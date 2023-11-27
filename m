Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE87F9E83
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjK0LYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjK0LYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:24:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB69E18A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:24:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8C672F4;
        Mon, 27 Nov 2023 03:25:24 -0800 (PST)
Received: from [10.57.73.142] (unknown [10.57.73.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21BC93F73F;
        Mon, 27 Nov 2023 03:24:35 -0800 (PST)
Message-ID: <6415df67-8d5f-44e5-8ca6-57007adf9aae@arm.com>
Date:   Mon, 27 Nov 2023 11:24:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
Content-Language: en-GB
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        steve.kang@unisoc.com
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
 <20231127071430.GA28214@lst.de>
 <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-27 8:56 am, Zhaoyang Huang wrote:
> On Mon, Nov 27, 2023 at 3:14 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Nov 27, 2023 at 11:09:30AM +0800, zhaoyang.huang wrote:
>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>
>>> memremap within dma_init_coherent_memory will map the given phys_addr
>>> into vmalloc area if the pa is not found during iterating iomem_resources,
>>> which conflict the rejection of vmalloc area in dma_map_single_attrs.
>>
>> I can't parse this sentence.
> Sorry for the confusion, please find below codes for more information.
> dma_init_coherent_memory
>      memremap
>          addr = ioremap_wt(offset, size);
> What I mean is addr is a vmalloc address, which is implicitly mapped
> by dma's framework and not be aware of to the driver.
>>
>>> IMO, it is find to let all valid virtual address be valid for DMA as the
>>> user will keep corresponding RAM safe for transfer.
>>
>> No, vmalloc address can't be passed to map_single.  You need to pass
>> the page to dma_map_page, and explicitly mange cache consistency
>> using the invalidate_kernel_vmap_range and flush_kernel_vmap_range
>> helpers.
> Please correct me if I am wrong. According to my understanding, cache
> consistency could be solved inside dma_map_page via either
> dma_direct_map_page(swio/arch_sync_dma_for_device) or ops->map_page.
> The original thought of rejecting vmalloc is that this pa is not safe
> as this mapping could go in any time. What I am suggesting is to let
> this kind of va be enrolled.

No, the point is that dma_map_single() uses virt_to_page(), and 
virt_to_page() is definitely not valid for vmalloc addresses. At worst 
it may blow up in itself with an out-of-bounds dereference; at best it's 
going to return a completely bogus page pointer which may then make 
dma_map_page() fall over.

Thanks,
Robin.

> 
>   static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>                  size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>         /* DMA must never operate on areas that might be remapped. */
>         if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
>                           "rejecting DMA map of vmalloc memory\n"))
>                 return DMA_MAPPING_ERROR;
> 
>>
> 
