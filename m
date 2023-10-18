Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1667CD8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjJRKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:19:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12360BA;
        Wed, 18 Oct 2023 03:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C089EC433C8;
        Wed, 18 Oct 2023 10:19:17 +0000 (UTC)
Message-ID: <0fb31f73-2743-44c0-af1b-ac30c582e45a@xs4all.nl>
Date:   Wed, 18 Oct 2023 12:19:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 22/56] media: pci: tw686x: Set min_buffers_needed to 3
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
 <20231017144756.34719-23-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231017144756.34719-23-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 16:47, Benjamin Gaignard wrote:
> vb2 queue_setup checks for a minimum number of buffers so set
> min_buffers_needed to 3 and remove the useless check in
> tw686x_queue_setup().
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/media/pci/tw686x/tw686x-video.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
> index 3ebf7a2c95f0..74cd864365aa 100644
> --- a/drivers/media/pci/tw686x/tw686x-video.c
> +++ b/drivers/media/pci/tw686x/tw686x-video.c
> @@ -426,13 +426,6 @@ static int tw686x_queue_setup(struct vb2_queue *vq,
>  	unsigned int szimage =
>  		(vc->width * vc->height * vc->format->depth) >> 3;
>  
> -	/*
> -	 * Let's request at least three buffers: two for the
> -	 * DMA engine and one for userspace.
> -	 */
> -	if (vq->num_buffers + *nbuffers < 3)
> -		*nbuffers = 3 - vq->num_buffers;
> -
>  	if (*nplanes) {
>  		if (*nplanes != 1 || sizes[0] < szimage)
>  			return -EINVAL;
> @@ -1221,7 +1214,11 @@ int tw686x_video_init(struct tw686x_dev *dev)
>  		vc->vidq.ops = &tw686x_video_qops;
>  		vc->vidq.mem_ops = dev->dma_ops->mem_ops;
>  		vc->vidq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -		vc->vidq.min_buffers_needed = 2;
> +		/*
> +		 * Let's request at least three buffers: two for the
> +		 * DMA engine and one for userspace.
> +		 */
> +		vc->vidq.min_buffers_needed = 3;

Don't touch min_buffers_needed, just keep the current check in queue_setup.

Regards,

	Hans

>  		vc->vidq.lock = &vc->vb_mutex;
>  		vc->vidq.gfp_flags = dev->dma_mode != TW686X_DMA_MODE_MEMCPY ?
>  				     GFP_DMA32 : 0;

