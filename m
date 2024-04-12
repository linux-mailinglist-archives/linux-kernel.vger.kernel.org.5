Return-Path: <linux-kernel+bounces-143200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34CC8A35B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129F81C2415D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FE14EC49;
	Fri, 12 Apr 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpCRkYro"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032914E2EC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946608; cv=none; b=M1AYTsT82Un030k46nObX7TOE7CxcCjd6BzRAtFrWDx23wQ6SK1QDke3MzkWYIiBVmbO21Ogyg3Qbg+9pFoqWVHaqLivQ6MzkQgWSzHeyIZz8kt3LXmgy4QYWHCnSWQmuC5YK+lxz0vzHRCJ37Tzzz8e7xNzmOvI27+bmVRJHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946608; c=relaxed/simple;
	bh=RKOs60WHL+SBdWq3uUVpvTOugaIx5MWQ+ImewTH54kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXoSB5mWKyBtkuT8bhV+kdKyjn6lJ8bwaoExLJ0Tvsb+CeKCQGvXnzzzMK6PB4YV2RdCZNoFzIw9urQW1qxOvCgcC7ZZx07oyHIzxSxvqt2dqqDEhd2ggkD15iDGU9jsH9kTzDvVf6NB5KD/5k338HM9HeapBLAA8kBDuh9bpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpCRkYro; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56fe8093c9eso1242447a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712946605; x=1713551405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD2nD0XariWODin1huWBZbgRGq+Hrz+B6uxbj5nmPoA=;
        b=jpCRkYroEtu3nSskyv7xGrfa2grtbRvFcnfy6hN1AHGUc7h0PKx5BRpJZ+gE7gcUK7
         Qbt1rmdgsHVUGY/5oxtYzGHh2q/vXltI+CrIRIvDW2AE0/3ZbcVvY/OpchK3gUllVbWf
         dCT+cNgZAXyc0ug9IPBZ/h0B9WeH6XE53eivD+ow2K9mw18u1x4mx3PKMyZV9O/KlcNW
         v5G0XzUpDkk1huDglLEDkVYzSze5VcghirTdgsB6surL6m5FaKtKMuSg9dmvyYBIGknV
         h1qfZWRuzDgrBP6gkglxW20Vo6WUJmiPmvUjLla0Z3R2sZCklEP5JkocmKyxgE8g0Wf3
         EzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946605; x=1713551405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD2nD0XariWODin1huWBZbgRGq+Hrz+B6uxbj5nmPoA=;
        b=PB/5XxyXD2fjmwwOcrMI0mpxayF49pDUzLPxltF36hydtEg7azCWisoBbr1GbS/IN9
         +9aOrBV2wlSWCb23ZrqSUxQ5Fs5dMsEbbGHzSpgG9qNWNAMam0wZ42OIDqtvCIqFJYFe
         7FXDnZRMDfSbyIwlMg49RglK/pGv3lSeP7Nvq7pAj/i3tqJAJw2Uesy04Z2L0mnlpEqz
         dXv50VudmexhmdHyoJzDcnY4phgU43mymEl6TM0xxPrUDdogUr9ByCWsq+hMkt88KB2l
         x6+KQNyUEYe2eKaESOnar5wn1kirwDeechdEYmtouwNzNpBLy3jhQvgcwrvVZ0qrIvoJ
         wrwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWokJrdtMcDT4H/H77C+5XjZu+l0INnDVp17RxhKkeOn/h/TnXrL4swFeK+IRh2PlNA63NW9M/EwH9UCpmjiAsoX5jy2MfyVSbUZJpt
X-Gm-Message-State: AOJu0YwTHUpjEoGQDv8qg2q1PVRyehsfCRgyWTT3HXTDcJgiRGUuBQe6
	t/KOPNISnMHFexbp7yGwca0UVMlrBntADk1hpPR6FXR30V4CxfXjs59eN8vbg2JQrOWUnfTzYAQ
	5WiqBxXSY6g/gbyynXjzEvn8fLe4=
