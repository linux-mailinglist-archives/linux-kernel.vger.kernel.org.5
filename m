Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004E7E3B06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjKGLWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjKGLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558AB10C6;
        Tue,  7 Nov 2023 03:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356130; x=1730892130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvsXSr+H0OXz+tRvroL/Z/VRfDIrygnvWqBJ8snWfQQ=;
  b=TMO5VeKSiwfifm1LlFGCxbLJUJzYbl/zuapI0R+rT3VyInrGwS3bzkox
   vLr40PwlQ2wFD3BuxEgX6pXRScVG85zMISeqo6ubjNG2nWqcmjruchYND
   ygaJCkbS2w+V/QXP6aUUpCK+QpAL/F9dyIcHbD3H5f9zk/LvVBt2NxdD/
   JHQ4dzUJevjnw67Xn0GCpIEYyQzZd9qZy451TtBGCaTdLHRQyewxqWVLS
   uursO/m2ZcMM1Zw2ql6J4VTgd448DMrEkNR8bVZtDMtOfovG28bsuybIP
   XdqHkKRGjmJfzHti8AC+A5ooJNI21ykwSZgpq7e1cQDi+noE8RwcXeXYc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727154"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579830"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579830"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:09 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id D5251580DC7;
        Tue,  7 Nov 2023 03:22:06 -0800 (PST)
From:   Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 5/7] net/sched: taprio: fix delayed switching to new schedule after timer expiry
Date:   Tue,  7 Nov 2023 06:20:21 -0500
Message-Id: <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a new GCL is triggered and the new admin base time falls before the
expiry of advance_timer (current running entry from oper),
taprio_start_sched() resets the current advance_timer expiry to the
new admin base time. However, upon expiry, advance_sched() doesn't
immediately switch to the admin schedule. It continues running entries
from the old oper schedule, and only switches to the new admin schedule
much later. Ideally, if the advance_timer is shorten to align with the
new admin base time, when the timer expires, advance_sched() should
trigger switch_schedules() at the beginning.

To resolve this issue, set the cycle_time_correction to a non-initialized
value in taprio_start_sched(). advance_sched() will use it to initiate
switch_schedules() at the beginning.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f18a5fe12f0c..01b114edec30 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1379,14 +1379,19 @@ static void setup_first_end_time(struct taprio_sched *q,
 }
 
 static void taprio_start_sched(struct Qdisc *sch,
-			       ktime_t start, struct sched_gate_list *new)
+			       ktime_t new_base_time,
+			       struct sched_gate_list *new)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
-	ktime_t expires;
+	struct sched_gate_list *oper = NULL;
+	ktime_t expires, start;
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
 		return;
 
+	oper = rcu_dereference_protected(q->oper_sched,
+					 lockdep_is_held(&q->current_entry_lock));
+
 	expires = hrtimer_get_expires(&q->advance_timer);
 	if (expires == 0)
 		expires = KTIME_MAX;
@@ -1395,7 +1400,17 @@ static void taprio_start_sched(struct Qdisc *sch,
 	 * reprogram it to the earliest one, so we change the admin
 	 * schedule to the operational one at the right time.
 	 */
-	start = min_t(ktime_t, start, expires);
+	start = min_t(ktime_t, new_base_time, expires);
+
+	if (expires != KTIME_MAX &&
+	    ktime_compare(start, new_base_time) == 0) {
+		/* Since timer was changed to align to the new admin schedule,
+		 * setting the variable below to a non-initialized value will
+		 * indicate to advance_sched() to call switch_schedules() after
+		 * this timer expires.
+		 */
+		oper->cycle_time_correction = 0;
+	}
 
 	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
 }
-- 
2.25.1

