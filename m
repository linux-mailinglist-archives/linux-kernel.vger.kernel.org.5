Return-Path: <linux-kernel+bounces-46651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1789C844248
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DAC292BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD812FF6C;
	Wed, 31 Jan 2024 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M76/cu73"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAB84A34
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712637; cv=none; b=t0Y3JlCXhmrbnBeciDYr/bd4qKxwgqRMqG4gf10d2d4y0ClP3pdSLpWinTpIhdsjBy+Ael7PC23Q6nmwNBoesdDM+RIoBfxKg5azklFT2lSYlXCAfmVJH0PUjfiL7zaN6DQ+BeIuqE+eDfsPkBPwqLWuNyWhPLRBKyOFhqIifS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712637; c=relaxed/simple;
	bh=wvDcuURwFBjHviS0hV+Ll931TObz0L+if/PDO433hI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxwvK6oRZ/SxbgDq+TGCebNqLljNPHtnp4cW+i3I+YxZKBlCIyjqPd4CtffJw7It2A+tDbPYoCP/VJPsplIRgeSPJ1WfRlbP6nZHWXcS79RxoKixeacPdfz/tM1+jSFneSrjBoW1ctDFfVoHgwQecqck/K4fwHWjipKb+4DsNXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M76/cu73; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33aeb088324so2380662f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712629; x=1707317429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSPofij0rtB0TUsot/rfjudAjlBg5LEz7sC6VEw1rX0=;
        b=M76/cu73jOpRqkRPPe+PqpMZaPitVuTW9/Bz+8ogUCQfdw6MITEIZLYwK56YIh+s81
         SxqOSElAJTrAtLx42KTsPgWQ8ruK2ojou2fQoQtW8aKQ9ce2PEtQANnrMfyP+GlRiLZ0
         p4TsyZmMuIxayTlDwM/ZbMFDyXt7mXS9eYhSrEo1z4dgp9VOyNrWy3+aUgkcyDQfT0om
         wKNazjelcpvJJMvFAiNk1PtfIdzM/IgfiW/aMEw64TScQG8AjfiFOqXCwAEm7lOaRksn
         0iGnZuJyCYYyPPf76SFXwu6EKjjlgB8nb7243x4cUNK69A5tc1yaVdMn9kwfbeg9dIpD
         HzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712629; x=1707317429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSPofij0rtB0TUsot/rfjudAjlBg5LEz7sC6VEw1rX0=;
        b=D2lpdBkdNO3pV1j09sO9qN6CkPE9XmitZ7ra/rYF8a/Ie2KC8G+n6QPSMEAlD9w89J
         Dk7+zHs2b7WLk7FevjO0XdOinmuOl0j5YQ1L0zZSOqJrAgfN0ngNl8F8Gp6NcSx/zbIg
         LcaKGGTKX8W4Jf5KdPUSme1mflwZ4R4rFpt4CY+Cg+Nj4///M4niv88dzWGJaw+hN0Uu
         vgoP4oT+XkAXaba9xSV9A4v8HmpPJ5MFLpR53CGSJO8GBUfr9C4bh6avw0sBqzP+g6N6
         fNAHGFuY+P56Uv+09MVP7OtC2NCDDDNpeYEnRaglgotAFOWNp/zXuO0X8qUepUyspVPL
         Umqg==
X-Gm-Message-State: AOJu0YzZ7T2GwGsErh033daXqyusIwGVB2AsrITOlBm8A00zAdJpKEl0
	+1IIytJyNOFyb1W2byjxQxyhFdBs4UYICTKeJVR/oyAjgTIgjpwUWcCxAlKFLpJi5jWY+lYV3qu
	J
X-Google-Smtp-Source: AGHT+IHOjPYHZsd/t4DuhpiR4rNC7pEzB/Ndq2k8WZ0QaKf/wEPQt/ssrKLvLbTJgIXP47/oHZEImA==
X-Received: by 2002:a05:6000:83:b0:33a:ff77:546c with SMTP id m3-20020a056000008300b0033aff77546cmr1398552wrx.62.1706712628954;
        Wed, 31 Jan 2024 06:50:28 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:28 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 15/28] completion.h: move declarations to completion_types.h
