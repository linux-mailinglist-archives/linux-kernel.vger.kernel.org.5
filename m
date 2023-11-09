Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747617E69C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKILgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjKILgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:36:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72E1991;
        Thu,  9 Nov 2023 03:36:11 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E3BB66607421;
        Thu,  9 Nov 2023 11:36:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699529770;
        bh=0/A01qhv+t/yxdlH4Uvpb5ikYV4gg6UyE57UO6NZhgw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FG515hO3HjrUoULvSvT8VrKX3xPTGhoWcL+Y7qvZnyMA2aPTy1YXj9DAPO31UMTjV
         M/ZEPpT/iG2nkXY83ACoykIN132N+TFuiFhdo0aWI6PGD5X7Phrc3REt048TB4woQk
         9iGfao44RM9abMps+U1mSCMncgz79o40ckh7ufYYzdUX2YVX4PQF0X8HBebiEDSSWG
         4Cecd4zyffcfzbnw5gccysBL1rHboOZlrtGTDdpVvF3o/E3Zp4+oya3OKcYFCZnsNO
         65Bkdk/aIsPuTaaKA4VzyvIPvAuXZbKmazdg5DnfnFxIDoHo1fE31/HeQZjIqUw2dE
         /cc2HV0dy3luA==
Message-ID: <ff26f953-35cc-4206-a8e9-86cf05acdc71@collabora.com>
Date:   Thu, 9 Nov 2023 12:36:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 41/56] media: usb: hackrf: Stop direct calls to queue
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
        kernel@collabora.com, Antti Palosaari <crope@iki.fi>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-42-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-42-benjamin.gaignard@collabora.com>
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

> CC: Antti Palosaari <crope@iki.fi>
> ---
>   drivers/media/usb/hackrf/hackrf.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
> index 3e535be2c520..9c0ecd5f056c 100644
> --- a/drivers/media/usb/hackrf/hackrf.c
> +++ b/drivers/media/usb/hackrf/hackrf.c
> @@ -753,12 +753,13 @@ static int hackrf_queue_setup(struct vb2_queue *vq,
>   		unsigned int *nplanes, unsigned int sizes[], struct device *alloc_devs[])
>   {
>   	struct hackrf_dev *dev = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>   
>   	dev_dbg(dev->dev, "nbuffers=%d\n", *nbuffers);
>   
>   	/* Need at least 8 buffers */
> -	if (vq->num_buffers + *nbuffers < 8)
> -		*nbuffers = 8 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 8)
> +		*nbuffers = 8 - q_num_bufs;
>   	*nplanes = 1;
>   	sizes[0] = PAGE_ALIGN(dev->buffersize);
>   

