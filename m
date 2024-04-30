Return-Path: <linux-kernel+bounces-163646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB638B6E11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E50B20DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C26199E84;
	Tue, 30 Apr 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHoE+slk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F7194C94
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468722; cv=none; b=Ei66TNI5DbNgqSKu7v8vJdImB5CCLsmWbGYSBbErqWUtRewaaTeIbT99tAkSR79Rko/LZFpzk5N1H/zkiKwrAGwla8FzjpMQE3FV3RR0JhjKQO34Ljtj4hN4WUJTdcPTuPT2CCIiifeVkXHFLoE8U228i9iK8Z7y+zE4Sics0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468722; c=relaxed/simple;
	bh=ShkN4zG8m9WO7iET+Gn4s046C9I9qaN46lYGZU9OQH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZn3VdRNa7m+8o6YiP7vhyySKRWRqfCw/HjXbBNaPP0SpHdV55+/DuLafDxg3xHr5R4AqRSqZZkp41SeUUplY6rQe6vQVbMhyBJ78/4NRecsr5BnzJ6AZyGkSYHA0Rp/wmM3cDG2NzHwAu6z1oGk8x+6+q4k6wT1V1RpZRQz2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHoE+slk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7BZ+Ee6yp7tkMterpTxffB+OrPYg8j9aGbd8sDD5Kw=;
	b=FHoE+slkSmcJfsaU62fHXpQ1QlcgWxsFaim/sm6gLnjdAVyOFVhNnLt6Wv60XGhLgToKDV
	02eEJclUuPzkUQtn0SbErLwneRPsp53oejEhV0+vm587HZP6aK+BIhJeh/lpzPeo7wjMEC
	Pltq1D+VvMNaoGxZcc1USYCBt+BQPqY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-nWcPhraOPhqA4cejc3082A-1; Tue,
 30 Apr 2024 05:18:35 -0400
X-MC-Unique: nWcPhraOPhqA4cejc3082A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 478CE3806738;
	Tue, 30 Apr 2024 09:18:34 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F19477F82;
	Tue, 30 Apr 2024 09:18:32 +0000 (UTC)
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
Subject: [PATCH v2 10/27] context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into ct_nmi_nesting()
Date: Tue, 30 Apr 2024 11:17:14 +0200
Message-ID: <20240430091740.1826862-11-vschneid@redhat.com>
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
RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
meaning.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 22 +++++++++++-----------
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 12d00adf29e1e..8f32fe599c5c0 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -87,7 +87,7 @@ static __always_inline long ct_nesting_cpu(int cpu)
 	return ct->nesting;
 }
 
-static __always_inline long ct_dynticks_nmi_nesting(void)
+static __always_inline long ct_nmi_nesting(void)
 {
 	return __this_cpu_read(context_tracking.nmi_nesting);
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 7fa2f8cfc7431..19e3e0e30a9b2 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -125,7 +125,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
+	WARN_ON_ONCE(ct_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(ct->nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     ct_nesting() == 0);
@@ -185,7 +185,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
+	WARN_ON_ONCE(ct_nmi_nesting());
 	WRITE_ONCE(ct->nmi_nesting, DYNTICK_IRQ_NONIDLE);
 	instrumentation_end();
 }
@@ -211,24 +211,24 @@ void noinstr ct_nmi_exit(void)
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() <= 0);
+	WARN_ON_ONCE(ct_nmi_nesting() <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (ct_dynticks_nmi_nesting() != 1) {
-		trace_rcu_dyntick(TPS("--="), ct_dynticks_nmi_nesting(), ct_dynticks_nmi_nesting() - 2,
+	if (ct_nmi_nesting() != 1) {
+		trace_rcu_dyntick(TPS("--="), ct_nmi_nesting(), ct_nmi_nesting() - 2,
 				  ct_rcu_watching());
 		WRITE_ONCE(ct->nmi_nesting, /* No store tearing. */
-			   ct_dynticks_nmi_nesting() - 2);
+			   ct_nmi_nesting() - 2);
 		instrumentation_end();
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), ct_dynticks_nmi_nesting(), 0, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("Startirq"), ct_nmi_nesting(), 0, ct_rcu_watching());
 	WRITE_ONCE(ct->nmi_nesting, 0); /* Avoid store tearing. */
 
 	// instrumentation for the noinstr ct_kernel_exit_state()
@@ -261,7 +261,7 @@ void noinstr ct_nmi_enter(void)
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(ct_dynticks_nmi_nesting() < 0);
+	WARN_ON_ONCE(ct_nmi_nesting() < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment ->dynticks
@@ -295,11 +295,11 @@ void noinstr ct_nmi_enter(void)
 	}
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  ct_dynticks_nmi_nesting(),
-			  ct_dynticks_nmi_nesting() + incby, ct_rcu_watching());
+			  ct_nmi_nesting(),
+			  ct_nmi_nesting() + incby, ct_rcu_watching());
 	instrumentation_end();
 	WRITE_ONCE(ct->nmi_nesting, /* Prevent store tearing. */
-		   ct_dynticks_nmi_nesting() + incby);
+		   ct_nmi_nesting() + incby);
 	barrier();
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c797a386a84af..f5b1d83cdef85 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -389,11 +389,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
-	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
+	RCU_LOCKDEP_WARN(ct_nmi_nesting() <= 0,
 			 "RCU nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
-	nesting = ct_dynticks_nmi_nesting();
+	nesting = ct_nmi_nesting();
 	if (nesting > 1)
 		return false;
 
@@ -597,7 +597,7 @@ void rcu_irq_exit_check_preempt(void)
 
 	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
+	RCU_LOCKDEP_WARN(ct_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
 			 "Bad RCU  nmi_nesting counter\n");
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
-- 
2.43.0


