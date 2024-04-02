Return-Path: <linux-kernel+bounces-128033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6B89553B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E618E289BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E083CAA;
	Tue,  2 Apr 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzU0mpZO"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882179B8A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064150; cv=none; b=kQm/5jWbo2GddIr7BOT8n4vN/y/ZHQz3haMU+cT0PCRkbqmUOwFqCtDb5/CxfSSl4xFlfZhno20ng6SZpCZY6INyeDeFewF3fk3H48Q1EbWhr//BXsl8o8VAfas7znLhgaI0Ib3d/K5Aie5zCDmuSY9nMqLlNq+2k1C9dr2Ihyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064150; c=relaxed/simple;
	bh=F3/KSztqXE1RJ4wE6tYtCNLde9NUViHXpH9XU3bO6Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9vm8PO//kkeYbtrFsHXMt6QuwOI7kh114K2xmxfAV3yWjeJNYN+x/RJJFC4XRINAg30V2cP/2EgONVELJIZ+26byBQsxe7k/nuPct6hMd6bWKRG7OFzbciZLEE5mFHuZxAu1Lh1Px8RMw6qOZLrUjC+upa2ahvVo/zbXi5Va3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzU0mpZO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so558753e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064147; x=1712668947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37qcl+O6YD2iKKcTYX3TCpIUlrBbXdw/pysK7vT88Us=;
        b=QzU0mpZOoYFl/eLZMpmpC4EGExQY2k8OgnR3JrC/Vc/KooUKU+BkjtS42wLxNPJSAW
         Uz9ADGSILKadacr5TjP9p1D4L4qau4vYs9Z6XMSBkZeJwctrzzJk3k9AEMBmtl6Oqv5o
         kyoLAyF/yI7Mj9uVZf4dpTtKeSnOHJ88RiLlGeTIzFqMs6XTOE58eCLIUW7i4xjIb318
         2V1K1NvatVCi+bl6+3CLaraztTdhE6/95WNggCfu7hFXgbxujEagmtGiLqosbstCnVoy
         mL5xHWKncapyMB6oiA3SIhSOKOjZtf+czQaoGBqo/2gi4lTYbb/R9cXVX7mHawdqkTtO
         QuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064147; x=1712668947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37qcl+O6YD2iKKcTYX3TCpIUlrBbXdw/pysK7vT88Us=;
        b=UbZ0OcjniDjeyZysBJM0MyhCTkr6+hDx2ESdwdcAOdpnyVq2vHW8JpGuk1jDGWiYg4
         qO8dTnMT1nZCcrOj3GjsOurCLTzzUZ3ODxwBctg6hEUugqu0KRJW1Z76F5SRiGhthbsC
         2kLHYoRle6iZhNL/NZveJaI7vLa8HfUreaZiqV4O1qYeiQYYRxA7jcJYGqf6ok30YmFj
         r1YjcD4F9swSjZedM6xWkVt+mdUuNT0yBvqaE/qhT9xp1IHpmfB41knqHMsrytIUh8cv
         J75Bf3ObyMVOFHgHjzO3Ha15lWv1U6zdNBjhvyggN72VKrZkBM7DzTLrIGzs2d4qWQiE
         2uyA==
X-Forwarded-Encrypted: i=1; AJvYcCVWqajrtetSN3yruU6AUYFhZlN+mEnDeK566c6W8khlNvVBnFdFQVmKOLHsg7QTcGVffh8fiYxM0vNxDWOMMCF5KNyWFYT/4LN3NcRD
X-Gm-Message-State: AOJu0YzvPGXfsxh46EW6NfLaA3Xb9H57ddrQK2XtaYEcYOzw5m4aA2jY
	E4PoX1DqUReTXw/oG6SOK/CGBF1Fa54enQVTG8zwNgIARfbJc1R/OE1JU7csox5F0lunA4nLVXN
	7YPFWML2tyOpxlvhgXLiP/xeDR60=
X-Google-Smtp-Source: AGHT+IEtz0OZ72umCyrzWRVSeywQrhQ3KFvQPpv0lJyPaEv6zyLlUi9ltNYQabYxlDa40WUsAN9ueDCmzRz5eLpwRis=
X-Received: by 2002:a05:6512:2389:b0:515:be10:e288 with SMTP id
 c9-20020a056512238900b00515be10e288mr10983912lfv.21.1712064146755; Tue, 02
 Apr 2024 06:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-6-ryan.roberts@arm.com> <CAGsJ_4x40DxoukgRuEt3OKP7dESj3w+HXz=dHYR+PH8LjtCnEA@mail.gmail.com>
 <63c9caf4-3af4-4149-b3c2-e677788cb11f@arm.com>
