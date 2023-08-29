Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A26178C326
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjH2LO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjH2LOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:14:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4365BD;
        Tue, 29 Aug 2023 04:14:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230A32F4;
        Tue, 29 Aug 2023 04:15:29 -0700 (PDT)
Received: from [10.57.3.159] (unknown [10.57.3.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A92603F738;
        Tue, 29 Aug 2023 04:14:46 -0700 (PDT)
Message-ID: <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
Date:   Tue, 29 Aug 2023 12:14:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>, Anle Pan <anle.pan@nxp.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hui.fang@nxp.com
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 11:03, Tomasz Figa wrote:
> Hi Anle,
> 
> On Mon, Aug 28, 2023 at 8:57 AM Anle Pan <anle.pan@nxp.com> wrote:
>>
>> When allocating from pages, the size of the sg segment is unlimited and
>> the default is UINT_MAX. This will cause the DMA stream mapping failed
>> later with a "swiotlb buffer full" error.
> 
> Thanks for the patch. Good catch.
> 
>> The default maximum mapping
>> size is 128 slots x 2K = 256K, determined by "IO_TLB_SEGSIZE".
>> To fix the issue, limit the sg segment size according to
>> "dma_max_mapping_size" to match the mapping limit.
>>
>> Signed-off-by: Anle Pan <anle.pan@nxp.com>
>> ---
>>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> index fa69158a65b1..b608a7c5f240 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> @@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>>          struct sg_table *sgt;
>>          int ret;
>>          int num_pages;
>> +       size_t max_segment = 0;
>>
>>          if (WARN_ON(!dev) || WARN_ON(!size))
>>                  return ERR_PTR(-EINVAL);
>> @@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>>          if (ret)
>>                  goto fail_pages_alloc;
>>
>> -       ret = sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
>> -                       buf->num_pages, 0, size, GFP_KERNEL);
>> +       if (dev)

dev can't be NULL, see the context above.

>> +               max_segment = dma_max_mapping_size(dev);
>> +       if (max_segment == 0)
>> +               max_segment = UINT_MAX;
>> +       ret = sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->pages,
>> +               buf->num_pages, 0, size, max_segment, GFP_KERNEL);
> 
> One thing that I'm not sure about here is that we use
> sg_alloc_table_from_pages_segment(), but we actually don't pass the
> max segment size (as returned by dma_get_max_seg_size()) to it.
> I'm also not exactly sure what's the difference between "max mapping
> size" and "max seg size".
> +Robin Murphy +Christoph Hellwig I think we could benefit from your
> expertise here.

dma_get_max_seg_size() represents a capability of the device itself, 
namely the largest contiguous range it can be programmed to access in a 
single DMA descriptor/register/whatever. Conversely, 
dma_max_mapping_size() is a capablity of the DMA API implementation, and 
represents the largest contiguous mapping it is guaranteed to be able to 
handle (each segment in the case of dma_map_sg(), or the whole thing for 
dma_map_page()). Most likely the thing you want here is 
min_not_zero(max_seg_size, max_mapping_size).

> Generally looking at videobuf2-dma-sg, I feel like we would benefit
> from some kind of dma_alloc_table_from_pages() that simply takes the
> struct dev pointer and does everything necessary.

Possibly; this code already looks lifted from drm_prime_pages_to_sg(), 
and if it's needed here then presumably vb2_dma_sg_get_userptr() also 
needs it, at the very least.

Thanks,
Robin.