Date: Wed, 31 Jan 2024 15:49:55 +0100
Message-Id: <20240131145008.1345531-16-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/target/target_core_xcopy.c |  1 +
 include/drm/drm_audio_component.h  |  2 +-
 include/drm/gpu_scheduler.h        |  2 +-
 include/linux/ceph/osd_client.h    |  2 +-
 include/linux/completion.h         | 18 +----------------
 include/linux/completion_types.h   | 31 ++++++++++++++++++++++++++++++
 include/linux/cpufreq.h            |  2 +-
 include/linux/edac.h               |  2 +-
 include/linux/firewire.h           |  2 +-
 include/linux/greybus/operation.h  |  2 +-
 include/linux/hw_random.h          |  2 +-
 include/linux/hyperv.h             |  2 +-
 include/linux/livepatch.h          |  2 +-
 include/linux/mailbox_controller.h |  2 +-
 include/linux/mfd/cs42l43.h        |  2 +-
 include/linux/mfd/da9052/da9052.h  |  2 +-
 include/linux/mfd/wm8350/core.h    |  2 +-
 include/linux/mlx4/device.h        |  2 +-
 include/linux/mlx5/cq.h            |  1 +
 include/linux/mlx5/driver.h        |  2 +-
 include/linux/mmc/core.h           |  2 +-
 include/linux/mtd/onenand.h        |  2 +-
 include/linux/mtd/sh_flctl.h       |  2 +-
 include/linux/ntb.h                |  2 +-
 include/linux/pm.h                 |  2 +-
 include/linux/rcupdate_wait.h      |  2 +-
 include/linux/sched/signal.h       |  1 +
 include/linux/soc/qcom/qmi.h       |  2 +-
 include/linux/spi/spi.h            |  2 +-
 include/linux/srcutree.h           |  2 +-
 include/linux/usb.h                |  2 +-
 include/net/inet_frag.h            |  2 +-
 include/rdma/ib_sa.h               |  2 +-
 include/rdma/restrack.h            |  2 +-
 include/target/target_core_base.h  |  2 +-
 include/xen/xenbus.h               |  2 +-
 36 files changed, 66 insertions(+), 48 deletions(-)
 create mode 100644 include/linux/completion_types.h

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index 4128631c9dfd..c822f57daa39 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/rculist.h>
+#include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/ratelimit.h>
 #include <scsi/scsi_proto.h>
diff --git a/include/drm/drm_audio_component.h b/include/drm/drm_audio_component.h
index 5a4cd1fa8e2a..d4e95bca4d10 100644
--- a/include/drm/drm_audio_component.h
+++ b/include/drm/drm_audio_component.h
@@ -4,7 +4,7 @@
 #ifndef _DRM_AUDIO_COMPONENT_H_
 #define _DRM_AUDIO_COMPONENT_H_
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/types.h>
 
 struct drm_audio_component;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 05591cc987c2..9a89f72a3bac 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -26,7 +26,7 @@
 
 #include <drm/spsc_queue.h>
 #include <linux/dma-fence.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/xarray.h>
 #include <linux/wait_types.h>
 #include <linux/workqueue_types.h>
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 2e6320a4c1d3..905c8afc095d 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -3,7 +3,7 @@
 #define _FS_CEPH_OSD_CLIENT_H
 
 #include <linux/bitrev.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/kref_types.h>
 #include <linux/mempool.h>
 #include <linux/rbtree_types.h>
diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..a57ffe2836b9 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -9,25 +9,9 @@
  * See kernel/sched/completion.c for details.
  */
 
+#include <linux/completion_types.h>
 #include <linux/swait.h>
 
-/*
- * struct completion - structure used to maintain state for a "completion"
- *
- * This is the opaque structure used to maintain the state for a "completion".
- * Completions currently use a FIFO to queue threads that have to wait for
- * the "completion" event.
- *
- * See also:  complete(), wait_for_completion() (and friends _timeout,
- * _interruptible, _interruptible_timeout, and _killable), init_completion(),
- * reinit_completion(), and macros DECLARE_COMPLETION(),
- * DECLARE_COMPLETION_ONSTACK().
- */
-struct completion {
-	unsigned int done;
-	struct swait_queue_head wait;
-};
-
 #define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
