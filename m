Return-Path: <linux-kernel+bounces-60991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CDD850C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DF281F23
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5718026;
	Sun, 11 Feb 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FlvLRcp9"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEED17996
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693348; cv=none; b=JpWSbqy8EywMuhn15vGGCCOkyH89BHhRSzKN9JYLsfaOpnBWLCJBsBQ3WXadwKX/yasiQb4AkEcwfFtMx76DoHgCy+TskCpvUwJKxOz7WwksNrRojqMqIxn4BvYbaHpKOpXh32tJYL4+MImL6mFyB3uigVzd/GydqGvfeeYgqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693348; c=relaxed/simple;
	bh=sm5m4u4t8eFbR2gjJprfwSpii3UwlxNYAW+qpTdBofY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHwRC9qSZIpoxZ2VaQxSTRYQv4j2lxwIx8MogxZOXkkdyTOxBqL1Di6fdFHQw9OkPdJpkGdkTo3HmVKsy7IpP+EDwXIK4bPtoET3X17kcjEl+MFKuQ3aJSVIojjudl+oBkVHlkJ0Ah1QxYkdrHSRA0cMB/jOhQeRHbmQ7zjFei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FlvLRcp9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so2895293a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693343; x=1708298143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Sd3F7Cnejo0YUOQY1FFsProakPDnxze1sPdzTvGqZE=;
        b=FlvLRcp9ESItTAwkhDDg/wfQE4p3YA1jx5f+cV4qygWjk2Sf6l59Qhukcg+5InS5WI
         mPfyy2GMVLT0gYlaYIFjESuuyYLXKS2amb0NekNNWJQIGlnFIp8aYZnD7/UfGlV5MP8j
         uASg+16bqnCJo4C+mMocL9LYKWxvvffXhDPDQZKClMJBfSWAv//HsmvbrJDC1zvD5xLj
         8kR0fbszZxDjZNJQdwXL6C6ltk1+MYU4HX+J2nQ3GrABhpxpRU6p8zosq6o59lw1hBU/
         VK4E4avNonbWJfx7H+J/wMgDfprbWlN3lhYd1kk1tQXSHhvOMTYRzwqfl0hkJDbhAtRI
         z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693343; x=1708298143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Sd3F7Cnejo0YUOQY1FFsProakPDnxze1sPdzTvGqZE=;
        b=QqjAXkz+DEOr532he38y4n0EBr6UwriiHPBSM4+cOPShYs0bLeJaCu6wbgrAzPe4WY
         atg8d/HdYVGw6TylaioTrMcUCmFx54dSgXf0EPtfye8qgGO/HFpS/DTaFHZ185Zegm6l
         Pgnb46cmZKviMEUz4LNls6w4E1SrDtF26i2xW3LA184UoaPJfuVJ/M0L7/nTe0jwvT5A
         PDqHPrwaOlbSqcfYBvpoW7epfcZ9K8YqB5GEJvWGGHpG4yA9yiybq1AkbLL/3vTDsV1r
         ud9y4Ucuy6LM3S/JMmDcym+s44GY8zLHTAjRmTllvsQjTHurlYd5VttbSQYO4hNL6gqT
         C/dg==
X-Gm-Message-State: AOJu0YxUYeoOebyxtkiJ3eY8jyfP+XGM/OmtAfcKWiNUdpwwA7SFOzge
	S2IkqwteWkEo8hMLDh0jHAVwvyxVxnYwCfGtPKphPbvkE9lDwNhUbbX0I1meWSF+FZnTGV1dwHF
	8
X-Google-Smtp-Source: AGHT+IFVD6dhA7AvgyQGGcNLirz+n3DBmYgKZL2CMl94ii/SInxDufLyQnxAyl+ZNhth4edUEo8kaA==
X-Received: by 2002:aa7:c383:0:b0:55f:e432:4cac with SMTP id k3-20020aa7c383000000b0055fe4324cacmr4137515edq.37.1707693343779;
        Sun, 11 Feb 2024 15:15:43 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 11/35] percpu_counter.h: move declarations to percpu_counter_types.h
Date: Mon, 12 Feb 2024 00:14:54 +0100
Message-Id: <20240211231518.349442-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
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


