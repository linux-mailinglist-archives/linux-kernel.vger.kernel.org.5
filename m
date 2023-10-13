Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6F7C8529
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJMMAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJML7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62F195;
        Fri, 13 Oct 2023 04:59:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EB7C433CC;
        Fri, 13 Oct 2023 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198371;
        bh=ZIdTdcHLWr/sOB8PSUXqF37fOevVbYeiYj5kEREzCsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/IY2FxF4nhhUiT9TcBAKeVscINBGdP8AOURhdYyTW5OdOfQPSZhvxYgXNeF+OSLB
         RZVjG9nesoqKrx0CGwMsydjOREuwtc65EUqeu+/3QHAj+jZA9G5GbZ0NyYpbGFvUeG
         9TcLiTxVjjklcl+q7u6hIfeDjRpwpmq7/Q0zVA1GKs9CgRLDGKM/p+cCh1GvrOxznk
         6KYgWu3arpTEttQ3S5QGF6qK9c84lWZ6/RVHVR173t9EcGx9TF21volEDZ2+J/g7HQ
         z/xqXH25wBkZO6aeKcj11GQWPjrvDjTjhhH58xIC894Soi7glIXnRRIEhjMzsVUgYN
         hw6qmljXrTeOg==
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
Subject: [PATCH 08/18] rcu: Eliminate rcu_gp_slow_unregister() false positive
Date:   Fri, 13 Oct 2023 13:58:52 +0200
Message-Id: <20231013115902.1059735-9-frederic@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

When using rcutorture as a module, there are a number of conditions that
can abort the modprobe operation, for example, when attempting to run
both RCU CPU stall warning tests and forward-progress tests.  This can
cause rcu_torture_cleanup() to be invoked on the unwind path out of
rcu_rcu_torture_init(), which will mean that rcu_gp_slow_unregister()
is invoked without a matching rcu_gp_slow_register().  This will cause
a splat because rcu_gp_slow_unregister() is passed rcu_fwd_cb_nodelay,
which does not match a NULL pointer.

This commit therefore forgives a mismatch involving a NULL pointer, thus
avoiding this false-positive splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aae515071ffd..a83ecab77917 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1260,7 +1260,7 @@ EXPORT_SYMBOL_GPL(rcu_gp_slow_register);
 /* Unregister a counter, with NULL for not caring which. */
 void rcu_gp_slow_unregister(atomic_t *rgssp)
 {
-	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress);
+	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress && rcu_gp_slow_suppress != NULL);
 
 	WRITE_ONCE(rcu_gp_slow_suppress, NULL);
 }
-- 
2.34.1

