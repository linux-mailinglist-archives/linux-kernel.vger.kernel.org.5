Return-Path: <linux-kernel+bounces-3920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B99817521
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F21D1C239BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6AD42388;
	Mon, 18 Dec 2023 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kdp61XXv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138B42385
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so5481465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702912742; x=1703517542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmSCxqVBdvceRVp8l3JOrS4y62t292lMmgaWp/xD5yk=;
        b=Kdp61XXvrpBJasetj9LNLTK0MhozOq8RIMnrRLdWJvw9wL54eRlnxSWr4CgLO87DZ+
         Z/hZBQx1qmLP9C8Bdj2oWcDCoUeIa9qFeLDWsR4dHIqbOvJU4mCFNty/TZDEjE1v8bTt
         88szkJFOFqN6oEKMCFfotKy/e6vXoHAqWgxoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912742; x=1703517542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmSCxqVBdvceRVp8l3JOrS4y62t292lMmgaWp/xD5yk=;
        b=kxeMerIpCH9zpsG606UMt2tERwUOJblUjIqH1EwwPN29kDrGv7hn2k6e+fSZzLyWtw
         eCU9pykiqGXDx2X7rSG5+yopf2+1Q+XsNCOTd3Sd9rJAe0WEh1m5z0kKnfp96Lqrqt3c
         728h5eOHZbNn8xP5/rEAVzblUR5YLbqv7l7cPdQl26Xz3ZJaHSaqo82pPS0lVm9HpTjl
         YsFQPHP5R1xZt9un2SNJ9hn73z3XVnkVMhHzuMz2NPcsJPsFyl336BZcJhDo13tonmYU
         UFMseilkFGwCyE/yNXFx2uwMOJC4cd+oxKiDSa3e6QlP1bMcbs/oUofZYeZdle5ToiD0
         cU2g==
X-Gm-Message-State: AOJu0YxXx77f6cDHdhWJ51VcbtPCWPayAl26An631vj/nhGLpFrvW5Dg
	iEBKXpRuqfpDSRBPsoNl8krPyw==
X-Google-Smtp-Source: AGHT+IFBLDWTrxqHzpacLkEIOONVOQWppVZJgDOzuOYrpu86Oq3gL8gLmFqD8UBT/yIzelpI2poRjA==
X-Received: by 2002:a17:902:e5d2:b0:1d3:41b6:6d7b with SMTP id u18-20020a170902e5d200b001d341b66d7bmr6120832plf.108.1702912742074;
        Mon, 18 Dec 2023 07:19:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:3a86:36f7:a34d:55f2])
        by smtp.gmail.com with UTF8SMTPSA id v4-20020a17090331c400b001d0c5037ed3sm19353681ple.46.2023.12.18.07.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 07:19:00 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] virtio_balloon: stay awake while adjusting balloon
Date: Tue, 19 Dec 2023 00:18:42 +0900
Message-ID: <20231218151842.2756673-1-stevensd@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

A virtio_balloon's parent device may be configured so that a
configuration change interrupt is a wakeup event. Extend the processing
of such a wakeup event until the balloon finishes inflating or deflating
by calling pm_stay_awake/pm_relax in the virtio_balloon driver. Note
that these calls are no-ops if the parent device doesn't support wakeup
events or if the wakeup events are not enabled.

This change allows the guest to use system power states such as s2idle
without running the risk the virtio_balloon's cooperative memory
management becoming unresponsive to the host's requests.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v1 -> v2:
 - Use adjustment_signal_pending flag instead of a sequence number
 - Call pm_stay_awake/pm_relax on parent device instead of adding a wake
   event to the virtio balloon device

 drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..a3c11159cbe0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -119,6 +119,11 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* State for keeping the wakeup_source active while adjusting the balloon */
+	spinlock_t adjustment_lock;
+	bool adjustment_signal_pending;
+	bool adjustment_in_progress;
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -437,6 +442,31 @@ static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
 	queue_work(vb->balloon_wq, &vb->report_free_page_work);
 }
 
+static void start_update_balloon_size(struct virtio_balloon *vb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vb->adjustment_lock, flags);
+	vb->adjustment_signal_pending = true;
+	if (!vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = true;
+		pm_stay_awake(vb->vdev->dev.parent);
+	}
+	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
+
+	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
+}
+
+static void end_update_balloon_size(struct virtio_balloon *vb)
+{
+	spin_lock(&vb->adjustment_lock);
+	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = false;
+		pm_relax(vb->vdev->dev.parent);
+	}
+	spin_unlock(&vb->adjustment_lock);
+}
+
 static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
@@ -444,8 +474,7 @@ static void virtballoon_changed(struct virtio_device *vdev)
 
 	spin_lock_irqsave(&vb->stop_update_lock, flags);
 	if (!vb->stop_update) {
-		queue_work(system_freezable_wq,
-			   &vb->update_balloon_size_work);
+		start_update_balloon_size(vb);
 		virtio_balloon_queue_free_page_work(vb);
 	}
 	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
@@ -476,19 +505,25 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
-	diff = towards_target(vb);
 
-	if (!diff)
-		return;
+	spin_lock(&vb->adjustment_lock);
+	vb->adjustment_signal_pending = false;
+	spin_unlock(&vb->adjustment_lock);
 
-	if (diff > 0)
-		diff -= fill_balloon(vb, diff);
-	else
-		diff += leak_balloon(vb, -diff);
-	update_balloon_size(vb);
+	diff = towards_target(vb);
+
+	if (diff) {
+		if (diff > 0)
+			diff -= fill_balloon(vb, diff);
+		else
+			diff += leak_balloon(vb, -diff);
+		update_balloon_size(vb);
+	}
 
 	if (diff)
 		queue_work(system_freezable_wq, work);
+	else
+		end_update_balloon_size(vb);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -992,6 +1027,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	spin_lock_init(&vb->adjustment_lock);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.43.0.472.g3155946c3a-goog


