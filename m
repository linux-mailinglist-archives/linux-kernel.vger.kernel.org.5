Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F67EB904
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjKNV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjKNV5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:57:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36281D8;
        Tue, 14 Nov 2023 13:57:14 -0800 (PST)
Date:   Tue, 14 Nov 2023 21:57:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699999032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qSSd9FGW8BlweZLwt59poRN99tZZYZnkIbBfiqtXHI=;
        b=EXz8nN4lwTCkPnTLjh0eUYjFGxBPOb5vvCYrTTN4d4JOMPxd84xvwjv7Lx87NdDQnqifq+
        B3dQ6byB2uatTb4N6o41GJ+iWE4H7ZRT/D3JpEUGdXNT+6zuMUiyxwHgydiF0cbjuCbraY
        4eoDyE7ntt4Mr3uBNjyns4X8v0OdmTbbxObusibDQvMgJMNYH4qYOmOyZkugk3Vy/R9rGj
        BYNznUCPckAdgjA+wGwGdSL++QJxWoV6QkLVr6gtgnIUUI4CXwv9PMkccX4sJ9Atu3lFJB
        kmWCdWXcfmyaKT1nvuYy7XQOyPtgZrBhDs/P+Og7q9FZWXJhUnxQ7o8t3zw97A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699999032;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qSSd9FGW8BlweZLwt59poRN99tZZYZnkIbBfiqtXHI=;
        b=4RH8QeqL91d3kCvARfa1ThU///aQZwW+Mhf5qvbUtDu1LpBZkaGaTjH+g0dNddAO7ixVLI
        Dvde76QgF4tiiDBw==
From:   "tip-bot2 for Keisuke Nishimura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix the decision for load balance
Cc:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231031133821.1570861-1-keisuke.nishimura@inria.fr>
References: <20231031133821.1570861-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Message-ID: <169999903219.391.2460827173392775023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3
Gitweb:        https://git.kernel.org/tip/6d7e4782bcf549221b4ccfffec2cf4d1a473f1a3
Author:        Keisuke Nishimura <keisuke.nishimura@inria.fr>
AuthorDate:    Tue, 31 Oct 2023 14:38:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Nov 2023 22:27:01 +01:00

sched/fair: Fix the decision for load balance

should_we_balance is called for the decision to do load-balancing.
When sched ticks invoke this function, only one CPU should return
true. However, in the current code, two CPUs can return true. The
following situation, where b means busy and i means idle, is an
example, because CPU 0 and CPU 2 return true.

        [0, 1] [2, 3]
         b  b   i  b

This fix checks if there exists an idle CPU with busy sibling(s)
after looking for a CPU on an idle core. If some idle CPUs with busy
siblings are found, just the first one should do load-balancing.

Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20231031133821.1570861-1-keisuke.nishimura@inria.fr
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 025d909..d7a3c63 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11184,12 +11184,16 @@ static int should_we_balance(struct lb_env *env)
 			continue;
 		}
 
-		/* Are we the first idle CPU? */
+		/*
+		 * Are we the first idle core in a non-SMT domain or higher,
+		 * or the first idle CPU in a SMT domain?
+		 */
 		return cpu == env->dst_cpu;
 	}
 
-	if (idle_smt == env->dst_cpu)
-		return true;
+	/* Are we the first idle CPU with busy siblings? */
+	if (idle_smt != -1)
+		return idle_smt == env->dst_cpu;
 
 	/* Are we the first CPU of this group ? */
 	return group_balance_cpu(sg) == env->dst_cpu;
