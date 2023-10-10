Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DE7BF64A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJJInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjJJInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:43:14 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D6D97
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:43:12 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S4Ttz3mTGz4xPYj;
        Tue, 10 Oct 2023 16:43:07 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 39A8gv4T040928;
        Tue, 10 Oct 2023 16:42:57 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 16:42:59 +0800 (CST)
Date:   Tue, 10 Oct 2023 16:42:59 +0800 (CST)
X-Zmail-TransId: 2b0465250e934f1-ce342
X-Mailer: Zmail v1.0
Message-ID: <202310101642598576993@zte.com.cn>
In-Reply-To: <ZST/WggW4hSVs9d4@gmail.com>
References: CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com,202310101109350209198@zte.com.cn,ZST/WggW4hSVs9d4@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMy80XSBzY2hlZC9wc2k6IHVwZGF0ZSBydHBvbGxfbmV4dF91cGRhdGUgYWZ0ZXIgdXBkYXRlIHRyaWdnZXJzIGFuZCBydHBvbGxfdG90YWw=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A8gv4T040928
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65250E9B.000/4S4Ttz3mTGz4xPYj
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

Update group->rtpoll_next_update after called update_triggers() and
update rtpoll_total. This will prevent bugs if update_triggers() uses
group->rtpoll_next_update in the future, and it makes more sense
to set the next update time after we finished the current update.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 143f8eb34f9d..79f8db0c6150 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -704,12 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		group->rtpoll_next_update = now + group->rtpoll_min_period;
 		if (changed_states & group->rtpoll_states) {
 			update_triggers(group, now, &update_total, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
 		}
+		group->rtpoll_next_update = now + group->rtpoll_min_period;
 	}

 	psi_schedule_rtpoll_work(group,
-- 
2.25.1
