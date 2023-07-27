Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1E7643E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjG0ClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG0Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:40:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC69B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:40:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RBFNd2l5Cz1KCFV
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:40:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 10:40:54 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] mailbox: platform-mhu: Remove redundant dev_err()
Date:   Thu, 27 Jul 2023 10:41:37 +0000
Message-ID: <20230727104137.2826372-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err() function directly to print a custom
message when handling an error from platform_get_irq() function as
it is going to display an appropriate error message in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/mailbox/platform_mhu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index a5922ac0b0bf..176ce290b8a8 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -135,10 +135,8 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	for (i = 0; i < MHU_CHANS; i++) {
 		mhu->chan[i].con_priv = &mhu->mlink[i];
 		mhu->mlink[i].irq = platform_get_irq(pdev, i);
-		if (mhu->mlink[i].irq < 0) {
-			dev_err(dev, "failed to get irq%d\n", i);
+		if (mhu->mlink[i].irq < 0)
 			return mhu->mlink[i].irq;
-		}
 		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];
 		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
 	}
-- 
2.34.1

