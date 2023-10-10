Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A77BF173
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442057AbjJJD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442029AbjJJD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:28:53 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6441BA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:28:51 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S4LwH3YXvz4xPYZ;
        Tue, 10 Oct 2023 11:28:47 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 39A3SfR2081972;
        Tue, 10 Oct 2023 11:28:41 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 11:28:42 +0800 (CST)
Date:   Tue, 10 Oct 2023 11:28:42 +0800 (CST)
X-Zmail-TransId: 2b066524c4eaffffffffb19-8be99
X-Mailer: Zmail v1.0
Message-ID: <202310101128424095908@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgNC80XcKgc2NoZWQvcHNpOiBEZWxldGUgdGhlIGZ1bmN0aW9uIHBhcmFtZXRlciB1cGRhdGVfdG90YWwgb2YKIHVwZGF0ZV90cmlnZ2Vycygp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39A3SfR2081972
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524C4EF.000/4S4LwH3YXvz4xPYZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

The parameter update_total in update_triggers() is useless after patch
"sched/psi: Avoid update triggers and rtpoll_total when it is unnecessary".
If changed_states & group->rtpoll_states is true, new_stall in
update_triggers() will be true, then update_total should also
be true. We have no need for update_total to help judgment
whether to update rtpoll_total, so delete it.
This makes the code cleaner & simpler.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/sched/psi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 79f8db0c6150..44a78774ae87 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -434,14 +434,13 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }

-static void update_triggers(struct psi_group *group, u64 now, bool *update_total,
+static void update_triggers(struct psi_group *group, u64 now,
 						   enum psi_aggregators aggregator)
 {
 	struct psi_trigger *t;
 	u64 *total = group->total[aggregator];
 	struct list_head *triggers;
 	u64 *aggregator_total;
-	*update_total = false;

 	if (aggregator == PSI_AVGS) {
 		triggers = &group->avg_triggers;
@@ -471,14 +470,6 @@ static void update_triggers(struct psi_group *group, u64 now, bool *update_total
 		 * events without dropping any).
 		 */
 		if (new_stall) {
-			/*
-			 * Multiple triggers might be looking at the same state,
-			 * remember to update group->polling_total[] once we've
-			 * been through all of them. Also remember to extend the
-			 * polling time if we see new stall activity.
-			 */
-			*update_total = true;
-
 			/* Calculate growth since last update */
 			growth = window_update(&t->win, now, total[t->state]);
 			if (!t->pending_event) {
@@ -563,7 +554,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool update_total;
 	u64 now;

 	dwork = to_delayed_work(work);
@@ -582,7 +572,7 @@ static void psi_avgs_work(struct work_struct *work)
 	 * go - see calc_avgs() and missed_periods.
 	 */
 	if (now >= group->avg_next_update) {
-		update_triggers(group, now, &update_total, PSI_AVGS);
+		update_triggers(group, now, PSI_AVGS);
 		group->avg_next_update = update_averages(group, now);
 	}

@@ -638,7 +628,6 @@ static void psi_rtpoll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
-	bool update_total;
 	u64 now;

 	mutex_lock(&group->rtpoll_trigger_lock);
@@ -705,7 +694,7 @@ static void psi_rtpoll_work(struct psi_group *group)

 	if (now >= group->rtpoll_next_update) {
 		if (changed_states & group->rtpoll_states) {
-			update_triggers(group, now, &update_total, PSI_POLL);
+			update_triggers(group, now, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
 		}
-- 
2.25.1
