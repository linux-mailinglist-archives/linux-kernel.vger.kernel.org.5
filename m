Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D129E7D9BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbjJ0OlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346044AbjJ0OlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:41:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83935194;
        Fri, 27 Oct 2023 07:41:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9E5C433AB;
        Fri, 27 Oct 2023 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698417670;
        bh=1Gy2J4196Ason/4s+Q9DcJjUAQ+dsGogthDv6LJxxNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wf3XrB4lbonjZ8b33Z/v5oowVFoMi9EgCyHv+7NQ4QwyevXljSj2ViB9KjmbkkCqf
         K2of/gnVoYyBDuYM1WWpRf+guN9Ka6iJMgrP05eTQ1cT7fhn5jIgCi9owyDdoHGc9V
         IXEg0Kf6DonMuMOmePd4mCY8YLDYisAYaZ0y57KDLAVzwn7rH9CoCUlyOP1vlqU51C
         MHF/EBlT15HIyU1fHoALOy0HUfLqC/kOJsgBbQD5yyufZyBHWX8zjez9y9zsQ80y8W
         QUT5TRyLk5u8+tgcofiL3v9H7CljFt9txqp7JKkeV9wzLXMU7WReeiPzc3h/FaQR+9
         zL1XMUmKg0riQ==
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
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 3/4] rcu/tasks-trace: Handle new PF_IDLE semantics
Date:   Fri, 27 Oct 2023 16:40:49 +0200
Message-Id: <20231027144050.110601-4-frederic@kernel.org>
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
such a way that the idle task of an offline CPU may not carry the
PF_IDLE flag anymore.

However RCU-tasks-trace tests the opposite assertion, still assuming
that idle tasks carry the PF_IDLE flag during their whole lifecycle.

Remove this assumption to avoid spurious warnings but keep the initial
test verifying that the idle task is the current task on any offline
CPU.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Suggested-by: Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a604f59aee0b..732ad5b39946 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1551,7 +1551,7 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	} else {
 		// The task is not running, so C-language access is safe.
 		nesting = t->trc_reader_nesting;
-		WARN_ON_ONCE(ofl && task_curr(t) && !is_idle_task(t));
+		WARN_ON_ONCE(ofl && task_curr(t) && (t != idle_task(task_cpu(t))));
 		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && ofl)
 			n_heavy_reader_ofl_updates++;
 	}
-- 
2.34.1

