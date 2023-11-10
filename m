Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE49D7E84F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjKJVIe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKJVId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:08:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3814C4;
        Fri, 10 Nov 2023 13:08:29 -0800 (PST)
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
        by madras.collabora.co.uk (Postfix) with ESMTP id D3FAD66073EF;
        Fri, 10 Nov 2023 21:08:27 +0000 (GMT)
From:   "Daniel Almeida" <daniel.almeida@collabora.com>
In-Reply-To: <20231109201640.340556-4-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Fri, 10 Nov 2023 21:08:27 +0000
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
Message-ID: <667d-654e9c00-5-40e97880@22375169>
Subject: =?utf-8?q?Re=3A?= [PATCH 4/4] =?utf-8?q?media=3A?==?utf-8?q?_rkvdec=3A?= 
 Hook the =?utf-8?q?(TRY=5F)DECODER=5FCMD?= stateless ioctls
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
> Fixes: ed7bb87d3d03 ("media: rkvdec: Enable capture buffer holding for H264")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 84a41792cb4b..ac398b5a9736 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -461,6 +461,9 @@ static const struct v4l2_ioctl_ops rkvdec_ioctl_ops = {
>  
>  	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
>  	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
> +
> +	.vidioc_decoder_cmd = v4l2_m2m_ioctl_stateless_decoder_cmd,
> +	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_stateless_try_decoder_cmd,
>  };
>  
>  static int rkvdec_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
> -- 
> 2.42.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

