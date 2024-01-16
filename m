Return-Path: <linux-kernel+bounces-28371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C086A82FDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D381C26784
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0D67C5E;
	Tue, 16 Jan 2024 23:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpEIQyII"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28567C47
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705446895; cv=none; b=BUh6htKyTxiMv9qdyg8Tb6hvfe8igqSU3tNPub5E5zjue35fGVrcABfYmGzwKpQP4t0aCbnV7WD7H2hb1WWG7rXaaQ48QR+CglBT5ZzB7J30HPAitFUJVHUEkNVcNParYqB3X+h7IYGPtbw/4nluS3jA1YsF9jk2q5Ue6vLXUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705446895; c=relaxed/simple;
	bh=Q4vL8wZCvJ1oqEBRwDYZd34EPBwNk81zviazhgZAJF8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=YDfDttSauLSSLbluA+sdBjqkM/V9eeavJ64JZ9o8jWZeHNp/VzoxXlAlHDNfKtYGa30WW63yXe4gF9xTMHddx9zp5RFVZ2Y1oe6ERSESYcGQAdxXWk/RFOIP+LIhDd4uny1+ftsoAeLyzEiA/a2VAHcqD8zktGtSEQob/hjGEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpEIQyII; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso4772849a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705446893; x=1706051693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9Z3MXcjroiy9i57xyVJiTSgypswwDTIzH0vhnXYwck=;
        b=bpEIQyIIPiW0YSMQCUUGRG2YulMKdd6e+MEcwbx3V+3JMFpdrrYvTsdcWWWqbDUuPZ
         Zav8evybvY0EY2LgcCLkSZk3Vi1+46XdIBmlvSKjOByVFZYJNv3WmzUeGp0y+EtEh+dw
         npcW4wVZ5RHInA+BY7uvwr/SrS5Q+pRVngDydz9Q7g51iP/YPEW/Ds7e3R/4saWSSV1+
         Sc8G0QebiXhPZNWtFjF1IHcL11k9N977s50LDSfaU4xX37zHumRnj8IWRgfLWi3RyIl4
         +8+g94typZAaMUWNecqKUAHhd03yY1Ce6WHiIuXi6UsfD/uBhXyaUyUhN8QG+6v/wS6l
         5LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705446893; x=1706051693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9Z3MXcjroiy9i57xyVJiTSgypswwDTIzH0vhnXYwck=;
        b=Sfm3QhD73Jhho+9j/W+n1LSsE3qKYkosa+JqkzwKnLziTLNwkT8pzVwmDXmWgvCEp3
         H+aOW71MILIICO1Yha1mytb+QCvllK2lMdHjdEXb1IgLIVXhywrZhbIa8dH9Bdk9e/Qf
         qfXm5/kNQkh6WNBbVTSIZC/SbgrkQrifVpoHAOtMSjg91GCa270xHzapJrQ1Of+QQPuQ
         JQptWEJVy2Kgc9s6/hdSaxLMiF+pqfF3Khjc+K/deHmz18oTjhSyePPeneMazjn799t1
         F/X5a3cs0t2rGwpAuBHhlY+4MITEARTGvlz5COw0tl299Cv8Bs2lTB62+jjQUmyKvjRY
         ZTjA==
X-Gm-Message-State: AOJu0Yyv/B2dzrnYB6e+Ca2o+OXMSsR5OAXBsNqzepm1Uxv9GWvr3bdx
	OOhDXaEdOS3lp6i9EMyobQsYodgRYFxngu06u8g=
X-Google-Smtp-Source: AGHT+IFSPAdOss9OUVk/3MV1NNKRhquNEgTUBhu8TCFWEVWXaSWD0A0eq/DOkUrsgOZPuLTX4gUD+GwBynThYugNSfc=
X-Received: by 2002:a17:90a:49cf:b0:28e:7b66:73e4 with SMTP id
 l15-20020a17090a49cf00b0028e7b6673e4mr1239524pjm.5.1705446893001; Tue, 16 Jan
 2024 15:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
 <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
 <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com> <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
