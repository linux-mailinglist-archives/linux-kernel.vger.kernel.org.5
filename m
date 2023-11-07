Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532867E3AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjKGLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjKGLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014EDF;
        Tue,  7 Nov 2023 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356118; x=1730892118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHImEZIJ0xShgJd/ZwUz1VFJC6sRPgJf9bhkur+fnmc=;
  b=bcmUsz5aE80nkZqKEgfgBFgg/8MYpvb7N9NFe2pFRj+2lQ/RD6S216Pt
   hSYGjf+PV70zPrsrSY/Z5z3NqB1qZIOOuOZ4ZlKgch8bAMSrlvAYYsKOl
   yTvPKekBRwTGjcnI8qXDgjYuULouuWue4+SvuKZ2HjBj239RFe0GPAcOz
   oPShqsUJNTkoaDf9nS8VYVRb6JiFfZfUi9S6c0wLkTVMjXyklp+bhvk0S
   61BAzqBzPNLkwvA022oaOI31bNtg+0KjaJDUBzN0jADOdq2TSG5iBrpiZ
   Kr4uXIAGhNcPwKqKnVJ6JsIBjoM13etDEqphtr7ROFISEbpBmX1ZiQU2Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475727098"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="475727098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="828579783"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="828579783"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:21:57 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id BA4DE580D42;
        Tue,  7 Nov 2023 03:21:54 -0800 (PST)
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
Subject: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules switching
Date:   Tue,  7 Nov 2023 06:20:17 -0500
Message-Id: <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In the current taprio code for dynamic schedule change,
admin/oper schedule switching happens immediately when
should_change_schedules() is true. Then the last entry of
the old admin schedule stops being valid anymore from
taprio_dequeue_from_txq’s perspective.

To solve this, we have to delay the switch_schedules() call via
the new cycle_time_correction variable. The variable serves 2
purposes:
1. Upon entering advance_sched(), if the value is set to a
non-initialized value, it indicates that we need to change
schedule.
2. Store the cycle time correction value which will be used for
negative or positive correction.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2e1949de4171..dee103647823 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
 #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
 #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
+#define INIT_CYCLE_TIME_CORRECTION S64_MIN
 
 struct sched_entry {
 	/* Durations between this GCL entry and the GCL entry where the
@@ -75,6 +76,7 @@ struct sched_gate_list {
 	ktime_t cycle_end_time;
 	s64 cycle_time;
 	s64 cycle_time_extension;
+	s64 cycle_time_correction;
 	s64 base_time;
 };
 
@@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 	admin = rcu_dereference_protected(q->admin_sched,
 					  lockdep_is_held(&q->current_entry_lock));
 
-	if (!oper)
+	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
+		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
 		switch_schedules(q, &admin, &oper);
+	}
 
 	/* This can happen in two cases: 1. this is the very first run
 	 * of this function (i.e. we weren't running any schedule
@@ -981,7 +985,7 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
 		 * schedule runs.
 		 */
 		end_time = sched_base_time(admin);
-		switch_schedules(q, &admin, &oper);
+		oper->cycle_time_correction = 0;
 	}
 
 	next->end_time = end_time;
@@ -1174,6 +1178,7 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 	}
 
 	taprio_calculate_gate_durations(q, new);
+	new->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
 
 	return 0;
 }
-- 
2.25.1

