Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537E785081
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjHWGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjHWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:18:21 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8CCF1;
        Tue, 22 Aug 2023 23:18:17 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37N6Hsxh025248;
        Wed, 23 Aug 2023 14:17:54 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVwtp70Gjz2QM4RY;
        Wed, 23 Aug 2023 14:15:30 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 23 Aug
 2023 14:17:52 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2 1/2] mmc: queue: replace immediate with hsq->depth
Date:   Wed, 23 Aug 2023 14:17:33 +0800
Message-ID: <20230823061734.27479-2-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823061734.27479-1-wenchao.chen@unisoc.com>
References: <20230823061734.27479-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37N6Hsxh025248
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsq is similar to cqe, using hsq->depth to represent
the maximum processing capacity of hsq. We can adjust
hsq->depth according to the actual situation.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/core/queue.c   | 6 +-----
 drivers/mmc/host/mmc_hsq.c | 1 +
 drivers/mmc/host/mmc_hsq.h | 6 ++++++
 include/linux/mmc/host.h   | 1 +
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b396e3900717..a0a2412f62a7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 		break;
 	case MMC_ISSUE_ASYNC:
-		/*
-		 * For MMC host software queue, we only allow 2 requests in
-		 * flight to avoid a long latency.
-		 */
-		if (host->hsq_enabled && mq->in_flight[issue_type] > 2) {
+		if (host->hsq_enabled && mq->in_flight[issue_type] > host->hsq_depth) {
 			spin_unlock_irq(&mq->lock);
 			return BLK_STS_RESOURCE;
 		}
diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 424dc7b07858..8556cacb21a1 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
 	hsq->mmc = mmc;
 	hsq->mmc->cqe_private = hsq;
 	mmc->cqe_ops = &mmc_hsq_ops;
+	mmc->hsq_depth = HSQ_NORMAL_DEPTH;
 
 	for (i = 0; i < HSQ_NUM_SLOTS; i++)
 		hsq->tag_slot[i] = HSQ_INVALID_TAG;
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index 1808024fc6c5..aa5c4543b55f 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -5,6 +5,12 @@
 #define HSQ_NUM_SLOTS	64
 #define HSQ_INVALID_TAG	HSQ_NUM_SLOTS
 
+/*
+ * For MMC host software queue, we only allow 2 requests in
+ * flight to avoid a long latency.
+ */
+#define HSQ_NORMAL_DEPTH	2
+
 struct hsq_slot {
 	struct mmc_request *mrq;
 };
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 461d1543893b..1fd8b1dd8698 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -520,6 +520,7 @@ struct mmc_host {
 
 	/* Host Software Queue support */
 	bool			hsq_enabled;
+	int			hsq_depth;
 
 	u32			err_stats[MMC_ERR_MAX];
 	unsigned long		private[] ____cacheline_aligned;
-- 
2.17.1

