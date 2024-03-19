Return-Path: <linux-kernel+bounces-108041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291A880525
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D771C22E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C539FC6;
	Tue, 19 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s2WeZm35"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C939ACD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874507; cv=none; b=tQmPvJCryg3J4TwsCsDiqGNCLsLM/ALcjGDeqR7R5k51sXC4qar0zuVz88zV/AfS5D1BPTA9tJt3Y1Z/i8Hx7fgaWUqpsMn5WLB20I+1M62dRVl3kFJKInOE/S8P4QpnLBOR2oHkxYW694o/r7bWkpORYbd3Mtp6O7tFkzf+T8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874507; c=relaxed/simple;
	bh=9tQwu/pTYuSg4zKOhht1Xekaj5u2ebuKBMHtRD/e+M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IeYOt8MIqApPNHy7QVJW+xi7msN0HO5eCvbiPgFbcCnoOxBsbaWYm/3Z1/KTX+SGnXONrg2iPZQ9HEiOzEeu51kM1RDfgy4XWS+hZsSrYfVZYWB48bCDJf7GBSPjFjwcTHhv+7k+2ZkC0Ox0qYuIhlrjqkR56a2/R8sfcRlC3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=s2WeZm35; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e675db6fbaso3483263a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710874503; x=1711479303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rbLDP9C5tBEsyxTYFGuT0+N/vSDd8dZonUgNGX8BHM=;
        b=s2WeZm35n5r6lclZ9WfmlwxVr7lBrNQ4jT+IL+uIYk6mRl1AkE44eISLbL27y2OPWt
         spsthZnRT2nacWqCAsL+Qto9Y1V8h95F4QW+7xzcEJQUljYm5ba26CEz9AS9mkY2/LbG
         PFM3i6JnM9tXczWW62vc2g4mkw4GvnqY0HLm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874503; x=1711479303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rbLDP9C5tBEsyxTYFGuT0+N/vSDd8dZonUgNGX8BHM=;
        b=KypO7Ujkunpp0IwKzg8V8XkcYi0gCTjLZf/00CRsgHHHxWYH2UqYM0R4XGiOQ4X/uP
         ltwRrPtrcQVPFBgIT6A2HdwrQH+pfI1mZvFOFRJQl1tiaDzJFitR0+wcK8PQ8hJ1Om4U
         rbOG+7/GxexwVJIiqEWtjqCZwjLVXWS2CNrGbcHlkC+shcBoh0CnfNr3QuEnqfI8ag2O
         AkfQnAtO4ZVCpn8gClZc4Q3Wmk6aToxjqM97TKEU9ZBCYqlEhD7AbrfPAOmRl0intmBj
         LWFOI3iWw+Lih05fj/7v7/29K6jWawFeEHBBcAfT3SXhwEKPCv9H0SaA5Ih29iqgZB0K
         1EzA==
X-Gm-Message-State: AOJu0Yyq2ujH3IHx0IJL1cW62etUKI5iQjSEnnzModOtgGxBD6qox2Y7
	WQQh7vhpJYip4h4PBcq6QqKdxxPtbbJ0on+nd/nQjZZ7h9Tm4kxJXMVrL81PLi1CoEpnjHrtnPL
	U
X-Google-Smtp-Source: AGHT+IGRuRQLFJ+LQ7GNxxar6uONk9dp+dom60UmGbwCzV2PiV02mP8ZtM6CtxNZWJET0w94SVR5kg==
X-Received: by 2002:a05:6830:12c3:b0:6e6:968d:8df4 with SMTP id a3-20020a05683012c300b006e6968d8df4mr3604953otq.26.1710874503419;
        Tue, 19 Mar 2024 11:55:03 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b0078a0edbaa94sm1135519qkj.91.2024.03.19.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:55:02 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: urezki@gmail.com,
	neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH v4] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue, 19 Mar 2024 14:54:57 -0400
Message-Id: <20240319185458.3968308-1-joel@joelfernandes.org>
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
v1->v2: Rebase on paul/dev
v2->v3: Additional optimization for wait_tail->next == NULL case.
v3->v4: Apply clean ups from Vlad. Tested rcutorture all scenarios.
---
 kernel/rcu/tree.c | 35 ++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..f3193670fe42 100644
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
@@ -1699,16 +1706,34 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/*
+	 * Fast path, no more users to process except putting the second last
+	 * wait head if no inflight-workers. If there are in-flight workers,
+	 * they will remove the last wait head.
+	 *
+	 * Note that the ACQUIRE orders atomic access with list manipulation.
+	 */
+	if (wait_tail->next && wait_tail->next->next == NULL &&
+	    rcu_sr_is_wait_head(wait_tail->next) &&
+	    !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		rcu_sr_put_wait_head(wait_tail->next);
+		wait_tail->next = NULL;
+	}
+
+	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 
 	/*
 	 * We schedule a work in order to perform a final processing
 	 * of outstanding users(if still left) and releasing wait-heads
 	 * added by rcu_sr_normal_gp_init() call.
 	 */
-	queue_work(sync_wq, &rcu_state.srs_cleanup_work);
+	if (wait_tail->next) {
+		atomic_inc(&rcu_state.srs_cleanups_pending);
+		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+			atomic_dec(&rcu_state.srs_cleanups_pending);
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


