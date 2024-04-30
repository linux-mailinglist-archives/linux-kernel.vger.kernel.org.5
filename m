Return-Path: <linux-kernel+bounces-163662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8BC8B6E24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098051C227B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAE91C232A;
	Tue, 30 Apr 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpAzqcvH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46648129A78
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468748; cv=none; b=PzX9l+0l5jDiVphQ6JVxjQe3mCC9XG/qVw+qSPrJkVRjG/4oqHd1LzPiEguvy2T9Uv4QyMDftG4S1AygXSDTkKg5iuuixdF0z4uRksoSeySncytJ7B9TcOcVINz2q0pmgCddyTMDLDFLyZb841IErTxBlINIe//KJwrkUpy32tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468748; c=relaxed/simple;
	bh=pI93azUTfm0jVXFOCYNtFoJdMEXa1fKEn47DRkBcfNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOonoXesjdDlNPbEU1q09XoFE71WmWDNRBhathw4o9MaJuHx3VBBEdGD2o0GwUS+BAkVUb38w+XbxypUiAY88GWfWz4/tlKm7wjy4NfEuKzzxhUDLSXm8f78vbUKgczN7e5C+bIEGb5Ny+zxdZ9C58KF0u/hgrHTIkVEgW2/H1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpAzqcvH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZrGeOnL2x3xIe2h4ybjWst5DkuDwK8OYAdVHQUiGNU=;
	b=bpAzqcvHEnzJZn3rsXtgRmx2O3AslDW4EVROtj9ltXTnmxKejvSA9zKcHAr/JcwSRtgEll
	xa70fo038SC9RTFIBNgXJnvyDd2B1gq4HngZ9aZyLLW8y/FDYRML+Jio8w3F7hZ+zQAKKh
	a7DqD42ungbxBf381bCZ0TUqbKdh78U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sCkQavtBO52uaAvaJuf5bg-1; Tue, 30 Apr 2024 05:19:00 -0400
X-MC-Unique: sCkQavtBO52uaAvaJuf5bg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CDFF88E924;
	Tue, 30 Apr 2024 09:19:00 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 321CF40C5C3;
	Tue, 30 Apr 2024 09:18:57 +0000 (UTC)
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
Subject: [PATCH v2 19/27] rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
Date: Tue, 30 Apr 2024 11:17:23 +0200
Message-ID: <20240430091740.1826862-20-vschneid@redhat.com>
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
 kernel/rcu/rcu.h   | 4 ++--
 kernel/rcu/tasks.h | 2 +-
 kernel/rcu/tree.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61a..5564402af4cbd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -606,7 +606,7 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 #endif
 
 #ifdef CONFIG_TINY_RCU
-static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -619,7 +619,7 @@ static inline void rcu_fwd_progress_check(unsigned long j) { }
 static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e1bf33018e6d5..2a1474c9aaa7d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1623,7 +1623,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 		// However, we cannot safely change its state.
 		n_heavy_reader_attempts++;
 		// Check for "running" idle tasks on offline CPUs.
-		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+		if (!rcu_watching_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return -EINVAL; // No quiescent state, do it the hard way.
 		n_heavy_reader_updates++;
 		nesting = 0;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ffcde8203c04f..d3f3a049904fc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -329,7 +329,7 @@ static bool rcu_watching_changed_since(struct rcu_data *rdp, int snap)
  * Return true if the referenced integer is zero while the specified
  * CPU remains within a single extended quiescent state.
  */
-bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+bool rcu_watching_zero_in_eqs(int cpu, int *vp)
 {
 	int snap;
 
-- 
2.43.0


