Return-Path: <linux-kernel+bounces-46654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC9884424B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913CE293408
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840C12A14D;
	Wed, 31 Jan 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SU+L/F9r"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FED12DD95
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712642; cv=none; b=mwZRk45CZELErBcumWlpWb8SofxQ7vpnn1oy92nOSXAzSF7VmbAA+YoAP/KKSrGbxHPpjs3eL0WvBe4JSediHyopBiCeDb1wirOLx1s5KayRWY8dkxVhtyuPIIYp4751r2MeI59GhG5nhJQ9ZabrRsR3AIM/v+VvZrq9TxaZgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712642; c=relaxed/simple;
	bh=wFqLf+lTO1P01iuDQ0Av3gwXEV1N5t6nBLfx+ncslxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoWZqlPN+hCdAWcSIYL9Er8JtdmwNlsly9wKi6PcLXeVo4UNHVaQh14H79mMptivRXOXXPkZFprstrzqzvgSLALK7xB13BUg0RU+/+k+XmV9ncG6WCUNd7DtbT8K/AHy4oBL/Fpx+kKK89QG/qX3wKQkt7SJeKCFl0A90dAqxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SU+L/F9r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b01484cd7so685127f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712633; x=1707317433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=832vfSrkeF3QnV1R+jKUiXGq3To3W4yBcWkWbh9r2EA=;
        b=SU+L/F9r8knT9XF5i5XNkPMVU2d3zl3P0gCeOEhcQ4wJqVFVVpt3Wwi4ti5oPbhQmk
         RyPI0EZOt5nhqfgHfsY9yqBHCoAGDnNIYq8OCGh2Yr2IkSiM7SX7tVgqu8K2oavL7FMI
         z+SCDRONftSPUQ5KtDtQIhNt1xchb3yVzh2eT5jUBgtolTNgJJiZ/uz/OGpFYJHYlY02
         VzwjZ8Shn8/e7Ov3x0roJ2nb+LJnNkSqUn5ynQenZ1L1/gupx+ZrsmxZmRo5KQFvC5rB
         GUVbnDtifuwlaG6J1vOGs+stLH4Kvn6WRYApTyc4SriHg6hY+Lp3IvGAQ2SQbMtRGB9r
         Ibpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712633; x=1707317433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=832vfSrkeF3QnV1R+jKUiXGq3To3W4yBcWkWbh9r2EA=;
        b=N3VgNzM/442TmytaKuu/F6iYDNjqiz4PmZuPG5X8/cU/hIHfJx517oi+3ITJQrDwyk
         f3EtKzlxA9VQxXxnsJJF5DoJpKhLSJ+evAgt1P/hwup1jC9CImkukh6ItAFe+Kezsswj
         /4tEmC6IvQTgdK0w5tiZ5V3n8w8T/BHzdRIrunQftsWSf2bXBEvQsArbrFWybThrgeJX
         KfOFUSnZx3W8ToS7DHzFBEW2SAAFjWJzkMfsKjzEMON9Haj97vCMIA3bIDlM9uNqmLSW
         4GpMIz4ywSo2y5IcUkDakDOqk/+JA5N9b2B8DLZvxBx4+MZ8HIOlc6PcrzEmy5UP9yls
         Oyqg==
X-Gm-Message-State: AOJu0YyYop++IepLN0TKAHx3K2fZz3g/KJxGe1essa+6qYAOijv1hBCR
	goQ+EPa9yRz3RkXQU8W37iaVUft0as9Cgtt4RmP2UvgLqMpIj7SbE9y/QlqNkNg5z3wycGOFDmB
	n
X-Google-Smtp-Source: AGHT+IGEyihrVppRA/dzZ5iIifSMeq1XP3AsrwKj9frfmaxBy/V5P7Rcb6iCTdS4n1vBwAqrAZ/Uug==
X-Received: by 2002:a5d:4448:0:b0:33a:e6cf:f564 with SMTP id x8-20020a5d4448000000b0033ae6cff564mr1220964wrr.28.1706712633473;
        Wed, 31 Jan 2024 06:50:33 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:32 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 21/28] percpu-refcount.h: move declarations to percpu-refcount_types.h
Date: Wed, 31 Jan 2024 15:50:01 +0100
Message-Id: <20240131145008.1345531-22-max.kellermann@ionos.com>
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
 drivers/target/target_core_alua.c     |  1 +
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
 12 files changed, 81 insertions(+), 69 deletions(-)
 create mode 100644 include/linux/percpu-refcount_types.h

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 01751faad386..f908e5562094 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -18,6 +18,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/percpu-refcount.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index a566d4d38192..19057040b7a1 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -19,6 +19,7 @@
 #include <linux/fcntl.h>
 #include <linux/fs.h>
 #include <linux/kref.h>
+#include <linux/percpu-refcount.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/target/target_core_xcopy.c b/drivers/target/target_core_xcopy.c
index c822f57daa39..232d84743b89 100644
--- a/drivers/target/target_core_xcopy.c
+++ b/drivers/target/target_core_xcopy.c
@@ -18,6 +18,7 @@
 #include <linux/rculist.h>
 #include <linux/completion.h>
 #include <linux/configfs.h>
+#include <linux/percpu-refcount.h>
 #include <linux/ratelimit.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 09e8f023070c..bc108e5fcec0 100644
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
index 40fce6ce3de9..b6e38331acfd 100644
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
index 63c8b1ce6133..95439c2e7542 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -16,7 +16,6 @@
 #include <linux/gfp_types.h>
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


