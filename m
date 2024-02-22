Return-Path: <linux-kernel+bounces-76665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F785FAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBD71F289DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE6414A4C0;
	Thu, 22 Feb 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p1Ko7q4H"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32D14A08D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610701; cv=none; b=nYubhOsTKrxfl+hltQo8yVCbbdjUlYecC5CW7odlg5neyCt86uf942BSKgSAB8NoZq+ht5YlMEUweb8sEQX46Mc/qaXrAl5s+raQRX99JYdO3RUFDvL8Wf//f9JkV1juvEJ90a/K7t17XnrdefbB+68NRFRqA3gF6KNBSFtjjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610701; c=relaxed/simple;
	bh=pKjNCBtJRKlytDtOYpIKfNyflGK1XMd1FZLmFDtWJWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPoo8aZI4PLaCnGPrm1+GsPIsvZUI6wj3jVVdKRIKFGwJ8FBaqf9oPDrw2hYzW7SjVKVtUAvA5s2UsES3a5xbehosQc6r145hCtvCROlswi24SLDEUtEzYahTgytNXqRkBExbIYipmd6xliRs2C924wvkE405/NnE8mOiCBIviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p1Ko7q4H; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgzBTPzPKbW03C1p+bf5b2VOJPKCTieqosPALSU6d3A=;
	b=p1Ko7q4HwLZ8IRyvsRmFPEObb08w0kLTfT8Eo/yUShmw9X8SanRExrBoYN4E8QizQ7JtJr
	y6CDhqCmusgjbGbPQnWZj7zwS/EdtoiwysOQK8U4EQ2jhWPEDI0N15nmbWXhOwCYYBftee
	20rXO2q25jdViRTYxjq4nVcOPEYzQBk=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v6 4/8] padata: dispatch works on different nodes
Date: Thu, 22 Feb 2024 22:04:17 +0800
Message-Id: <20240222140422.393911-5-gang.li@linux.dev>
In-Reply-To: <20240222140422.393911-1-gang.li@linux.dev>
References: <20240222140422.393911-1-gang.li@linux.dev>
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

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/padata.h |  2 ++
 kernel/padata.c        | 14 ++++++++++++--
 mm/mm_init.c           |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 495b16b6b4d72..8f418711351bc 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -137,6 +137,7 @@ struct padata_shell {
  *             appropriate for one worker thread to do at once.
  * @max_threads: Max threads to use for the job, actual number may be less
  *               depending on task size and minimum chunk size.
+ * @numa_aware: Distribute jobs to different nodes with CPU in a round robin fashion.
  */
 struct padata_mt_job {
 	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
@@ -146,6 +147,7 @@ struct padata_mt_job {
 	unsigned long		align;
 	unsigned long		min_chunk;
 	int			max_threads;
+	bool			numa_aware;
 };
 
 /**
diff --git a/kernel/padata.c b/kernel/padata.c
index 179fb1518070c..e3f639ff16707 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	struct padata_work my_work, *pw;
 	struct padata_mt_job_state ps;
 	LIST_HEAD(works);
-	int nworks;
+	int nworks, nid;
+	static atomic_t last_used_nid __initdata;
 
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
index 2c19f5515e36c..549e76af8f82a 100644
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


