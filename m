Return-Path: <linux-kernel+bounces-29649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E483114B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47071F22A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9B4436;
	Thu, 18 Jan 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o8MeTa2u"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7D5390
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543831; cv=none; b=N2vAiT/3pVMhNthgItkssLhgUP7LDIzSsT7U8iEv2JSUjpRy0+8eZc7BkWBu6U4NsWe1NXXWgoR9rMgvkTnrP52c2SLaBHIE7R9j9GNsEB+cJAvMlCUdda8H9cvQ6xZu5S+Pj3/qCXNR1meo54X8SI8sNi+rp2w34F1D2yfZk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543831; c=relaxed/simple;
	bh=/Wp9X6er7efyaM/KOFvjJ/aRIzEs08Ms/9JrKJL37I0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=S0IW0mQGSO7WKz5Sh2hNyTr0tVnypCM0f9Jch6uyaB7R3ZyYcSpDy46gUmGk3724pkNADmrr3blW1xtI+QGEAtlWnyVRB6rmCMgjuYwBUJVeMQXwqAEJRyjt714h1ysQmwInED2gFaf7Wc5WjhiFJO8N03bEhJys80P5v/YmFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8MeTa2u; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5fc2e997804so53684487b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705543829; x=1706148629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyBr76gK/Clq6PkTT3F/dpMJAQNA2rfRDAOiFvk9ZXo=;
        b=o8MeTa2ugxp7WlvHVrlVER9/O49fE24EVWgaAFC6m8KTR8AFVPd6oGU1sOrdoS0uhe
         A5QFIVw8KGrc3DNjKLS3vM6UQjKWKEH+pBS4dYSwaim5H+Icrb63eKXb098MJb4l4bbT
         /QpQhiorx6wGTfamq4ytiKrh8/Eivj2wl61K7pHGklpwlBQqYWtWjD808fEufav0WKTX
         aO8dfpIbtRfRrnlDfUpPoBwMWgRlH15XZQm/UHL+uyxGhMujvsnzdIYeGR/iyGu5AzFq
         HaZPxXKmHwzwqYQ5cZpn9hwSIBDFLaZ/EdcX9QOnYDH0jR+/5ugKDaaBbKqBJoUSuwwd
         VTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705543829; x=1706148629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyBr76gK/Clq6PkTT3F/dpMJAQNA2rfRDAOiFvk9ZXo=;
        b=lFq8qz6owaTYrYu4/Wi6wDwSmNe29EBcGXj1fRXImNLerKYH91qFlBct5o+Eb76KLG
         l29QqpWzLNIvSpvGQ0XVa1tu4dlUqmlh83FzafF4PZLZOI2pmcvY20wTimDVowUsKr/8
         SEJnPX9tBOtGLBpzX+thPd+355ly3uXE2JvUU1p8/ij8rEnnOLJrNLpFhI/upp9Mw/3O
         xoRBktp4rF89wp52L+oI6JOqjbj9rdE+eex2InN/K4EZIe1teXztoT0BL1pXmoJygkmX
         Ieljw/KGWRRIq9KrcKuwQlkhaI6DjRThWoPG+LPgkumQVy8i/++GB1oD5j3dg4D7NVbO
         0t8A==
X-Gm-Message-State: AOJu0YyeDyo5zgzpx1v48BJImzNissh+JVrhufJvfdMKo/1g/UCqi6Bg
	77Zb0u1xDWmkJz8cVGKL5oTm4ReknCIGzhuEhUnvsaGjUqccVX2eBEDIUY/wSSSOmBONTt2KgvN
	am2apknPfBhgBVJBJ1X5RWF5D+1yUFvKRbswjThVp9iYIjFCXzEPq
X-Google-Smtp-Source: AGHT+IGdVeN6j6qHtHoIAhsTeueIVNsOEyoxCokeRtPUsHUhApyrNFi9AfYo45DYrqk7QnHDA5Dvu4wYaa2Md2U4GPw=
X-Received: by 2002:a81:8584:0:b0:5ff:5dcf:44a5 with SMTP id
 v126-20020a818584000000b005ff5dcf44a5mr115505ywf.86.1705543828746; Wed, 17
 Jan 2024 18:10:28 -0800 (PST)
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
 <CAHbLzkoJpmtncnBQjot3YN3=gbTtWvPnw-xG-BrOpqoUsVeTwA@mail.gmail.com>
 <CAJuCfpG584eMNyi659AhVuOdZR3ooNh4ZVpXf6o_w8b=nbvjdg@mail.gmail.com> <CAJuCfpH+yUKQSh4tux=q3N3G1w92y1ggX0bv=FsaHWfvxjzMxw@mail.gmail.com>
