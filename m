Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2927854F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjHWKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHWKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:10:28 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6DEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:10:24 -0700 (PDT)
X-QQ-mid: bizesmtp79t1692785231tryd7oqn
Received: from localhost.localdomain ( [1.202.39.170])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 23 Aug 2023 18:07:09 +0800 (CST)
X-QQ-SSF: 01400000000000C0E000000A0000000
X-QQ-FEAT: CR3LFp2JE4mL/5mvuvva9T9icGlli5o/Ow1+i5QPsOyYqfMGdK+Q8jt9CXGV/
        ftDYgLm81uhFPTf5vsL4F4wTWcBwPTWCNSrfp9DH1kc6MJPhZqVjphqtbbgh5e0C2CzGiI3
        v50mMjG/TugQN6SIpC/As1hfdODeyXvAPT7JeNNhPOBxEY8/obIJhEkoFLHAZilPqhO0sR5
        1vcesCVyuiO95weIDeVpYLRLGthPYksPs4wS3MASGU8pR9XUpIKtBNBikchc+IrtfLdYpsJ
        ilx3jShJlJoJ/2goNWh1jPPlTfiRG/mVa8KGuIM/4Pj+ZqEjiQRaaJnhOXxS/NJ+8M0lTGa
        x2zZErCaocCtlbk9OjrXZThOeS405GUBKRaqd2WbpmYattzi2/AhSNU9tmAhg==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6244899448066092630
From:   Wang You <wangyoua@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Wang You <wangyoua@uniontech.com>
Subject: [RFC] remove preempt in do_sched_yield
Date:   Wed, 23 Aug 2023 18:07:05 +0800
Message-Id: <20230823100705.5363-1-wangyoua@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see do_sched_yield's irq disable cover preempt disable. In this
function, I think preempt op may not work, or it may have some
special effect ? Thanks.

Signed-off-by: Wang You <wangyoua@uniontech.com>
---
 kernel/sched/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..b255e54c1d38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8487,10 +8487,7 @@ static void do_sched_yield(void)
 
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
-
-	preempt_disable();
 	rq_unlock_irq(rq, &rf);
-	sched_preempt_enable_no_resched();
 
 	schedule();
 }
-- 
2.20.1

