Return-Path: <linux-kernel+bounces-29222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA1830B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645B128C8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF42224DA;
	Wed, 17 Jan 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSwJw1Vu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BF208AF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509373; cv=none; b=JW9bw4tdtB8l/D80YFC8oMPKJF/+9DB1OGA0rBmvyIJD26W7m7mxLtuAsimbL3wG5VLFr4oCz9OIzzprl2a29yZ7xeE6+yHzUUYTMvg/SuIfmu31HcJwGoUWseYyz54rbwUE4bQM0s3GXIbGN1nBhKvKM8ULTrwPIpjMiIYqcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509373; c=relaxed/simple;
	bh=+9dhGREDar7JnxPjUNvDr3ukqeiS2D+HMIM215GKB3o=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By; b=qa8zXbCCKNCWn27Hu9uXmtfAFhNCUGYM6v22SZnY35jg74HZFrZgLGrMAti6doqz/WGHvpfDH0gfniKG7/apU9UUwn/6hKfQaDDycwqYilFjg7qXqaUT5Prq7dWGLmkkNa9lK/jrVLHcMuQCa4AqU+zc2NiwgYzAF7sh+Qt/DHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSwJw1Vu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705509371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvHDvVh6wugcYdMxmpgUJ/MFh5amT/B96L0R0KTNtzk=;
	b=PSwJw1VuAZVaq/OfCcgClhl2B2DITBSh3Kv2ctq9ED6m1TIzI/MnC4savNOIljCJKfH0UF
	VTelIHQGkETiV8WxfGMeQIlizJOhuHQbvIBV2Ex5LuC2CMtSYEKtBsJY6DZ6QsFnvkNzNS
	rWT/smlaxB3BkYhIuB6UAdBi2l3zEzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-xwCFczkROcG7hczghk4wLg-1; Wed, 17 Jan 2024 11:36:07 -0500
X-MC-Unique: xwCFczkROcG7hczghk4wLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E6E782A6C6;
	Wed, 17 Jan 2024 16:36:06 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9285111E402;
	Wed, 17 Jan 2024 16:36:04 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 1/8] rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
Date: Wed, 17 Jan 2024 11:35:04 -0500
Message-Id: <20240117163511.88173-2-longman@redhat.com>
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Frederic Weisbecker <frederic@kernel.org>

Currently the interface to toggle callbacks offloading state only takes
a single CPU per call. Now driving RCU NOCB through cpusets requires
to be able to change the offloading state of a whole set of CPUs.

To make it easier, extend the (de-)offloading interface to support a
cpumask.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/rcupdate.h |   9 ++--
 kernel/rcu/rcutorture.c  |   4 +-
 kernel/rcu/tree_nocb.h   | 102 ++++++++++++++++++++++++++-------------
 3 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b663..b649344075d2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -142,13 +142,14 @@ static inline void rcu_irq_work_resched(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
-int rcu_nocb_cpu_offload(int cpu);
-int rcu_nocb_cpu_deoffload(int cpu);
+int rcu_nocb_cpumask_update(const struct cpumask *cpumask, bool offload);
 void rcu_nocb_flush_deferred_wakeup(void);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
-static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
-static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
+static inline int rcu_nocb_cpumask_update(const struct cpumask *cpumask, bool offload)
+{
+	return -EINVAL;
+}
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7567ca8e743c..228a5488eb5e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2140,10 +2140,10 @@ static int rcu_nocb_toggle(void *arg)
 		r = torture_random(&rand);
 		cpu = (r >> 1) % (maxcpu + 1);
 		if (r & 0x1) {
-			rcu_nocb_cpu_offload(cpu);
+			rcu_nocb_cpumask_update(cpumask_of(cpu), true);
 			atomic_long_inc(&n_nocb_offload);
 		} else {
-			rcu_nocb_cpu_deoffload(cpu);
+			rcu_nocb_cpumask_update(cpumask_of(cpu), false);
 			atomic_long_inc(&n_nocb_deoffload);
 		}
 		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4efbf7333d4e..60b0a15ed6e2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1203,29 +1203,23 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	return 0;
 }
 
