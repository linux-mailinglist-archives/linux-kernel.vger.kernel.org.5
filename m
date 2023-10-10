Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7A87BFA80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJJL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjJJL7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:59:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4AD6;
        Tue, 10 Oct 2023 04:59:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5980EC433CC;
        Tue, 10 Oct 2023 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939182;
        bh=yY4b8whFEwnmlYcpE6hF0dsGH6oKpTRsy7zKEUgC6Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N10vcVSHoCFumioWjGZilOa3IUNIErDU2RGiqtrv/arquLmUnQWc/ZtKkO2xF4omL
         LI/CYXs5AG+ZXaJbGfj2//C67e59LDYtpO2WLXVtUveX7KLYwu6294MwXUeOwdQyS1
         jf+iQqfPAv6EJDgB6EGr+ufhn887EgH4cw/iGBWDZ9hHHTrxmTRVSb47veqwne/l3j
         jDc7BxsTKFB+QFM1A6e5alpKK6WI/rXj35BdGRN5tWQz/KOK8yE2Q1RCGgl42aEOK7
         IwyYZGrEvXVm15MsWlcuxMq1hqhqogIpE3/UXDDxmfjpRXtc41rZxnBitcQmwh4y1n
         zzpOfoWEav08Q==
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
Subject: [PATCH 03/23] torture: Make torture_hrtimeout_ns() take an hrtimer mode parameter
Date:   Tue, 10 Oct 2023 13:59:01 +0200
Message-Id: <20231010115921.988766-4-frederic@kernel.org>
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

The current torture-test sleeps are waiting for a duration, but there
are situations where it is better to wait for an absolute time, for
example, when ending a stutter interval.  This commit therefore adds
an hrtimer mode parameter to torture_hrtimeout_ns().  Why not also the
other torture_hrtimeout_*() functions?  The theory is that most absolute
times will be in nanoseconds, especially not (say) jiffies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/torture.h |  3 ++-
 kernel/torture.c        | 13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index bb466eec01e4..017f0f710815 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -81,7 +81,8 @@ static inline void torture_random_init(struct torture_random_state *trsp)
 }
 
 /* Definitions for high-resolution-timer sleeps. */
-int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, const enum hrtimer_mode mode,
+			 struct torture_random_state *trsp);
 int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp);
 int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp);
 int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp);
diff --git a/kernel/torture.c b/kernel/torture.c
index 68dba4ecab5c..6ba62e5993e7 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -87,14 +87,15 @@ EXPORT_SYMBOL_GPL(verbose_torout_sleep);
  * nanosecond random fuzz.  This function and its friends desynchronize
  * testing from the timer wheel.
  */
-int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp)
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, const enum hrtimer_mode mode,
+			 struct torture_random_state *trsp)
 {
 	ktime_t hto = baset_ns;
 
 	if (trsp)
 		hto += torture_random(trsp) % fuzzt_ns;
 	set_current_state(TASK_IDLE);
-	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
+	return schedule_hrtimeout(&hto, mode);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_ns);
 
@@ -106,7 +107,7 @@ int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state
 {
 	ktime_t baset_ns = baset_us * NSEC_PER_USEC;
 
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_us);
 
@@ -123,7 +124,7 @@ int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state
 		fuzzt_ns = (u32)~0U;
 	else
 		fuzzt_ns = fuzzt_us * NSEC_PER_USEC;
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_ms);
 
@@ -136,7 +137,7 @@ int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp)
 {
 	ktime_t baset_ns = jiffies_to_nsecs(baset_j);
 
-	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), trsp);
+	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_jiffies);
 
@@ -153,7 +154,7 @@ int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *
 		fuzzt_ns = (u32)~0U;
 	else
 		fuzzt_ns = fuzzt_ms * NSEC_PER_MSEC;
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
 
-- 
2.34.1

