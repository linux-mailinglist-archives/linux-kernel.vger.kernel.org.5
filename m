Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64B79FB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjINFyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjINFx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:53:59 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4CBC1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:53:54 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RmRMf0Xmzz8XrRH;
        Thu, 14 Sep 2023 13:53:50 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 38E5rlXs069734;
        Thu, 14 Sep 2023 13:53:47 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 14 Sep 2023 13:53:49 +0800 (CST)
Date:   Thu, 14 Sep 2023 13:53:49 +0800 (CST)
X-Zmail-TransId: 2b0665029fedffffffffd82-56d4a
X-Mailer: Zmail v1.0
Message-ID: <202309141353492446199@zte.com.cn>
In-Reply-To: <202309141002037888418@zte.com.cn>
References: 202309132044261713252@zte.com.cn,CAJuCfpF_gSdfk_csny-6p661gfGy41w0V2QwoCSY02KdeXMLEA@mail.gmail.com,202309141002037888418@zte.com.cn
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38E5rlXs069734
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65029FEE.000/4RmRMf0Xmzz8XrRH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see this version, thanks.

---
 kernel/sched/psi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..3fe96d77f275 100644
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
@@ -702,10 +700,14 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
-		if (update_total)
-			memcpy(group->rtpoll_total, group->total[PSI_POLL],
-				   sizeof(group->rtpoll_total));
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
+
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, &update_total, PSI_POLL);
+			if (update_total)
+				memcpy(group->rtpoll_total, group->total[PSI_POLL],
+					   sizeof(group->rtpoll_total));
+		}
 	}

 	psi_schedule_rtpoll_work(group,
-- 
2.25.1
