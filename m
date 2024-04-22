Return-Path: <linux-kernel+bounces-152815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3928AC4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BA6280E56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2179482FF;
	Mon, 22 Apr 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VeIVKaoE"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAC48CF2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769308; cv=none; b=fTq/ycO7W5n6a1zZzdOJh5U97TsBwPV3jxlvrtdnVKkgIQSYLFr1q5wCoXyBl7LZZKL3+dSVWNx0kWKL/qtzD2kuyAa1Wncd8njapq3bpqD3ZnV8k7J+85ofqE2NTuOH0VcZveY6qikrP2llWb9hHU2pY0QFVQ7rgslmQNjwGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769308; c=relaxed/simple;
	bh=Xy32KSqRdhIN0Ie4e4eGrUBUj+fNig2wgvtR1UXLyD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh37jGsW5WGwKHWln5Wuiqfa1FyfyPBZSQ4koGGAuFKNFR+OI5Vnrq+vF0edMEDYl+6un3uhhmRmMC2gXheMsoQ+1uah7aGdKR6pGJbPmqI4mrNhwoSAtSZXHEhh2pGEQEJWkb1Ep9WHIi0MyC9nBSppk6bepmJ9sRkORXCbzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VeIVKaoE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1968874b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713769304; x=1714374104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwTDCi4263bvZbgRL3BQ9EFcpy+4L1K3NItwzBfyC88=;
        b=VeIVKaoEDArHoTzhxEFoIUeLdsxmDo/uXsTIlwzEXfklgYLFRZiyh4eFsQBakJskJD
         2/vxoTRV39/aA/zWzDxtr86E3aMbPxzUYDyA6X/za3odf8oDmaOlT8nkUVHMknScQu/f
         YVWXQAnkvwLjzSUXK8yIbpRRFV4YrDTPkGLCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769304; x=1714374104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwTDCi4263bvZbgRL3BQ9EFcpy+4L1K3NItwzBfyC88=;
        b=Uhx5gm3nk87PoIpllN59mxx7O66qVvNkg4ZGgSxEFm+u6lfE/Aajgvf9Hze3CYVL4t
         wtutOQy4kJsPjfwPW+CkJRroBZN25qJbmlgDOtuJCpOOkQ5CbLU+B96CTGAP7GFcqkVS
         uBoT9R6Mizu0MA6/Wqw3vXIBtCVcfmyLNldQwLQzy6T3ec0Tz0nTkjVTtNQSoItXSpXl
         X9UNNulxdkRGlL8emYBBBQ7zSxSpdzgfgn3cLunJ5/xgzcFCi4ETLBO3buPAdEFxmRl7
         O8RzEGDwVBpAqIw/Ji9OpluyTrfI8njEjeR4HgaKIuHIRTLfzMCnP6G5MQpJHyHpyAyv
         4dZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz3FnbIHmSZVKewF01okWe/+GOExnYYPjTEKgnuEqBi/zl/SW6TrfRjPAFGf+qC4ARa05G4yICQ9eH2m1hmjZr3+Z6GAolYMpuCakY
X-Gm-Message-State: AOJu0YwdcKhX9jaFeMpqo2cun5q3CXFJYIYaufqgErx20rtfqkWa0E2O
	SbAwfACzBlh+6KVgqgVhEC1bFQg1iVmvfstzNT9eGhyS+K9i6UUr0ExQs3sWGg==
X-Google-Smtp-Source: AGHT+IE6pWrWTUKPGep0x/4yve610F/NLl6S35jJwaxFabOo8IE6X1d9cVSVAIr+Sv95VTHeeAe5eg==
X-Received: by 2002:a05:6a00:847:b0:6ea:dfc1:b86 with SMTP id q7-20020a056a00084700b006eadfc10b86mr13138750pfk.12.1713769303768;
        Mon, 22 Apr 2024 00:01:43 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:abfb:1876:7a20:8e16])
        by smtp.gmail.com with UTF8SMTPSA id x23-20020a056a00189700b006edadf8058asm7159767pfh.23.2024.04.22.00.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:01:42 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-dev@lists.oasis-open.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 1/1] virtio: Add support for the virtio suspend feature
Date: Mon, 22 Apr 2024 16:01:28 +0900
Message-ID: <20240422070128.1980027-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422070128.1980027-1-stevensd@chromium.org>
References: <20240422070128.1980027-1-stevensd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the VIRTIO_F_SUSPEND feature. When this feature is
negotiated, power management can use it to suspend virtio devices
instead of resorting to resetting the devices entirely.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 34 ++++++++---------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++
 include/linux/virtio.h             |  8 ++++
 include/uapi/linux/virtio_config.h | 10 ++++-
 5 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..c7685a0dc995 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/virtio.h>
