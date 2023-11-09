Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CA7E69CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjKILhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjKILhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:37:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC622D76;
        Thu,  9 Nov 2023 03:37:16 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D800F660748C;
        Thu,  9 Nov 2023 11:37:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699529835;
        bh=wUHoc5zpet6eywYkyKBwFgxm3jsVkAzT68bGG5YHoIY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nkL9i3Il5m690763T3RMOIMD67YVb03EoPmOSqYCDXOlmo75ZLTIXKuy//GXgwLul
         uHn26mhT0z35qefwsRtuufOwdrvykYJ8yyJxfdZYR35hTqHqOwkvo+PZqZNnqGsIbd
         SU6USvy4GtCn+VvxmLwPKldxc/wQZo5JRJ7DozA1H1nunrbt4KeMQQersrLbciEYSn
         WxOMSIeKEp8qJPfQRDgBgiJPjFO3xp+Xw2LSYJQOJJyVpdFFXAKd/Jy1k3El9zI0e9
         PQj0GdJqxJ6wQZTY/33Fb8MpBnn2SFQNtLojwoPhM00+gFhQZMh5KLSVfO7ckAd9Mp
         FBE0SBgZySLyA==
Message-ID: <71cfb62d-1ad0-41cf-ac7e-f0a9ac6fe926@collabora.com>
Date:   Thu, 9 Nov 2023 12:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 42/56] media: usb: usbtv: Stop direct calls to queue
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
 <20231031163104.112469-43-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-43-benjamin.gaignard@collabora.com>
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

> ---
>   drivers/media/usb/usbtv/usbtv-video.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
> index 1e30e05953dc..62a583040cd4 100644
> --- a/drivers/media/usb/usbtv/usbtv-video.c
> +++ b/drivers/media/usb/usbtv/usbtv-video.c
> @@ -726,9 +726,10 @@ static int usbtv_queue_setup(struct vb2_queue *vq,
>   {
>   	struct usbtv *usbtv = vb2_get_drv_priv(vq);
>   	unsigned size = USBTV_CHUNK * usbtv->n_chunks * 2 * sizeof(u32);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>   
> -	if (vq->num_buffers + *nbuffers < 2)
> -		*nbuffers = 2 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 2)
> +		*nbuffers = 2 - q_num_bufs;
>   	if (*nplanes)
>   		return sizes[0] < size ? -EINVAL : 0;
>   	*nplanes = 1;

