Return-Path: <linux-kernel+bounces-60740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B51F85090A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9BAB235B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44B59B45;
	Sun, 11 Feb 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ccs2UrMP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6C23761
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654630; cv=none; b=H6Ae1sujboqNYN6/z3951smwpV5Vwcuj/MNoj1dTFA0FphpkSXq7r16Tmzn7KnpnU3xPdEus1tOO1HIg3mOslnsxKHhFlelXKTDkOEAJwWYQJGxMIAdchND96YPV0CJIgOfiVJ2lGXn6NJuJddnsZ4tEljPbHBzJ0QUixO5FAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654630; c=relaxed/simple;
	bh=sm5m4u4t8eFbR2gjJprfwSpii3UwlxNYAW+qpTdBofY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXTrDUYo/h5OYixZj+WA5mjRCwPGzDa6WcrV2Qoh5M0SMCCf5fj6Z8sRTbk6Z0dyQNhJJWY/QSSko1tn3+oALlJpOT77rrhFkZLed8nBi/te0awMQtuq8Fvd3QWfcp7AmYFh0Tc5wZrVE8BCI7G7bmJDWqroMTxFCRxAkkLKWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ccs2UrMP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d09faadba5so30560191fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654625; x=1708259425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Sd3F7Cnejo0YUOQY1FFsProakPDnxze1sPdzTvGqZE=;
        b=ccs2UrMPg2hZMWxxZoYWR1hW8I0L86+3pa1yp7tnWuAVc9eH/C7ww5mQoBQpgFfiAD
         IRvTfMsXril+j58HVkHHoSirqAz/aQQXZ5Jrc6OK1sx+bnHqJF0k0REQ7TGXFOhgrlyf
         lJbinfSpvcxSPV00isFEI+lB1GSrp8Cajj445E0+4oCThUqMY4vbBPAOSSGkti/xLiSK
         yGuJQ2XmJvcWwgEvYvVnJzI5oqHeLhNFF+rRu0fVLmFNHPSnRDA+E60AeG3VbsbEjuVg
         n8jrl/AzPQEXif2bhEOSbgvhrg5hsXl/UJ/iEH3qYjk5iEKvxvaRMGGKgCPeWhoEUNQ/
         QrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654625; x=1708259425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Sd3F7Cnejo0YUOQY1FFsProakPDnxze1sPdzTvGqZE=;
        b=c8IWL1JMUdkxNwRmJWtVmHnBYZScwO52rNd5CcrAvgTWWVHhQ5rv3wARQMU14IYETV
         P5Nt58fnS3x0/25Jh1iU+WTJ+eW2PieBqITjTitZQWfaH4H5vyu9CthiHi/2HW++0UXq
         WIoPZstpmIc1WS+AmKp1cEiUnfXhfX4bP7/rViCZYhQENrl9G/husPMUJ6Rs0yf7oiqM
         +iPKmXZjfkBuqB82MEwcf43waoFnX1cYLGLBJW2FHKUb2NtNszovSXQJphTQ0LGa8mU7
         uo1PPQfocV9QhEVyzwTu+H6Y5SnJD7NNpQrGi8PrgBrTr8+XWjzq9yE6egOKQjsuT5Ts
         Nxqw==
X-Gm-Message-State: AOJu0YxjTbp7YBgjc4FWbcOLgLcuTLgHgetCqjnMlvbtiCgdu9pctwhK
	vKv0hgZZkdQD+kx2nuNxw0AStntpKTcogPzWiBJ5HN21wzId1hxFYd0PBNB82dicLQlsb22OPAc
	7
X-Google-Smtp-Source: AGHT+IFZbRX3qVoU0jivHjl/qZiaQjmYyKH2fSFwaSLRh0ajj1UIVEo5OWEzqt4s4QXwIX82tNc6KQ==
X-Received: by 2002:a05:651c:1054:b0:2d0:e45c:5650 with SMTP id x20-20020a05651c105400b002d0e45c5650mr2452747ljm.11.1707654624989;
        Sun, 11 Feb 2024 04:30:24 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 11/35] percpu_counter.h: move declarations to percpu_counter_types.h
