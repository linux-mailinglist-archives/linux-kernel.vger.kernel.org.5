Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513347D9ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjJ0RZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJ0RZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:25:42 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05309CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h9F9MGQEWuO7FbcDirGpZveGbR00hMm8fS3YRyaKU7Q=;
  b=jzIIkwuiXIENTVPNiKWjpFny6CwewVRxqTiOvzQxpAqDVglH7On4tLne
   3ws+G/bmbYUWlsSAhsgw66AFzslIxj0G8sNLUF5/mtsdJnzReidQbmqGX
   N02Oa6TawMO10w3MFrrKAhpYjikfATqWYSQCn37XIsf+xazwUHljVgOBR
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,256,1694728800"; 
   d="scan'208";a="69978968"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.paris.inria.fr) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 19:25:38 +0200
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH] sched/fair: Fix the decision for load balance
Date:   Fri, 27 Oct 2023 19:17:43 +0200
Message-Id: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_we_balance is called for the decision to do load-balancing.
When sched ticks invoke this function, only one CPU should return
true. However, in the current code, two CPUs can return true. The
following situation, where b means busy and i means idle, is an
example because CPU 0 and CPU 2 return true.

        [0, 1] [2, 3]
         b  b   i  b

This fix checks if there exists an idle CPU with busy sibling(s)
after looking for a CPU on an idle core. If some idle CPUs with busy
siblings are found, just the first one should do load-balancing.

Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..eff0316d6c7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
 		return cpu == env->dst_cpu;
 	}
 
-	if (idle_smt == env->dst_cpu)
-		return true;
+	/* Is there an idle CPU with busy siblings? */
+	if (idle_smt != -1)
+		return idle_smt == env->dst_cpu;
 
 	/* Are we the first CPU of this group ? */
 	return group_balance_cpu(sg) == env->dst_cpu;
-- 
2.34.1

