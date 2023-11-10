Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B782C7E84F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjKJVGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 16:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjKJVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:06:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF839F;
        Fri, 10 Nov 2023 13:06:18 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id F295666073EF;
        Fri, 10 Nov 2023 21:06:15 +0000 (GMT)
From:   "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 10 Nov 2023 21:06:15 +0000
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Nicolas Dufresne" <nicolas.dufresne@collabora.com>,
        "Sebastian Fricke" <sebastian.fricke@collabora.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
To:     "Paul Kocialkowski" <paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Message-ID: <667d-654e9b80-1-40e97880@22375103>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/4] =?utf-8?q?media=3A?==?utf-8?q?_vicodec=3A?= 
 Disable =?utf-8?q?(TRY=5F)DECODER=5FCMD?= for the stateless case
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thursday, November 09, 2023 17:16 -03, Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> The (TRY_)DECODER_CMD ioctls are only useful for stateful decoders and for
> stateless decoders that support holding capture buffers (which is not the case
> for this driver).
> 
> Disable them when registering the stateless decoder.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../media/test-drivers/vicodec/vicodec-core.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
> index 6f0e20df74e9..8f7a2b153ee9 100644
> --- a/drivers/media/test-drivers/vicodec/vicodec-core.c
> +++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
> @@ -1240,6 +1240,12 @@ static int vicodec_decoder_cmd(struct file *file, void *fh,
>  	struct vicodec_ctx *ctx = file2ctx(file);
>  	int ret;
>  
> +	/*
> +	 * This ioctl should not be used with a stateless codec that doesn't
> +	 * support holding buffers and the associated flush command.
> +	 */
> +	WARN_ON(ctx->is_stateless);
> +
>  	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, dc);
>  	if (ret < 0)
>  		return ret;
> @@ -2025,7 +2031,7 @@ static const struct v4l2_m2m_ops m2m_ops = {
>  
>  static int register_instance(struct vicodec_dev *dev,
>  			     struct vicodec_dev_instance *dev_instance,
> -			     const char *name, bool is_enc)
> +			     const char *name, bool is_enc, bool is_stateless)
>  {
>  	struct video_device *vfd;
>  	int ret;
> @@ -2045,10 +2051,11 @@ static int register_instance(struct vicodec_dev *dev,
>  	strscpy(vfd->name, name, sizeof(vfd->name));
>  	vfd->device_caps = V4L2_CAP_STREAMING |
>  		(multiplanar ? V4L2_CAP_VIDEO_M2M_MPLANE : V4L2_CAP_VIDEO_M2M);
> -	if (is_enc) {
> +	if (is_enc || is_stateless) {
>  		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
>  		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
> -	} else {
> +	}
> +	if (!is_enc) {
>  		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
>  		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
>  	}
> @@ -2107,17 +2114,17 @@ static int vicodec_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, dev);
>  
>  	ret = register_instance(dev, &dev->stateful_enc, "stateful-encoder",
> -				true);
> +				true, false);
>  	if (ret)
>  		goto unreg_dev;
>  
>  	ret = register_instance(dev, &dev->stateful_dec, "stateful-decoder",
> -				false);
> +				false, false);
>  	if (ret)
>  		goto unreg_sf_enc;
>  
>  	ret = register_instance(dev, &dev->stateless_dec, "stateless-decoder",
> -				false);
> +				false, true);
>  	if (ret)
>  		goto unreg_sf_dec;
>  
> -- 
> 2.42.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

