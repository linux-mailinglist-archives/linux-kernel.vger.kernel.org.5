Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA97EF5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbjKQQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjKQQKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44883A5;
        Fri, 17 Nov 2023 08:10:47 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGAC0V065961;
        Fri, 17 Nov 2023 10:10:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700237412;
        bh=WJT/GOWye4bOLJhDVAPxuu/+d14nf1WjFFi9pEOVeR0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f+H9IQOiWQoklBsSg45iOmIz74Il/11yhq18CCiEx0h8trl5XLeyvORCUkP0kT8kb
         I4tyBGD8Tw+b+aisKiaxjr2kc7wT0Fr9c3T+nz4V0DE+vgxWHdgBMwACTWl/fJxCus
         sF0NzjYa40dK+pGDvnUFznV1jmSzm0YMHr2LmLNc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGACpL070310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:10:12 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:10:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:10:11 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGA8GL004950;
        Fri, 17 Nov 2023 10:10:10 -0600
From:   Andrew Davis <afd@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 2/5] drivers/soc/litex: Use devm_register_restart_handler()
Date:   Fri, 17 Nov 2023 10:10:03 -0600
Message-ID: <20231117161006.87734-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117161006.87734-1-afd@ti.com>
References: <20231117161006.87734-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device life-cycle managed register function to simplify probe error
path and eliminate need for explicit remove function.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 10813299aa106..7a0096d93c73d 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -69,14 +69,11 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 
 struct litex_soc_ctrl_device {
 	void __iomem *base;
-	struct notifier_block reset_nb;
 };
 
-static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
-			       void *cmd)
+static int litex_reset_handler(struct sys_off_data *data)
 {
-	struct litex_soc_ctrl_device *soc_ctrl_dev =
-		container_of(this, struct litex_soc_ctrl_device, reset_nb);
+	struct litex_soc_ctrl_device *soc_ctrl_dev = data->cb_data;
 
 	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
 	return NOTIFY_DONE;
@@ -107,11 +104,9 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	platform_set_drvdata(pdev, soc_ctrl_dev);
-
-	soc_ctrl_dev->reset_nb.notifier_call = litex_reset_handler;
-	soc_ctrl_dev->reset_nb.priority = 128;
-	error = register_restart_handler(&soc_ctrl_dev->reset_nb);
+	error = devm_register_restart_handler(&pdev->dev,
+					      litex_reset_handler,
+					      soc_ctrl_dev);
 	if (error) {
 		dev_warn(&pdev->dev, "cannot register restart handler: %d\n",
 			 error);
@@ -120,20 +115,12 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void litex_soc_ctrl_remove(struct platform_device *pdev)
-{
-	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
-
-	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
-}
-
 static struct platform_driver litex_soc_ctrl_driver = {
 	.driver = {
 		.name = "litex-soc-controller",
 		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
 	},
 	.probe = litex_soc_ctrl_probe,
-	.remove_new = litex_soc_ctrl_remove,
 };
 
 module_platform_driver(litex_soc_ctrl_driver);
-- 
2.39.2

