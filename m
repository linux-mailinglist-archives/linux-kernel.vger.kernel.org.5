Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511717EF5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjKQQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbjKQQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:10:52 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC090;
        Fri, 17 Nov 2023 08:10:48 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGAEte032286;
        Fri, 17 Nov 2023 10:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700237414;
        bh=T/wBuC6DtVWXHqmfK8fabulf+ENqoFBjAQef4pkVTeM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CRnP6wGsm8MksLN9E655pnO/IhR8fhXvG8PWulKwIit1g6xzStqQ8CS5PFCZDPIav
         ZIaFBoEZPtpvgInWvFH3Bxl4iI3VE2yicIRMclx8ZZDXzmOl5OvzbNEKKNT6XcUbkF
         DSC+alD49Y+OdRj0k9OUQlVQdbS28bRMvuKoDBzY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHGAENf081164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Nov 2023 10:10:14 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 10:10:14 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 10:10:13 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHGA8GN004950;
        Fri, 17 Nov 2023 10:10:13 -0600
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
Subject: [PATCH RFC 4/5] spi: sprd: adi: Use devm_register_restart_handler()
Date:   Fri, 17 Nov 2023 10:10:05 -0600
Message-ID: <20231117161006.87734-5-afd@ti.com>
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
 drivers/spi/spi-sprd-adi.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index bf01feedbf93f..58c3badd9c79a 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -138,8 +138,7 @@ struct sprd_adi_data {
 	u32 slave_offset;
 	u32 slave_addr_size;
 	int (*read_check)(u32 val, u32 reg);
-	int (*restart)(struct notifier_block *this,
-		       unsigned long mode, void *cmd);
+	int (*restart)(struct sys_off_data *data);
 	void (*wdg_rst)(void *p);
 };
 
@@ -150,7 +149,6 @@ struct sprd_adi {
 	struct hwspinlock	*hwlock;
 	unsigned long		slave_vbase;
 	unsigned long		slave_pbase;
-	struct notifier_block	restart_handler;
 	const struct sprd_adi_data *data;
 };
 
@@ -370,11 +368,9 @@ static void sprd_adi_set_wdt_rst_mode(void *p)
 #endif
 }
 
-static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
-				  void *cmd, struct sprd_adi_wdg *wdg)
+static int sprd_adi_restart(struct sprd_adi *sadi, unsigned long mode,
+			    const char *cmd, struct sprd_adi_wdg *wdg)
 {
-	struct sprd_adi *sadi = container_of(this, struct sprd_adi,
-					     restart_handler);
 	u32 val, reboot_mode = 0;
 
 	if (!cmd)
@@ -448,8 +444,7 @@ static int sprd_adi_restart(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static int sprd_adi_restart_sc9860(struct notifier_block *this,
-					   unsigned long mode, void *cmd)
+static int sprd_adi_restart_sc9860(struct sys_off_data *data)
 {
 	struct sprd_adi_wdg wdg = {
 		.base = PMIC_WDG_BASE,
@@ -458,7 +453,7 @@ static int sprd_adi_restart_sc9860(struct notifier_block *this,
 		.wdg_clk = PMIC_CLK_EN,
 	};
 
-	return sprd_adi_restart(this, mode, cmd, &wdg);
+	return sprd_adi_restart(data->cb_data, data->mode, data->cmd, &wdg);
 }
 
 static void sprd_adi_hw_init(struct sprd_adi *sadi)
@@ -590,9 +585,9 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	}
 
 	if (sadi->data->restart) {
-		sadi->restart_handler.notifier_call = sadi->data->restart;
-		sadi->restart_handler.priority = 128;
-		ret = register_restart_handler(&sadi->restart_handler);
+		ret = devm_register_restart_handler(&pdev->dev,
+						    sadi->data->restart,
+						    sadi);
 		if (ret) {
 			dev_err(&pdev->dev, "can not register restart handler\n");
 			goto put_ctlr;
@@ -606,14 +601,6 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void sprd_adi_remove(struct platform_device *pdev)
-{
-	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
-	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
-
-	unregister_restart_handler(&sadi->restart_handler);
-}
-
 static struct sprd_adi_data sc9860_data = {
 	.slave_offset = ADI_10BIT_SLAVE_OFFSET,
 	.slave_addr_size = ADI_10BIT_SLAVE_ADDR_SIZE,
@@ -657,7 +644,6 @@ static struct platform_driver sprd_adi_driver = {
 		.of_match_table = sprd_adi_of_match,
 	},
 	.probe = sprd_adi_probe,
-	.remove_new = sprd_adi_remove,
 };
 module_platform_driver(sprd_adi_driver);
 
-- 
2.39.2

