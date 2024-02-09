Return-Path: <linux-kernel+bounces-59630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1884F9CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633662880B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5027F47B;
	Fri,  9 Feb 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f7N4R7Zn"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03927B3D9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496860; cv=none; b=T87l6zlhAeOXKcpoSP67suorJXcmlBWhs3llOlZZuJEtny7TS/l0NJ3w7CieXBNHZkXJkgyXthPZGpYnP4GBKhqiWruEtpPWI8udrxr7rx+DevTW4xqdxTUsS12xG5WfQyj8mZ9szHqgA8ruFtplkQMriGjI54BilngNx9W+0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496860; c=relaxed/simple;
	bh=4CJZzLKHqNM0uZiH2QQttaGMDPfFliJBBIA1mtreQBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aROnnbiK4Wq3tq53ZaHfMXocHpT6H2RbiGRj9zDyaQiz529lRtwqZu6wh1ixi4WDH6zHU7qMVyD0gxi1hJfvakqBkuTYg8hx+pQAzKZJEmS5AOwaEm26JDMSdFdRutw4OOkzq7xZasU5hqrlIiTPHH2JQzoG9of3JSe5ZM6ghKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f7N4R7Zn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3c0d92ca8aso38781966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496855; x=1708101655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDRTgs4aFjSgZGv/2kmGoIQZbfsa+Sj6ctbIY2wFSfw=;
        b=f7N4R7Znpuba9KrDBliMvlzFOzC0R8/Dm73sj9FT6NGTijQG8kh5Nlmc4IVy5FMCvL
         3D+VjjGMQmq5L1mRlxC6RKwU1N12NdX+sqP3BPoRr4rV/sdGgzxzF/CUh6cQkbF9w2tV
         b2vSx1X9ZCoE+n5I3HGMZ1dhHXgwCVg50Yn/Ho4GW+1vpZ6vpvX3u86KHsZn2hGOhX+j
         chi3TUQe0LT9zbw9/ux0WyUXeNDLdOMYqwgFRSW2Rsr8WLalqDJa/5NapzB9NMmd54LT
         RVe5YYFGkKIuhn8G5DUbYTbbmd4J4P/k0NasNP1TmZPKHM58GWIUYV8aSYf56zQR4dL1
         q8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496855; x=1708101655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDRTgs4aFjSgZGv/2kmGoIQZbfsa+Sj6ctbIY2wFSfw=;
        b=A1l77nYNlFawoBFikrZSkXiAmPSIf9pdDu0pKruQUbZHAf+/ITCROdheQSAb1uC+AY
         BSS4k53e9RsbzazYT+PugY7nQrBCMlOR+fmfLnJzjpkrBbE5NZggti9GBJPhVMB14ow6
         QhiH2sVoTuz7XA1yphnHpVFmH6rtqY/KapFcWWiAbbZ/c2epFvWONk29iqGl5wAfeNZi
         Opf7kkWHrFNzN03+NcqXEgMQQOXXe2MqrvQC99SSMwC5RNbFgzj75iFSAluFbOLdBxT+
         x5r8SFBPrd/hGH4EP17lr80QCd9bEtvBccikWdAEsXlzzcUR9bzaIMqaPYtIYUJfQvHZ
         +44A==
X-Gm-Message-State: AOJu0YwULZh1cePp17LpMseWVY2VNL3ha649A6BOi6XMikgoikEYYQTv
	4qZVq5SUBDa/ro005Y+OJJSEIR3nQlpx1M+pyz7A7DZfsbZzx3QbV6bTTcaymHNZBrwglGqLHKK
	l
X-Google-Smtp-Source: AGHT+IF25EBKZV72ye/2uelo+SZb4EzKbQXTCX/5sbS5nlZxaO6WPz9x8eqiX7MGuZdqxmwl3jS07g==
X-Received: by 2002:a17:906:792:b0:a36:ff9f:4256 with SMTP id l18-20020a170906079200b00a36ff9f4256mr1558501ejc.54.1707496855757;
        Fri, 09 Feb 2024 08:40:55 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 11/35] percpu_counter.h: move declarations to percpu_counter_types.h
Date: Fri,  9 Feb 2024 17:40:03 +0100
Message-Id: <20240209164027.2582906-12-max.kellermann@ionos.com>
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


