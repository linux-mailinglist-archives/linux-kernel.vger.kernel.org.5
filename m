Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC47E84F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbjKJVHz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjKJVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:07:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D19F;
        Fri, 10 Nov 2023 13:07:49 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id 44D0F66073EF;
        Fri, 10 Nov 2023 21:07:47 +0000 (GMT)
From:   "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <20231109201640.340556-3-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 10 Nov 2023 21:07:46 +0000
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
Message-ID: <530d-654e9b80-9-557cd880@203483206>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/4] =?utf-8?q?media=3A?=
 =?utf-8?q?_verisilicon=3A?= Hook the =?utf-8?q?(TRY=5F)DECODER=5FCMD?= 
 stateless ioctls
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

On Thursday, November 09, 2023 17:16 -03, Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> The (TRY_)DECODER_CMD ioctls are used to support flushing when holding capture
> buffers is supported. This is the case of this driver but the ioctls were never
> hooked to the ioctl ops.
> 
> Add them to correctly support flushing.
> 
> Fixes: 340ce50f75a6 ("media: hantro: Enable HOLD_CAPTURE_BUF for H.264")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c  | 2 ++
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index a9fa05ac56a9..3a2a0f28cbfe 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -905,6 +905,8 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>  
>  	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder = func;
> +		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
> +		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
>  	} else {
>  		vpu->decoder = func;
>  		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> index b3ae037a50f6..db145519fc5d 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -785,6 +785,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
>  	.vidioc_g_selection = vidioc_g_selection,
>  	.vidioc_s_selection = vidioc_s_selection,
>  
> +	.vidioc_decoder_cmd = v4l2_m2m_ioctl_stateless_decoder_cmd,
> +	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_stateless_try_decoder_cmd,
> +
>  	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
>  	.vidioc_encoder_cmd = vidioc_encoder_cmd,
>  };
> -- 
> 2.42.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

