Return-Path: <linux-kernel+bounces-60749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BA85091A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AB91F217B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E15F84A;
	Sun, 11 Feb 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UbMOAr5+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D5D8EF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654641; cv=none; b=jDnDEBzKO5qGMrNOKrUUfZYlXoIOrKVUALfPRsAx3MENAI0yTs3+810+GpB5j9sSgsfbd/5k1fAvXdDBhuSHhqxceXxWBTLo0ozJau6MtZ/lrPlcde4uUVB5OXMAj2Gkm2AkZu4tuaD89i/sQ3xGWdgd/X9KsI6gXi7XdaEm91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654641; c=relaxed/simple;
	bh=Bin3DNZnSCUMXH5aICZHgBTErX76nCGHVd62Jfb1blU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MUy1bfv6j0rXb7fZmq8Pk5j9QqTjf8kQzzlJHuHpyWGLklDzk9cYUVZx/c+ynffJ8tB1Ka2F942mQrbp994pm+sxOhvLSscGHjShKeTjlpOt3+ZX8qgVIJFuMlxUye5l/U76DnmE8XWgY6H1/BDbwLEanzLPinnbcxNDfJIttac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UbMOAr5+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so3064041a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654635; x=1708259435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2+Iouf2UVGvs4mCNtCFcBfpV0dyvUFr5y+VeLzPrck=;
        b=UbMOAr5+WlTmM231cRZS58cov+cb/YMrF9AnfJR4Ym3F1G5I1zTzgYC2VrZ2cRDkLZ
         QM1WniK/GGeIwgxoUGc3ObUIX9zKZb131M5hIjtyNkXuLdbNPcFrdroC45A7o3yPTHDT
         Ckn5O52bVFZk6mj9Uh8PaYd6OdwqUJ+eguYPWNFM0B8hCw2qvhWisQchHfk4+ZJrSsgl
         VCFpeVbfXI5Ag5GMmZkyYnrQFsFs1TlGXU8ap0N0lLzxUV5/LEjBoc7OPokAhOiHcMLf
         4IU5czYho3U7tYh5RrgP0jHyD/eFZ2BScG/pFrxLZdGn7wr0PDjOLjfIDx8+pUElA/4E
         7aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654635; x=1708259435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2+Iouf2UVGvs4mCNtCFcBfpV0dyvUFr5y+VeLzPrck=;
        b=geV5/VhT0f79pT7S9j6zpE48ZplDapl3+Tzwf+wamDyw3JAgJGU0VezVqbCRr0jNjA
         x/IjC4w9C8Byc6T5sHEv3jEFCkgF9yDGIpsOo+APXYDA6kZibdQRjR+5emx46ZQEwQQS
         95ZD/NLyjKxVvShp4piXo8OqjxOYMWN/YtggdhPu0epRBmPOQD0vJyJBZJXVDo9JA9iu
         1QL2Jqw4AAgtKSmh1pAAXdXy4SFbmFvqdTRECx9NRwfeVn7v6bLGctY4wAN6AQqABty0
         Yn2mU6Pmv/OodnYSyH0jpeWObBhCctlOYdKkyE+sRRAfBTrNLRc+krNSdNMx58XuGqPY
         68VA==
X-Gm-Message-State: AOJu0YzaGxLH2qVm7iMddLH3OSMgbi94CN7Rcdrlq4rlSmZiU4JtVJcp
	jOfaWRk4fLzbJN3mQMZiizbZd5E2GQhO///EtEnosmbJxQEVQPKYBNxaOIkFyt2P929gruqK1fu
	5
X-Google-Smtp-Source: AGHT+IGZU0nBP+GVm1QLMvAKe9QIEr5j4fxo3m61ik3JnVv/cDcyVLvIVNBskY7DU0Ka7GyPJWuIwQ==
X-Received: by 2002:aa7:db54:0:b0:560:e589:f6dc with SMTP id n20-20020aa7db54000000b00560e589f6dcmr2818776edt.33.1707654635513;
        Sun, 11 Feb 2024 04:30:35 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 21/35] percpu-refcount.h: move declarations to percpu-refcount_types.h
