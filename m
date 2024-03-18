Return-Path: <linux-kernel+bounces-106098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE8987E91B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D6F282FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061337711;
	Mon, 18 Mar 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UN53Jgfd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5F376F5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763617; cv=none; b=TCpw1mEZN/YmC/NFOXKBXcYKwKVs/fvJo0Tnnq9NVoyjdpJ6YSLTm1XM369rwdtDaBbhcxa+Pr+XtBD6gxwhghon64WmlknKn751eSu3cucpqVfkWWTzumDXukG80N5179k0bYwRa8orYuMAgTNL1EcAqj1SxSEHfKcgvAa1H2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763617; c=relaxed/simple;
	bh=1ucnOX4eBH2Gp0p4Y9VWFs1z6yWidDpAfiK6Vg0nQvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCkH5uLgK0WgYey7M5YeHx3WPLGkn2Zy61MfUWaQ78UtDRxeqsIuijom3v1Q0kwQai3bNlJHxy1zERy6qseTk5ahktsekVZxuoYp34cIgpPJ9AYSh3vrOgYNgsG0UsfkO9HQ1RQpE7WhTgvwLZh/Em8tOHeini/zYGjUYB+I7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UN53Jgfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710763614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cfvb4rfMrCjDejQ9hwiY10cL20PKYA901UXEHxyf/eY=;
	b=UN53JgfdT8b6xrPqf3AtYqz+c69++a+AVZEff/bmWZfgEQaYS6HQCMZq3LrsO/R6+maj/u
	t8J2e+P3HFRy3dvp8o/BOHIz+HHYgX7fwUxpat6sr3jQUHwNipTPx/HKHd1zfiMzN7XAMK
	ebY4DM1IbId86W1+4pr4JVRpim506G4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-As0tlG6dPpmcA6X8wT67zQ-1; Mon, 18 Mar 2024 08:06:52 -0400
X-MC-Unique: As0tlG6dPpmcA6X8wT67zQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BAA687A9FA;
	Mon, 18 Mar 2024 12:06:52 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 437CC17A96;
	Mon, 18 Mar 2024 12:06:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1] virtio-mem: support suspend+resume
Date: Mon, 18 Mar 2024 13:06:45 +0100
Message-ID: <20240318120645.105664-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

With virtio-mem, primarily hibernation is problematic: as the machine shuts
down, the virtio-mem device loses its state. Powering the machine back up
is like losing a bunch of DIMMs. While there would be ways to add limited
support, suspend+resume is more commonly used for VMs and "easier" to
support cleanly.

s2idle can be supported without any device dependencies. Similarly, one
would expect suspend-to-ram (i.e., S3) to work out of the box. However,
QEMU currently unplugs all device memory when resuming the VM, using a
cold reset on the "wakeup" path. In order to support S3, we need a feature
flag for the device to tell us if memory remains plugged when waking up. In
the future, QEMU will implement this feature.

So let's always support s2idle and support S3 with plugged memory only if
the device indicates support. Block hibernation early using the PM
notifier.

Trying to hibernate now fails early:
	# echo disk > /sys/power/state
	[   26.455369] PM: hibernation: hibernation entry
	[   26.458271] virtio_mem virtio0: hibernation is not supported.
	[   26.462498] PM: hibernation: hibernation exit
	-bash: echo: write error: Operation not permitted

s2idle works even without the new feature bit:
	# echo s2idle > /sys/power/mem_sleep
	# echo mem > /sys/power/state
	[   52.083725] PM: suspend entry (s2idle)
	[   52.095950] Filesystems sync: 0.010 seconds
	[   52.101493] Freezing user space processes
	[   52.104213] Freezing user space processes completed (elapsed 0.001 seconds)
	[   52.106520] OOM killer disabled.
	[   52.107655] Freezing remaining freezable tasks
	[   52.110880] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
	[   52.113296] printk: Suspending console(s) (use no_console_suspend to debug)

S3 does not work without the feature bit when memory is plugged:
	# echo deep > /sys/power/mem_sleep
	# echo mem > /sys/power/state
	[   32.788281] PM: suspend entry (deep)
	[   32.816630] Filesystems sync: 0.027 seconds
	[   32.820029] Freezing user space processes
	[   32.823870] Freezing user space processes completed (elapsed 0.001 seconds)
	[   32.827756] OOM killer disabled.
	[   32.829608] Freezing remaining freezable tasks
	[   32.833842] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
	[   32.837953] printk: Suspending console(s) (use no_console_suspend to debug)
	[   32.916172] virtio_mem virtio0: suspend+resume with plugged memory is not supported
	[   32.916181] virtio-pci 0000:00:02.0: PM: pci_pm_suspend(): virtio_pci_freeze+0x0/0x50 returns -1
	[   32.916197] virtio-pci 0000:00:02.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x170 returns -1
	[   32.916210] virtio-pci 0000:00:02.0: PM: failed to suspend async: error -1

But S3 works with the new feature bit when memory is plugged (patched
QEMU):
	# echo deep > /sys/power/mem_sleep
	# echo mem > /sys/power/state
	[   33.983694] PM: suspend entry (deep)
	[   34.009828] Filesystems sync: 0.024 seconds
	[   34.013589] Freezing user space processes
	[   34.016722] Freezing user space processes completed (elapsed 0.001 seconds)
	[   34.019092] OOM killer disabled.
	[   34.020291] Freezing remaining freezable tasks
	[   34.023549] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
	[   34.026090] printk: Suspending console(s) (use no_console_suspend to debug)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

