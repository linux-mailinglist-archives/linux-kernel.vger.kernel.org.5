Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19F17E0D6D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbjKDDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbjKDDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCDBD72
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699067603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag+X6OdrPM4qcS+lve0uYD4xt7fsfaJmYoOAVQ+n5M0=;
        b=RXrB86OhMLBfvJceLO/3EeZx4uy1H+Zm9ZKrhhP1EBPprzM0GM2x1slZzrIim193JTYboz
        qGWTqrEO57ho3PKQws4lWViJEz9t5tee+2NZW/F/JxyIQ0oyKmYLsXIe3XPnmEyIuND/1/
        Nx8PyoDX9fkJUpdC6b/Ww9ny+Jv2Vco=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-spme2rO_PhOq1tF1su41mw-1; Fri,
 03 Nov 2023 23:13:19 -0400
X-MC-Unique: spme2rO_PhOq1tF1su41mw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A1FE29A9A10;
        Sat,  4 Nov 2023 03:13:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B72AC1290F;
        Sat,  4 Nov 2023 03:13:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Date:   Fri,  3 Nov 2023 23:13:02 -0400
Message-Id: <20231104031303.592879-3-longman@redhat.com>
In-Reply-To: <20231104031303.592879-1-longman@redhat.com>
References: <20231104031303.592879-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current design of cgroup_rstat_cpu_pop_updated() is to traverse
the updated tree in a way to pop out the leaf nodes first before
their parents. This can cause traversal of multiple nodes before a
leaf node can be found and popped out. IOW, a given node in the tree
can be visited multiple times before the whole operation is done. So
it is not very efficient and the code can be hard to read.

With the introduction of cgroup_rstat_updated_list() to build a list
of cgroups to be flushed first before any flushing operation is being
done, we can optimize the way the updated tree nodes are being popped
by pushing the parents first to the tail end of the list before their
children. In this way, most updated tree nodes will be visited only
once with the exception of the subtree root as we still need to go
back to its parent and popped it out of its updated_children list.
This also makes the code easier to read.

A parallel kernel build on a 2-socket x86-64 server is used as the
benchmarking tool for measuring the lock hold time. Below were the lock
hold time frequency distribution before and after the patch:

     Hold time        Before patch       After patch
     ---------        ------------       -----------
       0-01 us        13,738,708         14,594,545
      01-05 us         1,177,194            439,926
      05-10 us             4,984              5,960
      10-15 us             3,562              3,543
      15-20 us             1,314              1,397
      20-25 us                18                 25
      25-30 us                12                 12

It can be seen that the patch pushes the lock hold time towards the
lower end.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/rstat.c | 132 ++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 62 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1f300bf4dc40..d2b709cfeb2a 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -74,64 +74,90 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 }
 
 /**
- * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
- * @pos: current position
- * @root: root of the tree to traversal
+ * cgroup_rstat_push_children - push children cgroups into the given list
+ * @head: current head of the list (= parent cgroup)
+ * @prstatc: cgroup_rstat_cpu of the parent cgroup
  * @cpu: target cpu
+ * Return: A new singly linked list of cgroups to be flush
  *
- * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
- * the traversal and %NULL return indicates the end.  During traversal,
- * each returned cgroup is unlinked from the tree.  Must be called with the
- * matching cgroup_rstat_cpu_lock held.
+ * Recursively traverse down the cgroup_rstat_cpu updated tree and push
+ * parent first before its children. The parent is pushed by the caller.
+ * The recursion depth is the depth of the current updated tree.
+ */
+static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
+				struct cgroup_rstat_cpu *prstatc, int cpu)
+{
+	struct cgroup *child, *parent;
+	struct cgroup_rstat_cpu *crstatc;
+
+	parent = head;
+	child = prstatc->updated_children;
+	prstatc->updated_children = parent;
+
+	/* updated_next is parent cgroup terminated */
+	while (child != parent) {
+		child->rstat_flush_next = head;
+		head = child;
+		crstatc = cgroup_rstat_cpu(child, cpu);
+		if (crstatc->updated_children != parent)
+			head = cgroup_rstat_push_children(head, crstatc, cpu);
+		child = crstatc->updated_next;
+		crstatc->updated_next = NULL;
+	}
+	return head;
+}
+
+/**
+ * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
+ * @root: root of the cgroup subtree to traverse
+ * @cpu: target cpu
+ * Return: A singly linked list of cgroups to be flushed
+ *
+ * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
+ * each returned cgroup is unlinked from the updated tree.  Must be called
+ * with the matching cgroup_rstat_cpu_lock held.
  *
  * The only ordering guarantee is that, for a parent and a child pair
- * covered by a given traversal, if a child is visited, its parent is
- * guaranteed to be visited afterwards.
+ * covered by a given traversal, the child is before its parent in
+ * the list.
+ *
+ * Note that updated_children is self terminated while updated_next is
+ * parent cgroup terminated except the cgroup root which can be self
+ * terminated.
  */
