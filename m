Return-Path: <linux-kernel+bounces-97667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD2876D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036EF1C213D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855C36AF6;
	Fri,  8 Mar 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ix7yo8ZX"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF515AF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937886; cv=none; b=gfDqNo+h7hwM53/l6FBhgUUQ345K4OjzssemdMw5jX/ViaUJ/NQtvyQZQYiS6Gpq3VoJpp0a7biS+8gz0HhsnqLFQj6O4FteRHtGFnEX32MDhcqjAYmPoe6hFi2pQl3WGzzvUWhlOh51dlLGGfrFe59Ef+7Hv0ukZiCmcy7fwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937886; c=relaxed/simple;
	bh=v7DZ+Vb8YxhnbKdMmawFNDI46ZsBdnSyQ11R4R+guOw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kQrrzqUpLOBEm41Koo7ZaXLLUhVdUHgKZxcEWmaRCdSHUcPO1gbWZtwlYrX3Su9gB0aow6Y4NNj1q4IAsgzbddOrmZg2hxwPnPGyEm2xeiwJy7Zcx+6N+USvwoscMUJ3v3R3kNq/fov/q/dqmpQR7b2xGKjhzbjIPLz8qgJ0aBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=ix7yo8ZX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f74fb38a8so5720186d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 14:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709937883; x=1710542683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD+SjmlOeaPExLkTxwHt+ImqT/q8k7wQBnKxxPL1kU=;
        b=ix7yo8ZX96vxUxSVjOxN70xy7zq52YXv1T0yFs2RocuSfwpUtu+x35KdLNsnts2ldL
         f6O6MXD1C+jKkwrKa9D6HJM9jQ7jm2K01fqlQ2azhSjvlQK2FuYhDPFtyw2Rg5JwPmL2
         TqUo5VHL79ilzSPEwA7SO6a7qU/Qn+/cp0iuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937883; x=1710542683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iD+SjmlOeaPExLkTxwHt+ImqT/q8k7wQBnKxxPL1kU=;
        b=qBr+bsG1hHflNcUYg4HWssdzo5Ynv9+SDID6SCQa9MpAezt0/o4sC2J9z5a1/Gb55k
         kq4CeauITCgP6bDu02kT8UwI9I1YNyQ3aF+0A5uf7c0S4MORcmc/zkMhDNlrUIZOo6ru
         J6VW6oIFF/eo4GjInjYGcFywC6yixw16LZQCk3KJavx0pasREi9kwLMnnfAOo5QYxGm+
         Cd1MhL6oebEDs+0GQGQH1gNkNC97qkOBWBAF3IGIE0MLxGEoFLO12CAHDx7gDDB/toTn
         ZQSXmuJ1tMp37CE4ceFOptVMGVFVc1pTJccMuSBmHQ0bBAEgo9z20Xr4lJcihDgwhgVN
         flKA==
X-Gm-Message-State: AOJu0Yxqb+B7qVfQjRUY105eflVv+G0uS7duQOmqgytTrIPFBHGGRpg/
	dl9hB0+3jinjuehnsdIq3AARBmTcqCqGQzVP5WAjCyR6m3PvbbXTZV+u/LJtJxmZ5AjcVhvHkQZ
	2
X-Google-Smtp-Source: AGHT+IGQSXboq0XMNYKPbxgEvyg2w6pTP2ja7wrLRngBon1irEPARjIk6bbhJ2ojEp/4/OR48b4JKg==
X-Received: by 2002:a0c:f786:0:b0:690:b4a4:4298 with SMTP id s6-20020a0cf786000000b00690b4a44298mr429378qvn.61.1709937882865;
        Fri, 08 Mar 2024 14:44:42 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id px21-20020a056214051500b00690c0936d70sm36960qvb.127.2024.03.08.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:44:42 -0800 (PST)
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
Subject: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Fri,  8 Mar 2024 17:44:37 -0500
Message-Id: <20240308224439.281349-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the synchronize_rcu() common case, we will have less than
SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
is pointless just to free the last injected wait head since at that point,
all the users have already been awakened.

Introduce a new counter to track this and prevent the wakeup in the
common case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Rebased on paul/dev of today.

 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..bd29fe3c76bf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
+	.srs_cleanups_pending = ATOMIC_INIT(0),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * the done tail list manipulations are protected here.
 	 */
 	done = smp_load_acquire(&rcu_state.srs_done_tail);
-	if (!done)
+	if (!done) {
+		/* See comments below. */
+		atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 		return;
+	}
 
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
 	head = done->next;
@@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 
 		rcu_sr_put_wait_head(rcu);
 	}
+
+	/* Order list manipulations with atomic access. */
+	atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
 }
 
 /*
@@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail, *next, *rcu;
+	struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
 	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
@@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process. Remove the last wait head
+	 * if no inflight-workers. If there are in-flight workers, let them
+	 * remove the last wait head.
+	 */
+	WARN_ON_ONCE(!rcu);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
+	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+		/* Order atomic access with list manipulation. */
+		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		wait_tail->next = NULL;
+		rcu_sr_put_wait_head(rcu);
+		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+		return;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work)) {
+		atomic_dec(&rcu_state.srs_cleanups_pending);
+	}
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bae7925c497f..affcb92a358c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -420,6 +420,7 @@ struct rcu_state {
 	struct llist_node *srs_done_tail; /* ready for GP users. */
 	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 	struct work_struct srs_cleanup_work;
+	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.34.1


