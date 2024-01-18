Return-Path: <linux-kernel+bounces-29564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6B831046
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542C0B27006
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1725102;
	Thu, 18 Jan 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGn9jgrL"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0E81E480
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536132; cv=none; b=Rj3dxSFCQm23beAvqm7e7Peiu2F9+VIKGpcufM/yopLsKKQ1wuYhW5pIlDxO5yHwsKyK+qzE2T3XwJEqkarRliH1nfnpdMs15mMKRBfKUREiXrVSkujYFRpZ6n3tYy9og+iLxZDgXn2TXH5H84WiYR6xQMPignW8zkslHD93cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536132; c=relaxed/simple;
	bh=kgYxx8lrfR9o+V29Jg8WAUX6RHjY1H1/j59cLwk1aKk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Q3RZ+bxlGopGwLxJwt2uFBLx/DFwoBFb1soRTxrvZAC4UjyLZs4umnMQ2Y84cPTlBC1fzY7k4+8SxhDM6dWfIs35HItsvCU+efru+Hn8rwR/87HDayedQIYNNMgOWgY0HShuOy3RJFyKQgWJRlQBv82LK5HoIGTIEjsUeetloB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGn9jgrL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e784ce9bb8so1804857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705536129; x=1706140929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuJo17HGWlkmsJh3BmMrEUkGCN7pBDfz8ryumCkF23E=;
        b=QGn9jgrLjOupRlLIr5dZn3aY6W38venTZpIGgbNgZbnLIE5S6BnsaLRPRAfmDMGwFm
         ZCZr5eMy/tED76xm1ayxsgsyz1y9BaHI3bH3qJ208y9tahdlcBqR+CUsoTjp2731YUlv
         1eVhQC2M/iqbky7jafO9MhzxXywioX2HNBxN4EUIDso0b0NqRtSfTFLfrAXj+kEFUZzn
         DhodH4d5U9RtCu5iZHmITt7VMo0rcysR0TQZtWWfhjl0zDWwXGpOR0FHwBSotQRTum5j
         fR6yLVREDGbtCs6cQgtmd2WpV1c0XEjpbuQLOAfkn3cBssvbCos23vPdxXl0+qigodgi
         sjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536129; x=1706140929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuJo17HGWlkmsJh3BmMrEUkGCN7pBDfz8ryumCkF23E=;
        b=eJiJ0W7lf1JbSsnrX9jrW29JEX6Wb9tr4ZBaL72Bvwfm9+TriQkhNp0FrgIX0HY400
         8ij9dtfoxyFQenumr2kGvhM9WIw3BAQ22Ty/6Go68ZkLOdfiXulu+JozZf+NUPYxExJi
         XSGi0PHUdtmIaRHu6+vFMs/cYhYP4QJl8yCqBgUpCujviE/V7F1JlqKnwe9SV0Z7TKgm
         8LMLN7HhnujRTvm4/bVOOMDL3oIYqbrJVWGOpSksM42NtFGnfD6cNzFa0Fng+pN1N4Vj
         M+BrZ8JK+0Rob9Nhd8m1e+sitbbA82QaaZH7GhTD/kTjt2OtnUJWnr1k59VJT0piIlaS
         aOQA==
X-Gm-Message-State: AOJu0YzQuUCv/xs/GkqKHiKs0iTXleqQg2yxuw5sBD/8zgOIzMbBNZ7Y
	reWNq/DSrIuO9jujFUQJx2eIKbOv7g+Bnq+un8DFImsnQO5hEfGuGicOAihm+78CWTVnFNpCy+Q
	s5uLqAMvCq+qaaar2+cdm++QIQBj8hDakYHXa
X-Google-Smtp-Source: AGHT+IG2O/e+oiZQ/896Ypspajf6K7CKlewGUO0dyo1YSaL0Qv4ne17opY7gWwKea9kuFm9L4RaUnlIJFMbQmJTw/G4=
X-Received: by 2002:a0d:e4c5:0:b0:5ea:1ea8:9ca1 with SMTP id
 n188-20020a0de4c5000000b005ea1ea89ca1mr66440ywe.43.1705536127963; Wed, 17 Jan
 2024 16:02:07 -0800 (PST)
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
In-Reply-To: <CAHbLzkoHfvLoxbeXUrKAYdEnTigDOC4EO5FU+tQQ9bL5xBrx+g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 16:01:56 -0800
Message-ID: <CAJuCfpGkmN0D9+PFwuOWeGhcVn2+ePdOhXDPGLAM0BTm_XBaYg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:32=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chromium.org>=
 wrote:
> >
> > On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail.com=
> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmai=
l.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <su=
renb@google.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby=
@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > > >> Align larger anonymous memory mappings on THP boundaries=
 by
