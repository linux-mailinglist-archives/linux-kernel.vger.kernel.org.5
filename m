Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD55E7E6A96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjKIMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:31:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F122590;
        Thu,  9 Nov 2023 04:31:09 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7593E660747A;
        Thu,  9 Nov 2023 12:31:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699533067;
        bh=QHgtkMbPR42XKzSt/d+F/ArcOpNb7M22RF22MC40QeM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBIwjCKMOyEVutf0k2TMxWSVOmm3Cghe1TCrrR5c6GflI/qkDOAlYNLENryacWSA4
         eTJ5LKYeM/TzU+645E9Zfll4bF96thUjF619GeowEpaQi08Fn+yWnkJuLbsHwTxP5S
         5FF5s0iPPpyXbuR2NC4h5FF7rbUFkErs2EYIkeJ3QD6d6iJ8B3xK+NtxBYFsGMGefw
         VAMnREmoHUj4VHHKldKmK6FssrknRoE9gg3ftextkd7l3LVxp7zaheXW53db6/7v+Z
         HBw8TS3kKXEifNJE0DdNRKBgc8WiEXT+ZulaQRey88yBiUVKAb1vnWjefmOHWin7wW
         NlqHrKsePhs7w==
Message-ID: <d020a006-e413-4004-82ff-0fe7e0894df8@collabora.com>
Date:   Thu, 9 Nov 2023 13:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 45/56] media: test-drivers: vivid: Increase max
 supported buffers for capture queues
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
 <20231031163104.112469-46-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-46-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> Change the maximum number of buffers of some capture queues in order
> to test max_num_buffers field.
> 
> Allow to allocate up to:
> - 64 buffers for video capture queue.
> - 1024 buffers for sdr capture queue.
> - 32768 buffers for vbi capture queue.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/media/test-drivers/vivid/vivid-core.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 394c9f81ea72..353f035fcd19 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -876,6 +876,20 @@ static int vivid_create_queue(struct vivid_dev *dev,
>   	q->type = buf_type;
>   	q->io_modes = VB2_MMAP | VB2_DMABUF;
>   	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
> +
> +	/*
> +	 * The maximum number of buffers is 32768 if PAGE_SHIFT == 12,
> +	 * see also MAX_BUFFER_INDEX in videobuf2-core.c. It will be less if
> +	 * PAGE_SHIFT > 12, but then max_num_buffers will be clamped by
> +	 * videobuf2-core.c to MAX_BUFFER_INDEX.
> +	 */
> +	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		q->max_num_buffers = 64;
> +	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE)
> +		q->max_num_buffers = 1024;
> +	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
> +		q->max_num_buffers = 32768;
> +
>   	if (allocators[dev->inst] != 1)
>   		q->io_modes |= VB2_USERPTR;
>   	q->drv_priv = dev;

