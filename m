Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCDA7D0C51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376816AbjJTJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376755AbjJTJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:51:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5714D57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:51:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F292F4;
        Fri, 20 Oct 2023 02:51:56 -0700 (PDT)
Received: from [10.57.68.58] (unknown [10.57.68.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9C13F5A1;
        Fri, 20 Oct 2023 02:51:14 -0700 (PDT)
Message-ID: <efab630e-e8b4-4011-b3ce-0dfcab984bcd@arm.com>
Date:   Fri, 20 Oct 2023 10:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Rewrite comment explaining why the source is
 preserved on DMA_FROM_DEVICE
Content-Language: en-GB
To:     Sean Christopherson <seanjc@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20231018173409.1871540-1-seanjc@google.com>
 <85e332bf-decf-427c-a2e5-95ab872d4ea6@arm.com> <ZTG6-GalaSf2lMBq@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZTG6-GalaSf2lMBq@google.com>
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

On 2023-10-20 00:25, Sean Christopherson wrote:
> On Wed, Oct 18, 2023, Robin Murphy wrote:
>> On 2023-10-18 18:34, Sean Christopherson wrote:
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index 01637677736f..e071415a75dc 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -1296,11 +1296,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>>>    		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
>>>    	tlb_addr = slot_addr(pool->start, index) + offset;
>>>    	/*
>>> -	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
>>> -	 * to the tlb buffer, if we knew for sure the device will
>>> -	 * overwrite the entire current content. But we don't. Thus
>>> -	 * unconditional bounce may prevent leaking swiotlb content (i.e.
>>> -	 * kernel memory) to user-space.
>>> +	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
>>> +	 * the original buffer to the TLB buffer before initiating DMA in order
>>> +	 * to preserve the original's data if the device does a partial write,
>>> +	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
>>> +	 * the original data, even if it's garbage, is necessary to match
>>> +	 * hardware behavior (use of swiotlb is supposed to be transparent) and
>>
>> Super-nit: I think that last "and" is superfluous (i.e. unwritten memory not
>> magically corrupting itself *is* the aforementioned hardware behaviour).
> 
> Ah yeah, agreed.  How about this?
> 
> 	/*
> 	 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
> 	 * the original buffer to the TLB buffer before initiating DMA in order
> 	 * to preserve the original's data if the device does a partial write,
> 	 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
> 	 * the original data, even if it's garbage, is necessary to match
> 	 * hardware behavior.  Use of swiotlb is supposed to be transparent,
> 	 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
> 	 */

Nice, that reads even more clearly IMO.

Cheers,
Robin.
