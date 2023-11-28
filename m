Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039A77FB379
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjK1IBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbjK1IAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E592C5;
        Tue, 28 Nov 2023 00:00:43 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bb92811c0so410654e87.1;
        Tue, 28 Nov 2023 00:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158442; x=1701763242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1knYvYUft74/9sPbBJw7fP0T2tfAJH0adcanUwigNQ=;
        b=U8/i3izUbmxxzt7x7qWA0aMVn1+fmScgc3KgJ5TcFYmK1q4Sy/Bi3nx3w7S86VwI0I
         8nRpCf4OSYWrY94hbbNjKkc49UsLjb79Bw5AP1At4W3roCB9uiUqWuuespkrPV3QskNu
         1J01GS6gEoekZu6/bfTLmyJsg2TpK7zfKV5YMiqfNCrOTncZ3C9uIj5otbsryQyDJaxv
         /zkGiV2My8Mp6tonwuZM5V4FToVeKpIPi/V9LXAak0wa0yqoNnvXeDDhVDrjzgDVvRcf
         UiBNwD/YuhfC1T3TODAhuCn+8pSwn/F+hsLzQt56+lXDb7tFdsoeAp7aUnDbew/K5ple
         E4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158442; x=1701763242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1knYvYUft74/9sPbBJw7fP0T2tfAJH0adcanUwigNQ=;
        b=Po09UyuJhYjQwT2iHXorYojbvkER+1ABx2sgoE4tnCx9qOy3f5/Cdu8yz0NtXMB+KJ
         U80d7ImLzTFGtsdgg5KZcMhTSSSxV4yIQa7iXdRwhBGvpgV5zTk4eEXZqjwoAebUT82u
         Crp/jaicDyzyYN/pKyupjPco0w1hZ5y1XmxsnFnwXi887BXL52DiGEr+u5lgx87+s3St
         j2J8u8FaRcKly19rq74Wd2EJynn426VF3cPKXWdHPjhX+E/X0/YGKZcjCheW+bSHrhTR
         ZPGDum4Cye505lXP0gsSpVfqMtPrd97AblCz1Hh10K+yefJ8nZvVQlGfGAuwanVrG1P8
         2ZkQ==
X-Gm-Message-State: AOJu0YzoRsldp38+hoQ9736rCSz1Uhpeo+pa3qRNtDAfHCSaXadbPhMI
        Ml/J/IpY6ZfB+aK1aZbPk88=
X-Google-Smtp-Source: AGHT+IErBw7TS/n7sMQjbGmIi8k8IyP59ASSbwuOKTqfop6fLeJD/O5Albo8MhhmaCePMWvDn/ZCKQ==
X-Received: by 2002:a05:6512:401f:b0:4fe:8ba8:1a8b with SMTP id br31-20020a056512401f00b004fe8ba81a8bmr5553476lfb.7.1701158441575;
        Tue, 28 Nov 2023 00:00:41 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:41 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3 6/7] rcu: Move sync related data to rcu_state structure
Date:   Tue, 28 Nov 2023 09:00:32 +0100
Message-Id: <20231128080033.288050-7-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move synchronize_rcu() main control data under the rcu_state
structure. An access is done via "rcu_state" global variable.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 50 ++++++++++++++---------------------------------
 kernel/rcu/tree.h | 19 ++++++++++++++++++
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 69663a6d5050..c0d3e46730e8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,19 +1384,6 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
-/*
- * A max threshold for synchronize_rcu() users which are
- * awaken directly by the rcu_gp_kthread(). Left part is
- * deferred to the main worker.
- */
-#define SR_MAX_USERS_WAKE_FROM_GP 5
-#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
-
-struct sr_wait_node {
-	atomic_t inuse;
-	struct llist_node node;
-};
-
 /*
  * There is a single llist, which is used for handling
  * synchronize_rcu() users' enqueued rcu_synchronize nodes.
@@ -1523,17 +1510,10 @@ struct sr_wait_node {
  * +----------+     +--------+
  *
  */
