Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64BF7E6984
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjKIL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKIL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:27:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2702D6A;
        Thu,  9 Nov 2023 03:27:18 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CC7B6607421;
        Thu,  9 Nov 2023 11:27:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699529236;
        bh=elsGLjJBUb0H7SaXpx5HZ3Jp4Gtyrn+yMrEadZP4Gdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I3MnaGQem39Sj5xyItDxU2YsUjGm+wnLAEIlocZ+hSVaI6WV4gSFOKN+F2sarwt5g
         jXyefOGfiPIgs8uclUyUQBpI9xXCAZTLYWdwWFXcso/DoVY1vrnE8Q136E1fENU2BH
         nOjQO4Pa532J1Vgycgw9M5/Ij6LqSyhrCUhEq0o4mwPIbdsuUyBTl0H5PvKKjt2b8A
         2LzYxyEn0SBvJ98VhPfowGXefKJeRMAky2a/DnYIe2qh5pbFxqKHZw5hMKrMscRaTp
         3VZ18Ex7R7CuvfTZbaef+hbJENlSsmBxJSy3eadshVp+bzpnmw1oJISX0UvoRyR5be
         W3XT0l2d1jXJg==
Message-ID: <083e43d9-452a-4b11-b7f1-f75992bc795e@collabora.com>
Date:   Thu, 9 Nov 2023 12:27:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 35/56] media: cedrus: Stop direct calls to queue
 num_buffers field
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-36-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-36-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Given you've alaredy A-b, would you be ok with adding this sentence:

"While at it, check the return value of vb2_get_buffer()."

to the commit message body?

@Benjamin:

With this change, you can add my

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 9 +++++++--
>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> index dfb401df138a..3e2843ef6cce 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -653,8 +653,13 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
>   
>   	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>   
> -	for (i = 0; i < vq->num_buffers; i++) {
> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;
> +
> +		buf = vb2_to_cedrus_buffer(vb);
>   
>   		if (buf->codec.h264.mv_col_buf_size > 0) {
>   			dma_free_attrs(dev->dev,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index fc9297232456..52e94c8f2f01 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
>   
>   	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>   
> -	for (i = 0; i < vq->num_buffers; i++) {
> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;
> +
> +		buf = vb2_to_cedrus_buffer(vb);
>   
>   		if (buf->codec.h265.mv_col_buf_size > 0) {
>   			dma_free_attrs(dev->dev,

