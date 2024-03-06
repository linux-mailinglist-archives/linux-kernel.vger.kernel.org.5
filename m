Return-Path: <linux-kernel+bounces-94582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872F78741BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172D41F22324
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F71BDCB;
	Wed,  6 Mar 2024 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2kbahUW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F901B963
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759704; cv=none; b=mR9X7z90kxTBzKtxgtrMZxQXWLk5s1RpnAEeUo3rTNAYzhnp8I6sj/UY9I1j4h3RBC19iIePPoRFcp7BeyXflGXeLJffKPa2GAHANPUkeEKYLYmw12lzSQAwyT6CdfidQBxJQIG9qFsaDYOZhyzje6b7zwnhxoLHLFgP4fg8tGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759704; c=relaxed/simple;
	bh=uDvZmbhzjgCbD+IOgMCMicN1uz6//ORUxzBpD/0bs3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4PjLkHZBD/6PPuzxvm0Jl6qDdtDfvdEnoLRpXeP1QudzES0Ippn38eSIo2VbiP+ES7pabxRYnhYQtRhQZtGeVJKOQW3+A12z9PPAA0kudMce6O+V83Lv2etAtzEZNvgXopUXhHyqR2tcPQBMTkHOrma3olQomY7J6PAX9Zumd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2kbahUW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709759702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pl9GXk5TcsKKw+z3zePmd/ZcikM0pM3kNp5lRYIGv4U=;
	b=N2kbahUWhf6jYgA/TByaM1fELSuuTnBeIHihYt8csq3rIX1tefkH/vtHfT6/fTWUY/iqus
	Ij2dXgOE+hWeC/h6dQd1O7MOiFc3wkvqgGU9XQjTH/fM+nCT4pxRMIZCMIz4pSL+mV02rL
	uscWeqTRs5EkOLvCf0BKPSnbpWs+Z3s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-CwUIwcoBPKu-NCCdxrTm1Q-1; Wed, 06 Mar 2024 16:15:00 -0500
X-MC-Unique: CwUIwcoBPKu-NCCdxrTm1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00C6C8007AB;
	Wed,  6 Mar 2024 21:15:00 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.33.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0335247CB;
	Wed,  6 Mar 2024 21:14:58 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org,
	eric.auger@redhat.com,
	clg@redhat.com,
	reinette.chatre@intel.com,
	linux-kernel@vger.kernel.org,
	kevin.tian@intel.com
Subject: [PATCH 4/7] vfio/pci: Create persistent INTx handler
Date: Wed,  6 Mar 2024 14:14:39 -0700
Message-ID: <20240306211445.1856768-5-alex.williamson@redhat.com>
In-Reply-To: <20240306211445.1856768-1-alex.williamson@redhat.com>
References: <20240306211445.1856768-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

A vulnerability exists where the eventfd for INTx signaling can be
deconfigured, which unregisters the IRQ handler but still allows
eventfds to be signaled with a NULL context through the SET_IRQS ioctl
or through unmask irqfd if the device interrupt is pending.

Ideally this could be solved with some additional locking; the igate
mutex serializes the ioctl and config space accesses, and the interrupt
handler is unregistered relative to the trigger, but the irqfd path
runs asynchronous to those.  The igate mutex cannot be acquired from the
atomic context of the eventfd wake function.  Disabling the irqfd
relative to the eventfd registration is potentially incompatible with
existing userspace.

As a result, the solution implemented here moves configuration of the
INTx interrupt handler to track the lifetime of the INTx context object
and irq_type configuration, rather than registration of a particular
trigger eventfd.  Synchronization is added between the ioctl path and
eventfd_signal() wrapper such that the eventfd trigger can be
dynamically updated relative to in-flight interrupts or irqfd callbacks.

Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 145 ++++++++++++++++--------------
 1 file changed, 78 insertions(+), 67 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 75c85eec21b3..fb5392b749ff 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -90,11 +90,15 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 
 	if (likely(is_intx(vdev) && !vdev->virq_disabled)) {
 		struct vfio_pci_irq_ctx *ctx;
+		struct eventfd_ctx *trigger;
 
 		ctx = vfio_irq_ctx_get(vdev, 0);
 		if (WARN_ON_ONCE(!ctx))
 			return;
-		eventfd_signal(ctx->trigger);
+
+		trigger = READ_ONCE(ctx->trigger);
+		if (likely(trigger))
+			eventfd_signal(trigger);
 	}
 }
 
@@ -253,100 +257,100 @@ static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int vfio_intx_enable(struct vfio_pci_core_device *vdev)
+static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
+			    struct eventfd_ctx *trigger)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
+	unsigned long irqflags;
+	char *name;
+	int ret;
 
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!vdev->pdev->irq)
+	if (!pdev->irq)
 		return -ENODEV;
 
+	name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ctx = vfio_irq_ctx_alloc(vdev, 0);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->name = name;
+	ctx->trigger = trigger;
+
 	/*
-	 * If the virtual interrupt is masked, restore it.  Devices
-	 * supporting DisINTx can be masked at the hardware level
-	 * here, non-PCI-2.3 devices will have to wait until the
-	 * interrupt is enabled.
+	 * Fill the initial masked state based on virq_disabled.  After
+	 * enable, changing the DisINTx bit in vconfig directly changes INTx
+	 * masking.  igate prevents races during setup, once running masked
+	 * is protected via irqlock.
+	 *
+	 * Devices supporting DisINTx also reflect the current mask state in
+	 * the physical DisINTx bit, which is not affected during IRQ setup.
+	 *
+	 * Devices without DisINTx support require an exclusive interrupt.
+	 * IRQ masking is performed at the IRQ chip.  Again, igate protects
+	 * against races during setup and IRQ handlers and irqfds are not
+	 * yet active, therefore masked is stable and can be used to
+	 * conditionally auto-enable the IRQ.
+	 *
+	 * irq_type must be stable while the IRQ handler is registered,
+	 * therefore it must be set before request_irq().
 	 */
 	ctx->masked = vdev->virq_disabled;
