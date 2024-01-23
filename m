Return-Path: <linux-kernel+bounces-35786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 355CC839683
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FF01F242B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F17F80021;
	Tue, 23 Jan 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj/wgVvd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1565F555
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031251; cv=none; b=Z5L1052qijuVHAq61+cW79Y2kWCl3uJRHY3PEwlo/M1nJxWiQmPFQe4rKqw2hmmMq9p+v9in2IIdJ76GnNV+FkRFizBnn/zo5A4+5V9+nwvvq8T81/bdUwpaVgPsE8hWeAv94rFraomJvK/Ed12QSLsn49Ia9swZZ2k1ySON6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031251; c=relaxed/simple;
	bh=PC/VvLhrynnH71BeHH6g8SpKqxFdgAOitUvykSgRJTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg9YBeaxezeLibReKalaLUvyNV9UBp0juPHYgfvqyor17sqbAMiFFiuti1dunq16HkLydfRENeGhIG2xzjKQVCXhU5Bxqy/UxxEmfL+QlOODCosSvxmq+kS2mH9gOccqES7t2gTKdu8yuMYbmwLPrsto3r6mwwdbupAl9tzAI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj/wgVvd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dd7c194bb2so596555b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031249; x=1706636049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S76pwj7/jU8956MjRJG3wq6lOxv4Afsy/V61XQ4UUPY=;
        b=Uj/wgVvdZfURc4k1fsfayEgAPt5ngO2mJfXihmGbn2ngWn01i746dUcLsJHXCtSv4a
         dY0MH/3CCO1n2vSf/R8802bDIBroEPPIrn0eXwwh9/bv9+x8Qd5gJwFSTufJ/FjbZ1jM
         BkCH91HT8h1brYHLvSXnb9MDwROXpzcH2jneX7QCwBEe8DqTVlCPKzkp+LWA8IruqZSh
         5ErRPBvKMvw+A/YRGoaTVk24OEmxroec9Kdcs46NdF+h9GeqU2NedclwoflS2lBlfHDo
         6YfVobIxRabqDHY+0T1CZQIRurnRegSJUN0vsaqvvPAv+d1CsgA1/8tGow6FJIdF0Ng7
         DkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031249; x=1706636049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S76pwj7/jU8956MjRJG3wq6lOxv4Afsy/V61XQ4UUPY=;
        b=pzuwfs3GGN5UHv/hv1OFcGFW8yWBQq9i96um6NkU6sTkOH8E945xQYCV1gaj2N2R8S
         TVDlgTtB201tRNuEoe9b+cU34XJVtjZHU+8UybbNd/8CzWztynSNG6RQ2/oPyH7OsKma
         i1niASWmqa/72HhFvjHIY5FUbsibRLwsmHfPaa8nB02yQhQIKyfGW33wZJjRzrZXzWOY
         G5jaRWVVHa+vxWuKwwPmMrjLJQ6WLC+t17vYzKMN85z6zvUbOsUNjwWqctFTeS3a/Oag
         3+2XVpbiCh3oVOom6lPUPTYBcqtoRZ43zUm7wFaUv0Bg5UClVyzGTfY8s932Nx7gk6RJ
         /8IA==
X-Gm-Message-State: AOJu0YyemwcBbS/zkQ2UtvwG4b1KpbwT5M/G9UW4CDD8UeBYg67Xa3BN
	P8ajZ6Bb+JUZaHSMIzjQoDRzGnAMhDhy6SzkwZVD64JQ4PMgy6waWWRs01GBnAZR2lKjYdTgXK5
	GLK6tiLWCODzRGqfudDKy/AwMjkw=
