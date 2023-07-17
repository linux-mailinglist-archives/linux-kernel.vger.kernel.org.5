Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DFC756BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGQSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGQSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA5F7;
        Mon, 17 Jul 2023 11:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97DFB611EB;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31EFC433C8;
        Mon, 17 Jul 2023 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=pE4BWqzV7aB/0f8qofy45VqlKrCym7gg/FrxizK5ypg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyUAvZde7u8wWUU35mWpc2I0qIsa6NqvdKSCIO6VHJBj47drCQ535vmhgE1cGT4v5
         XdLe7pQArfVoJo7626fkN24yd/Lon2OKQ2POTAzTQOAKbXetcUVdmdZvAPFI2XjJhZ
         BQh27eG9BWYjsDYmatpQfB+fEGTBPpgSEQZtwxp4Q2O7/OcMtZ8Rb0wMNF8O1CV6PT
         9oP6CN76aQ74aA1ZkVt0y373rp39HnU66v8m8K40ITVhphtiBBL/H/HJktLJSb53Et
         uFIk3eBhE7Urg2ScrJsH1Emkm4M276rpk7LeIfQXBfsKmuELZYjcfgXXjG9f+vr9gF
         gvBLyZTNzeckQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 908DFCE0806; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH rcu 3/9] torture: Add lock_torture_writer_fifo module param
Date:   Mon, 17 Jul 2023 11:20:36 -0700
Message-Id: <20230717182042.1098651-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Modifies locktorture writer to run as RT task.

To use it:
insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3

This patch has been helpful to uncover issues with the proxy-execution
series.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: kernel-team@android.com
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
[jstultz: Include header change to build, reword commit message]
Signed-off-by: John Stultz <jstultz@google.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c |  3 ++-
 kernel/torture.c             | 11 ++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 949d3deae506..aac48d323254 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -809,7 +809,8 @@ static int lock_torture_writer(void *arg)
 	bool skip_main_lock;
 
 	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
-	set_user_nice(current, MAX_NICE);
+	if (!rt_task(current))
+		set_user_nice(current, MAX_NICE);
 
 	do {
 		if ((torture_random(&rand) & 0xfffff) == 0)
diff --git a/kernel/torture.c b/kernel/torture.c
index 8be83fdc6be1..db79197e257a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -37,6 +37,7 @@
 #include <linux/ktime.h>
 #include <asm/byteorder.h>
 #include <linux/torture.h>
+#include <linux/sched/rt.h>
 #include "rcu/rcu.h"
 
 MODULE_LICENSE("GPL");
@@ -57,6 +58,9 @@ module_param(verbose_sleep_duration, int, 0444);
 static int random_shuffle;
 module_param(random_shuffle, int, 0444);
 
+static int lock_torture_writer_fifo;
+module_param(lock_torture_writer_fifo, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -734,7 +738,7 @@ bool stutter_wait(const char *title)
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret) {
+		if (!ret && !rt_task(current)) {
 			sched_set_normal(current, MAX_NICE);
 			ret = true;
 		}
@@ -944,6 +948,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 		*tp = NULL;
 		return ret;
 	}
+
+	if (lock_torture_writer_fifo &&
+	    !strncmp(s, "lock_torture_writer", strlen(s)))
+		sched_set_fifo(*tp);
+
 	wake_up_process(*tp);  // Process is sleeping, so ordering provided.
 	torture_shuffle_task_register(*tp);
 	return ret;
-- 
2.40.1

