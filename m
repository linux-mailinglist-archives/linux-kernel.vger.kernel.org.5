Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F57A89C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjITQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:54:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85717CA;
        Wed, 20 Sep 2023 09:54:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 104761FB;
        Wed, 20 Sep 2023 09:55:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0293F67D;
        Wed, 20 Sep 2023 09:54:27 -0700 (PDT)
Message-ID: <353919fd-932e-5d81-6ac5-7b51117366cd@arm.com>
Date:   Wed, 20 Sep 2023 17:54:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MA-21654 Use dma_alloc_pages in
 vb2_dma_sg_alloc_compacted
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>, Fang Hui <hui.fang@nxp.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        anle.pan@nxp.com, xuegang.liu@nxp.com
References: <20230914145812.12851-1-hui.fang@nxp.com>
 <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAAFQd5CcN+TiVd8vhMxQRbmrJuBGYwL5d6C0fKzOy4ujjM_JMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 8:41 am, Tomasz Figa wrote:
> Hi Fang,
> 
> On Thu, Sep 14, 2023 at 4:41 PM Fang Hui <hui.fang@nxp.com> wrote:
>>
>> On system with "CONFIG_ZONE_DMA32=y", if the allocated physical address is
> 
> First of all, thanks a lot for the patch! Please check my review comments below.
> 
> Is CONFIG_ZONE_DMA32 really the factor that triggers the problem? My
> understanding was that the problem was that the hardware has 32-bit
> DMA, but the system has physical memory at addresses beyond the first
> 4G.

Indeed, without ZONE-DMA32 it would be difficult for any allocator to 
support this at all. SWIOTLB is merely a symptom - if it wasn't enabled, 
the dma_map_sgtable() operation would just fail entirely when any page 
is beyond the device's reach.

>> greater than 4G, swiotlb will be used. It will lead below defects.
>> 1) Impact performance due to an extra memcpy.
>> 2) May meet below error due to swiotlb_max_mapping_size()
>>     is 256K (IO_TLB_SIZE * IO_TLB_SEGSIZE).
>> "swiotlb buffer is full (sz: 393216 bytes), total 65536 (slots),
>> used 2358 (slots)"
>>
>> To avoid those defects, use dma_alloc_pages() instead of alloc_pages()
>> in vb2_dma_sg_alloc_compacted().
>>
>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>> Signed-off-by: Fang Hui <hui.fang@nxp.com>
>> ---
>>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
> 
> Please remove MA-21654 from the subject and prefix it with the right
> tags for the path (`git log drivers/media/common/videobuf2` should be
> helpful to find the right one).
> 
>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> index 28f3fdfe23a2..b938582c68f4 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>> @@ -58,7 +58,7 @@ struct vb2_dma_sg_buf {
>>   static void vb2_dma_sg_put(void *buf_priv);
>>
>>   static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
>> -               gfp_t gfp_flags)
>> +               gfp_t gfp_flags, struct device *dev)
> 
> FWIW buf->dev already points to the right device - although we would
> need to move the assignment in vb2_dma_sg_alloc() to a place higher in
> that function before calling this function.
> 
>>   {
>>          unsigned int last_page = 0;
>>          unsigned long size = buf->size;
>> @@ -67,6 +67,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
>>                  struct page *pages;
>>                  int order;
>>                  int i;
>> +               dma_addr_t dma_handle;
>>
>>                  order = get_order(size);
>>                  /* Don't over allocate*/
>> @@ -75,8 +76,9 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
>>
>>                  pages = NULL;
>>                  while (!pages) {
>> -                       pages = alloc_pages(GFP_KERNEL | __GFP_ZERO |
>> -                                       __GFP_NOWARN | gfp_flags, order);
>> +                       pages = dma_alloc_pages(dev, PAGE_SIZE << order, &dma_handle,
> 
> Hmm, when I was proposing dma_alloc_pages(), I missed that it returns
> a DMA handle. That on its own can be handled by saving the returned
> handles somewhere in struct vb2_dma_sg_buf, but there is a bigger
> problem - the function would actually create a mapping if the DMA
> device requires some mapping management (e.g. is behind an IOMMU),
> which is undesirable, because we create the mapping ourselves below
> anyway...
> 
> @Christoph Hellwig @Robin Murphy  I need your thoughts on this as
> well. Would it make sense to have a variant of dma_alloc_pages() that
> only allocates the pages, but doesn't perform the mapping? (Or a flag
> that tells the implementation to skip creating a mapping.)

As I mentioned before, I think it might make the most sense to make the 
whole thing into a "proper" dma_alloc_sgtable() function, which can then 
be used with dma_sync_sgtable_*() as dma_alloc_pages() is used with 
dma_sync_single_*() (and then dma_alloc_noncontiguous() clearly falls as 
the special in-between case).

Thanks,
Robin.

>> +                               DMA_BIDIRECTIONAL,
> 
> The right value should be already available in buf->dma_dir.
> 
>> +                               GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | gfp_flags);
>>                          if (pages)
>>                                  break;
>>
>> @@ -96,6 +98,7 @@ static int vb2_dma_sg_alloc_compacted(struct vb2_dma_sg_buf *buf,
>>          }
>>
>>          return 0;
>> +
> 
> Unnecessary blank line.
> 
>>   }
>>
>>   static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>> @@ -130,7 +133,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>>          if (!buf->pages)
>>                  goto fail_pages_array_alloc;
>>
>> -       ret = vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags);
>> +       ret = vb2_dma_sg_alloc_compacted(buf, vb->vb2_queue->gfp_flags, dev);
>>          if (ret)
>>                  goto fail_pages_alloc;
>>
>> --
>> 2.17.1
>>
> 
> We also need to use dma_free_pages() to free the memory.
> 
> Best regards,
> Tomasz