In-Reply-To: <63c9caf4-3af4-4149-b3c2-e677788cb11f@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 2 Apr 2024 21:22:15 +0800
Message-ID: <CAK1f24kmeAULGvnATXXDXLREsLBGRUSDf_3D=mRv7vyhwNJ9Kg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Baolin Wang's patch[1] has avoided confusion with PMD mapped THP
related statistics.

So, these three counters (THP_SPLIT_PAGE, THP_SPLIT_PAGE_FAILED,
and THP_DEFERRED_SPLIT_PAGE) no longer include mTHP.

[1] https://lore.kernel.org/linux-mm/a5341defeef27c9ac7b85c97f030f93e4368bb=
c1.1711694852.git.baolin.wang@linux.alibaba.com/

On Tue, Apr 2, 2024 at 9:10=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 28/03/2024 08:18, Barry Song wrote:
> > On Thu, Mar 28, 2024 at 3:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Now that swap supports storing all mTHP sizes, avoid splitting large
> >> folios before swap-out. This benefits performance of the swap-out path
> >> by eliding split_folio_to_list(), which is expensive, and also sets us
> >> up for swapping in large folios in a future series.
> >>
> >> If the folio is partially mapped, we continue to split it since we wan=
t
> >> to avoid the extra IO overhead and storage of writing out pages
> >> uneccessarily.
> >>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/vmscan.c | 9 +++++----
> >>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 00adaf1cb2c3..293120fe54f3 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct l=
ist_head *folio_list,
> >>                                         if (!can_split_folio(folio, NU=
LL))
> >>                                                 goto activate_locked;
> >>                                         /*
> >> -                                        * Split folios without a PMD =
map right
> >> -                                        * away. Chances are some or a=
ll of the
> >> -                                        * tail pages can be freed wit=
hout IO.
> >> +                                        * Split partially mapped foli=
os right
> >> +                                        * away. We can free the unmap=
ped pages
> >> +                                        * without IO.
> >>                                          */
> >> -                                       if (!folio_entire_mapcount(fol=
io) &&
> >> +                                       if (data_race(!list_empty(
> >> +                                               &folio->_deferred_list=
)) &&
> >>                                             split_folio_to_list(folio,
> >>                                                                 folio_=
list))
> >>                                                 goto activate_locked;
> >
> > Hi Ryan,
> >
> > Sorry for bringing up another minor issue at this late stage.
>
> No problem - I'd rather take a bit longer and get it right, rather than r=
ush it
> and get it wrong!
>
> >
> > During the debugging of thp counter patch v2, I noticed the discrepancy=
 between
> > THP_SWPOUT_FALLBACK and THP_SWPOUT.
> >
> > Should we make adjustments to the counter?
>
> Yes, agreed; we want to be consistent here with all the other existing TH=
P
> counters; they only refer to PMD-sized THP. I'll make the change for the =
next
> version.
>
> I guess we will eventually want equivalent counters for per-size mTHP usi=
ng the
> framework you are adding.
>
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 293120fe54f3..d7856603f689 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1241,8 +1241,10 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                                                                 folio_l=
ist))
> >                                                 goto activate_locked;
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -
> > count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> > -                                       count_vm_event(THP_SWPOUT_FALLB=
ACK);
> > +                                       if (folio_test_pmd_mappable(fol=
io)) {
> > +
> > count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
> > +
> > count_vm_event(THP_SWPOUT_FALLBACK);
> > +                                       }
> >  #endif
> >                                         if (!add_to_swap(folio))
> >                                                 goto activate_locked_sp=
lit;
> >
> >
> > Because THP_SWPOUT is only for pmd:
> >
> > static inline void count_swpout_vm_event(struct folio *folio)
> > {
> > #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >         if (unlikely(folio_test_pmd_mappable(folio))) {
> >                 count_memcg_folio_events(folio, THP_SWPOUT, 1);
> >                 count_vm_event(THP_SWPOUT);
> >         }
> > #endif
> >         count_vm_events(PSWPOUT, folio_nr_pages(folio));
> > }
> >
> > I can provide per-order counters for this in my THP counter patch.
> >
> >> --
> >> 2.25.1
> >>
> >
> > Thanks
> > Barry
>

