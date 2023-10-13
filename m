Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D457C8535
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjJMMAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjJML7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104F10D8;
        Fri, 13 Oct 2023 04:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281D9C433CB;
        Fri, 13 Oct 2023 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198378;
        bh=rCN4+iCoVX4jAGs7s+XIp9Rriuj5msPrP6NA95JLYbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovliKqTXYm9ZYVDaU9YCJen8c0uPB5I5KkvcUh/pIuFXCeqwgg0J9HJoZqsXWgoZT
         RKOrBm+E/4wowCXIiQA9tImmtOtIThJHQVRpdXzcHG2aFHZEHMl9I4cdixYdhZp+ha
         r3y2S2qPXMXFG3RYOPUEWfjb1P+OZGnxQQWX1p7C+2Q5V8yfAjIQNYU9g9Ti5OKjhO
         BZXFXH2jN1uME3IdN+JHHE8EXjk1JCkYI+vS1NsiVa/wrGUA70vjCm+/WvNM6+oPSy
         yJ/C+1ku0C1YknO82v7AzPqK41BYopgsZ3QFQ3KXIH1rg9WCF6L+4W6OfS/WKU8gAY
         bwtQM7d7Nq/zw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 10/18] rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
Date:   Fri, 13 Oct 2023 13:58:54 +0200
Message-Id: <20231013115902.1059735-11-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
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

From: Catalin Marinas <catalin.marinas@arm.com>

Since the actual slab freeing is deferred when calling kvfree_rcu(), so
is the kmemleak_free() callback informing kmemleak of the object
deletion. From the perspective of the kvfree_rcu() caller, the object is
freed and it may remove any references to it. Since kmemleak does not
scan RCU internal data storing the pointer, it will report such objects
as leaks during the grace period.

Tell kmemleak to ignore such objects on the kvfree_call_rcu() path. Note
that the tiny RCU implementation does not have such issue since the
objects can be tracked from the rcu_ctrlblk structure.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://lore.kernel.org/all/F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com/
Cc: <stable@vger.kernel.org>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a83ecab77917..4dd7df30df31 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/completion.h>
+#include <linux/kmemleak.h>
 #include <linux/moduleparam.h>
 #include <linux/panic.h>
 #include <linux/panic_notifier.h>
@@ -3389,6 +3390,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		success = true;
 	}
 
+	/*
+	 * The kvfree_rcu() caller considers the pointer freed at this point
+	 * and likely removes any references to it. Since the actual slab
+	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
+	 * this object (no scanning or false positives reporting).
+	 */
+	kmemleak_ignore(ptr);
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);
-- 
2.34.1

