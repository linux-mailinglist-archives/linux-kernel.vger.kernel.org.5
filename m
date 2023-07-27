Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770976447C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjG0Diw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjG0Dis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:38:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D3C106
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:38:45 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBGcP5K93zNmTG;
        Thu, 27 Jul 2023 11:35:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 11:38:40 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <laurent.pinchart@ideasonboard.com>,
        <u.kleine-koenig@pengutronix.de>, <guozhengkui@vivo.com>,
        <dianders@chromium.org>, <yuancan@huawei.com>, <arnd@arndb.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm: omapdrm: dss: Remove redundant DSSERR()
Date:   Thu, 27 Jul 2023 11:39:23 +0000
Message-ID: <20230727113923.3093070-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the DSSERR() function directly to print
a custom message when handling an error from platform_get_irq() function
as it is going to display an appropriate error message
in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 1 -
 drivers/gpu/drm/omapdrm/dss/dsi.c   | 4 +---
 drivers/gpu/drm/omapdrm/dss/hdmi4.c | 1 -
 drivers/gpu/drm/omapdrm/dss/hdmi5.c | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index c26aab4939fa..9209103f5dc5 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -4779,7 +4779,6 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
 
 	dispc->irq = platform_get_irq(dispc->pdev, 0);
 	if (dispc->irq < 0) {
-		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
 		goto err_free;
 	}
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index ea63c64d3a1a..63cfe0776788 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4935,10 +4935,8 @@ static int dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->pll_base);
 
 	dsi->irq = platform_get_irq(pdev, 0);
-	if (dsi->irq < 0) {
-		DSSERR("platform_get_irq failed\n");
+	if (dsi->irq < 0)
 		return -ENODEV;
-	}
 
 	r = devm_request_irq(dev, dsi->irq, omap_dsi_irq_handler,
 			     IRQF_SHARED, dev_name(dev), dsi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index a26b77d99d52..d4fd6c680db3 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -782,7 +782,6 @@ static int hdmi4_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
 		goto err_free;
 	}
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index e6611c683857..27c21ff8c4e5 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -756,7 +756,6 @@ static int hdmi5_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
 		goto err_free;
 	}
-- 
2.34.1

