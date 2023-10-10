Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5ED7BF627
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJJIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjJJIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:38:04 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBD211C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:36:50 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S4Tlg3vtrz4xVbp;
        Tue, 10 Oct 2023 16:36:47 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 39A8aWbm002933;
        Tue, 10 Oct 2023 16:36:32 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 16:36:34 +0800 (CST)
Date:   Tue, 10 Oct 2023 16:36:34 +0800 (CST)
X-Zmail-TransId: 2b0765250d12ffffffffdd9-60ac7
X-Mailer: Zmail v1.0
Message-ID: <202310101636345668937@zte.com.cn>
In-Reply-To: <ZST/WggW4hSVs9d4@gmail.com>
References: CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com,202310101109350209198@zte.com.cn,ZST/WggW4hSVs9d4@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMS80XSBzY2hlZC9wc2k6IENoYW5nZSB1cGRhdGVfdHJpZ2dlcnMoKSB0byBhICd2b2lkJyBmdW5jdGlvbg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39A8aWbm002933
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65250D1F.000/4S4Tlg3vtrz4xVbp
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
