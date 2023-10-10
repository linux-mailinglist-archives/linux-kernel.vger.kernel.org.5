Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB87BFA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjJJMAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjJJMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B99DA;
        Tue, 10 Oct 2023 05:00:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0773C433C7;
        Tue, 10 Oct 2023 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939205;
        bh=z/6W7Sq91lXYiT+T8Ou3AD0oMBmwnQ8VicZ7CbcAyQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3s41Ps24rSzylBKXRoRs6u5kl4sd3f8NZJIl5j5mVH5Gmqz50IGYmpv12lWlAIan
         fjA2A+cQQ6APRxtB6LiEJW6a7oOw5epFCfXB8lLYSSzp2JYhhQZt2QroGVjXkcMbQm
         febf1QkZU8CY1lwxKMIvLx3KlaifAIadxhaxlYF455QGYHHJ0j8YwFkpphSz6skX+B
         ffCQxP2N8CVjqzEPKd7wFcb2nKudj5JoE2gI4dw6ZbXarzLNYcUHwaLX/pDAadc9yC
         akasjg8jn+AAfK3oV/9fomzq+4OJmVdJ9fLtSLJXQbKULPVUg3q1fZTt4v/zh71uto
         rr2vO3+TPBcTg==
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
Subject: [PATCH 11/23] locktorture: Add acq_writer_lim to complain about long acquistion times
Date:   Tue, 10 Oct 2023 13:59:09 +0200
Message-Id: <20231010115921.988766-12-frederic@kernel.org>
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

This commit adds a locktorture.acq_writer_lim module parameter that
specifies the maximum number of jiffies that is expected to be consumed
by write-side lock acquisition.  If this limit is exceeded, a WARN_ONCE()
causes a splat.  Note that this limit applies to the main lock acquisition
only, not to any nested acquisitions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/locking/locktorture.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c8c322e69a90..296815ef67ae 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -33,6 +33,7 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
+torture_param(int, acq_writer_lim, 0, "Write_acquisition time limit (jiffies).");
 torture_param(int, long_hold, 100, "Do occasional long hold of lock (ms), 0=disable");
 torture_param(int, nested_locks, 0, "Number of nested locks (max = 8)");
 torture_param(int, nreaders_stress, -1, "Number of read-locking stress-test threads");
@@ -852,11 +853,13 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
  */
 static int lock_torture_writer(void *arg)
 {
-	struct lock_stress_stats *lwsp = arg;
-	int tid = lwsp - cxt.lwsa;
-	DEFINE_TORTURE_RANDOM(rand);
+	unsigned long j;
+	unsigned long j1;
 	u32 lockset_mask;
+	struct lock_stress_stats *lwsp = arg;
+	DEFINE_TORTURE_RANDOM(rand);
 	bool skip_main_lock;
+	int tid = lwsp - cxt.lwsa;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
 	if (!rt_task(current))
@@ -883,12 +886,20 @@ static int lock_torture_writer(void *arg)
 			cxt.cur_ops->nested_lock(tid, lockset_mask);
 
 		if (!skip_main_lock) {
+			if (acq_writer_lim > 0)
+				j = jiffies;
 			cxt.cur_ops->writelock(tid);
 			if (WARN_ON_ONCE(lock_is_write_held))
 				lwsp->n_lock_fail++;
 			lock_is_write_held = true;
 			if (WARN_ON_ONCE(atomic_read(&lock_is_read_held)))
 				lwsp->n_lock_fail++; /* rare, but... */
+			if (acq_writer_lim > 0) {
+				j1 = jiffies;
+				WARN_ONCE(time_after(j1, j + acq_writer_lim),
+					  "%s: Lock acquisition took %lu jiffies.\n",
+					  __func__, j1 - j);
+			}
 			lwsp->n_lock_acquired++;
 
 			cxt.cur_ops->write_delay(&rand);
-- 
2.34.1

