Return-Path: <linux-kernel+bounces-163661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53148B6E23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFD1C22C67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9AB129E81;
	Tue, 30 Apr 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7S5c29c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9A128386
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468747; cv=none; b=PUblx4vgnR9RsrbGiAnzLeD9ZiQaPjfSGCELNmB5oB5QGHzgAm8Y47wul6iW3CdMWWqm+CoXBg6/BtBh9wRYBQcxEaFP3uKoThelBCNIUprBDck+0RZSK3sdX2qqRv7phS/6n/qGg9XK7HcZjE7nxHvvw0PZjWqYd9LWqNMhsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468747; c=relaxed/simple;
	bh=BsJk+liTzIzW69boAdwlOQV0R2xJ8wtypfxZk2CcWdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVFWFzZeV7uCvDI+Iss84oXBskCRSz7tsz8Rmor08lxCoa+tPm2d4V4zdGgBCtyWDvR1fwoDh4UyEaiT1Ng8O9nl3SA7x7afEd6mvbncZ+pysD53ACmmQbmWMNFYZCZUqQ/vdeqEM5Qjcc0HpvJKxsFqNLuk3UKzqdScdBFKm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7S5c29c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6tazCG65QB+fPDOoSPBMWm4LU9sDgor8juKoVvi5V8I=;
	b=f7S5c29cKVwj6q9lA8Zh1wYgIws7YZd/d1xeudiUf82E1496UJ8D3+nblB4l+RKvmdH9Cm
	DMzbgPACrc1kg08kCLXIBSp25P7jx8USFPSvZQmWqwp5VReYHuz6BsZ9g9Hw3SfB63eFQU
	Ku2uOASZ5UFP/ZkZVN4wr7XaUPhKYNY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-yFJlcC9CM0Ocls4lEBT9MA-1; Tue,
 30 Apr 2024 05:18:57 -0400
X-MC-Unique: yFJlcC9CM0Ocls4lEBT9MA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5FB229ABA10;
	Tue, 30 Apr 2024 09:18:56 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2BB40C5C2;
	Tue, 30 Apr 2024 09:18:54 +0000 (UTC)
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
Subject: [PATCH v2 18/27] rcu: Rename rcu_dynticks_in_eqs_since() into rcu_watching_changed_since()
Date: Tue, 30 Apr 2024 11:17:22 +0200
Message-ID: <20240430091740.1826862-19-vschneid@redhat.com>
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
RCU_WATCHING, the dynticks prefix can go.

Furthermore, the "in_eqs_since" part confuses me, as IIUC this only checks
for a change in watching/eqs state, not that RCU transitionned *into* a
EQS after the snapshot was taken.

e.g. if
  snap = 0b1000 (EQS)
and the following rcu_watching_snap(CPU) is:
	 0b1100 (watching)
then
  rcu_watching_in_eqs_since(rdp, snap) -> true

but because RCU was already in EQS at the time of the
snap - it hasn't entered EQS "since" the snap was taken.

Update the name to reflect that we're only looking at watching/EQS
transitions, not specifically transitions into EQS.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 2 +-
 kernel/rcu/tree.c                                             | 4 ++--
 kernel/rcu/tree_exp.h                                         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index e8ef12ca1e9da..0533814a1f69a 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -150,7 +150,7 @@ This case is handled by calls to the strongly ordered
 is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
 time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
 The grace-period kthread invokes ``rcu_watching_snap()`` and
-``rcu_dynticks_in_eqs_since()`` (both of which invoke
+``rcu_watching_changed_since()`` (both of which invoke
 an ``atomic_add_return()`` of zero) to detect idle CPUs.
 
 +-----------------------------------------------------------------------+
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d772755ccd564..ffcde8203c04f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -320,7 +320,7 @@ static bool rcu_watching_in_eqs(int snap)
  * structure has spent some time in an extended quiescent state since
  * rcu_watching_snap() returned the specified snapshot.
  */
-static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
+static bool rcu_watching_changed_since(struct rcu_data *rdp, int snap)
 {
 	return snap != rcu_watching_snap(rdp->cpu);
 }
@@ -803,7 +803,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_changed_since(rdp, rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 68dea1427c8bd..4046fae99517e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -381,7 +381,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_changed_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.43.0


