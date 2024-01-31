Return-Path: <linux-kernel+bounces-46643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA184423D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A006A287E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1012C535;
	Wed, 31 Jan 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YqeQ6LpU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181A12A14D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712630; cv=none; b=XVGEeDZE3ouCK4/GwQgtO/q7UBt1YwBMtMc+J6HkarotzixgfS/YF2lhTHA1jeQTo/4hXrWXeSs5jAYFWkVtqwbSusEvbgLrbwiiGAqdWhV4dD3zGxrQ48d3VdWPrKUFHzsBpegTbf3e1uqdj0d7+6czufkmNGJnU4WAAjpUHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712630; c=relaxed/simple;
	bh=J2VH8/i/2DpwZazCrLvqYT71vTgotFPFK0JZfWd79MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxZJpxAtGD02yQF5TgiYOAw6fPhQMjY+lgd+RsJGXn4qpP3h27c5fXaZvbnxoh43D5eIsaV1iV00pHcdn5AYwlRcJWlBmbcDHu8hWB+PvsswZw7YahmS8OCELKXauI/bY8k8tNv4cjRt+zgbbePaN2Fl5XWY9LbOc35aIzyL0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YqeQ6LpU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40faff092a2so12207095e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712624; x=1707317424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML11U0aRq2SFVG0rLTJngEYXYfv9M/na78EUBHM5izI=;
        b=YqeQ6LpUU2tQYvR/hkJ3OJygOncOVHHTlySwWDBh+I7TDiJN+aiGwcI6RkkdTXb8Wy
         l+N0vTkivk7zNLYELeXWUiK7qECqQjYweBeVsaoPTSnQDTlZpLUomn5IqtBiT1q3d0Jk
         vL6AV1Oj34OqP7i+FyQDGRlcP+Oe7jcf1SnEOrRPzpVkWXPffyRPDFo9TVnsAX810MHn
         bx3dq7A6xqi15krADhqxvX2wwPMw4tmO3bNiLlhbbQVQjrA+QYMd83er/NkA+JCE5TC/
         VAs+vtfWWUbBkWssojz8PwVYF0kHojX/8vCewBMrbI1FRBziR2mC8RzSClQnCxFwjfNz
         tB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712624; x=1707317424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML11U0aRq2SFVG0rLTJngEYXYfv9M/na78EUBHM5izI=;
        b=Q1TBsRFz8Yz/6JM6f8u/9oZJrrgVRq8TR0W7ApVJdgtaKOPQd0bInJPcbH0tI2xgFM
         FKO2EQz8Fq+cg+QquODpF/cXZbryMEFkB3kURfH84OnfBhgGC2v89WTuluqQYRYeH5w8
         2INUwnqVQjwcoo6uTfeLMAAwJUuQkYsvGzSNu8nRRwE5uvrDVgQZzh+k1kEV9Ko5n4JL
         sGWoonfLtA1aPzp76UqygRn9ueJ/WeM7di8LgOBuFbwktLNqQNN+c0+3u0If92azbtRY
         IVXYYVPaV7MIDK9vUc9M1fTyyKFbYQmRqc80O9W+NHuZ1sPPCmmicJC9iLszjUYPGc3z
         O33w==
X-Gm-Message-State: AOJu0YxJiV9rrJnU6X7nR3V9+UHNz0i+60So+vQ+zVuQuh3k7AJOiQcC
	vq5RdFbNV+R3kqaBPKS8lajKwCuLbnrhQsFAIbzjHyzqEDC5Px+OM4g+DS5TCE62luPCQa5NgYc
	K
X-Google-Smtp-Source: AGHT+IEV2mh7Gpq51RCa+Qm7h0h5yma4aqohXDRrGeGtU0RdNQnNn83d1+AxwGSr7m7htF8KUFBZTQ==
X-Received: by 2002:a5d:4d11:0:b0:33a:eb98:6aaf with SMTP id z17-20020a5d4d11000000b0033aeb986aafmr1411088wrt.12.1706712624622;
        Wed, 31 Jan 2024 06:50:24 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:24 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 11/28] percpu_counter.h: move declarations to percpu_counter_types.h
Date: Wed, 31 Jan 2024 15:49:51 +0100
Message-Id: <20240131145008.1345531-12-max.kellermann@ionos.com>
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
index 88bbb724080f..80d5a1762cca 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -17,7 +17,8 @@
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
index 35784f94f0a7..967626b48bd0 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -34,6 +34,7 @@
  * which something happened with proportion of type j.
  */
 #include <linux/flex_proportions.h>
+#include <linux/percpu_counter.h>
 #include <linux/math64.h>
 #include <linux/seqlock.h>
 
-- 
2.39.2


