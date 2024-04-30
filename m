Return-Path: <linux-kernel+bounces-163644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8868B6E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DE21F23422
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF34142904;
	Tue, 30 Apr 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/wWb3vv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11614265E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468714; cv=none; b=gz/F3+6SZrKBS/54437HirSAXbhuJpIRrZSyoV0fdLa1JS6HZkEt7AMZPoNZJE97YoRxT7oRZ++t0qnseaFe/f2TYiyOa3tW6ACgMfnhSoR6v3SRjVM8y0heVKMt/PLclu8iPgYNqfNqwxH0Hqxbv+4LSR0VbupTTGNjlnL+MKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468714; c=relaxed/simple;
	bh=+JBBnsVXW1yETIF62J+k2tb+dskhEhdRmII/3jXkznY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzngcrvmzC1TLCKZNNXhyy1GQ1jEWbxc0M0d2SdI/qOHcsLrqETbSoV2zkWCKNkds2CKtKpQNNOUrJiw8g6winyZZWwiNZqYIw+3s8WEZ0Us9n2Jev7X+hiAHmHV9P29uStqmKtxYmY3iAP8+TllrgWIQbRWNq8MoXSL5p33a8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/wWb3vv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZDSvTcBIbMPTAgzpicF94RIF10BBxppzDWPRpbYqWU=;
	b=Z/wWb3vvwH1zx23ghKLXZRTLHhNrlsxZzcfYaCVgRosQrH5yoZzyyj5uB3MvGIMG0xZehW
	SINE3tmEu/lVihkDNfvelcxAKEispiu4ZH+077ReLudlfm+tpsF7r941VwKHUnC5UMM4a5
	rTJcHMupmWhplO7vkByFvu+VPMuhFLQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-WTiR5tc5P3agvZjFcy4x2A-1; Tue,
 30 Apr 2024 05:18:26 -0400
X-MC-Unique: WTiR5tc5P3agvZjFcy4x2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA2823C02525;
	Tue, 30 Apr 2024 09:18:25 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0F440C5C3;
	Tue, 30 Apr 2024 09:18:23 +0000 (UTC)
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
Subject: [PATCH v2 07/27] context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
Date: Tue, 30 Apr 2024 11:17:11 +0200
Message-ID: <20240430091740.1826862-8-vschneid@redhat.com>
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

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/context_tracking_state.h |  2 +-
 kernel/context_tracking.c              | 10 +++++-----
 kernel/rcu/tree.c                      |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 65290e7677e6c..586c1ff22c2e9 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -75,7 +75,7 @@ static __always_inline int ct_rcu_watching_cpu_acquire(int cpu)
 	return atomic_read_acquire(&ct->state) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline long ct_dynticks_nesting(void)
+static __always_inline long ct_nesting(void)
 {
 	return __this_cpu_read(context_tracking.nesting);
 }
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index ddf9cfa58039f..596aa4079c51e 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -128,8 +128,8 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
 	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     ct_dynticks_nesting() == 0);
-	if (ct_dynticks_nesting() != 1) {
+		     ct_nesting() == 0);
+	if (ct_nesting() != 1) {
 		// RCU will still be watching, so just do accounting and leave.
 		ct->nesting--;
 		return;
@@ -137,7 +137,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
 
 	instrumentation_begin();
 	lockdep_assert_irqs_disabled();
-	trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("Start"), ct_nesting(), 0, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_preempt_deferred_qs(current);
 
@@ -166,7 +166,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	long oldval;
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	oldval = ct_dynticks_nesting();
+	oldval = ct_nesting();
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
 		// RCU was already watching, so just do accounting and leave.
@@ -182,7 +182,7 @@ static void noinstr ct_kernel_enter(bool user, int offset)
 	// instrumentation for the noinstr ct_kernel_enter_state()
 	instrument_atomic_write(&ct->state, sizeof(ct->state));
 
-	trace_rcu_dyntick(TPS("End"), ct_dynticks_nesting(), 1, ct_rcu_watching());
+	trace_rcu_dyntick(TPS("End"), ct_nesting(), 1, ct_rcu_watching());
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(ct->nesting, 1);
 	WARN_ON_ONCE(ct_dynticks_nmi_nesting());
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7f3fa9bb34e92..9fe3dcc504777 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -387,7 +387,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() < 0,
+	RCU_LOCKDEP_WARN(ct_nesting() < 0,
 			 "RCU nesting counter underflow!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
@@ -403,7 +403,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	WARN_ON_ONCE(!nesting && !is_idle_task(current));
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
-	return ct_dynticks_nesting() == 0;
+	return ct_nesting() == 0;
 }
 
 #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
@@ -595,7 +595,7 @@ void rcu_irq_exit_check_preempt(void)
 {
 	lockdep_assert_irqs_disabled();
 
-	RCU_LOCKDEP_WARN(ct_dynticks_nesting() <= 0,
+	RCU_LOCKDEP_WARN(ct_nesting() <= 0,
 			 "RCU nesting counter underflow/zero!");
 	RCU_LOCKDEP_WARN(ct_dynticks_nmi_nesting() !=
 			 DYNTICK_IRQ_NONIDLE,
-- 
2.43.0


