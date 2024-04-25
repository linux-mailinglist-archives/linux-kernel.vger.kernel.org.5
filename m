Return-Path: <linux-kernel+bounces-158986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38448B27D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C028284EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9E14EC65;
	Thu, 25 Apr 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOx7+N/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B314E2EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068128; cv=none; b=A070Jen9+ZWlFDhqp+hfBSOdeYEF4ledZfzZd/U0JgbCrmEqmbN8mzqzBT/siF67XIpfLmCjTZ/87Yd2pt1mRWDl0fTI4ro8jdi4mlOJZxYmM8r/aC5Mhc3/znXcT2cOL1mmC8liP5kaVFh1m4FA74a42GWcH7nN3nfaSI2Xr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068128; c=relaxed/simple;
	bh=iorbnfY9Y/+ae9TLaZeSRmf271UI1XmIWWIOy7sTx0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0V7loG9Tv3PW/3Tp/J+HPysP8AJ84EhCc8rZfWbzLFfTT82naHof07gWgV5OkghWh/UivMzsZNHoTmVT9O+nohrskSMKFyhaTM93VZEN2YK7OAHy0J3CgQl3XwQyx7Z9k4Q/5U3bZ6WiJ3VrRK/qDZLOXhnnhTAhvtkUkBHZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOx7+N/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045A8C2BBFC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714068128;
	bh=iorbnfY9Y/+ae9TLaZeSRmf271UI1XmIWWIOy7sTx0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rOx7+N/yEbuKWCEQJzQOzma4enkJ3hf0FFNfXITnehojoUeHcpO3Re94xryLyQv0b
	 jiTfZJ5Nd7ahn9krRvrXg+JSoyIetw3tRP8NB3guIGEE4ZLVUhD1v5sPCl1gma5KKy
	 jk5xW5QKqHYSZupuHFNs/UAlyXo3JFPdOsTUmwi5AgumCfKbSF0cTm1yRsH8ZJyECf
	 IHjFldIrsZXf7HYpWSbFIQz7YUZyl4pQRfV3o/fakuWkh+ORavAU1nMmNyxJCVGpJf
	 ZxZM0ZGIthbfSlaEcUY3QM7EJAW5peeSFp2HMeKYABrbiWxeWX6UQaklER0pLQWHYN
	 IdI2hhiGHy9WQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so15144891fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:02:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUikYcRkphkrPPhRa8e3vG5UjxUu4xWILafkuZ4o8Zkmn4S0YYOuWjEQTN2TUFbfggTsRjw2Z913exuqax336RZmkaZOOqikfffLjW1
X-Gm-Message-State: AOJu0YzheQ/QbBQ+qCCKkaGggtu5oDBc7f1Nz8i69cvrNybY658dW990
	i75gSdqDvDwv6k0PLyOMqiQvLlY1ksDwUotN7y3zf8cEUH0cxhsKFkCo5cihHH/KoIggixcA70J
	8WeA1frvNXjK6nxoLmyEkcGHkEw==
X-Google-Smtp-Source: AGHT+IE2kwUS69B1UfRWMAazsvvDMmMVdiDxtpSpK2E2ggTdHaZYg4oZcgE6cZvVc10FogJKErfnIbqlh0R8L4Hzgr4=
X-Received: by 2002:a2e:7214:0:b0:2d8:54b3:954b with SMTP id
 n20-20020a2e7214000000b002d854b3954bmr42676ljc.53.1714068126645; Thu, 25 Apr
 2024 11:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423051826.791934-1-shakeel.butt@linux.dev> <20240423051826.791934-2-shakeel.butt@linux.dev>
In-Reply-To: <20240423051826.791934-2-shakeel.butt@linux.dev>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Apr 2024 11:01:54 -0700
X-Gmail-Original-Message-ID: <CANeU7Qk5ZKB3+FcA68kJpoeR2BQ+Ybm+ADzLJ-UZ6veRaA3brg@mail.gmail.com>
Message-ID: <CANeU7Qk5ZKB3+FcA68kJpoeR2BQ+Ybm+ADzLJ-UZ6veRaA3brg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at start
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:19=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> At the moment the memcg stats are sized based on the size of enum
> node_stat_item but not all fields in node_stat_item corresponds to memcg
> stats. So, rearrage the contents of node_stat_item such that all the
> memcg specific stats are at the top and then the later patches will make
> sure that the memcg code will not waste space for non-memcg stats.

Is this patch meant to have no functional change other than the output orde=
r?
It would be better to clarify it in the commit message if that is the case.

Chris

