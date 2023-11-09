Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C77E6806
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjKIK25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:28:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F79E;
        Thu,  9 Nov 2023 02:28:53 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96104660747A;
        Thu,  9 Nov 2023 10:28:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699525731;
        bh=YUI2716BL9MVVQKR0wOZgCkV9ZOFJ6M0hDxDFXWF8Os=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VduSF+4jFjCIiOCw9PdW4Xm9Hk4QGuGR5xTJ46FG+sS1ktnWtunI7b3tg/OqJUIPa
         CuMwLN1yJisi8JFrb2oFENwUbCmWBKLb1Z/JLpAoMd2qfHCKRw2Hzr5RfAI2MqSAIE
         uu+mi6eZpgyvFbmwviQUyIfssORhuPElWeooCByiYm7A0aOzYdipB8ZrOaKTr9V6Pc
         90LWux9RryGgf/ag0l7/BfZoETFy1RY+igfM/q0qsWFi2eTxS0qBv9gVOvzGsbLnI8
         u+KRjmP/Xtn1QtyMmKM3uoQ99HFgGYgBHGdazZZKdfZ+CAo29Hr//67/FMEN736MLB
         if7F4ggybw02g==
Message-ID: <919d0ff4-2e8b-4481-970c-5b9aa0f882bb@collabora.com>
Date:   Thu, 9 Nov 2023 11:28:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 29/56] media: verisilicon: Stop direct calls to queue
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
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-30-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-30-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>   drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index 64d6fb852ae9..8f8f17e671ce 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -195,7 +195,7 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>   	struct hantro_dev *vpu = ctx->dev;
>   	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
>   	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
> -	unsigned int num_buffers = cap_queue->num_buffers;
> +	unsigned int num_buffers = vb2_get_num_buffers(cap_queue);
>   	struct v4l2_pix_format_mplane pix_mp;
>   	const struct hantro_fmt *fmt;
>   	unsigned int i, buf_size;

