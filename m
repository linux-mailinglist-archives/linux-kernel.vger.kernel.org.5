Return-Path: <linux-kernel+bounces-163668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F38B6E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0675A28237A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE8C1C8FA6;
	Tue, 30 Apr 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPUTj509"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B813B2A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468759; cv=none; b=TA217X4sdp1JdJe3R9go2Oo+JE2QjXvvP893eDKBypB1gMrWSBzR2mLB68y2ppygVicTvCVHgyjJC6eH00494ZQolVLhTPF+uCEaEcIv/c8LIS7+KmZR8JkX1MzzQMkgh5LOMVZIdN5qy2j+gQkKy7tHgzrKwN4kxouMmGQ1bM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468759; c=relaxed/simple;
	bh=vlKmg6DA9wKcQv4r39yuQQ9vwNlQ/qJHYXaw/L+5ZPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is7TD9QyH7mwt18juJGm+jSHix+pMeFABIX5Z2PiiHKYsOps/o2oY3mbZe4WtTGVXlpooMadf/Ph/kdKymU2MJGKPN3qBfRUXXcdA+Otw51LBEWg39kX7t2lEyoDMP2CiH0/dEKymrePIvG3J/gKAL+4Um0ctCGxDVrv2vgnu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPUTj509; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Eya/4/g7fR+WjNOhBTd8JUBjKQiwUeiPhXDYb2fngg=;
	b=EPUTj509at9K1GnvMFvefRq48YnWOm0yBu9m+0w7VJRgOCzRftmEpw3InT3YpcSdQLy7Er
	2fVbVogL2mfdLvxxqkBFA6VBbZnUOqrDOcCNsnAsRukE5jcB6MnoCMGuPTUKIKgXkfqraJ
	lkPHvxwAXrRO+FfCgnxBUAFdmmlmWrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-ok1uK2niOk2YG8amtCYDaA-1; Tue, 30 Apr 2024 05:19:08 -0400
X-MC-Unique: ok1uK2niOk2YG8amtCYDaA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0915418065B2;
	Tue, 30 Apr 2024 09:19:08 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E2FED40C5C3;
	Tue, 30 Apr 2024 09:19:05 +0000 (UTC)
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
Subject: [PATCH v2 22/27] rcu: Rename dyntick_save_progress_counter() into eqs_save_progress_counter()
Date: Tue, 30 Apr 2024 11:17:26 +0200
Message-ID: <20240430091740.1826862-23-vschneid@redhat.com>
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

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg        | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg         | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg   | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg        | 2 +-
 kernel/rcu/tree.c                                         | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index 423df00c4df9d..961b2595241fe 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -528,7 +528,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">eqs_save_progress_counter()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index d82a77d03d8cc..9a8e7d1686ce1 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -844,7 +844,7 @@
      font-style="normal"
      y="1547.8876"
      x="4417.6396"
-     xml:space="preserve">dyntick_save_progress_counter()</text>
+     xml:space="preserve">eqs_save_progress_counter()</text>
   <g
      style="fill:none;stroke-width:0.025in"
      transform="translate(6501.9719,-10685.904)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 53e0dc2a2c793..40e6686962de1 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -2974,7 +2974,7 @@
        font-style="normal"
        y="38114.047"
        x="-334.33856"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">eqs_save_progress_counter()</text>
     <g
        style="fill:none;stroke-width:0.025in"
        transform="translate(1749.9916,25880.249)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index 4fa7506082bfe..14313aeb8affd 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -516,7 +516,7 @@
        font-style="normal"
        y="-8652.5312"
        x="2466.7822"
-       xml:space="preserve">dyntick_save_progress_counter()</text>
+       xml:space="preserve">eqs_save_progress_counter()</text>
     <text
        style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier"
        id="text202-7-2-7-2-0"
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 73b95240a1a6c..2037daf0298d0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -764,11 +764,11 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 }
 
 /*
- * Snapshot the specified CPU's dynticks counter so that we can later
+ * Snapshot the specified CPU's RCU_WATCHING counter so that we can later
  * credit them with an implicit quiescent state.  Return 1 if this CPU
  * is in dynticks idle mode, which is an extended quiescent state.
  */
-static int dyntick_save_progress_counter(struct rcu_data *rdp)
+static int eqs_save_progress_counter(struct rcu_data *rdp)
 {
 	rdp->watching_snap = rcu_watching_snap(rdp->cpu);
 	if (rcu_watching_in_eqs(rdp->watching_snap)) {
@@ -782,7 +782,7 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 /*
  * Returns positive if the specified CPU has passed through a quiescent state
  * by virtue of being in or having passed through an dynticks idle state since
- * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * the last call to eqs_save_progress_counter() for this same CPU, or by
  * virtue of having been offline.
  *
  * Returns negative if the specified CPU needs a force resched.
@@ -1981,7 +1981,7 @@ static void rcu_gp_fqs(bool first_time)
 
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
-		force_qs_rnp(dyntick_save_progress_counter);
+		force_qs_rnp(eqs_save_progress_counter);
 	} else {
 		/* Handle dyntick-idle and offline CPUs. */
 		force_qs_rnp(rcu_implicit_dynticks_qs);
-- 
2.43.0