In-Reply-To: <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 15:14:40 -0800
Message-ID: <CAHbLzkobPC3S0Wb97jjwQZoJhO7O+LkEkoPoEeYFAKGYk=XAaA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, Kees Cook <keescook@chromium.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 2:30=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmail.co=
m> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@ker=
nel.org> wrote:
> > > > > >
> > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > > > >> the current process.
> > > > > > >>
> > > > > > >> With this patch, larger anonymous mappings are now THP align=
ed.
> > > > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > > > >> arena can now be mapped with THPs right from the start, whic=
h
> > > > > > >> can result in better TLB hit rates and execution time.
> > > > > > >
> > > > > > > This appears to break 32bit processes on x86_64 (at least). I=
n
> > > > > > > particular, 32bit kernel or firefox builds in our build syste=
m.
> > > > > > >
> > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > >
> > > > > > > Downstream report:
> > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > > >
> > > > > > > So running:
> > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .t=
mp_vmlinux.btf
> > > > > > >
> > > > > > > crashes or errors out with some random errors:
> > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=
=3D0 type=3D181346
> > > > > > > Error emitting field
> > > > > > >
> > > > > > > strace shows mmap() fails with ENOMEM right before the errors=
:
> > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > ...
> > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot=
 allocate
> > > > > > > memory)
> > > > > > >
> > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely =
large
> > > > > > > enough. For reference, one is available at:
> > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > >
> > > > > > > Any ideas?
> > > > > >
> > > > > > This works around the problem, of course (but is a band-aid, no=
t a fix):
> > > > > >
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsi=
gned long
> > > > > > addr, unsigned long len,
> > > > > >                   */
> > > > > >                  pgoff =3D 0;
> > > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > > > !in_32bit_syscall()) {
> > > > > >                  /* Ensures that larger anonymous mappings are =
THP
> > > > > > aligned. */
> > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > >          }
> > > > > >
> > > > > >
> > > > > > thp_get_unmapped_area() does not take care of the legacy stuff.=
.
> > > > >
> > > > > This change also affects the entropy of allocations. With this pa=
tch
> > > > > Android test [1] started failing and it requires only 8 bits of
> > > > > entropy. The feedback from our security team:
> > > > >
> > > > > 8 bits of entropy is already embarrassingly low, but was necessar=
y for
> > > > > 32 bit ARM targets with low RAM at the time. It's definitely not
> > > > > acceptable for 64 bit targets.
> > > >
> > > > Thanks for the report. Is it 32 bit only or 64 bit is also impacted=
?
> > > > If I understand the code correctly, it expects the address allocate=
d
> > > > by malloc() is kind of randomized, right?
> > >
> > > Yes, correct, the test expects a certain level of address randomizati=
on.
> > > The test failure was reported while running kernel_virt_x86_64 target
> > > (Android emulator on x86), so it does impact 64bit targets.
> >
> > IIUC this breaks the "expectation" for randomized addresses returned
> > by malloc(), but it doesn't break any real Android application, right?
> > So this is a security concern instead of a real regression.
>
> How is making a system move vulnerabile not a real regression?
>
> >
> > I think we can make this opt-in with a knob. Anyone who outweighs
> > security could opt this feature out. However I'm wondering whether
> > Android should implement a general address randomization mechanism
> > instead of depending on "luck" if you do care about it.
>
> This is not depending on luck. This is checking for possible
> vulnerabilities in the system.

I don't think the kernel guarantees address randomization if I read
the kernel code correctly although it may look like it has a certain
level of randomization somehow.

If I remember correctly PaX has an ASLR patch, but it is out of tree.

> I admit I'm not a security expert, so I'm looping in Jeff and Kees to chi=
me in.
> Thanks,
> Suren.
>
> >
> > >
> > > >
> > > > >
> > > > > Could this change be either reverted or made optional (opt-in/opt=
-out)?
> > > > > Thanks,
> > > > > Suren.
> > > > >
> > > > > [1] https://cs.android.com/android/platform/superproject/main/+/m=
ain:cts/tests/aslr/src/AslrMallocTest.cpp;l=3D130
> > > > >
> > > > > >
> > > > > > regards,
> > > > > > --
> > > > > > js
> > > > > > suse labs
> > > > > >
> > > > > >

