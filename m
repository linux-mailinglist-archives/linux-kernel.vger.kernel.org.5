Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79F79FFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbjINJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjINJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:11:10 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608A1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:10:36 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RmWkc16cXz8XrRJ;
        Thu, 14 Sep 2023 17:10:32 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl2.zte.com.cn with SMTP id 38E9AHQ1005028;
        Thu, 14 Sep 2023 17:10:17 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 14 Sep 2023 17:10:19 +0800 (CST)
Date:   Thu, 14 Sep 2023 17:10:19 +0800 (CST)
X-Zmail-TransId: 2b046502cdfbffffffffb51-4cd21
X-Mailer: Zmail v1.0
Message-ID: <202309141710195376952@zte.com.cn>
In-Reply-To: <202309141353492446199@zte.com.cn>
References: 202309132044261713252@zte.com.cn,CAJuCfpF_gSdfk_csny-6p661gfGy41w0V2QwoCSY02KdeXMLEA@mail.gmail.com,202309141002037888418@zte.com.cn,202309141353492446199@zte.com.cn
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 38E9AHQ1005028
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6502CE08.000/4RmWkc16cXz8XrRJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update_total in update_triggers() is also only used by psi_rtpoll_work().
And when changed_states & group->rtpoll_states is true, update_total
should also be true, so try to delete update_total, please see below:

---
 kernel/sched/psi.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..744ba8b4e029 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -434,14 +434,13 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }

-static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
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
@@ -471,14 +470,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
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
@@ -499,8 +490,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
-
-	return now + group->rtpoll_min_period;
 }

 static u64 update_averages(struct psi_group *group, u64 now)
@@ -561,7 +550,6 @@ static void psi_avgs_work(struct work_struct *work)
 	struct delayed_work *dwork;
 	struct psi_group *group;
 	u32 changed_states;
-	bool update_total;
 	u64 now;

 	dwork = to_delayed_work(work);
@@ -580,7 +568,7 @@ static void psi_avgs_work(struct work_struct *work)
 	 * go - see calc_avgs() and missed_periods.
 	 */
 	if (now >= group->avg_next_update) {
-		update_triggers(group, now, &update_total, PSI_AVGS);
+		update_triggers(group, now, PSI_AVGS);
 		group->avg_next_update = update_averages(group, now);
 	}

@@ -636,7 +624,6 @@ static void psi_rtpoll_work(struct psi_group *group)
 {
 	bool force_reschedule = false;
 	u32 changed_states;
-	bool update_total;
 	u64 now;

 	mutex_lock(&group->rtpoll_trigger_lock);
@@ -702,10 +689,13 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
-		if (update_total)
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
+
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
+		}
 	}

 	psi_schedule_rtpoll_work(group,
-- 
2.25.1
