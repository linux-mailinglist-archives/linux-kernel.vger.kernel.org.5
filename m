Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469EA80AF5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574890AbjLHWGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574886AbjLHWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980E1712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:06:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C95C433C7;
        Fri,  8 Dec 2023 22:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073161;
        bh=6Rj2/Ew9i8og8UV1rs/YRIIkk8Z14PNfosvKFa7ip4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXojr6rgF4CVtj1/yBPc4JDT25DImi7RK6bjPnZ/E9+OwRt5xlCa7VBBdmwAuZRQk
         aSMyIc9cocqzJ7LMudOAEPf9o4ryZal2Oa/HV7IOcfmPXz4JSTHA6hflKzWJ/j5U04
         47RHygrGazdzJEjuHxp0zlfgxtpGTF+qVfmMzN8SY2ZLR55GpJobnvyxwHk7UYALl7
         4STCMLMjN779SK0D/wWSsCw1K+XE/WQfSuIe67z0e0HnM3EUh57lV7WsdRJ2iUezAj
         fb1y3eftmg/tb2vDlQw7dP4H+Gb2wIPAd2efJnXF2+n9aW8kKJTT1tmwcbg5O9rDhc
         iINxxKaf0URqg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH 3/8] rcu/exp: Fix RCU expedited parallel grace period kworker allocation failure recovery
Date:   Fri,  8 Dec 2023 23:05:40 +0100
Message-ID: <20231208220545.7452-4-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_RCU_EXP_KTHREAD=y, the nodes initialization for expedited
grace periods is queued to a kworker. However if the allocation of that
kworker failed, the nodes initialization is performed synchronously by
the caller instead.

Now the check for kworker initialization failure relies on the kworker
pointer to be NULL while its value might actually encapsulate an
allocation failure error.

Make sure to handle this case.

Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Cc: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 82f8130d3fe3..055f4817bc70 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4723,6 +4723,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
 		return;
 	}
-- 
2.42.1

