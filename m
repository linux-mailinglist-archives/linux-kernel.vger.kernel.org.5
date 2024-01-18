Return-Path: <linux-kernel+bounces-29626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150B8310ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17CAB248A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528C2115;
	Thu, 18 Jan 2024 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="09On8hhf"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05651186C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541675; cv=none; b=VFQtE4y34NU4I91A/1Kr99ZoGGlrGV4A8aZfJHfIBqLYOVkiCZxrjZ8lZ5TJuA7cq/y/0fuOUti82aLRBbySSZqcyvhlFLHSElZGWrU46GEUeo5svUPeifg9ANvNFV9mOW7nWQIrszpruk9EOKKxQGH1BMfp9aEfXH3B0Vi+hWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541675; c=relaxed/simple;
	bh=Pn29NlQYECcu9TP/wrI5g7aJacfyvnwzaZjtgQxJ+Po=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UXGMQVlkXYIMicEWzeVgslNucB+CJE2aY6NUGqerIVnWQQZoqvkA8tBpYyySMqzKL6/0UK9H4KQvnHIN7MH1YoERpM/na3TG9nspg3UE1C2c5vvK3WMFULGI9lkln4LldChuELGcE6xN7xgmGkV37wSvPFcXXYxYKomJHPAbrK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=09On8hhf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f254d1a6daso121257597b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705541673; x=1706146473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTt1bjaKAIwqL4Q5JoMaVHxUmIps0QDcEIJnYMzsbOg=;
        b=09On8hhfraWQ6zwKw09tBl8k9b0skY8OidIA/Yc4yUb5R87HNo67oOV6/fUJApdtmv
         mRXJ+4vGruPf1eZ3RN2xIGsPS17M9+y26UjjNkjoKsquOfHSTSvAduSqiMtfzCKjzuRX
         2a6x19P9cKZ4WVVY+AAPmz+ZtTVWJ9DLeq9mYw3q05fZ2kzgh99W8Uuztkwgf6J+Mw/C
         Ag0aeuvGKl652shY59Gntqvq/7HgkvzZWtA4ELStTB+nKw6+oVYBaIAnnG7sEicD1q8M
         oyKIxT+2IgYwX11OBWryHpdKQzNBatGsGbN01c8ybpzBRqq/mBc9QeVHKTSAccKuR5th
         OmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705541673; x=1706146473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTt1bjaKAIwqL4Q5JoMaVHxUmIps0QDcEIJnYMzsbOg=;
        b=X6EakBXIYPyIqTUsbkgcg6DqFuU+zCQJI2O/pE3AEGfVa1I2ZNyJGcmsZIP8l7wm22
         mtx1kSdH24EOH2HNjCj0/OW/MpDqke+FgI3BwVIIsJdIbUyzeQvibUWwVp73VRuyDRWT
         w9Jl41lDwxVJLWKS7V9xAAxwsp+Qu472KyIV6igEqQMVPul+jkYuCpe+eKSIo63K3J7R
         1uZzkFSnBLujroPJgfbDvZdKLAauSc+bUy6zJrutW0muSnHHjn0T3Lx9UgqdpU7JkBP8
         L3DdVROmMkn5NUqD+gU530EWrL1jZoeW3SUjqIF00z1L7P85MCFQYO42orZ4B3EaswEH
         k0FQ==
X-Gm-Message-State: AOJu0YwWwjG9QZQprK6mIxf5VPkiXd17Z3Kk4rzhSUEYQdnfUvmBxYSF
	MvUg3WzAWRe1P/IkjW8CHExLbpin7Q6axUwLqzUpVIgLYNioGVCdSCLmsqCZypAzom0EzOhlry5
	W9mutbvcXgnsN/aeqcharuL0dpozY0knAMBHi
X-Google-Smtp-Source: AGHT+IGe/hI4XX9yWMva0w0KkLnGBUrB82IA2UYEtldpo0mepPXCTVkCoMSie9V+25xRsGLWhMC0j8RkvUi3m+tbTE4=
X-Received: by 2002:a81:47c3:0:b0:5f5:63ee:6adf with SMTP id
 u186-20020a8147c3000000b005f563ee6adfmr126075ywa.93.1705541672800; Wed, 17
 Jan 2024 17:34:32 -0800 (PST)
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
 <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
 <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
 <202401170925.015D300A@keescook> <CAHbLzkoHfvLoxbeXUrKAYdEnTigDOC4EO5FU+tQQ9bL5xBrx+g@mail.gmail.com>
 <CAJuCfpGkmN0D9+PFwuOWeGhcVn2+ePdOhXDPGLAM0BTm_XBaYg@mail.gmail.com>
 <CAHbLzkoJpmtncnBQjot3YN3=gbTtWvPnw-xG-BrOpqoUsVeTwA@mail.gmail.com> <CAJuCfpG584eMNyi659AhVuOdZR3ooNh4ZVpXf6o_w8b=nbvjdg@mail.gmail.com>
