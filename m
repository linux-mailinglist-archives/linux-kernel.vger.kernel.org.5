Return-Path: <linux-kernel+bounces-163667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C148B6E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FA62818F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC1C13C66A;
	Tue, 30 Apr 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvHs21Wz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50651C6610
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468759; cv=none; b=L6KP7LzXOkAeRuJITKCLhVn81xac5nOqDw+q/SJqIo/J9ffFZPPetbLAvTGnoAITKdQZmZoSB0DYonq3vv9rR+eAb1gaSLPw9V4RKoQCHNa2pbuwAMUf+sd3eH7+vE/Fvof5MzCNKu667JXKm+cNLc03TFnQVMhxVYb9bKgJn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468759; c=relaxed/simple;
	bh=BIHnBwmbVaDUG/IadziTCuez47ce0sTjhxhkpzV8SQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2pGv4k8dECjqkf6dZ2nIVjhmfmHR9drh3Eyhu3Q0bVCo/q9rkVWkQUTYoAms/GAd5Erk/pVlUcvW8KElbMvgfLUK4p8IeT+n4oKPlcdblvfiqFHgwZDEcVJRpePzHnBNmKvYT4ZbRNojNRYdLiQ5uTHT6hvQOUeLqFD2pNeSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvHs21Wz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVvhaC/XHwMBow5A0gQUjQhCAAsLCxl8ACwwyXHU2KA=;
	b=MvHs21WznMqOpo9NTN//mW/F5gdrrG4uTxng7NryHjiGxZcJDoNeq7luOlGDqo2D7ybawB
	+dV7/SK2i9bdVHkJ6MrHfCTGMyZq+5dm40TIDpJip714+JcYpmk3Im+jGkAV/muJCsFEPG
	3OSCTThfwGOvq4Uf8Asar08rrfciLXA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-lEeFP2pQNCyNGyaTW05euw-1; Tue,
 30 Apr 2024 05:19:12 -0400
X-MC-Unique: lEeFP2pQNCyNGyaTW05euw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB83E29ABA10;
	Tue, 30 Apr 2024 09:19:10 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E5F40C5C3;
	Tue, 30 Apr 2024 09:19:08 +0000 (UTC)
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
Subject: [PATCH v2 23/27] rcu: Rename rcu_implicit_dynticks_qs() into rcu_implicit_eqs()
Date: Tue, 30 Apr 2024 11:17:27 +0200
Message-ID: <20240430091740.1826862-24-vschneid@redhat.com>
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
RCU_WATCHING, replace "dynticks_qs" into "eqs" to drop the dyntick
reference.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg      | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg | 2 +-
 kernel/rcu/tree.c                                            | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 961b2595241fe..b57210ecd689e 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -537,7 +537,7 @@
        font-style="normal"
        y="-8368.1475"
        x="2463.3262"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_implicit_eqs()</text>
   </g>
   <g
      id="g4504"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index 9a8e7d1686ce1..bd2b33e05447f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -899,7 +899,7 @@
      font-style="normal"
      y="1858.8729"
      x="4414.1836"
-     xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+     xml:space="preserve">rcu_implicit_eqs()</text>
   <text
      xml:space="preserve"
      x="14659.87"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 40e6686962de1..8ece2b559bd35 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3029,7 +3029,7 @@
        font-style="normal"
        y="38425.035"
        x="-337.79462"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_implicit_eqs()</text>
     <text
        xml:space="preserve"
        x="9907.8887"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index 14313aeb8affd..e063ff9c8ab61 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -525,7 +525,7 @@
        font-style="normal"
        y="-8368.1475"
        x="2463.3262"
-       xml:space="preserve">rcu_implicit_dynticks_qs()</text>
+       xml:space="preserve">rcu_implicit_eqs()</text>
     <text
        sodipodi:linespacing="125%"
        style="font-size:192px;font-style:normal;font-weight:bold;line-height:125%;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2037daf0298d0..b375c6006ed6b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -789,7 +789,7 @@ static int eqs_save_progress_counter(struct rcu_data *rdp)
  *
  * Returns zero otherwise.
  */
-static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
+static int rcu_implicit_eqs(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
 	int ret = 0;
@@ -1984,7 +1984,7 @@ static void rcu_gp_fqs(bool first_time)
 		force_qs_rnp(eqs_save_progress_counter);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
-		force_qs_rnp(rcu_implicit_dynticks_qs);
+		force_qs_rnp(rcu_implicit_eqs);
 	}
 	/* Clear flag to prevent immediate re-entry. */
 	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
-- 
2.43.0


