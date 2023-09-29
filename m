Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F67B3B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjI2Uqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjI2Uqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:46:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8114170E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so14453283a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696020372; x=1696625172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+z394u1icTlUvm5Wt49UZrjbdFkyO1xfSo9ivxRNHc=;
        b=OwA5g9vHzaGucmbi2nFxkhlgKIkqqT68Q2bUqsH1nWmTeGNRPYtvDC2WgSmVsDmQ1o
         Kq1H02PSmDkIdpLuqlwW6Gg6eoZZLGSzEf79pmOV2cbw33uBNBsqu4BONUD4Qdu1H0Go
         xryiH+cJJlYxaek4ZO6DErPYtM1Y2GwiLqUMMwh7WNh5A1xv6LrBDPLWzVU3tXZlHspV
         8PAyznmvvgyX86aAGfkk/iNGYF1bnpzr/Vpn2Q6+f5ctF2ubr1VfWE6gI5TYbSK8y/SW
         9qBtEfWiHIR7R0ARc0uvtpj8ebJI41I36H9+cez3bNLIDpVA12/MW3iHXC0bFN8m6bdf
         fO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696020372; x=1696625172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+z394u1icTlUvm5Wt49UZrjbdFkyO1xfSo9ivxRNHc=;
        b=MYLWrot5jYfhZQD3N08MsyYxMpXOLfVmTHG/tm7FUp0/eHny3WjLX0EobDsgY/vTBd
         kbob/D61X2M2kP+effBB9h/lUCz+rkNVMR7hdbk0Y4sdaDyL64TsUKHreYH8K0zo8cFP
         LmtDfA2wWL35KmdRKqcmz4Kbi4FfpzVfcKRJUzNfifklZmoB+CTBg0Ek0f8WBpQdEWGC
         Y0ZHWbFaIbHjcbqPFWyvvJGg8osrFiT7RvKjyexjreC30vjDcXmcJ8vQvUUsy/TpRo08
         4kYAClLCAUTPawAWugp6pUgIdGx0H/JEB3XpznLUa+KZuvsZt/AEzgpAvmhi7ALx9HC4
         Chfw==
X-Gm-Message-State: AOJu0YxKtfoY/gnOaauwl+vZtRczJBVMQIkXXrLiduCfIygKMi09ya47
        FG1wQWYzvhAWDxeI0yLdUSgP4A==
X-Google-Smtp-Source: AGHT+IFsKi0kj5q9t/Gq/FHaYVnQTOjnhlReVoCABP+l9pbNqlcDeN/X/7o5DYC8YrJCAchJOqaB6g==
X-Received: by 2002:aa7:df93:0:b0:526:9cfb:c12 with SMTP id b19-20020aa7df93000000b005269cfb0c12mr5189114edy.38.1696020372252;
        Fri, 29 Sep 2023 13:46:12 -0700 (PDT)
Received: from cloudflare.com (79.184.153.47.ipv4.supernova.orange.pl. [79.184.153.47])
        by smtp.gmail.com with ESMTPSA id ee9-20020a056402290900b0053498aa4f41sm4350298edb.48.2023.09.29.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:46:11 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH 2/2] virtio-mmio: Support multiple interrupts per device
Date:   Fri, 29 Sep 2023 22:46:04 +0200
Message-ID: <20230929-jakub-os-90-trim-v1-2-a3af0c08f812@cloudflare.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some virtual devices, such as the virtio network device, can use multiple
virtqueues (or multiple pairs of virtqueues in the case of a vNIC). In such
case, when there are multiple vCPUs present, it is possible to process
virtqueue events in parallel. Each vCPU can service a subset of all
virtqueues when notified that there is work to carry out.

However, the current virtio-mmio transport implementation poses a
limitation. Only one vCPU can service notifications from any of the
virtqueues of a single virtio device. This is because a virtio-mmio device
driver supports registering just one interrupt per device. With such setup
we are not able to scale virtqueue event processing among vCPUs.

Now, with more than one IRQ resource registered for a virtio-mmio platform
device, we can address this limitation.

First, we request multiple IRQs when creating virtqueues for a device.

Then, map each virtqueue to one of the IRQs assigned to the device. The
mapping is done in a device type specific manner. For instance, a network
device will want each RX/TX virtqueue pair mapped to a different IRQ
line. Other device types might require a different mapping scheme. We
currently provide a mapping for virtio-net device type.

Finally, when handling an interrupt, we service only the virtqueues
associated with the IRQ line that triggered the event.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_mmio.c | 102 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 06a587b23542..180c51c27704 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -69,6 +69,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
@@ -93,6 +94,10 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+
+	/* IRQ range allocated to the device */
+	unsigned int irq_base;
+	unsigned int num_irqs;
 };
 
 struct virtio_mmio_vq_info {
@@ -101,6 +106,9 @@ struct virtio_mmio_vq_info {
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
+
+	/* IRQ mapped to virtqueue */
+	unsigned int irq;
 };
 
 
@@ -297,7 +305,7 @@ static bool vm_notify_with_data(struct virtqueue *vq)
 	return true;
 }
 
