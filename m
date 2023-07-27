Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2714765775
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjG0PZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjG0PZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:25:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC61BC1;
        Thu, 27 Jul 2023 08:25:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 107E94A9;
        Thu, 27 Jul 2023 17:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690471464;
        bh=0Ry35vjwC+jjn2S26p5i0fCXU0DKrlIM8BhudOCLlvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQICmR6QfktMwXFfrveTldkvp0kblRN8qrUJW2gbHPutiv7VZsN98DPaFL9nLF1uC
         YIcW6ANd2PWZJzwmM71whtwXb22BSMDh/4F7c9/nbZm5/2bKwcF0k3JRnfWGOk/pr0
         x5U8dnvC38Ddz9Dloi5/uQZyrgYvcCseqrOcy+pM=
Date:   Thu, 27 Jul 2023 18:25:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v7 4/6] media: starfive: camss: Add video driver
Message-ID: <20230727152528.GI25174@pendragon.ideasonboard.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-5-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230619112838.19797-5-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Mon, Jun 19, 2023 at 07:28:36PM +0800, Jack Zhu wrote:
> Add video driver for StarFive Camera Subsystem.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---
>  .../media/platform/starfive/camss/Makefile    |   4 +-
>  .../media/platform/starfive/camss/stf_video.c | 724 ++++++++++++++++++
>  .../media/platform/starfive/camss/stf_video.h |  92 +++
>  3 files changed, 819 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.c
>  create mode 100644 drivers/media/platform/starfive/camss/stf_video.h
> 
> diff --git a/drivers/media/platform/starfive/camss/Makefile b/drivers/media/platform/starfive/camss/Makefile
> index d56ddd078a71..eb457917a914 100644
> --- a/drivers/media/platform/starfive/camss/Makefile
> +++ b/drivers/media/platform/starfive/camss/Makefile
> @@ -3,6 +3,8 @@
>  # Makefile for StarFive Camera Subsystem driver
>  #
>  
> -starfive-camss-objs += stf_camss.o
> +starfive-camss-objs += \
> +		stf_camss.o \
> +		stf_video.o
>  
>  obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
> diff --git a/drivers/media/platform/starfive/camss/stf_video.c b/drivers/media/platform/starfive/camss/stf_video.c
> new file mode 100644
> index 000000000000..2e6472fe51c6
> --- /dev/null
> +++ b/drivers/media/platform/starfive/camss/stf_video.c
> @@ -0,0 +1,724 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * stf_video.c
> + *
> + * StarFive Camera Subsystem - V4L2 device node
> + *
> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/pm_runtime.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-mc.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "stf_camss.h"
> +#include "stf_video.h"
> +
> +static const struct stfcamss_format_info formats_pix_wr[] = {
> +	{
> +		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.pixelformat = V4L2_PIX_FMT_SRGGB10,
> +		.planes = 1,
> +		.vsub = { 1 },
> +		.bpp = 10,
> +	},
> +	{
> +		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.pixelformat = V4L2_PIX_FMT_SGRBG10,
> +		.planes = 1,
> +		.vsub = { 1 },
> +		.bpp = 10,
> +	},
> +	{
> +		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.pixelformat = V4L2_PIX_FMT_SGBRG10,
> +		.planes = 1,
> +		.vsub = { 1 },
> +		.bpp = 10,
> +	},
> +	{
> +		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.pixelformat = V4L2_PIX_FMT_SBGGR10,
> +		.planes = 1,
> +		.vsub = { 1 },
> +		.bpp = 10,
> +	},
> +};
> +
> +static const struct stfcamss_format_info formats_pix_isp[] = {
> +	{
> +		.code = MEDIA_BUS_FMT_Y12_1X12,
> +		.pixelformat = V4L2_PIX_FMT_NV12,
> +		.planes = 2,
> +		.vsub = { 1, 2 },
> +		.bpp = 8,
> +	},
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Helper functions
> + */
> +
> +static int video_find_format(u32 code, u32 pixelformat,
> +			     struct stfcamss_video *video)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < video->nformats; ++i) {
> +		if (video->formats[i].code == code &&
> +		    video->formats[i].pixelformat == pixelformat)
> +			return i;
> +	}
> +
> +	for (i = 0; i < video->nformats; ++i)
> +		if (video->formats[i].code == code)
> +			return i;
> +
> +	for (i = 0; i < video->nformats; ++i)
> +		if (video->formats[i].pixelformat == pixelformat)
> +			return i;
> +

