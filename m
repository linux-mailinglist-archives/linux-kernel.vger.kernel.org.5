Return-Path: <linux-kernel+bounces-142535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24F8A2CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D71F22043
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1818443AD7;
	Fri, 12 Apr 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtJyJZLU"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517A1B5A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919200; cv=none; b=NnUQPFwgRuTBpkYR48eRvjkVho7VQ18LuQXtfp7p8FuSHVXFZFwwlgbiY6bkg5KhELHjBof/8Eswt7pte0gNUJ276p9pUc0uwWuUkBUAY/DOl/G+BNOqE+tuWos0Wj0LcbFng4wIpvM+LeGzllhAtD7nXBbcv9vnI7x9FJDoOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919200; c=relaxed/simple;
	bh=TcBlyRrt8oddJVpRoY56xZWJ0+0JaSuAnK/Jh41sq1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTn+z5V0DMqbWD/7VZeTFQ3Q1dgxTccsbAsLtIMqGOVZqTvf5Mg74nZGjg5xUfDyUX/S1SLyEZvgtjbQkBdyIke/IGCxe+tmtidbUZbsP/lOp5KqdOdGkfFbk5uruX2clJ8oGmDBh51h2nVlpYuo+palryEP6U3NjDvAwQ9+9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtJyJZLU; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so223009241.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712919198; x=1713523998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNMd+gb2+kz8eMgsr/jsH6tYZ45z+m5SXLIFNnje5mc=;
        b=VtJyJZLUmvOBdqY86j2AaqdQGQCsv1uWLIKiwc9c1f3npxcDKNIjoNjXQp+Oai6TkD
         +Ht3C4n6Qc5sBNtmPtrcjW97lYNnx4QigBaAbZxxcC+7mal3lPzM+XVzI1xfL7gx9VWc
         Rb2SJOBh0TifDVyYdPas+jZlfh69DP3fC9Ex18ViY3oe9z0cxq02bHzJpArfVpp5Ud8H
         /jX4yf0UIEMh/eQm+A2hQbKyqkbKUMoesow9w6ZE6aa9gFpnWIPEiOyhWrZZPJ9whUQJ
         jOFCJxoldcPY9NoxDjQl754rjrQ99J/BEcn6KOrco3Vpu3UFjk8ks6J6TI9ZgbwYGrHx
         vPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919198; x=1713523998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNMd+gb2+kz8eMgsr/jsH6tYZ45z+m5SXLIFNnje5mc=;
        b=dlAxRtKOi8qEk/Zpwv5QrWwsZXyRgzuQFmJfDqmmBHpJsNDyQR8jfwKxEuKOU66ea1
         7bz69zffANJt0cUI8xlXuYiKGxFVC/4evqT1Knb1/Vk3Y9e5N5CYnb2OfICWBoxTkB0Z
         NC4DUVmWQLBHJzDLtQmJEt6lGZNo7CWmr3UrrqjIKJtyB7PQq2e1Q4X3ruY7mpZIfXQW
         VFXdFxrF4rIs+LRMtOcN2eOSJu1HsGCDTpMA4A8KPtiAD7+hXzOE73nUGtTKVWmtCu4R
         889wf2cqD3e0h9+AWfzQJVFU5AspdQ+eU1TUbEx5NiNhTn48N6Myuh/gjoJjBHOrTvHE
         Or8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsXq+Kft1d/sdEGBi1CrNVEvswoP+6yIfKU+qca3aaWZxY/MEyAqHFxeCt6hiF2LrLnwjU6WlcZUbt/wf4TwuwhZbWlcHkcIUSTDsa
X-Gm-Message-State: AOJu0Yx8zSyhfVSvm/uxPOJ4vD+BndKejOagsxqZVLr1JNCTrqtNEymi
	VZCPIZ6JsxMLcHuKLb8Ag9xfwnKtagojF1imFFRkpuRn25MYtllXvU/OgyzGAO/ym/qk/RQNO4n
	X3e31MmwA2cgR2dB+naf7hLzOGKA=
