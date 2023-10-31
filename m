Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661077DCDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjJaNj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344599AbjJaNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:39:58 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45EB9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+R/StZ0rnd3KPlOJD7FBs4MnY5uMyxTojGwy+D7cBfE=;
  b=dxs7i03DmLPGojj/9w98djg9obg0R40MvthZamq0P5raUwyVO57WH+6U
   17INflnLwHjfbd9T71diB3EpXtd5f7mYbfGzQXqDKekM0KkpBbOJfUeyb
   RspWzT5u8TpqsPMO8XTgrDUW+FLh0Gn0s+FJnhut8FfOmnhdAQ1kdG5zM
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,265,1694728800"; 
   d="scan'208";a="70220528"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.paris.inria.fr) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 14:39:53 +0100
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH v3] sched/fair: Fix the decision for load balance
Date:   Tue, 31 Oct 2023 14:38:22 +0100
Message-Id: <20231031133821.1570861-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..921f4f65adef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11079,12 +11079,16 @@ static int should_we_balance(struct lb_env *env)
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
-- 
2.34.1

