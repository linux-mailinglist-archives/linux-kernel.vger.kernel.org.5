Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8A7D9BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbjJ0OlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbjJ0OlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:41:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D31BD;
        Fri, 27 Oct 2023 07:41:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D98C433CC;
        Fri, 27 Oct 2023 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698417673;
        bh=yhA516cCxkh8DPn4+h8OsNKdVrTpg3e/ugq1V3UWGyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fu9vUSOwcIXxWQg5AG0jUpdX0pWUHbfTHDWhouM4ZnBXmN8yi8Y9li983fAIsOGU0
         rDVYLzJOkxHPBjvRliMv3Hn/DcgIFmxpJ/zHNYBn1Gh9/wdzf7ecHL7ywENAh3gzn+
         r3kQec48NUbUmUcRFG3ta1x3WG1kYoQ36QIA20/lT5hw/l5Vgs+FdHAO6q6BGlYPF+
         1fvWQtynINo9YWaxL5N1i2OevmmeL4nxkihnKoDCSVXUSKbjsks4iVXlYwjRZNsS77
         3pE3MwoHTxLpnL5nPy/+2OyOrElZDzpKdzEJ4H7JvuEEaxC01WSFve5FQpNWsseUWd
         y6RHTZb+hqL/g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] sched: Exclude CPU boot code from PF_IDLE area
Date:   Fri, 27 Oct 2023 16:40:50 +0200
Message-Id: <20231027144050.110601-5-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027144050.110601-1-frederic@kernel.org>
References: <20231027144050.110601-1-frederic@kernel.org>
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

The commit:

	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")

has changed the semantics of what is to be considered an idle task in
such a way that only the actual idle loop is accounted as PF_IDLE. The
intent is to exclude the CPU boot code from that coverage.

However this doesn't clear the flag when the CPU goes down. Therefore
when the CPU goes up again, its boot code is part of the PF_IDLE zone.

Make sure this flag behave consistently and clear the flag when a CPU
exits from the idle loop. If anything, RCU-tasks relies on it to exclude
CPU boot code from its quiescent states.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c        | 4 ++++
 kernel/sched/idle.c | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3b9d5c7eb4a2..b24d7937b989 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1394,7 +1394,9 @@ void cpuhp_report_idle_dead(void)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	current->flags &= ~PF_IDLE;
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
+
 	rcutree_report_cpu_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
@@ -1642,6 +1644,8 @@ void cpuhp_online_idle(enum cpuhp_state state)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
+	current->flags |= PF_IDLE;
+
 	/* Happens for the boot cpu */
 	if (state != CPUHP_AP_ONLINE_IDLE)
 		return;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc6..342f58a329f5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,7 +373,6 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
-	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
-- 
2.34.1

