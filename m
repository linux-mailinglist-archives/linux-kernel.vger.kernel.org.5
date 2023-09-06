Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CB79389B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbjIFJnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbjIFJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:43:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF11733;
        Wed,  6 Sep 2023 02:43:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6BC433C8;
        Wed,  6 Sep 2023 09:43:26 +0000 (UTC)
Message-ID: <9e13765c-5ea2-6841-0c4b-6fad21134201@xs4all.nl>
Date:   Wed, 6 Sep 2023 11:43:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Content-Language: en-US, nl
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Anle Pan <anle.pan@nxp.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
 <8085c44d-2c58-82c5-185b-2bde75a07044@xs4all.nl>
 <CAAFQd5Cmk7NP4RjQ2N54RVFpLhqY0wpRwbn2piSZkZJSvJi6hg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CAAFQd5Cmk7NP4RjQ2N54RVFpLhqY0wpRwbn2piSZkZJSvJi6hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 11:26, Tomasz Figa wrote:
> On Wed, Sep 6, 2023 at 5:52 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> Hi all,
>>
>> On 29/08/2023 13:14, Robin Murphy wrote:
>>> On 2023-08-29 11:03, Tomasz Figa wrote:
>>>> Hi Anle,
>>>>
>>>> On Mon, Aug 28, 2023 at 8:57 AM Anle Pan <anle.pan@nxp.com> wrote:
>>>>>
>>>>> When allocating from pages, the size of the sg segment is unlimited and
>>>>> the default is UINT_MAX. This will cause the DMA stream mapping failed
>>>>> later with a "swiotlb buffer full" error.
>>>>
>>>> Thanks for the patch. Good catch.
>>>>
>>>>> The default maximum mapping
>>>>> size is 128 slots x 2K = 256K, determined by "IO_TLB_SEGSIZE".
>>>>> To fix the issue, limit the sg segment size according to
>>>>> "dma_max_mapping_size" to match the mapping limit.
>>>>>
>>>>> Signed-off-by: Anle Pan <anle.pan@nxp.com>
>>>>> ---
>>>>>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>>> index fa69158a65b1..b608a7c5f240 100644
>>>>> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
>>>>> @@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>>>>>          struct sg_table *sgt;
>>>>>          int ret;
>>>>>          int num_pages;
>>>>> +       size_t max_segment = 0;
>>>>>
>>>>>          if (WARN_ON(!dev) || WARN_ON(!size))
>>>>>                  return ERR_PTR(-EINVAL);
>>>>> @@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *vb, struct device *dev,
>>>>>          if (ret)
>>>>>                  goto fail_pages_alloc;
>>>>>
>>>>> -       ret = sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
>>>>> -                       buf->num_pages, 0, size, GFP_KERNEL);
>>>>> +       if (dev)
>>>
>>> dev can't be NULL, see the context above.
>>>
>>>>> +               max_segment = dma_max_mapping_size(dev);
>>>>> +       if (max_segment == 0)
>>>>> +               max_segment = UINT_MAX;
>>>>> +       ret = sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->pages,
>>>>> +               buf->num_pages, 0, size, max_segment, GFP_KERNEL);
>>>>
>>>> One thing that I'm not sure about here is that we use
>>>> sg_alloc_table_from_pages_segment(), but we actually don't pass the
>>>> max segment size (as returned by dma_get_max_seg_size()) to it.
>>>> I'm also not exactly sure what's the difference between "max mapping
>>>> size" and "max seg size".
>>>> +Robin Murphy +Christoph Hellwig I think we could benefit from your
>>>> expertise here.
>>>
>>> dma_get_max_seg_size() represents a capability of the device itself, namely the largest contiguous range it can be programmed to access in a single DMA descriptor/register/whatever. Conversely,
>>> dma_max_mapping_size() is a capablity of the DMA API implementation, and represents the largest contiguous mapping it is guaranteed to be able to handle (each segment in the case of dma_map_sg(), or
>>> the whole thing for dma_map_page()). Most likely the thing you want here is min_not_zero(max_seg_size, max_mapping_size).
>>>
>>>> Generally looking at videobuf2-dma-sg, I feel like we would benefit
>>>> from some kind of dma_alloc_table_from_pages() that simply takes the
>>>> struct dev pointer and does everything necessary.
>>>
>>> Possibly; this code already looks lifted from drm_prime_pages_to_sg(), and if it's needed here then presumably vb2_dma_sg_get_userptr() also needs it, at the very least.
>>
>> I also see sg_alloc_table_from_pages being called in vb2_dc_get_userptr in videobuf2-dma-contig.c,
>> presumably that needs the same fix?
>>
>> From what I gather from this thread there are no improved helpers on the immediate
>> horizon, so this issue has to be fixed in videobuf2 for now.
> 
> Agreed. (Although I suspect the real issue that NXP is having isn't
> really this and this is just a side effect.)
> 
>>
>> So this requires a v2 that fixes this also in vb2_dma_sg_get_userptr and vb2_dc_get_userptr,
>> correct? If so, then it would be nice if Anle can post a v2 with those changes.
> 
> If we need to fix 3 different callers, could we at least add an
> internal vb2 helper for this (e.g. vb2_asg_alloc_table_from_pages())?

Definitely.

> 
>>
>> Note that when I grepped for sg_alloc_table_from_pages_segment users, I noticed that
>> in most cases dma_max_mapping_size is used, but in one case it uses dma_get_max_seg_size
>> (drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c). I have no idea what the difference is
>> between the two.
> 
> FWIW, Robin explained that earlier in the thread. To be fully correct,
> we need to consider both...

Ah, I missed that explanation. Yes, it looks like both need to be considered.

> 
>>
>> One small change that would make sg_alloc_table_from_pages_segment() a bit easier
>> to work with is if it would replace a max_segment value of 0 with UINT_MAX. Then
>> you can just stick in dma_max_mapping_size(dev) as the argument.
>>
>> Alternatively, if we can be certain that dma_max_mapping_size(dev) never returns 0,
>> then that 'if (max_segment == 0)' part can just be dropped.
> 
> That's also the reason I wanted a helper. Not sure if it's so easy to
> change the calling convention now.

There are not all that many users of sg_alloc_table_from_pages(_segment),
dma_get_max_seg_size and dma_max_mapping_size, so it doesn't look too difficult
for a sufficiently motivated person (not me!) to make changes here.

Regards,

	Hans

> 
>>
>> I also wonder if any of the other (non-media) users of sg_alloc_table_from_pages
>> would need to use sg_alloc_table_from_pages_segment as well. Is this really
>> media specific? Or is media just the most likely subsystem to hit this issue due
>> to the large amounts of memory it uses?
> 
> I don't think it's media-specific, but also as I said earlier, it
> should be really rare to hit it - swiotlb isn't normally expected for
> reasonably capable systems and buffer allocation being done correctly.
> 
> Best regards,
> Tomasz

