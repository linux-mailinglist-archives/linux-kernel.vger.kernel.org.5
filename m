Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5D7E5BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjKHQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjKHQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:55:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29351BE2;
        Wed,  8 Nov 2023 08:55:19 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B5B56607699;
        Wed,  8 Nov 2023 16:55:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699462518;
        bh=x0X3+hz1eLsm7RowObDnmSRMEbSmWS82Ri5R/c672DI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PmGxV2yyqYJ8vEh9UpWUC0nxLHF+0jH5ErcGBLcYoi2aIZ4ChTZ1LA3CAJxCLiPQ5
         cSk2Tw2eO31X9c3EGfEUtn71/H6a6BAGOab8O2DIAKB3xWzLB/NbzjqEsUKAd3YqcV
         moVeFO0HtyAYFSwkHdwRb/1ASUsFFxSjBtU6AwwN/fkLuGKkSnNzNjBBwF43v46OZ5
         Qr8zmnwqcf8D3BluW3TuRmStKOHrsnghwQQ2BtquuNzh6dG8/CLuKfPu1V0zd0uGFB
         66qkyJ4w08bxdxJLNTALH0L1CoqoNQ7lKcnoq/PCoHfcM7UCgRyK4Husut9wLMJsZ3
         x4jQsFDAPXlqQ==
Message-ID: <be16b724-a8fb-4928-bff6-d95e1224bd20@collabora.com>
Date:   Wed, 8 Nov 2023 17:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/56] media: amphion: Use vb2_get_buffer() instead of
 directly access to buffers array
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
 <20231031163104.112469-10-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-10-benjamin.gaignard@collabora.com>
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

> CC: Ming Qian <ming.qian@nxp.com>
> CC: Zhou Peng <eagle.zhou@nxp.com>
> ---
>   drivers/media/platform/amphion/vpu_dbg.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
> index 982c2c777484..a462d6fe4ea9 100644
> --- a/drivers/media/platform/amphion/vpu_dbg.c
> +++ b/drivers/media/platform/amphion/vpu_dbg.c
> @@ -140,11 +140,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   
>   	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
>   	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +		struct vb2_buffer *vb;
> +		struct vb2_v4l2_buffer *vbuf;
> +
> +		vb = vb2_get_buffer(vq, i);
> +		if (!vb)
> +			continue;
>   
>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>   			continue;
> +
> +		vbuf = to_vb2_v4l2_buffer(vb);
> +
>   		num = scnprintf(str, sizeof(str),
>   				"output [%2d] state = %10s, %8s\n",
>   				i, vb2_stat_name[vb->state],
> @@ -155,11 +162,18 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
>   
>   	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
>   	for (i = 0; i < vq->num_buffers; i++) {
> -		struct vb2_buffer *vb = vq->bufs[i];
> -		struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +		struct vb2_buffer *vb;
> +		struct vb2_v4l2_buffer *vbuf;
> +
> +		vb = vb2_get_buffer(vq, i);
> +		if (!vb)
> +			continue;
>   
>   		if (vb->state == VB2_BUF_STATE_DEQUEUED)
>   			continue;
> +
> +		vbuf = to_vb2_v4l2_buffer(vb);
> +
>   		num = scnprintf(str, sizeof(str),
>   				"capture[%2d] state = %10s, %8s\n",
>   				i, vb2_stat_name[vb->state],