X-Google-Smtp-Source: AGHT+IEaiUVcWmRtkTl6RMCRUCIX5BdO+5bUQ0QPL9n4NrV/1fcO4HPLsB8YO/nf4pqjlpnD67bdYDJ7pYU1dKGicOw=
X-Received: by 2002:a05:6122:4687:b0:4d4:2fbc:e61f with SMTP id
 di7-20020a056122468700b004d42fbce61fmr2231946vkb.14.1712919197509; Fri, 12
 Apr 2024 03:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5d6e014-5d6b-441c-8379-252ff24e2260@arm.com> <20240412101756.296971-1-21cnbao@gmail.com>
 <744fc49e-d91b-4f5a-9a27-1a25c50c2154@arm.com> <CAGsJ_4z6B09wbRFTXXek+pNi9yCHSSF+ZS2gph+AtViMhZyN9w@mail.gmail.com>
 <c9f425fd-285b-46b6-821e-fb758a4101e0@arm.com>
In-Reply-To: <c9f425fd-285b-46b6-821e-fb758a4101e0@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 22:53:06 +1200
Message-ID: <CAGsJ_4yJLgVn-GSErtCQ=W=V9-S4AucbYcP3ZLqoE5ynHf1sGg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, chrisl@kernel.org, 
	corbet@lwn.net, david@redhat.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:38=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 12/04/2024 11:29, Barry Song wrote:
