Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5778F8C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348422AbjIAGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345856AbjIAGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:54:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FC10D3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:54:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcTDt3ZmkzhZHX;
        Fri,  1 Sep 2023 14:50:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 14:54:15 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] bus: omap_l3_smx: Add missing check for platform_get_irq()
Date:   Fri, 1 Sep 2023 14:54:03 +0800
Message-ID: <20230901065403.1303422-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

This func misses checking for platform_get_irq()'s call and may passes the
negative error codes to request_irq(), which takes unsigned IRQ #,
causing it to fail with -EINVAL, overriding an original error code.

Fix this by stop calling request_irq() with invalid IRQ #s.

Fixes: 0ee7261c9212 ("drivers: bus: Move the OMAP interconnect driver to drivers/bus/")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/bus/omap_l3_smx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index 31774648be9d..dd41b0d3cb1d 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -235,6 +235,11 @@ static int omap3_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->debug_irq = platform_get_irq(pdev, 0);
+	if (l3->debug_irq < 0) {
+		ret = l3->debug_irq;
+		goto err1;
+	}
+
 	ret = request_irq(l3->debug_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
 			  "l3-debug-irq", l3);
 	if (ret) {
@@ -243,6 +248,11 @@ static int omap3_l3_probe(struct platform_device *pdev)
 	}
 
 	l3->app_irq = platform_get_irq(pdev, 1);
+	if (l3->app_irq < 0) {
+		ret = l3->app_irq;
+		goto err2;
+	}
+
 	ret = request_irq(l3->app_irq, omap3_l3_app_irq, IRQF_TRIGGER_RISING,
 			  "l3-app-irq", l3);
 	if (ret) {
-- 
2.34.1

