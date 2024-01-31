Return-Path: <linux-kernel+bounces-46644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8B84423E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0481C1F210AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF812C555;
	Wed, 31 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="asPR4wYw"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5912BE9A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712630; cv=none; b=XdlGbYQird1SfZsaefZzdZZ4hLYv7v+Mgd/XOgZb4PpS2elyIl+RZkzlkeGrzJMAmQFugFekn3x3PYAd60Pf3AwujaOru4EYUqI4yWAdUZx20RCWhjc6J98I/s+2GSTmVW4p02AwtaQ35IzmqgiHpFgAvXxHpkoCYMxdjopehEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712630; c=relaxed/simple;
	bh=u+Pl+W46aVleKEzCvytgVoTsEqN32IxME3MotX6sQ/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5wHD0o2oqWogo/9fqGNEDY2wfd0Js3m6sGOBPVSysx9L1aJJe+OWz78fGRqkbMqrfDlxXY58pt/6K/2+9KQyKItMWtYkt1RtmQVK8IYTh1y7mP1zCr5uN9Odt4+WdXrTSxMvOVcPihRDZ3RVdYNPhFqSj+HYMpfIDszLwzQCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=asPR4wYw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae53eb5a8so2536839f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712622; x=1707317422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIYS3g3PLHkCa6eUPxwDXY+s8EfzimbZemSgII8la50=;
        b=asPR4wYwgSQzheqsqRDPbfJI9QrAJfbUoHfbtjX6zBY57whtid/21zgPLDU1xUx6KD
         VMBV1uV4kSQIYYRp2edSQgcAgppUiRWc674N8e+ceLewLutIGZy38i0lz8DlyadfYiCF
         kSI7Q22Ud2n+W9DWwZh3IaPE7o+g86qaa3OwiHn/qExEL6ksi8VzBbHPfQKEgGIDTyz5
         3VL0doz2QZL0f4oABb/bzk1I1RqW9+bLmJp14X9tEYlDnjz5eoFaKWdN5KCJ4tBcpgAE
         LDah26i2MZdjDDtFTY9lDGObj4Df7+OpN7I3hk/TXUDQZU5ff95weIsDSsjCT3vclBwx
         g6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712622; x=1707317422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIYS3g3PLHkCa6eUPxwDXY+s8EfzimbZemSgII8la50=;
        b=rdTUVBIUf5khm85m9WSjYXVdVsVNvDyYviPy0tYknhVPXTvtSrIgR2ue6dlGQxCx2I
         S7Tp5IPGSXQMuCqOyKhJsguvtqbCzfKlbjisQ90PYYeJLzRkRRMRKXpL85kWLuZOpKUt
         ZFTT/cE1If7us3AjwvQ8uy1H/G9MGDZjtu1ZYSS3H9VVzytvFpfdyQ1N6qVwbgqKbt6d
         TyE8FA/c6gBXlw4u3/KD95qipuu+Ck2k3iBCriwyhvSMETyeCH7hP0sH+TpmMNsGdXOS
         lg5l8XiOK4fJdGkm8CsIPjf8lDw2vQmqnxBrU2DaaE10QiI++L4wUmGa1fHgCWhZBJ5q
         /jyw==
X-Gm-Message-State: AOJu0Ywhx/2E+TENNbbJKegqxftGOWqG1pC85Mag0scXFv5AO9tkt2/I
	Zg1+Gk0Qxix81k7ozBlH8AZGMHOikneKGnTP/oZ+l8I3PbAtI+OjvTsPRtTEEkUEbi/evjSsFCt
	q
X-Google-Smtp-Source: AGHT+IF2yBZVfoGOzt71XeBTulGmlrSR/4WfueY/FKptJuJz0VO5gS4O03XRtoRNK1kJb+hZEzWoJw==
X-Received: by 2002:a5d:4dc9:0:b0:33a:e74a:60 with SMTP id f9-20020a5d4dc9000000b0033ae74a0060mr1351430wru.51.1706712622119;
        Wed, 31 Jan 2024 06:50:22 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:21 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 09/28] rwsem.h: move declarations to rwsem_types.h
