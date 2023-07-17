Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2083D756B64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGQSLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGQSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9EB3;
        Mon, 17 Jul 2023 11:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A41D611DC;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFD4C433C7;
        Mon, 17 Jul 2023 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=KSPQm/Cmvrwm7nB28Q1Uzn4KOU2brchdwzrXtjJDO4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZLvkrEZah3j+6IePfc6+sLQYSZW0DYR7tEycP5uAqBy1oLpb7FEKAW9bJXhXhvWq
         qARRbJgs88kzEspRRG8bRPSH8E7M6KXec/rpF3qDYzvite7r3nbGueVWZ/ShuTaOS4
         r/ZFQErgANur1O0+qeN7HbK5iNja9M7tXuXMnZkPKYJMyxzTWJk0JUAfvajnye9At8
         BzwfefHuqVEoSNRuZwLXybUNxWyBGx2/q1SkhP03KGkVkg2dNnNHXyQtE3LZpNBDfS
         7ONTk2MkJT3nz2dfFYOdvrHPdRrN6uHESR4bwXuInQVO8kWhap5SZOhmM+MzxRv/Kd
         sitT1fFW326Bg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B291FCE0806; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/13] rcuscale: Add minruntime module parameter
Date:   Mon, 17 Jul 2023 11:11:28 -0700
Message-Id: <20230717181138.1098063-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
References: <c5a593d3-abe0-40fd-92bd-28d269042aa1@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, rcuscale collects only 100 points of data per writer, but
arranging for all kthreads to be actively collecting (if not recording)
data during the time that any kthread might be recording.  This works
well, but does not allow much time to bring external performance tools
to bear.  This commit therefore adds a minruntime module parameter
that specifies a minimum data-collection interval in seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 kernel/rcu/rcuscale.c                           | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5ba231b786f8..a6888e3dfc20 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4953,6 +4953,12 @@
 			Number of loops doing rcuscale.kfree_alloc_num number
 			of allocations and frees.
 
+	rcuscale.minruntime= [KNL]
+			Set the minimum test run time in seconds.  This
+			does not affect the data-collection interval,
+			but instead allows better measurement of things
+			like CPU consumption.
+
 	rcuscale.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 15edd8c82933..7c5bab5a4f19 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -87,6 +87,7 @@ torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
 torture_param(int, gp_async_max, 1000, "Max # outstanding waits per writer");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
+torture_param(int, minruntime, 0, "Minimum run time (s)");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
 torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
@@ -411,6 +412,7 @@ rcu_scale_writer(void *arg)
 {
 	int i = 0;
 	int i_max;
+	unsigned long jdone;
 	long me = (long)arg;
 	struct rcu_head *rhp = NULL;
 	bool started = false, done = false, alldone = false;
@@ -447,6 +449,7 @@ rcu_scale_writer(void *arg)
 		}
 	}
 
+	jdone = jiffies + minruntime * HZ;
 	do {
 		if (writer_holdoff)
 			udelay(writer_holdoff);
@@ -479,7 +482,7 @@ rcu_scale_writer(void *arg)
 		if (!started &&
 		    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
 			started = true;
-		if (!done && i >= MIN_MEAS) {
+		if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
 			done = true;
 			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
-- 
2.40.1

