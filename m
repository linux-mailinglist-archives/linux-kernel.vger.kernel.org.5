Return-Path: <linux-kernel+bounces-163658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92A8B6E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F42284D09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6281BF6F6;
	Tue, 30 Apr 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm2ntcXt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E621BED7C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468735; cv=none; b=e0NFAOReQGSayI2raksQEJivhXdsWdFi5Uq/5/SQggs/8Nb3Xfh5CBP4woUkT8WlvYBDjM2DZC4Viv5Ii64/56Qav9XC5WyQh3DNg350ecBge8dHoMoRDeGHLvf1DSfNXfTz0mk+GSGHWqy3yRPyoiOOO7KPc5fNZoZjslQ44cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468735; c=relaxed/simple;
	bh=rdwNE4TivoWSLkLZ0FAD1O9FFZJKd8QQYOGbXyhpCkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqkf/NCzNrtwOIe+jFNgSMWZnJ1iwMXRGMed1p99ZDWZqCxq9p7nKQlLX/KACPjCKnyS2g+vD6DTT7kyq2gNmGNURuhI3no+i7mxjoR6jZQzC3oq9FKMdG1Q1XwCVfGiEicrpzmRd1CtqaHKPb+gWMFPFQlGNtxcwNmv0uMTx9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zm2ntcXt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFvEhpDaXmg9BXMihL4YArPI3eFmOuObqd6gNO/1dYU=;
	b=Zm2ntcXt7/4hf4QQ0qQwLT+CrUxmqAD6tOyHDEcjJgb46/aHkurm+iazXR7u5t5PauNkBh
	gz7NcAIJ9yz7dpivsJkAQw2oO10caTyNWv+n8SPzkuJHrn22NBZua5bpPcukSayWwTUefI
	XYmktD4x7RZ1ugcmf+ZSty7kAFt+h0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-bIDlG8WmPRyFIlnRIz9QIw-1; Tue, 30 Apr 2024 05:18:45 -0400
X-MC-Unique: bIDlG8WmPRyFIlnRIz9QIw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20437800CA2;
	Tue, 30 Apr 2024 09:18:45 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9823D477F81;
	Tue, 30 Apr 2024 09:18:42 +0000 (UTC)
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
Subject: [PATCH v2 14/27] context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into rcu_watching_curr_cpu()
Date: Tue, 30 Apr 2024 11:17:18 +0200
Message-ID: <20240430091740.1826862-15-vschneid@redhat.com>
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

Note that "watching" is the opposite of "in EQS", so the negation is lifted
out of the helper and into the callsites.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking.h | 12 ++++++++----
 kernel/context_tracking.c        |  6 +++---
 kernel/rcu/tree.c                |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index a6c36780cc3bd..d53092ffa9dba 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -113,13 +113,17 @@ extern void ct_idle_enter(void);
 extern void ct_idle_exit(void);
 
 /*
- * Is the current CPU in an extended quiescent state?
+ * Is RCU watching the current CPU (IOW, it is not in an extended quiescent state)?
+ *
+ * Note that this returns the actual boolean data (watching / not watching),
+ * whereas ct_rcu_watching() returns the RCU_WATCHING subvariable of
+ * context_tracking.state.
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+static __always_inline bool rcu_is_watching_curr_cpu(void)
 {
-	return !(raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING);
+	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING;
 }
 
 /*
@@ -140,7 +144,7 @@ static __always_inline bool warn_rcu_enter(void)
 	 * lots of the actual reporting also relies on RCU.
 	 */
 	preempt_disable_notrace();
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
+	if (!rcu_is_watching_curr_cpu()) {
 		ret = true;
 		ct_state_inc(CT_RCU_WATCHING);
 	}
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 9c8f7b9191cd4..e82f19bab9ed9 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -212,7 +212,7 @@ void noinstr ct_nmi_exit(void)
 	 * to us!)
 	 */
 	WARN_ON_ONCE(ct_nmi_nesting() <= 0);
-	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
+	WARN_ON_ONCE(!rcu_is_watching_curr_cpu());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
@@ -271,7 +271,7 @@ void noinstr ct_nmi_enter(void)
 	 * to be in the outermost NMI handler that interrupted an RCU-idle
 	 * period (observation due to Andy Lutomirski).
 	 */
-	if (rcu_dynticks_curr_cpu_in_eqs()) {
+	if (!rcu_is_watching_curr_cpu()) {
 
 		if (!in_nmi())
 			rcu_task_exit();
@@ -281,7 +281,7 @@ void noinstr ct_nmi_enter(void)
 		// ... but is watching here.
 
 		instrumentation_begin();
-		// instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
+		// instrumentation for the noinstr rcu_is_watching_curr_cpu()
 		instrument_atomic_read(&ct->state, sizeof(ct->state));
 		// instrumentation for the noinstr ct_kernel_enter_state()
 		instrument_atomic_write(&ct->state, sizeof(ct->state));
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d8f89bc573448..bb0d9dd8b6d3a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -600,7 +600,7 @@ void rcu_irq_exit_check_preempt(void)
 	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 CT_NESTING_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "RCU in extended quiescent state!");
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
@@ -640,7 +640,7 @@ void __rcu_irq_enter_check_tick(void)
 	if (in_nmi())
 		return;
 
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+	RCU_LOCKDEP_WARN(!rcu_is_watching_curr_cpu(),
 			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
 
 	if (!tick_nohz_full_cpu(rdp->cpu) ||
@@ -722,7 +722,7 @@ notrace bool rcu_is_watching(void)
 	bool ret;
 
 	preempt_disable_notrace();
-	ret = !rcu_dynticks_curr_cpu_in_eqs();
+	ret = rcu_is_watching_curr_cpu();
 	preempt_enable_notrace();
 	return ret;
 }
-- 
2.43.0


