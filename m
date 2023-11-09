Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382767E671F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjKIJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjKIJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:50:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21842D51;
        Thu,  9 Nov 2023 01:50:51 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BDE56607410;
        Thu,  9 Nov 2023 09:50:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699523450;
        bh=wHz7BSLit9iJCz9Rq7LuGR5W9A9QLTf6UvjPIsXnOb4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f5os2KkBrMxX7fKenpnv0S5pHDaJXkA071okahwLyfpXWIStY7bRsAF0CUa32phoX
         8AHY53GexYwfCna9GKDz1KqAMNkk8NYWLVLbY70mI9Fbea7AU6wshtA7WPKHoFIM97
         W0UOUcQiDQvQByogIiE39S0vAeZ+DBZCVxFeSZ/r00GOXZZBRDGJe5K1X2clGmzSwk
         abZsQVkbsElbTHwhBMz0A5TrbFKMzUd8Nnr1lUkcnd18lIyxs0hknHz6Ew4gbEH0Ov
         I4cKg3/FgYk5ijEx3i35e5TUbwsbYGjhMRPhq/gvXFdz+GdVl/UlYfHVyosmmkj9JQ
         E9Daww0PvlHvA==
Message-ID: <fc11c361-7d5b-493f-96c8-8495293f2544@collabora.com>
Date:   Thu, 9 Nov 2023 10:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/56] media: dvb-core: Do not initialize twice queue
 num_buffer field
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
 <20231031163104.112469-20-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-20-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> The above memset already zeroed all the ctx fields, it is useless
> to do it here again.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/media/dvb-core/dvb_vb2.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
> index 3a966fdf814c..a731b755a0b9 100644
> --- a/drivers/media/dvb-core/dvb_vb2.c
> +++ b/drivers/media/dvb-core/dvb_vb2.c
> @@ -177,7 +177,6 @@ int dvb_vb2_init(struct dvb_vb2_ctx *ctx, const char *name, int nonblocking)
>   	q->ops = &dvb_vb2_qops;
>   	q->mem_ops = &vb2_vmalloc_memops;
>   	q->buf_ops = &dvb_vb2_buf_ops;
> -	q->num_buffers = 0;

A few lines above this one is this:

	q->is_output = 0;

Can this also be included in this (cleanup) patch?

Regards,

Andrzej

>   	ret = vb2_core_queue_init(q);
>   	if (ret) {
>   		ctx->state = DVB_VB2_STATE_NONE;

