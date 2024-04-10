Return-Path: <linux-kernel+bounces-139227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9508A0019
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D17B2899CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288417BB11;
	Wed, 10 Apr 2024 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bY5Q34+J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67C63E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775349; cv=none; b=kisyC1kUa2MI8IZJY4SCGjTobJ8QmEKxI6SA0sE2ZEl2yKWYoE+dRWbCyezC/t1fiW92zQ9iCDLYcf0Lr5d7cUsAwdNW8EAIHI+GBrmgXlYysh48WoyzzOYwTwNoHLaMwZlTO8GhOSwvOBRDAOAf+a4fLgkO2wNcpQykJp3G6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775349; c=relaxed/simple;
	bh=J991FT9jfRVYTUbgaIe7oj26wpuEPNq1SqOjrjc0wQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VoQehGa42t4s/FemG5PU21chY/sUrThyTkPKNpnZmxfeXRYg+Z4c5YLOdLJF+I2LanKz8PYIlLM4kbBh9u9CBDfQedXyD8UkRxgu8ClHMiezT/5vMNbwe0lJm78XaSEkaGnoT5Rxob2oMthU3YhfZRazoV8you0TulGfaBWr0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bY5Q34+J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712775348; x=1744311348;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J991FT9jfRVYTUbgaIe7oj26wpuEPNq1SqOjrjc0wQA=;
  b=bY5Q34+J+X+MKkUPHp7sySVPeNBwGpV4iLdzOQn9sGR30gPWYsnqvpaE
   JdK3uDd/0Lq85Q9lQOE+PJQXYh3Z0Q30Pjz7pIx5NoSy5Ds3qfSnZHfMl
   dHjrJ/S0bh2zPxYe9CxD82CvXUQ75hNFKovHhM2QSwOy56mKernz8sW4E
   q8z5z31i12G6VE27fta3ZHGBWKHK3EWaQtH5dvqSuNZfATtCJ1cFHGm31
   VUxbZZQuL1c5wHcIaV9RP9L9ZInOeOJWHSAEdqMBcfdtWMf4d4bnX3iQk
   3X6gt6YfWezn5SXnkNo1ubG+p6AMtSFdaRcVHin0I+AVVcTadvfF2xgWa
   A==;
X-CSE-ConnectionGUID: +tw1RXUIRwSWZ7fxV5nzVQ==
X-CSE-MsgGUID: kvP++Yf6RlqS1nQPEatvvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8289707"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8289707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:55:46 -0700
X-CSE-ConnectionGUID: mqg2BM3xSUeGkesDmyF6sQ==
X-CSE-MsgGUID: V8yCf90lSsqaGZINY2GqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25137609"
Received: from sgollapu-mobl.amr.corp.intel.com (HELO [10.209.38.205]) ([10.209.38.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 11:55:44 -0700
Message-ID: <801a0a7015137a7ef573e2cdd69dca019f328da7.camel@linux.intel.com>
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>, akpm@linux-foundation.org,
  ryncsn@gmail.com, nphamcs@gmail.com
Cc: ying.huang@intel.com, songmuchun@bytedance.com, david@redhat.com, 
	chrisl@kernel.org, guo.ziliang@zte.com.cn, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 10 Apr 2024 11:55:43 -0700
In-Reply-To: <20240408121439.GA252652@bytedance>
References: <20240408121439.GA252652@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 20:14 +0800, Zhaoyu Liu wrote:
> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
> Create 1G anon mmap and set it to shared, and has two processes
> randomly access the shared memory. When they are racing on swap cache,
> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
> took about 1475 us.
>=20
> So skip page allocation if SWAP_HAS_CACHE was set, just
> schedule_timeout_uninterruptible and continue to acquire page
> via filemap_get_folio() from swap cache, to speedup
> __read_swap_cache_async.
>=20
> Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
> ---
> Changes in v2:
>   - Fix the patch format and rebase to latest linux-next.
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/swap_state.c      | 10 ++++++++++
>  mm/swapfile.c        | 15 +++++++++++++++
>  3 files changed, 31 insertions(+)
>=20
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..a374070e05a7 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -492,6 +492,7 @@ extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);
>  extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry=
);
>  extern int swp_swapcount(swp_entry_t entry);
> +extern bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entr=
y);
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry);
>  struct backing_dev_info;
>  extern int init_swap_address_space(unsigned int type, unsigned long nr_p=
ages);
> @@ -583,6 +584,11 @@ static inline int swp_swapcount(swp_entry_t entry)
>  	return 0;
>  }
> =20
> +static inline bool swap_has_cache(struct swap_info_struct *si, swp_entry=
_t entry)
> +{
> +	return false;
> +}
> +
>  static inline swp_entry_t folio_alloc_swap(struct folio *folio)
>  {
>  	swp_entry_t entry;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 642c30d8376c..f117fbf18b59 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -462,6 +462,15 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
>  		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
>  			goto fail_put_swap;
> =20
> +		/*
> +		 * Skipping page allocation if SWAP_HAS_CACHE was set,
> +		 * just schedule_timeout_uninterruptible and continue to
> +		 * acquire page via filemap_get_folio() from swap cache,
> +		 * to speedup __read_swap_cache_async.
> +		 */
> +		if (swap_has_cache(si, entry))
> +			goto skip_alloc;
> +

I think most of the cases where a page already exists will be caught by
filemap_get_folio().  The cases caught by this extra check should be when w=
e have races
between page cache update and the read async, which may not be that
often.  So please verify with benchmark that this extra check with its
own overhead would buy us anything.

Tim

>  		/*
>  		 * Get a new folio to read into from swap.  Allocate it now,
>  		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
> @@ -483,6 +492,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>  		if (err !=3D -EEXIST)
>  			goto fail_put_swap;
> =20
> +skip_alloc:
>  		/*
>  		 * Protect against a recursive call to __read_swap_cache_async()
>  		 * on the same entry waiting forever here because SWAP_HAS_CACHE
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3ee8957a46e6..b016ebc43b0d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1511,6 +1511,21 @@ int swp_swapcount(swp_entry_t entry)
>  	return count;
>  }
> =20
> +/*
> + * Verify that a swap entry has been tagged with SWAP_HAS_CACHE
> + */
> +bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +	pgoff_t offset =3D swp_offset(entry);
> +	struct swap_cluster_info *ci;
> +	bool has_cache;
> +
> +	ci =3D lock_cluster_or_swap_info(si, offset);
> +	has_cache =3D !!(si->swap_map[offset] & SWAP_HAS_CACHE);
> +	unlock_cluster_or_swap_info(si, ci);
> +	return has_cache;
> +}
> +
>  static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
>  					 swp_entry_t entry,
>  					 unsigned int nr_pages)


