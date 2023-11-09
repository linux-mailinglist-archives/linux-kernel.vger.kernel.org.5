Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B267E670C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjKIJqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjKIJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:46:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DB2715;
        Thu,  9 Nov 2023 01:46:44 -0800 (PST)
Received: from [100.98.136.55] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 109996607410;
        Thu,  9 Nov 2023 09:46:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699523203;
        bh=IFUUFnswkX8ko/bLeA8AThrmjVyJk/S4hUBWjROwSrE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TWFbkLboy695UDQbgJ4kpkCDHNPparXWuzAPl3syDfNnA3rSEpOUW+0KLpE91giq8
         l9u9xZt1uL9yz6+gfdLkeCRds6nEYOlKn4/ha7aSAeFF9WN7gTs7MdDYeJ7FmqpOTS
         B+8pPl1uzwL8/6uPwmnstIkTogYG8rIS5oXXN0aeTymg9gmpmcMeX7aUF7yXQ7HLR7
         l6/HXIgEaU/8Oi1lZZsd59o998YaM4Lm14KBeQ40vvf3NTRWdIoS2eXuIDTKwPm/eq
         Ti8oKSwoZpIXVK2wQdsVuCHF4WrVL6ITjlbBwnEwFnxQq4UHE4RYsuYtUuu5qBttws
         Lo0JnpTMmLg7Q==
Message-ID: <2f5ad14b-528d-4656-84d8-f85467c5b475@collabora.com>
Date:   Thu, 9 Nov 2023 10:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 56/56] media: test-drivers: Use helper for DELETE_BUFS
 ioctl
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-57-benjamin.gaignard@collabora.com>
 <20231109094311.yzmmn4vvskmrk4tk@chromium.org>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20231109094311.yzmmn4vvskmrk4tk@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 09/11/2023 à 10:43, Tomasz Figa a écrit :
> On Tue, Oct 31, 2023 at 05:31:04PM +0100, Benjamin Gaignard wrote:
>> Allow test drivers to use DELETE_BUFS by adding vb2_ioctl_delete_bufs() helper.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/test-drivers/vicodec/vicodec-core.c |  2 ++
>>   drivers/media/test-drivers/vimc/vimc-capture.c    |  2 ++
>>   drivers/media/test-drivers/visl/visl-video.c      |  2 ++
>>   drivers/media/test-drivers/vivid/vivid-core.c     | 13 ++++++++++---
>>   4 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
>> index 69cbe2c094e1..f14a8fd506d0 100644
>> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
>> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
>> @@ -1339,6 +1339,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
>>   	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
>>   	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
>>   	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
>> +	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
>>   
>>   	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
>>   	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
>> @@ -1725,6 +1726,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
>>   	dst_vq->mem_ops = &vb2_vmalloc_memops;
>>   	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
>>   	dst_vq->lock = src_vq->lock;
>> +	dst_vq->supports_delete_bufs = true;
> Since we have to explicitly provide the vidioc_delete_bufs callback anyway,
> is there any value in having a separate supports_delete_bufs flag? Or we
> envision that some drivers would support deleting buffers only for some
> queues?

That exactly the case for Hantro driver, it can support deleting buffers on
capture queue but not on output queue.

>
> Best regards,
> Tomasz
>