Date: Wed, 31 Jan 2024 15:49:49 +0100
Message-Id: <20240131145008.1345531-10-max.kellermann@ionos.com>
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
 include/linux/backing-dev-defs.h  |  2 +-
 include/linux/comedi/comedidev.h  |  2 +-
 include/linux/gnss.h              |  2 +-
 include/linux/i3c/master.h        |  2 +-
 include/linux/ipc_namespace.h     |  2 +-
 include/linux/leds.h              |  2 +-
 include/linux/mfd/intel-m10-bmc.h |  2 +-
 include/linux/mm_types.h          |  2 +-
 include/linux/nfs_fs.h            |  2 +-
 include/linux/posix-clock.h       |  2 +-
 include/linux/quota.h             |  2 +-
 include/linux/rwsem.h             | 48 +------------------
 include/linux/rwsem_types.h       | 78 +++++++++++++++++++++++++++++++
 include/linux/tty.h               |  2 +-
 include/linux/user_namespace.h    |  2 +-
 include/net/sch_generic.h         |  2 +-
 include/rdma/ib_verbs.h           |  2 +-
 include/sound/core.h              |  2 +-
 18 files changed, 95 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/rwsem_types.h

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index b379687434fa..68fdec049456 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -15,7 +15,7 @@
 #include <linux/kref_types.h>
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #endif
 
 struct page;
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index d7a75b15c6f7..a3c2268f7ae5 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -13,7 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/kref_types.h>
 #include <linux/comedi.h>
 
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 8fc4bdd38dc6..9f38ff948d78 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -12,7 +12,7 @@
 #include <linux/device.h>
 #include <linux/kfifo.h>
 #include <linux/mutex_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 16cc81e55b12..0e456edeebbf 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -14,7 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/i3c/ccc.h>
 #include <linux/i3c/device.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/workqueue_types.h>
 
 #define I3C_HOT_JOIN_ADDR		0x2
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e8240cf2611a..a0011b6cd5d1 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -4,7 +4,7 @@
 
 #include <linux/err.h>
 #include <linux/idr.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/notifier.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 71385b333f25..0f6f44f05a54 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -11,7 +11,7 @@
 #include <dt-bindings/leds/common.h>
 #include <linux/device.h>
 #include <linux/mutex_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/timer_types.h>
 #include <linux/types.h>
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index ee66c9751003..3500f5fa8057 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -11,7 +11,7 @@
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/regmap.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 
 #define M10BMC_N3000_LEGACY_BUILD_VER	0x300468
 #define M10BMC_N3000_SYS_BASE		0x300800
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 122a9011985b..6ee90f81e01d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -10,7 +10,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/rbtree_types.h>
 #include <linux/maple_tree_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
 #include <linux/rcupdate.h>
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 4511d8a50e15..8f14fce5d7e2 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -24,7 +24,7 @@
 #include <linux/pagemap.h>
 #include <linux/rbtree_types.h>
 #include <linux/refcount_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 
 #include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/auth.h>
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f48920..f8e0c65d262d 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -11,7 +11,7 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/posix-timers.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 
 struct posix_clock;
 struct posix_clock_context;
diff --git a/include/linux/quota.h b/include/linux/quota.h
index bf16d9d2866c..956281c84850 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -34,7 +34,7 @@
 
 #include <linux/list.h>
 #include <linux/mutex_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/percpu_counter.h>
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 9c29689ff505..ba9532734bf6 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -8,10 +8,10 @@
 #ifndef _LINUX_RWSEM_H
 #define _LINUX_RWSEM_H
 
+#include <linux/rwsem_types.h>
 #include <linux/linkage.h>
 
 #include <linux/types.h>
