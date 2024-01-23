Return-Path: <linux-kernel+bounces-35762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6F83961D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987AE1C241FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44437FBAF;
	Tue, 23 Jan 2024 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX7ejn2/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3B80050
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030082; cv=none; b=d4Birg5cyOBVc8BV6yI84Kt6WVsMH92DZfXgdljH39e4FBQhmWTqhHD47FaNqAFxwCg5t6Q5RrRYi/6PQSeSYyqbPBd41JvLQZe/9ysesax5vzcc0OKcARMMvw0NUHb8IY3UbRqwUrNsRZv+Ift+TyXFG3YATsdlCgEk4faupmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030082; c=relaxed/simple;
	bh=576bkPMLzuXbAGwilyifYFzjK/3LE0Ls74xIiOPTiGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVbRDRJXG/IssiZmWHjDnLQkPiBKE+gQfOsW6+Wcijxid3ZyUHDh5159nwgmOOH+bKb8HFl9yX4qE1JIdJWBTem4mTM5DABx896qPR0F51kBSOxcmDk9ipslLLFEd8PFYH3oaBENH9DIqEClnYJCbeo43XnLIpyLnoknpJZXy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX7ejn2/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so3689264b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706030080; x=1706634880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DNezpFxIXzeeU2U4MFZwCEO05BxRItJUlB3EwgzaOU=;
        b=WX7ejn2/HAiJDym3vfii2D8Zsh3oMoUdk/pysc0pJa2bXhojUJVbRPyGOU05D644L0
         9ZU6ZLJCDlJRyrpdjQ4awuyygcoW/3zQjft2Z6du5Y6oOznOc80evBV58Pk6VXF3nwPm
         Hir9Bwc/S1IjfvIzhq1TNBvoqZRxMzTPQqfRD+N1lKFjfzzLZ8SybV0J0cbuNGHzc9A/
         dbkY0kZbPsBt27LuQOr/bXW80oSgEi8jkzCI9gG1RXdh+8tJIF562gpuXlRrVV/KgLgG
         6YF+OOy9dxCUuhUfmHix16tJ3BFp6+Ku8PAAMQV4YbNkZlVhFiDMCEgsRZE1Ct6w57Tc
         VTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030080; x=1706634880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DNezpFxIXzeeU2U4MFZwCEO05BxRItJUlB3EwgzaOU=;
        b=mdygpV893AXXQhjcq8UmpOe0HWv2E3dmTRYKklLTAZNr6JHu1Wcp3A9cs30rciafAO
         utDDevpJw6H8RCKEutCdRz++DBnSdmhkn3c8MBLDD9ONn+r7zBwJEGmZ8vcJOvGN8cvo
         tBUrL5aG9hGOZ4d5Z8tHalnvA5/OklxIZgzWCLZQga3EfCBM03AbY3lPXC9tDdEkuaXK
         lP00CwGEVXW7tCiPFXr7NVQYrQH81eDKchJ4cIBOuuN51qZFOmvLZ3dv1O5czYOOuaqO
         LMJkjbPNZzLstSwyjbHPS3NKNhn3Xz91ViiHH/HF0ppIS2f3/dkAO0leQsVJC1nrNSsJ
         hNIw==
X-Gm-Message-State: AOJu0YwoIgpBSWCc2ZTLkUttzx/8HOu27nFkrJo/yQNyidfOh8URD5VI
	u8gwAKLKfwASKUf5EDrD8m69GuJgoQQMwANJEDpmcqXiA2Oo2yWlfxxC3Z90pgYGK0C2z8ckBwl
	IqyEWKI0D22hooO0EAhHC8o8oWZ8=
X-Google-Smtp-Source: AGHT+IGdprY6W0mA9cG6ffr/9OI2v7VapsMAQMcBcOYOgT5/4HrbOrkQ1ZRzfv0ww6Yhz5hLFN4HJmwjcLZduKkfYgc=
X-Received: by 2002:a05:6a21:3281:b0:197:570c:c3a6 with SMTP id
 yt1-20020a056a21328100b00197570cc3a6mr8141941pzb.101.1706030079600; Tue, 23
 Jan 2024 09:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com> <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
In-Reply-To: <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 23 Jan 2024 09:14:27 -0800
Message-ID: <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 22/01/2024 19:43, Yang Shi wrote:
> > On Mon, Jan 22, 2024 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 20/01/2024 16:39, Matthew Wilcox wrote:
> >>> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> >>>> However, after this patch, each allocation is in its own VMA, and th=
ere is a 2M
> >>>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH s=
lower
> >>>> because there are so many VMAs to check to find a new 1G gap. 2) It =
fails once
> >>>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this lim=
it then
> >>>> causes a subsequent calloc() to fail, which causes the test to fail.
> >>>>
> >>>> Looking at the code, I think the problem is that arm64 selects
> >>>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area()=
 allocates
