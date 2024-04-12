Return-Path: <linux-kernel+bounces-142430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634158A2B73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67166B21C99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8153818;
	Fri, 12 Apr 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP5yRG4C"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383E65380F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915015; cv=none; b=n8vt+RPa/Udx8wbrCwnUtEsZXtaE0m2Xb/mxDO6A8aujkjCrUzWfgl7M5yzI+gtVlNvad427DT7XSpRAQpHmWKBHIp6LVlD2lfRw39U6tVdHkGUOYHF9am82v8xWJOemC6wuRJGbOc3jxr1etCTPeZACscNpUByAGqVO/3dWdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915015; c=relaxed/simple;
	bh=LesXmNfIHeKMZ5MfIHS0mBdtJvZNYFJjEu59ET0/KIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRfFjFPFfCL9bZaOd1tFwSZSQxbjgXUB8mUnRzWUYC4PuYhTnVnSOqubEbIs8ZQGR4tGavQJXdMwEclZxhL8f0HJT9QHv0C4Fd6Yrt351HgkbE9o6o6LKJl1UFWoqvulhH4SE1z/FGs2/c5v2BT1cEAUUHaKlhJDcToMngOAGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP5yRG4C; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e618c51802so239609241.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915012; x=1713519812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N/psaTlBtE4ejH7nyl+e/9iBALPJhvNwmMr01wZTog=;
        b=KP5yRG4Cl/lOLpGpZ+bc6B+q/9KGaYw/2SI79KJKuXvA1jIiKuilg5JDlSdLbJSi5j
         RVR3a/Ov4+s0jdIKKkYIbceHUCCinZWU8BVe32pyXazsp+wS+4D++djUuPyiQvYBNz+3
         7ihKnLYLsLhshzqtR8aWsNVWTyG9hEW82X6Q0uDjWwZrOajCI5jyqQ+Chp745lNCpoG0
         Eyc2dL8MzScWHneWb0wQYH/xLVdl7AV496OHpN8Cmhv32JQZWrvCk1Xlr/xyj0FB0Ikp
         BNFx8I8CMnzdl09QpI2MpbrwO/2Eu19fDCd5pmpO6H24LpG9xDOeLHFoRZb1YufsFSVi
         LJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915012; x=1713519812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1N/psaTlBtE4ejH7nyl+e/9iBALPJhvNwmMr01wZTog=;
        b=JkgqUEKKbPrvbDNwDAJavQKVOtLO4o+10A5q5Ja9t71JUVrEjOHgIXH9ze1qDPUxGd
         DqkE7AULtYVJb7UHywngbMcj2agQb65k1L+FtHphPXS6geLk85KnrgunoN1TXN3TZgcV
         KIMSyIj1XT+Bv2E9x0A7XId0lFjlY1sNeiRI8jpjNqo5vxzUto/JyI2Cuz11Hk2P8PTW
         4ybX9iUfJc1Byop4ZFNji7isq9Z7dOeAYrg8bTofOZoVGrAED++WFBdYOk8tsLOxKnjO
         FUw6z6Tu4pBEjnEmVHi1YQu2g0bqc5JuQWIc2CnEEYky9WNbb2mTuCn73eb6Z6+n+AIe
         Y7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWP9o3x/yb39C1b80gIv57Xo24YAmGS3ypv0yIciaEZmktBBsCtRyFWoFA3kSPpQMBRB6mQvv8mCHbykZm+c6Bc5szRumaIPi9BOJ1G
X-Gm-Message-State: AOJu0YyI7QWYVqFZJHuFWKMlnE+CkPBzHlQRNFAGN6VGytyQoYmxNDQn
	87jxM2QiIzT9CjatCIStIwxdA/ID0kRI4T7KTIKQnjrTw+MDOrZAEOgBdIKeFWjZvsLLRT4Ec6g
	8p5d9MmcQkb/LEPpFGZfLfzLkw1A=
X-Google-Smtp-Source: AGHT+IEVkjyFyf++beVpi5qQuP98lqvfso3/zCZw3PF0vcTQEZmo2YIZUMUf4Z8M7auZjtK1lqb8oejto6EFEn5sVok=
X-Received: by 2002:a05:6122:7d1:b0:4d3:3446:6bc9 with SMTP id
 l17-20020a05612207d100b004d334466bc9mr2237944vkr.14.1712915011985; Fri, 12
 Apr 2024 02:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073740.294272-1-21cnbao@gmail.com> <20240412073740.294272-2-21cnbao@gmail.com>
 <ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com>
In-Reply-To: <ca73cbf1-8304-4790-a721-3c3a42f9d293@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 21:43:20 +1200
Message-ID: <CAGsJ_4xkRYBSF-8CrfpNpqwKACKSUyfLrwLHWuqqN+zFv29gZA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cerasuolodomenico@gmail.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, peterx@redhat.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, yosryahmed@google.com, 
	yuzhao@google.com, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:27=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Barry,
