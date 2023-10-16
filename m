Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DE7CA171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJPIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjJPIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:20:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFCDC;
        Mon, 16 Oct 2023 01:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC20AC433C8;
        Mon, 16 Oct 2023 08:20:20 +0000 (UTC)
Message-ID: <dcf6f56a-2b6d-4178-ad8e-c0f40804aeba@xs4all.nl>
Date:   Mon, 16 Oct 2023 10:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 34/56] media: usb: cx231xx: Set min_buffers_needed to
 CX231XX_MIN_BUF
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
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-35-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012114642.19040-35-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 13:46, Benjamin Gaignard wrote:
> vb2 queue_setup checks for a minimum number of buffers so set
> min_buffers_needed to  aCX231XX_MIN_BUFnd remove the useless check in

Garbled line.

Regards,

	Hans

> cx231xx queue_setup().
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/usb/cx231xx/cx231xx-417.c   | 4 +---
>  drivers/media/usb/cx231xx/cx231xx-video.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
> index c5e21785fafe..fecdb12f5ef7 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-417.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-417.c
> @@ -1223,9 +1223,6 @@ static int queue_setup(struct vb2_queue *vq,
>  	dev->ts1.ts_packet_size  = mpeglinesize;
>  	dev->ts1.ts_packet_count = mpeglines;
>  
> -	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
> -		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
> -
>  	if (*nplanes)
>  		return sizes[0] < size ? -EINVAL : 0;
>  	*nplanes = 1;
> @@ -1777,6 +1774,7 @@ int cx231xx_417_register(struct cx231xx *dev)
>  	q = &dev->mpegq;
>  	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	q->io_modes = VB2_USERPTR | VB2_MMAP | VB2_DMABUF | VB2_READ;
> +	q->min_buffers_needed = CX231XX_MIN_BUF;
>  	q->drv_priv = dev;
>  	q->buf_struct_size = sizeof(struct cx231xx_buffer);
>  	q->ops = &cx231xx_video_qops;
> diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
> index e23b8ccd79d4..26b593844157 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-video.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-video.c
> @@ -717,9 +717,6 @@ static int queue_setup(struct vb2_queue *vq,
>  
>  	dev->size = (dev->width * dev->height * dev->format->depth + 7) >> 3;
>  
> -	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
> -		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
> -
>  	if (*nplanes)
>  		return sizes[0] < dev->size ? -EINVAL : 0;
>  	*nplanes = 1;
> @@ -1805,6 +1802,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
>  	q = &dev->vidq;
>  	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>  	q->io_modes = VB2_USERPTR | VB2_MMAP | VB2_DMABUF | VB2_READ;
> +	q->min_buffers_needed = CX231XX_MIN_BUF;
>  	q->drv_priv = dev;
>  	q->buf_struct_size = sizeof(struct cx231xx_buffer);
>  	q->ops = &cx231xx_video_qops;