-static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
-						   struct cgroup *root, int cpu)
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc;
-	struct cgroup *parent;
-
-	if (pos == root)
-		return NULL;
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
+	struct cgroup *head = NULL, *parent;
+	unsigned long flags;
 
 	/*
-	 * We're gonna walk down to the first leaf and visit/remove it.  We
-	 * can pick whatever unvisited node as the starting point.
+	 * The _irqsave() is needed because cgroup_rstat_lock is
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+	 * this lock with the _irq() suffix only disables interrupts on
+	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+	 * interrupts on both configurations. The _irqsave() ensures
+	 * that interrupts are always disabled and later restored.
 	 */
-	if (!pos) {
-		pos = root;
-		/* return NULL if this subtree is not on-list */
-		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
-			return NULL;
-	} else {
-		pos = cgroup_parent(pos);
-	}
+	raw_spin_lock_irqsave(cpu_lock, flags);
 
-	/* walk down to the first leaf */
-	while (true) {
-		rstatc = cgroup_rstat_cpu(pos, cpu);
-		if (rstatc->updated_children == pos)
-			break;
-		pos = rstatc->updated_children;
-	}
+	/* Return NULL if this subtree is not on-list */
+	if (!rstatc->updated_next)
+		goto unlock_ret;
 
 	/*
-	 * Unlink @pos from the tree.  As the updated_children list is
+	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
-	 * However, due to the way we traverse, @pos will be the first
-	 * child in most cases. The only exception is @root.
 	 */
-	parent = cgroup_parent(pos);
+	parent = cgroup_parent(root);
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
 		struct cgroup **nextp;
 
 		prstatc = cgroup_rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
-		while (*nextp != pos) {
+		while (*nextp != root) {
 			struct cgroup_rstat_cpu *nrstatc;
 
 			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
@@ -142,31 +168,13 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	}
 
 	rstatc->updated_next = NULL;
-	return pos;
-}
-
-/* Return a list of updated cgroups to be flushed */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
-{
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup *head, *tail, *next;
-	unsigned long flags;
 
-	/*
-	 * The _irqsave() is needed because cgroup_rstat_lock is
-	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-	 * this lock with the _irq() suffix only disables interrupts on
-	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-	 * interrupts on both configurations. The _irqsave() ensures
-	 * that interrupts are always disabled and later restored.
-	 */
-	raw_spin_lock_irqsave(cpu_lock, flags);
-	head = tail = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
-	while (tail) {
-		next = cgroup_rstat_cpu_pop_updated(tail, root, cpu);
-		tail->rstat_flush_next = next;
-		tail = next;
-	}
+	/* Push @root to the list first before pushing the children */
+	head = root;
+	root->rstat_flush_next = NULL;
+	if (rstatc->updated_children != root)
+		head = cgroup_rstat_push_children(head, rstatc, cpu);
+unlock_ret:
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 	return head;
 }
-- 
2.39.3

