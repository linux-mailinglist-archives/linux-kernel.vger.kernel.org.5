Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BA7F9838
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjK0EUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0EUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E4131
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701058842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKVtOlZpPOEAj5lNTi1dWbItOap9Z0LKbf6VYUUDvbg=;
        b=FMTtt8QMywmnEf596PEhyNl5rUB3V738/i5GtPktNKAmaZTD/gkrgtzvkQ3weNorTuhSA/
        slb3CCTF8k24e96sKLSX5AsQDnIizvrBu1v70T3KzQmY5CMEh2wO9G85IbRXw3VkUqLuIq
        Cdyn9IyMjcc+lz/eNCbWZ0ADa8dgcKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-j3AE3EJcPLitu_hjDmnbBg-1; Sun, 26 Nov 2023 23:20:36 -0500
X-MC-Unique: j3AE3EJcPLitu_hjDmnbBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C3981D8A1;
        Mon, 27 Nov 2023 04:20:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8543410EA1;
        Mon, 27 Nov 2023 04:20:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check
Date:   Sun, 26 Nov 2023 23:19:56 -0500
Message-Id: <20231127041956.266026-3-longman@redhat.com>
In-Reply-To: <20231127041956.266026-1-longman@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the cpu_is_isolated() function checks only the statically
isolated CPUs specified via the "isolcpus" and "nohz_full" kernel
command line options. This function is used by vmstat and memcg to
reduce interference with isolated CPUs by not doing stat flushing
or scheduling works on those CPUs.

Workloads running on isolated CPUs within isolated cpuset
partitions should receive the same treatment to reduce unnecessary
interference. This patch introduces a new cpuset_cpu_is_isolated()
function to be called by cpu_is_isolated() so that the set of dynamically
created cpuset isolated CPUs will be included in the check.

To minimize overhead of calling cpuset_cpu_is_isolated(), a seqcount
is used to protect read access of the isolated cpumask without taking
the cpuset_mutex or callback_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpuset.h          |  6 ++++++
 include/linux/sched/isolation.h |  4 +++-
 kernel/cgroup/cpuset.c          | 25 +++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d629094fac6e..875d12598bd2 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -77,6 +77,7 @@ extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -207,6 +208,11 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 	return false;
 }
 
+static inline bool cpuset_cpu_is_isolated(int cpu)
+{
+	return false;
+}
+
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 {
 	return node_possible_map;
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index fe1a46f30d24..2b461129d1fa 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -2,6 +2,7 @@
 #define _LINUX_SCHED_ISOLATION_H
 
 #include <linux/cpumask.h>
+#include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/tick.h>
 
@@ -67,7 +68,8 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 static inline bool cpu_is_isolated(int cpu)
 {
 	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-		 !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
+	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
+	       cpuset_cpu_is_isolated(cpu);
 }
 
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e34bbb0e2f24..4adb6d2209ca 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -208,8 +208,13 @@ static cpumask_var_t	subpartitions_cpus;
 
 /*
  * Exclusive CPUs in isolated partitions
+ *
+ * The isolcpus_seq is used to protect read access to isolated_cpus without
+ * taking callback_lock or cpuset_mutex while write access requires taking
+ * both cpuset_mutex and callback_lock.
  */
 static cpumask_var_t	isolated_cpus;
+static seqcount_t isolcpus_seq = SEQCNT_ZERO(isolcpus_seq);
 
 /* List of remote partition root children */
 static struct list_head remote_children;
@@ -1435,10 +1440,12 @@ static void reset_partition_data(struct cpuset *cs)
 static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *xcpus)
 {
 	WARN_ON_ONCE(old_prs == new_prs);
+	write_seqcount_begin(&isolcpus_seq);
 	if (new_prs == PRS_ISOLATED)
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
 	else
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
+	write_seqcount_end(&isolcpus_seq);
 }
 
 /*
@@ -1518,6 +1525,24 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 	WARN_ON_ONCE(ret < 0);
 }
 
+/**
+ * cpuset_cpu_is_isolated - Check if the given CPU is isolated
+ * @cpu: the CPU number to be checked
+ * Return: true if CPU is used in an isolated partition, false otherwise
+ */
+bool cpuset_cpu_is_isolated(int cpu)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&isolcpus_seq);
+		ret = cpumask_test_cpu(cpu, isolated_cpus);
+	} while (read_seqcount_retry(&isolcpus_seq, seq));
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
+
 /*
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
-- 
2.39.3

