Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3C7CA699
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjJPLUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjJPLUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:20:51 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EDE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:20:47 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S8F606VXcz4xVbs;
        Mon, 16 Oct 2023 19:20:40 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 39GBKaTY026390;
        Mon, 16 Oct 2023 19:20:36 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 16 Oct 2023 19:20:39 +0800 (CST)
Date:   Mon, 16 Oct 2023 19:20:39 +0800 (CST)
X-Zmail-TransId: 2b07652d1c87ffffffffe0c-49d3c
X-Mailer: Zmail v1.0
Message-ID: <202310161920399921184@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjaGVkL3BzaTogVXBkYXRlIHBvbGwgdG8gcnRwb2xsIGluIHJlbGF0ZWTCoGNvbW1lbnRz?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39GBKaTY026390
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652D1C88.000/4S8F606VXcz4xVbs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Yu <fan.yu9@zte.com.cn>

The trigger code is distinct between privileged and unprivileged after the
previous commit:

 65457b74aa94 ("sched/psi: Rename existing poll members in preparation")

But some comments have not been modified along with the code, so they
need to be updated.

This will help readers better understand the code.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/sched/psi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 519bc922a960..23927ed34f4d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -596,7 +596,7 @@ static void init_rtpoll_triggers(struct psi_group *group, u64 now)
 	group->rtpoll_next_update = now + group->rtpoll_min_period;
 }

-/* Schedule polling if it's not already scheduled or forced. */
+/* Schedule rtpolling if it's not already scheduled or forced. */
 static void psi_schedule_rtpoll_work(struct psi_group *group, unsigned long delay,
 				   bool force)
 {
@@ -636,37 +636,37 @@ static void psi_rtpoll_work(struct psi_group *group)

 	if (now > group->rtpoll_until) {
 		/*
-		 * We are either about to start or might stop polling if no
-		 * state change was recorded. Resetting poll_scheduled leaves
+		 * We are either about to start or might stop rtpolling if no
+		 * state change was recorded. Resetting rtpoll_scheduled leaves
 		 * a small window for psi_group_change to sneak in and schedule
-		 * an immediate poll_work before we get to rescheduling. One
-		 * potential extra wakeup at the end of the polling window
-		 * should be negligible and polling_next_update still keeps
+		 * an immediate rtpoll_work before we get to rescheduling. One
+		 * potential extra wakeup at the end of the rtpolling window
+		 * should be negligible and rtpoll_next_update still keeps
 		 * updates correctly on schedule.
 		 */
 		atomic_set(&group->rtpoll_scheduled, 0);
 		/*
-		 * A task change can race with the poll worker that is supposed to
+		 * A task change can race with the rtpoll worker that is supposed to
 		 * report on it. To avoid missing events, ensure ordering between
-		 * poll_scheduled and the task state accesses, such that if the poll
-		 * worker misses the state update, the task change is guaranteed to
-		 * reschedule the poll worker:
+		 * rtpoll_scheduled and the task state accesses, such that if the
+		 * rtpoll worker misses the state update, the task change is
+		 * guaranteed to reschedule the rtpoll worker:
 		 *
-		 * poll worker:
-		 *   atomic_set(poll_scheduled, 0)
+		 * rtpoll worker:
+		 *   atomic_set(rtpoll_scheduled, 0)
 		 *   smp_mb()
 		 *   LOAD states
 		 *
 		 * task change:
 		 *   STORE states
-		 *   if atomic_xchg(poll_scheduled, 1) == 0:
-		 *     schedule poll worker
+		 *   if atomic_xchg(rtpoll_scheduled, 1) == 0:
+		 *     schedule rtpoll worker
 		 *
 		 * The atomic_xchg() implies a full barrier.
 		 */
 		smp_mb();
 	} else {
-		/* Polling window is not over, keep rescheduling */
+		/* Rtpolling window is not over, keep rescheduling */
 		force_reschedule = true;
 	}

@@ -674,7 +674,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 	collect_percpu_times(group, PSI_POLL, &changed_states);

 	if (changed_states & group->rtpoll_states) {
-		/* Initialize trigger windows when entering polling mode */
+		/* Initialize trigger windows when entering rtpolling mode */
 		if (now > group->rtpoll_until)
 			init_rtpoll_triggers(group, now);

-- 
2.25.1
