Return-Path: <linux-kernel+bounces-28353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CF82FD2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78841C28C50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF7A2510D;
	Tue, 16 Jan 2024 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qhfGHKaJ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC915250FE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444253; cv=none; b=kelKyQIiZpvBL9EEoe49WqmxBW9THl3beQCkiDZVMyH9vBuxL2mM8qQ69tEu6bgbE7tgSeu0G19xdpOWq/2Dlz5oZeYTwzyqf1zdRFfgRWPJUi4K0kZDu/CmjQJrq6/KcnW8kOR3ZVlrdZ8FGXtF2sxPE6RKh2rk9JiHXEjGzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444253; c=relaxed/simple;
	bh=fj8RX0sHhG8D3UOyvrpvrqz6AkKb8gbaELKtH8kieGg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ujbThtWEaUnIGNC+ISPELRW9NWzTXW2nVAApNmj3gM4n2B/MirQLWCtUtVT5fd7PY8Gsx4ehJFZ/UJDCXkGZ/2SeCCdbAlru03w3lHcWVvIn6vHRmlXzkmZ9VWdLpCQHi+BArBLIeUbLZ/1Au4s262FxXM5Ke9N08SQp+DEbYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhfGHKaJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff59e0dd71so10137207b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705444251; x=1706049051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7N4JboEtU4jWdz6byN6GCXUwgIkHJrOYqYlkao/tRU=;
        b=qhfGHKaJTFCGJd7spuzu2NXp5nvOOLiaNkxDpwUTTRbTUyfuU33K1Z5KpUSPTUGVDP
         d/M2RJdGMHvhuT5u67NVjrmYY7azEbFEK2VtZAGFxNJr9pXDTXwgS/Z6yVGZKDR/8mQ9
         ZgGINLNSOlIjVVuv//S/hZRJ5J91LkazG+5IMBunfUTJ4E/rBaUHdZgkbBDpUt/unGL8
         kROnNWa4ZgNADP6fUbFlUaP32XaWYByYus2HP0kJcRWB6JSzzrL0pjv6yaiSWO3FC1+i
         AXzBDS1pyfb9o2hdsWq+6CNV+D5Rat7jDH0RKbKg3rXD0CIk8g+YyeTrLqrjVPhHF7yQ
         t5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705444251; x=1706049051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7N4JboEtU4jWdz6byN6GCXUwgIkHJrOYqYlkao/tRU=;
        b=GYFQTOfZF/wOpJS610ttPczih14KIWSHovhh5s6NbRGpJl860xmIzLGdhpWqHct+HL
         RIFy0WDqJDnPMKqZOwhSSYa0Fd/dnmVw18Fts/RmSK7wlUjwtWK4gd75pFP33M3Z8eo1
         qeznkkVzyH2PSxR/zL7HJVr4icYpfQXvTi/sBfjSPhIWFsKcS2iZT3DoxzShSE12m2so
         sfKuwLnClcc7MtSeoRaj/7tgnkC8IK93jtN8H9Qf03cVUfZA15on84hwOnQDEX1J1/XP
         aMYXJKHTP3RSqpj5l1Fr9DtYr7ElVMNeBcuTy8urYkgYiunoqfaDYoQnvIUsGXR+R8+u
         fujw==
X-Gm-Message-State: AOJu0YzAJyiSywtKgyA/7i+Tt6HUldxKFNQ0zIW6E1H2AYmfFxY1NN+5
	nRmX9SBrUtvmpTs1PhLOaFFrzPHPRwm/fUYlM5xJvnOgiPEH
X-Google-Smtp-Source: AGHT+IFMSWhX0L9o3vSwlbTPorHKhPhpXS+jBqmQNMi6+lI/YckxrqP/DU0xTHHmyxrTl0aJox+C+lcWljGDjjzruio=
X-Received: by 2002:a81:af5e:0:b0:5d3:9f2d:658c with SMTP id
 x30-20020a81af5e000000b005d39f2d658cmr5577136ywj.24.1705444249248; Tue, 16
 Jan 2024 14:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
 <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com> <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
In-Reply-To: <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jan 2024 14:30:36 -0800
Message-ID: <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Kees Cook <keescook@chromium.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmail.com>=
 wrote:
> > >
> > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kerne=
l.org> wrote:
> > > > >
> > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > > >> the current process.
> > > > > >>
> > > > > >> With this patch, larger anonymous mappings are now THP aligned=
.
> > > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > > >> arena can now be mapped with THPs right from the start, which
> > > > > >> can result in better TLB hit rates and execution time.
> > > > > >
> > > > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > > > particular, 32bit kernel or firefox builds in our build system.
> > > > > >
> > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > >
> > > > > > Downstream report:
> > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > >
> > > > > > So running:
> > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp=
_vmlinux.btf
> > > > > >
> > > > > > crashes or errors out with some random errors:
> > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D=
0 type=3D181346
> > > > > > Error emitting field
> > > > > >
> > > > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > ...
> > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot a=
llocate
> > > > > > memory)
> > > > > >
> > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely la=
rge
> > > > > > enough. For reference, one is available at:
> > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > >
> > > > > > Any ideas?
> > > > >
> > > > > This works around the problem, of course (but is a band-aid, not =
a fix):
> > > > >
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsign=
ed long
> > > > > addr, unsigned long len,
> > > > >                   */
> > > > >                  pgoff =3D 0;
> > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > > !in_32bit_syscall()) {
> > > > >                  /* Ensures that larger anonymous mappings are TH=
P
> > > > > aligned. */
> > > > >                  get_area =3D thp_get_unmapped_area;
> > > > >          }
> > > > >
> > > > >
> > > > > thp_get_unmapped_area() does not take care of the legacy stuff...
> > > >
> > > > This change also affects the entropy of allocations. With this patc=
h
> > > > Android test [1] started failing and it requires only 8 bits of
> > > > entropy. The feedback from our security team:
> > > >
> > > > 8 bits of entropy is already embarrassingly low, but was necessary =
for
> > > > 32 bit ARM targets with low RAM at the time. It's definitely not
> > > > acceptable for 64 bit targets.
> > >
> > > Thanks for the report. Is it 32 bit only or 64 bit is also impacted?
> > > If I understand the code correctly, it expects the address allocated
> > > by malloc() is kind of randomized, right?
> >
> > Yes, correct, the test expects a certain level of address randomization=
.
> > The test failure was reported while running kernel_virt_x86_64 target
> > (Android emulator on x86), so it does impact 64bit targets.
>
> IIUC this breaks the "expectation" for randomized addresses returned
> by malloc(), but it doesn't break any real Android application, right?
> So this is a security concern instead of a real regression.

How is making a system move vulnerabile not a real regression?

>
> I think we can make this opt-in with a knob. Anyone who outweighs
> security could opt this feature out. However I'm wondering whether
> Android should implement a general address randomization mechanism
> instead of depending on "luck" if you do care about it.

This is not depending on luck. This is checking for possible
vulnerabilities in the system.
I admit I'm not a security expert, so I'm looping in Jeff and Kees to chime=
 in.
Thanks,
Suren.

>
> >
> > >
> > > >
> > > > Could this change be either reverted or made optional (opt-in/opt-o=
ut)?
> > > > Thanks,
> > > > Suren.
> > > >
> > > > [1] https://cs.android.com/android/platform/superproject/main/+/mai=
n:cts/tests/aslr/src/AslrMallocTest.cpp;l=3D130
> > > >
> > > > >
> > > > > regards,
> > > > > --
> > > > > js
> > > > > suse labs
> > > > >
> > > > >

