Return-Path: <linux-kernel+bounces-21651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A385F829263
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7661F26A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE45623B1;
	Wed, 10 Jan 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DiEzwTk6"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA11C2D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd3b34a58dso1005423b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704853177; x=1705457977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDxSSelDpoPAQNyNUVcKc0KClc7DkRzMA025xPQnKWc=;
        b=DiEzwTk68TMzOlv3pMYJg1FUXAoA45aG7e1rUzbT3KbM6XbhruQJrg6FXadOtSlx7H
         Gqydin0PG65VdOgYjtiatstfZdm/rpR2MlPyk8A2fUGnJsgkXaksO8kicyI2aOJT8VTj
         0Y3xxlqZEzvml7DrMZydujBppYtPxtufsSBDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704853177; x=1705457977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDxSSelDpoPAQNyNUVcKc0KClc7DkRzMA025xPQnKWc=;
        b=xCMAYrNz+3JSqJsDBTcW8yAktOExjBMt8UHtGM8gwacXxmGoi1xsSmEON4DKPcLKu8
         nc1qUsmksGLeUNtdifrguLtgtcFzMwUhXzyXK0a9bIIKD1ijzVoP6w+veltrSbGXQesq
         wo39MX4gMj4CzgJl+OnQMvXzdFLZLE2+makkJ6xCubh04njtrNi7SuirQSpLqNQw9hx0
         EMa5fGQaR2c8vQ1/6hFpt8hZT+TyEQ27vU3bMEWovYoqfrUIhqfg4EFlsPqv1Kd4uBeR
         3BHWBgga2B+CBzrXhtEWO/AWF515RdxusbvGwVjKBX0Le/l+d42x+ObqZfIMjIlmHKuL
         zGJA==
X-Gm-Message-State: AOJu0YwUKrkGs95+gNPDwCu05UVovwkXAozFjFio66T0Qws/6mYBdFbv
	V4dzmiJb6Tzd8093MyP3z8CLLPMIxoM0+ZxFXGpH6eWiQw==
X-Google-Smtp-Source: AGHT+IFKHS5gDIO09q4/OhKTSjfjm+tc4wEqOP2FsjkQaw+kuulPuiBk57t/oQBggGgZgoQQef8G/A==
X-Received: by 2002:a05:6808:1289:b0:3bc:316b:e5a8 with SMTP id a9-20020a056808128900b003bc316be5a8mr394036oiw.54.1704853177387;
        Tue, 09 Jan 2024 18:19:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:9106:7b1d:78f7:d925])
        by smtp.gmail.com with UTF8SMTPSA id y13-20020aa7854d000000b006d9bb4400f0sm2337199pfn.88.2024.01.09.18.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 18:19:36 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v3] virtio_balloon: stay awake while adjusting balloon
Date: Wed, 10 Jan 2024 11:19:25 +0900
Message-ID: <20240110021925.1137333-1-stevensd@google.com>
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
v2->v3:
 - Use _irq spinlock functions with adjustment_lock in workqueue, since
   the lock is accessed in an interrupt context.
v1 -> v2:
 - Use adjustment_signal_pending flag instead of a sequence number
 - Call pm_stay_awake/pm_relax on parent device instead of adding a wake
   event to the virtio balloon device

 drivers/virtio/virtio_balloon.c | 57 +++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..fa710e6c505a 100644
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
+	spin_lock_irq(&vb->adjustment_lock);
+	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = false;
+		pm_relax(vb->vdev->dev.parent);
+	}
+	spin_unlock_irq(&vb->adjustment_lock);
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
+	spin_lock_irq(&vb->adjustment_lock);
+	vb->adjustment_signal_pending = false;
+	spin_unlock_irq(&vb->adjustment_lock);
 
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


