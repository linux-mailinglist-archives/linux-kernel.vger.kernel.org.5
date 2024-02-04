Return-Path: <linux-kernel+bounces-51511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8758848C0E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE01D1C216A4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A5111AD;
	Sun,  4 Feb 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qXf4zRf3"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FDD101DE;
	Sun,  4 Feb 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707033741; cv=none; b=PW6DvLNgERIXKAUZDqUZhj2grDkI1EQMfctMK5Wu6EOVfxNqGxHsQlaxYCSz7wN97DETh2jpe0R7HybAjUWDhDlnZyNNsIo3IwrjkOMZX5OsTBq/nQMV6ol8ImR/TvhRptWUcesQqU16BLaCnlNE8mi+yPauolINcYGb/H3u4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707033741; c=relaxed/simple;
	bh=Lay0fChRwcqL6qRR/b90ytfV545qGIXnzfUUmYEnuS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlLxd6ijyWdgSYa9I3HNHQzpPFF5VDin+5SYocJxqGeQwyuxaD0UJwrnMyJs1Cg82xD1U7W5XPPb8xiGIcxmkx2ZPxxT+uI54HxqJtczV8Mny9jfX7QN4PvCUQh9EC094lmJc/0eXsbt/Y1rtb+w+OpZcQx6rWrnc6A3T0ReNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qXf4zRf3; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707033730; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3WJhfKXymgtJDxH1Bv4Pw2RdK+dUt+Ap8WfZiH7ulSU=;
	b=qXf4zRf3Ml0xoA9+onXRrORYE/QmP529rdSBZ7nAcIf7G2Rt41U9s8GmJ2CwSGZjqwQMCrQt2s6cfVsJL8dMoY3zg+MICSW/rUe+eEqxN2S4/UF97O4ARl1cN8mVJvnUDVYPOONZH3JV3d7Ar2L2o7yUSX452/hQHSQNtu5AMGs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0W0003OC_1707033725;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0W0003OC_1707033725)
          by smtp.aliyun-inc.com;
          Sun, 04 Feb 2024 16:02:07 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v11 3/3] ACPI: APEI: handle synchronous exceptions in task work to send correct SIGBUS si_code
Date: Sun,  4 Feb 2024 16:01:44 +0800
Message-Id: <20240204080144.7977-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware errors could be signaled by asynchronous interrupt, e.g. when an
error is detected by a background scrubber, or signaled by synchronous
exception, e.g. when a CPU tries to access a poisoned cache line. Since
commit a70297d22132 ("ACPI: APEI: set memory failure flags as
MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
could be used to determine whether a synchronous exception occurs on ARM64
platform. When a synchronous exception is detected, the kernel should
terminate the current process which accessing the poisoned page. This is
done by sending a SIGBUS signal with an error code BUS_MCEERR_AR,
indicating an action-required machine check error on read.

However, the memory failure recovery is incorrectly sending a SIGBUS
with wrong error code BUS_MCEERR_AO for synchronous errors in early kill
mode, even MF_ACTION_REQUIRED is set. The main problem is that
synchronous errors are queued as a memory_failure() work, and are
executed within a kernel thread context, not the user-space process that
encountered the corrupted memory on ARM64 platform. As a result, when
kill_proc() is called to terminate the process, it sends the incorrect
SIGBUS error code because the context in which it operates is not the
one where the error was triggered.

To this end, queue memory_failure() as a task_work so that it runs in
the context of the process that is actually consuming the poisoned data,
and it will send SIBBUS with si_code BUS_MCEERR_AR.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
 include/acpi/ghes.h      |  3 --
 mm/memory-failure.c      | 13 -------
 3 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0892550732d4..e5086d795bee 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -465,28 +465,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
 }
 
 /*
- * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+ * struct sync_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                fine tune action taken
+ *
+ * Structure to pass task work to be handled before
+ * ret_to_user via task_work_add().
  */
-static void ghes_kick_task_work(struct callback_head *head)
+struct sync_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
 {
-	struct acpi_hest_generic_status *estatus;
-	struct ghes_estatus_node *estatus_node;
-	u32 node_len;
+	int ret;
+	struct sync_task_work *twcb =
+		container_of(twork, struct sync_task_work, twork);
 
-	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
-	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		memory_failure_queue_kick(estatus_node->task_work_cpu);
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
 
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("Sending SIGBUS to current task due to memory error not recovered");
+	force_sig(SIGBUS);
 }
 
 static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
+	struct sync_task_work *twcb;
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
 		return false;
@@ -499,6 +512,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 		return false;
 	}
 
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return true;
+	}
+
 	memory_failure_queue(pfn, flags);
 	return true;
 }
@@ -746,7 +771,7 @@ int cxl_cper_unregister_callback(cxl_cper_callback callback)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
 
-static bool ghes_do_proc(struct ghes *ghes,
+static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
@@ -814,8 +839,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 		pr_err("Sending SIGBUS to current task due to memory error not recovered");
 		force_sig(SIGBUS);
 	}
-
-	return queued;
 }
 
 static void __ghes_print_estatus(const char *pfx,
@@ -1117,9 +1140,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	bool task_work_pending;
 	u32 len, node_len;
-	int ret;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -1134,25 +1155,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
+
+		ghes_do_proc(estatus_node->ghes, estatus);
+
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
 				ghes_estatus_cache_add(generic, estatus);
 		}
-
-		if (task_work_pending && current->mm) {
-			estatus_node->task_work.func = ghes_kick_task_work;
-			estatus_node->task_work_cpu = smp_processor_id();
-			ret = task_work_add(current, &estatus_node->task_work,
-					    TWA_RESUME);
-			if (ret)
-				estatus_node->task_work.func = NULL;
-		}
-
-		if (!estatus_node->task_work.func)
-			gen_pool_free(ghes_estatus_pool,
-				      (unsigned long)estatus_node, node_len);
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
 
 		llnode = next;
 	}
@@ -1213,7 +1225,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
-	estatus_node->task_work.func = NULL;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 
 	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index be1dd4c1a917..ebd21b05fe6e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -35,9 +35,6 @@ struct ghes_estatus_node {
 	struct llist_node llnode;
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes;
-
-	int task_work_cpu;
-	struct callback_head task_work;
 };
 
 struct ghes_estatus_cache {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d33729c48eff..4ad663bdc1d5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2462,19 +2462,6 @@ static void memory_failure_work_func(struct work_struct *work)
 	}
 }
 
-/*
- * Process memory_failure work queued on the specified CPU.
- * Used to avoid return-to-userspace racing with the memory_failure workqueue.
- */
-void memory_failure_queue_kick(int cpu)
-{
-	struct memory_failure_cpu *mf_cpu;
-
-	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
-}
-
 static int __init memory_failure_init(void)
 {
 	struct memory_failure_cpu *mf_cpu;
-- 
2.39.3