> > On Fri, Apr 12, 2024 at 10:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> On 12/04/2024 11:17, Barry Song wrote:
> >>> On Fri, Apr 12, 2024 at 9:56=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> On 12/04/2024 10:43, Barry Song wrote:
> >>>>> On Fri, Apr 12, 2024 at 9:27=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> >>>>>>
> >>>>>> Hi Barry,
> >>>>>>
> >>>>>> 2 remaining comments - otherwise looks good. (same comments I just=
 made in the
> >>>>>> v4 conversation).
> >>>>>>
> >>>>>> On 12/04/2024 08:37, Barry Song wrote:
> >>>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>>
> >>>>>>> Profiling a system blindly with mTHP has become challenging due t=
o the
> >>>>>>> lack of visibility into its operations.  Presenting the success r=
ate of
> >>>>>>> mTHP allocations appears to be pressing need.
> >>>>>>>
> >>>>>>> Recently, I've been experiencing significant difficulty debugging
> >>>>>>> performance improvements and regressions without these figures.  =
It's
> >>>>>>> crucial for us to understand the true effectiveness of mTHP in re=
al-world
> >>>>>>> scenarios, especially in systems with fragmented memory.
> >>>>>>>
> >>>>>>> This patch establishes the framework for per-order mTHP
> >>>>>>> counters. It begins by introducing the anon_fault_alloc and
> >>>>>>> anon_fault_fallback counters. Additionally, to maintain consisten=
cy
> >>>>>>> with thp_fault_fallback_charge in /proc/vmstat, this patch also t=
racks
> >>>>>>> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> >>>>>>> Incorporating additional counters should now be straightforward a=
s well.
> >>>>>>>
> >>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>> Cc: Chris Li <chrisl@kernel.org>
> >>>>>>> Cc: David Hildenbrand <david@redhat.com>
> >>>>>>> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >>>>>>> Cc: Kairui Song <kasong@tencent.com>
> >>>>>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>>>>>> Cc: Peter Xu <peterx@redhat.com>
> >>>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>>>>> Cc: Suren Baghdasaryan <surenb@google.com>
> >>>>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>>>>>> Cc: Yu Zhao <yuzhao@google.com>
> >>>>>>> ---
> >>>>>>>  include/linux/huge_mm.h | 51 ++++++++++++++++++++++++++++++++++
> >>>>>>>  mm/huge_memory.c        | 61 +++++++++++++++++++++++++++++++++++=
++++++
> >>>>>>>  mm/memory.c             |  3 ++
> >>>>>>>  mm/page_alloc.c         |  4 +++
> >>>>>>>  4 files changed, 119 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>>>> index e896ca4760f6..c5beb54b97cb 100644
> >>>>>>> --- a/include/linux/huge_mm.h
> >>>>>>> +++ b/include/linux/huge_mm.h
> >>>>>>> @@ -264,6 +264,57 @@ unsigned long thp_vma_allowable_orders(struc=
t vm_area_struct *vma,
> >>>>>>>                                         enforce_sysfs, orders);
> >>>>>>>  }
> >>>>>>>
> >>>>>>> +enum mthp_stat_item {
> >>>>>>> +     MTHP_STAT_ANON_FAULT_ALLOC,
> >>>>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK,
> >>>>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>>>> +     __MTHP_STAT_COUNT
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +struct mthp_stat {
> >>>>>>> +     unsigned long stats[0][__MTHP_STAT_COUNT];
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +extern struct mthp_stat __percpu *mthp_stats;
> >>>>>>> +
> >>>>>>> +static inline void count_mthp_stat(int order, enum mthp_stat_ite=
m item)
> >>>>>>> +{
> >>>>>>> +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> >>>>>>> +             return;
> >>>>>>> +
> >>>>>>> +     this_cpu_inc(mthp_stats->stats[order][item]);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +static inline void count_mthp_stats(int order, enum mthp_stat_it=
em item, long delta)
> >>>>>>> +{
> >>>>>>> +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> >>>>>>> +             return;
> >>>>>>> +
> >>>>>>> +     this_cpu_add(mthp_stats->stats[order][item], delta);
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +/*
> >>>>>>> + * Fold the foreign cpu mthp stats into our own.
> >>>>>>> + *
> >>>>>>> + * This is adding to the stats on one processor
> >>>>>>> + * but keeps the global counts constant.
> >>>>>>> + */
> >>>>>>> +static inline void mthp_stats_fold_cpu(int cpu)
> >>>>>>> +{
> >>>>>>> +     struct mthp_stat *fold_stat;
> >>>>>>> +     int i, j;
> >>>>>>> +
> >>>>>>> +     if (!mthp_stats)
> >>>>>>> +             return;
> >>>>>>> +     fold_stat =3D per_cpu_ptr(mthp_stats, cpu);
> >>>>>>> +     for (i =3D 1; i <=3D PMD_ORDER; i++) {
> >>>>>>> +             for (j =3D 0; j < __MTHP_STAT_COUNT; j++) {
> >>>>>>> +                     count_mthp_stats(i, j, fold_stat->stats[i][=
j]);
> >>>>>>> +                     fold_stat->stats[i][j] =3D 0;
> >>>>>>> +             }
> >>>>>>> +     }
> >>>>>>> +}
> >>>>>>
> >>>>>> This is a pretty horrible hack; I'm pretty sure just summing for a=
ll *possible*
> >>>>>> cpus should work.
> >>>>>>
> >>>>>>> +
> >>>>>>>  #define transparent_hugepage_use_zero_page()                    =
     \
> >>>>>>>       (transparent_hugepage_flags &                              =
     \
> >>>>>>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> >>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>>>> index dc30139590e6..21c4ac74b484 100644
> >>>>>>> --- a/mm/huge_memory.c
> >>>>>>> +++ b/mm/huge_memory.c
> >>>>>>> @@ -526,6 +526,50 @@ static const struct kobj_type thpsize_ktype =
=3D {
> >>>>>>>       .sysfs_ops =3D &kobj_sysfs_ops,
> >>>>>>>  };
> >>>>>>>
> >>>>>>> +struct mthp_stat __percpu *mthp_stats;
> >>>>>>> +
> >>>>>>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_ite=
m item)
> >>>>>>> +{
> >>>>>>> +     unsigned long sum =3D 0;
> >>>>>>> +     int cpu;
> >>>>>>> +
> >>>>>>> +     cpus_read_lock();
> >>>>>>> +     for_each_online_cpu(cpu) {
> >>>>>>> +             struct mthp_stat *this =3D per_cpu_ptr(mthp_stats, =
cpu);
> >>>>>>> +
> >>>>>>> +             sum +=3D this->stats[order][item];
> >>>>>>> +     }
> >>>>>>> +     cpus_read_unlock();
> >>>>>>> +
> >>>>>>> +     return sum;
> >>>>>>> +}
> >>>>>>> +
> >>>>>>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                    =
             \
> >>>>>>> +static ssize_t _name##_show(struct kobject *kobj,               =
     \
> >>>>>>> +                     struct kobj_attribute *attr, char *buf)    =
     \
> >>>>>>> +{                                                               =
     \
> >>>>>>> +     int order =3D to_thpsize(kobj)->order;                     =
       \
> >>>>>>> +                                                                =
     \
> >>>>>>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index=
));  \
> >>>>>>> +}                                                               =
     \
> >>>>>>> +static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
> >>>>>>> +
> >>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALL=
OC);
> >>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_=
FALLBACK);
> >>>>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON=
_FAULT_FALLBACK_CHARGE);
> >>>>>>> +
> >>>>>>> +static struct attribute *stats_attrs[] =3D {
> >>>>>>> +     &anon_fault_alloc_attr.attr,
> >>>>>>> +     &anon_fault_fallback_attr.attr,
> >>>>>>> +     &anon_fault_fallback_charge_attr.attr,
> >>>>>>> +     NULL,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static struct attribute_group stats_attr_group =3D {
> >>>>>>> +     .name =3D "stats",
> >>>>>>> +     .attrs =3D stats_attrs,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>>  static struct thpsize *thpsize_create(int order, struct kobject =
*parent)
> >>>>>>>  {
> >>>>>>>       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> >>>>>>> @@ -549,6 +593,12 @@ static struct thpsize *thpsize_create(int or=
der, struct kobject *parent)
> >>>>>>>               return ERR_PTR(ret);
> >>>>>>>       }
> >>>>>>>
> >>>>>>> +     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_grou=
p);
> >>>>>>> +     if (ret) {
> >>>>>>> +             kobject_put(&thpsize->kobj);
> >>>>>>> +             return ERR_PTR(ret);
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>>       thpsize->order =3D order;
> >>>>>>>       return thpsize;
> >>>>>>>  }
> >>>>>>> @@ -691,6 +741,11 @@ static int __init hugepage_init(void)
> >>>>>>>        */
> >>>>>>>       MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
> >>>>>>>
> >>>>>>> +     mthp_stats =3D __alloc_percpu((PMD_ORDER + 1) * sizeof(mthp=
_stats->stats[0]),
> >>>>>>> +                     sizeof(unsigned long));
> >>>>>>
> >>>>>> Personally I think it would be cleaner to allocate statically usin=
g
> >>>>>> ilog2(MAX_PTRS_PER_PTE) instead of PMD_ORDER.
> >>>>>
> >>>>> Hi Ryan,
> >>>>>
> >>>>> I don't understand why MAX_PTRS_PER_PTE is the correct size. For AR=
M64,
> >>>>>
> >>>>> #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
> >>>>>
> >>>>> #define MAX_PTRS_PER_PTE PTRS_PER_PTE
> >>>>>
> >>>>> #define PTRS_PER_PTE            (1 << (PAGE_SHIFT - 3))
> >>>>>
> >>>>> while PAGE_SIZE is 16KiB or 64KiB, PTRS_PER_PTE can be a huge numbe=
r?
> >>>>>
> >>>>>
> >>>>> Am I missing something?
> >>>>
> >>>> PTRS_PER_PTE is the number of PTE entries in a PTE table. On arm64 i=
ts as follows:
> >>>>
> >>>> PAGE_SIZE       PAGE_SHIFT      PTRS_PER_PTE
> >>>> 4K              12              512
> >>>> 16K             14              2048
> >>>> 64K             16              8192
> >>>>
> >>>> So (PTRS_PER_PTE * PAGE_SIZE) =3D PMD_SIZE
> >>>>
> >>>> PMD_ORDER is ilog2(PMD_SIZE / PAGE_SIZE) =3D ilog2(PTRS_PER_PTE)
> >>>>
> >>>> MAX_PTRS_PER_PTE is just the maximum value that PTRS_PER_PTE will ev=
er have,
> >>>> (and its equal to PTRS_PER_PTE except for powerpc).
> >>>>
> >>>> Pretty sure the math is correct?
> >>>
> >>> I am not convinced the math is correct :-)
> >>>
> >>> while page size is 64KiB, the page table is as below,
> >>> PMD_ORDER =3D L2 index bits =3D [41:29] =3D 13 !=3D ilog2(8192)
> >>
> >> 1 << 13 =3D 8192
> >>
> >> Right? So:
> >>
> >> ilog2(8192) =3D 13
> >>
> >> What's wrong with that?
> >>
> >> I even checked in Python to make sure I'm not going mad:
> >>
> >>>>> import math
> >>>>> math.log2(8192)
> >> 13.0
> >
> > You're correct. My mind fixated on the '16' in the line '64K 16 8192'.
> > I mistakenly thought ilog2(8192) equals 16. Apologies for the confusion=
.
>
> No worries! We got there in the end :)
>
> Of course my suggestion relies on being able to get a compile-time consta=
nt from
> ilog2(MAX_PTRS_PER_PTE). I think that should work, right?

