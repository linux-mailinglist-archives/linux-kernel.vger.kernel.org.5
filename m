Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2C7CD933
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjJRKae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:30:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA258EA;
        Wed, 18 Oct 2023 03:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F7EC433C7;
        Wed, 18 Oct 2023 10:30:24 +0000 (UTC)
Message-ID: <f677c49a-15e0-4d80-9359-57ea50f19d01@xs4all.nl>
Date:   Wed, 18 Oct 2023 12:30:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 35/56] media: cedrus: Stop direct calls to queue
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
        kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
 <20231017144756.34719-36-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231017144756.34719-36-benjamin.gaignard@collabora.com>
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
> Use vb2_get_num_buffers() and queue max_num_buffers field

Reference to max_num_buffers which doesn't exist yet.

> to avoid using queue num_buffer field directly.

num_buffer -> num_buffers

> This allows us to change how the number of buffers is computed in the
> futur.

futur -> future

Regards,

	Hans

> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> CC: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 9 +++++++--
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 9 +++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> index dfb401df138a..3e2843ef6cce 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -653,8 +653,13 @@ static void cedrus_h264_stop(struct cedrus_ctx *ctx)
>  
>  	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>  
> -	for (i = 0; i < vq->num_buffers; i++) {
> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;
> +
> +		buf = vb2_to_cedrus_buffer(vb);
>  
>  		if (buf->codec.h264.mv_col_buf_size > 0) {
>  			dma_free_attrs(dev->dev,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index fc9297232456..52e94c8f2f01 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -869,8 +869,13 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
>  
>  	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>  
> -	for (i = 0; i < vq->num_buffers; i++) {
> -		buf = vb2_to_cedrus_buffer(vb2_get_buffer(vq, i));
> +	for (i = 0; i < vb2_get_num_buffers(vq); i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(vq, i);
> +
> +		if (!vb)
> +			continue;
> +
> +		buf = vb2_to_cedrus_buffer(vb);
>  
>  		if (buf->codec.h265.mv_col_buf_size > 0) {
>  			dma_free_attrs(dev->dev,