Date: Sun, 11 Feb 2024 13:29:46 +0100
Message-Id: <20240211123000.3359365-22-max.kellermann@ionos.com>
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
 drivers/target/target_core_pr.c       |  1 +
 drivers/target/target_core_xcopy.c    |  1 +
 include/linux/blkdev.h                |  2 +-
 include/linux/bpf-cgroup-defs.h       |  2 +-
 include/linux/bpf.h                   |  2 +-
 include/linux/cgroup-defs.h           |  2 +-
 include/linux/cgroup.h                |  1 +
 include/linux/percpu-refcount.h       | 64 +-----------------------
 include/linux/percpu-refcount_types.h | 71 +++++++++++++++++++++++++++
 include/linux/slab.h                  |  1 -
 include/target/target_core_base.h     |  2 +-
 11 files changed, 80 insertions(+), 69 deletions(-)
 create mode 100644 include/linux/percpu-refcount_types.h

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 6ed604a164f8..0ee29c16a161 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -20,6 +20,7 @@
 #include <linux/fcntl.h>
 #include <linux/fs.h>
 #include <linux/kref.h>
+#include <linux/percpu-refcount.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index df06ec0f75fe..37d306570f8a 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -18,6 +18,7 @@
 #include <linux/rculist.h>
 #include <linux/completion.h>
 #include <linux/configfs.h>
+#include <linux/percpu-refcount.h>
 #include <linux/ratelimit.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_proto.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6747965c3580..5cd0edada09d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -18,7 +18,7 @@
 #include <linux/gfp_types.h>
 #include <linux/kdev_t.h>
 #include <linux/rcupdate.h>
-#include <linux/percpu-refcount.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/blkzoned.h>
 #include <linux/sched.h>
 #include <linux/uio.h> // for iov_iter_is_aligned()
diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index f3b400858129..70b79fd81fee 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -5,7 +5,7 @@
 #ifdef CONFIG_CGROUP_BPF
 
 #include <linux/list.h>
-#include <linux/percpu-refcount.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/workqueue_types.h>
 
 struct bpf_prog_array;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c5c435d04460..e28c74dd67ab 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -21,7 +21,7 @@
 #include <linux/capability.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
-#include <linux/percpu-refcount.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/stddef.h>
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 99e24f3034df..878deefba0e1 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -15,7 +15,7 @@
 #include <linux/mutex_types.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
-#include <linux/percpu-refcount.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 24dcff53bd05..19a5e801f77d 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -21,6 +21,7 @@
 #include <linux/ns_common.h>
 #include <linux/nsproxy.h>
 #include <linux/user_namespace.h>
+#include <linux/percpu-refcount.h>
 #include <linux/refcount.h>
 #include <linux/kernel_stat.h>
 
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index dd2f19ea08bd..ded13def0acd 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -50,74 +50,12 @@
 #ifndef _LINUX_PERCPU_REFCOUNT_H
 #define _LINUX_PERCPU_REFCOUNT_H
 
-#include <linux/atomic.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <linux/gfp_types.h>
 
-struct percpu_ref;
-typedef void (percpu_ref_func_t)(struct percpu_ref *);
-
-/* flags set in the lower bits of percpu_ref->percpu_count_ptr */
-enum {
-	__PERCPU_REF_ATOMIC	= 1LU << 0,	/* operating in atomic mode */
-	__PERCPU_REF_DEAD	= 1LU << 1,	/* (being) killed */
-	__PERCPU_REF_ATOMIC_DEAD = __PERCPU_REF_ATOMIC | __PERCPU_REF_DEAD,
-
-	__PERCPU_REF_FLAG_BITS	= 2,
-};
-
-/* @flags for percpu_ref_init() */
-enum {
-	/*
-	 * Start w/ ref == 1 in atomic mode.  Can be switched to percpu
-	 * operation using percpu_ref_switch_to_percpu().  If initialized
-	 * with this flag, the ref will stay in atomic mode until
-	 * percpu_ref_switch_to_percpu() is invoked on it.
-	 * Implies ALLOW_REINIT.
-	 */
-	PERCPU_REF_INIT_ATOMIC	= 1 << 0,
-
-	/*
-	 * Start dead w/ ref == 0 in atomic mode.  Must be revived with
-	 * percpu_ref_reinit() before used.  Implies INIT_ATOMIC and
-	 * ALLOW_REINIT.
-	 */
-	PERCPU_REF_INIT_DEAD	= 1 << 1,
-
-	/*
-	 * Allow switching from atomic mode to percpu mode.
-	 */
-	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
-};
-
-struct percpu_ref_data {
-	atomic_long_t		count;
-	percpu_ref_func_t	*release;
-	percpu_ref_func_t	*confirm_switch;
-	bool			force_atomic:1;
-	bool			allow_reinit:1;
-	struct rcu_head		rcu;
-	struct percpu_ref	*ref;
-};
-
-struct percpu_ref {
-	/*
-	 * The low bit of the pointer indicates whether the ref is in percpu
-	 * mode; if set, then get/put will manipulate the atomic_t.
-	 */
-	unsigned long		percpu_count_ptr;
-
-	/*
-	 * 'percpu_ref' is often embedded into user structure, and only
-	 * 'percpu_count_ptr' is required in fast path, move other fields
-	 * into 'percpu_ref_data', so we can reduce memory footprint in
-	 * fast path.
-	 */
-	struct percpu_ref_data  *data;
-};
-
 int __must_check percpu_ref_init(struct percpu_ref *ref,
 				 percpu_ref_func_t *release, unsigned int flags,
 				 gfp_t gfp);
