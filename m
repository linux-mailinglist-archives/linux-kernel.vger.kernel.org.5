Return-Path: <linux-kernel+bounces-163641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28948B6E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A83B22761
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FD12A144;
	Tue, 30 Apr 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSQiedJw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36712839B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468707; cv=none; b=NVQly9KQ1DnbFqwR9pFlRFkhK5KXJkirDD5+7+7USrIklkHFgcYJNAhIYgJaRn3Z/SKC+jJ4jtRYvtV3qEZMTAGszgHKK27J9hXl5uUXBVJlYhFByljYGk3R7G4mKZ0iOMkZgpv1D08WtprHoXekUme4S+/DUbSme2i3AnMIcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468707; c=relaxed/simple;
	bh=N4/h9ZnmRMGmIywRYRmyoGAk35G62X23wyiU70evxck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkcV7GnQYdwsjelF1jxTATEfvzX8uY5bMlb1OJ0ht/Lf6pxQHwU71kIu+OrjA4JMK1bZmHTOUlK8pHdI7tRX8dnY6HtKE2I8y4gdHS/ZCzM6+B9lyoONHur+1sBVQQEL2DN61BRuY00PeHjBQ2W3U7JG2AdXlojYM2M6BI9VXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSQiedJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhl2Ax5N8DRE4xjW6V6nfiYXNleFGEMe0JLCiGqZosE=;
	b=KSQiedJw6paGDaay+HF9FLnBqdqqKCSIFFPVy/zsoxOi6OMiMrRW6GMWqM753G3GAU0d4o
	vGu7nfLbmuIfe9CD7aXeAP1OqN3psQGUI5Ax9HHmJ9AY53CGvxePlP8o1LcAxXP36Q0Prh
	cyD1zccZOmRJuxykFBp4DdnoNozNA2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-G1Cd1T99PQWDPIzgnw_xAA-1; Tue, 30 Apr 2024 05:18:18 -0400
X-MC-Unique: G1Cd1T99PQWDPIzgnw_xAA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86EA1800CA2;
	Tue, 30 Apr 2024 09:18:17 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B1EB492BC7;
	Tue, 30 Apr 2024 09:18:15 +0000 (UTC)
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
Subject: [PATCH v2 04/27] context_tracking, rcu: Rename ct_dynticks_cpu() into ct_rcu_watching_cpu()
Date: Tue, 30 Apr 2024 11:17:08 +0200
Message-ID: <20240430091740.1826862-5-vschneid@redhat.com>
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
 include/linux/context_tracking_state.h | 2 +-
 kernel/rcu/tree.c                      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index cb90d8c178104..ad5a06a42b4a0 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -61,7 +61,7 @@ static __always_inline int ct_rcu_watching(void)
 	return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_RCU_WATCHING_MASK;
 }
 
-static __always_inline int ct_dynticks_cpu(int cpu)
+static __always_inline int ct_rcu_watching_cpu(int cpu)
 {
 	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index db64f092428dd..e4295d040cc9b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -334,14 +334,14 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = ct_dynticks_cpu(cpu) & ~CT_RCU_WATCHING;
+	snap = ct_rcu_watching_cpu(cpu) & ~CT_RCU_WATCHING;
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
 		return false;  // Non-zero, so report failure;
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == ct_dynticks_cpu(cpu);
+	return snap == ct_rcu_watching_cpu(cpu);
 }
 
 /*
-- 
2.43.0


