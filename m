Return-Path: <linux-kernel+bounces-72484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AE85B415
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E0D1F230FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1185E5A4FF;
	Tue, 20 Feb 2024 07:37:44 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6257302
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414663; cv=none; b=T2u+KLdz3sQlfyEjsrBR2eUVZyVxZoKnWJ4yprFXvb/BVSCaEZ6Nfa439hmn3M9a8WU1y5dJOAlRFMi67y3iv22k+gUwDXUDCvHajS20c+2/vvxjqoBcyM68/PaKVq/ue4Fbp3oE4I48CGeHtLpQ5TISoxkOcD+15XRIbBF7xeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414663; c=relaxed/simple;
	bh=ohz7ZLiLPRyOowTuERYt0dFvN8eBmr4esXel573GWl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tv0MTxhWTxJkxuXt3X/OC4wUgl8kxgaIw1W3ZbHnvP1oRn8NsJOxHPw3uJPRMKgwqIxR9dIF7u6V8OBTp513u9Ai2PY/aQb4aw9M3vIMVvMtb4xjY0qk4tzdT0oSed2i+MiQRwiWdzVq/WaJdnd3CVipL00V5FS3JatgnuXIXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp79t1708414262tqhppdrf
X-QQ-Originating-IP: TJT6PEsZ/mcoC1NdJoNe1JOwIhM7ywu+pPUF3RJA56A=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Feb 2024 15:31:00 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: 5q30pvLz2ifZqeXFFACOvOMFaBUd68FKh2OQ6Vhtgk5xC4IHC6ZW2fd99mVYL
	vamEp9UFP/mlRLG8s2ESkRsfjUPT2PgEkae+d/+mpWl8lUeaKYv7U+6kIIbLzYOAeVbltFY
	fziZU/dPbuhGy8M5no6HVjriwEaTNJk7AfoTN7oBK+opKmVG8u3Zvq763iaOGpmuLRQtxkT
	4wkkOEGxv6SZTqZovsOYJkLhZa5xQHVQ5tolCJpIA5fW1apWeZhO2TR++F43YbwBcqn5Bxg
	Osyo6jDT32TDd4rswnY/AGs+OCO+nlxPW9mSy0dMgFlolZoYx1cdUi9HAVRgvWuBXhPSTYa
	VKe4k7ejXDfkVZx2Y0Hy7F5iCbcaletApe1vb58cm6zgnt8HAOvwhndzaz/93kVsmHF199K
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7601370966241811881
From: Guo Hui <guohui@uniontech.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	David.Laight@ACULAB.COM
Cc: linux-kernel@vger.kernel.org,
	Guo Hui <guohui@uniontech.com>
Subject: [PATCH] locking/osq_lock: Optimize osq_lock performance using per-NUMA
Date: Tue, 20 Feb 2024 15:30:58 +0800
Message-Id: <20240220073058.6435-1-guohui@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

After extensive testing of osq_lock,
we found that the performance of osq_lock is closely related to
the distance between NUMA nodes.The greater the distance
between NUMA nodes,the more serious the performance degradation of
osq_lock.When a group of processes that need to compete for
the same lock are on the same NUMA node,the performance of osq_lock
is the best.when the group of processes is distributed on
different NUMA nodes,as the distance between NUMA nodes increases,
the performance of osq_lock becomes worse.

This patch uses the following solutions to improve performance:
Divide the osq_lock linked list according to NUMA nodes.
Each NUMA node corresponds to an osq linked list.
Each CPU is added to the linked list corresponding to
its respective NUMA node.When the last CPU of
the NUMA node releases osq_lock,osq_lock is passed to
the next NUMA node.

As shown in the figure below, the last osq_node1 on NUMA0 passes the lock
to the first node (osq_node3) of the next NUMA1 node.

-----------------------------------------------------------
|            NUMA0           |            NUMA1           |
|----------------------------|----------------------------|
|  osq_node0 ---> osq_node1 -|-> osq_node3 ---> osq_node4 |
-----------------------------|-----------------------------

