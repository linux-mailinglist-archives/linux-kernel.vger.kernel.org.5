Return-Path: <linux-kernel+bounces-148185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1B8A7ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AD21F220C4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF9212EBDB;
	Wed, 17 Apr 2024 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FCT1Ai9n"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FC13B7B3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344095; cv=none; b=uCylDPAqglRaOLt/PzJCn3Tc/ghI50djOMylvvTaIT+bB5xDwKLMYxYZWJau9Ci8n/OkijafT1Q6gbi2D2BDyIFl5alvfcIgTuyog5Nc4SXzB5Chiy2N7LzPTre4uVXWo6/zkFzdaLfaBiUiIxLm844AG1RUdV8tqwXXK13x51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344095; c=relaxed/simple;
	bh=0ycUtrSztOjzI9Q6VHwn3xtUH0mWNi0JOO2GjFmGm1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfvv51dMrp/0lnZBkvJR9n6akwZKVwwSICULA5YFELrV3/kcRixeHbqzN7vQVpy6mz6RNvEQ4NhnduS/SDo4HIer4y+DSYLQAorW1zLaOUi1f2U0SSfahO7mKWG5KJ4Ewk4dqP/YsnwjFj4Vps32Wl20QcRk+jmfUWvueVhUzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FCT1Ai9n; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e51398cc4eso49703795ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713344093; x=1713948893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVe6fJidHiWqF1ubI92yuDtWS6IKftFO9rWVP2qn744=;
        b=FCT1Ai9nHyxjYmUQRfeiOdU5nnBWl8+xvh8XIvIFO3kopSn+iLe4t3P9xWx5RYuHFf
         m9yXvLxELPhVd4Uc5PE4L1+ZPlU5VXZICuZKEv9Di8Ix1YtMO1KrM6aprLpMx8ykMQIi
         YZVN9j6u/Z2yxaQK1qjGhGLrCzymGHW4Wastg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344093; x=1713948893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVe6fJidHiWqF1ubI92yuDtWS6IKftFO9rWVP2qn744=;
        b=gHMnwZ20rlpunNfVVFwLkAmlqemDH5a8uCgtggy7GaJV1vxKXFHZt3PLTXPr9OcMMY
         W+ChiLHV94y7L2Ho3xQ3Kyx3QLMkuR4FcANV7I9lC6CHaKLlKiplsh1kW0h8Pv1fEU59
         Tfy4090tNikUUlTw4oC1yV2ugFDlnXvafQlVectcXNk7ZwPWrVUalOUoHm3GuqtUDYuC
         bp9dqmXilWZdea1bLGqNwjP8EBHUFfRV21ZCCNJf8UrriipcO7ebf9N5TBEDswtq3qJp
         /BTIqfaSo/dGnbVW62znM04J+clYrN9q45OTtw2CR2sfUY/JE/gTHgY71HW98askOimj
         HXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUma7B3GISWvReyOBo6MdsjMkt9JEoAhh/cqUocgwp9F2sVMxaScGXH6zxuA3EafWLnsf29ENYNFTfNBNGe047V1zQ6Al8mYdpb7D0
X-Gm-Message-State: AOJu0Yw7kxEe8G+o9qCmw6Wcp9nRJjlVDrR3MEJ/qjJ1X0eMsP3lzyIU
	n2WHWcmk6H9PI8jobarFHFZyhmrpBsLMRrGr6yFvj7OPbMrm8H6WfohOhIAYTw==
X-Google-Smtp-Source: AGHT+IHwnmxVxXYkbKiaWuH95n6UDpeU69HsZ9J/5XkmQPgDW2OBZeMIU6j8uUdiaQ0iNCv0/85HKA==
X-Received: by 2002:a17:903:2609:b0:1e2:ca65:68c2 with SMTP id jd9-20020a170903260900b001e2ca6568c2mr15746900plb.51.1713344093202;
        Wed, 17 Apr 2024 01:54:53 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:c7f8:50e7:e1ff:743b])
        by smtp.gmail.com with UTF8SMTPSA id a20-20020a170902b59400b001dddbb58d5esm11048957pls.109.2024.04.17.01.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:54:52 -0700 (PDT)
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
Subject: [PATCH 1/1] virtio: Add support for the virtio suspend feature
Date: Wed, 17 Apr 2024 17:54:39 +0900
Message-ID: <20240417085440.4036535-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240417085440.4036535-1-stevensd@chromium.org>
References: <20240417085440.4036535-1-stevensd@chromium.org>
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
 drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
 include/linux/virtio.h             |  2 ++
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 5 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..cd11495a5098 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/virtio.h>
+#include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_anchor.h>
@@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
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
+	dev->config->set_status(dev, target);
+
+	while ((status = dev->config->get_status(dev)) != target) {
+		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
+			return -EIO;
+		mdelay(10);
+	}
+	return 0;
+}
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, false);
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..4d542de05970 100644
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
+	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
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
+	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
+		return virtio_device_resume(&vp_dev->vdev);
+
+	return virtio_pci_restore(dev);
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
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
index b0201747a263..8e456b04114e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
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
2.44.0.683.g7961c838ac-goog


