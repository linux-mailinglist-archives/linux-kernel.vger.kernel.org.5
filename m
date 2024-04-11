Return-Path: <linux-kernel+bounces-140656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC518A173D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4EB1F25527
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C5633FE;
	Thu, 11 Apr 2024 14:30:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207C14F9EC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845840; cv=none; b=aSXiHwpi530xPdgLJNftDIcvCgVXS60dGYhmD4/MQI4r218qVgJV0XrnL3e5NJlvxiYHnslo93XDe4PTFhqbRkjWP2r3NkW2XL4iPT7fU8LDJW4eNXXuUwthZAe/HEQslWEedSWE5tAXcZ2kPCr1BsJHg13XDM339s5TN0hY+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845840; c=relaxed/simple;
	bh=FxQcOrEW4btp6JaWHQzTWcubSOAww5UXYLD7u/qtonQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkw+wIkGidBzJPCKFZ2ynuhHH0G6gSajDhEgt+0en5bltOtObiFfr90yAS90m1QYHE7lJEfTb+oybiLQwwN42yb7HANOflSQ7gdlYoXDsSsH1andl7i62kdxUh1lj1dV4UssI2uRz67kkPg/ASd+ZL5q2ayYEqMkZuw0aNv2KNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1AC339;
	Thu, 11 Apr 2024 07:31:07 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55BC3F64C;
	Thu, 11 Apr 2024 07:30:35 -0700 (PDT)
Message-ID: <95bc0ebb-49f4-4331-8809-3e4625f1d91a@arm.com>
Date: Thu, 11 Apr 2024 15:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched
 swap_free()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20240409082631.187483-1-21cnbao@gmail.com>
 <20240409082631.187483-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240409082631.187483-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:26, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Couple of nits; feel free to ignore.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..b7a107e983b8 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
> +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>  int swap_type_of(dev_t device, sector_t offset);
> @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>  
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 28642c188c93..f4c65aeb088d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
>  		__swap_entry_free(p, entry);
>  }
>  
> +/*
> + * Free up the maximum number of swap entries at once to limit the
> + * maximum kernel stack usage.
> + */
> +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
> +
> +/*
> + * Called after swapping in a large folio, batched free swap entries
> + * for this large folio, entry should be for the first subpage and
> + * its offset is aligned with nr_pages
> + */
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +	int i, j;
> +	struct swap_cluster_info *ci;
> +	struct swap_info_struct *p;
> +	unsigned int type = swp_type(entry);
> +	unsigned long offset = swp_offset(entry);
> +	int batch_nr, remain_nr;
> +	DECLARE_BITMAP(usage, SWAP_BATCH_NR) = { 0 };
> +
> +	/* all swap entries are within a cluster for mTHP */
> +	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
> +
> +	if (nr_pages == 1) {
> +		swap_free(entry);
> +		return;
> +	}
> +
> +	remain_nr = nr_pages;
> +	p = _swap_info_get(entry);
> +	if (p) {

nit: perhaps return early if (!p) ? Then you dedent the for() block.

> +		for (i = 0; i < nr_pages; i += batch_nr) {
> +			batch_nr = min_t(int, SWAP_BATCH_NR, remain_nr);
> +
> +			ci = lock_cluster_or_swap_info(p, offset);
> +			for (j = 0; j < batch_nr; j++) {
> +				if (__swap_entry_free_locked(p, offset + i * SWAP_BATCH_NR + j, 1))
> +					__bitmap_set(usage, j, 1);
> +			}
> +			unlock_cluster_or_swap_info(p, ci);
> +
> +			for_each_clear_bit(j, usage, batch_nr)
> +				free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR + j));
> +

nit: perhaps change to for (;;), and do the checks here to avoid clearing the
bitmap on the last run:

			i += batch_nr;
			if (i < nr_pages)
				break;

> +			bitmap_clear(usage, 0, SWAP_BATCH_NR);
> +			remain_nr -= batch_nr;
> +		}
> +	}
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */


