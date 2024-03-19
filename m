Return-Path: <linux-kernel+bounces-107903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE9880352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8401C227C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD251AACC;
	Tue, 19 Mar 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MpHKHX5A"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AD18AE4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869059; cv=none; b=o4bc4we2Vzr5GxKBedGQSfuMKEZjMV1awzK7LWJzKBsQkzVSdfqF4X3ziBxzpam9FmrCfMcSO/H27D8+Kp1StsMPONJZc2fy9t07JgNAIxcFXPMoNFuUJYllVrJoFdsDo7AEOmfSfI10KHCEfa2FuB8lk/0jK1X+ZC5gTb0pci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869059; c=relaxed/simple;
	bh=e7yeIqUpzRjjdTvOBKM5mQZ7beBxblyQQJZNb13cJvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P1quWwuU2zo7dR6LxPmV3bhribJ80yfe/2UmZLnvDeecI/HyNYKO9WLUKqFMWzY6vVYB9u0yjKYS5OyOyE3s13qiT+RJHcbWLBfm/fWtRb8eywusZHOnA4ek6k35+k1lIgqDBfknoCrh6nVDrEMLHpqQhbUHDSVyydZtzRs9Uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=MpHKHX5A; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c39c55ef57so336504b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710869055; x=1711473855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGf7OdIZL/0mVWg7rMGIh3EEFJoK6ZbRGH0lmn+lIjc=;
        b=MpHKHX5A8reaZRm9sw+d1bMQpEoIavfB1xkO1dNgqIZzSAVrBV8BBPvKhEY7qc7Z+k
         eJ/HMyHdZbqmrhDSNQDuL42MF1/4bR97UFEclaFOC4y6+s5hGf77zfrb3ZEZ9tFaTre/
         h5gOe2xVYbH0l4IMpBZRpxvx2TDRBUQxENwsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869055; x=1711473855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGf7OdIZL/0mVWg7rMGIh3EEFJoK6ZbRGH0lmn+lIjc=;
        b=sZTKJ6FpM/kZXDfbx1iI8bd8lFnBeWSAI1AEj2/wWYz3vpyirs+MEbanYiGhLl9vzD
         a+dB5i3ngmln3niyC9cDjh84NucjBm0US5HGPhQnbbb0Gw1zL8F6Hqh/QSeHolkqQTR7
         bZDevXticSclaH959HUepZxJ+jls5GXPEjyxyiVEoVSNxVVXhV1J2I7rRw8nzS7oF3Nc
         VaJtQzI8SwSe+lGhipy+grdIbNGOxiGr3nBle6/lzGvdw1sQnXaovMs/fCmcaJZZ8FQX
         vBOkelsfmSHZvE1Tg+nCF9mpIwDfJvloXJBne5TGce9CXiP4q6xHzVFYtfToCkPe9IjX
         jBiQ==
X-Gm-Message-State: AOJu0Yxozc/2xZssOUC5U4tjAB9SuxikbuDS/80p0VuZofspQIK4l/ZY
	DZwpy5/vUNEJUfLw7qNrguN0CPsoxRpd3qr4shkTPWcgSmC6lGLSi6JGZTD8TuRdn4RU6sYIHcG
	u
X-Google-Smtp-Source: AGHT+IGr+lA72U15DPRVE9LxkyBtJUHTWLbWUf55SlFl333j8vPBbZeMOCrcpSgj2WhhLDcnmke5Vw==
X-Received: by 2002:a05:6808:2219:b0:3c2:bec:69d7 with SMTP id bd25-20020a056808221900b003c20bec69d7mr21116497oib.48.1710869055467;
        Tue, 19 Mar 2024 10:24:15 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id ch14-20020a05622a40ce00b00430dcca3fb5sm1624717qtb.16.2024.03.19.10.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:24:14 -0700 (PDT)
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
Subject: [PATCH v3] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Tue, 19 Mar 2024 13:24:11 -0400
Message-Id: <20240319172412.2083384-1-joel@joelfernandes.org>
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

 kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..f06d13993478 100644
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
@@ -1699,16 +1706,36 @@ static void rcu_sr_normal_gp_cleanup(void)
 			break;
 	}
 
-	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	/* Fast path, no more users to process. */
+	if (!wait_tail->next)
+		return;
+
+	/*
+	 * Fast path, no more users to process except putting the second last
+	 * wait head if no inflight-workers. If there are in-flight workers,
+	 * they will remove the last wait head.
+	 */
+	if (rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
+		/* Order atomic access with list manipulation. */
+		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		wait_tail->next = NULL;
+		rcu_sr_put_wait_head(rcu);
+		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+		return;
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
+	atomic_inc(&rcu_state.srs_cleanups_pending);
+	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+		atomic_dec(&rcu_state.srs_cleanups_pending);
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


