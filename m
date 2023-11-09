Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F17E6783
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKIKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:13:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE532D6A;
        Thu,  9 Nov 2023 02:13:34 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB51C660745D;
        Thu,  9 Nov 2023 10:13:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699524813;
        bh=tF00I9rvCUL/jzVG4vb3E9oiI67esankiKYonVaACl8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iL0EXaSzBN2yXBqt+in7a4pGMkwKIY7NFpOgD7ZWB0RKGkReOXRfR2KOFHOZlmF2e
         XnFpq97cHi8jlcDHVlUlbKYWUCHva3Vk3O8ZGybGOyJ0GlVH80bryLtHMeYCA4GN6E
         zcLMXldER/e4h+WpVYXyahJgKhgRA8NJwrLinO9jL1fDQpal8aGE68DSOLh+aHIhfx
         nXFi+GF7906kxKNhhIRSFrRNe4YQdozco1jRJDTp3ONQ/z0Ovf9P7Coz/xEKtbM8mg
         +p/q7Z/0kwExiPmOen9bJS2pO2hOcxKkqDAWUwZlvOEuQCEEQ29yeodPb6koT+A/4I
         y4kzLsW4dxrgw==
Message-ID: <99945dbe-194b-429c-b8ea-fc71dbc0b3b4@collabora.com>
Date:   Thu, 9 Nov 2023 11:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 25/56] media: pci: tw68: Stop direct calls to queue
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
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-26-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-26-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> future.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>   drivers/media/pci/tw68/tw68-video.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
> index 773a18702d36..35296c226019 100644
> --- a/drivers/media/pci/tw68/tw68-video.c
> +++ b/drivers/media/pci/tw68/tw68-video.c
> @@ -360,13 +360,13 @@ static int tw68_queue_setup(struct vb2_queue *q,
>   			   unsigned int sizes[], struct device *alloc_devs[])
>   {
>   	struct tw68_dev *dev = vb2_get_drv_priv(q);

Why not

	unsigned int q_num_bufs = vb2_get_num_buffers(vq);

just like in other patches in the series?

Regards,

Andrzej

> -	unsigned tot_bufs = q->num_buffers + *num_buffers;
> +	unsigned tot_bufs = vb2_get_num_buffers(q) + *num_buffers;
>   	unsigned size = (dev->fmt->depth * dev->width * dev->height) >> 3;
>   
>   	if (tot_bufs < 2)
>   		tot_bufs = 2;
>   	tot_bufs = tw68_buffer_count(size, tot_bufs);
> -	*num_buffers = tot_bufs - q->num_buffers;
> +	*num_buffers = tot_bufs - vb2_get_num_buffers(q);
>   	/*
>   	 * We allow create_bufs, but only if the sizeimage is >= as the
>   	 * current sizeimage. The tw68_buffer_count calculation becomes quite

