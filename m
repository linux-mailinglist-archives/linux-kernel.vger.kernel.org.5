Return-Path: <linux-kernel+bounces-164518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA18B7E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A6C282CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7817F385;
	Tue, 30 Apr 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i06Boxdj"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1901369AC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498265; cv=none; b=jq0/MmBTvTRYUd52wVr1dMiHOcnz8U2AppPFbdhpKchtubzk7f4fVj83uaByAOO9DvFUretdJJIcsigyYhE6rLo6QtHKIqZcMEqPHXM+jsg26+8CSjH+qkJq3RI35fWMTPZ4JTfcRDSQ+4W6aUp5FOCdBdgRzD97Jl9EaEK2j/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498265; c=relaxed/simple;
	bh=WQOvdWBvpZS3qhrRb+L/4Cin+bT+LFrVUMZOjWtRckI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VS4xkvjfcjIJmbB0Mh3kav8HNUPpC+4VzWX8KdSW0p6q1J2ycG85/zdOKfzgwlBL+Wih9k8MiT3guUv0AjkaNFGGMF0xa36eOJlFc+uFFUTh+JZfsXJLUTZkngKT6wqbEnIQ2aWT9jdbbCjDv4ZAFxW18t/XZE1ZSJVGcHbIEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i06Boxdj; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de462f3d992so6502072276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498263; x=1715103063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmwzhH0n2boBZ8Tjjq/sRiI789WbpPcUksWgg+R34aI=;
        b=i06BoxdjJDvgNyo3jORbCDhBTuxT5zGYmqByWwV72oB8R+nm+ObDBGJFthyGuxzFQ9
         rzxoWqp4sAhVYyMCg37PimifTkPAs7NvO1errwVefwe6aG0ZuuggnlbIbwid/Ad/qYOR
         25KIm41ixsxhmz3o9LXC96rDZAxPF3/B8ayeXCFLw67sLB77mHSXEDgALrSILBIoeSdO
         3g//+qs95Sg82X75sYKmslGUMaQzUoeod88SqxKnZScnzGbCT1LSTY8XRUMRgEmSIGXe
         Owjk4lnr1a/+bXnnpXBINjH+nzDprU5B98vIGycS38dBfwncL7T9pQk2eSnWCb0wlLW/
         zO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498263; x=1715103063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmwzhH0n2boBZ8Tjjq/sRiI789WbpPcUksWgg+R34aI=;
        b=SjCM9v/bWLSrrT4x+AGa7J10Rnea7jxqYFYtumjxCwuDO/2nKT8LHP1HOV5z4kW8Dk
         FsGai3rNLi5efKYkJe71OxrxBQkHrjA8QDuL5dhF0DAUlMawAkPY4lBE3/hrJK9Ekw+t
         /rPOT1qSXvJHIBSj55k+gh4sxFge815Xrq47Pk2rygjHfb78A2ETr/y8GqZWA+4ZrD5p
         QEgWNt60Y/OPpL4HxMm7Ym5Hki9PXpcfT/fk+jUdTw8UxrWAzy2/5kNgN78VER1uKKFp
         0CFIgl/0pFWG4TvlpIGoIS2gkcxao2Kasi/NFPX/zFezbzQk1vUBeeZbbpFrPlgOMUoa
         CCng==
X-Forwarded-Encrypted: i=1; AJvYcCX6AHA7xN1bCONgLXebpKxw9m9FMXZKkAU2pfSAGjN1W7QDlJiciWKWZU8cwX3B8u6EA5ryPPliJqRpRNKiQPJdqRX6pSKWImW+TwGT
X-Gm-Message-State: AOJu0Yw8o6SHog97GZ5F70nBLTK7KMwVI41ozXzyTDruF0SD95uiQVhO
	QJe0s1jUN+cNFX6fTyxtfDnl3QSMKIotVe9lwu1LsCJoj/tCKWQbQWneyFevmi69m58SFTXDK07
	5nDMY4B7NyQ3D5MCXrUgyTvnw2mUI7RLCv4tr
