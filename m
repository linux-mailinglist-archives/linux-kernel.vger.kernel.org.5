Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781C079E83F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjIMMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIMMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:44:37 -0400
X-Greylist: delayed 106189 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 05:44:33 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5571B19B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:44:33 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Rm0Wv3bX0z8XrRF;
        Wed, 13 Sep 2023 20:44:27 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl1.zte.com.cn with SMTP id 38DCiMrQ097700;
        Wed, 13 Sep 2023 20:44:22 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 13 Sep 2023 20:44:26 +0800 (CST)
Date:   Wed, 13 Sep 2023 20:44:26 +0800 (CST)
X-Zmail-TransId: 2b036501aeaa159-29757
X-Mailer: Zmail v1.0
Message-ID: <202309132044261713252@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <hannes@cmpxchg.org>, <surenb@google.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNjaGVkL3BzaTogQXZvaWTCoHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW7CoGl0IGlzIHVubmVjZXNzYXJ5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 38DCiMrQ097700
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6501AEAB.000/4Rm0Wv3bX0z8XrRF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When psimon wakes up and there are no state changes for rtpoll_states,
it's unnecessary to update triggers and rtpoll_total because the pressures
being monitored by user have not changed.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 81fca77397f6..e4463bb267c3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -701,7 +701,7 @@ static void psi_rtpoll_work(struct psi_group *group)
 		goto out;
 	}

-	if (now >= group->rtpoll_next_update) {
+	if ((changed_states & group->rtpoll_states) && (now >= group->rtpoll_next_update)) {
 		group->rtpoll_next_update = update_triggers(group, now, &update_total, PSI_POLL);
 		if (update_total)
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
-- 
2.25.1
