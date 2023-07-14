Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB47539EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjGNLoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjGNLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:44:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1F30C5;
        Fri, 14 Jul 2023 04:44:11 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R2V3l6P9RzhXWn;
        Fri, 14 Jul 2023 19:43:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 19:44:09 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>
Subject: [PATCH 4/4] crypto: hisilicon/hpre - enable sva error interrupt event
Date:   Fri, 14 Jul 2023 19:41:38 +0800
Message-ID: <20230714114138.1582-5-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230714114138.1582-1-qianweili@huawei.com>
References: <20230714114138.1582-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Enable sva error interrupt event. When an error occurs on
the sva module, the device reports an abnormal interrupt to
the driver.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 5d0adfb54a34..39297ce70f44 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -209,7 +209,7 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_QM_RESET_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0xC37, 0x6C37},
 	{HPRE_QM_OOO_SHUTDOWN_MASK_CAP, 0x3128, 0, GENMASK(31, 0), 0x0, 0x4, 0x6C37},
 	{HPRE_QM_CE_MASK_CAP, 0x312C, 0, GENMASK(31, 0), 0x0, 0x8, 0x8},
-	{HPRE_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xFFFFFE},
+	{HPRE_NFE_MASK_CAP, 0x3130, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0x1FFFFFE},
 	{HPRE_RESET_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x3FFFFE, 0xBFFFFE},
 	{HPRE_OOO_SHUTDOWN_MASK_CAP, 0x3134, 0, GENMASK(31, 0), 0x0, 0x22, 0xBFFFFE},
 	{HPRE_CE_MASK_CAP, 0x3138, 0, GENMASK(31, 0), 0x0, 0x1, 0x1},
@@ -275,6 +275,9 @@ static const struct hpre_hw_error hpre_hw_errors[] = {
 	}, {
 		.int_msk = BIT(23),
 		.msg = "sva_fsm_timeout_int_set"
+	}, {
+		.int_msk = BIT(24),
+		.msg = "sva_int_set"
 	}, {
 		/* sentinel */
 	}
-- 
2.33.0

