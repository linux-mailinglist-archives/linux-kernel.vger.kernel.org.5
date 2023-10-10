Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC87BF14A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441918AbjJJDVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378482AbjJJDVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:21:00 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C1A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:20:58 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S4LlC0mGWz8XrRQ;
        Tue, 10 Oct 2023 11:20:55 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl2.zte.com.cn with SMTP id 39A3Khen070641;
        Tue, 10 Oct 2023 11:20:43 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp06[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 11:20:44 +0800 (CST)
Date:   Tue, 10 Oct 2023 11:20:44 +0800 (CST)
X-Zmail-TransId: 2b086524c30cffffffffe81-35b9a
X-Mailer: Zmail v1.0
Message-ID: <202310101120445530640@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>, <zhang.yunkai@zte.com.cn>,
        <ran.xiaokai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjIgMi80XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMKIHVubmVjZXNzYXJ5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39A3Khen070641
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524C317.000/4S4LlC0mGWz8XrRQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When psimon wakes up and there are no state changes for rtpoll_states,
it's unnecessary to update triggers and rtpoll_total because the pressures
being monitored by user had not changed.
This will help to slightly reduce unnecessary computations of psi.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
Cc: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/sched/psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fec8aab096a8..143f8eb34f9d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -705,10 +705,11 @@ static void psi_rtpoll_work(struct psi_group *group)

 	if (now >= group->rtpoll_next_update) {
 		group->rtpoll_next_update = now + group->rtpoll_min_period;
-		update_triggers(group, now, &update_total, PSI_POLL);
-		if (update_total)
+		if (changed_states & group->rtpoll_states) {
+			update_triggers(group, now, &update_total, PSI_POLL);
 			memcpy(group->rtpoll_total, group->total[PSI_POLL],
 				   sizeof(group->rtpoll_total));
+		}
 	}

 	psi_schedule_rtpoll_work(group,
-- 
2.25.1
