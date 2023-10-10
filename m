Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939417BFA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjJJL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjJJL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3EC94;
        Tue, 10 Oct 2023 04:59:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2FCC433C9;
        Tue, 10 Oct 2023 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939177;
        bh=kVkO+0yKi9ZpS4FWGCS7Kv5Nw6GETSxYizAFJIe2H3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBwTdFFyikcuW6zjgSfptEjDuaNX/KFrnf74ZHK7pPfzVMwkyIIKaj9oWSk2/E1Mw
         qzrsA4SH6hh1k6jAeQgxbG5f8CegrVjWMOAu2/3NvqCLu3SM5cmoMn3m7X7BliNOV1
         mSjXMW0J1MQTPZRVLQRHTMkS8is4YvN1D5/25QHSP+WK1kF+e5/awLb2TIZWFYie46
         31yOjVFf0K4zwdXfPH8XL/ZN4hNirLQR1hDyHuyMSxQ5f1ZxFAIABoA7kmHmNU9r1r
         duPEUI6f0wTldpEc+jtNyF8KgqB8UsEUX+YskTygFENqU+v8QBNolufhMBXN/o3T4W
         GHYh5cZxb3rsg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 01/23] torture: Share torture_random_state with torture_shuffle_tasks()
Date:   Tue, 10 Oct 2023 13:58:59 +0200
Message-Id: <20231010115921.988766-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Both torture_shuffle_tasks() and its caller torture_shuffle()
define a torture_random_state structure.  This is suboptimal given
that torture_shuffle_tasks() runs for a very short period of time.
This commit therefore causes torture_shuffle() to pass a pointer to its
torture_random_state structure down to torture_shuffle_tasks().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/torture.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index b28b05bbef02..68dba4ecab5c 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -520,9 +520,8 @@ static void torture_shuffle_task_unregister_all(void)
  * A special case is when shuffle_idle_cpu = -1, in which case we allow
  * the tasks to run on all CPUs.
  */
-static void torture_shuffle_tasks(void)
+static void torture_shuffle_tasks(struct torture_random_state *trp)
 {
-	DEFINE_TORTURE_RANDOM(rand);
 	struct shuffle_task *stp;
 
 	cpumask_setall(shuffle_tmp_mask);
@@ -543,7 +542,7 @@ static void torture_shuffle_tasks(void)
 
 	mutex_lock(&shuffle_task_mutex);
 	list_for_each_entry(stp, &shuffle_task_list, st_l) {
-		if (!random_shuffle || torture_random(&rand) & 0x1)
+		if (!random_shuffle || torture_random(trp) & 0x1)
 			set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
 	}
 	mutex_unlock(&shuffle_task_mutex);
@@ -562,7 +561,7 @@ static int torture_shuffle(void *arg)
 	VERBOSE_TOROUT_STRING("torture_shuffle task started");
 	do {
 		torture_hrtimeout_jiffies(shuffle_interval, &rand);
-		torture_shuffle_tasks();
+		torture_shuffle_tasks(&rand);
 		torture_shutdown_absorb("torture_shuffle");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("torture_shuffle");
@@ -673,7 +672,7 @@ int torture_shutdown_init(int ssecs, void (*cleanup)(void))
 	if (ssecs > 0) {
 		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
 		return torture_create_kthread(torture_shutdown, NULL,
-					     shutdown_task);
+					      shutdown_task);
 	}
 	return 0;
 }
-- 
2.34.1