-static struct sr_normal_state {
-	struct llist_head srs_next;	/* request a GP users. */
-	struct llist_node *srs_wait_tail; /* wait for GP users. */
-	struct llist_node *srs_done_tail; /* ready for GP users. */
-	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
-} sr;
-
 static bool rcu_sr_is_wait_head(struct llist_node *node)
 {
-	return &(sr.srs_wait_nodes)[0].node <= node &&
-		node <= &(sr.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
+	return &(rcu_state.srs_wait_nodes)[0].node <= node &&
+		node <= &(rcu_state.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
 }
 
 static struct llist_node *rcu_sr_get_wait_head(void)
@@ -1542,7 +1522,7 @@ static struct llist_node *rcu_sr_get_wait_head(void)
 	int i;
 
 	for (i = 0; i < SR_NORMAL_GP_WAIT_HEAD_MAX; i++) {
-		sr_wn = &(sr.srs_wait_nodes)[i];
+		sr_wn = &(rcu_state.srs_wait_nodes)[i];
 
 		if (!atomic_cmpxchg_acquire(&sr_wn->inuse, 0, 1))
 			return &sr_wn->node;
@@ -1590,7 +1570,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * cannot execute concurrently by multiple kworkers,
 	 * the done tail list manipulations are protected here.
 	 */
-	done = smp_load_acquire(&sr.srs_done_tail);
+	done = smp_load_acquire(&rcu_state.srs_done_tail);
 	if (!done)
 		return;
 
@@ -1626,12 +1606,12 @@ static void rcu_sr_normal_gp_cleanup(void)
 	struct llist_node *wait_tail, *head, *rcu;
 	int done = 0;
 
-	wait_tail = sr.srs_wait_tail;
+	wait_tail = rcu_state.srs_wait_tail;
 	if (wait_tail == NULL)
 		return;
 
-	sr.srs_wait_tail = NULL;
-	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
+	rcu_state.srs_wait_tail = NULL;
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
 
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
 	head = wait_tail->next;
@@ -1662,8 +1642,8 @@ static void rcu_sr_normal_gp_cleanup(void)
 	}
 
 	// concurrent sr_normal_gp_cleanup work might observe this update.
-	smp_store_release(&sr.srs_done_tail, wait_tail);
-	ASSERT_EXCLUSIVE_WRITER(sr.srs_done_tail);
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
 	if (wait_tail->next)
 		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
@@ -1678,7 +1658,7 @@ static bool rcu_sr_normal_gp_init(void)
 	struct llist_node *wait_head;
 	bool start_new_poll = false;
 
-	first = READ_ONCE(sr.srs_next.first);
+	first = READ_ONCE(rcu_state.srs_next.first);
 	if (!first || rcu_sr_is_wait_head(first))
 		return start_new_poll;
 
@@ -1690,23 +1670,23 @@ static bool rcu_sr_normal_gp_init(void)
 	}
 
 	/* Inject a wait-dummy-node. */
-	llist_add(wait_head, &sr.srs_next);
+	llist_add(wait_head, &rcu_state.srs_next);
 
 	/*
 	 * A waiting list of rcu_synchronize nodes should be empty on
 	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
 	 * rolls it over. If not, it is a BUG, warn a user.
 	 */
-	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
-	sr.srs_wait_tail = wait_head;
-	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
+	WARN_ON_ONCE(rcu_state.srs_wait_tail != NULL);
+	rcu_state.srs_wait_tail = wait_head;
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
 
 	return start_new_poll;
 }
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
-	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
+	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..f72166b5067a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -316,6 +316,19 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+/*
+ * A max threshold for synchronize_rcu() users which are
+ * awaken directly by the rcu_gp_kthread(). Left part is
+ * deferred to the main worker.
+ */
+#define SR_MAX_USERS_WAKE_FROM_GP 5
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
  * RCU global state, including node hierarchy.  This hierarchy is
  * represented in "heap" form in a dense array.  The root (first level)
@@ -397,6 +410,12 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+
+	/* synchronize_rcu() part. */
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.39.2

