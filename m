Return-Path: <linux-kernel+bounces-118435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1D88BAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D51A1F3A207
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15CA12CD9B;
	Tue, 26 Mar 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay3TqeCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B84129A71
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436291; cv=none; b=P25U7KSgL4DO8R+BMrQXypjxcgAPjc/3+CHfTIZVe3K6mLTXg2UW79Qe2D4Pwt2fiAS0pkqVe31AVdIRzNQVhKB9ILWG+hfOrWMvzHoiPY5+w3XrhcVJrwXI1SAceGYiA6hN+ZMOZ5lRfRi2MCELn+/4KX1OU8ywho13SI4rW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436291; c=relaxed/simple;
	bh=Oto1Bgx2nEcBajuiq3zg5pa2/Kdk7vuiCcvbsEb1ox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvAMOLitua8tfq89yoTSYXhRPchydrU3vsSrK5RSE8gCy/g2dJlHBbBrEMukt3uZewp+7duXvAGTHbWwWNDLhlbsyFLZoPAYSrnabyd4wSNKFYLtlHsKywc2lvEyU/wxIWYPAiaCbuNBBQbRAmJuCVOBLEfwEwRZmyrYVmiYHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay3TqeCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0DFC433F1;
	Tue, 26 Mar 2024 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711436290;
	bh=Oto1Bgx2nEcBajuiq3zg5pa2/Kdk7vuiCcvbsEb1ox4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay3TqeCmVtCa4qF1OL7AxLUF84qxvhegocKTuLWHsbSzS0UgBlX6f7JYNGb8GsCCe
	 qFmQRDbOM1FkEdIcqkVwhm64D+hPxIJNp6dbf8c0W/FuEw56ogMEjRCM/FOdLWKAbZ
	 0yHansf3kxUb5Lg4jDxjCOL5HNwe/eO/kiY4JrnAhwSZ5dG1adz9keSrXWgyqnlyI1
	 WcvlKvRNMtOCP7F40tIJ1Dvam3LfxDgwCOx6j8B7kc4BEl++YLMZJu715mR4qd56gl
	 FDAxb7ulwHdEUegXRfRWU/qnUO20UzXt3ALdHLqKNdWqmYi24QG6HIL2SjP2TydLZT
	 zKa93/C8jXs1g==
Date: Tue, 26 Mar 2024 08:57:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 3/6] mm/mm_init.c: add new function calc_nr_all_pages()
Message-ID: <ZgJx2RLPAdom1EbE@kernel.org>
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

Hi Baoquan,

On Mon, Mar 25, 2024 at 10:56:43PM +0800, Baoquan He wrote:
> This is a preparation to calculate nr_kernel_pages and nr_all_pages,
> both of which will be used later in alloc_large_system_hash().
> 
> nr_all_pages counts up all free but not reserved memory in memblock
> allocator, including HIGHMEM memory. While nr_kernel_pages counts up
> all free but not reserved low memory in memblock allocator, excluding
> HIGHMEM memory.

Sorry I've missed this in the previous review, but I think this patch and
the patch "remove unneeded calc_memmap_size()" can be merged into "remove
meaningless calculation of zone->managed_pages in free_area_init_core()"
with an appropriate update of the commit message.

With the current patch splitting there will be compilation warning about unused
function for this and the next patch.
 
> Signed-off-by: Baoquan He <bhe@redhat.com>
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