X-Google-Smtp-Source: AGHT+IE5zlQ8yc0MU0P9kDDeu/SpC3jhvH27ySpK6YbvqZusw9NvI2J/OR4zxes8l0lNTxBSunLIa4tGtevLUJjeMmY=
X-Received: by 2002:a25:8688:0:b0:de4:5e5c:5efe with SMTP id
 z8-20020a258688000000b00de45e5c5efemr224979ybk.47.1714498262595; Tue, 30 Apr
 2024 10:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-5-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:30:51 -0700
Message-ID: <CABdmKX0jGpZ4VSvQrLDB9ntLEb-tJTWFEfVLC5ukkZDi1CK2yQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> At the moment, the amount of memory allocated for stats related structs
> in the mem_cgroup corresponds to the size of enum node_stat_item.
> However not all fields in enum node_stat_item has corresponding memcg

typo: "have corresponding"

> stats. So, let's use indirection mechanism similar to the one used for
> memcg vmstats management.
>
> For a given x86_64 config, the size of stats with and without patch is:
>
> structs size in bytes         w/o     with
>
> struct lruvec_stats           1128     648
> struct lruvec_stats_percpu     752     432
> struct memcg_vmstats          1832    1352
> struct memcg_vmstats_percpu   1280     960
>
> The memory savings is further compounded by the fact that these structs
> are allocated for each cpu and for each node. To be precise, for each
> memcg the memory saved would be:
>
> Memory saved =3D ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODS * NR_CPUS) +

typo: "NR_NODES"

