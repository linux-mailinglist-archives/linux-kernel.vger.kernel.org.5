Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916B97DED90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjKBHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:40:52 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC76102
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:40:47 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4a06fb5331bso266358e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698910846; x=1699515646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ph3j09bnh+uZ1O+kPvM1GO3R5uTUJ9fK51sd5Kmv/I=;
        b=kjAD1oC4ElfeutKmbi0fRISpQwdN5BvgIITaSKsVDkXB/KdHM0UuQGwry8bLx+Uuwn
         IDr3/hgCHyXOJGwQnpd2WheleLUUtDM2kGZXnmddJm5RBYvUHxx035rh5JeCOl28JV9h
         p5BPBmaNsuSGSq+CMSzQph8D6i7EQIT2KYSsa1oFOI6/pU3qYvbtR/hRGHRhNguImB9m
         iBKYdsli1GTxRUC90JUUxESE6sybM7ibuQZoRWS/06wgpafeTsTN6WcKoho3+7IHyPnv
         Ubi2fyH1h1hbyCtgL7dNM7c+Kzw6c8LDzpJDB1wR/Tlmor7XZ/X5ajbwOaDFcJ0CYBPr
         D/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698910846; x=1699515646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ph3j09bnh+uZ1O+kPvM1GO3R5uTUJ9fK51sd5Kmv/I=;
        b=saqieJAzKIoV0jJmdNDdUbP3KCGIlaamtNIpPLTF8SZvTk+1yN9s84teHPKQ8QMcwb
         XR9LOI739p/106WJ7GET3uRMjdKvv2N8Gir0kbKI8oCTQA3hImf0XJB/76j7EfCHhpZK
         pjt64Ox1b92TQl4spxWJQCf9IW8smcJteuqhZpUpKMn7n6F/lOBYVY6BN1lK1Awi7wY0
         Scri3aFD4jvYeE1txvjE7vsmNUw27Y3zx/NSWzgqXcS+xgMPIrQAITwKWi2l+baGTC62
         T5oVQcORw2wszfWDqwpWvVKQLq9dS0vlxJcSX5jkBEtPjCeA7mC00IUe8jVz49MMSlJX
         oqFQ==
X-Gm-Message-State: AOJu0YwD/q04UEG94eMT1KQtAEDp4m9y+b8vnb0ivDomrTPAEv2nIYsX
        K6H49P3ka0+4Ej3vIvEgzs6xFeGUkG/djHHgt8E=
X-Google-Smtp-Source: AGHT+IHCz4mcDPPDmSbtiqETadZdagkRo5r4vq7rQ8mQyKr5NLY5wIrP2RMtUqwj0HNGgk128+GB51h1Bzo71zmpn8w=
X-Received: by 2002:a67:c389:0:b0:457:cbdc:9d4d with SMTP id
 s9-20020a67c389000000b00457cbdc9d4dmr17869393vsj.16.1698910846146; Thu, 02
 Nov 2023 00:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20231025144546.577640-5-ryan.roberts@arm.com>
In-Reply-To: <20231025144546.577640-5-ryan.roberts@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 2 Nov 2023 15:40:34 +0800
Message-ID: <CAGsJ_4z=G03n7ETfG-dH0Pn3opybq9yByTENEB2ACR-ww6KoVw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> The upcoming anonymous small-sized THP feature enables performance
> improvements by allocating large folios for anonymous memory. However
> I've observed that on an arm64 system running a parallel workload (e.g.
> kernel compilation) across many cores, under high memory pressure, the
> speed regresses. This is due to bottlenecking on the increased number of
> TLBIs added due to all the extra folio splitting.
>
> Therefore, solve this regression by adding support for swapping out
> small-sized THP without needing to split the folio, just like is already
> done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
> enabled, and when the swap backing store is a non-rotating block device.
> These are the same constraints as for the existing PMD-sized THP
> swap-out support.

Hi Ryan,

We had a problem while enabling THP SWP on arm64,
commit d0637c505f8 ("arm64: enable THP_SWAP for arm64")

this means we have to depend on !system_supports_mte().
static inline bool arch_thp_swp_supported(void)
{
        return !system_supports_mte();
}

Do we have the same problem for small-sized THP? If yes, MTE has been
widely existing in various ARM64 SoC. Does it mean we should begin to fix
the issue now?


