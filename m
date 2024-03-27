Return-Path: <linux-kernel+bounces-121546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9088E994
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D38F1F3271F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D429131752;
	Wed, 27 Mar 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7y9hYHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E24131188
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554055; cv=none; b=fsH7ejoAfq25Rw5e0xk/Kt41jcH/IyctWfkSDD5YUPBmYcNMjlw4HBoEsoO4yC/cKJPkl0zKVecgvw3rYzJw1fzMzFeXg7yPt7eQTOHXtMKnCEhzvZ+hFJWD38urLU/Yhh8nqdekP7TlDU+soXtCCcH1uawsVAU6DfBr+d79dKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554055; c=relaxed/simple;
	bh=HNlX16yEhkMKnQYWOX4sU3T+8rc8JG5/hnyo+cviw3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSkQ7WNsupbKR3/RqHggSm2XJTr49CuKpl66f2KFm+SbZTPsMuhcJmMxIkZUJIMKBnLYYD4Fega4telwhOsvxtNApKpQvMeQy8nzlNJranRPrHcrgUJTQ1g+YcebZCacEk5FxoxR0yGTA9sUcTUnysmSxG4BWFFatWsP+4rI5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7y9hYHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEBEC433A6;
	Wed, 27 Mar 2024 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554055;
	bh=HNlX16yEhkMKnQYWOX4sU3T+8rc8JG5/hnyo+cviw3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7y9hYHuRLtHvFLwO8Y4NO0itC/fk4QqmGjSusGf91p3QG5DF6iyq1cxHOvvstzI0
	 edCWgqhb/0nQbxWRTgf8biJg0d5OeT9/fbxX6E/GjmojuvotpQOzjJ0fTSE+bjk13Z
	 21wIMYhkIy7dr+27z0Yzz2IZdMF9m0HoRyEgdrtyqkn7d/Lxic2MM5TmmEfclHRjaG
	 TMc7uLg0ymzMNuHxyfmESWSNzMzcnrRwnwI18Zrdq9w7rmLyzP1CQ4DRxYinYyq+xY
	 P3tSh6w6HlL+vOS/Flq9BgOvcdfVDQyD20LMrIQR5rBkNZ0rl1e+G4RbiPKlwZFoGN
	 dI6A4osqTA2Qg==
Date: Wed, 27 Mar 2024 17:40:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/6] mm/mm_init.c: add new function calc_nr_all_pages()
Message-ID: <ZgQ93KOEfzr2_OVx@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-4-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-4-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:43PM +0800, Baoquan He wrote:
> This is a preparation to calculate nr_kernel_pages and nr_all_pages,
> both of which will be used later in alloc_large_system_hash().
> 
> nr_all_pages counts up all free but not reserved memory in memblock
> allocator, including HIGHMEM memory. While nr_kernel_pages counts up
> all free but not reserved low memory in memblock allocator, excluding
> HIGHMEM memory.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 153fb2dc666f..c57a7fc97a16 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1264,6 +1264,30 @@ static void __init reset_memoryless_node_totalpages(struct pglist_data *pgdat)
>  	pr_debug("On node %d totalpages: 0\n", pgdat->node_id);
>  }
>  
> +static void __init calc_nr_kernel_pages(void)
> +{
> +	unsigned long start_pfn, end_pfn;
> +	phys_addr_t start_addr, end_addr;
> +	u64 u;
> +#ifdef CONFIG_HIGHMEM
> +	unsigned long high_zone_low = arch_zone_lowest_possible_pfn[ZONE_HIGHMEM];
> +#endif
> +
> +	for_each_free_mem_range(u, NUMA_NO_NODE, MEMBLOCK_NONE, &start_addr, &end_addr, NULL) {
> +		start_pfn = PFN_UP(start_addr);
> +		end_pfn   = PFN_DOWN(end_addr);
> +
> +		if (start_pfn < end_pfn) {
> +			nr_all_pages += end_pfn - start_pfn;
> +#ifdef CONFIG_HIGHMEM
> +			start_pfn = clamp(start_pfn, 0, high_zone_low);
> +			end_pfn = clamp(end_pfn, 0, high_zone_low);
> +#endif
> +			nr_kernel_pages += end_pfn - start_pfn;
> +		}
> +	}
> +}
> +
>  static void __init calculate_node_totalpages(struct pglist_data *pgdat,
>  						unsigned long node_start_pfn,
>  						unsigned long node_end_pfn)
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.

