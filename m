Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2397A666F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjISOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjISOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:19:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518EB0;
        Tue, 19 Sep 2023 07:19:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42FCC433C7;
        Tue, 19 Sep 2023 14:19:29 +0000 (UTC)
Message-ID: <d52bff95-7cee-4e75-9f77-488384e92998@xs4all.nl>
Date:   Tue, 19 Sep 2023 16:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/49] media: usb: cx231xx: Stop direct calls to queue
 num_buffers field
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
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-39-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-39-benjamin.gaignard@collabora.com>
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

On 14/09/2023 15:33, Benjamin Gaignard wrote:
> Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/usb/cx231xx/cx231xx-417.c   | 5 +++--
>  drivers/media/usb/cx231xx/cx231xx-video.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
> index c5e21785fafe..9ec0b7e355e2 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-417.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-417.c
> @@ -1218,13 +1218,14 @@ static int queue_setup(struct vb2_queue *vq,
>  		       unsigned int sizes[], struct device *alloc_devs[])
>  {
>  	struct cx231xx *dev = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  	unsigned int size = mpeglinesize * mpeglines;
>  
>  	dev->ts1.ts_packet_size  = mpeglinesize;
>  	dev->ts1.ts_packet_count = mpeglines;
>  
> -	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
> -		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < CX231XX_MIN_BUF)
> +		*nbuffers = CX231XX_MIN_BUF - q_num_bufs;

Drop the check, update min_buffers_needed from 1 to CX231XX_MIN_BUF.

>  
>  	if (*nplanes)
>  		return sizes[0] < size ? -EINVAL : 0;
> diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
> index e23b8ccd79d4..c8eb4222319d 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-video.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-video.c
> @@ -714,11 +714,12 @@ static int queue_setup(struct vb2_queue *vq,
>  		       unsigned int sizes[], struct device *alloc_devs[])
>  {
>  	struct cx231xx *dev = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  
>  	dev->size = (dev->width * dev->height * dev->format->depth + 7) >> 3;
>  
> -	if (vq->num_buffers + *nbuffers < CX231XX_MIN_BUF)
> -		*nbuffers = CX231XX_MIN_BUF - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < CX231XX_MIN_BUF)
> +		*nbuffers = CX231XX_MIN_BUF - q_num_bufs;

Ditto.

>  
>  	if (*nplanes)
>  		return sizes[0] < dev->size ? -EINVAL : 0;

Regards,

	Hans
