Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD47BA7DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJERXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJERXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:23:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F82D4F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:48:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED01DC433C7;
        Thu,  5 Oct 2023 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524517;
        bh=CQ2O//GYwC5mvy1qRCT49ssKIiGsS8rLXvdx8sZl8yY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RsEsZ3/RFK5xfWdrP/s2tB3BdQqazLRDwZz9DQU0D7h0ATTaWh7Xtaw2fxgJZeC03
         slXoaHSTZYH7zcUYvsuhLx5aHP7utICxbDwqSTRU57p4rw+0g3tZJkKnLvuDngtuve
         QzRg1FWb262AAve3NySR0Ss5PGfZp5SaX+fP7OjH5eQ+mpBt2sRqaiq0Gpzuq2PYRN
         epbfg7Ueo7uTx1s39FRzBeCap70+pT+2xkYhgOfTgW+8wa+LaO99R+WDQwq+/KWqHg
         rX+nMRzBtotCJCwUoVhmK3CLc7+RtAxuDPnmo3+B6Gvfy4gdTKbdD4AceziWu0AAYA
         dBdbfhjFrj6MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8173ECE0869; Thu,  5 Oct 2023 09:48:36 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:48:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too long
Message-ID: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CSD lock seems to get stuck in 2 "modes". When it gets stuck
temporarily, it usually gets released in a few seconds, and sometimes
up to one or two minutes.

If the CSD lock stays stuck for more than several minutes, it never
seems to get unstuck, and gradually more and more things in the system
end up also getting stuck.

In the latter case, we should just give up, so the system can dump out
a little more information about what went wrong, and, with panic_on_oops
and a kdump kernel loaded, dump a whole bunch more information about
what might have gone wrong.

Question: should this have its own panic_on_ipistall switch in
/proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
way than via BUG_ON?

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index 8455a53465af..059f1f53fc6b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -230,6 +230,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 	}
 
 	ts2 = sched_clock();
+	/* How long since we last checked for a stuck CSD lock.*/
 	ts_delta = ts2 - *ts1;
 	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
 		return false;
@@ -243,9 +244,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 	else
 		cpux = cpu;
 	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
+	/* How long since this CSD lock was stuck. */
+	ts_delta = ts2 - ts0;
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
-		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
+		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
 		 cpu, csd->func, csd->info);
+	/*
+	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
+	 * to become unstuck. Use a signed comparison to avoid triggering
+	 * on underflows when the TSC is out of sync between sockets.
+	 */
+	BUG_ON((s64)ts_delta > 300000000000LL);
 	if (cpu_cur_csd && csd != cpu_cur_csd) {
 		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
 			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
