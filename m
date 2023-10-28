Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B527DA65C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ1KWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjJ1KWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:22:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FAFE5;
        Sat, 28 Oct 2023 03:22:38 -0700 (PDT)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHb7m371wzpWWH;
        Sat, 28 Oct 2023 18:17:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 18:22:35 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - print device abnormal information
Date:   Sat, 28 Oct 2023 18:22:44 +0800
Message-ID: <20231028102244.43918-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When device is abnormal and reports abnormal interrupt event to driver,
the driver can print device information for error analysis. This patch
adds some device error-related information output after the device reports
an abnormal interrupt.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 18599f3634c3..4d91a249be74 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -129,16 +129,21 @@
 #define QM_FIFO_OVERFLOW_TYPE		0xc0
 #define QM_FIFO_OVERFLOW_TYPE_SHIFT	6
 #define QM_FIFO_OVERFLOW_VF		0x3f
+#define QM_FIFO_OVERFLOW_QP_SHIFT	16
 #define QM_ABNORMAL_INF01		0x100014
 #define QM_DB_TIMEOUT_TYPE		0xc0
 #define QM_DB_TIMEOUT_TYPE_SHIFT	6
 #define QM_DB_TIMEOUT_VF		0x3f
+#define QM_DB_TIMEOUT_QP_SHIFT		16
+#define QM_ABNORMAL_INF02		0x100018
+#define QM_AXI_POISON_ERR		BIT(22)
 #define QM_RAS_CE_ENABLE		0x1000ec
 #define QM_RAS_FE_ENABLE		0x1000f0
 #define QM_RAS_NFE_ENABLE		0x1000f4
 #define QM_RAS_CE_THRESHOLD		0x1000f8
 #define QM_RAS_CE_TIMES_PER_IRQ		1
 #define QM_OOO_SHUTDOWN_SEL		0x1040f8
+#define QM_AXI_RRESP_ERR		BIT(0)
 #define QM_ECC_MBIT			BIT(2)
 #define QM_DB_TIMEOUT			BIT(10)
 #define QM_OF_FIFO_OF			BIT(11)
@@ -1406,7 +1411,7 @@ static void qm_log_hw_error(struct hisi_qm *qm, u32 error_status)
 {
 	const struct hisi_qm_hw_error *err;
 	struct device *dev = &qm->pdev->dev;
-	u32 reg_val, type, vf_num;
+	u32 reg_val, type, vf_num, qp_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qm_hw_error); i++) {
@@ -1422,19 +1427,24 @@ static void qm_log_hw_error(struct hisi_qm *qm, u32 error_status)
 			type = (reg_val & QM_DB_TIMEOUT_TYPE) >>
 			       QM_DB_TIMEOUT_TYPE_SHIFT;
 			vf_num = reg_val & QM_DB_TIMEOUT_VF;
-			dev_err(dev, "qm %s doorbell timeout in function %u\n",
-				qm_db_timeout[type], vf_num);
+			qp_id = reg_val >> QM_DB_TIMEOUT_QP_SHIFT;
+			dev_err(dev, "qm %s doorbell timeout in function %u qp %u\n",
+				qm_db_timeout[type], vf_num, qp_id);
 		} else if (err->int_msk & QM_OF_FIFO_OF) {
 			reg_val = readl(qm->io_base + QM_ABNORMAL_INF00);
 			type = (reg_val & QM_FIFO_OVERFLOW_TYPE) >>
 			       QM_FIFO_OVERFLOW_TYPE_SHIFT;
 			vf_num = reg_val & QM_FIFO_OVERFLOW_VF;
-
+			qp_id = reg_val >> QM_FIFO_OVERFLOW_QP_SHIFT;
 			if (type < ARRAY_SIZE(qm_fifo_overflow))
-				dev_err(dev, "qm %s fifo overflow in function %u\n",
-					qm_fifo_overflow[type], vf_num);
+				dev_err(dev, "qm %s fifo overflow in function %u qp %u\n",
+					qm_fifo_overflow[type], vf_num, qp_id);
 			else
 				dev_err(dev, "unknown error type\n");
+		} else if (err->int_msk & QM_AXI_RRESP_ERR) {
+			reg_val = readl(qm->io_base + QM_ABNORMAL_INF02);
+			if (reg_val & QM_AXI_POISON_ERR)
+				dev_err(dev, "qm axi poison error happened\n");
 		}
 	}
 }
-- 
2.33.0

