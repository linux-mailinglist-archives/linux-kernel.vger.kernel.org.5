Return-Path: <linux-kernel+bounces-163663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931988B6E25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B143E1C22BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC81C65E9;
	Tue, 30 Apr 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hmw+/hZv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD8129E7A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468750; cv=none; b=nus1F9FPjvOVHIxBeA5+CoOEFormi9uGIJg8nPeGS25UNickq8E1WynLIJu8dA+f3/9ES1DMMY9EqgxWZvFW8qTsjeoDmNYAsh5pBN90GR1ayvWf2pw/ToBgHtNL0C26ncwLrn1u5OCY/BCICKCDwLthF9vgpxCJKBhIdyTpb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468750; c=relaxed/simple;
	bh=fBp/NmsaAPYn3Q9LmEeHWCL4r9VZ/lDm41uN7wZ/n7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjHV6Pw7ke4FXmUOkVNpZGBEBFhQD7N/AlMoIBKGA/91RV2+JllrSlPurt5U5actvl9kdS04LE3fPejj3l6XvuQgXkbRMHDnQxPA1Wnd+RunuazjQ9dXRqNk3eBqjsb6wDG/G+m5AktTqUOEZVSrVbwBnbAdSy9Xd729HsI835Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hmw+/hZv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFwfWtoBEea+wl4lNZJkfIY1AL564duSUyUuZY/5YOk=;
	b=Hmw+/hZvuKqG2X+RFQ2sumKBpiJi2HKCkrs7E2Qvmo8p/EkIP9+Le9G+jnfYY+XP/b7cki
	QcsoLP6Ddz4NLllAHPf+XF31N30Tt9XwMEAdgeUiRsdri8Ea6Fz/d00M1Xqh8YTZe0ITFp
	P06XvPKzsYxNKpGAeCMS7CcIFE6NxcI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-FFE2xNfqMduNtc734sLPnw-1; Tue,
 30 Apr 2024 05:19:03 -0400
X-MC-Unique: FFE2xNfqMduNtc734sLPnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CD691C0AF43;
	Tue, 30 Apr 2024 09:19:03 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC88492BC7;
	Tue, 30 Apr 2024 09:19:00 +0000 (UTC)
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
Subject: [PATCH v2 20/27] rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
Date: Tue, 30 Apr 2024 11:17:24 +0200
Message-ID: <20240430091740.1826862-21-vschneid@redhat.com>
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
 .../RCU/Design/Data-Structures/Data-Structures.rst          | 4 ++--
 kernel/rcu/tree.c                                           | 6 +++---
 kernel/rcu/tree.h                                           | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index 5389cc49bea13..de76c624fe93e 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -921,10 +921,10 @@ This portion of the ``rcu_data`` structure is declared as follows:
 
 ::
 
-     1   int dynticks_snap;
+     1   int watching_snap;
      2   unsigned long dynticks_fqs;
 
-The ``->dynticks_snap`` field is used to take a snapshot of the
+The ``->watching_snap`` field is used to take a snapshot of the
 corresponding CPU's dyntick-idle state when forcing quiescent states,
 and is therefore accessed from other CPUs. Finally, the
 ``->dynticks_fqs`` field is used to count the number of times this CPU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d3f3a049904fc..73b95240a1a6c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -770,8 +770,8 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
  */
 static int dyntick_save_progress_counter(struct rcu_data *rdp)
 {
-	rdp->dynticks_snap = rcu_watching_snap(rdp->cpu);
-	if (rcu_watching_in_eqs(rdp->dynticks_snap)) {
+	rdp->watching_snap = rcu_watching_snap(rdp->cpu);
+	if (rcu_watching_in_eqs(rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rdp->mynode, rdp);
 		return 1;
@@ -803,7 +803,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_watching_changed_since(rdp, rdp->dynticks_snap)) {
+	if (rcu_watching_changed_since(rdp, rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index affcb92a358c3..ac153e365355d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -206,7 +206,7 @@ struct rcu_data {
 	long		blimit;		/* Upper limit on a processed batch */
 
 	/* 3) dynticks interface. */
-	int dynticks_snap;		/* Per-GP tracking for dynticks. */
+	int  watching_snap;		/* Per-GP tracking for dynticks. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
-- 
2.43.0