In-Reply-To: <CAJuCfpH+yUKQSh4tux=q3N3G1w92y1ggX0bv=FsaHWfvxjzMxw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 18:10:16 -0800
Message-ID: <CAJuCfpEVKwV7C8DcnyNeGWXEeACW1RFtyfj2d1N+rqoiS3b+Rg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:34=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 4:29=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Wed, Jan 17, 2024 at 4:13=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Wed, Jan 17, 2024 at 4:02=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Wed, Jan 17, 2024 at 3:32=E2=80=AFPM Yang Shi <shy828301@gmail.c=
om> wrote:
> > > > >
> > > > > On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chrom=
ium.org> wrote:
> > > > > >
> > > > > > On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wr=
ote:
> > > > > > > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan =
<surenb@google.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828=
301@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasa=
ryan <surenb@google.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <j=
irislaby@kernel.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > > > > > > >> Align larger anonymous memory mappings on THP bo=
undaries by
> > > > > > > > > > > > >> going through thp_get_unmapped_area if THPs are =
enabled for
> > > > > > > > > > > > >> the current process.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> With this patch, larger anonymous mappings are n=
ow THP aligned.
> > > > > > > > > > > > >> When a malloc library allocates a 2MB or larger =
arena, that
> > > > > > > > > > > > >> arena can now be mapped with THPs right from the=
 start, which
> > > > > > > > > > > > >> can result in better TLB hit rates and execution=
 time.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This appears to break 32bit processes on x86_64 (=
at least). In
> > > > > > > > > > > > > particular, 32bit kernel or firefox builds in our=
 build system.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Downstream report:
> > > > > > > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D121=
8841
> > > > > > > > > > > > >
> > > > > > > > > > > > > So running:
> > > > > > > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Dru=
st
> > > > > > > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_=
optimized .tmp_vmlinux.btf
> > > > > > > > > > > > >
> > > > > > > > > > > > > crashes or errors out with some random errors:
> > > > > > > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D1=
28 bit_size=3D0 type=3D181346
> > > > > > > > > > > > > Error emitting field
> > > > > > > > > > > > >
> > > > > > > > > > > > > strace shows mmap() fails with ENOMEM right befor=
e the errors:
> > > > > > > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > > > > > > ...
> > > > > > > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 EN=
OMEM (Cannot allocate
> > > > > > > > > > > > > memory)
> > > > > > > > > > > > >
> > > > > > > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary,=
 but likely large
> > > > > > > > > > > > > enough. For reference, one is available at:
> > > > > > > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > > > > > > >
> > > > > > > > > > > > > Any ideas?
> > > > > > > > > > > >
> > > > > > > > > > > > This works around the problem, of course (but is a =
band-aid, not a fix):
> > > > > > > > > > > >
> > > > > > > > > > > > --- a/mm/mmap.c
> > > > > > > > > > > > +++ b/mm/mmap.c
> > > > > > > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file=
 *file, unsigned long
> > > > > > > > > > > > addr, unsigned long len,
> > > > > > > > > > > >                   */
> > > > > > > > > > > >                  pgoff =3D 0;
> > > > > > > > > > > >                  get_area =3D shmem_get_unmapped_ar=
ea;
> > > > > > > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HU=
GEPAGE)) {
> > > > > > > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HU=
GEPAGE) &&
> > > > > > > > > > > > !in_32bit_syscall()) {
> > > > > > > > > > > >                  /* Ensures that larger anonymous m=
appings are THP
> > > > > > > > > > > > aligned. */
> > > > > > > > > > > >                  get_area =3D thp_get_unmapped_area=
;
> > > > > > > > > > > >          }
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > thp_get_unmapped_area() does not take care of the l=
egacy stuff...
> > > > > > > > > > >
> > > > > > > > > > > This change also affects the entropy of allocations. =
With this patch
> > > > > > > > > > > Android test [1] started failing and it requires only=
 8 bits of
> > > > > > > > > > > entropy. The feedback from our security team:
> > > > > > > > > > >
> > > > > > > > > > > 8 bits of entropy is already embarrassingly low, but =
was necessary for
> > > > > > > > > > > 32 bit ARM targets with low RAM at the time. It's def=
initely not
> > > > > > > > > > > acceptable for 64 bit targets.
> > > > > > > > > >
> > > > > > > > > > Thanks for the report. Is it 32 bit only or 64 bit is a=
lso impacted?
> > > > > > > > > > If I understand the code correctly, it expects the addr=
ess allocated
> > > > > > > > > > by malloc() is kind of randomized, right?
> > > > > > > > >
> > > > > > > > > Yes, correct, the test expects a certain level of address=
 randomization.
> > > > > > > > > The test failure was reported while running kernel_virt_x=
86_64 target
> > > > > > > > > (Android emulator on x86), so it does impact 64bit target=
s.
> > > > > > > >
> > > > > > > > IIUC this breaks the "expectation" for randomized addresses=
 returned