>
> Note that no attempt is made to swap-in THP here - this is still done
> page-by-page, like for PMD-sized THP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller falls back to splitting the folio and
> allocates individual entries (as per existing PMD-sized THP fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
> __scan_swap_map_try_ssd_cluster() is introduced to deal with arbitrary
> orders and scan_swap_map_try_ssd_cluster() is refactored as a wrapper
> for order-0.
>
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
>
> I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
> device as the swap device and from inside a memcg limited to 40G memory.
> I've then run `usemem` from vm-scalability with 70 processes (each has
> its own core), each allocating and writing 1G of memory. I've repeated
> everything 5 times and taken the mean:
>
> Mean Performance Improvement vs 4K/baseline
>
> | alloc size |            baseline |       + this series |
> |            |  v6.6-rc4+anonfolio |                     |
> |:-----------|--------------------:|--------------------:|
> | 4K Page    |                0.0% |                4.9% |
> | 64K THP    |              -44.1% |               10.7% |
> | 2M THP     |               56.0% |               65.9% |
>
> So with this change, the regression for 64K swap performance goes away
> and 4K and 2M swap improves slightly too.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  10 +--
>  mm/swapfile.c        | 149 +++++++++++++++++++++++++++++++------------
>  mm/vmscan.c          |  10 +--
>  3 files changed, 119 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0ca8aaa098ba..ccbca5db851b 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -295,11 +295,11 @@ struct swap_info_struct {
>         unsigned int __percpu *cluster_next_cpu; /*percpu index for next =
allocation */
>         unsigned int __percpu *cpu_next;/*
>                                          * Likely next allocation offset.=
 We
> -                                        * assign a cluster to each CPU, =
so each
> -                                        * CPU can allocate swap entry fr=
om its
> -                                        * own cluster and swapout sequen=
tially.
> -                                        * The purpose is to optimize swa=
pout
> -                                        * throughput.
> +                                        * assign a cluster per-order to =
each
> +                                        * CPU, so each CPU can allocate =
swap
> +                                        * entry from its own cluster and
> +                                        * swapout sequentially. The purp=
ose is
> +                                        * to optimize swapout throughput=
.
>                                          */
>         struct rb_root swap_extent_root;/* root of the swap extent rbtree=
 */
>         struct block_device *bdev;      /* swap device or bdev of swap fi=
le */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 94f7cc225eb9..b50bce50bed9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -545,10 +545,12 @@ static void free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>
>  /*
>   * The cluster corresponding to page_nr will be used. The cluster will b=
e
> - * removed from free cluster list and its usage counter will be increase=
d.
> + * removed from free cluster list and its usage counter will be increase=
d by
> + * count.
>   */
> -static void inc_cluster_info_page(struct swap_info_struct *p,
> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void add_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr,
> +       unsigned long count)
>  {
>         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
>
> @@ -557,9 +559,19 @@ static void inc_cluster_info_page(struct swap_info_s=
truct *p,
>         if (cluster_is_free(&cluster_info[idx]))
>                 alloc_cluster(p, idx);
>
> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) >=3D SWAPFILE_CLUSTER=
);
> +       VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CL=
USTER);
>         cluster_set_count(&cluster_info[idx],
> -               cluster_count(&cluster_info[idx]) + 1);
> +               cluster_count(&cluster_info[idx]) + count);
> +}
> +
> +/*
> + * The cluster corresponding to page_nr will be used. The cluster will b=
e
> + * removed from free cluster list and its usage counter will be increase=
d.
> + */
> +static void inc_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +{
> +       add_cluster_info_page(p, cluster_info, page_nr, 1);
>  }
>
>  /*
> @@ -588,8 +600,8 @@ static void dec_cluster_info_page(struct swap_info_st=
ruct *p,
>   * cluster list. Avoiding such abuse to avoid list corruption.
>   */
>  static bool
> -scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> -       unsigned long offset)
> +__scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> +       unsigned long offset, int order)
>  {
>         bool conflict;
>
> @@ -601,23 +613,36 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>         if (!conflict)
>                 return false;
>
> -       *this_cpu_ptr(si->cpu_next) =3D SWAP_NEXT_NULL;
> +       this_cpu_ptr(si->cpu_next)[order] =3D SWAP_NEXT_NULL;
>         return true;
>  }
>
>  /*
> - * Try to get a swap entry from current cpu's swap entry pool (a cluster=
). This
> - * might involve allocating a new cluster for current CPU too.
> + * It's possible scan_swap_map_slots() uses a free cluster in the middle=
 of free
> + * cluster list. Avoiding such abuse to avoid list corruption.
>   */
> -static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> -       unsigned long *offset, unsigned long *scan_base)
> +static bool
> +scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> +       unsigned long offset)
> +{
> +       return __scan_swap_map_ssd_cluster_conflict(si, offset, 0);
> +}
> +
> +/*
> + * Try to get a swap entry (or size indicated by order) from current cpu=
's swap
> + * entry pool (a cluster). This might involve allocating a new cluster f=
or
> + * current CPU too.
> + */
> +static bool __scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> +       unsigned long *offset, unsigned long *scan_base, int order)
>  {
>         struct swap_cluster_info *ci;
> -       unsigned int tmp, max;
> +       unsigned int tmp, max, i;
>         unsigned int *cpu_next;
> +       unsigned int nr_pages =3D 1 << order;
>
>  new_cluster:
> -       cpu_next =3D this_cpu_ptr(si->cpu_next);
> +       cpu_next =3D &this_cpu_ptr(si->cpu_next)[order];
>         tmp =3D *cpu_next;
>         if (tmp =3D=3D SWAP_NEXT_NULL) {
>                 if (!cluster_list_empty(&si->free_clusters)) {
> @@ -643,10 +668,12 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>          * reserve a new cluster.
>          */
>         ci =3D lock_cluster(si, tmp);
> -       if (si->swap_map[tmp]) {
> -               unlock_cluster(ci);
> -               *cpu_next =3D SWAP_NEXT_NULL;
> -               goto new_cluster;
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (si->swap_map[tmp + i]) {
> +                       unlock_cluster(ci);
> +                       *cpu_next =3D SWAP_NEXT_NULL;
> +                       goto new_cluster;
> +               }
>         }
>         unlock_cluster(ci);
>
> @@ -654,12 +681,22 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>         *scan_base =3D tmp;
>
>         max =3D ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;
> -       tmp +=3D 1;
> +       tmp +=3D nr_pages;
>         *cpu_next =3D tmp < max ? tmp : SWAP_NEXT_NULL;
>
>         return true;
>  }
>
> +/*
> + * Try to get a swap entry from current cpu's swap entry pool (a cluster=
). This
> + * might involve allocating a new cluster for current CPU too.
> + */
> +static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> +       unsigned long *offset, unsigned long *scan_base)
> +{
> +       return __scan_swap_map_try_ssd_cluster(si, offset, scan_base, 0);
> +}
> +
>  static void __del_from_avail_list(struct swap_info_struct *p)
>  {
>         int nid;
> @@ -982,35 +1019,58 @@ static int scan_swap_map_slots(struct swap_info_st=
ruct *si,
>         return n_ret;
>  }
>
> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *=
slot)
> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *sl=
ot,
> +                           unsigned int nr_pages)
>  {
> -       unsigned long idx;
>         struct swap_cluster_info *ci;
> -       unsigned long offset;
> +       unsigned long offset, scan_base;
> +       int order =3D ilog2(nr_pages);
> +       bool ret;
>
>         /*
> -        * Should not even be attempting cluster allocations when huge
> +        * Should not even be attempting large allocations when huge
>          * page swap is disabled.  Warn and fail the allocation.
>          */
> -       if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> +       if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +           nr_pages < 2 || nr_pages > SWAPFILE_CLUSTER ||
> +           !is_power_of_2(nr_pages)) {
>                 VM_WARN_ON_ONCE(1);
>                 return 0;
>         }
>
> -       if (cluster_list_empty(&si->free_clusters))
> +       /*
> +        * Swapfile is not block device or not using clusters so unable t=
o
> +        * allocate large entries.
> +        */
> +       if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
>                 return 0;
>
> -       idx =3D cluster_list_first(&si->free_clusters);
> -       offset =3D idx * SWAPFILE_CLUSTER;
> -       ci =3D lock_cluster(si, offset);
> -       alloc_cluster(si, idx);
> -       cluster_set_count(ci, SWAPFILE_CLUSTER);
> +again:
> +       /*
> +        * __scan_swap_map_try_ssd_cluster() may drop si->lock during dis=
card,
> +        * so indicate that we are scanning to synchronise with swapoff.
> +        */
> +       si->flags +=3D SWP_SCANNING;
> +       ret =3D __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, =
order);
> +       si->flags -=3D SWP_SCANNING;
> +
> +       /*
> +        * If we failed to allocate or if swapoff is waiting for us (due =
to lock
> +        * being dropped for discard above), return immediately.
> +        */
> +       if (!ret || !(si->flags & SWP_WRITEOK))
> +               return 0;
>
> -       memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
> +       if (__scan_swap_map_ssd_cluster_conflict(si, offset, order))
> +               goto again;
> +
> +       ci =3D lock_cluster(si, offset);
> +       memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
> +       add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>         unlock_cluster(ci);
> -       swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
> -       *slot =3D swp_entry(si->type, offset);
>
> +       swap_range_alloc(si, offset, nr_pages);
> +       *slot =3D swp_entry(si->type, offset);
>         return 1;
>  }
>
> @@ -1036,7 +1096,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entr=
ies[], int entry_size)
>         int node;
>
>         /* Only single cluster request supported */
> -       WARN_ON_ONCE(n_goal > 1 && size =3D=3D SWAPFILE_CLUSTER);
> +       WARN_ON_ONCE(n_goal > 1 && size > 1);
>
>         spin_lock(&swap_avail_lock);
>
> @@ -1073,14 +1133,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_en=
tries[], int entry_size)
>                         spin_unlock(&si->lock);
>                         goto nextsi;
>                 }
> -               if (size =3D=3D SWAPFILE_CLUSTER) {
> -                       if (si->flags & SWP_BLKDEV)
> -                               n_ret =3D swap_alloc_cluster(si, swp_entr=
ies);
> +               if (size > 1) {
> +                       n_ret =3D swap_alloc_large(si, swp_entries, size)=
;
>                 } else
>                         n_ret =3D scan_swap_map_slots(si, SWAP_HAS_CACHE,
>                                                     n_goal, swp_entries);
>                 spin_unlock(&si->lock);
> -               if (n_ret || size =3D=3D SWAPFILE_CLUSTER)
> +               if (n_ret || size > 1)
>                         goto check_out;
>                 cond_resched();
>
> @@ -3041,6 +3100,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         if (p->bdev && bdev_nonrot(p->bdev)) {
>                 int cpu;
>                 unsigned long ci, nr_cluster;
> +               int nr_order;
> +               int i;
>
>                 p->flags |=3D SWP_SOLIDSTATE;
>                 p->cluster_next_cpu =3D alloc_percpu(unsigned int);
> @@ -3068,13 +3129,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>                 for (ci =3D 0; ci < nr_cluster; ci++)
>                         spin_lock_init(&((cluster_info + ci)->lock));
>
> -               p->cpu_next =3D alloc_percpu(unsigned int);
> +               nr_order =3D IS_ENABLED(CONFIG_THP_SWAP) ? PMD_ORDER + 1 =
: 1;
> +               p->cpu_next =3D __alloc_percpu(sizeof(unsigned int) * nr_=
order,
> +                                            __alignof__(unsigned int));
>                 if (!p->cpu_next) {
>                         error =3D -ENOMEM;
>                         goto bad_swap_unlock_inode;
>                 }
> -               for_each_possible_cpu(cpu)
> -                       per_cpu(*p->cpu_next, cpu) =3D SWAP_NEXT_NULL;
> +               for_each_possible_cpu(cpu) {
> +                       unsigned int *cpu_next =3D per_cpu_ptr(p->cpu_nex=
t, cpu);
> +
> +                       for (i =3D 0; i < nr_order; i++)
> +                               cpu_next[i] =3D SWAP_NEXT_NULL;
> +               }
>         } else {
>                 atomic_inc(&nr_rotate_swap);
>                 inced_nr_rotate_swap =3D true;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2cc0cb41fb32..ea19710aa4cd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
>                                         if (!can_split_folio(folio, NULL)=
)
>                                                 goto activate_locked;
>                                         /*
> -                                        * Split folios without a PMD map=
 right
> -                                        * away. Chances are some or all =
of the
> -                                        * tail pages can be freed withou=
t IO.
> +                                        * Split PMD-mappable folios with=
out a
> +                                        * PMD map right away. Chances ar=
e some
> +                                        * or all of the tail pages can b=
e freed
> +                                        * without IO.
>                                          */
> -                                       if (!folio_entire_mapcount(folio)=
 &&
> +                                       if (folio_test_pmd_mappable(folio=
) &&
> +                                           !folio_entire_mapcount(folio)=
 &&
>                                             split_folio_to_list(folio,
>                                                                 folio_lis=
t))
>                                                 goto activate_locked;
> --
> 2.25.1
>

Thanks
Barry
