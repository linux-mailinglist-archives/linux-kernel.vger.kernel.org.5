Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4417DBA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjJ3Mr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJ3Mr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:47:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD84EE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:47:21 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xRfpqZBq8hjcfxRfqq6Wrd; Mon, 30 Oct 2023 13:47:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698670039;
        bh=dmtU2AY+lXKVaP3lfULxgXlxV9hKCfV18pob1MOOT6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CIqiZtc2Sd4uLb7vS6y0qq48+x53j6q9D1pBRYN3jXTByY4eyMEl4iuVenlS1JHNy
         uQfCG91E1XvrC6+48I0W+DnKHhS5qGXYvnIc5OUTTbc4j0eWGe1y1UC/UUPUSqn1QL
         Qi/BsLw32toGJVjDMsPUQjhBD0eUTKNw+6DrLVQwR1Y/7OBarY/AFgu2QtlAA5boRM
         0Z9I5/rUgkCTakssm0dnoOxh2fxPgmxVHfNz2jD0XUT8j0eQ85EHnvJL7JCa6lMXUN
         YhcNC7xp0D+J2G1y0ZjExJeUZPAYuTiempAhw/7SBlYYG77hMOMGNYvjlvfW7HNUXO
         TM/sh+qJ1pQ3Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 13:47:19 +0100
X-ME-IP: 86.243.2.178
Message-ID: <ad346052-ec62-4d68-903e-fccd7ad989bd@wanadoo.fr>
Date:   Mon, 30 Oct 2023 13:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: fr
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, michael.riesch@wolfvision.net
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/10/2023 à 13:25, Mehdi Djait a écrit :
> Introduce a video node-centric driver for the Rockchip CIF
> 
> This controller supports multiple interfaces, but for now only
> the BT.656 interface could be tested, hence it's the only one
> that's supported in the first version of this driver.
> 
> This controller can be found on RK3066, PX30, RK1808, RK3128 and RK3288,
> but for now it's only been tested on the PX30.
> 
> Most of this driver was written following the BSP driver from rockchip,
> removing the parts that either didn't fit correctly the guidelines, or
> that couldn't be tested.
> 
> This basic version doesn't support cropping nor scaling, and is only
> designed with one SDTV video decoder being attached to it a any time.
> 
> This version uses the "pingpong" mode of the controller, which is a
> double-buffering mechanism.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

Hi,

a few nit and a real question at the end.

> +static int cif_init_buffers(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	unsigned long lock_flags = 0;

Nit: no need to init

> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	stream->buffs[0] = cif_get_buffer(stream);
> +	stream->buffs[1] = cif_get_buffer(stream);
> +
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	if (!(stream->buffs[0]) || !(stream->buffs[1]))
> +		return -EINVAL;
> +
> +	stream->drop_frame = false;
> +
> +	cif_write(cif_dev, CIF_FRM0_ADDR_Y,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM0_ADDR_UV,
> +		  stream->buffs[0]->buff_addr[CIF_PLANE_UV]);
> +
> +	cif_write(cif_dev, CIF_FRM1_ADDR_Y,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, CIF_FRM1_ADDR_UV,
> +		  stream->buffs[1]->buff_addr[CIF_PLANE_UV]);
> +
> +	return 0;
> +}
> +
> +static void cif_assign_new_buffer_pingpong(struct cif_stream *stream)
> +{
> +	struct cif_device *cif_dev = stream->cifdev;
> +	struct cif_buffer *buffer = NULL;
> +	u32 frm_addr_y, frm_addr_uv;
> +	unsigned long lock_flags = 0;

Nit: no need to init

> +
> +	stream->drop_frame = false;
> +
> +	/* Set up an empty buffer for the next frame. */
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +	buffer = cif_get_buffer(stream);
> +
> +	/*
> +	 * In Pinpong mode:
> +	 * After one frame0 captured, CIF will start to capture the next frame1
> +	 * automatically.
> +	 *
> +	 * If there is no buffer:
> +	 * 1. Make the next frame0 write to the buffer of frame1.
> +	 *
> +	 * 2. Drop the frame1: Don't return it to user-space, as it will be
> +	 *    overwritten by the next frame0.
> +	 */
> +	if (!buffer) {
> +		stream->drop_frame = true;
> +		buffer = stream->buffs[1 - stream->frame_phase];
> +	}
> +
> +	stream->buffs[stream->frame_phase] = buffer;
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +
> +	frm_addr_y = stream->frame_phase ? CIF_FRM1_ADDR_Y : CIF_FRM0_ADDR_Y;
> +	frm_addr_uv = stream->frame_phase ? CIF_FRM1_ADDR_UV : CIF_FRM0_ADDR_UV;
> +
> +	cif_write(cif_dev, frm_addr_y, buffer->buff_addr[CIF_PLANE_Y]);
> +	cif_write(cif_dev, frm_addr_uv, buffer->buff_addr[CIF_PLANE_UV]);
> +}

