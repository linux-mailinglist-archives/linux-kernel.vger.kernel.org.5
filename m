Return-Path: <linux-kernel+bounces-48649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895C845F42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248952952D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBEA12E1F0;
	Thu,  1 Feb 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TEdRKWAS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B112B160;
	Thu,  1 Feb 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810500; cv=none; b=HudZQ3zYJvZQT5cDwmoQ8KTX9ixI6MTh7zr9KiXasC00QHTO1reuhXv5vRwenMb7nD31V1pzmhynh4WCOTUVIA54i4Q7g81zZTReUnRKi3ux/0PvuK7phvp6Wk1CHZXx8adhFGrXCr04qZBUOjwkPavwpbgbhDIpKCrVXRkvW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810500; c=relaxed/simple;
	bh=b1HCM6PNhU5iOFP0yy2ZAE2FiVY5BYt6sfsBzt/lauQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPkSVWJQEBEbgyJ7fSMI06UIunYWK5II9aZ8jo2yl3GpxoV1HtKXJ56j+8MJCxKUURGm9pPW0elZ3tUR2l04tGaAxivJNKZQkH0NVj88XnDXGq270kkkFBWHz3nRpmkYR1KR5xMxOnUJbmtlXdPZJrwYvHirBLmdEJy/cnpm9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TEdRKWAS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I1BFn127788;
	Thu, 1 Feb 2024 12:01:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810471;
	bh=+yoH0oyAcvSMYuuy/HNbc6iZw+avNZNinJT/iIL/4IE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TEdRKWAS68vhJJnd9EvHzfpDNDUtaYTLUff5lKyt45xraFCOzBhWFWWDs6v686NP2
	 JOCvYzpgpUi/mgq0ZWXBUyM+qKVCJ5kDjTsxt+FfOzRKdJfKEk7xPbGKA8ms77Ds+H
	 VvV1Jgk+88Xd8XmBSqPY1fo4wyAmLT4a7eaGPGtM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I1Bso120468
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:11 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:11 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Gr117221;
	Thu, 1 Feb 2024 12:01:10 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 13/18] power: reset: regulator-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 1 Feb 2024 12:00:57 -0600
Message-ID: <20240201180102.70395-14-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201180102.70395-1-afd@ti.com>
References: <20240201180102.70395-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed register function to simplify probe and
exit paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/regulator-poweroff.c | 36 +++++++++---------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
index 15160809c423a..fed4978e38580 100644
--- a/drivers/power/reset/regulator-poweroff.c
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -13,18 +13,15 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/regulator/consumer.h>
 
 #define TIMEOUT_MS 3000
 
-/*
- * Hold configuration here, cannot be more than one instance of the driver
- * since pm_power_off itself is global.
- */
-static struct regulator *cpu_regulator;
-
-static void regulator_poweroff_do_poweroff(void)
+static int regulator_poweroff_do_poweroff(struct sys_off_data *data)
 {
+	struct regulator *cpu_regulator = data->cb_data;
+
 	if (cpu_regulator && regulator_is_enabled(cpu_regulator))
 		regulator_force_disable(cpu_regulator);
 
@@ -32,30 +29,24 @@ static void regulator_poweroff_do_poweroff(void)
 	mdelay(TIMEOUT_MS);
 
 	WARN_ON(1);
+
+	return NOTIFY_DONE;
 }
 
 static int regulator_poweroff_probe(struct platform_device *pdev)
 {
-	/* If a pm_power_off function has already been added, leave it alone */
-	if (pm_power_off != NULL) {
-		dev_err(&pdev->dev,
-			"%s: pm_power_off function already registered\n",
-			__func__);
-		return -EBUSY;
-	}
+	struct regulator *cpu_regulator;
 
 	cpu_regulator = devm_regulator_get(&pdev->dev, "cpu");
 	if (IS_ERR(cpu_regulator))
 		return PTR_ERR(cpu_regulator);
 
-	pm_power_off = &regulator_poweroff_do_poweroff;
-	return 0;
-}
-
-static void regulator_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == &regulator_poweroff_do_poweroff)
-		pm_power_off = NULL;
+	/* Set this handler to low priority to not override an existing handler */
+	return devm_register_sys_off_handler(&pdev->dev,
+					     SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_LOW,
+					     regulator_poweroff_do_poweroff,
+					     cpu_regulator);
 }
 
 static const struct of_device_id of_regulator_poweroff_match[] = {
@@ -66,7 +57,6 @@ MODULE_DEVICE_TABLE(of, of_regulator_poweroff_match);
 
 static struct platform_driver regulator_poweroff_driver = {
 	.probe = regulator_poweroff_probe,
-	.remove_new = regulator_poweroff_remove,
 	.driver = {
 		.name = "poweroff-regulator",
 		.of_match_table = of_regulator_poweroff_match,
-- 
2.39.2


