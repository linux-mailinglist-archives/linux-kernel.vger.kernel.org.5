Return-Path: <linux-kernel+bounces-30106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C169831943
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559A7282C66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8242575E;
	Thu, 18 Jan 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CBfV/dbd"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C525579
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581571; cv=none; b=DRZ7hdUOlIOvQ/STKl+Gk5SCgGm9T1DMHCiYS/uqvJjaYFhTc/5VLl6yMAQry1A1nDuPjbBBp//lpfSaX0VAHrpoBNJ5JSlBdsyPlZJuq/+Ri2ELwFQESfPrwyzuSt311cF6bYXVzw7J7AnMgrXEMdkhaeXqam6/2eg1+huvllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581571; c=relaxed/simple;
	bh=hOV1vAKEslMDXnSKKyUL4RMeDVj1M1oqk023PSsPXZ8=;
	h=X-Report-Abuse:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Migadu-Flow; b=Cgu1JJDLzWXym5qhRF87pBIEsjx0gKNBioeaA2xnc16LcH+b4R+E9pn/vgnePwaB9LoWaVLgY1CeWCwBbbRIVLBHZ7PcZlkBHH5lYjwK+OGWwtS4bo5Aui5f7B3u4OcVvy1gaNk1IU9dzhJlxUePbZ1jUbvg0MiAuXjkUtkKCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CBfV/dbd; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705581568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzFCclyqcCZ/DPTkdiqBlpFX5oAyD0zr6O7wxsAo568=;
	b=CBfV/dbd2xHdE+F7YOmZ8GE2oRxwpthKTYpZaNj00rjrNcG/Z6lT98VVTzGw5xvY9Iwof6
	dbCeWyIuDNqzO2dQE9ps3z2Qxk/A0VvAR8HDZp233bxQeP3YxsFW41WeXH4eB6WEwKUxc2
	jA2LqaFNCxUtLsV24/vypYmZim4cKdU=
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
Subject: [PATCH v4 3/7] padata: dispatch works on different nodes
Date: Thu, 18 Jan 2024 20:39:07 +0800
Message-Id: <20240118123911.88833-4-gang.li@linux.dev>
In-Reply-To: <20240118123911.88833-1-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
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
Tested-by: David Rientjes <rientjes@google.com>
---
 include/linux/padata.h |  3 +++
 kernel/padata.c        | 14 ++++++++++++--
 mm/mm_init.c           |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 495b16b6b4d7..f79ccd50e7f4 100644
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
index 179fb1518070..10eae3f59203 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	struct padata_work my_work, *pw;
 	struct padata_mt_job_state ps;
 	LIST_HEAD(works);
-	int nworks;
+	int nworks, nid;
+	static atomic_t last_used_nid = ATOMIC_INIT(0);
 
 	if (job->size == 0)
 		return;
@@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	ps.chunk_size = roundup(ps.chunk_size, job->align);
 
 	list_for_each_entry(pw, &works, pw_list)
-		queue_work(system_unbound_wq, &pw->pw_work);
+		if (job->numa_aware) {
+			int old_node = atomic_read(&last_used_nid);
+
+			do {
+				nid = next_node_in(old_node, node_states[N_CPU]);
+			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
+			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
+		} else {
+			queue_work(system_unbound_wq, &pw->pw_work);
+		}
 
 	/* Use the current thread, which saves starting a workqueue worker. */
 	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 2c19f5515e36..549e76af8f82 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2231,6 +2231,7 @@ static int __init deferred_init_memmap(void *data)
 			.align       = PAGES_PER_SECTION,
 			.min_chunk   = PAGES_PER_SECTION,
 			.max_threads = max_threads,
+			.numa_aware  = false,
 		};
 
 		padata_do_multithreaded(&job);
-- 
2.20.1


