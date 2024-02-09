Return-Path: <linux-kernel+bounces-59634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51584F9D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03101C248F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDB685C61;
	Fri,  9 Feb 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iAF+yaLa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661B7EF1B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496866; cv=none; b=rdcmyFBrb5gJwY2GUaTg3d5n57gTFaavzC0Dy5lyKpe4dfVOeBiMlM7nZNDZh5GordNZi8CRRb1FHZhO0DXAAHUKOwSJ79KzsCEsihap6vwU0xZm9n7XZjmRPqqhzGW9upVUlPQ7koRD6ZlX/kRheph15J2aLObv2LG71cRMu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496866; c=relaxed/simple;
	bh=DFtkYlLlNabbshH9GwA9kiSm8fKyjyUMYUieRVNx8fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6+iJRGnlB+xFkk1HxZAQNhqBQ3sF1SHd0HXa3Rrgw9DT+jIR2xMfHS9VafH/Gy9crH9LLABBaaOT4IWfaXZ5cx/WQR+NDZoIuwxvLymOoKwG5X258uVcQKwAr4DYmpdI7HqtCO5hg0zVOFJcrDHCH34IOyaCztNF/tXxr4XQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iAF+yaLa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so1650874a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496860; x=1708101660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J9uDdEO2uVwAKDurDnR1+NlqV3E98caoyDJWoT9R94=;
        b=iAF+yaLag1m0kFrBMsCH0/z4bDazs/0Iyhj0BZAnKbyOpxxFZcCUuTh+N5cC8rl1jf
         JGNk1Z8xIqfEV49hrOAvFuIUXipXPTUvdvE8TQ8lGei2VQ1SHMWoL4bkz2gVsY8MtNtK
         s/pZqWoEphYIaCv6VcazksAWF3n+LjE5WsHjBbyZgA7TcAmMeAjPwf8UM7rouZmm75/W
         JgZbgCwloopbn8iiuyhNbB+jo+MAZXL1lh3OQIu30y8LC1KvyvSdhg6fxOIDdLzaS5HM
         kIskFmsRBP21kK1/4nsPClcDZaGjKRxunD3Nz2qfxzT80lMFBuWeJLTDlpMn1AUsBoIX
         fNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496860; x=1708101660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J9uDdEO2uVwAKDurDnR1+NlqV3E98caoyDJWoT9R94=;
        b=FtpUl6btJYpDLjYG3icW+zcHzZuI815kmq0hypmwWcUT8PsExhJYggrZ3Z3Z/+Mu0+
         WaiuBJzbXGjI2IlB0mw0zl8E9REvbqcHtH43ljXQ5LTyn8lM+3SKSaiurPcf/Ya9V2sR
         RQxKfjnoztR01OgP/fZHK1zdyQ5a1tcsdGtggchcCKowqcdj/GjtuEEmGRUegz9dnnJX
         U/G06NcZ9ni6ZLc3UeQk2I16Znxlkj5tOaFne9VBVn3NeZeP+6G2IYq2k83xecKnDALq
         pvI4yekd2Uf0kVu6NwgBGPFT28qnBBRrRqYFKXqmtCid6amG33lr2S2uYj7ro+NvZTIZ
         TrYg==
X-Gm-Message-State: AOJu0Yzs7Ynx+SkLwkrnHOdlQ/e45Nl9Wivx2ppVXEvx2QJWvwpwwr+u
	2R+yYxLIoPCCB7xyNuy3QXQlENraOw+l83KJTA5ZPlf9FjGYaXFJGPnRV1aWWmxR2ZWn/ZHLSlJ
	J
X-Google-Smtp-Source: AGHT+IHA7pllrs/k/oeefJdzzFT11+ZLONCi5ELxRKmPViS2B21ynrBxuTgVBk/Yhek2Lv45CP5P5w==
X-Received: by 2002:a17:906:c30e:b0:a3b:aa50:da81 with SMTP id s14-20020a170906c30e00b00a3baa50da81mr1545171ejz.5.1707496859984;
        Fri, 09 Feb 2024 08:40:59 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:59 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 15/35] completion.h: move declarations to completion_types.h
Date: Fri,  9 Feb 2024 17:40:07 +0100
Message-Id: <20240209164027.2582906-16-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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
 include/linux/memremap.h           |  2 +-
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
 include/linux/sched/signal.h       |  2 +-
 include/linux/soc/qcom/qmi.h       |  2 +-
 include/linux/spi/spi.h            |  2 +-
 include/linux/srcutree.h           |  2 +-
 include/linux/usb.h                |  2 +-
 include/net/inet_frag.h            |  2 +-
 include/rdma/ib_sa.h               |  2 +-
 include/rdma/restrack.h            |  2 +-
 include/target/target_core_base.h  |  2 +-
 include/xen/xenbus.h               |  2 +-
 37 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/completion_types.h

diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index fafa738f0f7e..df06ec0f75fe 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/rculist.h>
+#include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/ratelimit.h>
 #include <linux/workqueue.h>
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
index 289034e8854f..fa926dcdf940 100644
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
index a56eae4b0787..1087f325d056 100644
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
index 2006897fdaf9..c59f13cb5f28 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -5,7 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/hrtimer_types.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 
 struct device;
 struct of_phandle_args;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index eea01060a6b7..767b64ab667b 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_MEMREMAP_H_
 #define _LINUX_MEMREMAP_H_
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/mmzone.h>
 #include <linux/range.h>
 #include <linux/ioport.h>
diff --git a/include/linux/mfd/cs42l43.h b/include/linux/mfd/cs42l43.h
index 00e074b8c41f..e09e95ce1538 100644
--- a/include/linux/mfd/cs42l43.h
+++ b/include/linux/mfd/cs42l43.h
@@ -9,7 +9,7 @@
 #ifndef CS42L43_CORE_EXT_H
 #define CS42L43_CORE_EXT_H
 
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/mutex_types.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
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
index c1533ce86893..34cf20dd1ad1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -15,7 +15,7 @@
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
index 17436f950ec2..565d3e13efd3 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -7,7 +7,7 @@
 #include <linux/sched.h>
 #include <linux/sched/jobctl.h>
 #include <linux/sched/task.h>
-#include <linux/completion.h>
+#include <linux/completion_types.h>
 #include <linux/refcount.h>
 #include <linux/pid.h>
 #include <linux/posix-timers_types.h>
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
index 586a6ac21535..8f3b79a0d5d1 100644
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
index d7e2fa3d888d..a994f8a5edfd 100644
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
 #include <linux/sprintf.h>
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