I had QEMU support ready [1] but reset-related things just changed upstream
that will require a bit of a rework -- and it will end up looking cleaner.

Will come back to upstreaming the QEMU part once I can properly sync
the Linux headers to contain VIRTIO_MEM_F_PERSISTENT_SUSPEND.

[1] https://github.com/davidhildenbrand/qemu/tree/virtio-mem-suspend

---
 drivers/virtio/virtio_mem.c     | 68 ++++++++++++++++++++++++++++++---
 include/uapi/linux/virtio_mem.h |  2 +
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8e32232944423..51088d02de32f 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -21,6 +21,7 @@
 #include <linux/bitmap.h>
 #include <linux/lockdep.h>
 #include <linux/log2.h>
+#include <linux/suspend.h>
 
 #include <acpi/acpi_numa.h>
 
@@ -252,6 +253,9 @@ struct virtio_mem {
 	/* Memory notifier (online/offline events). */
 	struct notifier_block memory_notifier;
 
+	/* Notifier to block hibernation image storing/reloading. */
+	struct notifier_block pm_notifier;
+
 #ifdef CONFIG_PROC_VMCORE
 	/* vmcore callback for /proc/vmcore handling in kdump mode */
 	struct vmcore_cb vmcore_cb;
@@ -1111,6 +1115,25 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	return rc;
 }
 
+static int virtio_mem_pm_notifier_cb(struct notifier_block *nb,
+				     unsigned long action, void *arg)
+{
+	struct virtio_mem *vm = container_of(nb, struct virtio_mem,
+					     pm_notifier);
+	switch (action) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		/*
+		 * When restarting the VM, all memory is unplugged. Don't
+		 * allow to hibernate and restore from an image.
+		 */
+		dev_err(&vm->vdev->dev, "hibernation is not supported.\n");
+		return NOTIFY_BAD;
+	default:
+		return NOTIFY_OK;
+	}
+}
+
 /*
  * Set a range of pages PG_offline. Remember pages that were never onlined
  * (via generic_online_page()) using PageDirty().
@@ -2615,11 +2638,19 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	rc = register_memory_notifier(&vm->memory_notifier);
 	if (rc)
 		goto out_unreg_group;
-	rc = register_virtio_mem_device(vm);
+	/* Block hibernation as early as possible. */
+	vm->pm_notifier.priority = INT_MAX;
+	vm->pm_notifier.notifier_call = virtio_mem_pm_notifier_cb;
+	rc = register_pm_notifier(&vm->pm_notifier);
 	if (rc)
 		goto out_unreg_mem;
+	rc = register_virtio_mem_device(vm);
+	if (rc)
+		goto out_unreg_pm;
 
 	return 0;
+out_unreg_pm:
+	unregister_pm_notifier(&vm->pm_notifier);
 out_unreg_mem:
 	unregister_memory_notifier(&vm->memory_notifier);
 out_unreg_group:
@@ -2897,6 +2928,7 @@ static void virtio_mem_deinit_hotplug(struct virtio_mem *vm)
 
 	/* unregister callbacks */
 	unregister_virtio_mem_device(vm);
+	unregister_pm_notifier(&vm->pm_notifier);
 	unregister_memory_notifier(&vm->memory_notifier);
 
 	/*
@@ -2960,17 +2992,40 @@ static void virtio_mem_config_changed(struct virtio_device *vdev)
 #ifdef CONFIG_PM_SLEEP
 static int virtio_mem_freeze(struct virtio_device *vdev)
 {
+	struct virtio_mem *vm = vdev->priv;
+
 	/*
-	 * When restarting the VM, all memory is usually unplugged. Don't
-	 * allow to suspend/hibernate.
+	 * We block hibernation using the PM notifier completely. The workqueue
+	 * is already frozen by the PM core at this point, so we simply
+	 * reset the device and cleanup the queues.
 	 */
-	dev_err(&vdev->dev, "save/restore not supported.\n");
-	return -EPERM;
+	if (pm_suspend_target_state != PM_SUSPEND_TO_IDLE &&
+	    vm->plugged_size &&
+	    !virtio_has_feature(vm->vdev, VIRTIO_MEM_F_PERSISTENT_SUSPEND)) {
+		dev_err(&vm->vdev->dev,
+			"suspending with plugged memory is not supported\n");
+		return -EPERM;
+	}
+
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+	vm->vq = NULL;
+	return 0;
 }
 
 static int virtio_mem_restore(struct virtio_device *vdev)
 {
-	return -EPERM;
+	struct virtio_mem *vm = vdev->priv;
+	int ret;
+
+	ret = virtio_mem_init_vq(vm);
+	if (ret)
+		return ret;
+	virtio_device_ready(vdev);
+
+	/* Let's check if anything changed. */
+	virtio_mem_config_changed(vdev);
+	return 0;
 }
 #endif
 
@@ -2979,6 +3034,7 @@ static unsigned int virtio_mem_features[] = {
 	VIRTIO_MEM_F_ACPI_PXM,
 #endif
 	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
+	VIRTIO_MEM_F_PERSISTENT_SUSPEND,
 };
 
 static const struct virtio_device_id virtio_mem_id_table[] = {
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index e9122f1d0e0cb..6e4b2cf6b7f11 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -90,6 +90,8 @@
 #define VIRTIO_MEM_F_ACPI_PXM		0
 /* unplugged memory must not be accessed */
 #define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
+/* plugged memory will remain plugged when suspending+resuming */
+#define VIRTIO_MEM_F_PERSISTENT_SUSPEND		2
 
 
 /* --- virtio-mem: guest -> host requests --- */
-- 
2.43.2


