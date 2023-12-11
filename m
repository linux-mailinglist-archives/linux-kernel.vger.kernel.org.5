Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4999C80C85B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjLKLnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjLKLnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:43:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FDBA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:43:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso39504235ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702295036; x=1702899836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWSOqTGWbN7/1kah/VavpIcFubAITMhMWD90A/nR/50=;
        b=BahufwEbOMijAkG1weJ7ZlThAFQOgHDbp5s6SdfDUx9hW2LEXAZmVLE4ZeutUfSA+8
         eul/jl2J4FnbqqTPpiRBVDXYQgoFfMjA3F/nf7MryI2H2iUnGsFnUClS28vdmK2x1+sb
         LgNvJBv10scRfMgw6eXu0hu98ND5IHDS4INcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702295036; x=1702899836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWSOqTGWbN7/1kah/VavpIcFubAITMhMWD90A/nR/50=;
        b=tTtisKy71Eu7e1wwLd6SyyGHiVf/P8FgJvs3s8185Q1NZNP58d8eBTJxMwNpbt68MH
         V8dRZ/+bW3QIhrSEj0H9EzAwrm1Uj0dEkGmByVqnf7ognAnHRTaRiNJ8wKqMXamn1qFI
         u9t++8uW2RDuEXKSLJKWlIl4KWtWmbq+Kqt+wluOr7nHnphdpEuMM73GKGopnvpctzl7
         ENTgTaOLOaurfVfKeLDLYO8s5F+RF0GT8N5jhTysrIOAqOsMV5mZqVFgQegBjogKksqt
         SN8xLrw4ZX8zDsjNuEMCAhFTpeb65lzt5mg/aCgnIDa2mpbYuDUwXqJnGmT/zBIvsTP1
         wp0Q==
X-Gm-Message-State: AOJu0Yyx/C2qQuNJhVVy0aNrGXn+RP8gCk+z/KkeIfnS78Lk/TF5llcn
        qN1H3UgUTSpDhLO25o2NIRIgmzLCD4wBpmMdark=
X-Google-Smtp-Source: AGHT+IH7Xh1az1wiQpVmjLradIRIrBROYVFJjrZ2ymcEvhmwqw1W9rUCiU1B3MJGvYEVoR+YJZt6iA==
X-Received: by 2002:a17:902:ecc4:b0:1d0:7b67:c535 with SMTP id a4-20020a170902ecc400b001d07b67c535mr5058442plh.17.1702295036027;
        Mon, 11 Dec 2023 03:43:56 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f046:fcb8:db69:41ed])
        by smtp.gmail.com with UTF8SMTPSA id n2-20020a170902d2c200b001cfd0ddc5b9sm6388253plc.262.2023.12.11.03.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 03:43:55 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH] virtio_balloon: stay awake while adjusting balloon
Date:   Mon, 11 Dec 2023 20:43:46 +0900
Message-ID: <20231211114346.1132386-1-stevensd@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add a wakeup event for when the balloon is inflating or deflating.
Userspace can enable this wakeup event to prevent the system from
suspending while the balloon is being adjusted. This allows
/sys/power/wakeup_count to be used without breaking virtio_balloon's
cooperative memory management.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..811d8937246a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -119,6 +119,11 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* State for keeping the wakeup_source active while adjusting the balloon */
+	spinlock_t adjustment_lock;
+	u32 adjustment_seqno;
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
+	vb->adjustment_seqno++;
+	if (!vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = true;
+		pm_stay_awake(&vb->vdev->dev);
+	}
+	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
+
+	queue_work(system_freezable_wq, &vb->update_balloon_size_work);
+}
+
+static void end_update_balloon_size(struct virtio_balloon *vb, u32 seqno)
+{
+	spin_lock(&vb->adjustment_lock);
+	if (vb->adjustment_seqno == seqno && vb->adjustment_in_progress) {
+		vb->adjustment_in_progress = false;
+		pm_relax(&vb->vdev->dev);
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
@@ -473,22 +502,29 @@ static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
 	s64 diff;
+	u32 seqno;
 
 	vb = container_of(work, struct virtio_balloon,
 			  update_balloon_size_work);
-	diff = towards_target(vb);
 
-	if (!diff)
-		return;
+	spin_lock(&vb->adjustment_lock);
+	seqno = vb->adjustment_seqno;
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
+		end_update_balloon_size(vb, seqno);
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -992,6 +1028,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	spin_lock_init(&vb->adjustment_lock);
+	device_set_wakeup_capable(&vb->vdev->dev, true);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.43.0.472.g3155946c3a-goog

