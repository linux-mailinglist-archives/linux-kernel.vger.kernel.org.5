Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E267BF13A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441941AbjJJDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:09:55 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B6E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:09:49 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S4LVK3g89z4xPYp;
        Tue, 10 Oct 2023 11:09:45 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 39A39XXP084207;
        Tue, 10 Oct 2023 11:09:33 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 11:09:35 +0800 (CST)
Date:   Tue, 10 Oct 2023 11:09:35 +0800 (CST)
X-Zmail-TransId: 2b076524c06f155-bf0e1
X-Mailer: Zmail v1.0
Message-ID: <202310101109350209198@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMS80XSBzY2hlZC9wc2k6IENoYW5nZSB1cGRhdGVfdHJpZ2dlcnMoKSB0byBhICd2b2lkJyBmdW5jdGlvbg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A39XXP084207
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524C079.001/4S4LVK3g89z4xPYp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Update_triggers() always returns now + group->rtpoll_min_period, and the
return value is only used by psi_rtpoll_work(), so change update_triggers()
to a void function, let group->rtpoll_next_update = now +
group->rtpoll_min_period directly.

This will avoid unnecessary function return value passing & simplifies
the function.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/sched/psi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1d0f634725a6..fec8aab096a8 100644
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
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
+		update_triggers(group, now, &update_total, PSI_POLL);
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
-- 
2.25.1