This looks weird, I don't think it does what you expect below. I think
you can drop the function, and instead use video_get_pfmt_by_mcode() to
convert the mbus code to a pixel format, and compare it to the active
pixel format in video_check_format().

> +	return -EINVAL;
> +}
> +
> +static int __video_try_fmt(struct stfcamss_video *video, struct v4l2_format *f)
> +{
> +	struct v4l2_pix_format *pix;
> +	const struct stfcamss_format_info *fi;
> +	u32 width, height;
> +	u32 bpl;
> +	unsigned int i;
> +
> +	pix = &f->fmt.pix;

You can initialize pix when declaring it.

> +
> +	for (i = 0; i < video->nformats; i++)
> +		if (pix->pixelformat == video->formats[i].pixelformat)
> +			break;
> +

	for (i = 0; i < video->nformats; i++) {
		if (pix->pixelformat == video->formats[i].pixelformat)
			break;
	}

But a helper function that looks up a format by pixelformat, similar to
video_get_pfmt_by_mcode(), would be useful. I think I would make all
those helpers return a const struct stfcamss_format_info pointer instead
of an index.

> +	if (i == video->nformats)
> +		i = 0; /* default format */
> +
> +	fi = &video->formats[i];
> +	width = pix->width;
> +	height = pix->height;
> +
> +	memset(pix, 0, sizeof(*pix));
> +
> +	pix->pixelformat = fi->pixelformat;
> +	pix->width = clamp_t(u32, width, STFCAMSS_FRAME_MIN_WIDTH,
> +			     STFCAMSS_FRAME_MAX_WIDTH);
> +	pix->height = clamp_t(u32, height, STFCAMSS_FRAME_MIN_HEIGHT,
> +			      STFCAMSS_FRAME_MAX_HEIGHT);
> +	bpl = pix->width * fi->bpp / 8;
> +	bpl = ALIGN(bpl, video->bpl_alignment);
> +	pix->bytesperline = bpl;

Does the hardware support configuring the stride ?

> +
> +	for (i = 0; i < fi->planes; ++i)
> +		pix->sizeimage += bpl * pix->height / fi->vsub[i];
> +
> +	pix->field = V4L2_FIELD_NONE;
> +	pix->colorspace = V4L2_COLORSPACE_SRGB;
> +	pix->flags = 0;
> +	pix->ycbcr_enc =
> +		V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
> +	pix->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
> +							  pix->colorspace,
> +							  pix->ycbcr_enc);
> +	pix->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix->colorspace);

This doesn't seem right for the processed output.