>                (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)
>
> Where 21 is the number of fields eliminated.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>
> Changes since v2:
> - N/A
>
>  mm/memcontrol.c | 138 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 115 insertions(+), 23 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 434cff91b65e..f424c5b2ba9b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -576,35 +576,105 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgro=
up_tree_per_node *mctz)
>         return mz;
>  }
>
> +/* Subset of node_stat_item for memcg stats */
> +static const unsigned int memcg_node_stat_items[] =3D {
> +       NR_INACTIVE_ANON,
> +       NR_ACTIVE_ANON,
> +       NR_INACTIVE_FILE,
> +       NR_ACTIVE_FILE,
> +       NR_UNEVICTABLE,
> +       NR_SLAB_RECLAIMABLE_B,
> +       NR_SLAB_UNRECLAIMABLE_B,
> +       WORKINGSET_REFAULT_ANON,
> +       WORKINGSET_REFAULT_FILE,
> +       WORKINGSET_ACTIVATE_ANON,
> +       WORKINGSET_ACTIVATE_FILE,
> +       WORKINGSET_RESTORE_ANON,
> +       WORKINGSET_RESTORE_FILE,
> +       WORKINGSET_NODERECLAIM,
> +       NR_ANON_MAPPED,
> +       NR_FILE_MAPPED,
> +       NR_FILE_PAGES,
> +       NR_FILE_DIRTY,
> +       NR_WRITEBACK,
> +       NR_SHMEM,
> +       NR_SHMEM_THPS,
> +       NR_FILE_THPS,
> +       NR_ANON_THPS,
> +       NR_KERNEL_STACK_KB,
> +       NR_PAGETABLE,
> +       NR_SECONDARY_PAGETABLE,
> +#ifdef CONFIG_SWAP
> +       NR_SWAPCACHE,
> +#endif
> +};
> +
> +static const unsigned int memcg_stat_items[] =3D {
> +       MEMCG_SWAP,
> +       MEMCG_SOCK,
> +       MEMCG_PERCPU_B,
> +       MEMCG_VMALLOC,
> +       MEMCG_KMEM,
> +       MEMCG_ZSWAP_B,
> +       MEMCG_ZSWAPPED,
> +};
> +
> +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(memcg_stat=
_items))
> +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostly;
> +
> +static void init_memcg_stats(void)
> +{
> +       int8_t i, j =3D 0;
> +
> +       /* Switch to short once this failure occurs. */
> +       BUILD_BUG_ON(NR_MEMCG_STATS >=3D 127 /* INT8_MAX */);
> +
> +       for (i =3D 0; i < NR_MEMCG_NODE_STAT_ITEMS; ++i)
> +               mem_cgroup_stats_index[memcg_node_stat_items[i]] =3D ++j;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(memcg_stat_items); ++i)
> +               mem_cgroup_stats_index[memcg_stat_items[i]] =3D ++j;
> +}
> +
> +static inline int memcg_stats_index(int idx)
> +{
> +       return mem_cgroup_stats_index[idx] - 1;

Could this just be: return mem_cgroup_stats_index[idx];
with a postfix increment of j in init_memcg_stats instead of prefix increme=
nt?


> +}
> +
>  struct lruvec_stats_percpu {
>         /* Local (CPU and cgroup) state */
> -       long state[NR_VM_NODE_STAT_ITEMS];
> +       long state[NR_MEMCG_NODE_STAT_ITEMS];
>
>         /* Delta calculation for lockless upward propagation */
> -       long state_prev[NR_VM_NODE_STAT_ITEMS];
> +       long state_prev[NR_MEMCG_NODE_STAT_ITEMS];
>  };
>
>  struct lruvec_stats {
>         /* Aggregated (CPU and subtree) state */
> -       long state[NR_VM_NODE_STAT_ITEMS];
> +       long state[NR_MEMCG_NODE_STAT_ITEMS];
>
>         /* Non-hierarchical (CPU aggregated) state */
> -       long state_local[NR_VM_NODE_STAT_ITEMS];
> +       long state_local[NR_MEMCG_NODE_STAT_ITEMS];
>
>         /* Pending child counts during tree propagation */
> -       long state_pending[NR_VM_NODE_STAT_ITEMS];
> +       long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
>  };
>
>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_it=
em idx)
>  {
>         struct mem_cgroup_per_node *pn;
> -       long x;
> +       long x =3D 0;
> +       int i;
>
>         if (mem_cgroup_disabled())
>                 return node_page_state(lruvec_pgdat(lruvec), idx);
>
> -       pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       x =3D READ_ONCE(pn->lruvec_stats->state[idx]);
> +       i =3D memcg_stats_index(idx);
> +       if (i >=3D 0) {
> +               pn =3D container_of(lruvec, struct mem_cgroup_per_node, l=
ruvec);
> +               x =3D READ_ONCE(pn->lruvec_stats->state[i]);
> +       }
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -617,12 +687,16 @@ unsigned long lruvec_page_state_local(struct lruvec=
 *lruvec,
>  {
>         struct mem_cgroup_per_node *pn;
>         long x =3D 0;
> +       int i;
>
>         if (mem_cgroup_disabled())
>                 return node_page_state(lruvec_pgdat(lruvec), idx);
>
> -       pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -       x =3D READ_ONCE(pn->lruvec_stats->state_local[idx]);
> +       i =3D memcg_stats_index(idx);
> +       if (i >=3D 0) {
> +               pn =3D container_of(lruvec, struct mem_cgroup_per_node, l=
ruvec);
> +               x =3D READ_ONCE(pn->lruvec_stats->state_local[i]);
> +       }
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -689,11 +763,11 @@ struct memcg_vmstats_percpu {
>         /* The above should fit a single cacheline for memcg_rstat_update=
d() */
>
>         /* Local (CPU and cgroup) page state & events */
> -       long                    state[MEMCG_NR_STAT];
> +       long                    state[NR_MEMCG_STATS];
>         unsigned long           events[NR_MEMCG_EVENTS];
>
>         /* Delta calculation for lockless upward propagation */
> -       long                    state_prev[MEMCG_NR_STAT];
> +       long                    state_prev[NR_MEMCG_STATS];
>         unsigned long           events_prev[NR_MEMCG_EVENTS];
>
>         /* Cgroup1: threshold notifications & softlimit tree updates */
> @@ -703,15 +777,15 @@ struct memcg_vmstats_percpu {
>
>  struct memcg_vmstats {
>         /* Aggregated (CPU and subtree) page state & events */
> -       long                    state[MEMCG_NR_STAT];
> +       long                    state[NR_MEMCG_STATS];
>         unsigned long           events[NR_MEMCG_EVENTS];
>
>         /* Non-hierarchical (CPU aggregated) page state & events */
> -       long                    state_local[MEMCG_NR_STAT];
> +       long                    state_local[NR_MEMCG_STATS];
>         unsigned long           events_local[NR_MEMCG_EVENTS];
>
>         /* Pending child counts during tree propagation */
> -       long                    state_pending[MEMCG_NR_STAT];
> +       long                    state_pending[NR_MEMCG_STATS];
>         unsigned long           events_pending[NR_MEMCG_EVENTS];
>
>         /* Stats updates since the last flush */
> @@ -844,7 +918,13 @@ static void flush_memcg_stats_dwork(struct work_stru=
ct *w)
>
>  unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
> -       long x =3D READ_ONCE(memcg->vmstats->state[idx]);
> +       long x;
> +       int i =3D memcg_stats_index(idx);
> +
> +       if (i < 0)
> +               return 0;
> +
> +       x =3D READ_ONCE(memcg->vmstats->state[i]);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -876,18 +956,25 @@ static int memcg_state_val_in_pages(int idx, int va=
l)
>   */
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  {
> -       if (mem_cgroup_disabled())
> +       int i =3D memcg_stats_index(idx);
> +
> +       if (mem_cgroup_disabled() || i < 0)
>                 return;
>
> -       __this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> +       __this_cpu_add(memcg->vmstats_percpu->state[i], val);
>         memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
>  }
>
>  /* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, in=
t idx)
>  {
> -       long x =3D READ_ONCE(memcg->vmstats->state_local[idx]);
> +       long x;
> +       int i =3D memcg_stats_index(idx);
> +
> +       if (i < 0)
> +               return 0;
>
> +       x =3D READ_ONCE(memcg->vmstats->state_local[i]);
>  #ifdef CONFIG_SMP
>         if (x < 0)
>                 x =3D 0;
> @@ -901,6 +988,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *=
lruvec,
>  {
>         struct mem_cgroup_per_node *pn;
>         struct mem_cgroup *memcg;
> +       int i =3D memcg_stats_index(idx);
> +
> +       if (i < 0)
> +               return;
>
>         pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>         memcg =3D pn->memcg;
> @@ -930,10 +1021,10 @@ static void __mod_memcg_lruvec_state(struct lruvec=
 *lruvec,
>         }
>
>         /* Update memcg */
> -       __this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> +       __this_cpu_add(memcg->vmstats_percpu->state[i], val);
>
>         /* Update lruvec */
> -       __this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
> +       __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
>
>         memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
>         memcg_stats_unlock();
> @@ -5702,6 +5793,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *pa=
rent_css)
>                 page_counter_init(&memcg->kmem, &parent->kmem);
>                 page_counter_init(&memcg->tcpmem, &parent->tcpmem);
>         } else {
> +               init_memcg_stats();
>                 init_memcg_events();
>                 page_counter_init(&memcg->memory, NULL);
>                 page_counter_init(&memcg->swap, NULL);
> @@ -5873,7 +5965,7 @@ static void mem_cgroup_css_rstat_flush(struct cgrou=
p_subsys_state *css, int cpu)
>
>         statc =3D per_cpu_ptr(memcg->vmstats_percpu, cpu);
>
> -       for (i =3D 0; i < MEMCG_NR_STAT; i++) {
> +       for (i =3D 0; i < NR_MEMCG_STATS; i++) {
>                 /*
>                  * Collect the aggregated propagation counts of groups
>                  * below us. We're in a per-cpu loop here and this is
> @@ -5937,7 +6029,7 @@ static void mem_cgroup_css_rstat_flush(struct cgrou=
p_subsys_state *css, int cpu)
>
>                 lstatc =3D per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
>
> -               for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> +               for (i =3D 0; i < NR_MEMCG_NODE_STAT_ITEMS; i++) {
>                         delta =3D lstats->state_pending[i];
>                         if (delta)
>                                 lstats->state_pending[i] =3D 0;
> --
> 2.43.0
>