X-Google-Smtp-Source: AGHT+IGDMpUjzSkY3psrdP+Q+TVgpXXBLlLrW6Om+fPGeJ5DUQVuJtaswTsWa3AEWUXE3N4x5fygVtV0hE0rXT+wkKA=
X-Received: by 2002:a50:99c2:0:b0:568:7c01:a4a2 with SMTP id
 n2-20020a5099c2000000b005687c01a4a2mr2152393edb.13.1712946605037; Fri, 12 Apr
 2024 11:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
 <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com> <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
 <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com> <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
In-Reply-To: <A06608B4-9187-42DD-B9A2-CBBC3D5C9312@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 12 Apr 2024 11:29:53 -0700
Message-ID: <CAHbLzkoxXDwV8H_G2wSPNd3=pCtY-H-A20nBp-fxYNO_RVUTwQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 7:31=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 12 Apr 2024, at 10:21, Zi Yan wrote:
>
> > On 11 Apr 2024, at 17:59, Yang Shi wrote:
> >
> >> On Thu, Apr 11, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 11.04.24 21:01, Yang Shi wrote:
> >>>> On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 11.04.24 17:32, Zi Yan wrote:
> >>>>>> From: Zi Yan <ziy@nvidia.com>
> >>>>>>
> >>>>>> In __folio_remove_rmap(), a large folio is added to deferred split=
 list
> >>>>>> if any page in a folio loses its final mapping. It is possible tha=
t
> >>>>>> the folio is unmapped fully, but it is unnecessary to add the foli=
o
> >>>>>> to deferred split list at all. Fix it by checking folio mapcount b=
efore
> >>>>>> adding a folio to deferred split list.
> >>>>>>
> >>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>>>> ---
> >>>>>>    mm/rmap.c | 9 ++++++---
> >>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>>>> index 2608c40dffad..d599a772e282 100644
> >>>>>> --- a/mm/rmap.c
> >>>>>> +++ b/mm/rmap.c
> >>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                enum rmap_level level)
> >>>>>>    {
> >>>>>>        atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>>>>> -     int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>>>>> +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>>>>        enum node_stat_item idx;
> >>>>>>
> >>>>>>        __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> >>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                        break;
> >>>>>>                }
> >>>>>>
> >>>>>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
> >>>>>> +             mapcount =3D atomic_sub_return(nr_pages,
> >>>>>> +                                          &folio->_large_mapcount=
) + 1;
> >>>>>
> >>>>> That becomes a new memory barrier on some archs. Rather just re-rea=
d it
> >>>>> below. Re-reading should be fine here.
> >>>>>
> >>>>>>                do {
> >>>>>>                        last =3D atomic_add_negative(-1, &page->_ma=
pcount);
> >>>>>>                        if (last) {
> >>>>>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_r=
map(struct folio *folio,
> >>>>>>                 * is still mapped.
> >>>>>>                 */
> >>>>>>                if (folio_test_large(folio) && folio_test_anon(foli=
o))
> >>>>>> -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
> >>>>>> +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
> >>>>>> +                          mapcount !=3D 0) ||
> >>>>>> +                         (level =3D=3D RMAP_LEVEL_PMD && nr < nr_=
pmdmapped))
> >>>>>>                                deferred_split_folio(folio);
> >>>>>>        }
> >>>>>
> >>>>> But I do wonder if we really care? Usually the folio will simply ge=
t
> >>>>> freed afterwards, where we simply remove it from the list.
> >>>>>
> >>>>> If it's pinned, we won't be able to free or reclaim, but it's rathe=
r a
> >>>>> corner case ...
> >>>>>
> >>>>> Is it really worth the added code? Not convinced.
> >>>>
> >>>> It is actually not only an optimization, but also fixed the broken
> >>>> thp_deferred_split_page counter in /proc/vmstat.
> >>>>
> >>>> The counter actually counted the partially unmapped huge pages (so
> >>>> they are on deferred split queue), but it counts the fully unmapped
> >>>> mTHP as well now. For example, when a 64K THP is fully unmapped, the
> >>>> thp_deferred_split_page is not supposed to get inc'ed, but it does
> >>>> now.
> >>>>
> >>>> The counter is also useful for performance analysis, for example,
> >>>> whether a workload did a lot of partial unmap or not. So fixing the
> >>>> counter seems worthy. Zi Yan should have mentioned this in the commi=
t
> >>>> log.
> >>>
> >>> Yes, all that is information that is missing from the patch descripti=
on.
> >>> If it's a fix, there should be a "Fixes:".
> >>>
> >>> Likely we want to have a folio_large_mapcount() check in the code bel=
ow.
> >>> (I yet have to digest the condition where this happens -- can we have=
 an
> >>> example where we'd use to do the wrong thing and now would do the rig=
ht
> >>> thing as well?)
> >>
> >> For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
> >> some full 64K areas, you will see thp_deferred_split_page increased,
> >> but it shouldn't.
> >>
> >> It looks __folio_remove_rmap() incorrectly detected whether the mTHP
> >> is fully unmapped or partially unmapped by comparing the number of
> >> still-mapped subpages to ENTIRELY_MAPPED, which should just work for
> >> PMD-mappable THP.
> >>
> >> However I just realized this problem was kind of workaround'ed by comm=
it:
> >>
> >> commit 98046944a1597f3a02b792dbe9665e9943b77f28
> >> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Date:   Fri Mar 29 14:59:33 2024 +0800
> >>
> >>     mm: huge_memory: add the missing folio_test_pmd_mappable() for THP
> >> split statistics
> >>
> >>     Now the mTHP can also be split or added into the deferred list, so=
 add
