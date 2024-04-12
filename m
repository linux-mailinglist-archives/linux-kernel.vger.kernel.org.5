Return-Path: <linux-kernel+bounces-142480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3108A2C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505931F220A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382DD5381B;
	Fri, 12 Apr 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISxtYlZc"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF45535B7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917103; cv=none; b=eDQq+c21h7W0XaYRj57zhtLeYZrieuCG2xJwExB++2rvXZc4olegKffgEdUWi0167kop6xfNAe+jZ+w2Zc1HqpNwFvyehFalAYJEumjaj7uHlZBeWMPhFSNhDyBt33PDePo5LQDFoCr/gA/j4sT+WZn/IoZ0hTII26Xp0+AdQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917103; c=relaxed/simple;
	bh=4nzsRnMMkESnrE/ycvokpyT2gcLl6QCbaE2FCzfviIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5pIOXXBPDSF2gdhZEBjrhSsuTzHBVKRAHcpUX/k0IVGa0YxnfwDVCE5Ngx83MEHeU4tThnpVF37rnOzc7Ivgqy8R5i02r6urpEaIjwi8mYpq3zMlqJ/eY5mUy04ban4YWlO0Ba94giZszv2QBmgjWjA9IhQTEidjnHUZ2YtmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISxtYlZc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so796269b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917100; x=1713521900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=balnPClGS0lbieYNX5Ohm+y5qbZnkig8pTrKOraWhOc=;
        b=ISxtYlZcXw5071A71qRRj9dVd6Fs/aJc4QRelJBPgng7/PxXw1viaIMz2xP9Mxmllg
         2oP1Jk3UjL+dxnw8gULIrKmIwRt+zUfjmKz6hCSbUAPVONnX0ZsUyT4IiAMwPp0UoLyL
         gP5SRg+tyxxQzmcLMpSAmmblmQ/apwINlsIQ6REPSI9a6gYJjG82pCMlNOnUs/w2kEDZ
         Fw54tvKCIBsWC8C82zxO7Q8K2a26VFvFG4D28LOEHMwtgYOVimrO4bK7fTvNCSCeFUvO
         pRhku2fbgHE6cIUiNXn5C6qx7Zup2ddm9F1J/x6UlyOF/AZXFMbIwqLEjuOD2c0nZyyt
         26BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917100; x=1713521900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=balnPClGS0lbieYNX5Ohm+y5qbZnkig8pTrKOraWhOc=;
        b=Cv08nlzl9vN+zzexLA1Tdl6S/wxYaG2neEA4N28091/vUMT7xwBdU9y7NdKevwYw3C
         t1SqB66rKGdNhB+QOEU74XUQKRlp2vjUOXcs/gqqEDYMw3H+pais3gxBnCHllPpyMPxb
         YjWXVE+lO0kGeltpiKpsfGq53m4gE/BoMsit8aE+nC0I72IxfC0jFBn1W3vPlEqBR3uW
         xefk+1y7oeoqUwNVX7QynVY+O8HbLyXgAKKvJEzYXe5mwSBZJmNYQY5JSKRV5NHkcVR+
         1je+OcpKYaCmVfGVq3BX5RlZPW8QBwRx5FMyUaHcwO7/MvgbWO6DrzSxXkiVAEbnTTd/
         E5dA==
X-Forwarded-Encrypted: i=1; AJvYcCVhdHXdOloVdWfIWs0aeX3gHGY6NRSYB8UWT3p8sSmQN9Ay4iAztJtz/azY2GV1o8FwvGwxwnqCXiFadeCjXHM0nKKpNYlb+rCK0YCE
X-Gm-Message-State: AOJu0YwXfmayWy76O5+SHo/3y/U/EVtOSnLqiTj/VLTX/ncBMZfP7rPe
	v2AveAL+GQwqS1f+l9F9lDpBhGY+wA7nkylkKaL+Ef3ZHfNOvnAh
X-Google-Smtp-Source: AGHT+IHJ3J8TAbKRluPnxrgFqD0QGB2LfDRceiz9incexd91WsZnkN3zvr6WGbMXe+JpBFLU2yb1jg==
X-Received: by 2002:a05:6a20:100f:b0:1a3:a039:d11b with SMTP id gs15-20020a056a20100f00b001a3a039d11bmr2517458pzc.24.1712917099754;
        Fri, 12 Apr 2024 03:18:19 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id t24-20020a639558000000b005b7dd356f75sm2463819pgn.32.2024.04.12.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:18:19 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterx@redhat.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com