diff --git a/include/linux/completion_types.h b/include/linux/completion_types.h
new file mode 100644
index 000000000000..032192c95462
--- /dev/null
+++ b/include/linux/completion_types.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_COMPLETION_TYPES_H
+#define __LINUX_COMPLETION_TYPES_H
+
+/*
+ * (C) Copyright 2001 Linus Torvalds
+ *
+ * Atomic wait-for-completion handler data structures.
+ * See kernel/sched/completion.c for details.
+ */
+
+#include <linux/swait_types.h>
+
+/*
+ * struct completion - structure used to maintain state for a "completion"
+ *
+ * This is the opaque structure used to maintain the state for a "completion".
+ * Completions currently use a FIFO to queue threads that have to wait for
+ * the "completion" event.
+ *
+ * See also:  complete(), wait_for_completion() (and friends _timeout,
+ * _interruptible, _interruptible_timeout, and _killable), init_completion(),
+ * reinit_completion(), and macros DECLARE_COMPLETION(),
+ * DECLARE_COMPLETION_ONSTACK().
+ */
+struct completion {
+	unsigned int done;
+	struct swait_queue_head wait;
+};
+
+#endif
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9f57e106b040..7472dea7b7c6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -11,7 +11,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/kobject_types.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
diff --git a/include/linux/edac.h b/include/linux/edac.h
index f939d5fad491..7b78403cac40 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -14,7 +14,7 @@
 
 #include <linux/atomic.h>
 #include <linux/device.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/debugfs.h>
 #include <linux/numa.h>
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index feef7e09b60a..a81e31472530 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_FIREWIRE_H
 #define _LINUX_FIREWIRE_H
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
diff --git a/include/linux/greybus/operation.h b/include/linux/greybus/operation.h
index c49053e5707d..8d849f4ee99f 100644
--- a/include/linux/greybus/operation.h
+++ b/include/linux/greybus/operation.h
@@ -9,7 +9,7 @@
 #ifndef __OPERATION_H
 #define __OPERATION_H
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/kref_types.h>
 #include <linux/timer_types.h>
 #include <linux/types.h>
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 96cad10d0201..69838419f2e7 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -12,7 +12,7 @@
 #ifndef LINUX_HWRANDOM_H_
 #define LINUX_HWRANDOM_H_
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/kref_types.h>
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 249c4eb67f38..60ed23c4ca17 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -18,7 +18,7 @@
 #include <linux/types.h>
 #include <linux/scatterlist.h>
 #include <linux/list.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 9b9b38e89563..5277d2a768eb 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -11,7 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/ftrace.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/list.h>
 #include <linux/livepatch_sched.h>
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index fec4affa1543..d785db5d1915 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -6,7 +6,7 @@
 #include <linux/of.h>
 #include <linux/types.h>
 #include <linux/hrtimer_types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 
 struct device;
 struct mbox_chan;
diff --git a/include/linux/mfd/cs42l43.h b/include/linux/mfd/cs42l43.h
index 7649f2770697..3b3cbd0530c2 100644
--- a/include/linux/mfd/cs42l43.h
+++ b/include/linux/mfd/cs42l43.h
@@ -6,7 +6,7 @@
  *                         Cirrus Logic International Semiconductor Ltd.
  */
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mutex_types.h>
diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
index 76feb3a7066d..ade7e7ca0729 100644
--- a/include/linux/mfd/da9052/da9052.h
+++ b/include/linux/mfd/da9052/da9052.h
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/list.h>
 #include <linux/mfd/core.h>
 
diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index dc6ff85cb5b0..25379c7f94c4 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/mutex_types.h>
 #include <linux/interrupt.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/wm8350/audio.h>
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c89..18d71b808bc2 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -36,7 +36,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/if_ether.h>
 #include <linux/pci.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/radix-tree.h>
 #include <linux/cpu_rmap.h>
 #include <linux/crash_dump.h>
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index cb15308b5cb0..7acfefd41950 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -35,6 +35,7 @@
 
 #include <linux/mlx5/driver.h>
 #include <linux/refcount.h>
