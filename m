Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D610792447
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 17:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjIEP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbjIECkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:40:15 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD66E6;
        Mon,  4 Sep 2023 19:40:10 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3852dg4t095690;
        Tue, 5 Sep 2023 10:39:42 +0800 (+08)
        (envelope-from Wenchao.Chen@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RfqQY4hNyz2RD6Z7;
        Tue,  5 Sep 2023 10:36:53 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 5 Sep
 2023 10:39:40 +0800
From:   Wenchao Chen <wenchao.chen@unisoc.com>
To:     <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wenchao.chen666@gmail.com>, <zhenxiong.lai@unisoc.com>,
        <yuelin.tang@unisoc.com>, Wenchao Chen <wenchao.chen@unisoc.com>
Subject: [PATCH V3 2/2] mmc: hsq: dynamic adjustment of hsq->depth
Date:   Tue, 5 Sep 2023 10:39:21 +0800
Message-ID: <20230905023921.10766-3-wenchao.chen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905023921.10766-1-wenchao.chen@unisoc.com>
References: <20230905023921.10766-1-wenchao.chen@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 3852dg4t095690
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
 drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/mmc_hsq.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 8556cacb21a1..0984c39108ba 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -21,6 +21,31 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
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
+		if (mrq && mrq->data &&
+			(mrq->data->blksz * mrq->data->blocks == 4096) &&
+			(mrq->data->flags & MMC_DATA_WRITE))
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
@@ -42,6 +67,8 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
 		return;
 	}
 
+	mmc_hsq_modify_threshold(hsq);
+
 	slot = &hsq->slot[hsq->next_tag];
 	hsq->mrq = slot->mrq;
 	hsq->qcnt--;
diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
index aa5c4543b55f..dd352a6ac32a 100644
--- a/drivers/mmc/host/mmc_hsq.h
+++ b/drivers/mmc/host/mmc_hsq.h
@@ -10,6 +10,11 @@
  * flight to avoid a long latency.
  */
 #define HSQ_NORMAL_DEPTH	2
+/*
+ * For 4k random writes, we allow hsq_depth to increase to 5
+ * for better performance.
+ */
+#define HSQ_PERFORMANCE_DEPTH	5
 
 struct hsq_slot {
 	struct mmc_request *mrq;
-- 
2.17.1