I guess so, ilog2 can detect compile-time const, otherwise, it will find th=
e
last (most-significant) bit set.

I've implemented the following change, and the build all passed.
Currently conducting testing.

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c5beb54b97cb..d4fdb2641070 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -272,47 +272,17 @@ enum mthp_stat_item {
 };

 struct mthp_stat {
-       unsigned long stats[0][__MTHP_STAT_COUNT];
+       unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT]=
;
 };

-extern struct mthp_stat __percpu *mthp_stats;
+DECLARE_PER_CPU(struct mthp_stat, mthp_stats);

 static inline void count_mthp_stat(int order, enum mthp_stat_item item)
 {
-       if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
+       if (order <=3D 0 || order > PMD_ORDER)
                return;

-       this_cpu_inc(mthp_stats->stats[order][item]);
-}
-
-static inline void count_mthp_stats(int order, enum mthp_stat_item
item, long delta)
-{
-       if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
-               return;
-
-       this_cpu_add(mthp_stats->stats[order][item], delta);
-}
-
-/*
- * Fold the foreign cpu mthp stats into our own.
- *
- * This is adding to the stats on one processor
- * but keeps the global counts constant.
- */
-static inline void mthp_stats_fold_cpu(int cpu)
-{
-       struct mthp_stat *fold_stat;
-       int i, j;
-
-       if (!mthp_stats)
-               return;
-       fold_stat =3D per_cpu_ptr(mthp_stats, cpu);
-       for (i =3D 1; i <=3D PMD_ORDER; i++) {
-               for (j =3D 0; j < __MTHP_STAT_COUNT; j++) {
-                       count_mthp_stats(i, j, fold_stat->stats[i][j]);
-                       fold_stat->stats[i][j] =3D 0;
-               }
-       }
+       this_cpu_inc(mthp_stats.stats[order][item]);
 }

 #define transparent_hugepage_use_zero_page()                           \
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21c4ac74b484..e88961ffc398 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -526,20 +526,18 @@ static const struct kobj_type thpsize_ktype =3D {
        .sysfs_ops =3D &kobj_sysfs_ops,
 };

