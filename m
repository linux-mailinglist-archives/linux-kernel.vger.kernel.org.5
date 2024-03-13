Return-Path: <linux-kernel+bounces-101682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FDF87AA78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31931C22D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533547A64;
	Wed, 13 Mar 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vKEYO3rz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B04502C;
	Wed, 13 Mar 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343943; cv=none; b=d6md1cLSE0ovuQ0uuxJLcqOm3IeZunQ07WQ1lNF6n0Trc7lNVHvwvaIEsLBDvkgd9+aHjWO3nbrB7+UhpqWOqU/HSTfU4Mi88z+DIBUBE310Jje96tI81kUqIv1gr+vkTR3fO3DRhgNkvN18cPwkNSQW0CMr/ubp8KoTA84GFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343943; c=relaxed/simple;
	bh=RYj/hTGFeOICAffBo+IOFSfUokMceJPXN3Xwefp5Ee4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvdNqa07PRo2CfUtOas0fvRiL7q4QShf7HRbOZvWVJAiU1Yfu/YxyEM0MUVjEoSDrjHDkamq2rENGHbhelQpb+G4udgke16zKyijbnmypo0zPVQj2GMdEPPnYYSeULzXjJszjtw+ZpZFX2j0Hrc4ZSZJRlSB6VcVGctrxsqaBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vKEYO3rz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from jasper.fritz.box (unknown [IPv6:2a00:6020:448c:6c00:9b07:31b5:38e1:e957])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBF51A8F;
	Wed, 13 Mar 2024 16:31:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710343917;
	bh=RYj/hTGFeOICAffBo+IOFSfUokMceJPXN3Xwefp5Ee4=;
	h=From:To:Cc:Subject:Date:From;
	b=vKEYO3rzSe33FG42cJPkl0ClUEYxkAfR9ZnW4wrdK56dAsnXCEpeOmIf5k6JImSk3
	 TK06yhx3ScUjKFrsHZJbiFV6CVzHVTbE4018kKNoISnJ48nxMgojTL2BIqVuLZTQsn
	 QTxPOhHeCmU29xv7PCtcW3CjuD7uSYnaol0JUHXg=
From: Stefan Klug <stefan.klug@ideasonboard.com>
To: libcamera-devel@lists.libcamera.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Klug <stefan.klug@ideasonboard.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] mipi-csis: Emit V4L2_EVENT_FRAME_SYNC events
Date: Wed, 13 Mar 2024 16:30:58 +0100
Message-Id: <20240313153058.189684-1-stefan.klug@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Samsung CSIS Mipi receiver provides a start-of-frame interrupt and
a framecount register. As the CSI receiver is the hardware unit
that lies closest to the sensor, the frame counter is the best we can
get on these devices.
In case of the ISI available on the i.MX8 M Plus it is also the only
native start-of-frame signal available.

This patch exposes the sof interrupt and the framecount as
V4L2_EVENT_FRAME_SYNC event on the subdevice.

It was tested on a Debix-Som-A with a 6.8-rc4 kernel.

Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index db8ff5f5c4d3..caeb1622f741 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -30,6 +30,7 @@
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
 #include <media/v4l2-subdev.h>
@@ -742,6 +743,18 @@ static void mipi_csis_stop_stream(struct mipi_csis_device *csis)
 	mipi_csis_system_enable(csis, false);
 }
 
+static void mipi_csis_queue_event_sof(struct mipi_csis_device *csis)
+{
+	struct v4l2_event event = {
+		.type = V4L2_EVENT_FRAME_SYNC,
+	};
+
+	u32 frame = mipi_csis_read(csis, MIPI_CSIS_FRAME_COUNTER_CH(0));
+
+	event.u.frame_sync.frame_sequence = frame;
+	v4l2_event_queue(csis->sd.devnode, &event);
+}
+
 static irqreturn_t mipi_csis_irq_handler(int irq, void *dev_id)
 {
 	struct mipi_csis_device *csis = dev_id;
@@ -765,6 +778,10 @@ static irqreturn_t mipi_csis_irq_handler(int irq, void *dev_id)
 				event->counter++;
 		}
 	}
+
+	if (status & MIPI_CSIS_INT_SRC_FRAME_START)
+		mipi_csis_queue_event_sof(csis);
+
 	spin_unlock_irqrestore(&csis->slock, flags);
 
 	mipi_csis_write(csis, MIPI_CSIS_INT_SRC, status);
@@ -1154,8 +1171,23 @@ static int mipi_csis_log_status(struct v4l2_subdev *sd)
 	return 0;
 }
 
+static int mipi_csis_subscribe_event(struct v4l2_subdev *sd, struct v4l2_fh *fh,
+			       struct v4l2_event_subscription *sub)
+{
+	if (sub->type != V4L2_EVENT_FRAME_SYNC)
+		return -EINVAL;
+
+	/* V4L2_EVENT_FRAME_SYNC doesn't require an id, so zero should be set */
+	if (sub->id != 0)
+		return -EINVAL;
+
+	return v4l2_event_subscribe(fh, sub, 0, NULL);
+}
+
 static const struct v4l2_subdev_core_ops mipi_csis_core_ops = {
 	.log_status	= mipi_csis_log_status,
+	.subscribe_event =  mipi_csis_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
 };
 
 static const struct v4l2_subdev_video_ops mipi_csis_video_ops = {
@@ -1358,7 +1390,7 @@ static int mipi_csis_subdev_init(struct mipi_csis_device *csis)
 	snprintf(sd->name, sizeof(sd->name), "csis-%s",
 		 dev_name(csis->dev));
 
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 	sd->ctrl_handler = NULL;
 
 	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
-- 
2.40.1


