Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E227DC377
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjJaAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjJaAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB00AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698711290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IoQ2Le2ITOSvLLlQ6rdOrFcEhEfUWnC+H48y+paeBiM=;
        b=VUD67BggCP8j6qoyAOkK1XEkMT3NYfPrG/Ln66rhC6TkX/oqJO1f/Cp5R56Qrugg0qZBmS
        qtnNWQkbvSV60f10oIxp6Xs+iolLjGQo+IosSDZcBXRxpM2yMR6X8KWt6lU/uS4AkxgoEJ
        XgjnQ0nQ8wwcQrEBdngbAdWAw1aH2Vw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-bSQ0dSVyMeiQq3ONrasRCw-1; Mon, 30 Oct 2023 20:14:46 -0400
X-MC-Unique: bSQ0dSVyMeiQq3ONrasRCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FFB7811E7E;
        Tue, 31 Oct 2023 00:14:46 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 524D42026D4C;
        Tue, 31 Oct 2023 00:14:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] sched: Don't call any kfree*() API in do_set_cpus_allowed()
Date:   Mon, 30 Oct 2023 20:14:18 -0400
Message-Id: <20231031001418.274187-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
do_set_cpus_allowed()") added a kfree() call to free any user
provided affinity mask, if present. It was changed later to use
kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
in do_set_cpus_allowed()") to avoid a circular locking dependency
problem.

It turns out that even kfree_rcu() isn't safe for avoiding
circular locking problem. As reported by kernel test robot,
the following circular locking dependency still exists:

  &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock

So no kfree*() API can be used in do_set_cpus_allowed(). To prevent
memory leakage, the unused user provided affinity mask is now saved in a
lockless list to be reused later by subsequent sched_setaffinity() calls.

Without kfree_rcu(), the internal cpumask_rcuhead union can be removed
too as a lockless list entry only holds a single pointer.

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/core.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..f536d11a284e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2789,6 +2789,11 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		set_next_task(rq, p);
 }
 
+/*
+ * A lockless list of free cpumasks to be used for user cpumasks.
+ */
+static LLIST_HEAD(cpumask_free_lhead);
+
 /*
  * Used for kthread_bind() and select_fallback_rq(), in both cases the user
  * affinity (if any) should be destroyed too.
@@ -2800,29 +2805,29 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		.user_mask = NULL,
 		.flags     = SCA_USER,	/* clear the user requested mask */
 	};
-	union cpumask_rcuhead {
-		cpumask_t cpumask;
-		struct rcu_head rcu;
-	};
 
 	__do_set_cpus_allowed(p, &ac);
 
 	/*
-	 * Because this is called with p->pi_lock held, it is not possible
-	 * to use kfree() here (when PREEMPT_RT=y), therefore punt to using
-	 * kfree_rcu().
+	 * We can't call any kfree*() API here as p->pi_lock and/or rq lock
+	 * may be held. So we save it in a llist to be reused in the next
+	 * sched_setaffinity() call.
 	 */
-	kfree_rcu((union cpumask_rcuhead *)ac.user_mask, rcu);
+	if (ac.user_mask)
+		llist_add((struct llist_node *)ac.user_mask, &cpumask_free_lhead);
 }
 
 static cpumask_t *alloc_user_cpus_ptr(int node)
 {
-	/*
-	 * See do_set_cpus_allowed() above for the rcu_head usage.
-	 */
-	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
+	struct cpumask *pmask = NULL;
+
+	if (!llist_empty(&cpumask_free_lhead))
+		pmask = (struct cpumask *)llist_del_first(&cpumask_free_lhead);
+
+	if (!pmask)
+		pmask = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
 
-	return kmalloc_node(size, GFP_KERNEL, node);
+	return pmask;
 }
 
 int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
-- 
2.39.3

