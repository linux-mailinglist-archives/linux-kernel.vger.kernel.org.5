Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D77F438E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjKVKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjKVKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:19:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860B91
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:49 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6705379b835so24303876d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700648388; x=1701253188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcSnz+Cq458gO5KcUl518VSe/I/HM4THBDX1iPhbXu0=;
        b=eosc7BWlY3t6SpC4ba6ZKyR2i8BfXEqZnp3Pq7hq7mHoa3gefHM3JxvEawJnepJZLj
         jJo+LudlO27c0GktgqtF+kuGkMUHbVpj79p2Q2V3SXB7AV7NInsGRIX751NI2t+L71Y+
         tfIh30YhWFp5mHjGRKmcOFpy7TZq5O1+KYPSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648388; x=1701253188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcSnz+Cq458gO5KcUl518VSe/I/HM4THBDX1iPhbXu0=;
        b=RtS7x7mbzA2i3etGC1kNATKOM5s8E38hHrhnCW2d4sYwG7iH0HXoQK2Wxofpn31saD
         6kqLcFgI7IfqDxCVxMmc0mFWnyhjjB5GGgd0/j/8mrgsVPS9qFQWrhKSnL0Bwf/GY2uM
         ohW081OC82CtNemfURwRikvCKQFb9+PD+u27DRSn3hwZzP7Ca0AypkgJfpAPSHNKKqAL
         QI0GNwPVygGjGNB5ENowefCiF8K9PqD6giIn2kjC1NIP8PnNuMelp1sq06pL7wPvdH5p
         j1RECxKtkNXhua7NuqgYEY/kPc0LQ67YN6htQX72+FT73BuJaWtK53m5Eu2sxu5U34WX
         /5Jw==
X-Gm-Message-State: AOJu0YzqE5n/sQ9v6bgrMxqEiLkkWygf+v0MllF7gfTbPSZtfPcPAYAO
        hlJ4RgSMe+xKusww6jgpVzprcw==
X-Google-Smtp-Source: AGHT+IG1ql5Yo3ogWmJdOzQ74AC/uO3K/j8p3a33lIt+ZLaUQh5UXd2Km9Sf+UeohFhiDjYNr+7Lnw==
X-Received: by 2002:ad4:5c68:0:b0:656:4712:af9f with SMTP id i8-20020ad45c68000000b006564712af9fmr2569070qvh.13.1700648388258;
        Wed, 22 Nov 2023 02:19:48 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id di6-20020ad458e6000000b0066d1d2242desm4739352qvb.120.2023.11.22.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:19:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 10:19:36 +0000
Subject: [PATCH v4 3/3] media: uvcvideo: Do not use usb_* functions after
 .disconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-guenter-mini-v4-3-3d94e1e34dc1@chromium.org>
References: <20231122-guenter-mini-v4-0-3d94e1e34dc1@chromium.org>
In-Reply-To: <20231122-guenter-mini-v4-0-3d94e1e34dc1@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb drivers should not call to any I/O function after the
.disconnect() callback has been triggered.
https://www.kernel.org/doc/html/latest/driver-api/usb/callbacks.html#the-disconnect-callback

If an application is receiving frames form a camera and the device is
disconnected: the device will call close() after the usb .disconnect()
callback has been called. The streamoff path will call usb_set_interface
or usb_clear_halt, which is not allowed.

This patch only solves the calls to close() *after* .disconnect() is
being called.

