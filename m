Return-Path: <linux-kernel+bounces-29589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC8831086
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D811C22110
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D1184C;
	Thu, 18 Jan 2024 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bTQkSQ/W"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DF15A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537784; cv=none; b=kcDPfRvNx3Mk04kNjBaJA71Ge5ES079cgJ0aV6pb5RD/Lc6gzYygTXYX1Wpbv2EMB18GldtDMpAtyDolazdcPhXVq2FXpD+w+Sacg7dIwqxTgVdDpzmu1xlvHAVsxXH8dPTFi4iu+Hi3PPHuwDV9Y7FQeabjf2P8W3iCZu80PXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537784; c=relaxed/simple;
	bh=hOfkKaI6mMkX7fBFHjzkypLFKIL49/pZVikXUUQwiOE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=B7YHCQ/8pbiRuLQmhdD6SFHkDXulF50pS0mXqUfhmhQF8/5k1avCh2ERf3XTsjtgGV7VsRwO0OgMfn7ldU4pwUgemtxvUq3qSeJHjsAU0MSS6go2yeDu6rvPFfAk9e0miRw7XVvlKNDvcWJVZLp6Lh26aTw9G3ANVpE4+XmFxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTQkSQ/W; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5fa4b03f3f5so83994447b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705537781; x=1706142581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GbF8lWg9biRY3x9FtIXLv154tdCpudzNKri0Og9WYs=;
        b=bTQkSQ/Woayg/d0PcWLABGZwfGQTY0sviHVxVfEKhnMLstz2DRXr0nfaTs0pKVbK/Z
         OaHjicjINtzLvj5kTtWBd+feTf4xxDU6YWkeYmya6MUFYZEd51bvKri1/8Jy6h7akaFl
         bh3QslzfFgWjEhq2vprGpKNJX1DVTc+Dd5CnLJPLOcNDOVjESXxUoySxU9Y3ujehUq1H
         vh/DzKtqHdXGav0s6QDofMRq73v5EV62vGw31KamyWUUtur2kI/tsoFmbtc0KYjDSODB
         EuSDELufv/VUtlw+1pkr8kGzN3LL6H/dXP/173owIIyfL2bQqzfZFD5yavCeZ8WNWMH7
         TtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705537781; x=1706142581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GbF8lWg9biRY3x9FtIXLv154tdCpudzNKri0Og9WYs=;
        b=L4q/SXolpqyJfktCCvSv+YctUgdrVjzOqy7EFUiN1m1Fq7yojz96CaYv6t6QKWYSFV
         hagGDMkTwDr+K1zO7Wex0vew/WAaEwKuEjOgVBdYnnxbE9wLSG8uR0/HbzzKbljIwUsG
         cTSrh7bpZGfNhD18FrWujjp2UQa958yMoNRRF+GWioPOw3Lo8Ex9ZEvrn6gRSKEc0V1r
         O+5trjm9Px3KSEYm8iCnOFDkXSj0QrGLiz6CDDAnzE/JOA3A0n5yL/7E+TUEywRVvUrd
         2VfW7qgawEBP5y7LueWMIZ75y6Usudi1M/4uFf83KSP7pr20XsbEQJOM/45qirL4e7Kf
         is2Q==
X-Gm-Message-State: AOJu0YwFi6LrQfdHSOqu12PeMaQWdOsKSXoNm9iLnjutKSSbyGA8hyb9
	Fw7sS4mMTUBpTxuAO9s6bOuqgO8jL91LRvsD+Uh/HaMy0LesViDoHplpavjKeB7ONsDvnZm5NG3
	bm9d0+3kvYxy7nB7prx1uUJ9uhD/MGoF83GNx
X-Google-Smtp-Source: AGHT+IHoLXuA8c9/5bG5YB6abwFwfyTloeuGrrgIFPJuTccOwX142oUtKwWJNAXj+AD9v5Ms3/0z4WMcarpc6HGNSs8=
X-Received: by 2002:a0d:dfc1:0:b0:5f9:6f9d:4ae1 with SMTP id
 i184-20020a0ddfc1000000b005f96f9d4ae1mr49373ywe.81.1705537781228; Wed, 17 Jan
 2024 16:29:41 -0800 (PST)
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
 <CAJuCfpGkmN0D9+PFwuOWeGhcVn2+ePdOhXDPGLAM0BTm_XBaYg@mail.gmail.com> <CAHbLzkoJpmtncnBQjot3YN3=gbTtWvPnw-xG-BrOpqoUsVeTwA@mail.gmail.com>
