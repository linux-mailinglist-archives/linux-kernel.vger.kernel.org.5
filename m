Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796B77BF63C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJJIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJJIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:41:24 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC212B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:41:21 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S4Trt6KwHz4xVbs;
        Tue, 10 Oct 2023 16:41:18 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 39A8f4oH037767;
        Tue, 10 Oct 2023 16:41:04 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 16:41:07 +0800 (CST)
Date:   Tue, 10 Oct 2023 16:41:07 +0800 (CST)
X-Zmail-TransId: 2b0465250e23ffffffffc85-c9adb
X-Mailer: Zmail v1.0
Message-ID: <202310101641075436843@zte.com.cn>
In-Reply-To: <ZST/WggW4hSVs9d4@gmail.com>
References: CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com,202310101109350209198@zte.com.cn,ZST/WggW4hSVs9d4@gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <mingo@kernel.org>, <surenb@google.com>, <peterz@infradead.org>,
        <hannes@cmpxchg.org>
Cc:     <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <mingo@redhat.com>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMi80XSBzY2hlZC9wc2k6IEF2b2lkIHVwZGF0ZSB0cmlnZ2VycyBhbmQgcnRwb2xsX3RvdGFsIHdoZW4gaXQgaXMgdW5uZWNlc3Nhcnk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A8f4oH037767
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65250E2E.002/4S4Trt6KwHz4xVbs
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
index be853f227e40..143f8eb34f9d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -704,11 +704,12 @@ static void psi_rtpoll_work(struct psi_group *group)
 	}

 	if (now >= group->rtpoll_next_update) {
-		update_triggers(group, now, &update_total, PSI_POLL);
 		group->rtpoll_next_update = now + group->rtpoll_min_period;
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
