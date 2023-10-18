Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22497CD93C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjJRKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRKcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:32:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15756BA;
        Wed, 18 Oct 2023 03:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA133C433C7;
        Wed, 18 Oct 2023 10:32:14 +0000 (UTC)
Message-ID: <ae494e9e-63da-4644-8653-b29d76021907@xs4all.nl>
Date:   Wed, 18 Oct 2023 12:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 39/56] media: usb: Stop direct calls to queue
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
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
 <20231017144756.34719-40-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231017144756.34719-40-benjamin.gaignard@collabora.com>
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

Subject line doesn't mention 'airspy:'

Regards,

	Hans

On 17/10/2023 16:47, Benjamin Gaignard wrote:
> Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
> This allows us to change how the number of buffers is computed in the
> futur.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/usb/airspy/airspy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
> index 462eb8423506..e24e655fb1db 100644
> --- a/drivers/media/usb/airspy/airspy.c
> +++ b/drivers/media/usb/airspy/airspy.c
> @@ -482,12 +482,13 @@ static int airspy_queue_setup(struct vb2_queue *vq,
>  		unsigned int *nplanes, unsigned int sizes[], struct device *alloc_devs[])
>  {
>  	struct airspy *s = vb2_get_drv_priv(vq);
> +	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
>  
>  	dev_dbg(s->dev, "nbuffers=%d\n", *nbuffers);
>  
>  	/* Need at least 8 buffers */
> -	if (vq->num_buffers + *nbuffers < 8)
> -		*nbuffers = 8 - vq->num_buffers;
> +	if (q_num_bufs + *nbuffers < 8)
> +		*nbuffers = 8 - q_num_bufs;
>  	*nplanes = 1;
>  	sizes[0] = PAGE_ALIGN(s->buffersize);
>  

