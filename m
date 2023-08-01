Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DF76AB53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjHAIvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjHAIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:51:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57D10FA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:51:42 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFTM75ylrzVjy5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:49:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 16:51:38 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <jassisinghbrar@gmail.com>
CC:     <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mailbox: ti-msgmgr: Use devm_platform_ioremap_resource_byname()
Date:   Tue, 1 Aug 2023 16:51:07 +0800
Message-ID: <20230801085107.3912166-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
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

Convert platform_get_resource_byname() + devm_ioremap_resource() to a
single call to devm_platform_ioremap_resource_byname(), as this is
exactly what this function does.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/mailbox/ti-msgmgr.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 03048cbda525..a94577f16a47 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -812,7 +812,6 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	struct device_node *np;
-	struct resource *res;
 	const struct ti_msgmgr_desc *desc;
 	struct ti_msgmgr_inst *inst;
 	struct ti_queue_inst *qinst;
@@ -843,22 +842,19 @@ static int ti_msgmgr_probe(struct platform_device *pdev)
 	inst->dev = dev;
 	inst->desc = desc;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   desc->data_region_name);
-	inst->queue_proxy_region = devm_ioremap_resource(dev, res);
+	inst->queue_proxy_region =
+		devm_platform_ioremap_resource_byname(pdev, desc->data_region_name);
 	if (IS_ERR(inst->queue_proxy_region))
 		return PTR_ERR(inst->queue_proxy_region);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   desc->status_region_name);
-	inst->queue_state_debug_region = devm_ioremap_resource(dev, res);
+	inst->queue_state_debug_region =
+		devm_platform_ioremap_resource_byname(pdev, desc->status_region_name);
 	if (IS_ERR(inst->queue_state_debug_region))
 		return PTR_ERR(inst->queue_state_debug_region);
 
 	if (desc->is_sproxy) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   desc->ctrl_region_name);
-		inst->queue_ctrl_region = devm_ioremap_resource(dev, res);
+		inst->queue_ctrl_region =
+			devm_platform_ioremap_resource_byname(pdev, desc->ctrl_region_name);
 		if (IS_ERR(inst->queue_ctrl_region))
 			return PTR_ERR(inst->queue_ctrl_region);
 	}
-- 
2.34.1