Date: Sun, 11 Feb 2024 13:29:36 +0100
Message-Id: <20240211123000.3359365-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
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
 include/linux/backing-dev-defs.h     |  2 +-
 include/linux/flex_proportions.h     |  2 +-
 include/linux/ipc_namespace.h        |  2 +-
 include/linux/mm_types.h             |  3 ++-
 include/linux/percpu_counter.h       | 17 +------------
 include/linux/percpu_counter_types.h | 37 ++++++++++++++++++++++++++++
 include/linux/sched/user.h           |  2 +-
 include/linux/shmem_fs.h             |  2 +-
 kernel/user.c                        |  1 +
 lib/flex_proportions.c               |  1 +
 10 files changed, 47 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/percpu_counter_types.h

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 68fdec049456..720a88bb3513 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -6,7 +6,7 @@
 #include <linux/radix-tree.h>
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
 #include <linux/percpu-refcount.h>
 #include <linux/flex_proportions.h>
 #include <linux/timer_types.h>
diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index 35204b64addf..df9017a61046 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_FLEX_PROPORTIONS_H
 #define _LINUX_FLEX_PROPORTIONS_H
 
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/seqlock_types.h>
 #include <linux/gfp_types.h>
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index a0011b6cd5d1..7c758ab565fe 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -11,7 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
 #include <linux/sysctl.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
 
 struct user_namespace;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 54caee378e77..a88219770c82 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,7 +19,8 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue_types.h>
 #include <linux/seqlock_types.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
+#include <linux/percpu.h>
 
 #include <asm/mmu.h>
 
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 8d45785b3448..bec5e7cdd476 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -7,26 +7,15 @@
  * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
  */
 
-#include <linux/spinlock_types.h>
-#include <linux/list.h>
+#include <linux/percpu_counter_types.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
-#include <linux/types.h>
 
 /* percpu_counter batch for local add or sub */
 #define PERCPU_COUNTER_LOCAL_BATCH	INT_MAX
 
 #ifdef CONFIG_SMP
 
-struct percpu_counter {
-	raw_spinlock_t lock;
-	s64 count;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct list_head list;	/* All percpu_counters are on a list */
-#endif
-	s32 __percpu *counters;
-};
-
 extern int percpu_counter_batch;
 
 int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
@@ -131,10 +120,6 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 
 #else /* !CONFIG_SMP */
 
-struct percpu_counter {
-	s64 count;
-};
-
 static inline int percpu_counter_init_many(struct percpu_counter *fbc,
 					   s64 amount, gfp_t gfp,
 					   u32 nr_counters)
diff --git a/include/linux/percpu_counter_types.h b/include/linux/percpu_counter_types.h
new file mode 100644
index 000000000000..faccd9869a5a
--- /dev/null
+++ b/include/linux/percpu_counter_types.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PERCPU_COUNTER_TYPES_H
+#define _LINUX_PERCPU_COUNTER_TYPES_H
+/*
+ * A simple "approximate counter" for use in ext2 and ext3 superblocks.
+ *
+ * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
+ */
+
+#include <linux/types.h>
+
+#ifdef CONFIG_SMP
+
+#include <linux/spinlock_types.h>
+
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/list.h>
+#endif
+
+struct percpu_counter {
+	raw_spinlock_t lock;
+	s64 count;
+#ifdef CONFIG_HOTPLUG_CPU
+	struct list_head list;	/* All percpu_counters are on a list */
+#endif
+	s32 __percpu *counters;
+};
+
+#else /* !CONFIG_SMP */
+
+struct percpu_counter {
+	s64 count;
+};
+
+#endif	/* CONFIG_SMP */
+
+#endif /* _LINUX_PERCPU_COUNTER_TYPES_H */
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 671ecee08d23..913da0aba05c 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -4,7 +4,7 @@
 
 #include <linux/uidgid_types.h>
 #include <linux/atomic.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
 #include <linux/refcount.h>
 #include <linux/ratelimit_types.h>
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 2caa6b86106a..1d7e56eab60f 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -6,7 +6,7 @@
 #include <linux/swap.h>
 #include <linux/mempolicy.h>
 #include <linux/pagemap.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_types.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 #include <linux/userfaultfd_k.h>
diff --git a/kernel/user.c b/kernel/user.c
index 28da71ea1e74..6c8b818419f8 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -22,6 +22,7 @@
 #include <linux/proc_ns.h>
 #include <linux/ratelimit.h>
 #include <linux/uidgid.h>
+#include <linux/percpu_counter.h>
 
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc init_binfmt_misc = {
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 7749a48428e5..1d5e1e0bdbbe 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -36,6 +36,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/percpu_counter.h>
 #include <linux/seqlock.h>
 
 int fprop_global_init(struct fprop_global *p, gfp_t gfp)
-- 
2.39.2


