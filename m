Return-Path: <linux-kernel+bounces-103102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00F87BB05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE72831EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1256E5E9;
	Thu, 14 Mar 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tGbbHdKF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD36D1C8;
	Thu, 14 Mar 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411055; cv=none; b=KKswtRRZMqzrW9wIihYZokwcnXZ8yu+wcbuDdn90H1SB/hvHvmPe0CUTXSNWjgve1zu2Yjv/RnQTj/ou5+3oJKrkc0Xr/0iHx+7Vnz+QtyM6nbG3W8koad+zCOULZUNH3YMVxNRiVKWDQpUfS/ji3fo4SYMihiJxzyCPcYaMaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411055; c=relaxed/simple;
	bh=NHtfGxhYFnBpkY/V0r9ZDvAGH7uhabLvklqAYXuLw/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY1lwbgs9fUBdzz4LY0FLqT15Ez8jomgKsqYjVQZHGdq41Ob/ob9e+AIGqf90AenoOc2qeHQZFnaON6Jej82ddftNnm6qsKqnibK2V8dWrRUdx1Odn/EkvMQTpjDWy+mzCzyMNodCPqWEnFPjjuTM01J+XnKp3VADl0IQH9555A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tGbbHdKF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8F67675;
	Thu, 14 Mar 2024 11:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710411028;
	bh=NHtfGxhYFnBpkY/V0r9ZDvAGH7uhabLvklqAYXuLw/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGbbHdKFkvq56hha5BqkMYN0VaMpIa9uUJrn6y6GIsj6aHuxwTjv1HttRVoL5iuMi
	 IJUGiqMmd+4rbohBKegGxujb8qV9rIPtVdLGQmstIWbd+DaRqUV20mAHdFXg6W1NDd
	 oRM0iHIfSPA8dUbbYPLJKddPO1nad8ND4ENdMD/I=
Date: Thu, 14 Mar 2024 12:10:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Stefan Klug <stefan.klug@ideasonboard.com>
Cc: libcamera-devel@lists.libcamera.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] media: mipi-csis: Emit V4L2_EVENT_FRAME_SYNC events
Message-ID: <20240314101049.GC4372@pendragon.ideasonboard.com>
References: <20240314093652.56923-1-stefan.klug@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240314093652.56923-1-stefan.klug@ideasonboard.com>

Hi Stefan,

Thank you for the patch.

On Thu, Mar 14, 2024 at 10:36:50AM +0100, Stefan Klug wrote:
> The Samsung CSIS MIPI receiver provides a start-of-frame interrupt and
> a framecount register. As the CSI receiver is the hardware unit that lies
> closest to the sensor, the frame counter is the best we can get on these
> devices. In case of the ISI available on the i.MX8 M Plus it is also the
> only native start-of-frame signal available.

You still have either an extra line break or a missing blank line :-)

> This patch exposes the sof interrupt and the framecount as
> V4L2_EVENT_FRAME_SYNC event on the subdevice.
> 
> It was tested on a Debix-Som-A with a 6.8-rc4 kernel.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
> ---
> Changes v1 -> v2:
>  - fixed formatting issues from review
>  - moved frame variable declaration to top of subscribe_event()
> 
> Thanks all for the review!
> 
>  drivers/media/platform/nxp/imx-mipi-csis.c | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index db8ff5f5c4d3..664be27c4224 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -30,6 +30,7 @@
>  
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-mc.h>
>  #include <media/v4l2-subdev.h>
> @@ -742,6 +743,18 @@ static void mipi_csis_stop_stream(struct mipi_csis_device *csis)
>  	mipi_csis_system_enable(csis, false);
>  }
>  
> +static void mipi_csis_queue_event_sof(struct mipi_csis_device *csis)
> +{
> +	u32 frame;
> +	struct v4l2_event event = {
> +		.type = V4L2_EVENT_FRAME_SYNC,
> +	};

Nitpicking, we usually sort declarations by decreasing length. No need
for a v3.

> +
> +	frame = mipi_csis_read(csis, MIPI_CSIS_FRAME_COUNTER_CH(0));
> +	event.u.frame_sync.frame_sequence = frame;
> +	v4l2_event_queue(csis->sd.devnode, &event);
> +}
> +
>  static irqreturn_t mipi_csis_irq_handler(int irq, void *dev_id)
>  {
>  	struct mipi_csis_device *csis = dev_id;
> @@ -765,6 +778,10 @@ static irqreturn_t mipi_csis_irq_handler(int irq, void *dev_id)
>  				event->counter++;
>  		}
>  	}
> +
> +	if (status & MIPI_CSIS_INT_SRC_FRAME_START)
> +		mipi_csis_queue_event_sof(csis);
> +
>  	spin_unlock_irqrestore(&csis->slock, flags);
>  
>  	mipi_csis_write(csis, MIPI_CSIS_INT_SRC, status);
> @@ -1154,8 +1171,23 @@ static int mipi_csis_log_status(struct v4l2_subdev *sd)
>  	return 0;
>  }
>  
> +static int mipi_csis_subscribe_event(struct v4l2_subdev *sd, struct v4l2_fh *fh,
> +				     struct v4l2_event_subscription *sub)
> +{
> +	if (sub->type != V4L2_EVENT_FRAME_SYNC)
> +		return -EINVAL;
> +
> +	/* V4L2_EVENT_FRAME_SYNC doesn't require an id, so zero should be set */
> +	if (sub->id != 0)
> +		return -EINVAL;
> +
> +	return v4l2_event_subscribe(fh, sub, 0, NULL);
> +}
> +
>  static const struct v4l2_subdev_core_ops mipi_csis_core_ops = {
>  	.log_status	= mipi_csis_log_status,
> +	.subscribe_event =  mipi_csis_subscribe_event,
> +	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
>  };
>  
>  static const struct v4l2_subdev_video_ops mipi_csis_video_ops = {
> @@ -1358,7 +1390,7 @@ static int mipi_csis_subdev_init(struct mipi_csis_device *csis)
>  	snprintf(sd->name, sizeof(sd->name), "csis-%s",
>  		 dev_name(csis->dev));
>  
> -	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
>  	sd->ctrl_handler = NULL;
>  
>  	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;

-- 
Regards,

Laurent Pinchart

