Return-Path: <linux-kernel+bounces-9690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286681C9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7342E1C25180
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3F179B3;
	Fri, 22 Dec 2023 12:07:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AB17992
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SxQtg3Wp9z1FFJF;
	Fri, 22 Dec 2023 20:03:39 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FC711A0172;
	Fri, 22 Dec 2023 20:07:25 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Dec
 2023 20:07:24 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <mingo@redhat.com>, <will@kernel.org>, <peterz@infradead.org>,
	<longman@redhat.com>, <boqun.feng@gmail.com>
CC: <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] locking/osq_lock: Avoid false sharing in optimistic_spin_node
Date: Fri, 22 Dec 2023 20:10:40 +0800
Message-ID: <20231222121040.2635879-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500024.china.huawei.com (7.221.188.100)

Using the UnixBench test suite, we clearly find that osq_lock() cause
extremely high overheads with perf tool in the File Copy items:

Overhead  Shared Object            Symbol
  94.25%  [kernel]                 [k] osq_lock
   0.74%  [kernel]                 [k] rwsem_spin_on_owner
   0.32%  [kernel]                 [k] filemap_get_read_batch

In response to this, we conducted an analysis and made some gains:

In the prologue of osq_lock(), it set `cpu` member of percpu struct
optimistic_spin_node with the local cpu id, after that the value of the
percpu struct would never change in fact. Based on that, we can regard
the `cpu` member as a constant variable.

In the meanwhile, other members of the percpu struct like next, prev and
locked are frequently modified by osq_lock() and osq_unlock() which are
called by rwsem, mutex and so on. However, that would invalidate the cache
of the cpu member on other CPUs.

Therefore, we can place padding here and split them into different cache
lines to avoid cache misses when the next CPU is spinning to check other
node's cpu member by vcpu_is_preempted().

Here provide the UnixBench full-core test result based on v6.6 as below:
Machine Intel(R) Xeon(R) Gold 6248 CPU, 40 cores, 80 threads
Run the command of "./Run -c 80 -i 3" over 20 times and take the average.

System Benchmarks Index Values           Without Patch   With Patch     Diff
Dhrystone 2 using register variables         185518.38    185329.56   -0.10%
Double-Precision Whetstone                    79330.46     79268.22   -0.08%
Execl Throughput                               9725.14     10390.18    6.84%
File Copy 1024 bufsize 2000 maxblocks          1658.42      2035.55   22.74%
File Copy 256 bufsize 500 maxblocks            1086.54      1316.96   21.21%
File Copy 4096 bufsize 8000 maxblocks          3610.42      4152.79   15.02%
Pipe Throughput                               69325.18     69913.85    0.85%
Pipe-based Context Switching                  14026.32     14703.07    4.82%
Process Creation                               8329.94      8355.31    0.30%
Shell Scripts (1 concurrent)                  38942.41     41518.39    6.61%
Shell Scripts (8 concurrent)                  37762.35     40224.49    6.52%
System Call Overhead                           4064.44      4004.45   -1.48%
                                                                    ========
System Benchmarks Index Score                 13634.17     14560.71    6.80%

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
v1->v2: fix compile issue

 include/linux/osq_lock.h  | 10 +++++++++-
 kernel/locking/osq_lock.c |  8 +++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index 5581dbd3bd34..1883c31bf536 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_OSQ_LOCK_H
 #define __LINUX_OSQ_LOCK_H

+#include <linux/cache.h>
+
 /*
  * An MCS like lock especially tailored for optimistic spinning for sleeping
  * lock implementations (mutex, rwsem, etc).
@@ -9,7 +11,13 @@
 struct optimistic_spin_node {
 	struct optimistic_spin_node *next, *prev;
 	int locked; /* 1 if lock acquired */
-	int cpu; /* encoded CPU # + 1 value */
+
+	CACHELINE_PADDING(_pad1_);
+	/*
+	 * Stores an encoded CPU # + 1 value.
+	 * Only read by other cpus, so split into different cache lines.
+	 */
+	int cpu;
 };

 struct optimistic_spin_queue {
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52b92..17618d62343f 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -96,7 +96,13 @@ bool osq_lock(struct optimistic_spin_queue *lock)

 	node->locked = 0;
 	node->next = NULL;
-	node->cpu = curr;
+	/*
+	 * After this cpu member is initialized for the first time, it
+	 * would no longer change in fact. That could avoid cache misses
+	 * when spin and access the cpu member by other CPUs.
+	 */
+	if (node->cpu != curr)
+		node->cpu = curr;

 	/*
 	 * We need both ACQUIRE (pairs with corresponding RELEASE in
--
2.25.1


