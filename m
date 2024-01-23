Return-Path: <linux-kernel+bounces-35755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D912F83961C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215BAB2A898
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA17FBA9;
	Tue, 23 Jan 2024 17:09:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52134187A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029740; cv=none; b=HOvTnkgNRQdpqJ8brTCUFHozYhzaKAQ1P6u3+b7NzCn4zOkmUJc21RGZPWCs1DACXSJYry0E12siwfOh54jeslA4xozfR/uwGyLdYZH4jRh1y7y7Y45bKCUz7VkOeIiuUTHoCE0A9c66lJHe1ydshFDwdwfGOkcgwN9Q4X6JbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029740; c=relaxed/simple;
	bh=TAwP5lWL0q0rWth29pNEVCmD+etrS5ec3mhMC0ES/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKnCBpBy/bjbNdj7O7NRYGIM8kodCdjmKqy/5ufSkhdv63r5x/B24nPSW+pLvGQ/BYsGbmQYSsQ2rA4E2Uv0VsGJKcDv1GsvwOc2l4I2W96unR93oCM3OOlRcgaW7TsQ5CD8qT1mHEe3GJ8lrI80lXjY8jUyP+2cCa/OQKveVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSKGb-0004yc-EG; Tue, 23 Jan 2024 18:08:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSKGa-001sVw-Lj; Tue, 23 Jan 2024 18:08:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSKGa-006TIn-1t;
	Tue, 23 Jan 2024 18:08:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v2] memory: emif: Drop usage of platform_driver_probe()
Date: Tue, 23 Jan 2024 18:08:47 +0100
Message-ID: <20240123170846.1362597-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TAwP5lWL0q0rWth29pNEVCmD+etrS5ec3mhMC0ES/U0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlr/KeDTVpnmrTLspToC4ym6tTxyFjhN/EOBP/9 BRfldlDEqKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa/yngAKCRCPgPtYfRL+ TvSkB/93+6JuBCYm7/SaAbnfZ5gfIrPk23SV6iV8Z/Q2BFcFzFBCaizbPjWrqByz8NEBQUKnCdh Y9rRrDrzVCzQD44JXHqDAafFvh6rTCUdvCOdnlyrBVmDhYcvceFgNn7130qZ9vIu3PgEnlZKjqr amG7KFyTJqy8Q1oDy/fGtUC2lrxRuGq6E8/xSgTwF0EtUj1y5q2KP0uU32cncsvvEAFpqJvMuXH DWAqnRdYSug9z2xYp9aQi6k1jViJVJUpBV3kJ0xsm78EU8/qouzFU64uJOCo7X1KM9v4Sj3YpSi 5cCd1qDapBg6evLgGuVuI7+8yLin5KLJDcgFPSprtV1oZ1lU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There are considerations to drop platform_driver_probe() as a concept
that isn't relevant any more today. It comes with an added complexity
that makes many users hold it wrong. (E.g. this driver should have
better used __init instead of __init_or_module to mark functions only
relevant to .probe() and mark the driver struct with __refdata.)

This fixes a W=1 build warning:

	WARNING: modpost: drivers/memory/emif: section mismatch in reference: emif_driver+0x4 (section: .data) -> emif_remove (section: .exit.text)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

(implicit) v1 can be found at
https://lore.kernel.org/linux-kernel/cover.1702829744.git.u.kleine-koenig@pengutronix.de
.

Krzysztof applied the first two patches of that series. Patch #3 didn't
apply any more, so this is a rebase of this last patch on top of

	git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git refs/heads/for-next

Best regards
Uwe

 drivers/memory/emif.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index c5a24501db9b..8c5ad5c025fa 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -139,7 +139,7 @@ static int emif_mr4_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(emif_mr4);
 
-static void __init_or_module emif_debugfs_init(struct emif_data *emif)
+static void emif_debugfs_init(struct emif_data *emif)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		emif->debugfs_root = debugfs_create_dir(dev_name(emif->dev), NULL);
@@ -150,7 +150,7 @@ static void __init_or_module emif_debugfs_init(struct emif_data *emif)
 	}
 }
 
