Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CA7FD331
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjK2Jsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjK2JsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:48:06 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719719BC;
        Wed, 29 Nov 2023 01:48:11 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SgDsL5CSTzMnVg;
        Wed, 29 Nov 2023 17:43:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 Nov 2023 17:48:09 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 6/6] RDMA/hns: Improve the readability of free mr uninit
Date:   Wed, 29 Nov 2023 17:44:34 +0800
Message-ID: <20231129094434.134528-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
References: <20231129094434.134528-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Extract uninit functions of free mr qp, cq and pd to improve
readability.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 73 ++++++++++++++--------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 538f3e8949fc..be02034a8818 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2573,6 +2573,19 @@ static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
 	return pd;
 }
 
+static void free_mr_uninit_pd(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_pd)
+		return;
+
+	hns_roce_dealloc_pd(&free_mr->rsv_pd->ibpd, NULL);
+	kfree(free_mr->rsv_pd);
+	free_mr->rsv_pd = NULL;
+}
+
 static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
@@ -2607,6 +2620,19 @@ static struct ib_cq *free_mr_init_cq(struct hns_roce_dev *hr_dev)
 	return cq;
 }
 
+static void free_mr_uninit_cq(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_cq)
+		return;
+
+	hns_roce_destroy_cq(&free_mr->rsv_cq->ib_cq, NULL);
+	kfree(free_mr->rsv_cq);
+	free_mr->rsv_cq = NULL;
+}
+
 static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
 			   struct ib_qp_init_attr *init_attr, int i)
 {
@@ -2638,6 +2664,19 @@ static int free_mr_init_qp(struct hns_roce_dev *hr_dev, struct ib_cq *cq,
 	return 0;
 }
 
+static void free_mr_uninit_qp(struct hns_roce_dev *hr_dev, int i)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+
+	if (!free_mr->rsv_qp[i])
+		return;
+
+	hns_roce_v2_destroy_qp(&free_mr->rsv_qp[i]->ibqp, NULL);
+	kfree(free_mr->rsv_qp[i]);
+	free_mr->rsv_qp[i] = NULL;
+}
+
 static void free_mr_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
@@ -2645,26 +2684,12 @@ static void free_mr_exit(struct hns_roce_dev *hr_dev)
 	struct ib_qp *qp;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
-		if (free_mr->rsv_qp[i]) {
-			qp = &free_mr->rsv_qp[i]->ibqp;
-			hns_roce_v2_destroy_qp(qp, NULL);
-			kfree(free_mr->rsv_qp[i]);
-			free_mr->rsv_qp[i] = NULL;
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++)
+		free_mr_uninit_qp(hr_dev, i);
 
-	if (free_mr->rsv_cq) {
-		hns_roce_destroy_cq(&free_mr->rsv_cq->ib_cq, NULL);
-		kfree(free_mr->rsv_cq);
-		free_mr->rsv_cq = NULL;
-	}
+	free_mr_uninit_cq(hr_dev);
 
-	if (free_mr->rsv_pd) {
-		hns_roce_dealloc_pd(&free_mr->rsv_pd->ibpd, NULL);
-		kfree(free_mr->rsv_pd);
-		free_mr->rsv_pd = NULL;
-	}
+	free_mr_uninit_pd(hr_dev);
 }
 
 static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
@@ -2705,16 +2730,12 @@ static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
 	return 0;
 
 create_failed_qp:
-	for (i--; i >= 0; i--) {
-		hns_roce_v2_destroy_qp(&free_mr->rsv_qp[i]->ibqp, NULL);
-		kfree(free_mr->rsv_qp[i]);
-	}
-	hns_roce_destroy_cq(cq, NULL);
-	kfree(cq);
+	for (i--; i >= 0; i--)
+		free_mr_uninit_qp(hr_dev, i);
+	free_mr_uninit_cq(hr_dev);
 
 create_failed_cq:
-	hns_roce_dealloc_pd(pd, NULL);
-	kfree(pd);
+	free_mr_uninit_pd(hr_dev);
 
 	return ret;
 }
-- 
2.30.0

