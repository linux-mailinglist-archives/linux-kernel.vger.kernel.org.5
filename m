Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033487B1734
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjI1JYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjI1JYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:24:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CDFAC;
        Thu, 28 Sep 2023 02:24:32 -0700 (PDT)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rx7Hq3DJrzNnyN;
        Thu, 28 Sep 2023 17:20:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 17:24:29 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - fix the type value of aeq
Date:   Thu, 28 Sep 2023 17:21:03 +0800
Message-ID: <20230928092103.49587-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

The type of aeq has only 4bits in dw0 17 to 20bits, but 15bits(17 to
31bits) are read in function qm_aeq_thread(). The remaining 11bits(21
to 31bits) are reserved for aeq, but may not be 0. To avoid getting
incorrect value of type, other bits are cleared.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 1638c0a7df31..458d1fe42a24 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -69,6 +69,7 @@
 
 #define QM_AEQE_PHASE(aeqe)		((le32_to_cpu((aeqe)->dw0) >> 16) & 0x1)
 #define QM_AEQE_TYPE_SHIFT		17
+#define QM_AEQE_TYPE_MASK		0xf
 #define QM_AEQE_CQN_MASK		GENMASK(15, 0)
 #define QM_CQ_OVERFLOW			0
 #define QM_EQ_OVERFLOW			1
@@ -1024,7 +1025,8 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	u32 type, qp_id;
 
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
-		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
+		type = (le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT) &
+			QM_AEQE_TYPE_MASK;
 		qp_id = le32_to_cpu(aeqe->dw0) & QM_AEQE_CQN_MASK;
 
 		switch (type) {
-- 
2.33.0