-static void __exit emif_debugfs_exit(struct emif_data *emif)
+static void emif_debugfs_exit(struct emif_data *emif)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		debugfs_remove_recursive(emif->debugfs_root);
@@ -671,7 +671,7 @@ static void disable_and_clear_all_interrupts(struct emif_data *emif)
 	clear_all_interrupts(emif);
 }
 
-static int __init_or_module setup_interrupts(struct emif_data *emif, u32 irq)
+static int setup_interrupts(struct emif_data *emif, u32 irq)
 {
 	u32		interrupts, type;
 	void __iomem	*base = emif->base;
@@ -702,7 +702,7 @@ static int __init_or_module setup_interrupts(struct emif_data *emif, u32 irq)
 
 }
 
-static void __init_or_module emif_onetime_settings(struct emif_data *emif)
+static void emif_onetime_settings(struct emif_data *emif)
 {
 	u32				pwr_mgmt_ctrl, zq, temp_alert_cfg;
 	void __iomem			*base = emif->base;
@@ -826,7 +826,7 @@ static int is_custom_config_valid(struct emif_custom_configs *cust_cfgs,
 	return valid;
 }
 
-static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
+static void of_get_custom_configs(struct device_node *np_emif,
 		struct emif_data *emif)
 {
 	struct emif_custom_configs	*cust_cfgs = NULL;
@@ -875,7 +875,7 @@ static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 	emif->plat_data->custom_configs = cust_cfgs;
 }
 
-static void __init_or_module of_get_ddr_info(struct device_node *np_emif,
+static void of_get_ddr_info(struct device_node *np_emif,
 		struct device_node *np_ddr,
 		struct ddr_device_info *dev_info)
 {
@@ -909,7 +909,7 @@ static void __init_or_module of_get_ddr_info(struct device_node *np_emif,
 		dev_info->io_width = __fls(io_width) - 1;
 }
 
-static struct emif_data * __init_or_module of_get_memory_device_details(
+static struct emif_data *of_get_memory_device_details(
 		struct device_node *np_emif, struct device *dev)
 {
 	struct emif_data		*emif = NULL;
@@ -982,7 +982,7 @@ static struct emif_data * __init_or_module of_get_memory_device_details(
 	return emif;
 }
 
-static struct emif_data *__init_or_module get_device_details(
+static struct emif_data *get_device_details(
 		struct platform_device *pdev)
 {
 	u32				size;
@@ -1086,7 +1086,7 @@ static struct emif_data *__init_or_module get_device_details(
 	return NULL;
 }
 
-static int __init_or_module emif_probe(struct platform_device *pdev)
+static int emif_probe(struct platform_device *pdev)
 {
 	struct emif_data	*emif;
 	int			irq, ret;
@@ -1141,7 +1141,7 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
-static void __exit emif_remove(struct platform_device *pdev)
+static void emif_remove(struct platform_device *pdev)
 {
 	struct emif_data *emif = platform_get_drvdata(pdev);
 
@@ -1165,7 +1165,8 @@ MODULE_DEVICE_TABLE(of, emif_of_match);
 #endif
 
 static struct platform_driver emif_driver = {
-	.remove_new	= __exit_p(emif_remove),
+	.probe		= emif_probe,
+	.remove_new	= emif_remove,
 	.shutdown	= emif_shutdown,
 	.driver = {
 		.name = "emif",
@@ -1173,7 +1174,7 @@ static struct platform_driver emif_driver = {
 	},
 };
 
-module_platform_driver_probe(emif_driver, emif_probe);
+module_platform_driver(emif_driver);
 
 MODULE_DESCRIPTION("TI EMIF SDRAM Controller Driver");
 MODULE_LICENSE("GPL");

base-commit: d10e03cf9a4d78c67ef779dab5a5f4fb94fb835e
-- 
2.43.0


