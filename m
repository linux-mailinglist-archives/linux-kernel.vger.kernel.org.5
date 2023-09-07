Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E29797419
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjIGPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbjIGPdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:33:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7832A1BF8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:32:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386EA139F;
        Thu,  7 Sep 2023 01:57:51 -0700 (PDT)
Received: from [10.57.30.76] (unknown [10.57.30.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28B5B3F64C;
        Thu,  7 Sep 2023 01:57:12 -0700 (PDT)
Message-ID: <d2c93c6c-86d8-1a1f-e58c-8e9d29e9ddb0@arm.com>
Date:   Thu, 7 Sep 2023 09:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] Revert "dma-contiguous: check for memory region overlap"
Content-Language: en-GB
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_tingweiz@quicinc.com
References: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-07 09:03, Zhenhua Huang wrote:
> This reverts commit 3fa6456ebe13adab3ba1817c8e515a5b88f95dce.
> 
> The Commit broke the CMA region creation through DT on arm64,
> as showed below logs with "memblock=debug":
> [    0.000000] memblock_phys_alloc_range: 41943040 bytes align=0x200000
> from=0x0000000000000000 max_addr=0x00000000ffffffff
> early_init_dt_alloc_reserved_memory_arch+0x34/0xa0
> [    0.000000] memblock_reserve: [0x00000000fd600000-0x00000000ffdfffff]
> memblock_alloc_range_nid+0xc0/0x19c
> [    0.000000] Reserved memory: overlap with other memblock reserved region
> 
>  From call flow, region we defined in DT was always reserved before entering
> into rmem_cma_setup. Also, rmem_cma_setup has one routine cma_init_reserved_mem
> to ensure the region was reserved. Checking the region not reserved here seems
> not correct.
> 
> early_init_fdt_scan_reserved_mem:
>      fdt_scan_reserved_mem
>          __reserved_mem_reserve_reg
> 		early_init_dt_reserve_memory
> 			memblock_reserve(using “reg” prop case)
>          fdt_init_reserved_mem
> 		__reserved_mem_alloc_size
> 			*early_init_dt_alloc_reserved_memory_arch*
> 				memblock_reserve(dynamic alloc case)
>          __reserved_mem_init_node
> 		rmem_cma_setup(region overlap check here should always fail)
> 
> Example DT can be used to reproduce issue:
> 
>      dump_mem: mem_dump_region {
>              compatible = "shared-dma-pool";
>              alloc-ranges = <0x0 0x00000000 0x0 0xffffffff>;
>              reusable;
>              size = <0 0x2800000>;
>      };
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>   kernel/dma/contiguous.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 88c595e..f005c66 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -473,11 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>   		return -EBUSY;
>   	}
>   
> -	if (memblock_is_region_reserved(rmem->base, rmem->size)) {
> -		pr_info("Reserved memory: overlap with other memblock reserved region\n");
> -		return -EBUSY;
> -	}

Um, indeed... failing to process a reserved memory region if it is 
reserved is clearly nonsensical. I mean, a few steps later we reach 
cma_init_reserved_mem() which already relies on the exact opposite check:

	if (!size || !memblock_is_region_reserved(base, size))
		return -EINVAL;

There's no way 3fa6456ebe13 could have worked or been properly tested :/

Thanks,
Robin.

> -
>   	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
>   	    of_get_flat_dt_prop(node, "no-map", NULL))
>   		return -EINVAL;
