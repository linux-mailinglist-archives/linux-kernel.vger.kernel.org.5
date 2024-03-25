Return-Path: <linux-kernel+bounces-117473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D088ABC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079691C38C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EEB1442F9;
	Mon, 25 Mar 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XALqHOUR"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E91442E4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384298; cv=none; b=SOyQaW3Z2D8Cgfs8v3RR0w/BKZq7f7EtukiqOdi2lHWiNljsG02/6fj3vca0FhCjtEcJpw8sTYxb0UVK39U6xbZqyJgJdvU1Cs7Ryfp6kb7qveVjDGT6Z08hlEzptLuiAWxK32keeAdlRcUc+rCJ8b9jqVQ4GSb37gIdy81DS/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384298; c=relaxed/simple;
	bh=IbGWx43paY/eY3BoKH9LIehCJLKILNpJ3miMe4Ay6xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQp6hw1JSuSEWcGnTcx6osJsHSrNAET/EK7hoSwD2B+PoaRokzl/RSOmJsUInbZosoGfHnAE7aG4yk/y4rH38JJYdmUe1nRpmSDLKJOv2eE5VCpfsyDrkNYMWtrROMUnUZs/ZmiJSGND48A2ZeIejoaqtBsVaE88FiiEyz07oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XALqHOUR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690bd329df2so25521906d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711384296; x=1711989096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu6CRq784zZk8JmoJH+VcllViInTfNkEV44O9xYOrqY=;
        b=XALqHOURwLxzSrUCmAtzogdBXLS0B10YeY7xXUN84e1uA57vs8G54f9t1Y15lCoT8t
         WpkWbGRHUb9R29DwN6A/Az5w6p9CJq1wX5t42u6je8wLdJb36RWtA8D8cYPRhDv4E2ll
         1pdDG2ZiTdgYbtAaePhd2mdxyCXDYj6DIruk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384296; x=1711989096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu6CRq784zZk8JmoJH+VcllViInTfNkEV44O9xYOrqY=;
        b=K3qtdCcKbw4VYwcopYMVW87/6WlMdET94MVzbs5kiv1lYRx/R3NBHEAZaVA8H1JUH8
         LZ5EuQBbIfR12qcXajeGrjcmfFMeKWcy9SWShtBKZr8mEDByreiC0NAalc3GdIMcIU1Z
         sdI98Ka182bJ7WbKfUr0CSesOIaHQrximGTbKK/ArmatBCwGGjeXdrbJ3gImSxn+Nr5A
         giyzty0gAsACkVMCCLf/grIA8+NNSN6+XLjPFp5X5Rz4QXvmZ8lJUtcX3BJLdk2UEpZ0
         9yzGf2vAbLwtMbruS14IIFjGZ3kDW5jEt1jW3Tchakp/9R9bE11o1t54L/sq+cUlayUF
         vm7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4G0yPNrm6s2CqaYKiqbm2KcUjqQUmtLTTSyL9SQU7ePymI6y6nYESQTqZ2Ju7aVrzs4qSBUgQzxKy0KtmUMP9DvoMR2GPzVUGVXs/
X-Gm-Message-State: AOJu0YziI3IBe6QF4BN/4xb88YVCc+VJAmTl49DqduVZG8xSkT1xW72U
	0ydbDvk7op+hOgCtuAFVwiR4rLiN7QlETb903n8t+Co9ph224cnetTEnLzKDEUwRhSTGd05K1+i
	OlA==
X-Google-Smtp-Source: AGHT+IEtUg0mwiYcW1LyaV+FksxmaMuJ5FBKdGORci81ZmbE9EryF5lCqjbumq/U6M1tZw0jXCPXEQ==
X-Received: by 2002:a05:6214:acc:b0:696:3705:fe5a with SMTP id g12-20020a0562140acc00b006963705fe5amr9938267qvi.7.1711384296101;
        Mon, 25 Mar 2024 09:31:36 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id jr9-20020a0562142a8900b006905c8b37bbsm376330qvb.133.2024.03.25.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:31:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 16:31:33 +0000
Subject: [PATCH v3 1/3] media: uvcvideo: stop stream during unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-guenter-mini-v3-1-c4bc61d84e03@chromium.org>
References: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
In-Reply-To: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
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

uvc_unregister_video() can be called asynchronously from
uvc_disconnect(). If the device is still streaming when that happens, a
plethora of race conditions can happen.

Make sure that the device has stopped streaming before exiting this
function.

If the user still holds handles to the driver's file descriptors, any
ioctl will return -ENODEV from the v4l2 core.

This change make uvc more consistent with the rest of the v4l2 drivers
using the vb2_fop_* and vb2_ioctl_* helpers.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e76..17fc945c8deb6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1911,8 +1911,19 @@ static void uvc_unregister_video(struct uvc_device *dev)
 		if (!video_is_registered(&stream->vdev))
 			continue;
 
+		/*
+		 * Serialize other access to the stream.
+		 */
+		mutex_lock(&stream->mutex);
+		uvc_queue_streamoff(&stream->queue, stream->type);
 		video_unregister_device(&stream->vdev);
 		video_unregister_device(&stream->meta.vdev);
+		mutex_unlock(&stream->mutex);
+
+		/*
+		 * Now the vdev is not streaming and all the ioctls will
+		 * return -ENODEV
+		 */
 
 		uvc_debugfs_cleanup_stream(stream);
 	}

-- 
2.44.0.396.g6e790dbe36-goog


