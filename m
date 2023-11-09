Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E947E6E13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjKIPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:54:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD7125;
        Thu,  9 Nov 2023 07:54:24 -0800 (PST)
Received: from [100.98.136.55] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6B90C66074E4;
        Thu,  9 Nov 2023 15:54:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699545263;
        bh=3WWL6wQEComAANvAj1qEV/UYxsJ1yDBfQ3tP5uX/YLk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D/dUZwI3iQpedaY/GdQjHQS1scxyhcN7jhgn6D47iDVOWAXLkJYI6JlliE4PqmW/F
         dMEOOPkxJ8ZlzQybUFvpUZmlGi79eHqyaJx0Yxup3HJ5Yd6Ze+dQnNfdhHKlpO8PSd
         xeXAr05Z1tf0hQAm4iDfRDXdrOnBv1+GpDuUaeyED4Kd+IQ8QxcOkJsa+goDTcXPQg
         cs+yV0VQgJo5pHMGahaM5nsibUwKDyBxIKWaWQhTwPBpbwc4vz7xxBxDOLmmP5aVKf
         1weo50VNmE7smJkaFraV1l9OxfnyeJPl9QQ7xCmBW2qThbML61PtQ3rgYO5gVG8+gT
         dko5b02V9ORdA==
Message-ID: <22f2aee0-aea7-465d-b7f3-b1add1bf7bd7@collabora.com>
Date:   Thu, 9 Nov 2023 16:54:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 35/56] media: cedrus: Stop direct calls to queue
 num_buffers field
Content-Language: en-US
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Maxime Ripard <mripard@kernel.org>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-36-benjamin.gaignard@collabora.com>
 <083e43d9-452a-4b11-b7f1-f75992bc795e@collabora.com>
 <ZUzpSXDbO60uGr0t@aptenodytes>
 <618d5b67-ba46-4c33-ae7f-990f4b522ba8@collabora.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <618d5b67-ba46-4c33-ae7f-990f4b522ba8@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 09/11/2023 à 16:48, Andrzej Pietrasiewicz a écrit :
> Hi Paul,
>
> W dniu 9.11.2023 o 15:14, Paul Kocialkowski pisze:
>> Hi Andrzej,
>>
>> On Thu 09 Nov 23, 12:27, Andrzej Pietrasiewicz wrote:
>>> Hi Paul,
>>>
>>> W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
>>>> Use vb2_get_num_buffers() to avoid using queue num_buffers field 
>>>> directly.
>>>> This allows us to change how the number of buffers is computed in the
>>>> future.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>>
>>> Given you've alaredy A-b, would you be ok with adding this sentence:
>>>
>>> "While at it, check the return value of vb2_get_buffer()."
>>>
>>> to the commit message body?
>>
>> Not only do I agree, but because this is done in a function returning 
>> void,
>> you could even:
>>
>> if (WARN_ON(!vb))
>>     continue;
>>
>> so that it doesn't go completely unnoticed.
>>
>> What do you think?
>>
>
> I'd ask Benjamin.
>
> But my take on the direction of changes is that ultimately
> there will be "holes" in the array of allocated buffers (hence the
> bitmap to track which slots are used and which are not). In other words,
> getting a NULL sometimes will be an expected situation, and a WARN() will
> not be appropriate for an expected situation.
>
> @Benjamin?

That should never happens unless you add delete buffers capability to the driver
and in this case it is normal to have holes.
Other drivers do not use WARN_ON() so I will not do it for this one.

Regards,
Benjamin

>
> Regards,
>
> Andrzej
>
>> Cheers,
>>
>> Paul
>>
>>> @Benjamin:
>>>
>>> With this change, you can add my
>>>
>>> Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>>>
>>>> CC: Maxime Ripard <mripard@kernel.org>
>>>> ---
>>>>    drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 9 +++++++--
>>>>    drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
>>>>    2 files changed, 14 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c 
>>>> b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>>>> index dfb401df138a..3e2843ef6cce 100644
>>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>>>> @@ -653,8 +653,13 @@ static void cedrus_h264_stop(struct cedrus_ctx 
>>>> *ctx)
>>>>        vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, 
>>>> V4L2_BUF_TYPE_VIDEO_CAPTURE);
>>>> -    for (i = 0; i < vq->num_buffers; i++) {
>>>> -        buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
>>>> +    for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>>>> +        struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>>>> +
>>>> +        if (!vb)
>>>> +            continue;
>>>> +
>>>> +        buf = vb2_to_cedrus_buffer(vb);
>>>>            if (buf->codec.h264.mv_col_buf_size > 0) {
>>>>                dma_free_attrs(dev->dev,
>>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c 
>>>> b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> index fc9297232456..52e94c8f2f01 100644
>>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> @@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx 
>>>> *ctx)
>>>>        vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, 
>>>> V4L2_BUF_TYPE_VIDEO_CAPTURE);
>>>> -    for (i = 0; i < vq->num_buffers; i++) {
>>>> -        buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
>>>> +    for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>>>> +        struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>>>> +
>>>> +        if (!vb)
>>>> +            continue;
>>>> +
>>>> +        buf = vb2_to_cedrus_buffer(vb);
>>>>            if (buf->codec.h265.mv_col_buf_size > 0) {
>>>>                dma_free_attrs(dev->dev,
>>>
>>
>>
>> _______________________________________________
>> Kernel mailing list -- kernel@mailman.collabora.com
>> To unsubscribe send an email to kernel-leave@mailman.collabora.com
>
