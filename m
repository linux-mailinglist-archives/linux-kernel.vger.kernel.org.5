Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687B37E9AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjKMLGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:06:49 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761E10D3;
        Mon, 13 Nov 2023 03:06:39 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACAB61C0016;
        Mon, 13 Nov 2023 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699873598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jww218OGC87EBboTeBh0PiluXJvjuxLjPAU1JWB7n8c=;
        b=eApgiTlUMD2URE04HdyMCPmckvgWUApgCmSHFQz5Lqz2U+DYSM+oT4QBClk+cOxOlnNxG7
        If9UYdnw3dEzgKz5CeZkAr1nM943U7phuP/7sVOx8TTuQdFFif/BTHh5CRBjwWA/RSTMwb
        SAPCzjunDBrEdy6HVUBezKSKxKJmwDTyhrTPglGSJ9NmHgQ5jDJY/3G+dKg7SE2hK92BUj
        bsiqoxZ/6CTxQ8iSZnY4Fs6mDwJTld9ETdZNqsQEat4jyxZGRl6Kh7jCNBdRPqLXM97TDt
        3NV2xk480RPypXZ6qb+2F2/l+Rvuakju/E1Xr89BDPM0w6Kv7M58ra1OW9jRXg==
Date:   Mon, 13 Nov 2023 12:06:36 +0100
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v10 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Message-ID: <ZVIDPKIBLHHvgpE/@pc-70.home>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <bcc0b84f4a6a8cf4c007cfe25025060b22627408.1699460637.git.mehdi.djait@bootlin.com>
 <f817728d-6377-4fff-b8e8-ac0c652e5c29@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f817728d-6377-4fff-b8e8-ac0c652e5c29@wolfvision.net>
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, Nov 10, 2023 at 01:50:01PM +0100, Michael Riesch wrote:
> Hi Mehdi,
> 
> Thanks for your patches.
> 
> The good news first: with some hacks applied I was able to capture the
> video stream from a HDMI receiver chip via BT.1120 on a Rockchip RK3568.

this is really cool!