In-Reply-To: <CAHbLzkoJpmtncnBQjot3YN3=gbTtWvPnw-xG-BrOpqoUsVeTwA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 16:29:30 -0800
Message-ID: <CAJuCfpG584eMNyi659AhVuOdZR3ooNh4ZVpXf6o_w8b=nbvjdg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:13=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Jan 17, 2024 at 4:02=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Wed, Jan 17, 2024 at 3:32=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chromium.=
org> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrote:
> > > > > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail=
com> wrote:
> > > > > >
> > > > > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <sur=
enb@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@=
gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan=
 <surenb@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jiris=
laby@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > > > > Hi,
> > > > > > > > > > >
> > > > > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > > > > >> Align larger anonymous memory mappings on THP bounda=
ries by
> > > > > > > > > > >> going through thp_get_unmapped_area if THPs are enab=
led for
> > > > > > > > > > >> the current process.
> > > > > > > > > > >>
> > > > > > > > > > >> With this patch, larger anonymous mappings are now T=
HP aligned.
> > > > > > > > > > >> When a malloc library allocates a 2MB or larger aren=
a, that
> > > > > > > > > > >> arena can now be mapped with THPs right from the sta=
rt, which
> > > > > > > > > > >> can result in better TLB hit rates and execution tim=
e.
> > > > > > > > > > >
> > > > > > > > > > > This appears to break 32bit processes on x86_64 (at l=
east). In
> > > > > > > > > > > particular, 32bit kernel or firefox builds in our bui=
ld system.
> > > > > > > > > > >
> > > > > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > > > > >
> > > > > > > > > > > Downstream report:
> > > > > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > > > > > > >
> > > > > > > > > > > So running:
> > > > > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_opti=
mized .tmp_vmlinux.btf
> > > > > > > > > > >
> > > > > > > > > > > crashes or errors out with some random errors:
> > > > > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 b=
it_size=3D0 type=3D181346
> > > > > > > > > > > Error emitting field
> > > > > > > > > > >
> > > > > > > > > > > strace shows mmap() fails with ENOMEM right before th=
e errors:
> > > > > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > > > > ...
> > > > > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM=
 (Cannot allocate
> > > > > > > > > > > memory)
> > > > > > > > > > >
> > > > > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but=
 likely large
> > > > > > > > > > > enough. For reference, one is available at:
> > > > > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > > > > >
> > > > > > > > > > > Any ideas?
> > > > > > > > > >
> > > > > > > > > > This works around the problem, of course (but is a band=
-aid, not a fix):
> > > > > > > > > >
> > > > > > > > > > --- a/mm/mmap.c
> > > > > > > > > > +++ b/mm/mmap.c
> > > > > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *fi=
le, unsigned long
> > > > > > > > > > addr, unsigned long len,
> > > > > > > > > >                   */
> > > > > > > > > >                  pgoff =3D 0;
> > > > > > > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPA=
GE)) {
> > > > > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPA=
GE) &&
> > > > > > > > > > !in_32bit_syscall()) {
> > > > > > > > > >                  /* Ensures that larger anonymous mappi=
ngs are THP
> > > > > > > > > > aligned. */
> > > > > > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > > > > > >          }
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > thp_get_unmapped_area() does not take care of the legac=
y stuff...
> > > > > > > > >
> > > > > > > > > This change also affects the entropy of allocations. With=
 this patch
> > > > > > > > > Android test [1] started failing and it requires only 8 b=
its of
> > > > > > > > > entropy. The feedback from our security team:
> > > > > > > > >
> > > > > > > > > 8 bits of entropy is already embarrassingly low, but was =
necessary for
> > > > > > > > > 32 bit ARM targets with low RAM at the time. It's definit=
ely not
> > > > > > > > > acceptable for 64 bit targets.
> > > > > > > >
> > > > > > > > Thanks for the report. Is it 32 bit only or 64 bit is also =
impacted?
> > > > > > > > If I understand the code correctly, it expects the address =
allocated
> > > > > > > > by malloc() is kind of randomized, right?
> > > > > > >
> > > > > > > Yes, correct, the test expects a certain level of address ran=
domization.
> > > > > > > The test failure was reported while running kernel_virt_x86_6=
4 target
> > > > > > > (Android emulator on x86), so it does impact 64bit targets.
> > > > > >
> > > > > > IIUC this breaks the "expectation" for randomized addresses ret=
urned
> > > > > > by malloc(), but it doesn't break any real Android application,=
 right?