X-Google-Smtp-Source: AGHT+IFmp5I3qEG0qcMboNlDqFCkZm2BWY4+f+03+Vf/jsl9yO2VV+qiUa/ehFZGL54gORy95xylNA8PLvnXWwSMMq0=
X-Received: by 2002:a05:6a00:4b14:b0:6d9:b39f:4e72 with SMTP id
 kq20-20020a056a004b1400b006d9b39f4e72mr8282635pfb.25.1706031248855; Tue, 23
 Jan 2024 09:34:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com> <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com> <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
In-Reply-To: <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 23 Jan 2024 09:33:57 -0800
Message-ID: <CAHbLzkrtbj4OmaqB9XjJRJaY42OEBRkXUzFnuou2Zac8RbSNCQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:26=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 23/01/2024 17:14, Yang Shi wrote:
> > On Tue, Jan 23, 2024 at 1:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 22/01/2024 19:43, Yang Shi wrote:
> >>> On Mon, Jan 22, 2024 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> On 20/01/2024 16:39, Matthew Wilcox wrote:
> >>>>> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> >>>>>> However, after this patch, each allocation is in its own VMA, and =
there is a 2M
> >>>>>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH=
 slower
> >>>>>> because there are so many VMAs to check to find a new 1G gap. 2) I=
t fails once
> >>>>>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this l=
imit then
> >>>>>> causes a subsequent calloc() to fail, which causes the test to fai=
l.
> >>>>>>
> >>>>>> Looking at the code, I think the problem is that arm64 selects
> >>>>>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area=
() allocates
> >>>>>> len+2M then always aligns to the bottom of the discovered gap. Tha=
t causes the
> >>>>>> 2M hole. As far as I can see, x86 allocates bottom up, so you don'=
t get a hole.
> >>>>>
> >>>>> As a quick hack, perhaps
> >>>>> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >>>>> take-the-top-half
> >>>>> #else
> >>>>> current-take-bottom-half-code
> >>>>> #endif
> >>>>>
> >>>>> ?
> >>>
> >>> Thanks for the suggestion. It makes sense to me. Doing the alignment
> >>> needs to take into account this.
> >>>
> >>>>
> >>>> There is a general problem though that there is a trade-off between =
abutting
> >>>> VMAs, and aligning them to PMD boundaries. This patch has decided th=
at in
> >>>> general the latter is preferable. The case I'm hitting is special th=
ough, in
> >>>> that both requirements could be achieved but currently are not.
> >>>>
> >>>> The below fixes it, but I feel like there should be some bitwise mag=
ic that
> >>>> would give the correct answer without the conditional - but my head =
is gone and
> >>>> I can't see it. Any thoughts?
> >>>
> >>> Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
> >>> the conditional either.
> >>>
> >>>>
> >>>> Beyond this, though, there is also a latent bug where the offset pro=
vided to
> >>>> mmap() is carried all the way through to the get_unmapped_area()
> >>>> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should =
be
> >>>> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, fo=
r arches
> >>>> that use the default get_unmapped_area(), any non-zero offset would =
not have
> >>>> been used. But this change starts using it, which is incorrect. That=
 said, there
> >>>> are some arches that override the default get_unmapped_area() and do=
 use the
> >>>> offset. So I'm not sure if this is a bug or a feature that user spac=
e can pass
> >>>> an arbitrary value to the implementation for anon memory??
> >>>
> >>> Thanks for noticing this. If I read the code correctly, the pgoff use=
d
> >>> by some arches to workaround VIPT caches, and it looks like it is for
> >>> shared mapping only (just checked arm and mips). And I believe
> >>> everybody assumes 0 should be used when doing anonymous mapping. The
> >>> offset should have nothing to do with seeking proper unmapped virtual
> >>> area. But the pgoff does make sense for file THP due to the alignment
> >>> requirements. I think it should be zero'ed for anonymous mappings,
> >>> like:
> >>>
> >>> diff --git a/mm/mmap.c b/mm/mmap.c
> >>> index 2ff79b1d1564..a9ed353ce627 100644
> >>> --- a/mm/mmap.c
> >>> +++ b/mm/mmap.c
> >>> @@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
> >>> long addr, unsigned long len,
> >>>                 pgoff =3D 0;
> >>>                 get_area =3D shmem_get_unmapped_area;
> >>>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> >>> +               pgoff =3D 0;
> >>>                 /* Ensures that larger anonymous mappings are THP ali=
gned. */
> >>>                 get_area =3D thp_get_unmapped_area;
> >>>         }
> >>
> >> I think it would be cleaner to just zero pgoff if file=3D=3DNULL, then=
 it covers the
