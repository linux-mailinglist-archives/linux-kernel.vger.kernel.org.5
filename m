Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595E27B5071
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjJBKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjJBKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:35:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED0B0;
        Mon,  2 Oct 2023 03:35:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2B1C433C9;
        Mon,  2 Oct 2023 10:35:33 +0000 (UTC)
Message-ID: <46b3af72-d458-439d-9f2c-11a707acafa9@xs4all.nl>
Date:   Mon, 2 Oct 2023 12:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: imx-jpeg: notify source chagne event when the
 first picture parsed
Content-Language: en-US, nl
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        mirela.rabulea@oss.nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, eagle.zhou@nxp.com,
        tao.jiang_2@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230928053723.20765-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230928053723.20765-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 07:37, Ming Qian wrote:
> After gstreamer rework the dynamic resolution change handling, gstreamer
> stop doing capture buffer allocation based on guesses and wait for the
> source change event when available. It requires driver always notify
> source change event in the initialization, even if the size parsed is
> equal to the size set on capture queue. otherwise, the pipeline will be
> stalled.
> 
> Currently driver may not notify source change event if the parsed format
> and size are equal to those previously established, but it may stall the
> gstreamer pipeline.
> 
> The link of gstreamer patch is
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/4437
> 
> Fixes: b4e1fb8643da ("media: imx-jpeg: Support dynamic resolution change")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 7 ++++++-
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 3af0af8ac07b..372f3007ff43 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -1348,7 +1348,8 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>  	q_data_cap = mxc_jpeg_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
>  	if (mxc_jpeg_compare_format(q_data_cap->fmt, jpeg_src_buf->fmt))
>  		jpeg_src_buf->fmt = q_data_cap->fmt;
> -	if (q_data_cap->fmt != jpeg_src_buf->fmt ||
> +	if (!ctx->source_change_cnt ||
> +	    q_data_cap->fmt != jpeg_src_buf->fmt ||
>  	    q_data_cap->w != jpeg_src_buf->w ||
>  	    q_data_cap->h != jpeg_src_buf->h) {
>  		dev_dbg(dev, "Detected jpeg res=(%dx%d)->(%dx%d), pixfmt=%c%c%c%c\n",
> @@ -1392,6 +1393,7 @@ static bool mxc_jpeg_source_change(struct mxc_jpeg_ctx *ctx,
>  		mxc_jpeg_sizeimage(q_data_cap);
>  		notify_src_chg(ctx);
>  		ctx->source_change = 1;
> +		ctx->source_change_cnt++;
>  		if (vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
>  			mxc_jpeg_set_last_buffer(ctx);
>  	}
> @@ -1611,6 +1613,9 @@ static int mxc_jpeg_queue_setup(struct vb2_queue *q,
>  	for (i = 0; i < *nplanes; i++)
>  		sizes[i] = mxc_jpeg_get_plane_size(q_data, i);
>  
> +	if (V4L2_TYPE_IS_OUTPUT(q->type))
> +		ctx->source_change_cnt = 0;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index d80e94cc9d99..b7e94fa50e02 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -99,6 +99,7 @@ struct mxc_jpeg_ctx {
>  	enum mxc_jpeg_enc_state		enc_state;
>  	int				slot;
>  	unsigned int			source_change;
> +	unsigned int			source_change_cnt;

This is a confusing field. It is not a counter at all, it is just a
bool to indicate if the initial source change event was raised or not.

So something like:

	bool need_initial_source_change_evt;

(feel free to give it a better name!)

It is certainly not a counter.

Regards,

	Hans

>  	bool				header_parsed;
>  	struct v4l2_ctrl_handler	ctrl_handler;
>  	u8				jpeg_quality;

