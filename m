Return-Path: <linux-kernel+bounces-163666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CB98B6E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD111C22BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05561C689D;
	Tue, 30 Apr 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTKCEpBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E721C688A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468756; cv=none; b=PO/LtvM2BWimogiyA+PqmFIJiDJSR/BCFrBb1XypMRVvrGSZyr1riZ5VUqGBNdHZnerLVUwk2IyIstAvX6UHyiZjZ2nIeVbzrAHXyTmnldep7y8Zbca48X+kw4a9OEAowXP3Rf7GdQ+UkL8IlR4ZVBI7kEdtuyNgqxOVzgwnqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468756; c=relaxed/simple;
	bh=DfCPd4Sm9LK7oXDquhiPePSRCrvD2nPKphDjMObon5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQt/L9QEYha6ZUARsolZ3aZ0SAXGirxzZIfPR9dK7DzWKa50ghCQskYV1f2474vjldeFrIwZyll+cpErIBAd3i6Qdy+ZgAXA7WHQNcUEOTzciEqPlamKZ0SKwJUOh4glCA9ksOVaTjxN3ZLxvx1SnoLQ9rXpxRVOips3vrIjC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTKCEpBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/OW8PJUv2MdPGe6JPUa5g7O0zHRLkmoFwJKzdUpl6c=;
	b=hTKCEpBuGZ2KYRnPPS9ug3FOR668f/oLN1Etf7330a/xRX2IhvpRtlAEEdf+DwM/OA9/aX
	TUsI3kcqu3EfjVR+OiDozbzpgYy1Z7UjzOtpMoxdMTtlZYVklckLrGfxXITZroZYrYm4Sq
	C6uE6qeZrMBWqsuzxU88y3lp6aCoDfg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-YoU6loPMNMuK3nsvHyiSCA-1; Tue,
 30 Apr 2024 05:19:07 -0400
X-MC-Unique: YoU6loPMNMuK3nsvHyiSCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6AE03C0252D;
	Tue, 30 Apr 2024 09:19:05 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4880740C5C3;
	Tue, 30 Apr 2024 09:19:03 +0000 (UTC)
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
Subject: [PATCH v2 21/27] rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
Date: Tue, 30 Apr 2024 11:17:25 +0200
Message-ID: <20240430091740.1826862-22-vschneid@redhat.com>
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
RCU_WATCHING, and the snapshot helpers are now prefix by
"rcu_watching". Reflect that change into the storage variables for these
snapshots.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/rcu/tree.h     | 2 +-
 kernel/rcu/tree_exp.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index ac153e365355d..d0d6f46f12871 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -215,7 +215,7 @@ struct rcu_data {
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	unsigned long barrier_seq_snap;	/* Snap of rcu_state.barrier_sequence. */
 	struct rcu_head barrier_head;
-	int exp_dynticks_snap;		/* Double-check need for IPI. */
+	int exp_watching_snap;		/* Double-check need for IPI. */
 
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 4046fae99517e..d1b80ed7c3d65 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -361,7 +361,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 			if (rcu_watching_in_eqs(snap))
 				mask_ofl_test |= mask;
 			else
-				rdp->exp_dynticks_snap = snap;
+				rdp->exp_watching_snap = snap;
 		}
 	}
 	mask_ofl_ipi = rnp->expmask & ~mask_ofl_test;
@@ -381,7 +381,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_watching_changed_since(rdp, rdp->exp_dynticks_snap)) {
+		if (rcu_watching_changed_since(rdp, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}
-- 
2.43.0


