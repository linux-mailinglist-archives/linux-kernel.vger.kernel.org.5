Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696447BFA97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjJJMBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJJMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4DC10C2;
        Tue, 10 Oct 2023 05:00:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67717C433C9;
        Tue, 10 Oct 2023 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939221;
        bh=auFBPodM5kO9BUafGEXKYKTSfdxIB8Ykugl3mHcHETw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7XqFctbaENt8+vsG9vMQjuAon9bLLDiSAV9lJy1BnuaWV9sAiXEnaHSRPrm34P1I
         mWK0w1owL2M8zs3fDzHCnKAf3y37AnQNQpZPw/awSFeIwcnVeb0k58WxFr+1o44u57
         bNRPrzUrUWTUq2lHh4dIFxRmyGV3xlRp6Y0BU/6C7xfKU8SYsmhZ5a3MTw24x5svsT
         NIkDceCbAfShNxaUQ56q426HQJv+2n1BvHDuY7kQ9s4w0NviKQfhTb/DpSHofjgR2o
         E75LyL6vucLF4JmpPf7OJj/eqcnQnxqCV2NiDxAAontPq6UEDbImWcfgIuSmGIn9GM
         AAEh9ir+jOyhg==
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
Subject: [PATCH 17/23] doc: Catch-up update for locktorture module parameters
Date:   Tue, 10 Oct 2023 13:59:15 +0200
Message-Id: <20231010115921.988766-18-frederic@kernel.org>
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

This commit documents recently added locktorture module parameters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 50 +++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 300e2c30986c..47f8b1cef4fd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2913,6 +2913,11 @@
 			to extract confidential information from the kernel
 			are also disabled.
 
+	locktorture.acq_writer_lim= [KNL]
+			Set the time limit in jiffies for a lock
+			acquisition.  Acquisitions exceeding this limit
+			will result in a splat once they do complete.
+
 	locktorture.call_rcu_chains= [KNL]
 			Specify the number of self-propagating call_rcu()
 			chains to set up.  These are used to ensure that
@@ -2920,6 +2925,18 @@
 			in progress at any given time.	Defaults to 0,
 			which disables these call_rcu() chains.
 
+	locktorture.long_hold= [KNL]
+			Specify the duration in milliseconds for the
+			occasional long-duration lock hold time.  Defaults
+			to 100 milliseconds.  Select 0 to disable.
+
+	locktorture.nested_locks= [KNL]
+			Specify the maximum lock nesting depth that
+			locktorture is to exercise, up to a limit of 8
+			(MAX_NESTED_LOCKS).  Specify zero to disable.
+			Note that this parameter is ineffective on types
+			of locks that do not support nested acquisition.
+
 	locktorture.nreaders_stress= [KNL]
 			Set the number of locking read-acquisition kthreads.
 			Defaults to being automatically set based on the
@@ -2935,6 +2952,29 @@
 			Set time (s) between CPU-hotplug operations, or
 			zero to disable CPU-hotplug testing.
 
+	locktorture.readers_bind= [KNL]
+			Specify the list of CPUs to which the readers are
+			to be bound.
+
+	locktorture.rt_boost= [KNL]
+			Do periodic testing of real-time lock priority
+			boosting.  Select 0 to disable, 1 to boost
+			only rt_mutex, and 2 to boost unconditionally.
+			Defaults to 2, which might seem to be an
+			odd choice, but which should be harmless for
+			non-real-time spinlocks, due to their disabling
+			of preemption.	Note that non-realtime mutexes
+			disable boosting.
+
+	locktorture.rt_boost_factor= [KNL]
+			Number that determines how often and for how
+			long priority boosting is exercised.  This is
+			scaled down by the number of writers, so that the
+			number of boosts per unit time remains roughly
+			constant as the number of writers increases.
+			On the other hand, the duration of each boost
+			increases with the number of writers.
+
 	locktorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (jiffies).  Shuffling
 			tasks allows some CPUs to go into dyntick-idle
@@ -2957,13 +2997,17 @@
 	locktorture.torture_type= [KNL]
 			Specify the locking implementation to test.
 
+	locktorture.verbose= [KNL]
+			Enable additional printk() statements.
+
+	locktorture.writers_bind= [KNL]
+			Specify the list of CPUs to which the writers are
+			to be bound.
+
 	locktorture.writer_fifo= [KNL]
 			Run the write-side locktorture kthreads at
 			sched_set_fifo() real-time priority.
 
-	locktorture.verbose= [KNL]
-			Enable additional printk() statements.
-
 	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>
 
-- 
2.34.1