>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/mmzone.h | 25 +++++++++++++------------
>  mm/vmstat.c            | 24 ++++++++++++------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8f9c9590a42c..989ca97402c6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -166,9 +166,6 @@ enum node_stat_item {
>         NR_UNEVICTABLE,         /*  "     "     "   "       "         */
>         NR_SLAB_RECLAIMABLE_B,
>         NR_SLAB_UNRECLAIMABLE_B,
> -       NR_ISOLATED_ANON,       /* Temporary isolated pages from anon lru=
 */
> -       NR_ISOLATED_FILE,       /* Temporary isolated pages from file lru=
 */
> -       WORKINGSET_NODES,
>         WORKINGSET_REFAULT_BASE,
>         WORKINGSET_REFAULT_ANON =3D WORKINGSET_REFAULT_BASE,
>         WORKINGSET_REFAULT_FILE,
> @@ -179,39 +176,43 @@ enum node_stat_item {
>         WORKINGSET_RESTORE_ANON =3D WORKINGSET_RESTORE_BASE,
>         WORKINGSET_RESTORE_FILE,
>         WORKINGSET_NODERECLAIM,
> +       NR_PAGETABLE,           /* used for pagetables */
> +       NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
> +       NR_KERNEL_STACK_KB,     /* measured in KiB */
>         NR_ANON_MAPPED, /* Mapped anonymous pages */
>         NR_FILE_MAPPED, /* pagecache pages mapped into pagetables.
>                            only modified from process context */
>         NR_FILE_PAGES,
> +#ifdef CONFIG_SWAP
> +       NR_SWAPCACHE,
> +#endif
>         NR_FILE_DIRTY,
>         NR_WRITEBACK,
> -       NR_WRITEBACK_TEMP,      /* Writeback using temporary buffers */
>         NR_SHMEM,               /* shmem pages (included tmpfs/GEM pages)=
 */
>         NR_SHMEM_THPS,
> -       NR_SHMEM_PMDMAPPED,
>         NR_FILE_THPS,
> -       NR_FILE_PMDMAPPED,
>         NR_ANON_THPS,
> +       /* No memcg stats for the following fields. */
> +       NR_SHMEM_PMDMAPPED,
> +       NR_FILE_PMDMAPPED,
> +       NR_WRITEBACK_TEMP,      /* Writeback using temporary buffers */
>         NR_VMSCAN_WRITE,
>         NR_VMSCAN_IMMEDIATE,    /* Prioritise for reclaim when writeback =
ends */
> +       NR_ISOLATED_ANON,       /* Temporary isolated pages from anon lru=
 */
> +       NR_ISOLATED_FILE,       /* Temporary isolated pages from file lru=
 */
> +       WORKINGSET_NODES,
>         NR_DIRTIED,             /* page dirtyings since bootup */
>         NR_WRITTEN,             /* page writings since bootup */
>         NR_THROTTLED_WRITTEN,   /* NR_WRITTEN while reclaim throttled */
>         NR_KERNEL_MISC_RECLAIMABLE,     /* reclaimable non-slab kernel pa=
ges */
>         NR_FOLL_PIN_ACQUIRED,   /* via: pin_user_page(), gup flag: FOLL_P=
IN */
>         NR_FOLL_PIN_RELEASED,   /* pages returned via unpin_user_page() *=
/
> -       NR_KERNEL_STACK_KB,     /* measured in KiB */
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>         NR_KERNEL_SCS_KB,       /* measured in KiB */
>  #endif
> -       NR_PAGETABLE,           /* used for pagetables */
> -       NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
>  #ifdef CONFIG_IOMMU_SUPPORT
>         NR_IOMMU_PAGES,         /* # of pages allocated by IOMMU */
>  #endif
> -#ifdef CONFIG_SWAP
> -       NR_SWAPCACHE,
> -#endif
>  #ifdef CONFIG_NUMA_BALANCING
>         PGPROMOTE_SUCCESS,      /* promote successfully */
>         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8507c497218b..4eac2f6322a3 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1206,9 +1206,6 @@ const char * const vmstat_text[] =3D {
>         "nr_unevictable",
>         "nr_slab_reclaimable",
>         "nr_slab_unreclaimable",
> -       "nr_isolated_anon",
> -       "nr_isolated_file",
> -       "workingset_nodes",
>         "workingset_refault_anon",
>         "workingset_refault_file",
>         "workingset_activate_anon",
> @@ -1216,38 +1213,41 @@ const char * const vmstat_text[] =3D {
>         "workingset_restore_anon",
>         "workingset_restore_file",
>         "workingset_nodereclaim",
> +       "nr_page_table_pages",
> +       "nr_sec_page_table_pages",
> +       "nr_kernel_stack",
>         "nr_anon_pages",
>         "nr_mapped",
>         "nr_file_pages",
> +#ifdef CONFIG_SWAP
> +       "nr_swapcached",
> +#endif
>         "nr_dirty",
>         "nr_writeback",
> -       "nr_writeback_temp",
>         "nr_shmem",
>         "nr_shmem_hugepages",
> -       "nr_shmem_pmdmapped",
>         "nr_file_hugepages",
> -       "nr_file_pmdmapped",
>         "nr_anon_transparent_hugepages",
> +       "nr_shmem_pmdmapped",
> +       "nr_file_pmdmapped",
> +       "nr_writeback_temp",
>         "nr_vmscan_write",
>         "nr_vmscan_immediate_reclaim",
> +       "nr_isolated_anon",
> +       "nr_isolated_file",
> +       "workingset_nodes",
>         "nr_dirtied",
>         "nr_written",
>         "nr_throttled_written",
>         "nr_kernel_misc_reclaimable",
>         "nr_foll_pin_acquired",
>         "nr_foll_pin_released",
> -       "nr_kernel_stack",
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
>         "nr_shadow_call_stack",
>  #endif
> -       "nr_page_table_pages",
> -       "nr_sec_page_table_pages",
>  #ifdef CONFIG_IOMMU_SUPPORT
>         "nr_iommu_pages",
>  #endif
> -#ifdef CONFIG_SWAP
> -       "nr_swapcached",
> -#endif
>  #ifdef CONFIG_NUMA_BALANCING
>         "pgpromote_success",
>         "pgpromote_candidate",
> --
> 2.43.0
>
>