>
> 2 remaining comments - otherwise looks good. (same comments I just made i=
n the
> v4 conversation).
>
> On 12/04/2024 08:37, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Profiling a system blindly with mTHP has become challenging due to the
> > lack of visibility into its operations.  Presenting the success rate of
> > mTHP allocations appears to be pressing need.
> >
> > Recently, I've been experiencing significant difficulty debugging
> > performance improvements and regressions without these figures.  It's
> > crucial for us to understand the true effectiveness of mTHP in real-wor=
ld
> > scenarios, especially in systems with fragmented memory.
> >
> > This patch establishes the framework for per-order mTHP
> > counters. It begins by introducing the anon_fault_alloc and
> > anon_fault_fallback counters. Additionally, to maintain consistency
> > with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
> > anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> > Incorporating additional counters should now be straightforward as well=
.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Yu Zhao <yuzhao@google.com>
> > ---
> >  include/linux/huge_mm.h | 51 ++++++++++++++++++++++++++++++++++
> >  mm/huge_memory.c        | 61 +++++++++++++++++++++++++++++++++++++++++
> >  mm/memory.c             |  3 ++
> >  mm/page_alloc.c         |  4 +++
> >  4 files changed, 119 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index e896ca4760f6..c5beb54b97cb 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -264,6 +264,57 @@ unsigned long thp_vma_allowable_orders(struct vm_a=
rea_struct *vma,
> >                                         enforce_sysfs, orders);
> >  }
> >
> > +enum mthp_stat_item {
> > +     MTHP_STAT_ANON_FAULT_ALLOC,
> > +     MTHP_STAT_ANON_FAULT_FALLBACK,
> > +     MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > +     __MTHP_STAT_COUNT
> > +};
> > +
> > +struct mthp_stat {
> > +     unsigned long stats[0][__MTHP_STAT_COUNT];
> > +};
> > +
> > +extern struct mthp_stat __percpu *mthp_stats;
> > +
> > +static inline void count_mthp_stat(int order, enum mthp_stat_item item=
)
> > +{
> > +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> > +             return;
> > +
> > +     this_cpu_inc(mthp_stats->stats[order][item]);
> > +}
> > +
> > +static inline void count_mthp_stats(int order, enum mthp_stat_item ite=
m, long delta)
> > +{
> > +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> > +             return;
> > +
> > +     this_cpu_add(mthp_stats->stats[order][item], delta);
> > +}
> > +
> > +/*
> > + * Fold the foreign cpu mthp stats into our own.
> > + *
> > + * This is adding to the stats on one processor
> > + * but keeps the global counts constant.
> > + */
> > +static inline void mthp_stats_fold_cpu(int cpu)
> > +{
> > +     struct mthp_stat *fold_stat;
> > +     int i, j;
> > +
> > +     if (!mthp_stats)
> > +             return;
> > +     fold_stat =3D per_cpu_ptr(mthp_stats, cpu);
> > +     for (i =3D 1; i <=3D PMD_ORDER; i++) {
> > +             for (j =3D 0; j < __MTHP_STAT_COUNT; j++) {
> > +                     count_mthp_stats(i, j, fold_stat->stats[i][j]);
> > +                     fold_stat->stats[i][j] =3D 0;
> > +             }
> > +     }
> > +}
>
> This is a pretty horrible hack; I'm pretty sure just summing for all *pos=
sible*
> cpus should work.
>
> > +
> >  #define transparent_hugepage_use_zero_page()                         \
> >       (transparent_hugepage_flags &                                   \
> >        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index dc30139590e6..21c4ac74b484 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -526,6 +526,50 @@ static const struct kobj_type thpsize_ktype =3D {
> >       .sysfs_ops =3D &kobj_sysfs_ops,
> >  };
> >
> > +struct mthp_stat __percpu *mthp_stats;
> > +
> > +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item=
)
> > +{
> > +     unsigned long sum =3D 0;
> > +     int cpu;
> > +
> > +     cpus_read_lock();
> > +     for_each_online_cpu(cpu) {
> > +             struct mthp_stat *this =3D per_cpu_ptr(mthp_stats, cpu);
> > +
> > +             sum +=3D this->stats[order][item];
> > +     }
> > +     cpus_read_unlock();
> > +
> > +     return sum;
> > +}
> > +
> > +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                          =
       \