-	if (vdev->pci_2_3)
-		pci_intx(vdev->pdev, !ctx->masked);
+	if (vdev->pci_2_3) {
+		pci_intx(pdev, !ctx->masked);
+		irqflags = IRQF_SHARED;
+	} else {
+		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
+	}
 
 	vdev->irq_type = VFIO_PCI_INTX_IRQ_INDEX;
 
+	ret = request_irq(pdev->irq, vfio_intx_handler,
+			  irqflags, ctx->name, vdev);
+	if (ret) {
+		vdev->irq_type = VFIO_PCI_NUM_IRQS;
+		kfree(name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
+		return ret;
+	}
+
 	return 0;
 }
 
-static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev, int fd)
+static int vfio_intx_set_signal(struct vfio_pci_core_device *vdev,
+				struct eventfd_ctx *trigger)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	unsigned long irqflags = IRQF_SHARED;
 	struct vfio_pci_irq_ctx *ctx;
-	struct eventfd_ctx *trigger;
-	unsigned long flags;
-	int ret;
+	struct eventfd_ctx *old;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
 	if (WARN_ON_ONCE(!ctx))
 		return -EINVAL;
 
-	if (ctx->trigger) {
-		free_irq(pdev->irq, vdev);
-		kfree(ctx->name);
-		eventfd_ctx_put(ctx->trigger);
-		ctx->trigger = NULL;
-	}
-
-	if (fd < 0) /* Disable only */
-		return 0;
-
-	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)",
-			      pci_name(pdev));
-	if (!ctx->name)
-		return -ENOMEM;
-
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(ctx->name);
-		return PTR_ERR(trigger);
-	}
+	old = ctx->trigger;
 
-	ctx->trigger = trigger;
+	WRITE_ONCE(ctx->trigger, trigger);
 
-	/*
-	 * Devices without DisINTx support require an exclusive interrupt,
-	 * IRQ masking is performed at the IRQ chip.  The masked status is
-	 * protected by vdev->irqlock. Setup the IRQ without auto-enable and
-	 * unmask as necessary below under lock.  DisINTx is unmodified by
-	 * the IRQ configuration and may therefore use auto-enable.
-	 */
-	if (!vdev->pci_2_3)
-		irqflags = IRQF_NO_AUTOEN;
-
-	ret = request_irq(pdev->irq, vfio_intx_handler,
-			  irqflags, ctx->name, vdev);
-	if (ret) {
-		ctx->trigger = NULL;
-		kfree(ctx->name);
-		eventfd_ctx_put(trigger);
-		return ret;
+	/* Releasing an old ctx requires synchronizing in-flight users */
+	if (old) {
+		synchronize_irq(pdev->irq);
+		vfio_virqfd_flush_thread(&ctx->unmask);
+		eventfd_ctx_put(old);
 	}
 
-	spin_lock_irqsave(&vdev->irqlock, flags);
-	if (!vdev->pci_2_3 && !ctx->masked)
-		enable_irq(pdev->irq);
-	spin_unlock_irqrestore(&vdev->irqlock, flags);
-
 	return 0;
 }
 
 static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
 
 	ctx = vfio_irq_ctx_get(vdev, 0);
@@ -354,10 +358,13 @@ static void vfio_intx_disable(struct vfio_pci_core_device *vdev)
 	if (ctx) {
 		vfio_virqfd_disable(&ctx->unmask);
 		vfio_virqfd_disable(&ctx->mask);
+		free_irq(pdev->irq, vdev);
+		if (ctx->trigger)
+			eventfd_ctx_put(ctx->trigger);
+		kfree(ctx->name);
+		vfio_irq_ctx_free(vdev, ctx, 0);
 	}
-	vfio_intx_set_signal(vdev, -1);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
-	vfio_irq_ctx_free(vdev, ctx, 0);
 }
 
 /*
@@ -641,19 +648,23 @@ static int vfio_pci_set_intx_trigger(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		struct eventfd_ctx *trigger = NULL;
 		int32_t fd = *(int32_t *)data;
 		int ret;
 
-		if (is_intx(vdev))
-			return vfio_intx_set_signal(vdev, fd);
+		if (fd >= 0) {
+			trigger = eventfd_ctx_fdget(fd);
+			if (IS_ERR(trigger))
+				return PTR_ERR(trigger);
+		}
 
-		ret = vfio_intx_enable(vdev);
-		if (ret)
-			return ret;
+		if (is_intx(vdev))
+			ret = vfio_intx_set_signal(vdev, trigger);
+		else
+			ret = vfio_intx_enable(vdev, trigger);
 
-		ret = vfio_intx_set_signal(vdev, fd);
-		if (ret)
-			vfio_intx_disable(vdev);
+		if (ret && trigger)
+			eventfd_ctx_put(trigger);
 
 		return ret;
 	}
-- 
2.43.2


