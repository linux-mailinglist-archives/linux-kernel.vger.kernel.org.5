Return-Path: <linux-kernel+bounces-163660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A822E8B6E22
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63960284124
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C01C2302;
	Tue, 30 Apr 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFnUfh6P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863C1C2304
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468740; cv=none; b=j1/1DKbjn+JPcLcpt/x4ASOHJ40GlCkVBuh2+MyTSj0x7JS/WX4ukjk5rJ2uAO3qJWCfIBY6zQuBqVJt+SV5RmVyTEaBZmiRuGmV5nR4j9ASjgVPkVkPgJYNC743lba3+8SV63hBWjfXM+Aj7mj2ahqWE4+Yg34Q8Nxj9lowJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468740; c=relaxed/simple;
	bh=DYnXJHD9kJ9V1r0+3XVdouBDhuhgaU3D2u8eA1TSSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uToBjEYuHeQlLnIrTGvSsfTkCWEI1ooZ/Hk5f9gTwzhQgLx2Q+CZ7p6uPNE2HR6+ksV5sKb6gQ7uWxRoRFJiJP9i+lrNA04voF7mUBUokEUv3MM6zO1po1SbuEUnZ3OO9xMuQoahdxn91ODA4KcUyH76I1+TfidIYlY8E1e3ecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFnUfh6P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iJ+HhpR5xS1NIdRXohsDpAsZ+ySrJwbYzJ1VO+vaqM=;
	b=UFnUfh6PHGTeNolyCdDGnku477ldgC2mYG+qXkSpetBJYYRExv5uwCObK5MUf2nYndOlWs
	/rXXtBzZ31Ub8gdNVhgMa/bmc/4FpMCCZBpR4ewN43EF11UU/eHk4xgFiI6Y33SZ0cPmIP
	JM37ZlRuIXZrmdiRW0soBlzDqA66T/s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-xATXoSjZMLeETUBX2KF7LA-1; Tue,
 30 Apr 2024 05:18:55 -0400
X-MC-Unique: xATXoSjZMLeETUBX2KF7LA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 346FB1C0AF42;
	Tue, 30 Apr 2024 09:18:54 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 69271492BC7;
	Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
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
Subject: [PATCH v2 17/27] rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_in_eqs()
Date: Tue, 30 Apr 2024 11:17:21 +0200
Message-ID: <20240430091740.1826862-18-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
RCU_WATCHING, reflect that change in the related helpers.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/rcu/tree.c       | 8 ++++----
 kernel/rcu/tree_exp.h   | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 857c2565efeac..d772755ccd564 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -308,9 +308,9 @@ static int rcu_watching_snap(int cpu)
 
 /*
  * Return true if the snapshot returned from rcu_watching_snap()
- * indicates that RCU is in an extended quiescent state.
+ * indicates that RCU in an extended quiescent state (not watching).
  */
-static bool rcu_dynticks_in_eqs(int snap)
+static bool rcu_watching_in_eqs(int snap)
 {
 	return !(snap & CT_RCU_WATCHING);
 }
@@ -771,7 +771,7 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
 	rdp->dynticks_snap = rcu_watching_snap(rdp->cpu);
-	if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
+	if (rcu_watching_in_eqs(rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -4798,7 +4798,7 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(ct->nesting != 1);
-	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_watching_snap(cpu)));
+	WARN_ON_ONCE(rcu_watching_in_eqs(rcu_watching_snap(cpu)));
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_state = RCU_GP_CLEANED;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 50ec57304c1b7..68dea1427c8bd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -358,7 +358,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			mask_ofl_test |= mask;
 		} else {
 			snap = rcu_watching_snap(cpu);
-			if (rcu_dynticks_in_eqs(snap))
+			if (rcu_watching_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
 				rdp->exp_dynticks_snap = snap;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 4fa23f9fc207f..589f1be8ff921 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -501,7 +501,7 @@ static void print_cpu_stall_info(int cpu)
 	}
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
-			rcu_dynticks_in_eqs(rcu_watching_snap(cpu));
+			rcu_watching_in_eqs(rcu_watching_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		// Print signed value, as negative values indicate a probable bug.
-- 
2.43.0


