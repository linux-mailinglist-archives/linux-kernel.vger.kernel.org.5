Return-Path: <linux-kernel+bounces-14384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E5821C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D825283625
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31111708;
	Tue,  2 Jan 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eko96B8O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182BC10A0D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704201208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BwxzTkbv6fMj2IlVqqVSI+5ecpQCg7jHconULcXMhU=;
	b=Eko96B8OaBJVKkDyhD/UM2q4AYrrNykiYUCYNcfOZ1A32BsBy/zQcEdL/Y94CQ0FhNyARP
	ty7rzZ3ZddQ0yUhcxHQr6aLFHRTzuQy4e+fg9Mn0btG4rccV9gwgX3Wz1I1oA73vy9Mlfb
	eNChOv/zhRPqCB0SpDniNhAQ6XPQGOE=
From: Gang Li <gang.li@linux.dev>
To: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v3 3/7] padata: dispatch works on different nodes
Date: Tue,  2 Jan 2024 21:12:45 +0800
Message-Id: <20240102131249.76622-4-gang.li@linux.dev>
In-Reply-To: <20240102131249.76622-1-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a group of tasks that access different nodes are scheduled on the
same node, they may encounter bandwidth bottlenecks and access latency.

Thus, numa_aware flag is introduced here, allowing tasks to be
distributed across different nodes to fully utilize the advantage of
multi-node systems.

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 include/linux/padata.h | 3 +++
 kernel/padata.c        | 8 ++++++--
 mm/mm_init.c           | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 495b16b6b4d72..f79ccd50e7f40 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -137,6 +137,8 @@ struct padata_shell {
  *             appropriate for one worker thread to do at once.
  * @max_threads: Max threads to use for the job, actual number may be less
  *               depending on task size and minimum chunk size.
+ * @numa_aware: Dispatch jobs to different nodes. If a node only has memory but
+ *              no CPU, dispatch its jobs to a random CPU.
  */
 struct padata_mt_job {
 	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
@@ -146,6 +148,7 @@ struct padata_mt_job {
 	unsigned long		align;
 	unsigned long		min_chunk;
 	int			max_threads;
+	bool			numa_aware;
 };
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index 179fb1518070c..1c2b3a337479e 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	struct padata_work my_work, *pw;
 	struct padata_mt_job_state ps;
 	LIST_HEAD(works);
-	int nworks;
+	int nworks, nid = 0;
 
 	if (job->size == 0)
 		return;
@@ -517,7 +517,11 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	ps.chunk_size = roundup(ps.chunk_size, job->align);
 
 	list_for_each_entry(pw, &works, pw_list)
-		queue_work(system_unbound_wq, &pw->pw_work);
+		if (job->numa_aware)
+			queue_work_node((++nid % num_node_state(N_MEMORY)),
+					system_unbound_wq, &pw->pw_work);
+		else
+			queue_work(system_unbound_wq, &pw->pw_work);
 
 	/* Use the current thread, which saves starting a workqueue worker. */
 	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 89dc29f1e6c6f..59fcffddf65a3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2225,6 +2225,7 @@ static int __init deferred_init_memmap(void *data)
 			.align       = PAGES_PER_SECTION,
 			.min_chunk   = PAGES_PER_SECTION,
 			.max_threads = max_threads,
+			.numa_aware  = false,
 		};
 
 		padata_do_multithreaded(&job);
-- 
2.20.1