Subject: Re: [PATCH v5 1/4] mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters
Date: Fri, 12 Apr 2024 22:17:56 +1200
Message-Id: <20240412101756.296971-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f5d6e014-5d6b-441c-8379-252ff24e2260@arm.com>
References: <f5d6e014-5d6b-441c-8379-252ff24e2260@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Apr 12, 2024 at 9:56 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 12/04/2024 10:43, Barry Song wrote:
> > On Fri, Apr 12, 2024 at 9:27 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> Hi Barry,
> >>
> >> 2 remaining comments - otherwise looks good. (same comments I just made in the
> >> v4 conversation).
> >>
> >> On 12/04/2024 08:37, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Profiling a system blindly with mTHP has become challenging due to the
> >>> lack of visibility into its operations.  Presenting the success rate of
> >>> mTHP allocations appears to be pressing need.
> >>>
> >>> Recently, I've been experiencing significant difficulty debugging
> >>> performance improvements and regressions without these figures.  It's
> >>> crucial for us to understand the true effectiveness of mTHP in real-world
> >>> scenarios, especially in systems with fragmented memory.
> >>>
> >>> This patch establishes the framework for per-order mTHP
> >>> counters. It begins by introducing the anon_fault_alloc and
> >>> anon_fault_fallback counters. Additionally, to maintain consistency
> >>> with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
> >>> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> >>> Incorporating additional counters should now be straightforward as well.
> >>>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> Cc: Chris Li <chrisl@kernel.org>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >>> Cc: Kairui Song <kasong@tencent.com>
> >>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>> Cc: Suren Baghdasaryan <surenb@google.com>
> >>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>> Cc: Yu Zhao <yuzhao@google.com>
> >>> ---
> >>>  include/linux/huge_mm.h | 51 ++++++++++++++++++++++++++++++++++
> >>>  mm/huge_memory.c        | 61 +++++++++++++++++++++++++++++++++++++++++
> >>>  mm/memory.c             |  3 ++
> >>>  mm/page_alloc.c         |  4 +++
> >>>  4 files changed, 119 insertions(+)
> >>>
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index e896ca4760f6..c5beb54b97cb 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -264,6 +264,57 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
> >>>                                         enforce_sysfs, orders);
> >>>  }
> >>>
> >>> +enum mthp_stat_item {
> >>> +     MTHP_STAT_ANON_FAULT_ALLOC,
> >>> +     MTHP_STAT_ANON_FAULT_FALLBACK,
> >>> +     MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>> +     __MTHP_STAT_COUNT
> >>> +};
> >>> +
> >>> +struct mthp_stat {
> >>> +     unsigned long stats[0][__MTHP_STAT_COUNT];
> >>> +};
> >>> +
> >>> +extern struct mthp_stat __percpu *mthp_stats;
> >>> +
> >>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> >>> +{
> >>> +     if (order <= 0 || order > PMD_ORDER || !mthp_stats)
> >>> +             return;
> >>> +
> >>> +     this_cpu_inc(mthp_stats->stats[order][item]);
> >>> +}
> >>> +
> >>> +static inline void count_mthp_stats(int order, enum mthp_stat_item item, long delta)
> >>> +{
> >>> +     if (order <= 0 || order > PMD_ORDER || !mthp_stats)
> >>> +             return;
> >>> +
> >>> +     this_cpu_add(mthp_stats->stats[order][item], delta);
> >>> +}
> >>> +
> >>> +/*
> >>> + * Fold the foreign cpu mthp stats into our own.
> >>> + *
> >>> + * This is adding to the stats on one processor
> >>> + * but keeps the global counts constant.
> >>> + */
> >>> +static inline void mthp_stats_fold_cpu(int cpu)
> >>> +{
> >>> +     struct mthp_stat *fold_stat;
> >>> +     int i, j;
> >>> +
> >>> +     if (!mthp_stats)
> >>> +             return;
> >>> +     fold_stat = per_cpu_ptr(mthp_stats, cpu);
> >>> +     for (i = 1; i <= PMD_ORDER; i++) {
> >>> +             for (j = 0; j < __MTHP_STAT_COUNT; j++) {
> >>> +                     count_mthp_stats(i, j, fold_stat->stats[i][j]);
> >>> +                     fold_stat->stats[i][j] = 0;
> >>> +             }
> >>> +     }
> >>> +}
> >>
> >> This is a pretty horrible hack; I'm pretty sure just summing for all *possible*
> >> cpus should work.
> >>
> >>> +
> >>>  #define transparent_hugepage_use_zero_page()                         \
> >>>       (transparent_hugepage_flags &                                   \
> >>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index dc30139590e6..21c4ac74b484 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -526,6 +526,50 @@ static const struct kobj_type thpsize_ktype = {
> >>>       .sysfs_ops = &kobj_sysfs_ops,
> >>>  };
> >>>
> >>> +struct mthp_stat __percpu *mthp_stats;
> >>> +
> >>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
> >>> +{
> >>> +     unsigned long sum = 0;
> >>> +     int cpu;
> >>> +
> >>> +     cpus_read_lock();
> >>> +     for_each_online_cpu(cpu) {
> >>> +             struct mthp_stat *this = per_cpu_ptr(mthp_stats, cpu);
> >>> +
> >>> +             sum += this->stats[order][item];
> >>> +     }
> >>> +     cpus_read_unlock();
> >>> +
> >>> +     return sum;
> >>> +}
> >>> +
> >>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                                 \
> >>> +static ssize_t _name##_show(struct kobject *kobj,                    \
> >>> +                     struct kobj_attribute *attr, char *buf)         \
> >>> +{                                                                    \
> >>> +     int order = to_thpsize(kobj)->order;                            \
> >>> +                                                                     \
> >>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));  \
> >>> +}                                                                    \
> >>> +static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> >>> +
> >>> +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
> >>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
> >>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> >>> +
> >>> +static struct attribute *stats_attrs[] = {
> >>> +     &anon_fault_alloc_attr.attr,
> >>> +     &anon_fault_fallback_attr.attr,
> >>> +     &anon_fault_fallback_charge_attr.attr,
> >>> +     NULL,
> >>> +};
> >>> +
> >>> +static struct attribute_group stats_attr_group = {
> >>> +     .name = "stats",
> >>> +     .attrs = stats_attrs,
> >>> +};
> >>> +
> >>>  static struct thpsize *thpsize_create(int order, struct kobject *parent)
> >>>  {
> >>>       unsigned long size = (PAGE_SIZE << order) / SZ_1K;
> >>> @@ -549,6 +593,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
> >>>               return ERR_PTR(ret);
> >>>       }
> >>>
> >>> +     ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> >>> +     if (ret) {
> >>> +             kobject_put(&thpsize->kobj);
> >>> +             return ERR_PTR(ret);
> >>> +     }
> >>> +
> >>>       thpsize->order = order;
> >>>       return thpsize;
> >>>  }
> >>> @@ -691,6 +741,11 @@ static int __init hugepage_init(void)
> >>>        */
> >>>       MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
> >>>
> >>> +     mthp_stats = __alloc_percpu((PMD_ORDER + 1) * sizeof(mthp_stats->stats[0]),
> >>> +                     sizeof(unsigned long));
> >>
> >> Personally I think it would be cleaner to allocate statically using
> >> ilog2(MAX_PTRS_PER_PTE) instead of PMD_ORDER.
> >
> > Hi Ryan,
> >
> > I don't understand why MAX_PTRS_PER_PTE is the correct size. For ARM64,
> >
> > #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
> >
> > #define MAX_PTRS_PER_PTE PTRS_PER_PTE
> >
> > #define PTRS_PER_PTE            (1 << (PAGE_SHIFT - 3))
> >
> > while PAGE_SIZE is 16KiB or 64KiB, PTRS_PER_PTE can be a huge number?
> >
> >
> > Am I missing something?
>
> PTRS_PER_PTE is the number of PTE entries in a PTE table. On arm64 its as follows:
>
> PAGE_SIZE       PAGE_SHIFT      PTRS_PER_PTE
> 4K              12              512
> 16K             14              2048
> 64K             16              8192
>
> So (PTRS_PER_PTE * PAGE_SIZE) = PMD_SIZE
>
> PMD_ORDER is ilog2(PMD_SIZE / PAGE_SIZE) = ilog2(PTRS_PER_PTE)
>
> MAX_PTRS_PER_PTE is just the maximum value that PTRS_PER_PTE will ever have,
> (and its equal to PTRS_PER_PTE except for powerpc).
>
> Pretty sure the math is correct?