Set an atomic type global variable osq_lock_node to
record the NUMA node number that can currently obtain
the osq_lock lock.When the osq_lock_node value is
a certain node number,the CPU on the node obtains
the osq_lock lock in turn,and the CPUs on
other NUMA nodes poll wait.

This solution greatly reduces the performance degradation caused
by communication between CPUs on different NUMA nodes.

The effect on the 96-core 4-NUMA ARM64 platform is as follows:
System Benchmarks Partial Index       with patch  without patch  promote
File Copy 1024 bufsize 2000 maxblocks   2060.8      980.3        +110.22%
File Copy 256 bufsize 500 maxblocks     1346.5      601.9        +123.71%
File Copy 4096 bufsize 8000 maxblocks   4229.9      2216.1       +90.87%

The effect on the 128-core 8-NUMA X86_64 platform is as follows:
System Benchmarks Partial Index       with patch  without patch  promote
File Copy 1024 bufsize 2000 maxblocks   841.1       553.7        +51.91%
File Copy 256 bufsize 500 maxblocks     517.4       339.8        +52.27%
File Copy 4096 bufsize 8000 maxblocks   2058.4      1392.8       +47.79%

Signed-off-by: Guo Hui <guohui@uniontech.com>
---
 include/linux/osq_lock.h  | 20 +++++++++++--
 kernel/locking/osq_lock.c | 60 +++++++++++++++++++++++++++++++++------
 2 files changed, 69 insertions(+), 11 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index ea8fb31379e3..c016c1cf5e8b 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_OSQ_LOCK_H
 #define __LINUX_OSQ_LOCK_H
 
+#include <linux/nodemask.h>
+
 /*
  * An MCS like lock especially tailored for optimistic spinning for sleeping
  * lock implementations (mutex, rwsem, etc).
@@ -11,8 +13,9 @@ struct optimistic_spin_queue {
 	/*
 	 * Stores an encoded value of the CPU # of the tail node in the queue.
 	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
+	 * The actual number of NUMA nodes is generally not greater than 32.
 	 */
-	atomic_t tail;
+	atomic_t tail[32];
 };
 
 #define OSQ_UNLOCKED_VAL (0)
