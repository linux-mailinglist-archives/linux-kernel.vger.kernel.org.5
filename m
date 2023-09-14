Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBA79F789
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjINCHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjINCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:06:43 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050B1B19D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 19:02:21 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RmLDT6ZDnz4xPYd;
        Thu, 14 Sep 2023 10:02:17 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 38E222xs027528;
        Thu, 14 Sep 2023 10:02:02 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 14 Sep 2023 10:02:03 +0800 (CST)
Date:   Thu, 14 Sep 2023 10:02:03 +0800 (CST)
X-Zmail-TransId: 2b066502699b3e1-8c571
X-Mailer: Zmail v1.0
Message-ID: <202309141002037888418@zte.com.cn>
In-Reply-To: <CAJuCfpF_gSdfk_csny-6p661gfGy41w0V2QwoCSY02KdeXMLEA@mail.gmail.com>
References: 202309132044261713252@zte.com.cn,CAJuCfpF_gSdfk_csny-6p661gfGy41w0V2QwoCSY02KdeXMLEA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38E222xs027528
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 650269A9.000/4RmLDT6ZDnz4xPYd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  I don't think that's your intention here, it is?
It's an omission, rtpoll_next_update should be update, thanks
for your reviewing. I did a simple test and did not see delay,
maybe it is other reason.

And I read update_triggers() again, it always return 
now + group->rtpoll_min_period, and this return
value is only used by psi_rtpoll_work(). So I think
there is no need for update_triggers() to return
value. So what about this version see below:

---
 kernel/sched/psi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..b6b8af2cf311 100644
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
@@ -499,8 +499,6 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
 	}
-
-	return now + group->rtpoll_min_period;
 }

 static u64 update_averages(struct psi_group *group, u64 now)
@@ -699,10 +697,11 @@ static void psi_rtpoll_work(struct psi_group *group)
 	if (now > group->rtpoll_until) {
 		group->rtpoll_next_update = ULLONG_MAX;
 		goto out;
-	}
+	} else
+		group->rtpoll_next_update = now + group->rtpoll_min_period;

-	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
+	if ((changed_states & group->rtpoll_states) && (now >= group->rtpoll_next_update)) {
+		update_triggers(group, now, &update_total, PSI_POLL);
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
-- 
2.25.1
