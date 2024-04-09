Return-Path: <linux-kernel+bounces-137639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033BC89E4E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641E31F22BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB18158A2A;
	Tue,  9 Apr 2024 21:25:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AB158867
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697905; cv=none; b=u3x9FngA61AVUPe3wVnQxxRaYCuGe22BmC+2s/45FTm1MUWaqjG9dzT6jWUyeS9KEGYzxK/7pDl3csrs2/R3t8mZnDXWNm4XSysvfQcz9HIVnkDwaoN85t07fP/JDWGeDvINXTmEgCVQ2CYWDDniB59C5CoBNIM8Lsi8Dft2YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697905; c=relaxed/simple;
	bh=HiHvbLiNKh+4kFHZN7IDQemdpmrFlcoc0ZTzObRXs3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BNH/va208+4LYk/X8VQb3P3Io5+2y5gNELYeFwPmRcfUlASW4Mw8FZkd1QgEB5lYtW3HDT/Smt2pixIfDFJ0Zu1IGgJqjY1dUyYgdxhIxzQP6DOZaO9akb3TgdQE+o7MuaWYfv1/iDcKN5vkD8vHyxtBh8IB/A1514eot0E9Ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxf-00081Y-FR; Tue, 09 Apr 2024 23:24:59 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00BNAd-Qr; Tue, 09 Apr 2024 23:24:58 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1ruIxe-00FQKu-2T;
	Tue, 09 Apr 2024 23:24:58 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 09 Apr 2024 23:24:58 +0200
Subject: [PATCH 2/3] usb: gadget: uvc: add g_parm and s_parm for frame
 interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v1-2-9436c4716233@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3274;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=HiHvbLiNKh+4kFHZN7IDQemdpmrFlcoc0ZTzObRXs3M=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmFbIqyMzAMSvamjZxvQctnqi69TxA/R68dMTpZ
 Ob1D/TLwtWJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZhWyKgAKCRC/aVhE+XH0
 q2nDD/92L9Hl0OnAyJCoyDXNFLh4JqhW2wTkHzR89YirJ43XbbiQXMNl91Vby7KOYECzreFtGLv
 VvcvQBYyNtmbyh6SkV65oczfEdY0W429frz+tl+geW6t+i3XEt8ECS/u8pWDzn/mrRQbi0ho/5q
 mDG8buvfo+cdi/qGLpVvBuBn8wf2BuObvLCRGJt4n+K4c53VZtUB+2WGRLo30iAxJg9hh98Z59Q
 jveU+gv7p7qmQh0h9ja6CX1gXlS6JW8AuGtooGAGNrCL68WsIWUYJwmh85EPe9T+n/O8ErQRIPv
 p82ZWBpLQ0EjXSaQt0iYwV9MoJ2ef+8lPAPdoIQm4LQupGUnsdFYPvbKE83pF6tB6JwmhLgi+Bb
 L2mafVXl2jkrKuWy4lFfcg9WAx/ZrA0xs4HerHDj+vSYMnw2mb/u1C49Xf4DPX6tM7IsDxfNsXv
 Gek14AMU9310+G9AbVtT1NdJ+0FbkUBZ+L0Mj5rPQVR3NrAYZdNVUkXcZkHniADCUobpwBKR65S
 /LLDAJYz9n9SkQdDfUeZQwW6vJO9unC020J7Ssnh4Qf9K7sGWE5RJsHQNedjrSAjSDPkPuzUDef
 YvMNdZImMXKmZOuIIWhC2ERKKS0eunMrF8s6AQASln9C7D9Mw0opUit3XpFv9w1FaBIgBMNQVtv
 /fIDcNTL+1MCU6w==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The uvc gadget driver is lacking the information which frame interval
was set by the host. We add this information by implementing the g_parm
and s_parm callbacks.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc.h      |  1 +
 drivers/usb/gadget/function/uvc_v4l2.c | 52 ++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index cb35687b11e7e..d153bd9e35e31 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -97,6 +97,7 @@ struct uvc_video {
 	unsigned int width;
 	unsigned int height;
 	unsigned int imagesize;
+	unsigned int interval;
 	struct mutex mutex;	/* protects frame parameters */
 
 	unsigned int uvc_num_requests;
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc3..5b579ec1f5040 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -307,6 +307,56 @@ uvc_v4l2_set_format(struct file *file, void *fh, struct v4l2_format *fmt)
 	return ret;
 }
 
+static int uvc_v4l2_g_parm(struct file *file, void *fh,
+			    struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	/* Return the actual frame period. */
+	timeperframe.numerator = video->interval;
+	timeperframe.denominator = 10000000;
+	v4l2_simplify_fraction(&timeperframe.numerator,
+		&timeperframe.denominator, 8, 333);
+
+	uvcg_dbg(&uvc->func, "Getting frame interval of %u/%u (%u)\n",
+		timeperframe.numerator, timeperframe.denominator,
+		video->interval);
+
+	parm->parm.output.timeperframe = timeperframe;
+	parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+
+	return 0;
+}
+
+static int uvc_v4l2_s_parm(struct file *file, void *fh,
+			    struct v4l2_streamparm *parm)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct uvc_device *uvc = video_get_drvdata(vdev);
+	struct uvc_video *video = &uvc->video;
+	struct v4l2_fract timeperframe;
+
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	timeperframe = parm->parm.output.timeperframe;
+
+	video->interval = v4l2_fraction_to_interval(timeperframe.numerator,
+		timeperframe.denominator);
+
+	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
+		timeperframe.numerator, timeperframe.denominator,
+		video->interval);
+
+	return 0;
+}
+
 static int
 uvc_v4l2_enum_frameintervals(struct file *file, void *fh,
 		struct v4l2_frmivalenum *fival)
@@ -577,6 +627,8 @@ const struct v4l2_ioctl_ops uvc_v4l2_ioctl_ops = {
 	.vidioc_dqbuf = uvc_v4l2_dqbuf,
 	.vidioc_streamon = uvc_v4l2_streamon,
 	.vidioc_streamoff = uvc_v4l2_streamoff,
+	.vidioc_s_parm = uvc_v4l2_s_parm,
+	.vidioc_g_parm = uvc_v4l2_g_parm,
 	.vidioc_subscribe_event = uvc_v4l2_subscribe_event,
 	.vidioc_unsubscribe_event = uvc_v4l2_unsubscribe_event,
 	.vidioc_default = uvc_v4l2_ioctl_default,

-- 
2.39.2