@@ -22,7 +25,11 @@ struct optimistic_spin_queue {
 
 static inline void osq_lock_init(struct optimistic_spin_queue *lock)
 {
-	atomic_set(&lock->tail, OSQ_UNLOCKED_VAL);
+	int node;
+
+	for_each_online_node(node) {
+		atomic_set(&lock->tail[node], OSQ_UNLOCKED_VAL);
+	}
 }
 
 extern bool osq_lock(struct optimistic_spin_queue *lock);
@@ -30,7 +37,14 @@ extern void osq_unlock(struct optimistic_spin_queue *lock);
 
 static inline bool osq_is_locked(struct optimistic_spin_queue *lock)
 {
-	return atomic_read(&lock->tail) != OSQ_UNLOCKED_VAL;
+	int node;
+
+	for_each_online_node(node) {
+		if (atomic_read(&lock->tail[node]) != OSQ_UNLOCKED_VAL)
+			return true;
+	}
+
+	return false;
 }
 
 #endif
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f6133866..7147050671a3 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -2,6 +2,7 @@
 #include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/osq_lock.h>
+#include <linux/topology.h>
 
 /*
  * An MCS like lock especially tailored for optimistic spinning for sleeping
@@ -16,6 +17,7 @@ struct optimistic_spin_node {
 	struct optimistic_spin_node *next, *prev;
 	int locked; /* 1 if lock acquired */
 	int cpu; /* encoded CPU # + 1 value */
+	int node;
 };
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
@@ -58,8 +60,8 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	int curr = encode_cpu(smp_processor_id());
 
 	for (;;) {
-		if (atomic_read(&lock->tail) == curr &&
-		    atomic_cmpxchg_acquire(&lock->tail, curr, old_cpu) == curr) {
+		if (atomic_read(&lock->tail[node->node]) == curr &&
+		    atomic_cmpxchg_acquire(&lock->tail[node->node], curr, old_cpu) == curr) {
 			/*
 			 * We were the last queued, we moved @lock back. @prev
 			 * will now observe @lock and will complete its
@@ -90,6 +92,21 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	}
 }
 
+static atomic_t osq_numa_node = ATOMIC_INIT(-1);
+
+/*
+ * The value of osq_numa_node is -1 or wait for the value of osq_numa_node
+ * to change to the NUMA node number where the current CPU is located.
+ */
+static void osq_wait_numa_node(struct optimistic_spin_node *node)
+{
+	int  old_node;
+
+	while (!need_resched() && (old_node = atomic_cmpxchg_acquire(&osq_numa_node, -1,
+					node->node)) != -1 && node->node != old_node)
+		cpu_relax();
+}
+
 bool osq_lock(struct optimistic_spin_queue *lock)
 {
 	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
@@ -100,6 +117,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	node->locked = 0;
 	node->next = NULL;
 	node->cpu = curr;
+	node->node = cpu_to_node(smp_processor_id());
 
 	/*
 	 * We need both ACQUIRE (pairs with corresponding RELEASE in
@@ -107,9 +125,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * the node fields we just initialised) semantics when updating
 	 * the lock tail.
 	 */
-	old = atomic_xchg(&lock->tail, curr);
-	if (old == OSQ_UNLOCKED_VAL)
+	old = atomic_xchg(&lock->tail[node->node], curr);
+	if (old == OSQ_UNLOCKED_VAL) {
+		osq_wait_numa_node(node);
 		return true;
+	}
 
 	prev = decode_cpu(old);
 	node->prev = prev;
@@ -144,8 +164,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * polling, be careful.
 	 */
 	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
-				  vcpu_is_preempted(node_cpu(node->prev))))
+				  vcpu_is_preempted(node_cpu(node->prev)))) {
+		osq_wait_numa_node(node);
 		return true;
+	}
 
 	/* unqueue */
 	/*
@@ -170,8 +192,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 		 * in which case we should observe @node->locked becoming
 		 * true.
 		 */
-		if (smp_load_acquire(&node->locked))
+		if (smp_load_acquire(&node->locked)) {
+			osq_wait_numa_node(node);
 			return true;
+		}
 
 		cpu_relax();
 
@@ -207,6 +231,22 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	return false;
 }
 
+static void set_osq_numa_node(struct optimistic_spin_queue *lock)
+{
+	int curr_node = cpu_to_node(smp_processor_id());
+	int node = curr_node;
+	int num_nodes = num_online_nodes();
+
+	do {
+		node = (node + 1) % num_nodes;
+		if (node == curr_node) {
+			atomic_set(&osq_numa_node, -1);
+			return;
+		}
+	} while (atomic_read(&lock->tail[node]) == OSQ_UNLOCKED_VAL);
+	atomic_set(&osq_numa_node, node);
+}
+
 void osq_unlock(struct optimistic_spin_queue *lock)
 {
 	struct optimistic_spin_node *node, *next;
@@ -215,9 +255,11 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	/*
 	 * Fast path for the uncontended case.
 	 */
-	if (likely(atomic_cmpxchg_release(&lock->tail, curr,
-					  OSQ_UNLOCKED_VAL) == curr))
+	if (likely(atomic_cmpxchg_release(&lock->tail[cpu_to_node(smp_processor_id())], curr,
+					  OSQ_UNLOCKED_VAL) == curr)) {
+		set_osq_numa_node(lock);
 		return;
+	}
 
 	/*
 	 * Second most likely case.
@@ -232,4 +274,6 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	next = osq_wait_next(lock, node, OSQ_UNLOCKED_VAL);
 	if (next)
 		WRITE_ONCE(next->locked, 1);
+	else
+		set_osq_numa_node(lock);
 }
-- 
2.20.1