> >>     folio_test_pmd_mappable() validation for PMD mapped THP, to avoid
> >>     confusion with PMD mapped THP related statistics.
> >>
> >>     Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93e43=
68bbc1.1711694852.git.baolin.wang@linux.alibaba.com
> >>     Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>     Acked-by: David Hildenbrand <david@redhat.com>
> >>     Cc: Muchun Song <muchun.song@linux.dev>
> >>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>
> >> This commit made thp_deferred_split_page didn't count mTHP anymore, it
> >> also made thp_split_page didn't count mTHP anymore.
> >>
> >> However Zi Yan's patch does make the code more robust and we don't
> >> need to worry about the miscounting issue anymore if we will add
> >> deferred_split_page and split_page counters for mTHP in the future.
> >
> > Actually, the patch above does not fix everything. A fully unmapped
> > PTE-mapped order-9 THP is also added to deferred split list and
> > counted as THP_DEFERRED_SPLIT_PAGE without my patch, since nr is 512
> > (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
> > the order-9 folio is folio_test_pmd_mappable().
> >
> > I will add this information in the next version.
>
> It might
> Fixes: b06dc281aa99 ("mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]=
()"),
> but before this commit fully unmapping a PTE-mapped order-9 THP still inc=
reased
> THP_DEFERRED_SPLIT_PAGE, because PTEs are unmapped individually and first=
 PTE
> unmapping adds the THP into the deferred split list. This means commit b0=
6dc281aa99
> did not change anything and before that THP_DEFERRED_SPLIT_PAGE increase =
is
> due to implementation. I will add this to the commit log as well without =
Fixes
> tag.

Thanks for digging deeper. The problem may be not that obvious before
mTHP because PMD-mappable THP is converted to PTE-mapped due to
partial unmap in most cases. But mTHP is always PTE-mapped in the
first place. The other reason is batched rmap remove was not supported
before David's optimization.

Now we do have reasonable motivation to make it precise and it is also
easier to do so than before.

>
>
> --
> Best Regards,
> Yan, Zi