...

> +static void cif_buf_queue(struct vb2_buffer *vb)
> +{
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct cif_buffer *cifbuf = to_cif_buffer(vbuf);
> +	struct vb2_queue *queue = vb->vb2_queue;
> +	struct cif_stream *stream = queue->drv_priv;
> +	struct v4l2_pix_format *pix = &stream->pix;
> +	unsigned long lock_flags = 0;

Nit: no need to init

> +	int i;
> +
> +	struct cif_output_fmt *fmt = stream->cif_fmt_out;
> +
> +	memset(cifbuf->buff_addr, 0, sizeof(cifbuf->buff_addr));
> +
> +	cifbuf->buff_addr[0] = vb2_dma_contig_plane_dma_addr(vb, 0);
> +
> +	for (i = 0; i < fmt->cplanes - 1; i++)
> +		cifbuf->buff_addr[i + 1] = cifbuf->buff_addr[i] +
> +			pix->bytesperline * pix->height;
> +
> +	spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +	list_add_tail(&cifbuf->queue, &stream->buf_head);
> +	spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +}
> +
> +static void cif_return_all_buffers(struct cif_stream *stream,
> +				   enum vb2_buffer_state state)
> +{
> +	struct cif_buffer *buf;
> +	unsigned long lock_flags = 0;

Nit: no need to init

> +
> +	if (stream->buffs[0]) {
> +		vb2_buffer_done(&stream->buffs[0]->vb.vb2_buf, state);
> +		stream->buffs[0] = NULL;
> +	}
> +
> +	if (stream->buffs[1]) {
> +		if (!stream->drop_frame)
> +			vb2_buffer_done(&stream->buffs[1]->vb.vb2_buf, state);
> +
> +		stream->buffs[1] = NULL;
> +	}
> +
> +	while (!list_empty(&stream->buf_head)) {
> +		spin_lock_irqsave(&stream->vbq_lock, lock_flags);
> +
> +		buf = cif_get_buffer(stream);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +
> +		spin_unlock_irqrestore(&stream->vbq_lock, lock_flags);
> +	}
> +}

...