> +
> +	return 0;
> +}
> +
> +static int stf_video_init_format(struct stfcamss_video *video)
> +{
> +	int ret;
> +	struct v4l2_format format = {
> +		.type = video->type,
> +		.fmt.pix = {
> +			.width = 1920,
> +			.height = 1080,
> +			.pixelformat = V4L2_PIX_FMT_RGB565,

That format doesn't seem supported, let's pick V4L2_PIX_FMT_NV12.

> +		},
> +	};
> +
> +	ret = __video_try_fmt(video, &format);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	video->active_fmt = format;
> +
> +	return 0;
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Video queue operations
> + */
> +
> +static int video_queue_setup(struct vb2_queue *q,
> +			     unsigned int *num_buffers,
> +			     unsigned int *num_planes,
> +			     unsigned int sizes[],
> +			     struct device *alloc_devs[])
> +{
> +	struct stfcamss_video *video = vb2_get_drv_priv(q);
> +	const struct v4l2_pix_format *format = &video->active_fmt.fmt.pix;
> +
> +	if (*num_planes) {
> +		if (*num_planes != 1)
> +			return -EINVAL;
> +
> +		if (sizes[0] < format->sizeimage)
> +			return -EINVAL;
> +	}
> +
> +	*num_planes = 1;
> +	sizes[0] = format->sizeimage;
> +	if (!sizes[0])
> +		dev_err(video->stfcamss->dev,
> +			"%s: error size is zero!!!\n", __func__);

Shouldn't you return an error ? Also, use dev_dbg(), printing an error
message based on a condition that can easily be triggered by
unpriviledge userspace opens the door to applications flooding the
kernel log.

> +
> +	dev_dbg(video->stfcamss->dev, "planes = %d, size = %d\n",
> +		*num_planes, sizes[0]);
> +
> +	return 0;
> +}
> +
> +static int video_buf_init(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
> +	struct stfcamss_buffer *buffer =
> +		container_of(vbuf, struct stfcamss_buffer, vb);

A static inline to_stfcamss_buffer() function that wraps the
container_of() would be nice. You can use it below too.

> +	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
> +	dma_addr_t *paddr;
> +
> +	paddr = vb2_plane_cookie(vb, 0);
> +	buffer->addr[0] = *paddr;
> +
> +	if (fmt->pixelformat == V4L2_PIX_FMT_NV12 ||
> +	    fmt->pixelformat == V4L2_PIX_FMT_NV21 ||
> +	    fmt->pixelformat == V4L2_PIX_FMT_NV16 ||
> +	    fmt->pixelformat == V4L2_PIX_FMT_NV61)

Only V4L2_PIX_FMT_NV12 is listed in formats_pix_isp. Does the hardware
support the other formats ? If so, it would be nice to support them
already.

> +		buffer->addr[1] =
> +			buffer->addr[0] + fmt->bytesperline * fmt->height;

As the hardware supports non-contiguous planes, you should use the
MPLANE API (V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) and support the NV*M
formats in addition to the NV* formats.

> +
> +	return 0;
> +}
> +
> +static int video_buf_prepare(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
> +	const struct v4l2_pix_format *fmt = &video->active_fmt.fmt.pix;
> +
> +	if (fmt->sizeimage > vb2_plane_size(vb, 0)) {
> +		dev_err(video->stfcamss->dev,

dev_dbg() here too.

> +			"sizeimage = %d, plane size = %d\n",
> +			fmt->sizeimage, (unsigned int)vb2_plane_size(vb, 0));

Both are unsigned, use %u instead of %d.

> +		return -EINVAL;
> +	}
> +	vb2_set_plane_payload(vb, 0, fmt->sizeimage);
> +
> +	vbuf->field = V4L2_FIELD_NONE;
> +
> +	return 0;
> +}
> +
> +static void video_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
> +	struct stfcamss_buffer *buffer =
> +		container_of(vbuf, struct stfcamss_buffer, vb);
> +
> +	video->ops->queue_buffer(video, buffer);
> +}
> +
> +/*
> + * video_mbus_to_pix - Convert v4l2_mbus_framefmt to v4l2_pix_format
> + * @mbus: v4l2_mbus_framefmt format (input)
> + * @pix: v4l2_pix_format_mplane format (output)
> + * @f: a pointer to formats array element to be used for the conversion
> + * @alignment: bytesperline alignment value
> + *
> + * Fill the output pix structure with information from the input mbus format.
> + *
> + * Return 0 on success or a negative error code otherwise
> + */
> +static int video_mbus_to_pix(const struct v4l2_mbus_framefmt *mbus,
> +			     struct v4l2_pix_format *pix,
> +			     const struct stfcamss_format_info *f,
> +			     unsigned int alignment)
> +{
> +	u32 bytesperline;
> +	unsigned int i;
> +
> +	memset(pix, 0, sizeof(*pix));
> +	v4l2_fill_pix_format(pix, mbus);
> +	pix->pixelformat = f->pixelformat;
> +	bytesperline = pix->width * f->bpp / 8;
> +	bytesperline = ALIGN(bytesperline, alignment);
> +	pix->bytesperline = bytesperline;
> +
> +	for (i = 0; i < f->planes; ++i)
> +		pix->sizeimage += bytesperline * pix->height / f->vsub[i];

This function is used for validation of the format only, the
bytesperline and sizeimage values are never used. You can simplify the
driver by dropping the function and comparing the width, height and
field of the subdev and video device from the v4l2_mbus_framefmt and
v4l2_pix_format respectively in video_check_format().
video_get_subdev_format() will then take a v4l2_mbus_framefmt pointer,
not a v4l2_pix_format.

The format match check still needs conversion of the 

To check the format, you need to convert the mbus code from the subdev
to a pixel format using the 

> +
> +	return 0;
> +}
> +
> +static struct v4l2_subdev *video_remote_subdev(struct stfcamss_video *video,
> +					       u32 *pad)
> +{
> +	struct media_pad *remote;
> +
> +	remote = media_pad_remote_pad_first(&video->pad);
> +
> +	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
> +		return NULL;
> +
> +	if (pad)
> +		*pad = remote->index;
> +
> +	return media_entity_to_v4l2_subdev(remote->entity);

As the connected subdev is always the same (the CSI-2 RX for the raw
capture video device and the ISP for the processed capture video
device), I would store a pointer to the connected subdev in the
stfcamss_video structure at registration time. You can pass the pointer
to the stf_video_register() function.

> +}
> +
> +static int video_get_subdev_format(struct stfcamss_video *video,
> +				   struct v4l2_format *format)
> +{
> +	struct v4l2_pix_format *pix = &video->active_fmt.fmt.pix;
> +	struct v4l2_subdev_format fmt;
> +	struct v4l2_subdev *subdev;
> +	u32 pixelformat;
> +	u32 pad;
> +	int ret;
> +
> +	subdev = video_remote_subdev(video, &pad);
> +	if (!subdev)
> +		return -EPIPE;
> +
> +	fmt.pad = pad;
> +	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +
> +	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);

