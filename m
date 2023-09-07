Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA81797B92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjIGSV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjIGSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C16AA1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC9441480;
        Thu,  7 Sep 2023 05:58:26 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ECDC3F7B4;
        Thu,  7 Sep 2023 05:57:48 -0700 (PDT)
Message-ID: <8c3fe8ce-4716-73f0-fb8a-ee982f212371@arm.com>
Date:   Thu, 7 Sep 2023 13:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] cma: check for memory region overlapping
Content-Language: en-GB
To:     Binglei Wang <l3b2w1@gmail.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230726142823.6356-1-l3b2w1@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230726142823.6356-1-l3b2w1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 3:28 pm, Binglei Wang wrote:
> From: Binglei Wang <l3b2w1@gmail.com>
> 
> In the process of parsing the DTS, checks
> whether the memory region specified by the DTS CMA node area
> overlaps with the kernel text memory space reserved by memblock
> before calling early_init_fdt_scan_reserved_mem.

This description bears no relation to what the code actually does. 
rmem_cma_setup() happens well after parsing the DTS, as it is that 
initial parsing process in fdt_scan_reserved_mem() which *makes* the 
memblock reservations in the first place. Thus, as the revert patch 
demonstrates, by the time we get here to start *using* the reserved 
region via fdt_init_reserved_mem(), it is always guaranteed to overlap a 
reserved region because it trivially overlaps with itself.

Furthermore, even if the bootloader does stupidly load a non-relocatable 
kernel into memory that it's described as reserved, the kernel text 
pages should not be available for CMA to allocate from - and if they 
were, that would be a far more fundamental bug elsewhere - so what is 
the exact problem you're trying to solve here?

Thanks,
Robin.

> Maybe it's better to have some warning prompts printed.
> 
> Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
> ---
> 
> Notes:
>      v3: fix compile error.
>      v2: delete the logic code for handling return -EBUSY.
>      v1: return -EBUSY when detect overlapping and handle the return case.
> 
>   kernel/dma/contiguous.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 6ea80ae42..dc6d2af1e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -410,6 +410,11 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   		return -EBUSY;
>   	}
>   
> +	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> +		pr_info("Reserved memory: overlap with other memblock reserved region\n");
> +		return -EBUSY;
> +	}
> +
>   	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
