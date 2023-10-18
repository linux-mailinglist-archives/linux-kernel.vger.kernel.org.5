Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F67CE55A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjJRRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJRRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:53:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 292C6B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:53:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA4F62F4;
        Wed, 18 Oct 2023 10:53:42 -0700 (PDT)
Received: from [10.57.67.203] (unknown [10.57.67.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97F743F5A1;
        Wed, 18 Oct 2023 10:53:00 -0700 (PDT)
Message-ID: <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com>
Date:   Wed, 18 Oct 2023 18:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
Content-Language: en-GB
To:     Sean Christopherson <seanjc@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20231018173409.1871540-1-seanjc@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231018173409.1871540-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-18 18:34, Sean Christopherson wrote:
> Rewrite the comment explaining why swiotlb copies the original buffer to
> the TLB buffer before initiating DMA *from* the device, i.e. before the
> device DMAs into the TLB buffer.  The existing comment's argument that
> preserving the original data can prevent a kernel memory leak is bogus.
> 
> If the driver that triggered the mapping _knows_ that the device will
> overwrite the entire mapping, or the driver will consume only the written
> parts, then copying from the original memory is completely pointless.
> 
> If neither of the above holds true, then copying from the original adds
> value only if preserving the data is necessary for functional correctness,
> or the driver explicitly initialized the original memory.  If the driver
> didn't initialize the memory, then copying the original buffer to the TLB
> buffer simply changes what kernel data is leaked to userspace.
> 
> Writing the entire TLB buffer _does_ prevent leaking stale TLB buffer data
> from a previous bounce, but that can be achieved by simply zeroing the TLB
> buffer when grabbing a slot.
> 
> The real reason swiotlb ended up initializing the TLB buffer with the
> original buffer is that it's necessary to make swiotlb operate as
> transparently as possible, i.e. to behave as closely as possible to
> hardware, and to avoid corrupting the original buffer, e.g. if the driver
> knows the device will do partial writes and is relying on the unwritten
> data to be preserved.

Thanks Sean, I like this :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/ZN5elYQ5szQndN8n@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   kernel/dma/swiotlb.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 01637677736f..e071415a75dc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
>   	tlb_addr = slot_addr(pool->start, index) + offset;
>   	/*
> -	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
> -	 * to the tlb buffer, if we knew for sure the device will
> -	 * overwrite the entire current content. But we don't. Thus
> -	 * unconditional bounce may prevent leaking swiotlb content (i.e.
> -	 * kernel memory) to user-space.
> +	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
> +	 * the original buffer to the TLB buffer before initiating DMA in order
> +	 * to preserve the original's data if the device does a partial write,
> +	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
> +	 * the original data, even if it's garbage, is necessary to match
> +	 * hardware behavior (use of swiotlb is supposed to be transparent) and

Super-nit: I think that last "and" is superfluous (i.e. unwritten memory 
not magically corrupting itself *is* the aforementioned hardware behaviour).

> +	 * so that swiotlb doesn't corrupt bytes that the device does NOT write.
>   	 */
>   	swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
>   	return tlb_addr;
> 
> base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
