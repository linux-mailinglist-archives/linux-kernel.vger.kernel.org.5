Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668397E5BCB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKHQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjKHQ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:56:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351CD1FE6;
        Wed,  8 Nov 2023 08:56:39 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 09C0E660746B;
        Wed,  8 Nov 2023 16:56:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699462598;
        bh=kYRbh6QCO0drKtDqhYzofnzH2F/9JXlenVRZfwbwu2o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C5FqcnxL9jhiXGVI76sn04GNZJCgntZUTy/I9qgG1i8iEcQiFkVs/6DjWQOzlh+HE
         9cu+5ZDTU646TGuUZuAtq8h4xKbC3+rJG7QV1jp+4Y6EnVkBHdrFB6pB90cZynwQ26
         f5A6no6MtNRkpRKOZOiNRirD9W0bSy4bLwgx56dw1D7iHaxv9X33YNHgQnDxBt0bZI
         fqB6esSSpr4Ru0nL1IAr6Y3UyREqd63VvWxZMZ3UJMs2T01xXlJ4xryCce7ZZhq3Rd
         2g2GmCWBEJtsSf8YBjuRB41kTh7bkoETju0eoVIY/NM9aqy3jyZ8v/yS/JAtUZJSdk
         DFYC328oA+TTQ==
Message-ID: <3b8a4886-3589-4bde-9a18-74cb6a6a7509@collabora.com>
Date:   Wed, 8 Nov 2023 17:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 10/56] media: amphion: Stop direct calls to queue
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
        kernel@collabora.com, Zhou Peng <eagle.zhou@nxp.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-11-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-11-benjamin.gaignard@collabora.com>
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

> CC: Ming Qian <ming.qian@nxp.com>
> CC: Zhou Peng <eagle.zhou@nxp.com>
> ---
>   drivers/media/platform/amphion/vpu_dbg.c  | 8 ++++----
>   drivers/media/platform/amphion/vpu_v4l2.c | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index a462d6fe4ea9..940e5bda5fa3 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -87,7 +87,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   	num = scnprintf(str, sizeof(str),
>   			"output (%2d, %2d): fmt = %c%c%c%c %d x %d, %d;",
>   			vb2_is_streaming(vq),
> -			vq->num_buffers,
> +			vb2_get_num_buffers(vq),
>   			inst->out_format.pixfmt,
>   			inst->out_format.pixfmt >> 8,
>   			inst->out_format.pixfmt >> 16,
> @@ -111,7 +111,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   	num = scnprintf(str, sizeof(str),
>   			"capture(%2d, %2d): fmt = %c%c%c%c %d x %d, %d;",
>   			vb2_is_streaming(vq),
> -			vq->num_buffers,
> +			vb2_get_num_buffers(vq),
>   			inst->cap_format.pixfmt,
>   			inst->cap_format.pixfmt >> 8,
>   			inst->cap_format.pixfmt >> 16,
> @@ -139,7 +139,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   		return 0;
>   
>   	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
> -	for (i = 0; i < vq->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>   		struct vb2_buffer *vb;
>   		struct vb2_v4l2_buffer *vbuf;
>   
> @@ -161,7 +161,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   	}
>   
>   	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
> -	for (i = 0; i < vq->num_buffers; i++) {
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
>   		struct vb2_buffer *vb;
>   		struct vb2_v4l2_buffer *vbuf;
>   
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
> index 0f6e4c666440..87afb4a18d5d 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -439,7 +439,7 @@ int vpu_get_num_buffers(struct vpu_inst *inst, u32 type)
>   	else
>   		q = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>   
> -	return q->num_buffers;
> +	return vb2_get_num_buffers(q);
>   }
>   
>   static void vpu_m2m_device_run(void *priv)
> @@ -587,7 +587,7 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
>   		  fmt->sizeimage[0], fmt->bytesperline[0],
>   		  fmt->sizeimage[1], fmt->bytesperline[1],
>   		  fmt->sizeimage[2], fmt->bytesperline[2],
> -		  q->num_buffers);
> +		  vb2_get_num_buffers(q));
>   	vb2_clear_last_buffer_dequeued(q);
>   	ret = call_vop(inst, start, q->type);
>   	if (ret)

