Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895C27CC00B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjJQJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjJQJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:59:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E8F9;
        Tue, 17 Oct 2023 02:59:25 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:7205:da49:a7e8:59f8] (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DF1B66072C1;
        Tue, 17 Oct 2023 10:59:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697536764;
        bh=a5Sv7ioncBaZOFxcfAjDRAD0foGoDHh+LBV8taa+Qz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Px3k7uZzN9kGzG9Xg2iO78mVd9HTmp+Z9chGKVONZxXA2n1f/p79WJkuf8d11/1Qm
         PmbASDogOpGc2FRB8Uin7AgX9vy++S8VdiM0dqsLsIrn0L8kfK+8BOncmkJvgm+A0p
         CsOjq1EAZn7FiOMLMtGqbScXi4YDAhvqmymF1xr15tPQa5El6/lU27chyxptRg9fkq
         JHpiyJNMHP2UVTUcITlsu3vY/rNhVQmF9FK7Ik8ROYGAInsT91EOpxUAJT6X+GFQjN
         3Hez6TtPgGLWvVE8zhGjm4Z9LoYoi/uiqguK6z/ENPB/ez6ixJ65jUzN35w4deqE6R
         1Whj2tf7ZABOw==
Message-ID: <e13a2d7b-3288-4899-9469-bf9ea821e35d@collabora.com>
Date:   Tue, 17 Oct 2023 11:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 41/56] media: cedrus: Stop direct calls to queue
 num_buffers field
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Maxime Ripard <mripard@kernel.org>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-42-benjamin.gaignard@collabora.com>
 <ZS5L4l2PzQgpJXua@aptenodytes>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <ZS5L4l2PzQgpJXua@aptenodytes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 17/10/2023 à 10:54, Paul Kocialkowski a écrit :
> Hi Benjamin,
>
> On Thu 12 Oct 23, 13:46, Benjamin Gaignard wrote:
>> Use vb2_get_num_buffers() and queue max_num_buffers field
>> to avoid using queue num_buffer field directly.
> Thanks for the patch, this is indeed a nice cleanup and safer usage.
> Maybe the commit message needs to reflect why this change is welcome,
> not just what is being changed.

I will add this comment in the commit message:
This allows us to change how the number of buffers is computed in the futur.

>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> CC: Maxime Ripard <mripard@kernel.org>
>> CC: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> ---
>>   drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 8 ++++++--
>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
>>   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>> index dfb401df138a..95e490532a87 100644
>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
>> @@ -653,8 +653,12 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
>>   
>>   	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>>   
>> -	for (i = 0; i < vq->num_buffers; i++) {
>> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
>> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>> +
>> +		if (!vb)
>> +			continue;
> Please add a newline here to be consistent with the other block being changed.
>
> With this change and the commit log reworked, you can consider this:
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

That will be done for the next version.

Thanks,

Benjamin

>
> Thanks!
>
> Paul
>
>> +		buf = vb2_to_cedrus_buffer(vb);
>>   
>>   		if (buf->codec.h264.mv_col_buf_size > 0) {
>>   			dma_free_attrs(dev->dev,
>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> index fc9297232456..52e94c8f2f01 100644
>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>> @@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
>>   
>>   	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>>   
>> -	for (i = 0; i < vq->num_buffers; i++) {
>> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
>> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
>> +
>> +		if (!vb)
>> +			continue;
>> +
>> +		buf = vb2_to_cedrus_buffer(vb);
>>   
>>   		if (buf->codec.h265.mv_col_buf_size > 0) {
>>   			dma_free_attrs(dev->dev,
>> -- 
>> 2.39.2
>>
