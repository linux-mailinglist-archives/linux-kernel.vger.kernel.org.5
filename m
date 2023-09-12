Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7778C79CE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjILKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjILKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5251F172B;
        Tue, 12 Sep 2023 03:29:11 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:29:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxnwhY0eyqPXBZlkvRElJQmn5nzqSgjydnNqnLGzKks=;
        b=btwVyddA5Tt13pov5v8CwQ6pM+T2ghCg7uwncJymLY8v223DxHezhW3BQhm+YK6wgq/Rxj
        xXBDlb4To0I/TS2SrD1DMywDWPBqF3PYOWdR6EoJkZyeO2iaZR9eajHJEBqnhAnlKQLnPI
        md8acF6j1Jp9cWnqzE2HVf8KoASl9EqWWE/e2bw00JfZVvy0EKXBZ7GrXRUoI3K6zB9wDv
        qfqKShn9Cy0lN7vREIEuHAWEZRn7XHN+LNI5kyDz5BoccJTnfe4/Nbb4Oac6qZmaqNAIJb
        bBx4bhTbydzqbzqQduu/Wgi6LuHbw2oU/gqeTm8E286j9vzOCO9JZ9+pnQnuhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxnwhY0eyqPXBZlkvRElJQmn5nzqSgjydnNqnLGzKks=;
        b=j56G3AdoO287DEgIVxAfbjkp1nX8m4lRrCJm6Ft+vsz2DBiZld399UG1SEnyEbFRCP59Vg
        Qaqq99bXV6326aDQ==
From:   "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix SMT4 group_smt_balance handling
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com>
References: <6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169451454934.27769.5511295733807328036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ad468232c3eb1dab163672f98a1ab2363be7981e
Gitweb:        https://git.kernel.org/tip/ad468232c3eb1dab163672f98a1ab2363be7981e
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Thu, 07 Sep 2023 10:42:21 -07:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:10 +02:00

sched/fair: Fix SMT4 group_smt_balance handling

For SMT4, any group with more than 2 tasks will be marked as
group_smt_balance. Retain the behaviour of group_has_spare by marking
the busiest group as the group which has the least number of idle_cpus.

Also, handle rounding effect of adding (ncores_local + ncores_busy) when
the local is fully idle and busy group imbalance is less than 2 tasks.
Local group should try to pull at least 1 task in this case so imbalance
should be set to 2 instead.

Fixes: fee1759e4f04 ("sched/fair: Determine active load balance for SMT sched groups")
Acked-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33a2b6b..cb22592 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9580,7 +9580,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	imbalance /= ncores_local + ncores_busiest;
 
 	/* Take advantage of resource in an empty sched group */
-	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	if (imbalance <= 1 && local->sum_nr_running == 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance = 2;
 
@@ -9768,6 +9768,15 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;
 
 	case group_smt_balance:
+		/*
+		 * Check if we have spare CPUs on either SMT group to
+		 * choose has spare or fully busy handling.
+		 */
+		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0)
+			goto has_spare;
+
+		fallthrough;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9807,6 +9816,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 			else
 				return true;
 		}
+has_spare:
 
 		/*
 		 * Select not overloaded group with lowest number of idle cpus
