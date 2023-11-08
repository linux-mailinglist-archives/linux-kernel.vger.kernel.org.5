Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13FF7E5621
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbjKHMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjKHMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:21:28 -0500
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226B19A5;
        Wed,  8 Nov 2023 04:21:25 -0800 (PST)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id CD3F91843CD;
        Wed,  8 Nov 2023 13:21:21 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1699446082; bh=cXTYXJuCKJSS8YA7h7LVgaTMvx8Dmk0utMJe5g35Yps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J7GpROVo6TRRazgizq4HuwI6ns5kp9jtnmPGP0sxz7X8dk5a7PrwiTafGDx7jsGBx
         uMCGEtEW2iHZJBQBMwqHQVFgYTT3aMu59kKLJHM0jazBsLAaJ7nWERKS/VwX98jgnC
         WLvdpMH99Y2sZQRPerGk1liuTzAmqnAdXrKDjfum6gfnICwkv/dX8WafTl+XfKDYUa
         Qf3YneQq4GWKgzpPCDWfeihAGQreZwNxYd9/Lln0t+dPh5y8YezvtbCmVtbFRbUtdE
         Q5IJIIAsmQuvNYKN85y8eTa+z/70tXT94z3J4QEJyJwNoWax0EUyCcysau0TOhalPk
         JOe0yjtVZRXGg==
Date:   Wed, 8 Nov 2023 13:21:20 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list),
        Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations with
 CONFIG_SWIOTLB_DYNAMIC
Message-ID: <20231108132120.0538a778@meshulam.tesarici.cz>
In-Reply-To: <20231108111249.261-1-petrtesarik@huaweicloud.com>
References: <20231108111249.261-1-petrtesarik@huaweicloud.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 12:12:49 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Limit the free list length to the size of the IO TLB. Transient pool can be
> smaller than IO_TLB_SEGSIZE, but the free list is initialized with the
> assumption that the total number of slots is a multiple of IO_TLB_SEGSIZE.
> As a result, swiotlb_area_find_slots() may allocate slots past the end of
> a transient IO TLB buffer.

Just to make it clear, this patch addresses only the memory corruption
reported by Niklas, without addressing the underlying issues. Where
corruption happened before, allocations will fail with this patch.

I am still looking into improving the allocation strategy itself.

Petr T

> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-iommu/104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com/
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 26202274784f..ec82524ba902 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -283,7 +283,8 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
>  	}
>  
>  	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> +		mem->slots[i].list = min(IO_TLB_SEGSIZE - io_tlb_offset(i),
> +					 mem->nslabs - i);
>  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>  		mem->slots[i].alloc_size = 0;
>  	}