In-Reply-To: <CAJuCfpG584eMNyi659AhVuOdZR3ooNh4ZVpXf6o_w8b=nbvjdg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 17:34:20 -0800
Message-ID: <CAJuCfpH+yUKQSh4tux=q3N3G1w92y1ggX0bv=FsaHWfvxjzMxw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 4:13=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Wed, Jan 17, 2024 at 4:02=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 3:32=E2=80=AFPM Yang Shi <shy828301@gmail.com=
> wrote:
> > > >
> > > > On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chromiu=
m.org> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrot=
e:
> > > > > > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gma=
il.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <s=
urenb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy82830=
1@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasary=
an <surenb@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jir=
islaby@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > > > > > Hi,
> > > > > > > > > > > >
> > > > > > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > > > > > >> Align larger anonymous memory mappings on THP boun=
daries by
> > > > > > > > > > > >> going through thp_get_unmapped_area if THPs are en=
abled for
> > > > > > > > > > > >> the current process.
> > > > > > > > > > > >>
> > > > > > > > > > > >> With this patch, larger anonymous mappings are now=
 THP aligned.
> > > > > > > > > > > >> When a malloc library allocates a 2MB or larger ar=
ena, that
> > > > > > > > > > > >> arena can now be mapped with THPs right from the s=
tart, which
> > > > > > > > > > > >> can result in better TLB hit rates and execution t=
ime.
> > > > > > > > > > > >
> > > > > > > > > > > > This appears to break 32bit processes on x86_64 (at=
 least). In
> > > > > > > > > > > > particular, 32bit kernel or firefox builds in our b=
uild system.
> > > > > > > > > > > >
> > > > > > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > > > > > >
> > > > > > > > > > > > Downstream report:
> > > > > > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D12188=
41
> > > > > > > > > > > >
> > > > > > > > > > > > So running:
> > > > > > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_op=
timized .tmp_vmlinux.btf
> > > > > > > > > > > >
> > > > > > > > > > > > crashes or errors out with some random errors:
> > > > > > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128=
 bit_size=3D0 type=3D181346
> > > > > > > > > > > > Error emitting field
> > > > > > > > > > > >
> > > > > > > > > > > > strace shows mmap() fails with ENOMEM right before =
the errors:
> > > > > > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > > > > > ...
> > > > > > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOM=
EM (Cannot allocate
> > > > > > > > > > > > memory)
> > > > > > > > > > > >
> > > > > > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, b=
ut likely large
> > > > > > > > > > > > enough. For reference, one is available at:
> > > > > > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > > > > > >
> > > > > > > > > > > > Any ideas?
> > > > > > > > > > >
> > > > > > > > > > > This works around the problem, of course (but is a ba=
nd-aid, not a fix):
> > > > > > > > > > >
> > > > > > > > > > > --- a/mm/mmap.c
> > > > > > > > > > > +++ b/mm/mmap.c
> > > > > > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *=
file, unsigned long
> > > > > > > > > > > addr, unsigned long len,
> > > > > > > > > > >                   */
> > > > > > > > > > >                  pgoff =3D 0;
> > > > > > > > > > >                  get_area =3D shmem_get_unmapped_area=
;
> > > > > > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGE=
PAGE)) {
> > > > > > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGE=
PAGE) &&
> > > > > > > > > > > !in_32bit_syscall()) {
> > > > > > > > > > >                  /* Ensures that larger anonymous map=
pings are THP
> > > > > > > > > > > aligned. */
> > > > > > > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > > > > > > >          }
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > thp_get_unmapped_area() does not take care of the leg=
acy stuff...
> > > > > > > > > >
> > > > > > > > > > This change also affects the entropy of allocations. Wi=
th this patch
> > > > > > > > > > Android test [1] started failing and it requires only 8=
 bits of