I am not convinced the math is correct :-)

while page size is 64KiB, the page table is as below,
PMD_ORDER = L2 index bits = [41:29] = 13 != ilog2(8192)


+--------+--------+--------+--------+--------+--------+--------+--------+
|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
+--------+--------+--------+--------+--------+--------+--------+--------+
 |                 |    |               |              |
 |                 |    |               |              v
 |                 |    |               |            [15:0]  in-page offset
 |                 |    |               +----------> [28:16] L3 index
 |                 |    +--------------------------> [41:29] L2 index
 |                 +-------------------------------> [47:42] L1 index (48-bit)
 |                                                   [51:42] L1 index (52-bit)
 +-------------------------------------------------> [63] TTBR0/1
 
while page size is 4KiB, the page table is as below,

+--------+--------+--------+--------+--------+--------+--------+--------+
|63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      0|
+--------+--------+--------+--------+--------+--------+--------+--------+
 |                 |         |         |         |         |
 |                 |         |         |         |         v
 |                 |         |         |         |   [11:0]  in-page offset
 |                 |         |         |         +-> [20:12] L3 index
 |                 |         |         +-----------> [29:21] L2 index
 |                 |         +---------------------> [38:30] L1 index
 |                 +-------------------------------> [47:39] L0 index
 +-------------------------------------------------> [63] TTBR0/1

PMD_ORDER = L2 index bits = [29:21] = 9 = ilog2(512).

You are only correct while page size = 4KiB.



 

