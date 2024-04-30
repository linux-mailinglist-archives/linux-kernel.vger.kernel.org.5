Return-Path: <linux-kernel+bounces-163640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02A8B6E09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31E91C22B65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E6128387;
	Tue, 30 Apr 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0OHf3C1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C051292FF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468703; cv=none; b=HONSyfl+UYc9ju3gEzEsVe/qKBTyQMl1ufta9smLLqN+5WJiiWxqAkgb6g5uO5smcNwWb4LDWyF4x6cwhqus8dKYFEdfDywzJYI1XKgmg5zVeKs/V/CDi69AUNnzCts50lJPP18fiZMfZMtVSK6aZV4TwegXHZS1udM4Ui8zZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468703; c=relaxed/simple;
	bh=6W21K9eH/6kGr4UiCCz78lCh/I3jLdLhvQ6VLuSlWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVyscIGNDR/jsg7DjY1Ngpik9HRBwQZg7uQavW513UzMs9DOHLbLaGcoYb3tp0wP9gnfYqPR3X7d2xw3ohU2oX1MjNV1/6pFjBWQoDosDxA8JMpOSA8rRwG/925pv1Xts0hZFZr0b1rvkYV3aqRiyKy4BNadUBb11u6oWr1RgeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0OHf3C1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFlTn+/v8IRwxqNngHBcNmTXrKR+6D0bXWHVkn7P2Ec=;
	b=J0OHf3C1MSb9MUu4cpoUy/xevgDKX3drMcqf/M3tY84E+fEUvlfwfqYsaC/pdgx9RRzxgu
	xXTIc/jSAn8Xtz2wG+4ApiiFWYoVA0yd3SIEpGiVaRXnwGD3cswMYBIgf7GuBjcTM9eqyB
	Psho5NvBV+wi33lZe9GolEhplMj+Vhw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-JIKxblCvOUC1R3xYbu7TSg-1; Tue, 30 Apr 2024 05:18:15 -0400
X-MC-Unique: JIKxblCvOUC1R3xYbu7TSg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE1BC100ADE3;
	Tue, 30 Apr 2024 09:18:14 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D22D140ED37;
	Tue, 30 Apr 2024 09:18:12 +0000 (UTC)
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
Subject: [PATCH v2 03/27] context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
Date: Tue, 30 Apr 2024 11:17:07 +0200
Message-ID: <20240430091740.1826862-4-vschneid@redhat.com>
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
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 94d6a935af3be..cb90d8c178104 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -56,7 +56,7 @@ static __always_inline int __ct_state(void)
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
-static __always_inline int ct_dynticks(void)
+static __always_inline int ct_rcu_watching(void)
 {
 	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 9f009de83cc8e..738a9ff4f1f51 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
+	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	// instrumentation for the noinstr ct_kernel_enter_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
-	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_dynticks());
+	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->dynticks_nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
@@ -220,7 +220,7 @@ void noinstr ct_nmi_exit(void)
 	 */
 	if (ct_dynticks_nmi_nesting() != 1) {
 		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
-				  ct_dynticks());
+				  ct_rcu_watching());
 		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
 			   ct_dynticks_nmi_nesting() - 2);
 		instrumentation_end();
@@ -228,7 +228,7 @@ void noinstr ct_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_dynticks());
+	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_rcu_watching());
 	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
@@ -296,7 +296,7 @@ void noinstr ct_nmi_enter(void)
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  ct_dynticks_nmi_nesting(),
-			  ct_dynticks_nmi_nesting() + incby, ct_dynticks());
+			  ct_dynticks_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
 	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   ct_dynticks_nmi_nesting() + incby);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 84befc91799a3..db64f092428dd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -291,7 +291,7 @@ void rcu_softirq_qs(void)
  */
 static void rcu_dynticks_eqs_online(void)
 {
-	if (ct_dynticks() & CT_RCU_WATCHING)
+	if (ct_rcu_watching() & CT_RCU_WATCHING)
 		return;
 	ct_state_inc(CT_RCU_WATCHING);
 }
-- 
2.43.0


