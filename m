Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56F7CA526
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjJPKSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjJPKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:18:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E37131;
        Mon, 16 Oct 2023 03:18:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D5C433C8;
        Mon, 16 Oct 2023 10:18:00 +0000 (UTC)
Message-ID: <1b49bfc4-808a-48fe-97b3-b49067e5e18e@xs4all.nl>
Date:   Mon, 16 Oct 2023 12:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 40/56] sample: v4l: Stop direct calls to queue
 num_buffers field
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-41-benjamin.gaignard@collabora.com>
 <21864437-bfdd-4d39-91fa-f24fc1c7cf97@xs4all.nl>
In-Reply-To: <21864437-bfdd-4d39-91fa-f24fc1c7cf97@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 10:23, Hans Verkuil wrote:
> On 12/10/2023 13:46, Benjamin Gaignard wrote:
>> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>  samples/v4l/v4l2-pci-skeleton.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
>> index a61f94db18d9..a65aa9d1e9da 100644
>> --- a/samples/v4l/v4l2-pci-skeleton.c
>> +++ b/samples/v4l/v4l2-pci-skeleton.c
>> @@ -155,6 +155,7 @@ static int queue_setup(struct vb2_queue *vq,
>>  		       unsigned int sizes[], struct device *alloc_devs[])
>>  {
>>  	struct skeleton *skel = vb2_get_drv_priv(vq);
>> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>>  
>>  	skel->field = skel->format.field;
>>  	if (skel->field == V4L2_FIELD_ALTERNATE) {
>> @@ -167,8 +168,8 @@ static int queue_setup(struct vb2_queue *vq,
>>  		skel->field = V4L2_FIELD_TOP;
>>  	}
>>  
>> -	if (vq->num_buffers + *nbuffers < 3)
>> -		*nbuffers = 3 - vq->num_buffers;
>> +	if (q_num_bufs + *nbuffers < 3)
>> +		*nbuffers = 3 - q_num_bufs;
> 
> This should be dropped, and instead update q->min_buffers_needed from
> 2 to 3.

Actually, that's not quite true. I realized that there is a subtle bug in
the vb2 core and a general misunderstanding of min_buffers_needed in a lot
of drivers.

The min_buffers_needed field describes the minimum number of buffers needed
before the DMA engine can start. This is typically 0, 1 or 2. Once that many
buffers have been queued, then start_streaming callback is called. With fewer
buffers queued the DMA engine cannot start, so this represents a DMA engine
limitation.

Currently vb2 also uses this field as the minimum number of buffers to
allocate. However, that should be one more, so min_buffers_needed+1:
'min_buffers_needed' buffers are in-flight, and you need one more that is
owned by userspace, otherwise you would never be able to dequeue a buffer
if you only created 'min_buffers_needed' buffers.

But I noticed a lot of drivers that misinterpret this value as 'the minimum
number of buffers to allocate', unrelated to any DMA engine limitations.
This is most likely a bug, since this would unnecessarily delay the call to
start_streaming().

In other words, it is a mess.

I think my earlier advice to change min_buffers_needed and drop the check
in queue_setup should be disregarded. If the min_buffers_needed value
is >= the value checked in queue_setup, then you can drop the check. In all
other cases it is safer to keep it.

So in other words, this patch is fine. But e.g. patch 21 needs to keep the
check (although with a fix: *nbuffers = 2 - q_num_bufs).

When this work is done, then I think I need to take a close review at all the
drivers that set min_buffers_needed and/or check the number of buffers in
queue_setup and fix it properly.

Likely we need two different fields: one for the minimum number of buffers
that need to be allocated, and one for the minimum number of buffers that
need to be queued before start_streaming can be called. But that raises
the question how the 'minimum number of buffers that need to be allocated'
would interact with deleting buffers. It's actually not all that easy.

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>  
>>  	if (*nplanes)
>>  		return sizes[0] < skel->format.sizeimage ? -EINVAL : 0;
> 