Use v4l2_subdev_call_state_active() to support the subdev state API.

> +	if (ret)
> +		return ret;
> +
> +	pixelformat = pix->pixelformat;
> +	ret = video_find_format(fmt.format.code, pixelformat, video);
> +	if (ret < 0)
> +		return ret;
> +
> +	format->type = video->type;
> +
> +	return video_mbus_to_pix(&fmt.format, &format->fmt.pix,
> +				 &video->formats[ret], video->bpl_alignment);
> +}
> +
> +static int video_check_format(struct stfcamss_video *video)
> +{
> +	struct v4l2_pix_format *pix = &video->active_fmt.fmt.pix;
> +	struct v4l2_format format;
> +	struct v4l2_pix_format *sd_pix = &format.fmt.pix;
> +	int ret;
> +
> +	sd_pix->pixelformat = pix->pixelformat;
> +	ret = video_get_subdev_format(video, &format);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pix->pixelformat != sd_pix->pixelformat ||
> +	    pix->height != sd_pix->height ||
> +	    pix->width != sd_pix->width ||
> +	    pix->field != format.fmt.pix.field) {
> +		dev_err(video->stfcamss->dev,
> +			"not match:\n"

Let's be a bit clearer: "Format mismatch between ISP and video device".

> +			"pixelformat: 0x%x <-> 0x%x\n"
> +			"height: %d <-> %d\n"
> +			"field: %d <-> %d\n",

Use dev_dbg(), and make the message a single line (without '\n'), or it
will mess up formatting in the kernel log.

> +			pix->pixelformat, sd_pix->pixelformat,
> +			pix->height, sd_pix->height,
> +			pix->field, format.fmt.pix.field);
> +		return -EPIPE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int video_start_streaming(struct vb2_queue *q, unsigned int count)
> +{
> +	struct stfcamss_video *video = vb2_get_drv_priv(q);
> +	struct video_device *vdev = &video->vdev;
> +	struct media_entity *entity;
> +	struct media_pad *pad;
> +	struct v4l2_subdev *subdev;
> +	int ret;
> +
> +	ret = video_device_pipeline_start(vdev, &video->stfcamss->pipe);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev,
> +			"Failed to media_pipeline_start: %d\n", ret);

flush_buffers() should be called here to release the buffers that have
been queued before starting streaming.

> +		return ret;
> +	}
> +
> +	ret = video_check_format(video);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = pm_runtime_resume_and_get(video->stfcamss->dev);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev, "power up failed %d\n", ret);
> +		goto error;
> +	}
> +
> +	entity = &vdev->entity;
> +	while (1) {
> +		pad = &entity->pads[0];
> +		if (!(pad->flags & MEDIA_PAD_FL_SINK))
> +			break;
> +
> +		pad = media_pad_remote_pad_first(pad);
> +		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
> +			break;
> +
> +		entity = pad->entity;
> +		subdev = media_entity_to_v4l2_subdev(entity);
> +
> +		ret = v4l2_subdev_call(subdev, video, s_stream, 1);
> +		if (ret < 0 && ret != -ENOIOCTLCMD)
> +			goto err_pm_put;
> +	}

