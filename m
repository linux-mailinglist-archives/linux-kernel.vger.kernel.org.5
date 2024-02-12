Return-Path: <linux-kernel+bounces-61482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8F8512CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD26F283C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934D3D569;
	Mon, 12 Feb 2024 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="goL+SXTK"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F43AC25
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738940; cv=none; b=KRVU3VMIrDyMcJHLdIuphxFO5pOmFSmEyOwnPX58uTICh1VHfVwM6yJn7nZKoAkHxk3X5zKEK8t7Tzg+aCmj1qOaOsHu7qvqPc/mEDiO+XERfBPDMYYiAuvTziFoqcCm20o8JkUPS6e4YuHi1zDDDFTQwbcpuUjeE2eHQ7O/rCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738940; c=relaxed/simple;
	bh=Bin3DNZnSCUMXH5aICZHgBTErX76nCGHVd62Jfb1blU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZZX38D8RB3yTcG50MJBJ9+IA/wmpAn1qK+bg9daOhM6Bn+7G57annv+B/6Cv78lRoaoQj338gVctGbb3Yc9X6227FpDKb1nwF2WJV/Sep23KIjq+PLqULTU1mRRAk9OUZLWl6rccZMqFvcj1tK84chfrPx8rilBoDLZPLHARcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=goL+SXTK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so4163264a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738934; x=1708343734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2+Iouf2UVGvs4mCNtCFcBfpV0dyvUFr5y+VeLzPrck=;
        b=goL+SXTK/3qRMqOUeQ4iZzinmfik50I62xMbGLYlxY6Z4CiRcQZ+NzFDIFMMJ6tjhy
         kI5MvqUTDa+Ys0EUOuWr2jOM1TvYywmWi3CcJiZRp1QU9SB7I1JLHEWrHXmPsMBhBkZn
         K4Oa3gCZ42QKWK6x62blzd0wY/4EHBRqaHHk6oMNgl++xjjPq4jvkMevgbJdoOWUFcip
         zJM0MIg+gk3dCQVKhbFQn8/EGe6VxYoIgudtP99fDPy+2x41fH3nbjSFylfBZEzElrp8
         0xAvAadaGLkTynJw3Dd8yCqYDxjT6OvTPsfhXjGBActxCd2xGvfIdt1Zv4gs+SeHErPE
         v53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738934; x=1708343734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2+Iouf2UVGvs4mCNtCFcBfpV0dyvUFr5y+VeLzPrck=;
        b=Y3xTec1BO9r07qDtBNT3riBvCwkMsyTMa5QVbU8HzHksHVN3l6wDf4mEKuASaoK6Jb
         lsgkYPqJUrIlUHKnTfCcQ/CZDb7f7Nz94DzW33qaRwYwPbHuFgk+uXdg/ukL6ylM6OC1
         /zDch3mHWeyB1vfsjVTX0Qzmka0eqM7pmgBbl/wXIEDDNePez4mjoCFrnyEKgYNj36jh
         hPbO1ztO4GzLomU+hT6omeTwXCFH+NDIBZBQAlcghmOcVOe0GjsYzCfVXtBBJBGlaM5j
         a40vOtBiSgI5idl8GXSy23IklbdINjdhkSNYos5zfCMHWsvccmogJXQggbyLszIKM8nj
         Yxcw==
X-Gm-Message-State: AOJu0YwF0T1MxX8hZBuRSbZ4IkFYgCa3e3tFZ/FjLRBitiL4tW3ZpV1G
	4p6HrpMiMCSk1AOs2xhff3shX2bi2f1TsObmBZMepLAGj67PjYoBbfsqtrlIgjDM4liAyFk4d18
	h
X-Google-Smtp-Source: AGHT+IGc5FNIYBMf/EACCBp1txSeFwQcMy197OPwHZm/231ZBswhTTbT9nSQwwg7pzNOcyJjasbU3g==
X-Received: by 2002:a17:906:d96f:b0:a3c:ccf7:5fda with SMTP id rp15-20020a170906d96f00b00a3cccf75fdamr688046ejb.46.1707738934581;
        Mon, 12 Feb 2024 03:55:34 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 21/35] percpu-refcount.h: move declarations to percpu-refcount_types.h
Date: Mon, 12 Feb 2024 12:54:46 +0100
Message-Id: <20240212115500.2078463-22-max.kellermann@ionos.com>
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