> > > > > > > > >> going through thp_get_unmapped_area if THPs are enabled =
for
> > > > > > > > >> the current process.
> > > > > > > > >>
> > > > > > > > >> With this patch, larger anonymous mappings are now THP a=
ligned.
> > > > > > > > >> When a malloc library allocates a 2MB or larger arena, t=
hat
> > > > > > > > >> arena can now be mapped with THPs right from the start, =
which
> > > > > > > > >> can result in better TLB hit rates and execution time.
> > > > > > > > >
> > > > > > > > > This appears to break 32bit processes on x86_64 (at least=
). In
> > > > > > > > > particular, 32bit kernel or firefox builds in our build s=
ystem.
> > > > > > > > >
> > > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > > >
> > > > > > > > > Downstream report:
> > > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > > > > >
> > > > > > > > > So running:
> > > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimize=
d .tmp_vmlinux.btf
> > > > > > > > >
> > > > > > > > > crashes or errors out with some random errors:
> > > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_s=
ize=3D0 type=3D181346
> > > > > > > > > Error emitting field
> > > > > > > > >
> > > > > > > > > strace shows mmap() fails with ENOMEM right before the er=
rors:
> > > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > > ...
> > > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Ca=
nnot allocate
> > > > > > > > > memory)
> > > > > > > > >
> > > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but lik=
ely large
> > > > > > > > > enough. For reference, one is available at:
> > > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > > >
> > > > > > > > > Any ideas?
> > > > > > > >
> > > > > > > > This works around the problem, of course (but is a band-aid=
, not a fix):
> > > > > > > >
> > > > > > > > --- a/mm/mmap.c
> > > > > > > > +++ b/mm/mmap.c
> > > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, =
unsigned long
> > > > > > > > addr, unsigned long len,
> > > > > > > >                   */
> > > > > > > >                  pgoff =3D 0;
> > > > > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))=
 {
> > > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) =
&&
> > > > > > > > !in_32bit_syscall()) {
> > > > > > > >                  /* Ensures that larger anonymous mappings =
are THP
> > > > > > > > aligned. */
> > > > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > > > >          }
> > > > > > > >
> > > > > > > >
> > > > > > > > thp_get_unmapped_area() does not take care of the legacy st=
uff...
> > > > > > >
> > > > > > > This change also affects the entropy of allocations. With thi=
s patch
> > > > > > > Android test [1] started failing and it requires only 8 bits =
of
> > > > > > > entropy. The feedback from our security team:
> > > > > > >
> > > > > > > 8 bits of entropy is already embarrassingly low, but was nece=
ssary for
> > > > > > > 32 bit ARM targets with low RAM at the time. It's definitely =
not
> > > > > > > acceptable for 64 bit targets.
> > > > > >
> > > > > > Thanks for the report. Is it 32 bit only or 64 bit is also impa=
cted?
> > > > > > If I understand the code correctly, it expects the address allo=
cated
> > > > > > by malloc() is kind of randomized, right?
> > > > >
> > > > > Yes, correct, the test expects a certain level of address randomi=
zation.
> > > > > The test failure was reported while running kernel_virt_x86_64 ta=
rget
> > > > > (Android emulator on x86), so it does impact 64bit targets.
> > > >
> > > > IIUC this breaks the "expectation" for randomized addresses returne=
d
> > > > by malloc(), but it doesn't break any real Android application, rig=
ht?
> > > > So this is a security concern instead of a real regression.
> > >
> > > How is making a system move vulnerabile not a real regression?
> > >
> > > >
> > > > I think we can make this opt-in with a knob. Anyone who outweighs
> > > > security could opt this feature out. However I'm wondering whether
> > > > Android should implement a general address randomization mechanism
> > > > instead of depending on "luck" if you do care about it.
> > >
> > > This is not depending on luck. This is checking for possible
> > > vulnerabilities in the system.
> > > I admit I'm not a security expert, so I'm looping in Jeff and Kees to=
 chime in.
> >
> > Hi!
> >
> > Just to chime in, but reduction in ASLR entropy is absolutely a
> > regression. This is userspace visible (via /proc/sys/kernel/randomize_v=
a_space,
> > /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> > advertised. So, while 32-bit might be already ASLR-weak, we don't want
> > to make things super bad nor break ASLR in compat mode under 64-bit
> > systems.
> >
> > Having an opt-in sounds reasonable, but we need to wire it to the ASLR
> > sysctls in some way so nothing lying about the ASLR entropy.
>
> Thanks for the explanation. IIUC the randomiza_va_space and
> mmap_rnd_bits randomize the mmap_base and start_brk for each exec()
> call. So the heap allocation is randomized. But it seems the formula
> doesn't take into account huge page. ARM64 adjusts the mmap_rnd_bits
> based on page size.
>
> I did a simple test, which conceptually does:
> 1. call mmap to allocate 8M heap
> 2. print out the allocated address
> 3. run the program 1000 times (launch/exit/re-launch)
> 4. check how many unique addresses
>
> With the default config on my arm64 VM (mmap_rnd_bits is 18), I saw
> 134 unique addresses. Without the patch, I saw 945 unique addresses.
> So I think the test could replicate what your test does.
>
> When I increased the mmap_rnd_bits to 24, I saw 988 unique addresses
> with the patch. x86_64 should have 28 bits by default, it should
> randomize the address quite well. I don't know why you still saw this,
> or you have a different setting for mmap_rnd_bits?

I checked the configuration on our test harness where the test failed:

/proc/sys/vm/mmap_rnd_bits =3D 32
/proc/sys/vm/mmap_rnd_compat_bits =3D 16

The failure logs are:

10-20 14:37:52.123  7029  7029 V AslrMallocTest: 7 bits of entropy for
allocation size 8388608 (minimum 8)
10-20 14:37:52.123  7029  7029 E AslrMallocTest: insufficient entropy
for malloc(8388608)

which come from here:
https://cs.android.com/android/platform/superproject/main/+/main:cts/tests/=
aslr/src/AslrMallocTest.cpp;l=3D127
So, the allocation size for which this test failed was 2^23.


> I'm wondering whether we should take into account huge page alignment
> for mmap_rnd_bits. And I think this is a huge page common problem, we
> have file mapping huge page aligned as well.
>
> 32 bit is easy, I think I can just make thp_get_unmapped_area() a
> no-op on 32 bit system.
>
> >
> > -Kees
> >
> > --
> > Kees Cook

