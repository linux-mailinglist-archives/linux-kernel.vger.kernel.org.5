Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F247C7E5BDC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjKHRAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:00:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93551719;
        Wed,  8 Nov 2023 09:00:08 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47EA6660746B;
        Wed,  8 Nov 2023 17:00:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699462807;
        bh=v1ZDZ92VUQvwcoBTo3YLDcAwJdq/9mIJJULop13aVjc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DPxbTyaMPU2PQPpXxDwVbUyxVY/ySm7+tshhCBnMxktHXu5Kh0l9Afdgu0EnxdUWH
         floksg8TAOJSiHZxMPD3IYNNlfIhDPj+4lRd+l4r+20sstKqxMtm3uaxuEUpH4HV8H
         bj2caCJtxaR2A4JrNmbREt4LXd1zWiGhZXCmehnFWJbX4ZbbhHcdDNwREOs6B+53J2
         8A9E0grogHDLtSbXuAUXzTS13taqL3kN8EyD44HLM5mYgfN6dF4940IlqqKM5oUBox
         TtXAkleyJc8CCq31npcCizjNq+A0hjdLzCUGVCdmIX2A48L+pzoQVP8s4mHkzKVHds
         c7OVd7EwTfbkg==
Message-ID: <900d7ba8-6b0c-412a-936c-184decba7566@collabora.com>
Date:   Wed, 8 Nov 2023 18:00:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/56] media: mediatek: jpeg: Use vb2_get_buffer()
 instead of directly access to buffers array
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
        kernel@collabora.com, Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-12-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-12-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_buffer() instead of direct access to the vb2_queue bufs array.
> This allows us to change the type of the bufs in the future.
> After each call to vb2_get_buffer() we need to be sure that we get
> a valid pointer so check the return value of all of them.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Bin Liu <bin.liu@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 7194f88edc0f..73a063b1569b 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -598,12 +598,11 @@ static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>   		goto end;
>   
>   	vq = v4l2_m2m_get_vq(fh->m2m_ctx, buf->type);
> -	if (buf->index >= vq->num_buffers) {
> -		dev_err(ctx->jpeg->dev, "buffer index out of range\n");
> +	vb = vb2_get_buffer(vq, buf->index);
> +	if (!vb) {
> +		dev_err(ctx->jpeg->dev, "buffer not found\n");
>   		return -EINVAL;
>   	}
> -
> -	vb = vq->bufs[buf->index];
>   	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
>   	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
>   

