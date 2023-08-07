Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD7A771D20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjHGJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHGJar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:30:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC8E7B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:30:43 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RK9xF0DTWzVkCc;
        Mon,  7 Aug 2023 17:28:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 17:30:40 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 RESEND] misc: tps6594: Remove redundant dev_err_probe() for platform_get_irq_byname()
Date:   Mon, 7 Aug 2023 17:30:10 +0800
Message-ID: <20230807093010.2112302-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the dev_err_probe() function directly to print
a custom message when handling an error from platform_get_irq_byname()
function as it is going to display an appropriate error message
in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- Update the commit title.
---
 drivers/misc/tps6594-esm.c  | 3 +--
 drivers/misc/tps6594-pfsm.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/tps6594-esm.c b/drivers/misc/tps6594-esm.c
index 68cc235181cc..b4d67a1a24e4 100644
--- a/drivers/misc/tps6594-esm.c
+++ b/drivers/misc/tps6594-esm.c
@@ -56,8 +56,7 @@ static int tps6594_esm_probe(struct platform_device *pdev)
 	for (i = 0; i < pdev->num_resources; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
 		if (irq < 0)
-			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
-					     pdev->resource[i].name);
+			return irq;
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						tps6594_esm_isr, IRQF_ONESHOT,
diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 0e24f8daaa9a..88dcac814892 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -266,8 +266,7 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	for (i = 0 ; i < pdev->num_resources ; i++) {
 		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
 		if (irq < 0)
-			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
-					     pdev->resource[i].name);
+			return irq;
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 						tps6594_pfsm_isr, IRQF_ONESHOT,
-- 
2.34.1

