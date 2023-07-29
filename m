Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD2C767F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjG2Mzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjG2Mzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:55:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7530F4;
        Sat, 29 Jul 2023 05:55:30 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCkt338BXztRZb;
        Sat, 29 Jul 2023 20:52:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 20:55:28 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 6/7] crypto: hisilicon/qm - fix the type value of aeq
Date:   Sat, 29 Jul 2023 20:52:38 +0800
Message-ID: <20230729125239.25337-7-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230729125239.25337-1-qianweili@huawei.com>
References: <20230729125239.25337-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of aeq has only 17 to 20 bits, but 17 to 31 bits are read in
function qm_aeq_thread(), fix it.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index cc2caa08966d..9b65266a3678 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -71,6 +71,7 @@
 
 #define QM_AEQE_PHASE(aeqe)		((le32_to_cpu((aeqe)->dw0) >> 16) & 0x1)
 #define QM_AEQE_TYPE_SHIFT		17
+#define QM_AEQE_TYPE_MASK		0xf
 #define QM_AEQE_CQN_MASK		GENMASK(15, 0)
 #define QM_CQ_OVERFLOW			0
 #define QM_EQ_OVERFLOW			1
@@ -1133,7 +1134,8 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	u32 type, qp_id;
 
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
-		type = le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT;
+		type = (le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT) &
+			QM_AEQE_TYPE_MASK;
 		qp_id = le32_to_cpu(aeqe->dw0) & QM_AEQE_CQN_MASK;
 
 		switch (type) {
-- 
2.33.0