The .s_stream() operation should be called recursively, not on all
subdevs in the graph. This function should call .s_stream() on the ISP,
which should call it on the CSI-2 receiver subdev, which should then
call it on its connected subdev. The reason for this is that you don't
know what devices are connected to the CSI-2 RX, it could be just a
camera sensor, but it could also be a more complex chain of devices (for
instance, a sensor, an automotive serializer and a deserializer). Each
device would have its own requirements regarding what operations to
perform before and after starting and stopping its source, so each
subdev should call .s_stream() on its own source.

Same in video_stop_streaming().

> +	return 0;
> +
> +err_pm_put:
> +	pm_runtime_put(video->stfcamss->dev);
> +error:
> +	video_device_pipeline_stop(vdev);
> +	video->ops->flush_buffers(video, VB2_BUF_STATE_QUEUED);
> +	return ret;
> +}
> +
> +static void video_stop_streaming(struct vb2_queue *q)
> +{
> +	struct stfcamss_video *video = vb2_get_drv_priv(q);
> +	struct video_device *vdev = &video->vdev;
> +	struct media_entity *entity;
> +	struct media_pad *pad;
> +	struct v4l2_subdev *subdev;
> +	int ret;
> +
> +	entity = &vdev->entity;
> +	while (1) {
> +		pad = &entity->pads[0];
> +		if (!(pad->flags & MEDIA_PAD_FL_SINK))
> +			break;
> +
> +		pad = media_pad_remote_pad_first(pad);
> +		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
> +			break;
> +
> +		entity = pad->entity;
> +		subdev = media_entity_to_v4l2_subdev(entity);
> +
> +		v4l2_subdev_call(subdev, video, s_stream, 0);
> +	}
> +
> +	ret = pm_runtime_put(video->stfcamss->dev);
> +	if (ret < 0)
> +		dev_err(video->stfcamss->dev, "power down failed:%d\n", ret);
> +
> +	video_device_pipeline_stop(vdev);
> +	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
> +}
> +
> +static const struct vb2_ops stf_video_vb2_q_ops = {
> +	.queue_setup     = video_queue_setup,
> +	.wait_prepare    = vb2_ops_wait_prepare,
> +	.wait_finish     = vb2_ops_wait_finish,
> +	.buf_init        = video_buf_init,
> +	.buf_prepare     = video_buf_prepare,
> +	.buf_queue       = video_buf_queue,
> +	.start_streaming = video_start_streaming,
> +	.stop_streaming  = video_stop_streaming,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * V4L2 ioctls
> + */
> +
> +static int video_querycap(struct file *file, void *fh,
> +			  struct v4l2_capability *cap)
> +{
> +	strscpy(cap->driver, "stf camss", sizeof(cap->driver));
> +	strscpy(cap->card, "Starfive Camera Subsystem", sizeof(cap->card));
> +
> +	return 0;
> +}
> +
> +static int video_get_pfmt_by_index(struct stfcamss_video *video, int ndx)
> +{
> +	int i, j, k;
> +
> +	/* find index "i" of "k"th unique pixelformat in formats array */
> +	k = -1;
> +	for (i = 0; i < video->nformats; i++) {
> +		for (j = 0; j < i; j++) {
> +			if (video->formats[i].pixelformat ==
> +			    video->formats[j].pixelformat)
> +				break;
> +		}
> +
> +		if (j == i)
> +			k++;
> +
> +		if (k == ndx)
> +			return i;
> +	}

This looks unnecessarily complicated, as all entries in the format array
has unique pixel formats.

> +
> +	return -EINVAL;
> +}
> +
> +static int video_get_pfmt_by_mcode(struct stfcamss_video *video, u32 mcode)
> +{
> +	int i;
> +
> +	for (i = 0; i < video->nformats; i++) {
> +		if (video->formats[i].code == mcode)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

Move these two helper functions above, just below video_find_format().

> +
> +static int video_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
> +{
> +	struct stfcamss_video *video = video_drvdata(file);
> +	int i;
> +
> +	if (f->type != video->type)
> +		return -EINVAL;

I think you can skip this. check_fmt() in v4l2-ioctl.c checks that the
driver implements the .vidioc_g_fmt_* operation corresponding to the
type, which should catch invalid types.

> +	if (f->index >= video->nformats)
> +		return -EINVAL;
> +
> +	if (f->mbus_code) {
> +		/* Each entry in formats[] table has unique mbus_code */
> +		if (f->index > 0)
> +			return -EINVAL;
> +
> +		i = video_get_pfmt_by_mcode(video, f->mbus_code);
> +	} else {
> +		i = video_get_pfmt_by_index(video, f->index);
> +	}
> +
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	f->pixelformat = video->formats[i].pixelformat;
> +
> +	return 0;
> +}
> +
> +static int video_enum_framesizes(struct file *file, void *fh,
> +				 struct v4l2_frmsizeenum *fsize)
> +{
> +	struct stfcamss_video *video = video_drvdata(file);
> +	int i;

i never takes negative values, you can make it an unsigned int.

> +
> +	if (fsize->index)
> +		return -EINVAL;
> +
> +	for (i = 0; i < video->nformats; i++) {
> +		if (video->formats[i].pixelformat == fsize->pixel_format)
> +			break;
> +	}
> +
> +	if (i == video->nformats)
> +		return -EINVAL;
> +
> +	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
> +	fsize->stepwise.min_width = STFCAMSS_FRAME_MIN_WIDTH;
> +	fsize->stepwise.max_width = STFCAMSS_FRAME_MAX_WIDTH;
> +	fsize->stepwise.min_height = STFCAMSS_FRAME_MIN_HEIGHT;
> +	fsize->stepwise.max_height = STFCAMSS_FRAME_MAX_HEIGHT;
> +	fsize->stepwise.step_width = 1;
> +	fsize->stepwise.step_height = 1;
> +
> +	return 0;
> +}
> +
> +static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
> +{
> +	struct stfcamss_video *video = video_drvdata(file);
> +
> +	*f = video->active_fmt;
> +
> +	return 0;
> +}
> +
> +static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
> +{
> +	struct stfcamss_video *video = video_drvdata(file);
> +	int ret;
> +
> +	if (vb2_is_busy(&video->vb2_q))
> +		return -EBUSY;
> +
> +	ret = __video_try_fmt(video, f);
> +	if (ret < 0)
> +		return ret;
> +
> +	video->active_fmt = *f;
> +
> +	return 0;
> +}
> +
> +static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
> +{
> +	struct stfcamss_video *video = video_drvdata(file);
> +
> +	return __video_try_fmt(video, f);
> +}
> +
> +static const struct v4l2_ioctl_ops stf_vid_ioctl_ops = {
> +	.vidioc_querycap                = video_querycap,
> +	.vidioc_enum_fmt_vid_cap        = video_enum_fmt,
> +	.vidioc_enum_fmt_vid_out        = video_enum_fmt,

As far as I can tell the driver doesn't support video output (processing
with the ISP data read from memory), so you can drop this.

> +	.vidioc_enum_framesizes         = video_enum_framesizes,
> +	.vidioc_g_fmt_vid_cap           = video_g_fmt,
> +	.vidioc_s_fmt_vid_cap           = video_s_fmt,
> +	.vidioc_try_fmt_vid_cap         = video_try_fmt,
> +	.vidioc_g_fmt_vid_out           = video_g_fmt,
> +	.vidioc_s_fmt_vid_out           = video_s_fmt,
> +	.vidioc_try_fmt_vid_out         = video_try_fmt,

These three operations can be dropped too.

> +	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
> +	.vidioc_querybuf                = vb2_ioctl_querybuf,
> +	.vidioc_qbuf                    = vb2_ioctl_qbuf,
> +	.vidioc_expbuf                  = vb2_ioctl_expbuf,
> +	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
> +	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
> +	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
> +	.vidioc_streamon                = vb2_ioctl_streamon,
> +	.vidioc_streamoff               = vb2_ioctl_streamoff,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * V4L2 file operations
> + */
> +
> +static const struct v4l2_file_operations stf_vid_fops = {
> +	.owner          = THIS_MODULE,
> +	.unlocked_ioctl = video_ioctl2,
> +	.open           = v4l2_fh_open,
> +	.release        = vb2_fop_release,
> +	.poll           = vb2_fop_poll,
> +	.mmap           = vb2_fop_mmap,
> +	.read           = vb2_fop_read,
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * STFCAMSS video core
> + */
> +
> +static void stf_video_release(struct video_device *vdev)
> +{
> +	struct stfcamss_video *video = video_get_drvdata(vdev);
> +
> +	media_entity_cleanup(&vdev->entity);
> +
> +	mutex_destroy(&video->q_lock);
> +	mutex_destroy(&video->lock);
> +}
> +
> +int stf_video_register(struct stfcamss_video *video,
> +		       struct v4l2_device *v4l2_dev, const char *name)
> +{
> +	struct video_device *vdev;
> +	struct vb2_queue *q;
> +	struct media_pad *pad = &video->pad;
> +	int ret;
> +
> +	vdev = &video->vdev;

You can assign vdev above when declaring it.

> +
> +	mutex_init(&video->q_lock);
> +
> +	q = &video->vb2_q;
> +	q->drv_priv = video;
> +	q->mem_ops = &vb2_dma_contig_memops;
> +	q->ops = &stf_video_vb2_q_ops;
> +	q->type = video->type;
> +	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;

Drop VB2_READ, that's inefficient and deprecated for uncompressed
formats.

> +	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> +	q->buf_struct_size = sizeof(struct stfcamss_buffer);
> +	q->dev = video->stfcamss->dev;
> +	q->lock = &video->q_lock;
> +	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
> +	ret = vb2_queue_init(q);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev,
> +			"Failed to init vb2 queue: %d\n", ret);
> +		goto err_vb2_init;

Error labels should be named based on the cleaning action being
performed, not the function that failed. This should be
err_mutex_destroy (or just err_mutex).

> +	}
> +
> +	pad->flags = MEDIA_PAD_FL_SINK;
> +	ret = media_entity_pads_init(&vdev->entity, 1, pad);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev,
> +			"Failed to init video entity: %d\n", ret);
> +		goto err_vb2_init;
> +	}
> +
> +	mutex_init(&video->lock);

I'd move this above, with the other mutex_init() call.

> +
> +	if (video->id == STF_V_LINE_WR) {
> +		video->formats = formats_pix_wr;
> +		video->nformats = ARRAY_SIZE(formats_pix_wr);
> +		video->bpl_alignment = 8;
> +	} else {
> +		video->formats = formats_pix_isp;
> +		video->nformats = ARRAY_SIZE(formats_pix_isp);
> +		video->bpl_alignment = 1;
> +	}
> +
> +	ret = stf_video_init_format(video);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev,
> +			"Failed to init format: %d\n", ret);
> +		goto err_vid_init_format;