> > > > > > > > > > entropy. The feedback from our security team:
> > > > > > > > > >
> > > > > > > > > > 8 bits of entropy is already embarrassingly low, but wa=
s necessary for
> > > > > > > > > > 32 bit ARM targets with low RAM at the time. It's defin=
itely not
> > > > > > > > > > acceptable for 64 bit targets.
> > > > > > > > >
> > > > > > > > > Thanks for the report. Is it 32 bit only or 64 bit is als=
o impacted?
> > > > > > > > > If I understand the code correctly, it expects the addres=
s allocated
> > > > > > > > > by malloc() is kind of randomized, right?
> > > > > > > >
> > > > > > > > Yes, correct, the test expects a certain level of address r=
andomization.
> > > > > > > > The test failure was reported while running kernel_virt_x86=
_64 target
> > > > > > > > (Android emulator on x86), so it does impact 64bit targets.
> > > > > > >
> > > > > > > IIUC this breaks the "expectation" for randomized addresses r=
eturned
> > > > > > > by malloc(), but it doesn't break any real Android applicatio=
n, right?
> > > > > > > So this is a security concern instead of a real regression.
> > > > > >
> > > > > > How is making a system move vulnerabile not a real regression?
> > > > > >
> > > > > > >
> > > > > > > I think we can make this opt-in with a knob. Anyone who outwe=
ighs
> > > > > > > security could opt this feature out. However I'm wondering wh=
ether
> > > > > > > Android should implement a general address randomization mech=
anism
> > > > > > > instead of depending on "luck" if you do care about it.
> > > > > >
> > > > > > This is not depending on luck. This is checking for possible
> > > > > > vulnerabilities in the system.
> > > > > > I admit I'm not a security expert, so I'm looping in Jeff and K=
ees to chime in.
> > > > >
> > > > > Hi!
> > > > >
> > > > > Just to chime in, but reduction in ASLR entropy is absolutely a
> > > > > regression. This is userspace visible (via /proc/sys/kernel/rando=
mize_va_space,
> > > > > /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> > > > > advertised. So, while 32-bit might be already ASLR-weak, we don't=
 want
> > > > > to make things super bad nor break ASLR in compat mode under 64-b=
it
> > > > > systems.
> > > > >
> > > > > Having an opt-in sounds reasonable, but we need to wire it to the=
 ASLR
> > > > > sysctls in some way so nothing lying about the ASLR entropy.
> > > >
> > > > Thanks for the explanation. IIUC the randomiza_va_space and
> > > > mmap_rnd_bits randomize the mmap_base and start_brk for each exec()
> > > > call. So the heap allocation is randomized. But it seems the formul=
a
> > > > doesn't take into account huge page. ARM64 adjusts the mmap_rnd_bit=
s
> > > > based on page size.
> > > >
> > > > I did a simple test, which conceptually does:
> > > > 1. call mmap to allocate 8M heap
> > > > 2. print out the allocated address
> > > > 3. run the program 1000 times (launch/exit/re-launch)
> > > > 4. check how many unique addresses
> > > >
> > > > With the default config on my arm64 VM (mmap_rnd_bits is 18), I saw
> > > > 134 unique addresses. Without the patch, I saw 945 unique addresses=
.
> > > > So I think the test could replicate what your test does.
> > > >
> > > > When I increased the mmap_rnd_bits to 24, I saw 988 unique addresse=
s
> > > > with the patch. x86_64 should have 28 bits by default, it should
> > > > randomize the address quite well. I don't know why you still saw th=
is,
> > > > or you have a different setting for mmap_rnd_bits?
> > >
> > > I checked the configuration on our test harness where the test failed=
:
> >
> > Thanks, Suren.
> >
> > >
> > > /proc/sys/vm/mmap_rnd_bits =3D 32
> >
> > It is surprising 32 bits still fail. 24 bits on arm64 works for me. Or
> > the compat bits is used?
>
> Hmm. Let me verify to exclude that possibility.

Aha! You are correct, the test is using compat syscalls and your
suggestion at https://lore.kernel.org/all/CAHbLzkoL6sCDciHqVMJga288853CHdOT=
a5thOPQ9SHKSqjGGPQ@mail.gmail.com/
seems to fix it. I started a complete set of presubmit tests at
https://android-review.googlesource.com/c/kernel/common/+/2916065 and
will report the results tomorrow morning but I expect them to pass
now.
Thanks,
Suren.

>
> >
> > > /proc/sys/vm/mmap_rnd_compat_bits =3D 16
> > >
> > > The failure logs are:
> > >
> > > 10-20 14:37:52.123  7029  7029 V AslrMallocTest: 7 bits of entropy fo=
r
> > > allocation size 8388608 (minimum 8)
> > > 10-20 14:37:52.123  7029  7029 E AslrMallocTest: insufficient entropy
> > > for malloc(8388608)
> > >
> > > which come from here:
> > > https://cs.android.com/android/platform/superproject/main/+/main:cts/=
tests/aslr/src/AslrMallocTest.cpp;l=3D127
> > > So, the allocation size for which this test failed was 2^23.
> >
> > The patch just tries to align >=3D 2M allocations. It looks like your
> > test allocates 256 bytes, 64K and 8M. So just 8M is impacted.
>
> Correct.
>
> >
> >
> > >
> > >
> > > > I'm wondering whether we should take into account huge page alignme=
nt
> > > > for mmap_rnd_bits. And I think this is a huge page common problem, =
we
> > > > have file mapping huge page aligned as well.
> > > >
> > > > 32 bit is easy, I think I can just make thp_get_unmapped_area() a
> > > > no-op on 32 bit system.
> > > >
> > > > >
> > > > > -Kees
> > > > >
> > > > > --
> > > > > Kees Cook

