Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644927DE9BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjKBAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjKBAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB51A130
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698886417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KrR34QK/1EgU2vcvxk/QZ8sFIYtb+uVipnwj+yKp+tQ=;
        b=YKHAraS0NZcl78dl8N+Mbwuu4TaTg6YXHSahZwUPJ9QcpwNwr6V/eb1UDx+KpWOU6gW1EW
        LSJaMHWl5vOuzgG/HhPy786FISxEJrm1dsb9K7fv6lsqgaJIoazn3mLfPxRthGujNVc/mS
        ik1TmsKQponFBKOfRqqq8RS19FEQYAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-Njlu7c5GMtKKFVtf1b8I9g-1; Wed, 01 Nov 2023 20:53:30 -0400
X-MC-Unique: Njlu7c5GMtKKFVtf1b8I9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF16081B563;
        Thu,  2 Nov 2023 00:53:29 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 304C510F52;
        Thu,  2 Nov 2023 00:53:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/rstat: Reduce cpu_lock hold time in cgroup_rstat_flush_locked()
Date:   Wed,  1 Nov 2023 20:53:10 -0400
Message-Id: <20231102005310.439588-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
cgroup_rstat_updated_list() function to return a singly linked list of
cgroups to be flushed.

By adding some instrumentation code to measure the maximum elapsed times
of the new cgroup_rstat_updated_list() function and each cpu iteration of
cgroup_rstat_updated_locked() around the old cpu_lock lock/unlock pair
on a 2-socket x86-64 server running parallel kernel build, the maximum
elapsed times are 27us and 88us respectively. The maximum cpu_lock hold
time is now reduced to about 30% of the original.

Below were the run time distribution of cgroup_rstat_updated_list()
during the same period:

      Run time             Count
      --------             -----
         t <= 1us       12,574,302
   1us < t <= 5us        2,127,482
   5us < t <= 10us           8,445
  10us < t <= 20us           6,425
  20us < t <= 30us              50

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |  6 +++++
 kernel/cgroup/rstat.c       | 45 ++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 265da00a1a8b..daaf6d4eb8b6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -491,6 +491,12 @@ struct cgroup {
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct list_head rstat_css_list;
 
+	/*
+	 * A singly-linked list of cgroup structures to be rstat flushed.
+	 * Protected by cgroup_rstat_lock.
+	 */
+	struct cgroup	*rstat_flush_next;
+
 	/* cgroup basic resource statistics */
 	struct cgroup_base_stat last_bstat;
 	struct cgroup_base_stat bstat;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..a86d40ed8bda 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -145,6 +145,34 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 	return pos;
 }
 
+/*
+ * Return a list of updated cgroups to be flushed
+ */
+static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+{
+	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+	struct cgroup *head, *tail, *next;
+	unsigned long flags;
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
+	head = tail = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
+	while (tail) {
+		next = cgroup_rstat_cpu_pop_updated(tail, root, cpu);
+		tail->rstat_flush_next = next;
+		tail = next;
+	}
+	raw_spin_unlock_irqrestore(cpu_lock, flags);
+	return head;
+}
+
 /*
  * A hook for bpf stat collectors to attach to and flush their stats.
  * Together with providing bpf kfuncs for cgroup_rstat_updated() and
@@ -179,21 +207,9 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
-						       cpu);
-		struct cgroup *pos = NULL;
-		unsigned long flags;
+		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
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
+		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
@@ -205,7 +221,6 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock_irqrestore(cpu_lock, flags);
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
-- 
2.39.3