And this label should be err_media_cleanup.

> +	}
> +
> +	vdev->fops = &stf_vid_fops;
> +	vdev->ioctl_ops = &stf_vid_ioctl_ops;
> +	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE;
> +	vdev->vfl_dir = VFL_DIR_RX;
> +	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;

Drop V4L2_CAP_READWRITE for the same reason as VB2_READ.

> +	vdev->release = stf_video_release;
> +	vdev->v4l2_dev = v4l2_dev;
> +	vdev->queue = &video->vb2_q;
> +	vdev->lock = &video->lock;
> +	strscpy(vdev->name, name, sizeof(vdev->name));
> +
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, video->id);
> +	if (ret < 0) {
> +		dev_err(video->stfcamss->dev,
> +			"Failed to register video device: %d\n", ret);
> +		goto err_vid_reg;
> +	}
> +
> +	video_set_drvdata(vdev, video);

Call this before video_register_device(). As soon as
video_register_device() gets called, userspace can access the device, so
it needs to be fully initialized.

> +	return 0;
> +
> +err_vid_reg:
> +err_vid_init_format:
> +	media_entity_cleanup(&vdev->entity);
> +	mutex_destroy(&video->lock);
> +err_vb2_init:
> +	mutex_destroy(&video->q_lock);
> +	return ret;
> +}
> +
> +void stf_video_unregister(struct stfcamss_video *video)
> +{
> +	vb2_video_unregister_device(&video->vdev);
> +}
> diff --git a/drivers/media/platform/starfive/camss/stf_video.h b/drivers/media/platform/starfive/camss/stf_video.h
> new file mode 100644
> index 000000000000..60323c23a40c
> --- /dev/null
> +++ b/drivers/media/platform/starfive/camss/stf_video.h
> @@ -0,0 +1,92 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * stf_video.h
> + *
> + * StarFive Camera Subsystem - V4L2 device node
> + *
> + * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
> + */
> +
> +#ifndef STF_VIDEO_H
> +#define STF_VIDEO_H
> +
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/videodev2.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-fh.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +#define STFCAMSS_FRAME_MIN_WIDTH		64
> +#define STFCAMSS_FRAME_MAX_WIDTH		1920
> +#define STFCAMSS_FRAME_MIN_HEIGHT		64
> +#define STFCAMSS_FRAME_MAX_HEIGHT		1080
> +#define STFCAMSS_FRAME_WIDTH_ALIGN_8		8
> +#define STFCAMSS_FRAME_WIDTH_ALIGN_128		128
> +#define STFCAMSS_MIN_BUFFERS			2
> +
> +#define STFCAMSS_MAX_ENTITY_NAME_LEN		27
> +
> +enum stf_v_line_id {
> +	STF_V_LINE_WR = 0,
> +	STF_V_LINE_ISP,
> +	STF_V_LINE_MAX,
> +};
> +
> +struct stfcamss_buffer {
> +	struct vb2_v4l2_buffer vb;
> +	dma_addr_t addr[3];

The driver supports two planes at most (for NV formats), not three.

> +	struct list_head queue;
> +};
> +
> +struct fract {
> +	u8 numerator;
> +	u8 denominator;
> +};
> +
> +/*
> + * struct stfcamss_format_info - ISP media bus format information
> + * @code: V4L2 media bus format code
> + * @pixelformat: V4L2 pixel format FCC identifier
> + * @planes: Number of planes
> + * @vsub: Vertical subsampling (for each plane)
> + * @bpp: Bits per pixel when stored in memory (for each plane)
> + */
> +struct stfcamss_format_info {
> +	u32 code;
> +	u32 pixelformat;
> +	u8 planes;
> +	u8 vsub[3];
> +	u8 bpp;
> +};
> +
> +struct stfcamss_video {
> +	struct stfcamss *stfcamss;
> +	u8 id;
> +	struct vb2_queue vb2_q;
> +	struct video_device vdev;
> +	struct media_pad pad;
> +	struct v4l2_format active_fmt;
> +	enum v4l2_buf_type type;
> +	const struct stfcamss_video_ops *ops;
> +	struct mutex lock;	 /* serialize device access */
> +	struct mutex q_lock;	 /* protects the queue */
> +	unsigned int bpl_alignment;
> +	const struct stfcamss_format_info *formats;
> +	unsigned int nformats;
> +};
> +
> +struct stfcamss_video_ops {
> +	int (*queue_buffer)(struct stfcamss_video *vid,
> +			    struct stfcamss_buffer *buf);
> +	int (*flush_buffers)(struct stfcamss_video *vid,
> +			     enum vb2_buffer_state state);
> +};
> +
> +int stf_video_register(struct stfcamss_video *video,
> +		       struct v4l2_device *v4l2_dev, const char *name);
> +
> +void stf_video_unregister(struct stfcamss_video *video);
> +
> +#endif /* STF_VIDEO_H */

-- 
Regards,

Laurent Pinchart
