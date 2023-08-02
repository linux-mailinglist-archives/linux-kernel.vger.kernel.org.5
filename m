Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A076C2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHBCeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:34:06 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAC1139;
        Tue,  1 Aug 2023 19:34:04 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3722UWPq049048;
        Wed, 2 Aug 2023 10:30:32 +0800 (+08)
        (envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RFwrx0tqrz2NmLXW;
        Wed,  2 Aug 2023 10:28:49 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 2 Aug 2023 10:30:27 +0800
From:   Yunlong Xing <yunlong.xing@unisoc.com>
To:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <CLoehle@hyperstone.com>, <brauner@kernel.org>, <hare@suse.de>,
        <asuk4.q@gmail.com>, <avri.altman@wdc.com>, <beanhuo@micron.com>
CC:     <linus.walleij@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <hongyu.jin@unisoc.com>, <zhiguo.niu@unisoc.com>,
        <yunlong.xing23@gmail.com>, <yibin.ding@unisoc.com>,
        <dongliang.cui@unisoc.com>
Subject: [PATCH V2] mmc: block: Fix in_flight[issue_type] value error
Date:   Wed, 2 Aug 2023 10:30:23 +0800
Message-ID: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3722UWPq049048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yibin Ding <yibin.ding@unisoc.com>

For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
function is executed, the bitmap_tags corresponding to the
request will be cleared, that is, the request will be regarded as
idle. If the request is acquired by a different type of process at
this time, the issue_type of the request may change. It further
caused the value of mq->in_flight[issue_type] to be abnormal,
and a large number of requests could not be sent.

p1:					      p2:
mmc_blk_mq_complete_rq
  blk_mq_free_request
					      blk_mq_get_request
					        blk_mq_rq_ctx_init
mmc_blk_mq_dec_in_flight
  mmc_issue_type(mq, req)

This strategy can ensure the consistency of issue_type
before and after executing mmc_blk_mq_complete_rq.

Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
Cc: stable@vger.kernel.org
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
changes of v2: Sort local declarations in descending order of
line length
---
 drivers/mmc/core/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f701efb1fa78..b6f4be25b31b 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
 	mmc_blk_urgent_bkops(mq, mqrq);
 }
 
-static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
 {
 	unsigned long flags;
 	bool put_card;
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
@@ -2117,6 +2117,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
 static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
 				bool can_sleep)
 {
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct mmc_host *host = mq->card->host;
@@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
 			blk_mq_complete_request(req);
 	}
 
-	mmc_blk_mq_dec_in_flight(mq, req);
+	mmc_blk_mq_dec_in_flight(mq, issue_type);
 }
 
 void mmc_blk_mq_recovery(struct mmc_queue *mq)
-- 
2.25.1