> >> shared case, the THP case, and the non-THP case properly. I'll prepare=
 a
> >> separate patch for this.
> >
> > IIUC I don't think this is ok for those arches which have to
> > workaround VIPT cache since MAP_ANONYMOUS | MAP_SHARED with NULL file
> > pointer is a common case for creating tmpfs mapping. For example,
> > arm's arch_get_unmapped_area() has:
> >
> > if (aliasing)
> >         do_align =3D filp || (flags & MAP_SHARED);
> >
> > The pgoff is needed if do_align is true. So we should just zero pgoff
> > iff !file && !MAP_SHARED like what my patch does, we can move the
> > zeroing to a better place.
>
> We crossed streams - I sent out the patch just as you sent this. My patch=
 is
> implemented as I proposed.

We crossed again :-)

>
> I'm not sure I agree with what you are saying. The mmap man page says thi=
s:
>
>   The  contents  of  a file mapping (as opposed to an anonymous mapping; =
see
>   MAP_ANONYMOUS below), are initialized using length bytes starting at of=
fset
>   offset in the file (or other object) referred to by the file descriptor=
 fd.
>
> So that implies offset is only relavent when a file is provided. It then =
goes on
> to say:
>
>   MAP_ANONYMOUS
>   The mapping is not backed by any file; its contents are initialized to =
zero.
>   The fd argument is ignored; however, some implementations require fd to=
 be -1
>   if MAP_ANONYMOUS (or MAP_ANON) is specified, and portable applications =
should
>   ensure this. The offset argument should be zero.
>
> So users are expected to pass offset=3D0 when mapping anon memory, for bo=
th shared
> and private cases.
>
> Infact, in the line above where you made your proposed change, pgoff is a=
lso
> being zeroed for the (!file && (flags & MAP_SHARED)) case.

Yeah, rethinking led me to the same conclusion.

>
>
> >
> >>
> >>
> >>>
> >>>>
> >>>> Finally, the second test failure I reported (ksm_tests) is actually =
caused by a
> >>>> bug in the test code, but provoked by this change. So I'll send out =
a fix for
> >>>> the test code separately.
> >>>>
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 4f542444a91f..68ac54117c77 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(str=
uct file *filp,
> >>>>  {
> >>>>         loff_t off_end =3D off + len;
> >>>>         loff_t off_align =3D round_up(off, size);
> >>>> -       unsigned long len_pad, ret;
> >>>> +       unsigned long len_pad, ret, off_sub;
> >>>>
> >>>>         if (off_end <=3D off_align || (off_end - off_align) < size)
> >>>>                 return 0;
> >>>> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(st=
ruct file *filp,
> >>>>         if (ret =3D=3D addr)
> >>>>                 return addr;
> >>>>
> >>>> -       ret +=3D (off - ret) & (size - 1);
> >>>> +       off_sub =3D (off - ret) & (size - 1);
> >>>> +
> >>>> +       if (current->mm->get_unmapped_area =3D=3D arch_get_unmapped_=
area_topdown &&
> >>>> +           !off_sub)
> >>>> +               return ret + size;
> >>>> +
> >>>> +       ret +=3D off_sub;
> >>>>         return ret;
> >>>>  }
> >>>
> >>> I didn't spot any problem, would you please come up with a formal pat=
ch?
> >>
> >> Yeah, I'll aim to post today.
> >
> > Thanks!
> >
> >>
> >>
>

