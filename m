Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3478DD81
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbjH3SvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244665AbjH3Nlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:41:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 791BD1B0;
        Wed, 30 Aug 2023 06:41:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ECE72F4;
        Wed, 30 Aug 2023 06:42:25 -0700 (PDT)
Received: from [10.57.4.99] (unknown [10.57.4.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02AC3F738;
        Wed, 30 Aug 2023 06:41:44 -0700 (PDT)
Message-ID: <d99ebaf2-bd95-1213-6c33-584a8c944b33@arm.com>
Date:   Wed, 30 Aug 2023 14:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Content-Language: en-GB
To:     Hui Fang <hui.fang@nxp.com>, Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>, Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com> <20230829150442.GA3929@lst.de>
 <DB9PR04MB92841D8BC1122D5A4210F78987E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <DB9PR04MB92841D8BC1122D5A4210F78987E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-30 04:22, Hui Fang wrote:
> Hi, guys
>   Thanks for your time.
>   I wonder if only NXP met the "swiotlb buffer full" issue.
>   In theory, when format is YUYV, those resolutions no greater than 320x240 (153600 bytes, which less than the max mapping size 256K ) can't meet the issue.
>   But resolutions no less than 640x480 (307200 bytes), may have chances to trigger the issue.
>   On our side, we tested on 1080p, easy to reproduce.
>   Or maybe "dma_max_mapping_size(dev)" is much bigger than 256K on your side?

I would imagine that in most cases, people either have an IOMMU, or they 
don't have more RAM than the device can access directly.

And in fact I think we've missed looking deep enough and that's the real 
problem here - the overall context is a buffer allocator, so if SWIOTLB 
is bouncing anything in that dma_map_sg() call, then it means we're 
allocating a buffer for a device out of pages that that device can't 
actually access, which seems fundamentally bad. Unfortunately there 
isn't currently an easy way to do the right thing - dma-debug would 
probably get very unhappy about scraping a bunch of dma_alloc_pages() 
allocations into a scatterlist and subsequently calling dma_sync_sg() on 
it, while dma_alloc_noncontiguous() does at least return a scatterlist 
but would be overly restrictive since we don't need it to be 
dma-contiguous either. I guess we could do with some sort of 
dma_alloc_sgt() API that joins the relevant internal bits together to 
replace vb2_dma_sg_alloc_compacted() with proper DMA-mask-aware 
allocation, and probably also allocates the sg_table as well?

Thanks,
Robin.

> 
> BRs,
> Fang Hui
> ________________________________
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, August 29, 2023 11:04 PM
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Tomasz Figa <tfiga@chromium.org>; Anle Pan <anle.pan@nxp.com>; Christoph Hellwig <hch@lst.de>; m.szyprowski@samsung.com <m.szyprowski@samsung.com>; mchehab@kernel.org <mchehab@kernel.org>; linux-media@vger.kernel.org <linux-media@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Hui Fang <hui.fang@nxp.com>
> Subject: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On Tue, Aug 29, 2023 at 12:14:44PM +0100, Robin Murphy wrote:
>> dma_get_max_seg_size() represents a capability of the device itself, namely
>> the largest contiguous range it can be programmed to access in a single DMA
>> descriptor/register/whatever.
> 
> Yes.  In a way it's a bit odd that it ended up in a field in
> struct device, as the feature might actually be different for different
> DMA engines or features in a device.  If I was to redesign it from
> scratch I'd just pass it to dma_map_sg.
> 
>>> Generally looking at videobuf2-dma-sg, I feel like we would benefit
>>> from some kind of dma_alloc_table_from_pages() that simply takes the
>>> struct dev pointer and does everything necessary.
>>
>> Possibly; this code already looks lifted from drm_prime_pages_to_sg(), and
>> if it's needed here then presumably vb2_dma_sg_get_userptr() also needs it,
>> at the very least.
> 
> Yes, there's tons of them.  But I'd feel really bad adding even more
> struct scatterlist based APIs given how bad of a data structure that is.
> 
