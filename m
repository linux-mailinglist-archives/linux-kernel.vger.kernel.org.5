Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143C67FFCF6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376378AbjK3Unr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376330AbjK3Unn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2641710
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701377028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvh/PoAVDFNBvxQYr5eIckx+Y2FvTFRvRfoME4darjI=;
        b=ZiFesjK8pHl9CuJBLZW9uoKeAKLHPTljg1zd6qszd1skBKP18jSy0QxDC75Zm+pdqmmrQX
        HZzkdQ6ABqqZC92BSlWkAO9e7EXE6G+Ih7GcBzdJkXsn5aS8LwpoFU9HQotKqd8QSvlwHh
        sV7Skg3f/KicB/we2shpAoVp3keXeas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-kJ8CWpKQM2egS-VgsYXc2g-1; Thu, 30 Nov 2023 15:43:44 -0500
X-MC-Unique: kJ8CWpKQM2egS-VgsYXc2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 210EB85A59D;
        Thu, 30 Nov 2023 20:43:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95E7440C6EB9;
        Thu, 30 Nov 2023 20:43:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 1/2] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Date:   Thu, 30 Nov 2023 15:43:26 -0500
Message-Id: <20231130204327.494249-2-longman@redhat.com>
In-Reply-To: <20231130204327.494249-1-longman@redhat.com>
References: <20231130204327.494249-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/rstat.c | 153 +++++++++++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 62 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1f300bf4dc40..e77f134c6f03 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -74,64 +74,109 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 }
 
 /**
- * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
- * @pos: current position
- * @root: root of the tree to traversal
+ * cgroup_rstat_push_children - push children cgroups into the given list
+ * @head: current head of the list (= subtree root)
+ * @child: first child of the root
  * @cpu: target cpu
+ * Return: A new singly linked list of cgroups to be flush
  *
- * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
- * the traversal and %NULL return indicates the end.  During traversal,
- * each returned cgroup is unlinked from the tree.  Must be called with the
- * matching cgroup_rstat_cpu_lock held.
+ * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
+ * level and push all the parents first before their next level children
+ * into a singly linked list built from the tail backward like "pushing"
+ * cgroups into a stack. The parent is by the caller.
+ */
+static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
+						 struct cgroup *child, int cpu)
+{
+	struct cgroup *chead = child;	/* Head of child cgroup level */
+	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
+	struct cgroup *parent, *grandchild;
+	struct cgroup_rstat_cpu *crstatc;
+
+	child->rstat_flush_next = NULL;
+
+next_level:
+	while (chead) {
+		child = chead;
+		chead = child->rstat_flush_next;
+		parent = cgroup_parent(child);
+
+		/* updated_next is parent cgroup terminated */
+		while (child != parent) {
+			child->rstat_flush_next = head;
+			head = child;
+			crstatc = cgroup_rstat_cpu(child, cpu);
+			grandchild = crstatc->updated_children;
+			if (grandchild != child) {
+				/* Push the grand child to the next level */
+				crstatc->updated_children = child;
+				grandchild->rstat_flush_next = ghead;
+				ghead = grandchild;
+			}
+			child = crstatc->updated_next;
+			crstatc->updated_next = NULL;
+		}
+	}
+
+	if (ghead) {
+		chead = ghead;
+		ghead = NULL;
+		goto next_level;
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
+ * each returned cgroup is unlinked from the updated tree.
  *
  * The only ordering guarantee is that, for a parent and a child pair
- * covered by a given traversal, if a child is visited, its parent is
- * guaranteed to be visited afterwards.
+ * covered by a given traversal, the child is before its parent in
+ * the list.
+ *
+ * Note that updated_children is self terminated and points to a list of
+ * child cgroups if not empty. Whereas updated_next is like a sibling link
+ * within the children list and terminated by the parent cgroup. An exception
+ * here is the cgroup root whose updated_next can be self terminated.
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
+	struct cgroup *head = NULL, *parent, *child;
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
@@ -142,31 +187,15 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	}
 
 	rstatc->updated_next = NULL;
-	return pos;
-}
 
-/* Return a list of updated cgroups to be flushed */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
-{
-	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup *head, *tail, *next;
-	unsigned long flags;
-
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
+	child = rstatc->updated_children;
+	rstatc->updated_children = root;
+	if (child != root)
+		head = cgroup_rstat_push_children(head, child, cpu);
+unlock_ret:
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 	return head;
 }
-- 
2.39.3

