Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E47FB712
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbjK1KXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjK1KXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:23:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6094C186;
        Tue, 28 Nov 2023 02:23:51 -0800 (PST)
Received: from [100.122.216.38] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58AE76606F5E;
        Tue, 28 Nov 2023 10:23:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701167029;
        bh=Qfm6uqEOnWvLZh3donKgv+pWA6CIt9GNyYhvnnw2sck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ia8VkIk+iHf3ASvMi5U9L2zkxq8g51P51FnWBXg7GjtulES56vrePQJAcxuuKU7Pp
         hAS9kwizyB6zZXuKlGRWKGlcGr2eAVmAKbs32S8NCZ6iBpxC5tEVKHI0YAxS5l11QQ
         KyFbZr24cyVO9ulM6l6O1sF1KGqAyfxQRS9cOcQ2PHlepldqMzyy3D5dkoEBBBBWdX
         x4ZNnhAg/Rb9Jbwdz1AxWMsuOhHLTTTuuf51Iyb+hkEJrOPcVRm+qVmuJI3b9++7g2
         MiWHszup7dvJuxwq/hUwU17a0T59F97xjYmu6gzvI+GkQlvdLWKgfBA7KsCIuSoExU
         xF1ld+8zZKZ0g==
Message-ID: <f1402052-f688-4f4b-98ef-e65fdbec3d51@collabora.com>
Date:   Tue, 28 Nov 2023 11:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/55] media: usb: cx231xx: Stop abusing of
 min_buffers_needed field
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-4-benjamin.gaignard@collabora.com>
 <44ca55bf-978d-47e8-abd2-8e3adb5071a2@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <44ca55bf-978d-47e8-abd2-8e3adb5071a2@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 28/11/2023 à 11:18, Hans Verkuil a écrit :
> On 27/11/2023 17:54, Benjamin Gaignard wrote:
>> 'min_buffers_needed' is suppose to be used to indicate the number
>> of buffers needed by DMA engine to start streaming.
>> cx231xx driver doesn't use DMA engine and just want to specify
>> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
>> That 'min_reqbufs_allocation' field purpose so use it.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/usb/cx231xx/cx231xx-417.c   | 2 +-
>>   drivers/media/usb/cx231xx/cx231xx-video.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
>> index 45973fe690b2..66043ed50c8e 100644
>> --- a/drivers/media/usb/cx231xx/cx231xx-417.c
>> +++ b/drivers/media/usb/cx231xx/cx231xx-417.c
>> @@ -1782,7 +1782,7 @@ int cx231xx_417_register(struct cx231xx *dev)
>>   	q->ops = &cx231xx_video_qops;
>>   	q->mem_ops = &vb2_vmalloc_memops;
>>   	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> -	q->min_buffers_needed = 1;
>> +	q->min_reqbufs_allocation = 1;
> There is no point setting min_reqbufs_allocation to 1: you can't allocate
> less than 1 buffer after all.

Does that mean I should just remove this line ?

>
> It is different in that respect from min_buffers_needed: you can call
> VIDIOC_STREAMON (and thus start_streaming) without any buffers queued.
>
> This also suggests a better name for min_buffers_needed: min_queued_buffers
>
> So 'min_queued_buffers' buffers have to be queued before start_streaming can
> be called.

Ok I will change that in V2

Regards,
Benjamin

>
> The old min_buffers_needed mixed up the two requirements of the minimum
> number of buffers to allocate in REQBUFS and the minimum number of buffers
> that need to be queued before you can start streaming. Separating these two
> meanings should make things easier to understand.
>
> The only relationship between the two is that min_reqbufs_allocation >
> min_queued_buffers, otherwise you would end up in a state where the
> driver would just cycle buffers and never be able to return a buffer
> to userspace to process.
>
> Regards,
>
> 	Hans
>
>>   	q->lock = &dev->lock;
>>   	err = vb2_queue_init(q);
>>   	if (err)
>> diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
>> index c8eb4222319d..df572c466bfb 100644
>> --- a/drivers/media/usb/cx231xx/cx231xx-video.c
>> +++ b/drivers/media/usb/cx231xx/cx231xx-video.c
>> @@ -1811,7 +1811,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
>>   	q->ops = &cx231xx_video_qops;
>>   	q->mem_ops = &vb2_vmalloc_memops;
>>   	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> -	q->min_buffers_needed = 1;
>> +	q->min_reqbufs_allocation = 1;
>>   	q->lock = &dev->lock;
>>   	ret = vb2_queue_init(q);
>>   	if (ret)
>> @@ -1871,7 +1871,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
>>   	q->ops = &cx231xx_vbi_qops;
>>   	q->mem_ops = &vb2_vmalloc_memops;
>>   	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>> -	q->min_buffers_needed = 1;
>> +	q->min_reqbufs_allocation = 1;
>>   	q->lock = &dev->lock;
>>   	ret = vb2_queue_init(q);
>>   	if (ret)
>
