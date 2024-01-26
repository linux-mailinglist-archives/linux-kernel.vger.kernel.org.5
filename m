Return-Path: <linux-kernel+bounces-40271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289483DD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAB61F212F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD81CFBE;
	Fri, 26 Jan 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wyYlzc34"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162791DFE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282718; cv=none; b=uKyOHJuQF5R6Zb8yvZIOwS5Ct1h5LPl+mmtP5CHczLemnpAv4Li8pLjZSglDan6qnoMKKkODvImBFH0mxZxtO9WF3+gJiOhNBVa9pgoA417rd0K6DjjrfnA6LAtSMdZFSl/N42/aPlG3eCXOh5VG0MOuMwYWw+NNffJQpv0Jgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282718; c=relaxed/simple;
	bh=A7DeycgaAylfyaGHNXPeWa+Y5alq9KqCBr3DPXdOYWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCeFITXaapkNiwwNqgJxqwXW1fzVogXfo4jlWK+oVR475/z5/thytWCMOefS9q3V0MqCONERFGtf2ib0/FotJ8o646K1ARMimk+VfokEvmL7a5FjI1F5Jtel2XzVdhhBZv9N7fkNry8yuNgdh0TzJMYRU8tRk6UxIxuCotpNrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wyYlzc34; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmrMLc6E2IVqKhV8ZhRU9VeFjN80rDuhVxh0u6+eJMA=;
	b=wyYlzc34oaBoDa42QsBypygqXrsoGKHAfb+deg3SuOPDAmbhiv09g6PCqoW3PG4AJbHsVA
	hz3+64qyLRhxOGW5ACJiiomiu2sHCxRKxpEOC4gAbDn/H6YePZadVNJJ/H4FtQXG7IOOjG
	0L+u9CTOwvqS2DBzIXlE1TKDr+2kLOc=
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
Subject: [PATCH v5 3/7] padata: dispatch works on different nodes
Date: Fri, 26 Jan 2024 23:24:07 +0800
Message-Id: <20240126152411.1238072-4-gang.li@linux.dev>
In-Reply-To: <20240126152411.1238072-1-gang.li@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
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