+#include <linux/completion.h>
 
 struct mlx5_core_cq {
 	u32			cqn;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 7d47499ce75a..d9b99aca9e72 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -34,7 +34,7 @@
 #define MLX5_DRIVER_H
 
 #include <linux/kernel.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 2c7928a50907..54cee0bf305d 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -5,7 +5,7 @@
 #ifndef LINUX_MMC_CORE_H
 #define LINUX_MMC_CORE_H
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/types.h>
 
 struct mmc_data;
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 7ebd8180c617..43e0f8812f52 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -10,7 +10,7 @@
 #define __LINUX_MTD_ONENAND_H
 
 #include <linux/spinlock_types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/onenand_regs.h>
 #include <linux/mtd/bbm.h>
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 78fc2d4218c8..2f48438bf2a3 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -8,7 +8,7 @@
 #ifndef __SH_FLCTL_H__
 #define __SH_FLCTL_H__
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 191b524e5c0d..b8a8be4052e1 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -56,7 +56,7 @@
 #ifndef _NTB_H_
 #define _NTB_H_
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 14f95d7e67ab..05e483d6a7c9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -14,7 +14,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/wait_types.h>
 #include <linux/hrtimer_types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 
 #ifdef CONFIG_PM_CLK
 #include <linux/mutex_types.h>
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index d07f0848802e..a28b4fce69a5 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -7,7 +7,7 @@
  */
 
 #include <linux/rcupdate.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/sched.h>
 
 /*
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0fe856628e60..50ff10ba803e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/sched/jobctl.h>
 #include <linux/sched/task.h>
+#include <linux/completion_types.h>
 #include <linux/cred.h>
 #include <linux/refcount.h>
 #include <linux/pid.h>
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index 900c4b3540cc..d2e725b1864b 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -6,7 +6,7 @@
 #ifndef __QMI_HELPERS_H__
 #define __QMI_HELPERS_H__
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/qrtr.h>
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8bf398247f0a..97312a919a70 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -8,7 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 74edc15cfcf3..8b1747a66608 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -12,7 +12,7 @@
 #define _LINUX_SRCU_TREE_H
 
 #include <linux/rcu_node_tree.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/mutex_types.h>
 #include <linux/workqueue.h>
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 3dbfbef457de..bf089b335a88 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -18,7 +18,7 @@
 #include <linux/kref_types.h>	/* for struct kref */
 #include <linux/device.h>	/* for struct device */
 #include <linux/fs.h>		/* for struct file_operations */
-#include <linux/completion.h>	/* for struct completion */
+#include <linux/completion_types.h>	/* for struct completion */
 #include <linux/sched.h>	/* for current && schedule_timeout */
 #include <linux/mutex_types.h>	/* for struct mutex */
 #include <linux/pm_runtime.h>	/* for runtime PM */
diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 153960663ce4..eafb78c7cd76 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -3,7 +3,7 @@
 #define __NET_FRAG_H__
 
 #include <linux/rhashtable-types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/in6.h>
 #include <linux/rbtree_types.h>
 #include <linux/refcount.h>
diff --git a/include/rdma/ib_sa.h b/include/rdma/ib_sa.h
index b46353fc53bf..fd6f7630e91e 100644
--- a/include/rdma/ib_sa.h
+++ b/include/rdma/ib_sa.h
@@ -8,7 +8,7 @@
 #ifndef IB_SA_H
 #define IB_SA_H
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/compiler.h>
 
 #include <linux/atomic.h>
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index f5a4ae56a1d9..48aba5db7544 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -9,7 +9,7 @@
 #include <linux/typecheck.h>
 #include <linux/sched.h>
 #include <linux/kref_types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/sched/task.h>
 #include <uapi/rdma/rdma_netlink.h>
 
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 97099a5e3f6c..5b9156adceca 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -7,7 +7,7 @@
 #include <linux/sbitmap.h>
 #include <linux/percpu-refcount.h>
 #include <linux/semaphore.h>     /* struct semaphore */
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 
 #define TARGET_CORE_VERSION		"v5.0"
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index d0f2e0a134be..a7326aa58680 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -38,7 +38,7 @@
 #include <linux/notifier.h>
 #include <linux/export.h>
 #include <linux/fs.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/semaphore.h>
-- 
2.39.2


