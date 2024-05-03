Return-Path: <linux-kernel+bounces-167461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DE28BA9DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0F286EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAA14F136;
	Fri,  3 May 2024 09:26:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2414F12A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728375; cv=none; b=clMGrF4RfhxF/rXD3L/0A595bbIKjbn155gIzOOf152+nL6fDa/JXAwZHcsYuoFXWZ8/Le9Nj9qDRrB80oGojoMNwE3a1rwqb1JEEi94r/9ZtjyGlo9rarA2T0+gD3jtE9MzIJ/b0s/Ry65Vt1TARzvEo6/HQOmI278o4TXD5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728375; c=relaxed/simple;
	bh=ovCdzajEX8FJS9uQOEWLNBz4ZK/Q+CgJfm27Sm34Cds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j76PEUW78wvyPWOBaDGthUGEe+M6pQX7jfwvxGi7ziL+TMK2+hD4CgbKlpUZEaNhLJ1FxyhprSgbkkIWCStDj8qW5xDvjK/GuJJ3s7W32vnL8n+bwbHJfxOjRlu+SG0wd+3ajqyvso3P7m5Iqh1Sju/1zwKh1mwy7kGMWaH9z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B50692F4;
	Fri,  3 May 2024 02:26:38 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D95153F73F;
	Fri,  3 May 2024 02:26:10 -0700 (PDT)
Message-ID: <a44e1104-1508-4445-a4f2-a72b8f6fbfa2@arm.com>
Date: Fri, 3 May 2024 10:26:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] mm: swap: introduce swap_free_nr() for batched
 swap_free()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503005023.174597-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 01:50, Barry Song wrote:
> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> While swapping in a large folio, we need to free swaps related to the whole
> folio. To avoid frequently acquiring and releasing swap locks, it is better
> to introduce an API for batched free.
> Furthermore, this new function, swap_free_nr(), is designed to efficiently
> handle various scenarios for releasing a specified number, nr, of swap
> entries.
> 
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

This looks much better!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  include/linux/swap.h |  5 +++++
>  mm/swapfile.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 11c53692f65f..d1d35e92d7e9 100644
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
> +static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +}
> +
>  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
>  {
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6ca215fb92f..ec12f2b9d229 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1356,6 +1356,53 @@ void swap_free(swp_entry_t entry)
>  		__swap_entry_free(p, entry);
>  }
>  
> +static void cluster_swap_free_nr(struct swap_info_struct *sis,
> +		unsigned long offset, int nr_pages)
> +{
> +	struct swap_cluster_info *ci;
> +	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
> +	int i, nr;
> +
> +	ci = lock_cluster_or_swap_info(sis, offset);
> +	while (nr_pages) {
> +		nr = min(BITS_PER_LONG, nr_pages);
> +		for (i = 0; i < nr; i++) {
> +			if (!__swap_entry_free_locked(sis, offset + i, 1))
> +				bitmap_set(to_free, i, 1);
> +		}
> +		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> +			unlock_cluster_or_swap_info(sis, ci);
> +			for_each_set_bit(i, to_free, BITS_PER_LONG)
> +				free_swap_slot(swp_entry(sis->type, offset + i));
> +			if (nr == nr_pages)
> +				return;
> +			bitmap_clear(to_free, 0, BITS_PER_LONG);
> +			ci = lock_cluster_or_swap_info(sis, offset);
> +		}
> +		offset += nr;
> +		nr_pages -= nr;
> +	}
> +	unlock_cluster_or_swap_info(sis, ci);
> +}
> +
> +void swap_free_nr(swp_entry_t entry, int nr_pages)
> +{
> +	int nr;
> +	struct swap_info_struct *sis;
> +	unsigned long offset = swp_offset(entry);
> +
> +	sis = _swap_info_get(entry);
> +	if (!sis)
> +		return;
> +
> +	while (nr_pages) {
> +		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> +		cluster_swap_free_nr(sis, offset, nr);
> +		offset += nr;
> +		nr_pages -= nr;
> +	}
> +}
> +
>  /*
>   * Called after dropping swapcache to decrease refcnt to swap entries.
>   */


