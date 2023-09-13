Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCAA79E8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjIMNLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjIMNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A11BD3;
        Wed, 13 Sep 2023 06:11:25 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Lbr+GREXFEIWdqi56FKOM82bPUrS1DfjkzuftxKpOU=;
        b=bI4ynV4KCRDLsAecFpDqPzz0YhKoNzcIhTNMOezL7aw/qy0EdAoDnEHEEE1X8JK0cEb7Rt
        WQXdeQM1jpx7mntwuo9n3fAtxlMUXqxxDEShPPRyVXMdewZ5rM2CwmmGquAZjjqbAU1NTy
        haLymHLPzftO3U2hBfv1j8ol9PePj4sbmFaZYufFJVSIjDSiPBhhcRnO1EiEPnZg/O2owT
        hDRXFqPjid1eAaLqg/QggqMdU2N+rtD5Q5o9bohT39rr6P8Eq+icYr2pG+rsMiQtwiapDo
        qUqwqmt6uNtpfRuXkndn1bhFaGpDUeI4iDheYE3jkFr8glgakuesEYbc015XCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Lbr+GREXFEIWdqi56FKOM82bPUrS1DfjkzuftxKpOU=;
        b=bZ0OadvV9qyxjH665056/IZzyjAwF117+HzrQCi2ftQBoc+vGd5VVkTWCWZOQs9gn1PBg+
        n3ggAGYJHxvpjBDA==
From:   "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix SMT4 group_smt_balance handling
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com>
References: <6cd1633036bb6b651af575c32c2a9608a106702c.camel@linux.intel.com>
MIME-Version: 1.0
Message-ID: <169461068361.27769.13031358982665213840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     450e749707bc1755f22b505d9cd942d4869dc535
Gitweb:        https://git.kernel.org/tip/450e749707bc1755f22b505d9cd942d4869dc535
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Thu, 07 Sep 2023 10:42:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:03:06 +02:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