> > > > > > > > by malloc(), but it doesn't break any real Android applicat=
ion, right?
> > > > > > > > So this is a security concern instead of a real regression.
> > > > > > >
> > > > > > > How is making a system move vulnerabile not a real regression=
?
> > > > > > >
> > > > > > > >
> > > > > > > > I think we can make this opt-in with a knob. Anyone who out=
weighs
> > > > > > > > security could opt this feature out. However I'm wondering =
whether
> > > > > > > > Android should implement a general address randomization me=
chanism
> > > > > > > > instead of depending on "luck" if you do care about it.
> > > > > > >
> > > > > > > This is not depending on luck. This is checking for possible
> > > > > > > vulnerabilities in the system.
> > > > > > > I admit I'm not a security expert, so I'm looping in Jeff and=
 Kees to chime in.
> > > > > >
> > > > > > Hi!
> > > > > >
> > > > > > Just to chime in, but reduction in ASLR entropy is absolutely a
> > > > > > regression. This is userspace visible (via /proc/sys/kernel/ran=
domize_va_space,
> > > > > > /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> > > > > > advertised. So, while 32-bit might be already ASLR-weak, we don=
't want
> > > > > > to make things super bad nor break ASLR in compat mode under 64=
-bit
> > > > > > systems.
> > > > > >
> > > > > > Having an opt-in sounds reasonable, but we need to wire it to t=
he ASLR
> > > > > > sysctls in some way so nothing lying about the ASLR entropy.
> > > > >
> > > > > Thanks for the explanation. IIUC the randomiza_va_space and
> > > > > mmap_rnd_bits randomize the mmap_base and start_brk for each exec=
()
> > > > > call. So the heap allocation is randomized. But it seems the form=
ula
> > > > > doesn't take into account huge page. ARM64 adjusts the mmap_rnd_b=
its
> > > > > based on page size.
> > > > >
> > > > > I did a simple test, which conceptually does:
> > > > > 1. call mmap to allocate 8M heap
> > > > > 2. print out the allocated address
> > > > > 3. run the program 1000 times (launch/exit/re-launch)
> > > > > 4. check how many unique addresses
> > > > >
> > > > > With the default config on my arm64 VM (mmap_rnd_bits is 18), I s=
aw
> > > > > 134 unique addresses. Without the patch, I saw 945 unique address=
es.
> > > > > So I think the test could replicate what your test does.
> > > > >
> > > > > When I increased the mmap_rnd_bits to 24, I saw 988 unique addres=
ses
> > > > > with the patch. x86_64 should have 28 bits by default, it should
> > > > > randomize the address quite well. I don't know why you still saw =
this,
> > > > > or you have a different setting for mmap_rnd_bits?
> > > >
> > > > I checked the configuration on our test harness where the test fail=
ed:
> > >
> > > Thanks, Suren.
> > >
> > > >
> > > > /proc/sys/vm/mmap_rnd_bits =3D 32
> > >
> > > It is surprising 32 bits still fail. 24 bits on arm64 works for me. O=
r
> > > the compat bits is used?
> >
> > Hmm. Let me verify to exclude that possibility.
>
> Aha! You are correct, the test is using compat syscalls and your
> suggestion at https://lore.kernel.org/all/CAHbLzkoL6sCDciHqVMJga288853CHd=
OTa5thOPQ9SHKSqjGGPQ@mail.gmail.com/
> seems to fix it. I started a complete set of presubmit tests at
> https://android-review.googlesource.com/c/kernel/common/+/2916065 and
> will report the results tomorrow morning but I expect them to pass
> now.

nit: You will need to #include <linux/compat.h> in your fix. Most
configurations build fine but one failed. It has only CONFIG_COMPAT_32
enabled:

#
# Binary Emulations
#
CONFIG_COMPAT_32=3Dy
# end of Binary Emulations

Adding the missing include into mm/huge_memory.c fixes the issue.


> Thanks,
> Suren.
>
> >
> > >
> > > > /proc/sys/vm/mmap_rnd_compat_bits =3D 16
> > > >
> > > > The failure logs are:
> > > >
> > > > 10-20 14:37:52.123  7029  7029 V AslrMallocTest: 7 bits of entropy =
for
> > > > allocation size 8388608 (minimum 8)
> > > > 10-20 14:37:52.123  7029  7029 E AslrMallocTest: insufficient entro=
py
> > > > for malloc(8388608)
> > > >
> > > > which come from here:
> > > > https://cs.android.com/android/platform/superproject/main/+/main:ct=
s/tests/aslr/src/AslrMallocTest.cpp;l=3D127
> > > > So, the allocation size for which this test failed was 2^23.
> > >
> > > The patch just tries to align >=3D 2M allocations. It looks like your
> > > test allocates 256 bytes, 64K and 8M. So just 8M is impacted.
> >
> > Correct.
> >
> > >
> > >
> > > >
> > > >
> > > > > I'm wondering whether we should take into account huge page align=
ment
> > > > > for mmap_rnd_bits. And I think this is a huge page common problem=
, we
> > > > > have file mapping huge page aligned as well.
> > > > >
> > > > > 32 bit is easy, I think I can just make thp_get_unmapped_area() a
> > > > > no-op on 32 bit system.
> > > > >
> > > > > >
> > > > > > -Kees
> > > > > >
> > > > > > --
> > > > > > Kees Cook