diff --git a/include/linux/percpu-refcount_types.h b/include/linux/percpu-refcount_types.h
new file mode 100644
index 000000000000..9f4f93e8faaf
--- /dev/null
+++ b/include/linux/percpu-refcount_types.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_PERCPU_REFCOUNT_TYPES_H
+#define _LINUX_PERCPU_REFCOUNT_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/types.h>
+
+struct percpu_ref;
+typedef void (percpu_ref_func_t)(struct percpu_ref *);
+
+/* flags set in the lower bits of percpu_ref->percpu_count_ptr */
+enum {
+	__PERCPU_REF_ATOMIC	= 1LU << 0,	/* operating in atomic mode */
+	__PERCPU_REF_DEAD	= 1LU << 1,	/* (being) killed */
+	__PERCPU_REF_ATOMIC_DEAD = __PERCPU_REF_ATOMIC | __PERCPU_REF_DEAD,
+
+	__PERCPU_REF_FLAG_BITS	= 2,
+};
+
+/* @flags for percpu_ref_init() */
+enum {
+	/*
+	 * Start w/ ref == 1 in atomic mode.  Can be switched to percpu
+	 * operation using percpu_ref_switch_to_percpu().  If initialized
+	 * with this flag, the ref will stay in atomic mode until
+	 * percpu_ref_switch_to_percpu() is invoked on it.
+	 * Implies ALLOW_REINIT.
+	 */
+	PERCPU_REF_INIT_ATOMIC	= 1 << 0,
+
+	/*
+	 * Start dead w/ ref == 0 in atomic mode.  Must be revived with
+	 * percpu_ref_reinit() before used.  Implies INIT_ATOMIC and
+	 * ALLOW_REINIT.
+	 */
+	PERCPU_REF_INIT_DEAD	= 1 << 1,
+
+	/*
+	 * Allow switching from atomic mode to percpu mode.
+	 */
+	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
+};
+
+struct percpu_ref_data {
+	atomic_long_t		count;
+	percpu_ref_func_t	*release;
+	percpu_ref_func_t	*confirm_switch;
+	bool			force_atomic:1;
+	bool			allow_reinit:1;
+	struct rcu_head		rcu;
+	struct percpu_ref	*ref;
+};
+
+struct percpu_ref {
+	/*
+	 * The low bit of the pointer indicates whether the ref is in percpu
+	 * mode; if set, then get/put will manipulate the atomic_t.
+	 */
+	unsigned long		percpu_count_ptr;
+
+	/*
+	 * 'percpu_ref' is often embedded into user structure, and only
+	 * 'percpu_count_ptr' is required in fast path, move other fields
+	 * into 'percpu_ref_data', so we can reduce memory footprint in
+	 * fast path.
+	 */
+	struct percpu_ref_data  *data;
+};
+
+#endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index a7ee429c0535..df92bb41affb 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,7 +17,6 @@
 #include <linux/log2.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
-#include <linux/percpu-refcount.h>
 #include <linux/cleanup.h>
 #include <linux/hash.h>
 #include <linux/mmzone.h>
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 5b9156adceca..1598a4062398 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -5,7 +5,7 @@
 #include <linux/configfs.h>      /* struct config_group */
 #include <linux/dma-direction.h> /* enum dma_data_direction */
 #include <linux/sbitmap.h>
-#include <linux/percpu-refcount.h>
+#include <linux/percpu-refcount_types.h>
 #include <linux/semaphore.h>     /* struct semaphore */
 #include <linux/completion_types.h>
 
-- 
2.39.2


