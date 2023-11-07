Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8787E3B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjKGLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjKGLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:22:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB4ED;
        Tue,  7 Nov 2023 03:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699356134; x=1730892134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTJNmm6maYeBIBNzxeaSXpjj2cPTvW1Qy7oFWpBrI8M=;
  b=auywIVi2HFm3cqYdNE/C9pvqVjocLzhsBptAiZwCVqYNEjbfgYNCPsG5
   md85ps8gCX8Fu5v8/XsN+XcBmcfk+2GCTvryrAoxxMPncvbvW9zTZXgqK
   INMA5KaKw1aXUspSrFn7e380L4b8DEaTuwVYHKHWveSz/djjiXjb19xxD
   xECseTfey3kfA0RNLVibWVNRylW+rPFJMMKUQVwsqowK6YRZoSZ1hCxf6
   ssVsx62t4NnsWtcmg3Pdsg0VRjWIUsyvg4sHnZ5kcXMZyllVtWFE4fsSR
   hfLm9QsuwlPfbYAgTzVyd5VcaXSiRIvFBP6v/P+kNyJW7VlNNuIht/8vb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393382991"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="393382991"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766285654"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="766285654"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 03:22:12 -0800
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
        by linux.intel.com (Postfix) with ESMTP id C8862580D61;
        Tue,  7 Nov 2023 03:22:09 -0800 (PST)
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
Subject: [PATCH v2 net 6/7] net/sched: taprio: fix q->current_entry is NULL before its expiry
Date:   Tue,  7 Nov 2023 06:20:22 -0500
Message-Id: <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issue of prematurely setting q->current_entry to NULL in the
setup_first_end_time() function when a new admin schedule arrives
while the oper schedule is still running but hasn't transitioned yet.
This premature setting causes problems because any reference to
q->current_entry, such as in taprio_dequeue(), will result in NULL
during this period, which is incorrect. q->current_entry should remain
valid until the currently running entry expires.

To address this issue, only set q->current_entry to NULL when there is
no oper schedule currently running.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 01b114edec30..c60e9e7ac193 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1375,7 +1375,8 @@ static void setup_first_end_time(struct taprio_sched *q,
 			first->gate_close_time[tc] = ktime_add_ns(base, first->gate_duration[tc]);
 	}
 
-	rcu_assign_pointer(q->current_entry, NULL);
+	if (!hrtimer_active(&q->advance_timer))
+		rcu_assign_pointer(q->current_entry, NULL);
 }
 
 static void taprio_start_sched(struct Qdisc *sch,
-- 
2.25.1

