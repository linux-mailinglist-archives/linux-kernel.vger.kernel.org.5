Return-Path: <linux-kernel+bounces-163670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 079AF8B6E30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01702819EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4541C9EA4;
	Tue, 30 Apr 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efIpPOdl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3721C8FB3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468762; cv=none; b=AC7y23KV4U8dLUA55flQk70zB+3M+WzbeC6+ALxUlemPwW1UZ+RNIFQSdH2VzAOCe7UAv/6nQ7A9xLZECjnEcoYW8+kOxBGmTeH+NkBQ3MzHjn4hmv4lA0uJykcN2IWyJLdboQCTt+YF5gGTuizPffdV+MQFpzO6oNX7QiNOEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468762; c=relaxed/simple;
	bh=UDpOa6uq/0wige4xYCIveLrLekZbUFVMIPs9Q8uP2/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1DJDkVqLJdkE/FPzTUfCNWHisuG5VyG9/366hwJ7vlVjjPq4R/S/0jCwMzUig5L5SlEpNVaa9T1hY3B6dIPsc99rd/QxxOv5rxImLKj92YBRYihf1dj6scf+Tsfbo7YfsBpbR2SEdhOAn7PG1oSmUy9Wi9Q5jLNZy6k4FFnqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efIpPOdl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoUWjkUm7PdXxKYHB7R0MSsQHH4nwZT+HFgfi6OrWXU=;
	b=efIpPOdljHggjYkCxmD2xy9sDwiSHkjbVg5AsmE5IdOBhjznIARY5VLjUhJZ4ukxk9a6XZ
	Q1DhS9JILxVMIlACczwLV70b17P2uN0mg/L03jfEkm9n0hvqY1vdU/R8IG+VMhRoUumwY5
	O/+CN104OGO+21qsySfOIZHa1TR4W98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-hqUChMk9PBWFLnTY8Yp-Tw-1; Tue, 30 Apr 2024 05:19:16 -0400
X-MC-Unique: hqUChMk9PBWFLnTY8Yp-Tw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1745E80B3DD;
	Tue, 30 Apr 2024 09:19:16 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F020492BC7;
	Tue, 30 Apr 2024 09:19:13 +0000 (UTC)
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
Subject: [PATCH v2 25/27] context_tracking, rcu: Rename stray ->dynticks comments
Date: Tue, 30 Apr 2024 11:17:29 +0200
Message-ID: <20240430091740.1826862-26-vschneid@redhat.com>
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

A few comments still mention a context_tracking .dynticks field, but that
has been merged into the .state field as of:

171476775d32 ("context_tracking: Convert state to atomic_t")

Update these loose references.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/context_tracking.c | 8 ++++----
 kernel/rcu/tree.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e82f19bab9ed9..dfa64f21d900d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
-	rcu_task_trace_enter();  // Before ->dynticks update!
+	rcu_task_trace_enter();  // Before CT state update!
 	seq = ct_state_inc(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
@@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 */
 	seq = ct_state_inc(offset);
 	// RCU is now watching.  Better not be in an extended quiescent state!
-	rcu_task_trace_exit();  // After ->dynticks update!
+	rcu_task_trace_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
 }
 
@@ -207,7 +207,7 @@ void noinstr ct_nmi_exit(void)
 
 	instrumentation_begin();
 	/*
-	 * Check for ->nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->nmi_nesting underflow and bad CT state.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
@@ -264,7 +264,7 @@ void noinstr ct_nmi_enter(void)
 	WARN_ON_ONCE(ct_nmi_nesting() < 0);
 
 	/*
-	 * If idle from RCU viewpoint, atomically increment ->dynticks
+	 * If idle from RCU viewpoint, atomically increment CT state
 	 * to mark non-idle and increment ->nmi_nesting by one.
 	 * Otherwise, increment ->nmi_nesting by two.  This means
 	 * if ->nmi_nesting is equal to one, we are guaranteed
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e4783a5d18e0d..11bd55f7ec398 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -286,7 +286,7 @@ void rcu_softirq_qs(void)
  * to the next non-quiescent value.
  *
  * The non-atomic test/increment sequence works because the upper bits
- * of the ->dynticks counter are manipulated only by the corresponding CPU,
+ * of the ->state variable are manipulated only by the corresponding CPU,
  * or when the corresponding CPU is offline.
  */
 static void rcu_watching_eqs_online(void)
@@ -335,10 +335,10 @@ bool rcu_watching_zero_in_eqs(int cpu, int *vp)
 
 	// If not quiescent, force back to earlier extended quiescent state.
 	snap = ct_rcu_watching_cpu(cpu) & ~CT_RCU_WATCHING;
-	smp_rmb(); // Order ->dynticks and *vp reads.
+	smp_rmb(); // Order CT state and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
-	smp_rmb(); // Order *vp read and ->dynticks re-read.
+	smp_rmb(); // Order *vp read and CT state re-read.
 
 	// If still in the same extended quiescent state, we are good!
 	return snap == ct_rcu_watching_cpu(cpu);
-- 
2.43.0


