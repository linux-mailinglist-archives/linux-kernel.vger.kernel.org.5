Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C288E7BDBAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376390AbjJIMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346546AbjJIMYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:24:34 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F4E8E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:24:32 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S3yrv1cQ3z4xPYc;
        Mon,  9 Oct 2023 20:24:31 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 399COPfh004233;
        Mon, 9 Oct 2023 20:24:25 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Oct 2023 20:24:28 +0800 (CST)
Date:   Mon, 9 Oct 2023 20:24:28 +0800 (CST)
X-Zmail-TransId: 2b066523f0fc1e7-7a974
X-Mailer: Zmail v1.0
Message-ID: <202310092024289721617@zte.com.cn>
In-Reply-To: <ZSPayGSz6HQBp+3W@gmail.com>
References: CAJuCfpHV+Tf+-YqdWFwQNAeQJU5aqOM56R2GzbehFaFQcHuxAg@mail.gmail.com,202310071421311735972@zte.com.cn,ZSPayGSz6HQBp+3W@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMS8zXSBzY2hlZC9wc2k6IENoYW5nZSB1cGRhdGVfdHJpZ2dlcnMoKSB0byBhIHZvaWQgZnVuY3Rpb24=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 399COPfh004233
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6523F0FF.001/4S3yrv1cQ3z4xPYc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Update_triggers() always return now + group->rtpoll_min_period, and the
return value is only used by psi_rtpoll_work(), so change update_triggers()
to a void function, let group->rtpoll_next_update = now +
group->rtpoll_min_period directly.
This will avoid unnecessary function return value passing.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/psi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1d0f634725a6..be853f227e40 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -434,7 +434,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }

-static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
+static void update_triggers(struct psi_group *group, u64 now, bool *update_total,
 						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
@@ -503,8 +503,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
-
-	return now + group->rtpoll_min_period;
 }

 static u64 update_averages(struct psi_group *group, u64 now)
@@ -706,7 +704,8 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
+		update_triggers(group, now, &update_total, PSI_POLL);
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
-- 
2.25.1