> >>>> len+2M then always aligns to the bottom of the discovered gap. That =
causes the
> >>>> 2M hole. As far as I can see, x86 allocates bottom up, so you don't =
get a hole.
> >>>
> >>> As a quick hack, perhaps
> >>> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >>> take-the-top-half
> >>> #else
> >>> current-take-bottom-half-code
> >>> #endif
> >>>
> >>> ?
> >
> > Thanks for the suggestion. It makes sense to me. Doing the alignment
> > needs to take into account this.
> >
> >>
> >> There is a general problem though that there is a trade-off between ab=
utting
> >> VMAs, and aligning them to PMD boundaries. This patch has decided that=
 in
> >> general the latter is preferable. The case I'm hitting is special thou=
gh, in
> >> that both requirements could be achieved but currently are not.
> >>
> >> The below fixes it, but I feel like there should be some bitwise magic=
 that
> >> would give the correct answer without the conditional - but my head is=
 gone and
> >> I can't see it. Any thoughts?
> >
> > Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
> > the conditional either.
> >
> >>
> >> Beyond this, though, there is also a latent bug where the offset provi=
ded to
> >> mmap() is carried all the way through to the get_unmapped_area()
> >> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
> >> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for =
arches
> >> that use the default get_unmapped_area(), any non-zero offset would no=
t have
> >> been used. But this change starts using it, which is incorrect. That s=
aid, there
> >> are some arches that override the default get_unmapped_area() and do u=
se the
> >> offset. So I'm not sure if this is a bug or a feature that user space =
can pass
> >> an arbitrary value to the implementation for anon memory??
> >
> > Thanks for noticing this. If I read the code correctly, the pgoff used
> > by some arches to workaround VIPT caches, and it looks like it is for
> > shared mapping only (just checked arm and mips). And I believe
> > everybody assumes 0 should be used when doing anonymous mapping. The
> > offset should have nothing to do with seeking proper unmapped virtual
> > area. But the pgoff does make sense for file THP due to the alignment
> > requirements. I think it should be zero'ed for anonymous mappings,
> > like:
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 2ff79b1d1564..a9ed353ce627 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
> > long addr, unsigned long len,
> >                 pgoff =3D 0;
> >                 get_area =3D shmem_get_unmapped_area;
> >         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > +               pgoff =3D 0;
> >                 /* Ensures that larger anonymous mappings are THP align=
ed. */
> >                 get_area =3D thp_get_unmapped_area;
> >         }
>
> I think it would be cleaner to just zero pgoff if file=3D=3DNULL, then it=
 covers the
> shared case, the THP case, and the non-THP case properly. I'll prepare a
> separate patch for this.

IIUC I don't think this is ok for those arches which have to
workaround VIPT cache since MAP_ANONYMOUS | MAP_SHARED with NULL file
pointer is a common case for creating tmpfs mapping. For example,
arm's arch_get_unmapped_area() has:

if (aliasing)
        do_align =3D filp || (flags & MAP_SHARED);

The pgoff is needed if do_align is true. So we should just zero pgoff
iff !file && !MAP_SHARED like what my patch does, we can move the
zeroing to a better place.

>
>
> >
> >>
> >> Finally, the second test failure I reported (ksm_tests) is actually ca=
used by a
> >> bug in the test code, but provoked by this change. So I'll send out a =
fix for
> >> the test code separately.
> >>
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 4f542444a91f..68ac54117c77 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struc=
t file *filp,
> >>  {
> >>         loff_t off_end =3D off + len;
> >>         loff_t off_align =3D round_up(off, size);
> >> -       unsigned long len_pad, ret;
> >> +       unsigned long len_pad, ret, off_sub;
> >>
> >>         if (off_end <=3D off_align || (off_end - off_align) < size)
> >>                 return 0;
> >> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(stru=
ct file *filp,
> >>         if (ret =3D=3D addr)
> >>                 return addr;
> >>
> >> -       ret +=3D (off - ret) & (size - 1);
> >> +       off_sub =3D (off - ret) & (size - 1);
> >> +
> >> +       if (current->mm->get_unmapped_area =3D=3D arch_get_unmapped_ar=
ea_topdown &&
> >> +           !off_sub)
> >> +               return ret + size;
> >> +
> >> +       ret +=3D off_sub;
> >>         return ret;
> >>  }
> >
> > I didn't spot any problem, would you please come up with a formal patch=
?
>
> Yeah, I'll aim to post today.

Thanks!

>
>

