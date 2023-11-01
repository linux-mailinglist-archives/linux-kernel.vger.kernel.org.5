Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAF7DE468
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjKAQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjKAQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2033E101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698854981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=weAhIXN5PXtoiXEIYu5w/2Q9wOZehC52EigYsa65J4Y=;
        b=iEQFuq05PcqMQZYEPDNSiQTx3YEZe8kySkWruBLpqXBBnU/zMqgAsrb07UKJZ99ei549VJ
        435GpfwEYLwVb1Dgs4vmMbJ+QGMK/pY6i/NJ/y5+4SPyAgtSb7NLlWmBsWAlv/fkTOcO8z
        BVca7dqCWUYhXWgz8qNbxQ7j8K4tCA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-EnA82G9lNGKQ5WKHccFtRQ-1; Wed, 01 Nov 2023 12:09:36 -0400
X-MC-Unique: EnA82G9lNGKQ5WKHccFtRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E197D881E24;
        Wed,  1 Nov 2023 16:09:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79414C1290F;
        Wed,  1 Nov 2023 16:09:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
Date:   Wed,  1 Nov 2023 12:09:11 -0400
Message-Id: <20231101160911.394526-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cgroup_rstat_updated() isn't being called concurrently with
cgroup_rstat_flush_locked(), its run time is pretty short. When
both are called concurrently, the cgroup_rstat_updated() run time
can spike to a pretty high value due to high cpu_lock hold time in
cgroup_rstat_flush_locked(). This can be problematic if the task calling
cgroup_rstat_updated() is a realtime task running on an isolated CPU
with a strict latency requirement. The cgroup_rstat_updated() call can
happens when there is a page fault even though the task is running in
user space most of the time.

The percpu cpu_lock is used to protect the update tree -
updated_next and updated_children. This protection is only needed
when cgroup_rstat_cpu_pop_updated() is being called. The subsequent
flushing operation which can take a much longer time does not need
that protection.

To reduce the cpu_lock hold time, we need to perform all the
cgroup_rstat_cpu_pop_updated() calls up front with the lock
released afterward before doing any flushing. This patch adds a new
cgroup_rstat_flush_list() function to do just that and return a singly
linked list of cgroup_rstat_cpu structures to be flushed.

By adding some instrumentation code to measure the maximum elapsed times
of the new cgroup_rstat_flush_list() function and each cpu iteration
of cgroup_rstat_flush_locked() around the old cpu_lock lock/unlock pair
on a 2-socket x86-64 server running parallel kernel build, the maximum
elapsed times are 31us and 118us respectively. The maximum cpu_lock
hold time is now reduced to about 1/4 of the original.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |  7 +++++
 kernel/cgroup/rstat.c       | 57 +++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 265da00a1a8b..22adb94ebb74 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -368,6 +368,13 @@ struct cgroup_rstat_cpu {
 	 */
 	struct cgroup *updated_children;	/* terminated by self cgroup */
 	struct cgroup *updated_next;		/* NULL iff not on the list */
+
+	/*
+	 * A singly-linked list of cgroup_rstat_cpu structures to be flushed.
+	 * Protected by cgroup_rstat_lock.
+	 */
+	struct cgroup_rstat_cpu *flush_next;
+	struct cgroup *cgroup;			/* Cgroup back pointer */
 };
 
 struct cgroup_freezer_state {
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..93ef2795a68d 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -145,6 +145,42 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/*
+ * Return a list of cgroup_rstat_cpu structures to be flushed
+ */
+static struct cgroup_rstat_cpu *cgroup_rstat_flush_list(struct cgroup *root,
+							int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup_rstat_cpu *head = NULL, *tail, *next;
+	unsigned long flags;
+	struct cgroup *pos;
+
+	/*
+	 * The _irqsave() is needed because cgroup_rstat_lock is
+	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+	 * this lock with the _irq() suffix only disables interrupts on
+	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+	 * interrupts on both configurations. The _irqsave() ensures
+	 * that interrupts are always disabled and later restored.
+	 */
+	raw_spin_lock_irqsave(cpu_lock, flags);
+	pos = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
+	if (!pos)
+		goto unlock;
+
+	head = tail = cgroup_rstat_cpu(pos, cpu);
+	while ((pos = cgroup_rstat_cpu_pop_updated(pos, root, cpu))) {
+		next = cgroup_rstat_cpu(pos, cpu);
+		tail->flush_next = next;
+		tail = next;
+	}
+	tail->flush_next = NULL;
+unlock:
+	raw_spin_unlock_irqrestore(cpu_lock, flags);
+	return head;
+}
+
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
  * Together with providing bpf kfuncs for cgroup_rstat_updated() and
@@ -179,23 +215,14 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
-						       cpu);
-		struct cgroup *pos = NULL;
-		unsigned long flags;
+		struct cgroup_rstat_cpu *rstat_cpu_next;
 
-		/*
-		 * The _irqsave() is needed because cgroup_rstat_lock is
-		 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
-		 * this lock with the _irq() suffix only disables interrupts on
-		 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
-		 * interrupts on both configurations. The _irqsave() ensures
-		 * that interrupts are always disabled and later restored.
-		 */
-		raw_spin_lock_irqsave(cpu_lock, flags);
-		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
+		rstat_cpu_next = cgroup_rstat_flush_list(cgrp, cpu);
+		while (rstat_cpu_next) {
+			struct cgroup *pos = rstat_cpu_next->cgroup;
 			struct cgroup_subsys_state *css;
 
+			rstat_cpu_next = rstat_cpu_next->flush_next;
 			cgroup_base_stat_flush(pos, cpu);
 			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
 
@@ -205,7 +232,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock_irqrestore(cpu_lock, flags);
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
@@ -281,6 +307,7 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 
 		rstatc->updated_children = cgrp;
+		rstatc->cgroup = cgrp;
 		u64_stats_init(&rstatc->bsync);
 	}
 
-- 
2.39.3

