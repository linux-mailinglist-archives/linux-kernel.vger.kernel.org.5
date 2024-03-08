Return-Path: <linux-kernel+bounces-97668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D64876D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D951F21FB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E73BBC6;
	Fri,  8 Mar 2024 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Vh0eXsio"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C73611E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937887; cv=none; b=pnC8Tt2VISEktfFfSfmWXYJoOEHoFu4pu4ff6Ho7GFSPtkJk9TeZ5lD9dYIyFEOeN34/lz126w3MAoPKUUTXUoGee6WBXNhU3EGuGp6K4QtktGahZDHQQgkA/mZSD/kvS/tTlX5PKPtDzdJrI4ZO16uzl4dkqINQveNSTyUX5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937887; c=relaxed/simple;
	bh=Q/dpA4EDL9DKNd657tQSSkB0gcrr3hEqFVGn6lgUnrs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4gtDd2/H/Jj9j/ZX+cqIluNP1+qYpg0hX/R4hO9ZC1MqefBZrEG77dlePT8B+5ZfPep6Tk7Zpf+N6oKNyG5v7mkV2HSLH3wxrD69mw04HR6G6UeWrrXW43MYf4vIEkkVFUltXuoMUdl/AFC2FyW2jYxIjrnWqFLSvrbzMXDPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Vh0eXsio; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6902947c507so14886226d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709937884; x=1710542684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGozGRObik8kRBqAaXDv14vyB9qXJuUjlDQ4UlEdAqY=;
        b=Vh0eXsio4QZPnTr3kIzy7UeGWLYCc4w26wLtOlwuVa6B8cFSWaaQcl5+MaHl+wHKp8
         q6mEcfyTip67af4fPMimuyjBcmXwsw/JtN1/zeXZp6MCWkxt4XKqIoD3gSHJAYtb0ANg
         /h5Q+XddKt/c88RhFRo1iK3RmLxF0nz6qHVoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937884; x=1710542684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGozGRObik8kRBqAaXDv14vyB9qXJuUjlDQ4UlEdAqY=;
        b=WKnEfyzAzYeRHacLpFOwy2MBNkGT4ROqcRyxYJfrdv/cVjAYqOavUa0pAMNWNH1Xmn
         caft2BK50HWEOL7U4kKsMF7+56Ci3GkM9O5ZgrwjdeVYxoIgoVcn4OtUAv4xSpUeJu3H
         itAgiWAb6vWT/hnRfFJMr3lStZMCA1Wia3gdOrTXYIhi3glSvAu2u+sRHbGYYQl5zuXw
         plpvlUdiVht02T6ocpDgrEhaZJmoqzWw7yMpjsPgzOy8K0rztalb5wtGm4dufpZs6bcs
         WsyOR7+oPtozExO85/HObxS4A/kWUWzCzKw6bzqKn0hcZKGXMyXUq2T5f+mPBVO5z9tD
         9AWA==
X-Gm-Message-State: AOJu0Yz+QYRg7wKB7NdObpq+i5o8T1OVbv65JoLkvibgpLyHt2lx1Nsh
	ip9edhxgmv90CBSGN2JAHxm0VePZ0ah496w6x4chgOsE4Gwwfmmvn7MwqrQymacj9z7B3lVoizz
	5
X-Google-Smtp-Source: AGHT+IEw+M//3zPkORy6vYQ+apdR177VVl0Z+YSd4BJ66C+o526aJdoXX71W9ee7sW7ili48pmMCCw==
X-Received: by 2002:ad4:4d4b:0:b0:690:4ac8:2283 with SMTP id m11-20020ad44d4b000000b006904ac82283mr436827qvm.20.1709937884436;
        Fri, 08 Mar 2024 14:44:44 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id px21-20020a056214051500b00690c0936d70sm36960qvb.127.2024.03.08.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:44:43 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 rcu/dev 2/2] rcu/tree: Add comments explaining now-offline-CPU QS reports
Date: Fri,  8 Mar 2024 17:44:38 -0500
Message-Id: <20240308224439.281349-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308224439.281349-1-joel@joelfernandes.org>
References: <20240308224439.281349-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This a confusing piece of code (rightfully so as the issue it deals with
is complex). Recent discussions brought up a question -- what prevents the
rcu_implicit_dyntick_qs() from warning about QS reports for offline
CPUs.

QS reporting for now-offline CPUs should only happen from:
- gp_init()
- rcutree_cpu_report_dead()

Add some comments to this code explaining how QS reporting is not
missed when these functions are concurrently running.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd29fe3c76bf..f3582f843a05 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1917,7 +1917,22 @@ static noinline_for_stack bool rcu_gp_init(void)
 		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		/* Quiescent states for tasks on any now-offline CPUs. */
+		/*
+		 * === Quiescent states for tasks on any now-offline CPUs. ===
+		 *
+		 * QS reporting for now-offline CPUs should only be performed from
+		 * either here, i.e., gp_init() or from rcutree_report_cpu_dead().
+		 *
+		 * Note that, when reporting quiescent states for now-offline CPUs,
+		 * the sequence of code doing those reports while also accessing
+		 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
+		 * that QS reporting is not missed! Otherwise it possible that
+		 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
+		 * the rnp->lock acquired throughout these QS-reporting
+		 * sequences, which is also acquired in
+		 * rcutree_report_cpu_dead(), so, acquiring ofl_lock is not
+		 * necessary here to synchronize with that function.
+		 */
 		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
 		rnp->rcu_gp_init_mask = mask;
 		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
@@ -5116,6 +5131,25 @@ void rcutree_report_cpu_dead(void)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
+
+	/*
+	 * === Quiescent state reporting for now-offline CPUs ===
+	 *
+	 * QS reporting for now-offline CPUs should only be performed from
+	 * either here, i.e. rcutree_report_cpu_dead(), or gp_init().
+	 *
+	 * Note that, when reporting quiescent states for now-offline CPUs,
+	 * the sequence of code doing those reports while also accessing
+	 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
+	 * that QS reporting is not missed! Otherwise it possible that
+	 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
+	 * the rnp->lock acquired throughout these QS-reporting sequences, which
+	 * is also acquired in gp_init().
+	 * One slight change to this rule is below, where we release and
+	 * reacquire the lock after a QS report, but before we clear the
+	 * ->qsmaskinitnext bit. That is OK to do, because gp_init() report a
+	 * QS again, if it acquired the rnp->lock before we reacquired below.
+	 */
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_disable_urgency_upon_qs(rdp);
-- 
2.34.1


