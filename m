Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56507BDC12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376533AbjJIMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbjJIMcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:32:22 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B1211F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:30:49 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S3z072YT1z4xPYY;
        Mon,  9 Oct 2023 20:30:47 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 399CUeF1008403;
        Mon, 9 Oct 2023 20:30:40 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 9 Oct 2023 20:30:43 +0800 (CST)
Date:   Mon, 9 Oct 2023 20:30:43 +0800 (CST)
X-Zmail-TransId: 2b076523f2730b8-e8417
X-Mailer: Zmail v1.0
Message-ID: <202310092030430136422@zte.com.cn>
In-Reply-To: <ZSPayGSz6HQBp+3W@gmail.com>
References: CAJuCfpHV+Tf+-YqdWFwQNAeQJU5aqOM56R2GzbehFaFQcHuxAg@mail.gmail.com,202310071421311735972@zte.com.cn,ZSPayGSz6HQBp+3W@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>
Cc:     <hannes@cmpxchg.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMi8zXSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 399CUeF1008403
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6523F277.000/4S3z072YT1z4xPYY
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

When psimon wakes up and there are no state changes for rtpoll_states,
it's unnecessary to update triggers and rtpoll_total because the pressures
being monitored by user had not changed. This will help to slightly reduce
unnecessary computations of psi.

And update group->rtpoll_next_update after called update_triggers() and
update rtpoll_total. This will prevent bugs if update_triggers() uses
group->rtpoll_next_update in the future, and it makes more sense
to set the next update time after we finished the current update.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index be853f227e40..79f8db0c6150 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		update_triggers(group, now, &update_total, PSI_POLL);
-		group->rtpoll_next_update = now + group->rtpoll_min_period;
-		if (update_total)
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, &update_total, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
+		}
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 	}

 	psi_schedule_rtpoll_work(group,
-- 
2.25.1
