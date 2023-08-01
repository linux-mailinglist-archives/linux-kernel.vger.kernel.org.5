Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3B76BCE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHASsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjHASr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:47:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209F2700;
        Tue,  1 Aug 2023 11:47:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 964E58D;
        Tue,  1 Aug 2023 20:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690915592;
        bh=ffDp7O3afC7Y615B58rFG/L3MZSJl9ezabb6Gkyw+vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0TObPG/iYraSTtqErbiYAaX/ohD9htCX1BxBDPgHxHAoplB48AV2cI1tnpGMfLmv
         TAniiGebmwUJBBgFENZPZoywsZq5lGcerLALs3vNts/EJF0oKRK3unCUyMu+BU+UhT
         KjRSN463tQ/LT8YJkak/Ur/8VTbYRfxqMa28cuC8=
Date:   Tue, 1 Aug 2023 21:47:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v7 4/6] media: starfive: camss: Add video driver
Message-ID: <20230801184741.GB30382@pendragon.ideasonboard.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-5-jack.zhu@starfivetech.com>
 <8e381fd6-9475-88fc-9159-927f119a8b9c@xs4all.nl>
 <7c4e63e7-ce28-139f-373d-0fecca6839b9@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c4e63e7-ce28-139f-373d-0fecca6839b9@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On Tue, Aug 01, 2023 at 02:23:07PM +0800, Jack Zhu wrote:
> On 2023/7/27 16:49, Hans Verkuil wrote:
> > On 19/06/2023 13:28, Jack Zhu wrote:
> >> Add video driver for StarFive Camera Subsystem.
> >> 
> >> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> >> ---
> >>  .../media/platform/starfive/camss/Makefile    |   4 +-
> >>  .../media/platform/starfive/camss/stf_video.c | 724 ++++++++++++++++++
> >>  .../media/platform/starfive/camss/stf_video.h |  92 +++
> >>  3 files changed, 819 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.c
> >>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.h

[snip]

> >> diff --git a/drivers/media/platform/starfive/camss/stf_video.c b/drivers/media/platform/starfive/camss/stf_video.c
> >> new file mode 100644
> >> index 000000000000..2e6472fe51c6
> >> --- /dev/null
> >> +++ b/drivers/media/platform/starfive/camss/stf_video.c
> >> @@ -0,0 +1,724 @@

[snip]

> >> +int stf_video_register(struct stfcamss_video *video,
> >> +		       struct v4l2_device *v4l2_dev, const char *name)
> >> +{
> >> +	struct video_device *vdev;
> >> +	struct vb2_queue *q;
> >> +	struct media_pad *pad = &video->pad;
> >> +	int ret;
> >> +
> >> +	vdev = &video->vdev;
> >> +
> >> +	mutex_init(&video->q_lock);
> >> +
> >> +	q = &video->vb2_q;
> >> +	q->drv_priv = video;
> >> +	q->mem_ops = &vb2_dma_contig_memops;
> >> +	q->ops = &stf_video_vb2_q_ops;
> >> +	q->type = video->type;
> >> +	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;
> > 
> > VB2_READ support does not generally make sense for uncompressed video since
> > read() always requires a memcpy, and that makes it very inefficient.
> > 
> > It doesn't hurt though, so it is up to you whether or not you want this.
> 
> Yes, we would like to retain this feature to meet some possible special needs.

The issue with enabling READ support in drivers is that it encourages
applications to do the wrong thing. If you want to keep it, I'd like to
know what use cases you envision would strongly require it.

> >> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> >> +	q->buf_struct_size = sizeof(struct stfcamss_buffer);
> >> +	q->dev = video->stfcamss->dev;
> >> +	q->lock = &video->q_lock;
> >> +	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
> >> +	ret = vb2_queue_init(q);
> >> +	if (ret < 0) {
> >> +		dev_err(video->stfcamss->dev,
> >> +			"Failed to init vb2 queue: %d\n", ret);
> >> +		goto err_vb2_init;
> >> +	}
> >> +
> >> +	pad->flags = MEDIA_PAD_FL_SINK;
> >> +	ret = media_entity_pads_init(&vdev->entity, 1, pad);
> >> +	if (ret < 0) {
> >> +		dev_err(video->stfcamss->dev,
> >> +			"Failed to init video entity: %d\n", ret);
> >> +		goto err_vb2_init;
> >> +	}
> >> +
> >> +	mutex_init(&video->lock);
> >> +
> >> +	if (video->id == STF_V_LINE_WR) {
> >> +		video->formats = formats_pix_wr;
> >> +		video->nformats = ARRAY_SIZE(formats_pix_wr);
> >> +		video->bpl_alignment = 8;
> >> +	} else {
> >> +		video->formats = formats_pix_isp;
> >> +		video->nformats = ARRAY_SIZE(formats_pix_isp);
> >> +		video->bpl_alignment = 1;
> >> +	}
> >> +
> >> +	ret = stf_video_init_format(video);
> >> +	if (ret < 0) {
> >> +		dev_err(video->stfcamss->dev,
> >> +			"Failed to init format: %d\n", ret);
> >> +		goto err_vid_init_format;
> >> +	}
> >> +
> >> +	vdev->fops = &stf_vid_fops;
> >> +	vdev->ioctl_ops = &stf_vid_ioctl_ops;
> >> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
> >> +	vdev->vfl_dir = VFL_DIR_RX;
> >> +	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
> >> +	vdev->release = stf_video_release;
> >> +	vdev->v4l2_dev = v4l2_dev;
> >> +	vdev->queue = &video->vb2_q;
> >> +	vdev->lock = &video->lock;
> >> +	strscpy(vdev->name, name, sizeof(vdev->name));
> >> +
> >> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, video->id);
> >> +	if (ret < 0) {
> >> +		dev_err(video->stfcamss->dev,
> >> +			"Failed to register video device: %d\n", ret);
> >> +		goto err_vid_reg;
> >> +	}
> >> +
> >> +	video_set_drvdata(vdev, video);
> >> +	return 0;
> >> +
> >> +err_vid_reg:
> >> +err_vid_init_format:
> >> +	media_entity_cleanup(&vdev->entity);
> >> +	mutex_destroy(&video->lock);
> >> +err_vb2_init:
> >> +	mutex_destroy(&video->q_lock);
> >> +	return ret;
> >> +}

[snip]

-- 
Regards,

Laurent Pinchart