> > +static ssize_t _name##_show(struct kobject *kobj,                    \
> > +                     struct kobj_attribute *attr, char *buf)         \
> > +{                                                                    \
> > +     int order =3D to_thpsize(kobj)->order;                           =
 \
> > +                                                                     \
> > +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
> > +}                                                                    \
> > +static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
> > +
> > +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
> > +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBA=
CK);
> > +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT=
_FALLBACK_CHARGE);
> > +
> > +static struct attribute *stats_attrs[] =3D {
> > +     &anon_fault_alloc_attr.attr,
> > +     &anon_fault_fallback_attr.attr,
> > +     &anon_fault_fallback_charge_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group stats_attr_group =3D {
> > +     .name =3D "stats",
> > +     .attrs =3D stats_attrs,
> > +};
> > +
> >  static struct thpsize *thpsize_create(int order, struct kobject *paren=
t)
> >  {
> >       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> > @@ -549,6 +593,12 @@ static struct thpsize *thpsize_create(int order, s=
truct kobject *parent)
> >               return ERR_PTR(ret);
> >       }
> >
> > +     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> > +     if (ret) {
> > +             kobject_put(&thpsize->kobj);
> > +             return ERR_PTR(ret);
> > +     }
> > +
> >       thpsize->order =3D order;
> >       return thpsize;
> >  }
> > @@ -691,6 +741,11 @@ static int __init hugepage_init(void)
> >        */
> >       MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
> >
> > +     mthp_stats =3D __alloc_percpu((PMD_ORDER + 1) * sizeof(mthp_stats=
->stats[0]),
> > +                     sizeof(unsigned long));
>
> Personally I think it would be cleaner to allocate statically using
> ilog2(MAX_PTRS_PER_PTE) instead of PMD_ORDER.

Hi Ryan,

I don't understand why MAX_PTRS_PER_PTE is the correct size. For ARM64,

#define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)

#define MAX_PTRS_PER_PTE PTRS_PER_PTE

#define PTRS_PER_PTE            (1 << (PAGE_SHIFT - 3))

while PAGE_SIZE is 16KiB or 64KiB, PTRS_PER_PTE can be a huge number?


Am I missing something?

>
> > +     if (!mthp_stats)
> > +             return -ENOMEM;
> > +
> >       err =3D hugepage_init_sysfs(&hugepage_kobj);
> >       if (err)
> >               goto err_sysfs;
> > @@ -725,6 +780,8 @@ static int __init hugepage_init(void)
> >  err_slab:
> >       hugepage_exit_sysfs(hugepage_kobj);
> >  err_sysfs:
> > +     free_percpu(mthp_stats);
> > +     mthp_stats =3D NULL;
> >       return err;
> >  }
> >  subsys_initcall(hugepage_init);
> > @@ -880,6 +937,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(stru=
ct vm_fault *vmf,
> >               folio_put(folio);
> >               count_vm_event(THP_FAULT_FALLBACK);
> >               count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> > +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FAL=
LBACK);
> > +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FAL=
LBACK_CHARGE);
> >               return VM_FAULT_FALLBACK;
> >       }
> >       folio_throttle_swaprate(folio, gfp);
> > @@ -929,6 +988,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(stru=
ct vm_fault *vmf,
> >               mm_inc_nr_ptes(vma->vm_mm);
> >               spin_unlock(vmf->ptl);
> >               count_vm_event(THP_FAULT_ALLOC);
> > +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALL=
OC);
> >               count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> >       }
> >
> > @@ -1050,6 +1110,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_f=
ault *vmf)
> >       folio =3D vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true)=
;
> >       if (unlikely(!folio)) {
> >               count_vm_event(THP_FAULT_FALLBACK);
> > +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FAL=
LBACK);
> >               return VM_FAULT_FALLBACK;
> >       }
> >       return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 649a547fe8e3..06048af7cf9a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4368,6 +4368,7 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
> >               folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> >               if (folio) {
> >                       if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> > +                             count_mthp_stat(order, MTHP_STAT_ANON_FAU=
LT_FALLBACK_CHARGE);
> >                               folio_put(folio);
> >                               goto next;
> >                       }
> > @@ -4376,6 +4377,7 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
> >                       return folio;
> >               }
> >  next:
> > +             count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> >               order =3D next_order(&orders, order);
> >       }
> >
> > @@ -4485,6 +4487,7 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
> >
> >       folio_ref_add(folio, nr_pages - 1);
> >       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +     count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
> >       folio_add_new_anon_rmap(folio, vma, addr);
> >       folio_add_lru_vma(folio, vma);
> >  setpte:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b51becf03d1e..3135b5ca2457 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5840,6 +5840,10 @@ static int page_alloc_cpu_dead(unsigned int cpu)
> >        */
> >       vm_events_fold_cpu(cpu);
> >
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +     mthp_stats_fold_cpu(cpu);
> > +#endif
> > +
> >       /*
> >        * Zero the differential counters of the dead processor
> >        * so that the vm statistics are consistent.
>

