Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5080998B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjLHCxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573014AbjLHCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:09 -0500
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C010CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:15 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702003993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBnw5RqwYO2IqY80uM+vPTSc8/TzM8Sh0FOmLemG2G4=;
        b=esddMIrNubz11Tjk5hcSDYsiI76jCdFHcT7RuRX5vkHNO/tt71jh8T95AJcRJ0EkjT5FPP
        nyp6uRRHoc0E4ynoEJCj3cDTTNvgLfqjFHV2Cv3uc8gZ6cNzKUTvW7ji1pnYkE7HVckU18
        dtXx/KCzGEPds0Qw2r7tjuJ+Dt6mSrc=
From:   Gang Li <gang.li@linux.dev>
To:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ligang.bdlg@bytedance.com, Gang Li <gang.li@linux.dev>
Subject: [RFC PATCH v2 3/5] padata: dispatch works on different nodes
Date:   Fri,  8 Dec 2023 10:52:38 +0800
Message-Id: <20231208025240.4744-4-gang.li@linux.dev>
In-Reply-To: <20231208025240.4744-1-gang.li@linux.dev>
References: <20231208025240.4744-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a group of tasks that access different nodes are scheduled on the
same node, they may encounter bandwidth bottlenecks and access latency.

Thus, numa_aware flag is introduced here, allowing tasks to be
distributed across different nodes to fully utilize the advantage of
multi-node systems.

Signed-off-by: Gang Li <gang.li@linux.dev>
---
 include/linux/padata.h | 2 ++
 kernel/padata.c        | 8 ++++++--
 mm/mm_init.c           | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/padata.h b/include/linux/padata.h
index 495b16b6b4d72..f6c58c30ed96a 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -137,6 +137,7 @@ struct padata_shell {
  *             appropriate for one worker thread to do at once.
  * @max_threads: Max threads to use for the job, actual number may be less
  *               depending on task size and minimum chunk size.
+ * @numa_aware: Dispatch jobs to different nodes.
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
index 179fb1518070c..80f82c563e46a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	struct padata_work my_work, *pw;
 	struct padata_mt_job_state ps;
 	LIST_HEAD(works);
-	int nworks;
+	int nworks, nid;
 
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
index 077bfe393b5e2..1226f0c81fcb3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2234,6 +2234,7 @@ static int __init deferred_init_memmap(void *data)
 			.align       = PAGES_PER_SECTION,
 			.min_chunk   = PAGES_PER_SECTION,
 			.max_threads = max_threads,
+			.numa_aware  = false,
 		};
 
 		padata_do_multithreaded(&job);
-- 
2.30.2