-#include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
@@ -29,43 +29,6 @@
 
 #ifndef CONFIG_PREEMPT_RT
 
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-#include <linux/osq_lock.h>
-#endif
-
-/*
- * For an uncontended rwsem, count and owner are the only fields a task
- * needs to touch when acquiring the rwsem. So they are put next to each
- * other to increase the chance that they will share the same cacheline.
- *
- * In a contended rwsem, the owner is likely the most frequently accessed
- * field in the structure as the optimistic waiter that holds the osq lock
- * will spin on owner. For an embedded rwsem, other hot fields in the
- * containing structure should be moved further away from the rwsem to
- * reduce the chance that they will share the same cacheline causing
- * cacheline bouncing problem.
- */
-struct rw_semaphore {
-	atomic_long_t count;
-	/*
-	 * Write owner or one of the read owners as well flags regarding
-	 * the current state of the rwsem. Can be used as a speculative
-	 * check to see if the write owner is running on the cpu.
-	 */
-	atomic_long_t owner;
-#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-	struct optimistic_spin_queue osq; /* spinner MCS lock */
-#endif
-	raw_spinlock_t wait_lock;
-	struct list_head wait_list;
-#ifdef CONFIG_DEBUG_RWSEMS
-	void *magic;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
@@ -124,15 +87,6 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
 
 #else /* !CONFIG_PREEMPT_RT */
 
-#include <linux/rwbase_rt.h>
-
-struct rw_semaphore {
-	struct rwbase_rt	rwbase;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #define __RWSEM_INITIALIZER(name)				\
 	{							\
 		.rwbase = __RWBASE_INITIALIZER(name),		\
diff --git a/include/linux/rwsem_types.h b/include/linux/rwsem_types.h
new file mode 100644
index 000000000000..105142147b9b
--- /dev/null
+++ b/include/linux/rwsem_types.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* rwsem.h: R/W semaphores, public interface
+ *
+ * Written by David Howells (dhowells@redhat.com).
+ * Derived from asm-i386/semaphore.h
+ */
+
+#ifndef _LINUX_RWSEM_TYPES_H
+#define _LINUX_RWSEM_TYPES_H
+
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+#include <linux/atomic.h>
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#include <linux/lockdep_types.h>
+# define __RWSEM_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	},
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+#include <linux/osq_lock.h>
+#endif
+
+/*
+ * For an uncontended rwsem, count and owner are the only fields a task
+ * needs to touch when acquiring the rwsem. So they are put next to each
+ * other to increase the chance that they will share the same cacheline.
+ *
+ * In a contended rwsem, the owner is likely the most frequently accessed
+ * field in the structure as the optimistic waiter that holds the osq lock
+ * will spin on owner. For an embedded rwsem, other hot fields in the
+ * containing structure should be moved further away from the rwsem to
+ * reduce the chance that they will share the same cacheline causing
+ * cacheline bouncing problem.
+ */
+struct rw_semaphore {
+	atomic_long_t count;
+	/*
+	 * Write owner or one of the read owners as well flags regarding
+	 * the current state of the rwsem. Can be used as a speculative
+	 * check to see if the write owner is running on the cpu.
+	 */
+	atomic_long_t owner;
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+	struct optimistic_spin_queue osq; /* spinner MCS lock */
+#endif
+	raw_spinlock_t wait_lock;
+	struct list_head wait_list;
+#ifdef CONFIG_DEBUG_RWSEMS
+	void *magic;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+struct rw_semaphore {
+	struct rwbase_rt	rwbase;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#endif /* CONFIG_PREEMPT_RT */
+
+#endif /* _LINUX_RWSEM_TYPES_H */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5a3815e7d73d..da820609bc77 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -13,7 +13,7 @@
 #include <linux/mutex_types.h>
 #include <linux/tty_flags.h>
 #include <uapi/linux/tty.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/llist.h>
 
 
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 7d0e3418d497..c82e1b50dfcb 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -6,7 +6,7 @@
 #include <linux/ns_common.h>
 #include <linux/sched.h>
 #include <linux/workqueue_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index bab44a435a62..6ec5064156d9 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -12,7 +12,7 @@
 #include <linux/list.h>
 #include <linux/refcount.h>
 #include <linux/mutex_types.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/atomic.h>
 #include <linux/hashtable.h>
 #include <net/gen_stats.h>
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 64b62d1388a4..7d6216e85b0e 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -18,7 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref_types.h>
 #include <linux/list.h>
-#include <linux/rwsem.h>
+#include <linux/rwsem_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/irq_poll.h>
 #include <uapi/linux/if_ether.h>
diff --git a/include/sound/core.h b/include/sound/core.h
index 0c512acac050..f95f6863986f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/sched.h>		/* wake_up() */
 #include <linux/mutex_types.h>		/* struct mutex */
-#include <linux/rwsem.h>		/* struct rw_semaphore */
+#include <linux/rwsem_types.h>		/* struct rw_semaphore */
 #include <linux/stringify.h>
 #include <linux/printk.h>
 #include <linux/wait.h>
-- 
2.39.2