-/* Notify all virtqueues on an interrupt. */
+/* Notify all or some virtqueues on an interrupt. */
 static irqreturn_t vm_interrupt(int irq, void *opaque)
 {
 	struct virtio_mmio_device *vm_dev = opaque;
@@ -308,20 +316,31 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 
 	/* Read and acknowledge interrupts */
 	status = readl(vm_dev->base + VIRTIO_MMIO_INTERRUPT_STATUS);
-	writel(status, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
 
 	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
+		writel(status & VIRTIO_MMIO_INT_CONFIG, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
 		virtio_config_changed(&vm_dev->vdev);
 		ret = IRQ_HANDLED;
 	}
 
 	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
+		writel(status & VIRTIO_MMIO_INT_VRING, vm_dev->base + VIRTIO_MMIO_INTERRUPT_ACK);
 		spin_lock_irqsave(&vm_dev->lock, flags);
 		list_for_each_entry(info, &vm_dev->virtqueues, node)
 			ret |= vring_interrupt(irq, info->vq);
 		spin_unlock_irqrestore(&vm_dev->lock, flags);
 	}
 
+	/* Notify only affected vrings if device uses multiple interrupts */
+	if (vm_dev->num_irqs > 1) {
+		spin_lock_irqsave(&vm_dev->lock, flags);
+		list_for_each_entry(info, &vm_dev->virtqueues, node) {
+			if (info->irq == irq)
+				ret |= vring_interrupt(irq, info->vq);
+		}
+		spin_unlock_irqrestore(&vm_dev->lock, flags);
+	}
+
 	return ret;
 }
 
@@ -356,11 +375,15 @@ static void vm_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtqueue *vq, *n;
+	int i, irq;
+
+	for (i = 0; i < vm_dev->num_irqs; i++) {
+		irq = vm_dev->irq_base + i;
+		devm_free_irq(&vdev->dev, irq, vm_dev);
+	}
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vm_del_vq(vq);
-
-	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
 static void vm_synchronize_cbs(struct virtio_device *vdev)
@@ -488,6 +511,18 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	return ERR_PTR(err);
 }
 
+/* Map virtqueue to zero-based interrupt number */
+static unsigned int vq2irq(const struct virtqueue *vq)
+{
+	switch (vq->vdev->id.device) {
+	case VIRTIO_ID_NET:
+		/* interrupt shared by rx/tx virtqueue pair */
+		return vq->index / 2;
+	default:
+		return 0;
+	}
+}
+
 static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
@@ -496,19 +531,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err, queue_idx = 0;
-
-	if (irq < 0)
-		return irq;
-
-	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
-			dev_name(&vdev->dev), vm_dev);
-	if (err)
-		return err;
-
-	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
-		enable_irq_wake(irq);
+	struct virtio_mmio_vq_info *info;
+	int i, err, irq, nirqs, queue_idx = 0;
+	unsigned int irq_base = UINT_MAX;
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
@@ -519,12 +544,51 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
-			vm_del_vqs(vdev);
-			return PTR_ERR(vqs[i]);
+			err = PTR_ERR(vqs[i]);
+			goto fail_vq;
 		}
 	}
 
+	nirqs = platform_irq_count(vm_dev->pdev);
+	if (nirqs < 0) {
+		err = nirqs;
+		goto fail_vq;
+	}
+
+	for (i = 0; i < nirqs; i++) {
+		irq = platform_get_irq(vm_dev->pdev, i);
+		if (irq < 0)
+			goto fail_irq;
+		if (irq < irq_base)
+			irq_base = irq;
+
+		err = devm_request_irq(&vdev->dev, irq, vm_interrupt,
+				       IRQF_SHARED, NULL, vm_dev);
+		if (err)
+			goto fail_irq;
+
+		if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
+			enable_irq_wake(irq);
+	}
+
+	for (i = 0; i < nvqs; i++) {
+		irq = vq2irq(vqs[i]);
+		info = vqs[i]->priv;
+		info->irq = irq_base + (irq % nirqs);
+	}
+
+	vm_dev->irq_base = irq_base;
+	vm_dev->num_irqs = nirqs;
+
 	return 0;
+
+fail_irq:
+	while (i--)
+		devm_free_irq(&vdev->dev, irq_base + i, vm_dev);
+fail_vq:
+	vm_del_vqs(vdev);
+
+	return err;
 }
 
 static const char *vm_bus_name(struct virtio_device *vdev)

-- 
2.41.0
