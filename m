Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E12756B61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGQSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGQSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E94E4C;
        Mon, 17 Jul 2023 11:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA41611DD;
        Mon, 17 Jul 2023 18:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE024C433CB;
        Mon, 17 Jul 2023 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617500;
        bh=5A8xH+p0dUJfvye10KzRYh4lPe5RZ2TL4tDrfKR9vx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR9mNJCGa0lEX1MzLzlunbCdKEny04LHyl33ZVfu9iRO9pZCmmCmnU10FIauKD17c
         AtzN4soQXUTe95wjeMRaMPYEV/S60XPyr6B9s56DgbpIoKFWqhxs66n1ahizdjbdZh
         GaN8eP4mQZxC77NlCVHCWQA9X4e4i1cXjCV0Np+epPYBxwNkZDPBXy3Uys0JE9xbFy
         KNCebj0ugbDIo/ddKrtLLaaNqe0r3Al6QFlocxTg6okZRC/YyckNdI+PQAAhdV4Lir
         u1xNATbnZV5cIUtEj/6UrpvQ20KTb+xGEF1ZUej7pK0S1d/M+FnHTBaXSxj6ZkKVMz
         x+RUyCjNqOkrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AD68BCE03F1; Mon, 17 Jul 2023 11:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/13] rcuscale: Permit blocking delays between writers
Date:   Mon, 17 Jul 2023 11:11:26 -0700
Message-Id: <20230717181138.1098063-1-paulmck@kernel.org>
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

Some workloads do isolated RCU work, and this can affect operation
latencies.  This commit therefore adds a writer_holdoff_jiffies module
parameter that causes writers to block for the specified number of
jiffies between each pair of consecutive write-side operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 kernel/rcu/rcuscale.c                           | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..5ba231b786f8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4983,6 +4983,11 @@
 			in microseconds.  The default of zero says
 			no holdoff.
 
+	rcuscale.writer_holdoff_jiffies= [KNL]
+			Additional write-side holdoff between grace
+			periods, but in jiffies.  The default of zero
+			says no holdoff.
+
 	rcutorture.fqs_duration= [KNL]
 			Set duration of force_quiescent_state bursts
 			in microseconds.
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d1221731c7cf..4277037e0996 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -93,6 +93,7 @@ torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
 	      "Shutdown at end of scalability tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
+torture_param(int, writer_holdoff_jiffies, 0, "Holdoff (jiffies) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
@@ -414,6 +415,7 @@ rcu_scale_writer(void *arg)
 	struct rcu_head *rhp = NULL;
 	bool started = false, done = false, alldone = false;
 	u64 t;
+	DEFINE_TORTURE_RANDOM(tr);
 	u64 *wdp;
 	u64 *wdpp = writer_durations[me];
 
@@ -448,6 +450,8 @@ rcu_scale_writer(void *arg)
 	do {
 		if (writer_holdoff)
 			udelay(writer_holdoff);
+		if (writer_holdoff_jiffies)
+			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
 		if (gp_async) {
-- 
2.40.1