> +static int subdev_notifier_bound(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_subdev *subdev,
> +				 struct v4l2_async_connection *asd)
> +{
> +	struct cif_device *cif_dev = container_of(notifier,
> +						  struct cif_device, notifier);
> +

Nit: no need for an extra blank line

> +	int pad;
> +
> +	cif_dev->remote.sd = subdev;
> +	pad = media_entity_get_fwnode_pad(&subdev->entity, subdev->fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (pad < 0)
> +		return pad;
> +
> +	cif_dev->remote.pad = pad;
> +
> +	return 0;
> +}

...

> +static int cif_subdev_notifier(struct cif_device *cif_dev)
> +{
> +	struct v4l2_async_notifier *ntf = &cif_dev->notifier;
> +	struct device *dev = cif_dev->dev;
> +	struct v4l2_async_connection *asd;
> +	struct v4l2_fwnode_endpoint vep = {
> +		.bus_type = V4L2_MBUS_PARALLEL,
> +	};
> +	struct fwnode_handle *ep;
> +	int ret;
> +
> +	v4l2_async_nf_init(ntf, &cif_dev->v4l2_dev);
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> +					     FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep)
> +		return -EINVAL;
> +
> +	ret = v4l2_fwnode_endpoint_parse(ep, &vep);
> +	if (ret)
> +		return ret;
> +
> +	asd = v4l2_async_nf_add_fwnode_remote(ntf, ep,
> +					      struct v4l2_async_connection);
> +	if (IS_ERR(asd)) {
> +		ret = PTR_ERR(asd);
> +		return ret;

Nit: return PTR_ERR(asd);

> +	}
> +
> +	ntf->ops = &subdev_notifier_ops;
> +
> +	fwnode_handle_put(ep);
> +
> +	ret = v4l2_async_nf_register(ntf);
> +	return ret;

Nit: return v4l2_async_nf_register(ntf);

> +}

...

> +static int cif_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct v4l2_device *v4l2_dev;
> +	struct cif_device *cif_dev;
> +	int ret, irq;
> +
> +	cif_dev = devm_kzalloc(dev, sizeof(*cif_dev), GFP_KERNEL);
> +	if (!cif_dev)
> +		return -ENOMEM;
> +
> +	cif_dev->match_data = of_device_get_match_data(dev);
> +	if (!cif_dev->match_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, cif_dev);
> +	cif_dev->dev = dev;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, cif_irq_pingpong, 0,
> +			       dev_driver_string(dev), dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request irq failed\n");
> +
> +	cif_dev->irq = irq;
> +
> +	ret = cif_get_resource(pdev, cif_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_clk_bulk_get(dev, cif_dev->match_data->clks_num,
> +				cif_dev->match_data->clks);
> +	if (ret)
> +		return ret;
> +
> +	cif_dev->cif_rst = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(cif_dev->cif_rst))
> +		return PTR_ERR(cif_dev->cif_rst);
> +
> +	/* Initialize the stream. */
> +	cif_stream_init(cif_dev);
> +	strscpy(cif_dev->media_dev.model, "cif",
> +		sizeof(cif_dev->media_dev.model));
> +	cif_dev->media_dev.dev = &pdev->dev;
> +	v4l2_dev = &cif_dev->v4l2_dev;
> +	v4l2_dev->mdev = &cif_dev->media_dev;
> +	strscpy(v4l2_dev->name, "rockchip-cif", sizeof(v4l2_dev->name));
> +
> +	ret = v4l2_device_register(cif_dev->dev, &cif_dev->v4l2_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	media_device_init(&cif_dev->media_dev);
> +
> +	ret = media_device_register(&cif_dev->media_dev);
> +	if (ret < 0)
> +		goto err_unreg_v4l2_dev;
> +
> +	/* Create & register platform subdev. */
> +	ret = cif_register_stream_vdev(cif_dev);
> +	if (ret < 0)
> +		goto err_unreg_media_dev;
> +
> +	ret = cif_subdev_notifier(cif_dev);
> +	if (ret < 0) {
> +		v4l2_err(&cif_dev->v4l2_dev,
> +			 "Failed to register subdev notifier(%d)\n", ret);
> +		cif_unregister_stream_vdev(cif_dev);
> +		goto err_unreg_media_dev;

Should there be another label with cif_unregister_stream_vdev(cif_dev); 
if an error occurs here?

CJ

> +	}
> +
> +	cif_set_default_format(cif_dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_media_dev:
> +	media_device_unregister(&cif_dev->media_dev);
> +err_unreg_v4l2_dev:
> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
> +	return ret;
> +}

...

