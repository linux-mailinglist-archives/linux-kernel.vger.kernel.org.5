Return-Path: <linux-kernel+bounces-132398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776E899404
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4211028C47F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95351BDDB;
	Fri,  5 Apr 2024 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGVlpVrO"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A731C687
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712289976; cv=none; b=MHzc2KjAAY72CoIkHcEUNFpEZ4sbMf7vzq96ZxjOcHLt6BVKE3KZTgudc1WLPypnPnaViOxekMY96qv9Cp1ZLbccBtjCQRTEEQfnm2kU8iJndLKDweQ/VgrgagzlPdwECf77pGvil2A51z3EmAU/aLaF2pJbFsdUc33UWKNXQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712289976; c=relaxed/simple;
	bh=5bi5PXnRQHq5Uh0w9F79pNa+WxLgBKykgsSPh2SlQgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QySmuL5BCltRkU0bEyVRhvyfbXEFir1lF0GbnZb9wip1uuVrBOEJDp2ZLipc7lQz7Afj/xMX01gyrqyV4AinMsl9NocADirVs2E9LgqcrKMw0nQERVGbEd/kKIHFYPuh0UKdqJ74Au2d1KAjMDNbzZ1IVsP1VSIEqYj44/cQuHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGVlpVrO; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-479c8f43ca5so585504137.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712289974; x=1712894774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oGwlVU9ddzBAFbWf0+zs68/qlXNCHyABcIeCzpjalA=;
        b=MGVlpVrOqSGogs6as9c6iwWZiR0T2l4a0U7UrriIyUN8suuu9x/k0qKRsMtH49ep72
         iesPTojVvoL9uAUaa+8xlixHEUjfaj3vQbu/ZOjLI/zGgK2EwmxIrpQ2S7sUYxKvSCjH
         qyap5XQLS/7YAppTXxYpek3rMXLvrnshN6cZ4wv5n9wXaG5egX4qIWieBGapo+6Ug35k
         fMFWkSFbwHb513O1qsYQbu5/Tv7P2BGqqSfPkycLBF16yYLmBPjyRn1aFC7jVRocr/7h
         eMnePwGxqVDOIqJQeFMVK8wJHh5lsvu7P8RY7cL9H38v1lw9F85ybyJZX7nCFPtJ38A0
         Lahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712289974; x=1712894774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oGwlVU9ddzBAFbWf0+zs68/qlXNCHyABcIeCzpjalA=;
        b=GidknIKbXUWFb8HHG45pjXbYePCwmIfIkB6ceF8x9kNKYGFt5uQodWZTBGq/v08CUz
         qT3gfy2DbywYkUZvffy/NsCQjaC93bBxz3fKnT4+yq17ZTB4zzALsskjOUPq0xkWlQ4K
         BNDduTvigdeMCQtS/sy5HPeBGTw9mPBHSVi6nDOWgXjHJfRV3R8dXaNRvb6XTECm17uQ
         DPiK3q5R+PhD+y8Q74fMmqgChUVPF9isE1euNLEQNUWPsqzaXJDkic2Om4TZ2S0KbJdv
         yll7Wkfs2KfYIDe8OJ7IMJQdd3CmWEUxC7ZSsgzZM/pwO+R43lCHp+ERwNOKzmrvvVLZ
         wCJg==
X-Forwarded-Encrypted: i=1; AJvYcCWyT6mufC204lqfTbXTj/0C4DhHTIQI3YrFrM0Efr864BGu3lUWSUvR7u1Tv566mHGmB4SpQvCVqNElrnqQ06Z5pTTUlCxx5z9IoscF
X-Gm-Message-State: AOJu0Yygkw12ILwuFwVFf+ykZmw+Fi8BJKMK5BqEnBYkEO7Z0mgGR7gZ
	/GmVN9KeT8jPolRlpASc7gC2hs4vIYWpjJUPKkoBToPBFmiwYwQ0h2lOlIelpPQA6tT0ZKkjYXs
	t2dqqJFqxRgqwz2Y6vDyD+wJFT7w=
