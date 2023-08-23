Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE378507F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjHWGSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHWGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:18:21 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085AE40;
        Tue, 22 Aug 2023 23:18:19 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37N6Hti6025267;
        Wed, 23 Aug 2023 14:17:55 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RVwtr1gmsz2QM4RY;
        Wed, 23 Aug 2023 14:15:32 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 23 Aug
 2023 14:17:53 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V2 2/2] mmc: hsq: dynamic adjustment of hsq->depth
Date:   Wed, 23 Aug 2023 14:17:34 +0800
Message-ID: <20230823061734.27479-3-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823061734.27479-1-wenchao.chen@unisoc.com>
References: <20230823061734.27479-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37N6Hti6025267
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing hsq_depth improves random write performance.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/mmc_hsq.c | 26 ++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 8556cacb21a1..8682a3d16a76 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -21,6 +21,30 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
 	mmc->ops->request(mmc, hsq->mrq);
 }
 
+static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
+{
+	struct mmc_host *mmc = hsq->mmc;
+	struct mmc_request *mrq;
+	struct hsq_slot *slot;
+	int need_change = 0;
+	int tag;
+
+	for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
+		slot = &hsq->slot[tag];
+		mrq = slot->mrq;
+		if (mrq && mrq->data && (mrq->data->blocks == HSQ_DATA_IS_4K)
+				&& (mrq->data->flags & MMC_DATA_WRITE))
+			need_change++;
+		else
+			break;
+	}
+
+	if (need_change > 1)
+		mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
+	else
+		mmc->hsq_depth = HSQ_NORMAL_DEPTH;
+}
+
 static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 {
 	struct mmc_host *mmc = hsq->mmc;
@@ -42,6 +66,8 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 		return;
 	}
 
+	mmc_hsq_modify_threshold(hsq);
+
 	slot = &hsq->slot[hsq->next_tag];
 	hsq->mrq = slot->mrq;
 	hsq->qcnt--;
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index aa5c4543b55f..fc031e38f1e0 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -10,6 +10,8 @@
  * flight to avoid a long latency.
  */
 #define HSQ_NORMAL_DEPTH	2
+#define HSQ_PERFORMANCE_DEPTH	5
+#define HSQ_DATA_IS_4K	8
 
 struct hsq_slot {
 	struct mmc_request *mrq;
-- 
2.17.1