Trace:
[ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
[ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
[ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
[ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
[ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
[ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
[ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c |  4 +++-
 drivers/media/usb/uvc/uvc_status.c |  8 +++----
 drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
 drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  4 +++-
 5 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index ded2cb6ce14f..d78640d422f4 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2266,6 +2266,8 @@ static void uvc_disconnect(struct usb_interface *intf)
 		return;
 
 	uvc_unregister_video(dev);
+	/* Barrier needed to pair with uvc_video_stop_streaming(). */
+	smp_store_release(&dev->disconnected, true);
 	kref_put(&dev->ref, uvc_delete);
 }
 
@@ -2282,7 +2284,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	    UVC_SC_VIDEOCONTROL) {
 		mutex_lock(&dev->lock);
 		if (dev->users)
-			uvc_status_stop(dev);
+			uvc_status_stop(dev, true);
 		mutex_unlock(&dev->lock);
 		return 0;
 	}
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 0208612a9f12..9c5da1244999 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	uvc_status_stop(dev);
+	uvc_status_stop(dev, false);
 	uvc_input_unregister(dev);
 }
 
@@ -310,7 +310,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags)
 	return usb_submit_urb(dev->int_urb, flags);
 }
 
-void uvc_status_stop(struct uvc_device *dev)
+void uvc_status_stop(struct uvc_device *dev, bool run_async_work)
 {
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
@@ -326,7 +326,7 @@ void uvc_status_stop(struct uvc_device *dev)
 	 * Cancel any pending asynchronous work. If any status event was queued,
 	 * process it synchronously.
 	 */
-	if (cancel_work_sync(&w->work))
+	if (cancel_work_sync(&w->work) && run_async_work)
 		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
 
 	/* Kill the urb. */
@@ -338,7 +338,7 @@ void uvc_status_stop(struct uvc_device *dev)
 	 * cancelled before returning or it could then race with a future
 	 * uvc_status_start() call.
 	 */
-	if (cancel_work_sync(&w->work))
+	if (cancel_work_sync(&w->work) && run_async_work)
 		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
 
 	/*
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4988f03640a..f90206263ff4 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -672,7 +672,7 @@ static int uvc_v4l2_release(struct file *file)
 
 	mutex_lock(&stream->dev->lock);
 	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
+		uvc_status_stop(stream->dev, false);
 	mutex_unlock(&stream->dev->lock);
 
 	usb_autopm_put_interface(stream->dev->intf);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 28dde08ec6c5..f5ef375088de 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
 	return ret;
 }
 
-void uvc_video_stop_streaming(struct uvc_streaming *stream)
+static void uvc_video_halt(struct uvc_streaming *stream)
 {
-	uvc_video_stop_transfer(stream, 1);
+	unsigned int epnum;
+	unsigned int pipe;
+	unsigned int dir;
 
 	if (stream->intf->num_altsetting > 1) {
 		usb_set_interface(stream->dev->udev, stream->intfnum, 0);
-	} else {
-		/*
-		 * UVC doesn't specify how to inform a bulk-based device
-		 * when the video stream is stopped. Windows sends a
-		 * CLEAR_FEATURE(HALT) request to the video streaming
-		 * bulk endpoint, mimic the same behaviour.
-		 */
-		unsigned int epnum = stream->header.bEndpointAddress
-				   & USB_ENDPOINT_NUMBER_MASK;
-		unsigned int dir = stream->header.bEndpointAddress
-				 & USB_ENDPOINT_DIR_MASK;
-		unsigned int pipe;
-
-		pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
-		usb_clear_halt(stream->dev->udev, pipe);
+		return;
 	}
 
+	/*
+	 * UVC doesn't specify how to inform a bulk-based device
+	 * when the video stream is stopped. Windows sends a
+	 * CLEAR_FEATURE(HALT) request to the video streaming
+	 * bulk endpoint, mimic the same behaviour.
+	 */
+	epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
+	pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
+	usb_clear_halt(stream->dev->udev, pipe);
+}
+
+void uvc_video_stop_streaming(struct uvc_streaming *stream)
+{
+	uvc_video_stop_transfer(stream, 1);
+
+	/*
+	 * Barrier needed to pair with uvc_disconnect().
+	 * We cannot call usb_* functions on a disconnected USB device.
+	 */
+	if (!smp_load_acquire(&stream->dev->disconnected))
+		uvc_video_halt(stream);
+
 	uvc_video_clock_cleanup(stream);
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b00..5b1a3643de05 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -559,6 +559,8 @@ struct uvc_device {
 	unsigned int users;
 	atomic_t nmappings;
 
+	bool disconnected;
+
 	/* Video control interface */
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_device mdev;
@@ -745,7 +747,7 @@ int uvc_status_init(struct uvc_device *dev);
 void uvc_status_unregister(struct uvc_device *dev);
 void uvc_status_cleanup(struct uvc_device *dev);
 int uvc_status_start(struct uvc_device *dev, gfp_t flags);
-void uvc_status_stop(struct uvc_device *dev);
+void uvc_status_stop(struct uvc_device *dev, bool run_async_work);
 
 /* Controls */
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;

-- 
2.43.0.rc1.413.gea7ed67945-goog

