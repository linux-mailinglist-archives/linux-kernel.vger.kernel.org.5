Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2D7BFA99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjJJMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjJJMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:01:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E5134;
        Tue, 10 Oct 2023 05:00:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A969CC433D9;
        Tue, 10 Oct 2023 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939230;
        bh=SnsQJBzy5Sum4OSbj5ASIkNn9fJzznr2FBfCStBhfp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rK1w8HDcpJRzF2UpaCBAi8ddw1YfpGgZdzCIXIEdNuLaLZNd+IQBa9AaES3CZdNaG
         MFRaSiKxJnJqA2LkPv+7mdOvSfrXTqo+xA75YGLBTuE+E1SbrbExgU1pBEs+401W4L
         V0FdNJ8nYRZf2o/VRRASoFcaqsLaaQRBSGkwArzVkruvpJjoCRsnbBaG9FzOCynxnw
         PKB2rvRVRHm/8t8+BWkO8ZwtB01kYC8sR6TsEB9qmgnYyNZz2ATsEoPsVTCZBJy8kv
         J3zYeghvwdtH128NRWez+hJGs3nxaYrZ0eT5JIixzPCPv6lF4Yv0vTIR+vBlnCkQ4H
         JPb/+5CMYW1wA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 20/23] rcutorture: Replace schedule_timeout*() 1-jiffy waits with HZ/20
Date:   Tue, 10 Oct 2023 13:59:18 +0200
Message-Id: <20231010115921.988766-21-frederic@kernel.org>
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

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In the past, spinning on schedule_timeout* with a wait of 1 jiffy has
hung the kernel. See for example d52d3a2bf408 ("torture: Fix hang during
kthread shutdown phase").

This issue recently recurred in torture's stutter code.  The result is
that the function instantly returns and never goes to sleep, preempting
whatever might otherwise make useful forward progress.

To prevent future issues, apply the commit-d52d3a2bf408 fix throughout
rcutorture, moving from a 1-jiffy wait to a 50-millisecond wait.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7e82fb887d09..8136fec0310b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1149,7 +1149,7 @@ static int rcu_torture_boost(void *arg)
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-			schedule_timeout_uninterruptible(1);
+			schedule_timeout_uninterruptible(HZ / 20);
 		}
 
 		/* Go do the stutter. */
@@ -1160,7 +1160,7 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 	/* Clean up and exit. */
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	}
 	torture_kthread_stopping("rcu_torture_boost");
 	return 0;
@@ -1183,7 +1183,7 @@ rcu_torture_fqs(void *arg)
 		fqs_resume_time = jiffies + fqs_stutter * HZ;
 		while (time_before(jiffies, fqs_resume_time) &&
 		       !kthread_should_stop()) {
-			schedule_timeout_interruptible(1);
+			schedule_timeout_interruptible(HZ / 20);
 		}
 		fqs_burst_remaining = fqs_duration;
 		while (fqs_burst_remaining > 0 &&
@@ -2899,7 +2899,7 @@ static int rcu_torture_fwd_prog(void *args)
 			WRITE_ONCE(rcu_fwd_seq, rcu_fwd_seq + 1);
 		} else {
 			while (READ_ONCE(rcu_fwd_seq) == oldseq && !torture_must_stop())
-				schedule_timeout_interruptible(1);
+				schedule_timeout_interruptible(HZ / 20);
 			oldseq = READ_ONCE(rcu_fwd_seq);
 		}
 		pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
@@ -3200,7 +3200,7 @@ static int rcu_torture_read_exit_child(void *trsp_in)
 	set_user_nice(current, MAX_NICE);
 	// Minimize time between reading and exiting.
 	while (!kthread_should_stop())
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	(void)rcu_torture_one_read(trsp, -1);
 	return 0;
 }
@@ -3248,7 +3248,7 @@ static int rcu_torture_read_exit(void *unused)
 	smp_mb(); // Store before wakeup.
 	wake_up(&read_exit_wq);
 	while (!torture_must_stop())
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	torture_kthread_stopping("rcu_torture_read_exit");
 	return 0;
 }
-- 
2.34.1

