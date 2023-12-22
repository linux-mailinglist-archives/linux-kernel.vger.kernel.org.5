Return-Path: <linux-kernel+bounces-9406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121681C514
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7141F261D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A856F9C3;
	Fri, 22 Dec 2023 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cS2igrNA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1179D4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703226470; x=1734762470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hJZ0EKv2QD33t/EPcdMXeHcn3tCCkT2bruiT8sdwzJI=;
  b=cS2igrNAMIXsuCXj+Xdm2m6flMC+m2W9r5k2pmjfmKYG0HFSNmBaOp39
   ZF/v3fhmZzT/Wr4e+uHN3IReLuQrQ1BVJLOgqaoJnYZ0hrSOcrwjCjEE1
   x9ZdaPYIo33zbJ1G/ZSUCOlREVu6lhOqkOTjUdx/MdQaN7vPA2Vz277aD
   eATcGM+mDlC8/df7hj9LTTAJdHNojAWf4Y2jiOJYCF5imUrfLj6cJpHKF
   MzaOdROMOvmJ3rL6P79iIKKUWMWIn7+TT7qUrFWo5uaaz1Uj7ud0nStZA
   A321/4fpjaVNtqi1ENGkNxYYqdK4Yda4CbhEuFoUOyOrCmaa1xF5ZH5Cx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="462519999"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="462519999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847362650"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="847362650"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 22:27:45 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: naoya.horiguchi@nec.com
Cc: linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	tony.luck@intel.com,
	ying.huang@intel.com,
	fengwei.yin@intel.com,
	qiuxu.zhuo@intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: memory-failure: Make memory_failure_queue_delayed() helper
Date: Fri, 22 Dec 2023 14:27:05 +0800
Message-Id: <20231222062706.5221-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce the memory_failure_queue_delayed() helper for deferred handling
of memory failure tasks. This prepares for later re-splitting of a
hardware-poisoned huge page.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Prepares for the patch 2.

 mm/memory-failure.c | 51 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..8f2c11863bae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2385,28 +2385,12 @@ struct memory_failure_cpu {
 	DECLARE_KFIFO(fifo, struct memory_failure_entry,
 		      MEMORY_FAILURE_FIFO_SIZE);
 	spinlock_t lock;
-	struct work_struct work;
+	struct delayed_work work;
 };
 
 static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
 
-/**
- * memory_failure_queue - Schedule handling memory failure of a page.
- * @pfn: Page Number of the corrupted page
- * @flags: Flags for memory failure handling
- *
- * This function is called by the low level hardware error handler
- * when it detects hardware memory corruption of a page. It schedules
- * the recovering of error page, including dropping pages, killing
- * processes etc.
- *
- * The function is primarily of use for corruptions that
- * happen outside the current execution context (e.g. when
- * detected by a background scrubber)
- *
- * Can run in IRQ context.
- */
-void memory_failure_queue(unsigned long pfn, int flags)
+static void memory_failure_queue_delayed(unsigned long pfn, int flags, unsigned long delay)
 {
 	struct memory_failure_cpu *mf_cpu;
 	unsigned long proc_flags;
@@ -2418,13 +2402,34 @@ void memory_failure_queue(unsigned long pfn, int flags)
 	mf_cpu = &get_cpu_var(memory_failure_cpu);
 	spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 	if (kfifo_put(&mf_cpu->fifo, entry))
-		schedule_work_on(smp_processor_id(), &mf_cpu->work);
+		schedule_delayed_work_on(smp_processor_id(), &mf_cpu->work, delay);
 	else
 		pr_err("buffer overflow when queuing memory failure at %#lx\n",
 		       pfn);
 	spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
 	put_cpu_var(memory_failure_cpu);
 }
+
+/**
+ * memory_failure_queue - Schedule handling memory failure of a page.
+ * @pfn: Page Number of the corrupted page
+ * @flags: Flags for memory failure handling
+ *
+ * This function is called by the low level hardware error handler
+ * when it detects hardware memory corruption of a page. It schedules
+ * the recovering of error page, including dropping pages, killing
+ * processes etc.
+ *
+ * The function is primarily of use for corruptions that
+ * happen outside the current execution context (e.g. when
+ * detected by a background scrubber)
+ *
+ * Can run in IRQ context.
+ */
+void memory_failure_queue(unsigned long pfn, int flags)
+{
+	memory_failure_queue_delayed(pfn, flags, 0);
+}
 EXPORT_SYMBOL_GPL(memory_failure_queue);
 
 static void memory_failure_work_func(struct work_struct *work)
@@ -2434,7 +2439,7 @@ static void memory_failure_work_func(struct work_struct *work)
 	unsigned long proc_flags;
 	int gotten;
 
-	mf_cpu = container_of(work, struct memory_failure_cpu, work);
+	mf_cpu = container_of(work, struct memory_failure_cpu, work.work);
 	for (;;) {
 		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
@@ -2457,8 +2462,8 @@ void memory_failure_queue_kick(int cpu)
 	struct memory_failure_cpu *mf_cpu;
 
 	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
+	cancel_delayed_work_sync(&mf_cpu->work);
+	memory_failure_work_func(&mf_cpu->work.work);
 }
 
 static int __init memory_failure_init(void)
@@ -2470,7 +2475,7 @@ static int __init memory_failure_init(void)
 		mf_cpu = &per_cpu(memory_failure_cpu, cpu);
 		spin_lock_init(&mf_cpu->lock);
 		INIT_KFIFO(mf_cpu->fifo);
-		INIT_WORK(&mf_cpu->work, memory_failure_work_func);
+		INIT_DELAYED_WORK(&mf_cpu->work, memory_failure_work_func);
 	}
 
 	register_sysctl_init("vm", memory_failure_table);
-- 
2.17.1


