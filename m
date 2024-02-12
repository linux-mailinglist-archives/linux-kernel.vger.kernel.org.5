Return-Path: <linux-kernel+bounces-61471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E305B8512BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FBA1C21878
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B573A8C0;
	Mon, 12 Feb 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ZVkb+Iiv"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5339FDA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738928; cv=none; b=boUVpDuoFoKJRtWEQIpVFwhxulxANmd2yEzZdt/8o/ocVbTCo/wxuq6jeETvZUI6wAkS0gHcLxgVxhCd9noqYWzpFjBUW9e4sy4SsYtJaxj71vCw+ywV77fiJJL4LpIaztjQ94cyjsEUK3NWN/H81s4KVMK0xxsqZwuFLzWR9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738928; c=relaxed/simple;
	bh=VakhuskCOEmdUKNKG6h481SR/1QpIv5oUGc9vY942tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDvV6k/lgPhk3dKuBTWTQgreh+uNa0GcL1msBbSjJl6WlCX5prj2ofRFB5fRuQMYd7dAIjD1E1xeRFRdKUU9d5CYySM8LWikkFjT/q4hQs/w4PCvQ9SKPzp8lLdg2fRheY/6VaWuRHayZWMyHz+0yoLpfaXRmvFZGI2gQmmLYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ZVkb+Iiv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so4016150a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738924; x=1708343724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpANRYXvs6zGbuIzmy6jouZw9SrrvoBI/ftf7n/DOy4=;
        b=ZVkb+IivFda0raddP/sOm0aCNdDUxXzYARJGuyXKfwrxRDja2yMDAZz4jqPfhb/r/P
         e7/orZTR/t4ta/uuujnZro54IdehPrjXFDE6AtsuEinxVsKsHp2JZaqvC0Ik65SNRxLh
         DbVD+4Iro+qfNOiWr3h5Wv3EXJRBRsFJfEcj+MvGm7l/qktD66nGeCMyoCtIzueK7fcX
         zwieQ6xvyKpwaOIRM0kw0QiIRrWdUVUjF5e+nsHqW4sn1qMIWQFmDXbHPXRNQ5Ew7Z08
         UhccxxAX44nWDNMlYf/5tacfzc6LyuvJUC5NoHnlVbKz2DabWe4IsJhKQXniIX8wI1LL
         JdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738924; x=1708343724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpANRYXvs6zGbuIzmy6jouZw9SrrvoBI/ftf7n/DOy4=;
        b=jh8ZU23Bbj6MrLXsmaJL6udgCCE17l8ncMgd11/Qu3BHVEDrRV7JBOhZ06aLlWXvoa
         j/jS8Y39/eR5a5CLn5BWzotyMR8rr09TPdtrE5JbbEQnHglCANS3qGToXhSzR8UVv0JF
         mrvYe9AOu3cehJmfMPF1aZEM9MF1iXSTf0Ri6fU87ugwiaom6a8Zy0WCcjTHQSHjYCvT
         5GAI3Xqq0IKDhiuyjJdzJILhtfqZF3Vh5Pr55Vh9nl+yjiESAwlT/MMVpUhWpmdxtEM3
         pdadqD6i9oaGJEb9ZhjbOcqRc1T6SyRZclftxq0Eo/KOBw9WHnTOJoEEO43+vxNLtSIT
         dFlA==
X-Gm-Message-State: AOJu0YzeAPvA3MUXF7JxIFAbqUbRwS8DAAUvQxf5fqauivKc1sI6q7bF
	SwrtgJFkFuJ4RVn/c1xasSiVm8PhMJTiOaWjT14tfCuRKi7TwaLiQUdGkcTbOhMa0pHK3YFRYHz
	K
X-Google-Smtp-Source: AGHT+IHUevkNQF+wpA51jPCqkDjNJtB75E1X9WncLutB2feZCf5+5IrIaYq3XpZUfgMD3WNkCyrhpw==
X-Received: by 2002:a17:906:84c:b0:a37:4c04:a472 with SMTP id f12-20020a170906084c00b00a374c04a472mr4236449ejd.18.1707738924077;
        Mon, 12 Feb 2024 03:55:24 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:22 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 11/35] percpu_counter.h: move declarations to percpu_counter_types.h
Date: Mon, 12 Feb 2024 12:54:36 +0100
Message-Id: <20240212115500.2078463-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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
index ce5bda191ec5..9f2ef799cff4 100644
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
index 91e3a527ceef..84f58b8b7856 100644
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
@@ -133,10 +122,6 @@ static inline bool percpu_counter_initialized(struct percpu_counter *fbc)
 
 #include <linux/irqflags.h> // for local_irq_save()
 
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
index 66828dfc6e74..56b11f1f82c5 100644
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


