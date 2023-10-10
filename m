Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262627BF160
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441986AbjJJDYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441983AbjJJDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:24:15 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58BAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:24:13 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S4Lpy1sYCz8XrRG;
        Tue, 10 Oct 2023 11:24:10 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl1.zte.com.cn with SMTP id 39A3O1FY006580;
        Tue, 10 Oct 2023 11:24:01 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 11:24:03 +0800 (CST)
Date:   Tue, 10 Oct 2023 11:24:03 +0800 (CST)
X-Zmail-TransId: 2b056524c3d3ffffffffb7a-bc80c
X-Mailer: Zmail v1.0
Message-ID: <202310101124033093148@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMy80XcKgc2NoZWQvcHNpOiB1cGRhdGUgcnRwb2xsX25leHRfdXBkYXRlIGFmdGVyIHVwZGF0ZQogdHJpZ2dlcnMgYW5kIHJ0cG9sbF90b3RhbA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A3O1FY006580
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524C3DA.000/4S4Lpy1sYCz8XrRG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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
