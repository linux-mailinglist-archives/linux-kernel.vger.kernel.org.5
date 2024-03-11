Return-Path: <linux-kernel+bounces-99439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AE87885D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E3DB23621
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC465677F;
	Mon, 11 Mar 2024 18:51:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185AD56751
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183090; cv=none; b=W6zcXSt5SeU3eCGM0feNTqRkaw98rJZzoQvjlmDfIwGKyCbLdxOvZNe6rsNxiREdLdE/dJbbgEZRKE/145TmJzo5tBsOCjq2davQRPa2hv1ipHc3RpPC79XU9Elu7TQ3/4xNROgO6fspRvmrpFftB9PhEEDjrG0eLniZejU/3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183090; c=relaxed/simple;
	bh=L3czb4yKVFTuEdeekbnrd39IUTZN8nT4xpst5WMpWtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNk4Wu0PVWWD6qQEIDuAMtQFXc3FPRJclybi45ctuBrbh79ZevBHHUW78X85cmcucLeiXTZgWp+xISx7IyBV5IB39e/MOHhq3C2IhmHzVOJyw0eqIn9sUcJ8ShsOMy3uOlWR31AlFmB+iFMi3CbYzcLcXVsCtVn0g3EakJvaZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C48FEC;
	Mon, 11 Mar 2024 11:52:04 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D730F3F64C;
	Mon, 11 Mar 2024 11:51:22 -0700 (PDT)
Message-ID: <499a60c6-eeb8-4bbd-8563-9717c0d2e43d@arm.com>
Date: Mon, 11 Mar 2024 18:51:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched
 swap_free()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Chuanhua Han
 <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240304081348.197341-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 08:13, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2955f7a78d8d..d6ab27929458 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_nr_free(swp_entry_t entry, int nr_pages);

nit: In my swap-out v4 series, I've created a batched version of
free_swap_and_cache() and called it free_swap_and_cache_nr(). Perhaps it is
preferable to align the naming schemes - i.e. call this swap_free_nr(). Your
scheme doesn't really work when applied to free_swap_and_cache().

>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern int free_swap_and_cache(swp_entry_t);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>  
> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> +{
> +
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3f594be83b58..244106998a69 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
>  		__swap_entry_free(p, entry);
>  }
>  
> +/*
> + * Called after swapping in a large folio, batched free swap entries
> + * for this large folio, entry should be for the first subpage and
> + * its offset is aligned with nr_pages
> + */
> +void swap_nr_free(swp_entry_t entry, int nr_pages)
> +{
> +	int i;
> +	struct swap_cluster_info *ci;
> +	struct swap_info_struct *p;
> +	unsigned type = swp_type(entry);

nit: checkpatch.py will complain about bare "unsigned", preferring "unsigned
int" or at least it did for me when I did something similar in my swap-out patch
set.

> +	unsigned long offset = swp_offset(entry);
> +	DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) = { 0 };

I don't love this, as it could blow the stack if SWAPFILE_CLUSTER ever
increases. But the only other way I can think of is to explicitly loop over
fixed size chunks, and that's not much better.

> +
> +	/* all swap entries are within a cluster for mTHP */
> +	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
> +
> +	if (nr_pages == 1) {
> +		swap_free(entry);
> +		return;
> +	}
> +
> +	p = _swap_info_get(entry);

You need to handle this returning NULL, like swap_free() does.

> +
> +	ci = lock_cluster(p, offset);

The existing swap_free() calls lock_cluster_or_swap_info(). So if swap is backed
by rotating media, and clusters are not in use, it will lock the whole swap
info. But your new version only calls lock_cluster() which won't lock anything
if clusters are not in use. So I think this is a locking bug.

> +	for (i = 0; i < nr_pages; i++) {
> +		if (__swap_entry_free_locked(p, offset + i, 1))
> +			__bitmap_set(usage, i, 1);
> +	}
> +	unlock_cluster(ci);
> +
> +	for_each_clear_bit(i, usage, nr_pages)
> +		free_swap_slot(swp_entry(type, offset + i));
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */

Thanks,
Ryan


