Return-Path: <linux-kernel+bounces-163659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C408B6E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92051F22082
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CA1C0DCB;
	Tue, 30 Apr 2024 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3W6h0Ig"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41471BED8D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468736; cv=none; b=RlYFNhPYP2i+Qla0PTN4UxIouQFzPGOBC/eSLnvmq/vSDw+WK5RwEjwURLJ8tfIzFhvVt3fQ2IUPiNnYSBZ2St5gYQ1iXcnww0FHO/QYDPihknKFSQCv0aI5ILQ4T90f8Z8FKvlOazUCD2nPW5Dls1aKZ1+iOK0GajSJ0gXCN1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468736; c=relaxed/simple;
	bh=U3Cy4NttbHi2BkaO4bm1GlKkF0GkSotWS5a6h24aid0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZeHnTNg8qJU17AmaNyIWbgoK3c+LP5YxS9K1VTHKsexePEMnRDh1rtSqZ8rgpl/SsN/El7rFSBBCsJdTs4jkw43XaVdc8ZJjCJnYpHjxnD9X9/bPTC8PKUR5Rzn4bi6RhPxfSngCjVU5fL4ZGixoiq+vRfhWMA5CCHo4xEUiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3W6h0Ig; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfLwZxi1mDBGY6ll5+O6iAeszW6M/8q1eCE20JHCrDo=;
	b=h3W6h0Igq1t/2MCU/3VrmBHnK35I0Edu84cB9HDVhd6gc5H3gnpRrnwgM9hP4bJmNfPiRq
	URrciwQ+95bh5HVGx26ssZu4ebJnTllRQM1szluKkrG9IIS3YI8pDB1qxf5mdoVRU3bUE9
	A4Ovqb56O+I4OqOXfgittq2sbrr/YtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-adXFX0PNPPqOo7E4cJ8GEg-1; Tue, 30 Apr 2024 05:18:51 -0400
X-MC-Unique: adXFX0PNPPqOo7E4cJ8GEg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23391104B508;
	Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 25C9840C5C2;
	Tue, 30 Apr 2024 09:18:47 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 16/27] rcu: Rename rcu_dynticks_snap() into rcu_watching_snap()
Date: Tue, 30 Apr 2024 11:17:20 +0200
Message-ID: <20240430091740.1826862-17-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../Memory-Ordering/Tree-RCU-Memory-Ordering.rst |  2 +-
 kernel/rcu/tree.c                                | 16 ++++++++--------
 kernel/rcu/tree_exp.h                            |  2 +-
 kernel/rcu/tree_stall.h                          |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 5750f125361b0..e8ef12ca1e9da 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -149,7 +149,7 @@ This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
-The grace-period kthread invokes ``rcu_dynticks_snap()`` and
+The grace-period kthread invokes ``rcu_watching_snap()`` and
 ``rcu_dynticks_in_eqs_since()`` (both of which invoke
 an ``atomic_add_return()`` of zero) to detect idle CPUs.
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fe2beb7d2e82d..857c2565efeac 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -297,17 +297,17 @@ static void rcu_watching_eqs_online(void)
 }
 
 /*
- * Snapshot the ->dynticks counter with full ordering so as to allow
+ * Snapshot the RCU_WATCHING counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
  */
-static int rcu_dynticks_snap(int cpu)
+static int rcu_watching_snap(int cpu)
 {
 	smp_mb();  // Fundamental RCU ordering guarantee.
 	return ct_rcu_watching_cpu_acquire(cpu);
 }
 
 /*
- * Return true if the snapshot returned from rcu_dynticks_snap()
+ * Return true if the snapshot returned from rcu_watching_snap()
  * indicates that RCU is in an extended quiescent state.
  */
 static bool rcu_dynticks_in_eqs(int snap)
@@ -318,11 +318,11 @@ static bool rcu_dynticks_in_eqs(int snap)
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
- * rcu_dynticks_snap() returned the specified snapshot.
+ * rcu_watching_snap() returned the specified snapshot.
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp->cpu);
+	return snap != rcu_watching_snap(rdp->cpu);
 }
 
 /*
@@ -770,7 +770,7 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
+	rdp->dynticks_snap = rcu_watching_snap(rdp->cpu);
 	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
@@ -2185,7 +2185,7 @@ static noinline void rcu_gp_cleanup(void)
 
 		// We get here either if there is no need for an
 		// additional grace period or if rcu_accelerate_cbs() has
-		// already set the RCU_GP_FLAG_INIT bit in ->gp_flags. 
+		// already set the RCU_GP_FLAG_INIT bit in ->gp_flags.
 		// So all we need to do is to clear all of the other
 		// ->gp_flags bits.
 
@@ -4798,7 +4798,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
+	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_watching_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8a1d9c8bd9f74..50ec57304c1b7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -357,7 +357,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		    !(rnp->qsmaskinitnext & mask)) {
 			mask_ofl_test |= mask;
 		} else {
-			snap = rcu_dynticks_snap(cpu);
+			snap = rcu_watching_snap(cpu);
 			if (rcu_dynticks_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 6cb346952e3e4..4fa23f9fc207f 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
+			rcu_dynticks_in_eqs(rcu_watching_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
@@ -515,7 +515,7 @@ static void print_cpu_stall_info(int cpu)
 			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
 				"!."[!delta],
 	       ticks_value, ticks_title,
-	       rcu_dynticks_snap(cpu) & 0xffff,
+	       rcu_watching_snap(cpu) & 0xffff,
 	       ct_nesting_cpu(cpu), ct_nmi_nesting_cpu(cpu),
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
-- 
2.43.0


