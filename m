Return-Path: <linux-kernel+bounces-163657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F58B6E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1733A1F21FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B21BF6DF;
	Tue, 30 Apr 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+Bl4Hd/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68891BED6D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468735; cv=none; b=a/ORxvEaDLaz1J6JT2hKzgV9OMmqpmRla0sF7Ci7W8yez9wh5ozid1RhiAh6+nLGQDBQ6vLF0iv17bKHRwHpXZjRzgiMCjCKYlWDlj3SmfyHU9W2xTdeM2eaKfOeZ0blA1WZqDgDy7RcFv+Y8ubbNUFeoqgSVmk8oelz1ufsYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468735; c=relaxed/simple;
	bh=pXYuBf/no3D++5JfAuxUjhyr9k0cvSL2Fvh5M9LRvfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+p4hWKJhn5uZQ06MmCFbn10+SIMrCzjOM7QVfVUVgK57FG8Nxw3qBfnnGnTW+8G2WVdY7VQSw2UcSjbFIMwwJx3pfTrnQQPdIqxT6bIMY73C0/JKaaNPOhcagD0vqftrhX73NdK6IfqUnPAhEilli94VCTq6TrAgus31k/c96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+Bl4Hd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Acnvg5m0QI7jC0qpMYe1ycEQuPijsttmR1AejYIGro=;
	b=Z+Bl4Hd/UoSOUnn6tiRCpc4XSvnorsHzXcnN26RA5+COA/7Dlgu3s+vogilL1TAxynrr/v
	IZa2+PYLOa0vfDgFzhlFWhzMwqYK6OB7oxqvNDj6HfX7PcPsIvsaxT4zgbrl9ZIXLfZZso
	vwntFOKmpNsaLSasA/v/HAnw7jWKSaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-upcu8rZ-O5C6VeIGzzUM_A-1; Tue, 30 Apr 2024 05:18:48 -0400
X-MC-Unique: upcu8rZ-O5C6VeIGzzUM_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5AA78032FA;
	Tue, 30 Apr 2024 09:18:47 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D77A492BC7;
	Tue, 30 Apr 2024 09:18:45 +0000 (UTC)
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
Subject: [PATCH v2 15/27] rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_eqs_online()
Date: Tue, 30 Apr 2024 11:17:19 +0200
Message-ID: <20240430091740.1826862-16-vschneid@redhat.com>
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
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bb0d9dd8b6d3a..fe2beb7d2e82d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -280,7 +280,7 @@ void rcu_softirq_qs(void)
 }
 
 /*
- * Reset the current CPU's ->dynticks counter to indicate that the
+ * Reset the current CPU's RCU_WATCHING counter to indicate that the
  * newly onlined CPU is no longer in an extended quiescent state.
  * This will either leave the counter unchanged, or increment it
  * to the next non-quiescent value.
@@ -289,7 +289,7 @@ void rcu_softirq_qs(void)
  * of the ->dynticks counter are manipulated only by the corresponding CPU,
  * or when the corresponding CPU is offline.
  */
-static void rcu_dynticks_eqs_online(void)
+static void rcu_watching_eqs_online(void)
 {
 	if (ct_rcu_watching() & CT_RCU_WATCHING)
 		return;
@@ -5051,7 +5051,7 @@ void rcutree_report_cpu_starting(unsigned int cpu)
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
 	arch_spin_lock(&rcu_state.ofl_lock);
-	rcu_dynticks_eqs_online();
+	rcu_watching_eqs_online();
 	raw_spin_lock(&rcu_state.barrier_lock);
 	raw_spin_lock_rcu_node(rnp);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-- 
2.43.0