X-Google-Smtp-Source: AGHT+IEwhifn1AjlV40ks2cDrmGC2MQKw88EjzZTnibHX97kUgz+W0ToiN9tkMhomur40IjK01IAnifCGEVvzIazXbM=
X-Received: by 2002:a05:6102:b08:b0:479:d98e:2cb7 with SMTP id
 b8-20020a0561020b0800b00479d98e2cb7mr415139vst.2.1712289974090; Thu, 04 Apr
 2024 21:06:14 -0700 (PDT)
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
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 5 Apr 2024 17:06:03 +1300
Message-ID: <CAGsJ_4xocWy7PyHbgWhaK1gQeHADMAng3cFtnPHFW4MGB7qkBA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:10=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
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

Hi Ryan,

Today, I created counters for per-order SWPOUT and SWPOUT_FALLBACK.
I'd appreciate any
suggestions you might have before I submit this as patch 2/2 of my
mTHP counters series.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index cc13fa14aa32..762a6d8759b9 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -267,6 +267,8 @@ unsigned long thp_vma_allowable_orders(struct
vm_area_struct *vma,
 enum thp_stat_item {
        THP_STAT_ANON_ALLOC,
        THP_STAT_ANON_ALLOC_FALLBACK,
+       THP_STAT_ANON_SWPOUT,
+       THP_STAT_ANON_SWPOUT_FALLBACK,
        __THP_STAT_COUNT
 };

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e704b4408181..7f2b5d2852cc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -554,10 +554,14 @@ static struct kobj_attribute _name##_attr =3D
__ATTR_RO(_name)

 THP_STATE_ATTR(anon_alloc, THP_STAT_ANON_ALLOC);
 THP_STATE_ATTR(anon_alloc_fallback, THP_STAT_ANON_ALLOC_FALLBACK);
+THP_STATE_ATTR(anon_swpout, THP_STAT_ANON_SWPOUT);
+THP_STATE_ATTR(anon_swpout_fallback, THP_STAT_ANON_SWPOUT_FALLBACK);

 static struct attribute *stats_attrs[] =3D {
        &anon_alloc_attr.attr,
        &anon_alloc_fallback_attr.attr,
+       &anon_swpout_attr.attr,
+       &anon_swpout_fallback_attr.attr,
        NULL,
 };

diff --git a/mm/page_io.c b/mm/page_io.c
index a9a7c236aecc..be4f822b39f8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -212,13 +212,16 @@ int swap_writepage(struct page *page, struct
writeback_control *wbc)

 static inline void count_swpout_vm_event(struct folio *folio)
 {
+       long nr_pages =3D folio_nr_pages(folio);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
        if (unlikely(folio_test_pmd_mappable(folio))) {
                count_memcg_folio_events(folio, THP_SWPOUT, 1);
                count_vm_event(THP_SWPOUT);
        }
+       if (nr_pages > 0 && nr_pages <=3D HPAGE_PMD_NR)
+               count_thp_state(folio_order(folio), THP_STAT_ANON_SWPOUT);
 #endif
-       count_vm_events(PSWPOUT, folio_nr_pages(folio));
+       count_vm_events(PSWPOUT, nr_pages);
 }

 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ffc4553c8615..b7c5fbd830b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1247,6 +1247,10 @@ static unsigned int shrink_folio_list(struct
list_head *folio_list,
                                                count_vm_event(
                                                        THP_SWPOUT_FALLBACK=
);
                                        }
+                                       if (nr_pages > 0 && nr_pages
<=3D HPAGE_PMD_NR)
+
count_thp_state(folio_order(folio),
+
THP_STAT_ANON_SWPOUT_FALLBACK);
+
 #endif
                                        if (!add_to_swap(folio))
                                                goto activate_locked_split;


Thanks
Barry

