Return-Path: <linux-kernel+bounces-163654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247328B6E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0112284ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB81A38E4;
	Tue, 30 Apr 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJjXl+hr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAF19DF71
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468732; cv=none; b=AoNkULvBSDmaFZShz+K9lSr96vH/wsUVt9IntfPr5AlSmjh8Z5Z07bVVCbastnIB+Tw2NO7/YnXB4mqO5qTn0VcDfFMPuRbi3YWkzpsozX9ndszKnzWCI30PabqhdT6kHqPI+BdO63fDMZv749jSepcCO898tUoNGjNA19lgbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468732; c=relaxed/simple;
	bh=Pe8SeQspcQPq95W+iIrjpfycVYHkHPOSxqcBfu4GPzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTvNV6EcqGVe5xZ1gpcRXMbIwVsV7+U+TRhglbk1QoyXbpmwiByDr+G5LB5HiZZHbdX8J1XelhQegyjvCAjmPfTTvsilj6jRfjrehCGARAIp91zM7OzeIu+xY9ecRJpIgJSzzu7qPJyE+Mt5YvwMuH7lM3wQPlyAoDT427YPDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJjXl+hr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8awsJgtclw2OlTdFfSQcYC+8CDBAdIkV2xcq1bwbmE=;
	b=JJjXl+hr8JZ0dlkGKA1u/D2IraaEiOjvf5gLV8BlAJFKXHTrFeBsFv3dFYF8eKyrMvms4e
	36EIT6Lfev+lhpa+HXn4ikKxLWXCuDnzKa928P4+wc8pXb3LGm9LEyMGQP55d0qDXUOMUA
	AnsbmGsX7aGgqRvlRiTbIpWxqxk+e8M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-0GGxrRm_N9y32oiF2ibSyg-1; Tue,
 30 Apr 2024 05:18:42 -0400
X-MC-Unique: 0GGxrRm_N9y32oiF2ibSyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38C523806729;
	Tue, 30 Apr 2024 09:18:42 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FDF6492BC7;
	Tue, 30 Apr 2024 09:18:39 +0000 (UTC)
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
Subject: [PATCH v2 13/27] context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
Date: Tue, 30 Apr 2024 11:17:17 +0200
Message-ID: <20240430091740.1826862-14-vschneid@redhat.com>
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
 kernel/context_tracking.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 647939b0befd9..9c8f7b9191cd4 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(context_tracking);
 #define TPS(x)  tracepoint_string(x)
 
 /* Record the current task on dyntick-idle entry. */
-static __always_inline void rcu_dynticks_task_enter(void)
+static __always_inline void rcu_task_enter(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
@@ -47,7 +47,7 @@ static __always_inline void rcu_dynticks_task_enter(void)
 }
 
 /* Record no current task on dyntick-idle exit. */
-static __always_inline void rcu_dynticks_task_exit(void)
+static __always_inline void rcu_task_exit(void)
 {
 #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
@@ -55,7 +55,7 @@ static __always_inline void rcu_dynticks_task_exit(void)
 }
 
 /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
-static __always_inline void rcu_dynticks_task_trace_enter(void)
+static __always_inline void rcu_task_trace_enter(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -64,7 +64,7 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
 }
 
 /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
-static __always_inline void rcu_dynticks_task_trace_exit(void)
+static __always_inline void rcu_task_trace_exit(void)
 {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
@@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
+	rcu_task_trace_enter();  // Before ->dynticks update!
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
@@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 */
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
+	rcu_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
 }
 
@@ -149,7 +149,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	// RCU is watching here ...
 	ct_kernel_exit_state(offset);
 	// ... but is no longer watching here.
-	rcu_dynticks_task_enter();
+	rcu_task_enter();
 }
 
 /*
@@ -173,7 +173,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 		ct->nesting++;
 		return;
 	}
-	rcu_dynticks_task_exit();
+	rcu_task_exit();
 	// RCU is not watching here ...
 	ct_kernel_enter_state(offset);
 	// ... but is watching here.
@@ -240,7 +240,7 @@ void noinstr ct_nmi_exit(void)
 	// ... but is no longer watching here.
 
 	if (!in_nmi())
-		rcu_dynticks_task_enter();
+		rcu_task_enter();
 }
 
 /**
@@ -274,7 +274,7 @@ void noinstr ct_nmi_enter(void)
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 
 		if (!in_nmi())
-			rcu_dynticks_task_exit();
+			rcu_task_exit();
 
 		// RCU is not watching here ...
 		ct_kernel_enter_state(CT_RCU_WATCHING);
-- 
2.43.0


