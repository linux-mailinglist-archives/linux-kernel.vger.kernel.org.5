Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8576E7E6180
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjKIAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjKIAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:41:16 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A922696
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:41:13 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc5ef7e815so2002225ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699490473; x=1700095273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfIcnNK4CP8AvroQHK0BiBRCHDWi0iGc94q1kRdTwyc=;
        b=U2wwkfA+8Yt+JYZ7+UGfU/xHyglU6pyyuiX1SRmCeKPbTnVurxEkOGUOpDI81AE6rK
         zxnc2JM+IdzuEQNLmB46DJdtduOnDlkj2vZBUfzqDU6wluBC3VQMWpqRM7jKW4h+J3IV
         CKGrXt2rKxvyHRK2VNn8+YgN+g28mIPmq50XeNptyKGq7h/7Jb4GesuLAw0eUAAfzuBN
         YwxO3VMwv6sHHDocBeVKf6ryqDSqN31zfLGuul4hFkraJH2eraPmwvVRurMTaumIp/uo
         Br1e7zG0/2osVHsCQH3hswIhOQq7k1jWnCIdsAcbm3YC5rmsDdviIPiboJRhAf2jEKfO
         6ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699490473; x=1700095273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfIcnNK4CP8AvroQHK0BiBRCHDWi0iGc94q1kRdTwyc=;
        b=IMbElr/3mMuUeYPWDlyUywdRtWsPR6PzPXNIs7s0EnMou4wg7IVvHAtZvp0/RLbgOX
         5mh0KnO2m3CVjwphwz0scCmiJ8MH99jwOg/EVOIAzO1Br3g1NgZ6aWV386bqODqQ3cIF
         kgvakSzSCnj6D1g/8Kol086BbnR0sDu8c0uLaYSM5uC+PZFQdkEWnhB9xOgxru+UmByP
         iBUs1/7cALC1Q3Sv91hejmwhQJtkYS8r1tc6V3b51w0aJVIBE6YQ6oTLOdckpFrt2HWd
         EVtsftfS43pwW7Q5ydH+yEi1zORaiVbN3ESU+0FaNQhNQwfuMho2BdF+wG0wSlUeCUWM
         FJaQ==
X-Gm-Message-State: AOJu0YwClyRPFhEzDOVU4nPT+G7uBNyMd3Fv7QeVPxvT0rnlmgF8dPge
        rjr9lwHTbIFbM8AftoGGtye9J40zBaLg
X-Google-Smtp-Source: AGHT+IH4oM5cWgazODtCF2dRZI/RQBHue8ZYEJ3gV5BYwxylZLIMBVYuStH8YUhzEYAsGOdcSYmsLoZj1mRz
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a17:902:8c86:b0:1cc:30cf:eae6 with SMTP id
 t6-20020a1709028c8600b001cc30cfeae6mr87715plo.10.1699490473283; Wed, 08 Nov
 2023 16:41:13 -0800 (PST)
Date:   Wed,  8 Nov 2023 16:41:03 -0800
In-Reply-To: <20231109004104.3467968-1-arakesh@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com> <20231109004104.3467968-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109004104.3467968-3-arakesh@google.com>
Subject: [PATCH v12 3/4] usb: gadget: uvc: move video disable logic to its own function
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the video disable logic in uvcg_video_enable
into its own separate function 'uvcg_video_disable'. This function
is now used anywhere uvcg_video_enable(video, 0) was used.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
XX  -> v6  : Introduced this patch to make the next one easier to review
v6  -> v7  : Add Suggested-by
v7  -> v8  : No change. Getting back in review queue
v8  -> v9  : Call uvcg_video_disable directly instead of uvcg_video_enable(video, 0)
v9  -> v10 : Rebase to ToT (usb-next)
v10 -> v11 : No change
v11 -> v12 : Rebase to ToT (usb-next)

 drivers/usb/gadget/function/uvc_v4l2.c  |  6 ++--
 drivers/usb/gadget/function/uvc_video.c | 40 ++++++++++++++++---------
 drivers/usb/gadget/function/uvc_video.h |  3 +-
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 7cb8d027ff0c..904dd283cbf7 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -443,7 +443,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 		return -EINVAL;

 	/* Enable UVC video. */
-	ret = uvcg_video_enable(video, 1);
+	ret = uvcg_video_enable(video);
 	if (ret < 0)
 		return ret;

@@ -469,7 +469,7 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 		return -EINVAL;

 	uvc->state = UVC_STATE_CONNECTED;
-	ret = uvcg_video_enable(video, 0);
+	ret = uvcg_video_disable(video);
 	if (ret < 0)
 		return ret;

@@ -515,7 +515,7 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
 	if (uvc->state == UVC_STATE_STREAMING)
 		uvc->state = UVC_STATE_CONNECTED;

-	uvcg_video_enable(&uvc->video, 0);
+	uvcg_video_disable(&uvc->video);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
 	wake_up_interruptible(&uvc->func_connected_queue);
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 1619f9664748..c3e8c48f46a9 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -493,31 +493,43 @@ static void uvcg_video_pump(struct work_struct *work)
 }

 /*
- * Enable or disable the video stream.
+ * Disable the video stream
  */
-int uvcg_video_enable(struct uvc_video *video, int enable)
+int
+uvcg_video_disable(struct uvc_video *video)
 {
-	int ret;
 	struct uvc_request *ureq;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
-			  "Video enable failed, device is uninitialized.\n");
+			  "Video disable failed, device is uninitialized.\n");
 		return -ENODEV;
 	}

-	if (!enable) {
-		cancel_work_sync(&video->pump);
-		uvcg_queue_cancel(&video->queue, 0);
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);

-		list_for_each_entry(ureq, &video->ureqs, list) {
-			if (ureq->req)
-				usb_ep_dequeue(video->ep, ureq->req);
-		}
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		if (ureq->req)
+			usb_ep_dequeue(video->ep, ureq->req);
+	}

-		uvc_video_free_requests(video);
-		uvcg_queue_enable(&video->queue, 0);
-		return 0;
+	uvc_video_free_requests(video);
+	uvcg_queue_enable(&video->queue, 0);
+	return 0;
+}
+
+/*
+ * Enable the video stream.
+ */
+int uvcg_video_enable(struct uvc_video *video)
+{
+	int ret;
+
+	if (video->ep == NULL) {
+		uvcg_info(&video->uvc->func,
+			  "Video enable failed, device is uninitialized.\n");
+		return -ENODEV;
 	}

 	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index 03adeefa343b..8ef6259741f1 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -14,7 +14,8 @@

 struct uvc_video;

-int uvcg_video_enable(struct uvc_video *video, int enable);
+int uvcg_video_enable(struct uvc_video *video);
+int uvcg_video_disable(struct uvc_video *video);

 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);

--
2.42.0.869.gea05f2083d-goog
