Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C578C7F4513
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbjKVLqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:45:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3D1AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:45:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41ccd38eaa5so6279291cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700653551; x=1701258351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jbUgexWSE+UkwxAykTeDpdOwZGPMwaBInU8mlrkF50=;
        b=FMIPQhVWAUX99jBK/61YMbTBqOPSAGwDVxrJzMi32KGBhrkep7XdX9kKhVDmP8X3mr
         lP7JJLFBJRx8YJ3uNfVq6trTIstNVw0RYGIhkVyVLjOmSyx02kpJQPU9XEnOiKWYCuVD
         Mftzw31w+nAGSx5uG0SViTMP1o6a/ZfoB3ltU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700653551; x=1701258351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jbUgexWSE+UkwxAykTeDpdOwZGPMwaBInU8mlrkF50=;
        b=K9/V6n3AyzXZJe1eAP6VymAyOSXso+U4OdBgbiIuTuA2bsqO5OlwkSA9gnYftRgolw
         Bjvq1TnMLm3tJopF8Q7E2UlM9uCBtVBoTbP7sJnfDd2EWyDOYL1AmFUXdcLDVEMlGgwH
         Mu87eJE6yNPSJUnIkpZqMSn2HrQ+MCQ4pKJW8XadcGWTYRwgBCqOJ7NmWl4UwDwM5nEg
         82i3hDu29jpX4ThAnQLNezty6F9KR6ZKBKSrM/hf8qOGbxTrs1Xhf1uYzG4oMCbb2Rw6
         H8Dumchlv312Fad7SPUxkAqaDVYdlbNiX104MLr3FqwezpEjq0FIE7eRg3kVU2NQrXEx
         vJrQ==
X-Gm-Message-State: AOJu0YwsJLGvM/tvypQwW/xLeYJzZFw5cjo+5bLieKyaVSQP+7m0ARN6
        WLAYtvFUPVIuAhKIg5vjPBfSiQ==
X-Google-Smtp-Source: AGHT+IFodkyAJCmsafuO1iHU1vxR0lAw0pyCS50IbjxIuK4OPhQJVWfXNaYu+OFCnB8r2gyR59P9BQ==
X-Received: by 2002:a05:622a:5085:b0:423:7279:2662 with SMTP id fp5-20020a05622a508500b0042372792662mr5108506qtb.10.1700653550850;
        Wed, 22 Nov 2023 03:45:50 -0800 (PST)
Received: from denia.c.googlers.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id h3-20020ac85143000000b00419732075b4sm4357790qtn.84.2023.11.22.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:45:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 11:45:47 +0000
Subject: [PATCH v5 1/3] media: uvcvideo: Lock video streams and queues
 while unregistering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-guenter-mini-v5-1-15d8cd8ed74f@chromium.org>
References: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
In-Reply-To: <20231122-guenter-mini-v5-0-15d8cd8ed74f@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
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

From: Guenter Roeck <linux@roeck-us.net>

The call to uvc_disconnect() is not protected by any mutex.
This means it can and will be called while other accesses to the video
device are in progress. This can cause all kinds of race conditions,
including crashes such as the following.

usb 1-4: USB disconnect, device number 3
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 5633 Comm: V4L2CaptureThre Not tainted 4.19.113-08536-g5d29ca36db06 #1
Hardware name: GOOGLE Edgar, BIOS Google_Edgar.7287.167.156 03/25/2019
RIP: 0010:usb_ifnum_to_if+0x29/0x40
Code: <...>
RSP: 0018:ffffa46f42a47a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff904a396c9000
RDX: ffff904a39641320 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffa46f42a47a80 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000009975 R11: 0000000000000009 R12: 0000000000000000
R13: ffff904a396b3800 R14: ffff904a39e88000 R15: 0000000000000000
FS: 00007f396448e700(0000) GS:ffff904a3ba00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000016cb46000 CR4: 00000000001006f0
Call Trace:
 usb_hcd_alloc_bandwidth+0x1ee/0x30f
 usb_set_interface+0x1a3/0x2b7
 uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
 uvc_video_start_streaming+0x91/0xdd [uvcvideo]
 uvc_start_streaming+0x28/0x5d [uvcvideo]
 vb2_start_streaming+0x61/0x143 [videobuf2_common]
 vb2_core_streamon+0xf7/0x10f [videobuf2_common]
 uvc_queue_streamon+0x2e/0x41 [uvcvideo]
 uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
 __video_do_ioctl+0x33d/0x42a
 video_usercopy+0x34e/0x5ff
 ? video_ioctl2+0x16/0x16
 v4l2_ioctl+0x46/0x53
 do_vfs_ioctl+0x50a/0x76f
 ksys_ioctl+0x58/0x83
 __x64_sys_ioctl+0x1a/0x1e
 do_syscall_64+0x54/0xde

usb_set_interface() should not be called after the USB device has been
unregistered. However, in the above case the disconnect happened after
v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().

Acquire various mutexes in uvc_unregister_video() to fix the majority
(maybe all) of the observed race conditions.

The uvc_device lock prevents races against suspend and resume calls
and the poll function.

The uvc_streaming lock prevents races against stream related functions;
for the most part, those are ioctls. This lock also requires other
functions using this lock to check if a video device is still registered
after acquiring it. For example, it was observed that the video device
was already unregistered by the time the stream lock was acquired in
uvc_ioctl_streamon().

The uvc_queue lock prevents races against queue functions, Most of
those are already protected by the uvc_streaming lock, but some
are called directly. This is done as added protection; an actual race
was not (yet) observed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..ded2cb6ce14f 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1907,14 +1907,22 @@ static void uvc_unregister_video(struct uvc_device *dev)
 {
 	struct uvc_streaming *stream;
 
+	mutex_lock(&dev->lock);
+
 	list_for_each_entry(stream, &dev->streams, list) {
 		if (!video_is_registered(&stream->vdev))
 			continue;
 
+		mutex_lock(&stream->mutex);
+		mutex_lock(&stream->queue.mutex);
+
 		video_unregister_device(&stream->vdev);
 		video_unregister_device(&stream->meta.vdev);
 
 		uvc_debugfs_cleanup_stream(stream);
+
+		mutex_unlock(&stream->queue.mutex);
+		mutex_unlock(&stream->mutex);
 	}
 
 	uvc_status_unregister(dev);
@@ -1925,6 +1933,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 	if (media_devnode_is_registered(dev->mdev.devnode))
 		media_device_unregister(&dev->mdev);
 #endif
+	mutex_unlock(&dev->lock);
 }
 
 int uvc_register_video_device(struct uvc_device *dev,

-- 
2.43.0.rc1.413.gea7ed67945-goog