-int rcu_nocb_cpu_deoffload(int cpu)
+static int rcu_nocb_cpu_deoffload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	cpus_read_lock();
-	mutex_lock(&rcu_state.barrier_mutex);
-	if (rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
-			if (!ret)
-				cpumask_clear_cpu(cpu, rcu_nocb_mask);
-		} else {
-			pr_info("NOCB: Cannot CB-deoffload offline CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
-		}
-	}
-	mutex_unlock(&rcu_state.barrier_mutex);
-	cpus_read_unlock();
+	if (cpu_is_offline(cpu))
+		return -EINVAL;
+
+	if (!rcu_rdp_is_offloaded(rdp))
+		return 0;
+
+	ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+	if (!ret)
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
 static long rcu_nocb_rdp_offload(void *arg)
 {
@@ -1236,12 +1230,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
-	/*
-	 * For now we only support re-offload, ie: the rdp must have been
-	 * offloaded on boot first.
-	 */
-	if (!rdp->nocb_gp_rdp)
-		return -EINVAL;
 
 	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
 		return -EINVAL;
@@ -1288,29 +1276,77 @@ static long rcu_nocb_rdp_offload(void *arg)
 	return 0;
 }
 
-int rcu_nocb_cpu_offload(int cpu)
+static int rcu_nocb_cpu_offload(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	int ret = 0;
+	int ret;
+
+	if (cpu_is_offline(cpu))
+		return -EINVAL;
+
+	if (rcu_rdp_is_offloaded(rdp))
+		return 0;
+
+	ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+	if (!ret)
+		cpumask_set_cpu(cpu, rcu_nocb_mask);
+
+	return ret;
+}
+
+int rcu_nocb_cpumask_update(const struct cpumask *cpumask, bool offload)
+{
+	int cpu;
+	int err = 0;
+	int err_cpu;
+	cpumask_var_t saved_nocb_mask;
+
+	if (!alloc_cpumask_var(&saved_nocb_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(saved_nocb_mask, rcu_nocb_mask);
 
 	cpus_read_lock();
 	mutex_lock(&rcu_state.barrier_mutex);
-	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
-			if (!ret)
-				cpumask_set_cpu(cpu, rcu_nocb_mask);
+	for_each_cpu(cpu, cpumask) {
+		if (offload) {
+			err = rcu_nocb_cpu_offload(cpu);
+			if (err < 0) {
+				err_cpu = cpu;
+				pr_err("NOCB: offload cpu %d failed (%d)\n", cpu, err);
+				break;
+			}
 		} else {
-			pr_info("NOCB: Cannot CB-offload offline CPU %d\n", rdp->cpu);
-			ret = -EINVAL;
+			err = rcu_nocb_cpu_deoffload(cpu);
+			if (err < 0) {
+				err_cpu = cpu;
+				pr_err("NOCB: deoffload cpu %d failed (%d)\n", cpu, err);
+				break;
+			}
+		}
+	}
+
+	/* Rollback in case of error */
+	if (err < 0) {
+		err_cpu = cpu;
+		for_each_cpu(cpu, cpumask) {
+			if (err_cpu == cpu)
+				break;
+			if (cpumask_test_cpu(cpu, saved_nocb_mask))
+				WARN_ON_ONCE(rcu_nocb_cpu_offload(cpu));
+			else
+				WARN_ON_ONCE(rcu_nocb_cpu_deoffload(cpu));
 		}
 	}
+
 	mutex_unlock(&rcu_state.barrier_mutex);
 	cpus_read_unlock();
 
-	return ret;
+	free_cpumask_var(saved_nocb_mask);
+
+	return err;
 }
-EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
+EXPORT_SYMBOL_GPL(rcu_nocb_cpumask_update);
 
 #ifdef CONFIG_RCU_LAZY
 static unsigned long
-- 
2.39.3


