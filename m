Return-Path: <linux-kernel+bounces-120527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0E88D8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609A71F2B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A208536AF8;
	Wed, 27 Mar 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KN2VspRS"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2422E645
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527893; cv=none; b=PZ1eBWhNc6zyOOccCMtsL2eK6xNK2PUNZLScNSU7cxUj5gzSay4LJXOakubLr5BmS293NqGCKpeuUClYO8YZzhFBpRV2utZ0XD6Mbg/if0342j6xSwdQNjLx8qNwOvX0sDbN/oCzhtbLJPTqzauzgtkk1J3zGwSa0c7OQ4Iyct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527893; c=relaxed/simple;
	bh=9RLuwP/ogAKSLndvjalwDyIeMRGXBo7XEO//Re2gJyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhnrGXvbBGLRf/cK9wOlsICrHW5RRDxLZ+KgVolqy9wnQ8/tHJ1gMPrQ2TqXmxuyO0SJT4TEueNq/oBYQDxPmzhEGv+ivbc/ZNe8N9Nv0b9Yt1Wom1OyOS/xxwMnZ9oaBImPpABY+fxga+Yuh2dUHPR4HFV7dRNWJFJsp6HwMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KN2VspRS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430c63d4da9so45520881cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711527891; x=1712132691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmWRpBECwxe7ijkwLIPczozPsnS1Cw5Xsz7/RS0qQRY=;
        b=KN2VspRSefxtVCrZwxhPyUR3lyvvXDry6xKhdC9et//LgUKh5H5xwzegX7Yfn9PJ8b
         TWWIlCZJa62htCAp6yvw2FYJvQE2vOOedJig99A3mOIsYmK6U+aTAofQc8iabmis2v2a
         EoTlH6WjhMJFREThjwvC8b2SDwcCnDsElQhEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527891; x=1712132691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmWRpBECwxe7ijkwLIPczozPsnS1Cw5Xsz7/RS0qQRY=;
        b=Ur8PxqM8+v4g4Ldow/TQJTdckIG1WhI1Abrp6t9jJuIVGmN+CwpUlRKqohFFneATnv
         57CYTXYBPL6ZoLkvYQFe0oqt1h4bvZnVxnS6/kRzqcA1kG/ecsUE65ZY+0QOq/K6uSXj
         nig9+jtNSRoeZc1Qa/uDzXrjZqmGwIECJFbMDJ/pNPl1mspiKz0HaJWq3BCNWrGPmCkV
         CAP/FJR9VUHQ/8/h7RXZK/b3D9f4P29iDEYEfp7gE9b8b1KobLcJ4HiLIeahLLBRLgU9
         /fKlMlGt/fQXGY1pGliMrHDxX/Eas+lj2xzd6ErzSCpF9Gk/9q/Jun5/rsCH1Hacumi5
         keyw==
X-Forwarded-Encrypted: i=1; AJvYcCXkmcef/I6MbzVef3lRsgQ9AtOcZRb8/O2sBpb1N1cXD/qCEHG3g4b6uW67Pz/nU1h5bdX31nEpYZV0eoE4y3TlP++JAplMez9PSSot
X-Gm-Message-State: AOJu0Yy2rMyBkca8+gJWzIBMMoozZGfQZrLZfhDoVekOct2wZQyzOPN5
	/THAwl4m9UuNPr0cm20qQMPfjs7vTCx0dtMAv9O0PxmS4i70ApfW5Ighf3BgDw==
X-Google-Smtp-Source: AGHT+IHcrYLlePvtS2L+3EOSxz98tF2AwNVGbSteXEp13d492FBjYS/lfiS4OitGu1Suvpn3kOVSXw==
X-Received: by 2002:a05:622a:253:b0:431:50a0:9154 with SMTP id c19-20020a05622a025300b0043150a09154mr4232946qtx.18.1711527890552;
        Wed, 27 Mar 2024 01:24:50 -0700 (PDT)