+#include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_anchor.h>
@@ -498,6 +499,13 @@ void unregister_virtio_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
 
+void virtio_device_mark_removed(struct virtio_device *dev)
+{
+	/* Pairs with READ_ONCE() in virtio_device_set_suspend_bit(). */
+	WRITE_ONCE(dev->removed, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_mark_removed);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev)
 {
@@ -580,6 +588,58 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
+{
+	u8 status, target;
+
+	status = dev->config->get_status(dev);
+	if (enabled)
+		target = status | VIRTIO_CONFIG_S_SUSPEND;
+	else
+		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
+
+	if (target == status)
+		return 0;
+
+	dev->config->set_status(dev, target);
+
+	while ((status = dev->config->get_status(dev)) != target) {
+		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
+			return -EIO;
+		/* Pairs with WRITE_ONCE() in virtio_device_mark_removed(). */
+		if (READ_ONCE(dev->removed))
+			return -EIO;
+		msleep(10);
+	}
+	return 0;
+}
+
+bool virtio_device_can_suspend(struct virtio_device *dev)
+{
+	return virtio_has_feature(dev, VIRTIO_F_SUSPEND) &&
+	       (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FEATURES_OK);
+}
+EXPORT_SYMBOL_GPL(virtio_device_can_suspend);
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+bool virtio_device_can_resume(struct virtio_device *dev)
+{
+	return virtio_has_feature(dev, VIRTIO_F_SUSPEND) &&
+	       (dev->config->get_status(dev) & VIRTIO_CONFIG_S_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(virtio_device_can_resume);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, false);
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..a6ca7718b5dc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
-static bool vp_supports_pm_no_reset(struct device *dev)
+static int virtio_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 pmcsr;
-
-	if (!pci_dev->pm_cap)
-		return false;
-
-	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		dev_err(dev, "Unable to query pmcsr");
-		return false;
-	}
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
-	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
-}
+	if (virtio_device_can_suspend(&vp_dev->vdev))
+		return virtio_device_suspend(&vp_dev->vdev);
 
-static int virtio_pci_suspend(struct device *dev)
-{
-	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
+	return virtio_pci_freeze(dev);
 }
 
 static int virtio_pci_resume(struct device *dev)
 {
-	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	if (virtio_device_can_resume(&vp_dev->vdev))
+		return virtio_device_resume(&vp_dev->vdev);
+
+	return virtio_pci_restore(dev);
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
@@ -623,9 +618,12 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	 * Device is marked broken on surprise removal so that virtio upper
 	 * layers can abort any ongoing operation.
 	 */
-	if (!pci_device_is_present(pci_dev))
+	if (!pci_device_is_present(pci_dev)) {
 		virtio_break_device(&vp_dev->vdev);
 
+		virtio_device_mark_removed(&vp_dev->vdev);
+	}
+
 	pci_disable_sriov(pci_dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..ac8734526b8d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
 	__virtqueue_break(admin_vq->info.vq);
 }
 
+static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
+{
+	u16 pmcsr;
+
+	if (!pci_dev->pm_cap)
+		return false;
+
+	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		dev_err(&pci_dev->dev, "Unable to query pmcsr");
+		return false;
+	}
+
+	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 
 	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
 		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
+
+	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
+		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
 }
 
 static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..2ca2ae290d4f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,6 +115,7 @@ struct virtio_admin_cmd {
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
+ * @removed: whether or not the device was removed from under us
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
@@ -130,6 +131,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
+	bool removed;
 	bool config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
@@ -156,10 +158,16 @@ void __virtio_unbreak_device(struct virtio_device *dev);
 void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
+void virtio_device_mark_removed(struct virtio_device *dev);
+
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
+bool virtio_device_can_suspend(struct virtio_device *dev);
+bool virtio_device_can_resume(struct virtio_device *dev);
+int virtio_device_suspend(struct virtio_device *dev);
+int virtio_device_resume(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce7..4a6e2c28ea76 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -40,6 +40,8 @@
 #define VIRTIO_CONFIG_S_DRIVER_OK	4
 /* Driver has finished configuring features */
 #define VIRTIO_CONFIG_S_FEATURES_OK	8
+/* Driver has suspended the device */
+#define VIRTIO_CONFIG_S_SUSPEND		0x10
 /* Device entered invalid state, driver must reset it */
 #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
 /* We've given up on this device. */
@@ -52,7 +54,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		43
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +122,10 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the driver can suspend the device via the
+ * suspend bit in the device status byte.
+ */
+#define VIRTIO_F_SUSPEND		42
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.44.0.769.g3c40516874-goog