> > > > > > So this is a security concern instead of a real regression.
> > > > >
> > > > > How is making a system move vulnerabile not a real regression?
> > > > >
> > > > > >
> > > > > > I think we can make this opt-in with a knob. Anyone who outweig=
hs
> > > > > > security could opt this feature out. However I'm wondering whet=
her
> > > > > > Android should implement a general address randomization mechan=
ism
> > > > > > instead of depending on "luck" if you do care about it.
> > > > >
> > > > > This is not depending on luck. This is checking for possible
> > > > > vulnerabilities in the system.
> > > > > I admit I'm not a security expert, so I'm looping in Jeff and Kee=
s to chime in.
> > > >
> > > > Hi!
> > > >
> > > > Just to chime in, but reduction in ASLR entropy is absolutely a
> > > > regression. This is userspace visible (via /proc/sys/kernel/randomi=
ze_va_space,
> > > > /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> > > > advertised. So, while 32-bit might be already ASLR-weak, we don't w=
ant
> > > > to make things super bad nor break ASLR in compat mode under 64-bit
> > > > systems.
> > > >
> > > > Having an opt-in sounds reasonable, but we need to wire it to the A=
SLR
> > > > sysctls in some way so nothing lying about the ASLR entropy.
> > >
> > > Thanks for the explanation. IIUC the randomiza_va_space and
> > > mmap_rnd_bits randomize the mmap_base and start_brk for each exec()
> > > call. So the heap allocation is randomized. But it seems the formula
> > > doesn't take into account huge page. ARM64 adjusts the mmap_rnd_bits
> > > based on page size.
> > >
> > > I did a simple test, which conceptually does:
> > > 1. call mmap to allocate 8M heap
> > > 2. print out the allocated address
> > > 3. run the program 1000 times (launch/exit/re-launch)
> > > 4. check how many unique addresses
> > >
> > > With the default config on my arm64 VM (mmap_rnd_bits is 18), I saw
> > > 134 unique addresses. Without the patch, I saw 945 unique addresses.
> > > So I think the test could replicate what your test does.
> > >
> > > When I increased the mmap_rnd_bits to 24, I saw 988 unique addresses
> > > with the patch. x86_64 should have 28 bits by default, it should
> > > randomize the address quite well. I don't know why you still saw this=
,
> > > or you have a different setting for mmap_rnd_bits?
> >
> > I checked the configuration on our test harness where the test failed:
>
> Thanks, Suren.
>
> >
> > /proc/sys/vm/mmap_rnd_bits =3D 32
>
> It is surprising 32 bits still fail. 24 bits on arm64 works for me. Or
> the compat bits is used?

Hmm. Let me verify to exclude that possibility.

>
> > /proc/sys/vm/mmap_rnd_compat_bits =3D 16
> >
> > The failure logs are:
> >
> > 10-20 14:37:52.123  7029  7029 V AslrMallocTest: 7 bits of entropy for
> > allocation size 8388608 (minimum 8)
> > 10-20 14:37:52.123  7029  7029 E AslrMallocTest: insufficient entropy
> > for malloc(8388608)
> >
> > which come from here:
> > https://cs.android.com/android/platform/superproject/main/+/main:cts/te=
sts/aslr/src/AslrMallocTest.cpp;l=3D127
> > So, the allocation size for which this test failed was 2^23.
>
> The patch just tries to align >=3D 2M allocations. It looks like your
> test allocates 256 bytes, 64K and 8M. So just 8M is impacted.

Correct.

>
>
> >
> >
> > > I'm wondering whether we should take into account huge page alignment
> > > for mmap_rnd_bits. And I think this is a huge page common problem, we
> > > have file mapping huge page aligned as well.
> > >
> > > 32 bit is easy, I think I can just make thp_get_unmapped_area() a
> > > no-op on 32 bit system.
> > >
> > > >
> > > > -Kees
> > > >
> > > > --
> > > > Kees Cook