Received: from denia.c.googlers.com (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ca9-20020a05622a1f0900b00430ea220b32sm4581691qtb.71.2024.03.27.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:24:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Mar 2024 08:24:45 +0000
Subject: [PATCH v4 2/4] media: uvcvideo: Refactor the status irq API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-guenter-mini-v4-2-49955c198eae@chromium.org>
References: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
In-Reply-To: <20240327-guenter-mini-v4-0-49955c198eae@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Max Staudt <mstaudt@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.4

There are two different use-cases of uvc_status():
	- adding/removing a user when the camera is open/closed
	- stopping/starting when the camera is suspended/resumed

Make the API reflect these two use-cases and move all the refcounting
and locking logic to the uvc_status.c file.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 13 ++-------
 drivers/media/usb/uvc/uvc_status.c | 55 ++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c   | 22 +++++----------
 drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
 4 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 17fc945c8deb6..b579644ac0745 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
 	INIT_LIST_HEAD(&dev->streams);
 	kref_init(&dev->ref);
 	atomic_set(&dev->nmappings, 0);
-	mutex_init(&dev->lock);
 
 	dev->udev = usb_get_dev(udev);
 	dev->intf = usb_get_intf(intf);
@@ -2282,10 +2281,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	/* Controls are cached on the fly so they don't need to be saved. */
 	if (intf->cur_altsetting->desc.bInterfaceSubClass ==
 	    UVC_SC_VIDEOCONTROL) {
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			uvc_status_stop(dev);
-		mutex_unlock(&dev->lock);
+		uvc_status_suspend(dev);
 		return 0;
 	}
 
@@ -2316,12 +2312,7 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
 				return ret;
 		}
 
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			ret = uvc_status_start(dev, GFP_NOIO);
-		mutex_unlock(&dev->lock);
-
-		return ret;
+		return uvc_status_resume(dev);
 	}
 
 	list_for_each_entry(stream, &dev->streams, list) {
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e24..375a95dd30110 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -257,6 +257,8 @@ int uvc_status_init(struct uvc_device *dev)
 	unsigned int pipe;
 	int interval;
 
+	mutex_init(&dev->status_lock);
+
 	if (ep == NULL)
 		return 0;
 
@@ -302,18 +304,22 @@ void uvc_status_cleanup(struct uvc_device *dev)
 	kfree(dev->status);
 }
 
-int uvc_status_start(struct uvc_device *dev, gfp_t flags)
+static int __uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
+	lockdep_assert_held(&dev->status_lock);
+
 	if (dev->int_urb == NULL)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
 }
 
-void uvc_status_stop(struct uvc_device *dev)
+static void __uvc_status_stop(struct uvc_device *dev)
 {
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
+	lockdep_assert_held(&dev->status_lock);
+
 	/*
 	 * Prevent the asynchronous control handler from requeing the URB. The
 	 * barrier is needed so the flush_status change is visible to other
@@ -350,3 +356,48 @@ void uvc_status_stop(struct uvc_device *dev)
 	 */
 	smp_store_release(&dev->flush_status, false);
 }
+
+int uvc_status_resume(struct uvc_device *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users)
+		ret = __uvc_status_start(dev, GFP_NOIO);
+	mutex_unlock(&dev->status_lock);
+
+	return ret;
+}
+
+void uvc_status_suspend(struct uvc_device *dev)
+{
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users)
+		__uvc_status_stop(dev);
+	mutex_unlock(&dev->status_lock);
+}
+
+int uvc_status_get(struct uvc_device *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->status_lock);
+	if (!dev->status_users)
+		ret = __uvc_status_start(dev, GFP_KERNEL);
+	if (!ret)
+		dev->status_users++;
+	mutex_unlock(&dev->status_lock);
+
+	return ret;
+}
+
+void uvc_status_put(struct uvc_device *dev)
+{
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users == 1)
+		__uvc_status_stop(dev);
+	WARN_ON(!dev->status_users);
+	if (dev->status_users)
+		dev->status_users--;
+	mutex_unlock(&dev->status_lock);
+}
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4988f03640ae..97c5407f66032 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -628,20 +628,13 @@ static int uvc_v4l2_open(struct file *file)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&stream->dev->lock);
-	if (stream->dev->users == 0) {
-		ret = uvc_status_start(stream->dev, GFP_KERNEL);
-		if (ret < 0) {
-			mutex_unlock(&stream->dev->lock);
-			usb_autopm_put_interface(stream->dev->intf);
-			kfree(handle);
-			return ret;
-		}
+	ret = uvc_status_get(stream->dev);
+	if (ret) {
+		usb_autopm_put_interface(stream->dev->intf);
+		kfree(handle);
+		return ret;
 	}
 
-	stream->dev->users++;
-	mutex_unlock(&stream->dev->lock);
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -670,10 +663,7 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
-	mutex_unlock(&stream->dev->lock);
+	uvc_status_put(stream->dev);
 
 	usb_autopm_put_interface(stream->dev->intf);
 	return 0;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b009..00b600eb058cc 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -555,8 +555,6 @@ struct uvc_device {
 
 	const struct uvc_device_info *info;
 
-	struct mutex lock;		/* Protects users */
-	unsigned int users;
 	atomic_t nmappings;
 
 	/* Video control interface */
@@ -578,6 +576,8 @@ struct uvc_device {
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
 	struct uvc_status *status;
+	struct mutex status_lock; /* Protects status_users */
+	unsigned int status_users;
 	bool flush_status;
 
 	struct input_dev *input;
@@ -744,8 +744,10 @@ int uvc_register_video_device(struct uvc_device *dev,
 int uvc_status_init(struct uvc_device *dev);
 void uvc_status_unregister(struct uvc_device *dev);
 void uvc_status_cleanup(struct uvc_device *dev);
-int uvc_status_start(struct uvc_device *dev, gfp_t flags);
-void uvc_status_stop(struct uvc_device *dev);
+int uvc_status_resume(struct uvc_device *dev);
+void uvc_status_suspend(struct uvc_device *dev);
+int uvc_status_get(struct uvc_device *dev);
+void uvc_status_put(struct uvc_device *dev);
 
 /* Controls */
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;

-- 
2.44.0.396.g6e790dbe36-goog


