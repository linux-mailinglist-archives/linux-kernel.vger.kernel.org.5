Return-Path: <linux-kernel+bounces-118427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A788BAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5404B1C31DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B789127B68;
	Tue, 26 Mar 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKfjQouz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333554BFF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435533; cv=none; b=nOfPKTxr0cd7H27AUboJvTC5vqnPQBFqx6kAzJzy/IqodhwEBssoD6rki44SM41fgI5FskyN0ysm+x1/f/JON/mqNSO3g61Dqo86Vub4L7TnCksctg1LzMCbH9qYyF1EsLDyvJ5xABNAZ2JytE68eEw0eegfLJzyHlCwNFm0r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435533; c=relaxed/simple;
	bh=ulrv7k7ZRJRs0j0UdGjBhPLsD3RfogntRNv4v9/Eono=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiRzPhrypOFW2xkwDBoysq/SncxpfBebUYTey0KrV5XlIr//JaMMLeynmWpQP/WFrcZQk2UrokxKFzz4hy8jE16uV+NfLL3MOdx/6VO1u7/9PM+5sChBELCv/4cntOiucXJVrCuOYdUhQ8VFoTfJLxIlcRQtJ/kX195m8Y4tO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKfjQouz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE56CC433C7;
	Tue, 26 Mar 2024 06:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711435533;
	bh=ulrv7k7ZRJRs0j0UdGjBhPLsD3RfogntRNv4v9/Eono=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKfjQouzCOhBvoDhqXcHLgUMTJFUwVqNgPbgWGKOmhGTJ2nQSmlZE1A6IBDIPQY2A
	 zVpMgtMPeairercXPNLIzgoWtn3Fot5ibnD/lzLoVjSHSxBEC54Stouwo1s7On6811
	 GV3eKVumEycJwcreNVmSqHMaEU3TT7qbMKpzGd0QH1KXh/HcLxTNhvf4wg/wPPgehW
	 o9P9KN2GbpJQ2SiGHHDwXxJkMEoyB7gGG+UVh2qybk2PxPOBC9IrRtKLtb5QTE2OPs
	 8YV0+/1H9qGhY+CBxkf9uGH3nLLndd1kAzYHZhH2awWnGchEcMWzNHZhDmOF0r9nH8
	 uw4bX4TFQ7lqA==
Date: Tue, 26 Mar 2024 08:44:51 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/6] mm/mm_init.c: remove the useless dma_reserve
Message-ID: <ZgJu4z6JFBwo0p1-@kernel.org>
References: <20240325145646.1044760-1-bhe@redhat.com>
 <20240325145646.1044760-3-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325145646.1044760-3-bhe@redhat.com>

On Mon, Mar 25, 2024 at 10:56:42PM +0800, Baoquan He wrote:
> Now nobody calls set_dma_reserve() to set value for dma_reserve, remove
> set_dma_reserve(), global variable dma_reserve and the codes using it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h |  1 -
>  mm/mm_init.c       | 23 -----------------------
>  2 files changed, 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0436b919f1c7..ad19350e1538 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3210,7 +3210,6 @@ static inline int early_pfn_to_nid(unsigned long pfn)
>  extern int __meminit early_pfn_to_nid(unsigned long pfn);
>  #endif
>  
> -extern void set_dma_reserve(unsigned long new_dma_reserve);
>  extern void mem_init(void);
>  extern void __init mmap_init(void);
>  
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 549e76af8f82..153fb2dc666f 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -226,7 +226,6 @@ static unsigned long required_movablecore_percent __initdata;
>  
>  static unsigned long nr_kernel_pages __initdata;
>  static unsigned long nr_all_pages __initdata;
> -static unsigned long dma_reserve __initdata;
>  
>  static bool deferred_struct_pages __meminitdata;
>  
> @@ -1583,12 +1582,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  					zone_names[j], memmap_pages, freesize);
>  		}
>  
> -		/* Account for reserved pages */
> -		if (j == 0 && freesize > dma_reserve) {
> -			freesize -= dma_reserve;
> -			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
> -		}
> -
>  		if (!is_highmem_idx(j))
>  			nr_kernel_pages += freesize;
>  		/* Charge for highmem memmap if there are enough kernel pages */
> @@ -2547,22 +2540,6 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	return table;
>  }
>  
> -/**
> - * set_dma_reserve - set the specified number of pages reserved in the first zone
> - * @new_dma_reserve: The number of pages to mark reserved
> - *
> - * The per-cpu batchsize and zone watermarks are determined by managed_pages.
> - * In the DMA zone, a significant percentage may be consumed by kernel image
> - * and other unfreeable allocations which can skew the watermarks badly. This
> - * function may optionally be used to account for unfreeable pages in the
> - * first zone (e.g., ZONE_DMA). The effect will be lower watermarks and
> - * smaller per-cpu batchsize.
> - */
> -void __init set_dma_reserve(unsigned long new_dma_reserve)
> -{
> -	dma_reserve = new_dma_reserve;
> -}
> -
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> -- 
> 2.41.0
> 
> 

-- 
Sincerely yours,
Mike.