> 
> As a next step, I'll clean up the hacky RK3568 support and submit them
> for review.
> 
> Still, there are some issues that needs to be addressed. Please find my
> comments inline.
> 
> On 11/8/23 17:38, Mehdi Djait wrote:
> > This introduces a V4L2 driver for the Rockchip CIF video capture controller.
> > 
> > This controller supports multiple parallel interfaces, but for now only the
> > BT.656 interface could be tested, hence it's the only one that's supported
> > in the first version of this driver.
> > 
> > This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> > but for now it's only been tested on the PX30.
> > 
> > CIF is implemented as a video node-centric driver.
> > 
> > Most of this driver was written following the BSP driver from rockchip,
> > removing the parts that either didn't fit correctly the guidelines, or that
> > couldn't be tested.
> > 
> > This basic version doesn't support cropping nor scaling and is only
> > designed with one SDTV video decoder being attached to it at any time.
> > 
> > This version uses the "pingpong" mode of the controller, which is a
> > double-buffering mechanism.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > +static const struct cif_input_fmt in_fmts[] = {
> > +	{
> > +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> 
> What is the point of this csi_fmt_val field? If the strategy is to kick
> everything out that is not explicitly required then this should be
> removed (and added at a later stage, if needed).
> 

I can remove this but I don't really see the harm of keeping this.
It can even save some time for the person adding the support for CSI
later.

> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_NONE,
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_YUYV,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_INTERLACED,
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_NONE,
> 
> What is the difference between this entry (in_fmts[2]) and in_fmts[0]?
> Similarly, between in_fmts[1] and in_fmts[3]?
> 

Between in_fmts[0] and in_fmts[2] is the order of Y U V components:
0 -> YUYV
2 -> YVYU

between in_fmts[1] and in_fmts[3]: the same thing:
1 -> YUYV
3 -> YVYU
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_YVYU,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_INTERLACED,
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_NONE,
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_UYVY,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_INTERLACED,
> > +	}, {
> > +		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
> > +		.dvp_fmt_val	= CIF_FORMAT_YUV_INPUT_422 |
> > +				  CIF_FORMAT_YUV_INPUT_ORDER_VYUY,
> > +		.csi_fmt_val	= CIF_CSI_WRDDR_TYPE_YUV422,
> > +		.fmt_type	= CIF_FMT_TYPE_YUV,
> > +		.field		= V4L2_FIELD_NONE,
> > +	}, {
> > +static const struct
> > +cif_input_fmt *get_input_fmt(struct v4l2_subdev *sd)
> > +{
> > +	struct v4l2_subdev_format fmt;
> > +	u32 i;
> > +
> > +	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > +	fmt.pad = 0;
> > +	v4l2_subdev_call(sd, pad, get_fmt, NULL, &fmt);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(in_fmts); i++)
> > +		if (fmt.format.code == in_fmts[i].mbus_code &&
> > +		    fmt.format.field == in_fmts[i].field)
> > +			return &in_fmts[i];
> > +
> > +	v4l2_err(sd->v4l2_dev, "remote's mbus code not supported\n");
> > +	return NULL;
> > +}
> > +
> > +static struct
> > +cif_output_fmt *find_output_fmt(struct cif_stream *stream, u32 pixelfmt)
> > +{
> > +	struct cif_output_fmt *fmt;
> > +	u32 i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(out_fmts); i++) {
> > +		fmt = &out_fmts[i];
> > +		if (fmt->fourcc == pixelfmt)
> > +			return fmt;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static struct cif_buffer *cif_get_buffer(struct cif_stream *stream)
> > +{
> > +	struct cif_buffer *buff;
> > +
> > +	lockdep_assert_held(&stream->vbq_lock);
> > +
> > +	if (list_empty(&stream->buf_head))
> > +		return NULL;
> > +
> > +	buff = list_first_entry(&stream->buf_head, struct cif_buffer, queue);
> > +	list_del(&buff->queue);
> > +
> > +	return buff;
> > +}
> > +
> > +static int cif_init_buffers(struct cif_stream *stream)
> > +{
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	unsigned long lock_flags;
> > +
> > +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> > +
> > +	stream->buffs[0] = cif_get_buffer(stream);
> > +	stream->buffs[1] = cif_get_buffer(stream);
> > +
> > +	if (!(stream->buffs[0]) || !(stream->buffs[1])) {
> > +		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> > +		return -EINVAL;
> > +	}
> > +
> > +	stream->drop_frame = false;
> > +
> > +	cif_write(cif_dev, CIF_FRM0_ADDR_Y,
> > +		  stream->buffs[0]->buff_addr[CIF_PLANE_Y]);
> > +	cif_write(cif_dev, CIF_FRM0_ADDR_UV,
> > +		  stream->buffs[0]->buff_addr[CIF_PLANE_UV]);
> > +
> > +	cif_write(cif_dev, CIF_FRM1_ADDR_Y,
> > +		  stream->buffs[1]->buff_addr[CIF_PLANE_Y]);
> > +	cif_write(cif_dev, CIF_FRM1_ADDR_UV,
> > +		  stream->buffs[1]->buff_addr[CIF_PLANE_UV]);
> > +
> > +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
> > +{
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	struct cif_buffer *buffer = NULL;
> > +	u32 frm_addr_y, frm_addr_uv;
> > +	unsigned long lock_flags;
> > +
> > +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> > +
> > +	buffer = cif_get_buffer(stream);
> > +
> > +	/*
> > +	 * In Pingpong mode:
> > +	 * After one frame0 captured, CIF will start to capture the next frame1
> > +	 * automatically.
> > +	 *
> > +	 * If there is no buffer:
> > +	 * 1. Make the next frame0 write to the buffer of frame1.
> > +	 *
> > +	 * 2. Drop the frame1: Don't return it to user-space, as it will be
> > +	 *    overwritten by the next frame0.
> > +	 */
> > +	if (!buffer) {
> > +		stream->drop_frame = true;
> > +		buffer = stream->buffs[1 - stream->frame_phase];
> > +	} else {
> > +		stream->drop_frame = false;
> > +	}
> > +
> > +	stream->buffs[stream->frame_phase] = buffer;
> > +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> > +
> > +	frm_addr_y = stream->frame_phase ? CIF_FRM1_ADDR_Y : CIF_FRM0_ADDR_Y;
> > +	frm_addr_uv = stream->frame_phase ? CIF_FRM1_ADDR_UV : CIF_FRM0_ADDR_UV;
> > +
> > +	cif_write(cif_dev, frm_addr_y, buffer->buff_addr[CIF_PLANE_Y]);
> > +	cif_write(cif_dev, frm_addr_uv, buffer->buff_addr[CIF_PLANE_UV]);
> > +}
> > +
> > +static void cif_stream_stop(struct cif_stream *stream)
> > +{
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	u32 val;
> > +
> > +	val = cif_read(cif_dev, CIF_CTRL);
> > +	cif_write(cif_dev, CIF_CTRL, val & (~CIF_CTRL_ENABLE_CAPTURE));
> > +	cif_write(cif_dev, CIF_INTEN, 0x0);
> > +	cif_write(cif_dev, CIF_INTSTAT, 0x3ff);
> > +	cif_write(cif_dev, CIF_FRAME_STATUS, 0x0);
> > +
> > +	stream->stopping = false;
> > +}
> > +
> > +static int cif_queue_setup(struct vb2_queue *queue,
> > +			   unsigned int *num_buffers,
> > +			   unsigned int *num_planes,
> > +			   unsigned int sizes[],
> > +			   struct device *alloc_devs[])
> > +{
> > +	struct cif_stream *stream = queue->drv_priv;
> > +	const struct v4l2_pix_format *pix;
> > +
> > +	pix = &stream->pix;
> > +
> > +	if (*num_planes) {
> > +		if (*num_planes != 1)
> > +			return -EINVAL;
> > +
> > +		if (sizes[0] < pix->sizeimage)
> > +			return -EINVAL;
> > +		return 0;
> > +	}
> > +
> > +	*num_planes = 1;
> > +
> > +	sizes[0] = pix->sizeimage;
> > +
> > +	*num_buffers = CIF_REQ_BUFS_MIN;
> > +
> > +	return 0;
> > +}
> > +
> > +static void cif_buf_queue(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> > +	struct cif_buffer *cifbuf = to_cif_buffer(vbuf);
> > +	struct vb2_queue *queue = vb->vb2_queue;
> > +	struct cif_stream *stream = queue->drv_priv;
> > +	struct v4l2_pix_format *pix = &stream->pix;
> > +	unsigned long lock_flags;
> > +	int i;
> > +
> > +	struct cif_output_fmt *fmt = stream->cif_fmt_out;
> > +
> > +	memset(cifbuf->buff_addr, 0, sizeof(cifbuf->buff_addr));
> > +
> > +	cifbuf->buff_addr[0] = vb2_dma_contig_plane_dma_addr(vb, 0);
> > +
> > +	for (i = 0; i < fmt->cplanes - 1; i++)
> > +		cifbuf->buff_addr[i + 1] = cifbuf->buff_addr[i] +
> > +			pix->bytesperline * pix->height;
> > +
> > +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> > +	list_add_tail(&cifbuf->queue, &stream->buf_head);
> > +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> > +}
> > +
> > +static void cif_return_all_buffers(struct cif_stream *stream,
> > +				   enum vb2_buffer_state state)
> > +{
> > +	struct cif_buffer *buf;
> > +	unsigned long lock_flags;
> > +
> > +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> > +
> > +	if (stream->buffs[0]) {
> > +		vb2_buffer_done(&stream->buffs[0]->vb.vb2_buf, state);
> > +		stream->buffs[0] = NULL;
> > +	}
> > +
> > +	if (stream->buffs[1]) {
> > +		if (!stream->drop_frame)
> > +			vb2_buffer_done(&stream->buffs[1]->vb.vb2_buf, state);
> > +
> > +		stream->buffs[1] = NULL;
> > +	}
> > +
> > +	while (!list_empty(&stream->buf_head)) {
> > +		buf = cif_get_buffer(stream);
> > +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> > +}
> > +
> > +static void cif_stop_streaming(struct vb2_queue *queue)
> > +{
> > +	struct cif_stream *stream = queue->drv_priv;
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	struct v4l2_subdev *sd;
> > +	int ret;
> > +
> > +	stream->stopping = true;
> > +	ret = wait_event_timeout(stream->wq_stopped,
> > +				 !stream->stopping,
> > +				 msecs_to_jiffies(1000));
> > +	if (!ret) {
> > +		cif_stream_stop(stream);
> > +		stream->stopping = false;
> > +	}
> > +
> > +	/* Stop the sub device. */
> > +	sd = cif_dev->remote.sd;
> > +	v4l2_subdev_call(sd, video, s_stream, 0);
> > +
> > +	pm_runtime_put(cif_dev->dev);
> > +
> > +	cif_return_all_buffers(stream, VB2_BUF_STATE_ERROR);
> > +}
> > +
> > +static int cif_stream_start(struct cif_stream *stream)
> > +{
> > +	u32 val, mbus_flags, href_pol, vsync_pol, fmt_type,
> > +	    xfer_mode = 0, yc_swap = 0;
> > +	struct cif_device *cif_dev = stream->cifdev;
> > +	struct cif_remote *remote_info;
> > +	int ret;
> > +	u32 input_mode;
> > +
> > +	remote_info = &cif_dev->remote;
> > +	fmt_type = stream->cif_fmt_in->fmt_type;
> > +	stream->frame_idx = 0;
> 
> Those lines are somewhat mixed. The reset of the frame_idx should be
> made more visible. The remote_info line could be integrated into the
> declaration. For the fmt_type line please see the comment below.
> 
> > +	input_mode = (remote_info->std == V4L2_STD_NTSC) ?
> > +		      CIF_FORMAT_INPUT_MODE_NTSC :
> > +		      CIF_FORMAT_INPUT_MODE_PAL;
> 
> This seems to be an oversimplification. How can one use BT.656 here?

I don't quite understand the question. This is used to configure the
hardware, i.e., the INPUT_MODE of the format VIP_FOR

bits 4:2

INPUT_MODE Input mode:

3'b000 : YUV
3'b010 : PAL
3'b011 : NTSC
3'b100 : RAW
3'b101 : JPEG
3'b110 : MIPI
Other : invalid

> (Aren't you using BT.656 as mbus format between your video decoder and
> the PX30 VIP?)

I look into this. I will probably need to add this.

> You should not assume that the remote is capable of any TV standards
> (this statement holds for the driver in general).
> 

But this is the support I am adding right now, for cif with a SDTV
decoder capable of TV standards. This statement will need to be 
changed when support for sensors is added. 

> > +	mbus_flags = remote_info->mbus.bus.parallel.flags;
> > +	href_pol = (mbus_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) ?
> > +			0 : CIF_FORMAT_HSY_LOW_ACTIVE;
> > +	vsync_pol = (mbus_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) ?
> > +			CIF_FORMAT_VSY_HIGH_ACTIVE : 0;
> > +
> > +	val = vsync_pol | href_pol | input_mode | stream->cif_fmt_out->fmt_val |
> > +	      stream->cif_fmt_in->dvp_fmt_val | xfer_mode | yc_swap;
> > +void cif_set_default_format(struct cif_device *cif_dev)
> > +{
> > +	struct cif_stream *stream = &cif_dev->stream;
> > +	struct v4l2_pix_format pix;
> > +
> > +	cif_dev->remote.std = V4L2_STD_NTSC;
> 
> Not every subdevice supports TV standards. Is this really reasonable?
> 

For the support I am adding right now it is reasonable but for future
support it needs to be changed.

> > +
> > +	pix.pixelformat = V4L2_PIX_FMT_NV12;
> > +	pix.width = CIF_DEFAULT_WIDTH;
> > +	pix.height = CIF_DEFAULT_HEIGHT;
> > +
> > +	cif_set_fmt(stream, &pix);
> > +}
> > +
> > +static int cif_enum_input(struct file *file, void *priv,
> > +			  struct v4l2_input *input)
> > +{
> > +	struct cif_stream *stream = video_drvdata(file);
> > +	struct v4l2_subdev *sd = stream->cifdev->remote.sd;
> > +	int ret;
> > +
> > +	if (input->index > 0)
> > +		return -EINVAL;
> > +
> > +	ret = v4l2_subdev_call(sd, video, g_input_status, &input->status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	strscpy(input->name, "Camera", sizeof(input->name));
> > +	input->type = V4L2_INPUT_TYPE_CAMERA;
> 
> Wait, we are a camera in any case? How does this fit together with your
> video decoder setup?
> 

Yes the video decoder is attached to a camera.

From the kernel documentation:
https://docs.kernel.org/userspace-api/media/v4l/vidioc-enuminput.html?highlight=v4l2_input_type_camera
--------------------------------------------------------------------------------
V4L2_INPUT_TYPE_CAMERA
Any non-tuner video input, for example Composite Video, S-Video, HDMI, camera
sensor. The naming as _TYPE_CAMERA is historical, today we would have called it
_TYPE_VIDEO.
--------------------------------------------------------------------------------

> > +	input->std = stream->vdev.tvnorms;
> > +	input->capabilities = V4L2_IN_CAP_STD;
> 
> Not every subdevice supports TV standards. Is this really reasonable?
> 

see above answer.

--
Kind Regards
Mehdi Djait