-struct mthp_stat __percpu *mthp_stats;
+DEFINE_PER_CPU(struct mthp_stat, mthp_stats) =3D {{{0}}};

 static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
 {
        unsigned long sum =3D 0;
        int cpu;

-       cpus_read_lock();
-       for_each_online_cpu(cpu) {
-               struct mthp_stat *this =3D per_cpu_ptr(mthp_stats, cpu);
+       for_each_possible_cpu(cpu) {
+               struct mthp_stat *this =3D &per_cpu(mthp_stats, cpu);

                sum +=3D this->stats[order][item];
        }
-       cpus_read_unlock();

        return sum;
 }
@@ -741,11 +739,6 @@ static int __init hugepage_init(void)
         */
        MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);

-       mthp_stats =3D __alloc_percpu((PMD_ORDER + 1) *
sizeof(mthp_stats->stats[0]),
-                       sizeof(unsigned long));
-       if (!mthp_stats)
-               return -ENOMEM;
-
        err =3D hugepage_init_sysfs(&hugepage_kobj);
        if (err)
                goto err_sysfs;
@@ -780,8 +773,6 @@ static int __init hugepage_init(void)
 err_slab:
        hugepage_exit_sysfs(hugepage_kobj);
 err_sysfs:
-       free_percpu(mthp_stats);
-       mthp_stats =3D NULL;
        return err;
 }
 subsys_initcall(hugepage_init);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3135b5ca2457..b51becf03d1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5840,10 +5840,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
         */
        vm_events_fold_cpu(cpu);

-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-       mthp_stats_fold_cpu(cpu);
-#endif
-
        /*
         * Zero the differential counters of the dead processor
         * so that the vm statistics are consistent.


Thanks
Barry

