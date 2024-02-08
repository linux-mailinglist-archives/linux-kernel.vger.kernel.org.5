Return-Path: <linux-kernel+bounces-58407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE54A84E634
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F5C1C20ABD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D64129A8B;
	Thu,  8 Feb 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jffJY8Iu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380F82D8B;
	Thu,  8 Feb 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411878; cv=none; b=rbHjILEcD54oDKjRw+FM1MbGt9N83IqJDfHL9S1Zo0iNYUku4TW1efgue7pMU31/h3M39O03szeYXPFUEqBX3M3Fd0Fkn7BlUS27tRzYOtJtRPJCN7Rtkl4TOTPqEWT6fV1JsK38gqK3BYwm1v99ki3MlJu9hB5cnjLTJrh5u10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411878; c=relaxed/simple;
	bh=sRckxtSDsCpf73zR+jB6R7mpE9gOvaxLiRmboePNvtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkQ/moTFUxsYivOspne4uu+vns/PEGCulwLAsgqDhpOabrVDMUmbTvPNaHWwIiSF4mQuuadZTBSkBGWcK9/D8EPxKUQoy0udc1a7mkRZf8Fi0+mkl2h7/NJnxBh21qLti85CnUyul7yhoxfzw/igF99TNDzHP/DbDRVeffNnMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jffJY8Iu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4JkL018161;
	Thu, 8 Feb 2024 11:04:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411859;
	bh=YZPa9ZZEbQI9MSRPlkSzDWGxamhkq1zsmhD46HzU6Hs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jffJY8Iu8YZwiGU0xFKp8gz4B2jzlRGKHRetBItcdMu6BLFk+u1rc2EfBwBFzv4cp
	 uGQAA93F3k4vwaTXcLeCuz2RxKZN7qb1P2rnyRxDhv+2F+DxWcLqyCNMtQFl3ljjA3
	 cD+o2s82cdsMcNFGLf3GNKqAfvZOiIMDgeY6wrOQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4Jkb054113
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:19 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:19 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6D091006;
	Thu, 8 Feb 2024 11:04:18 -0600
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
Subject: [PATCH v3 11/19] power: reset: mt6323-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 8 Feb 2024 11:04:02 -0600
Message-ID: <20240208170410.67975-12-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208170410.67975-1-afd@ti.com>
References: <20240208170410.67975-1-afd@ti.com>
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
 drivers/power/reset/mt6323-poweroff.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
index 57a63c0ab7fb7..c663347547f97 100644
--- a/drivers/power/reset/mt6323-poweroff.c
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/rtc.h>
+#include <linux/reboot.h>
 
 struct mt6323_pwrc {
 	struct device *dev;
@@ -21,11 +22,9 @@ struct mt6323_pwrc {
 	u32 base;
 };
 
-static struct mt6323_pwrc *mt_pwrc;
-
-static void mt6323_do_pwroff(void)
+static int mt6323_do_pwroff(struct sys_off_data *data)
 {
-	struct mt6323_pwrc *pwrc = mt_pwrc;
+	struct mt6323_pwrc *pwrc = data->cb_data;
 	unsigned int val;
 	int ret;
 
@@ -44,6 +43,8 @@ static void mt6323_do_pwroff(void)
 	mdelay(1000);
 
 	WARN_ONCE(1, "Unable to power off system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int mt6323_pwrc_probe(struct platform_device *pdev)
@@ -51,6 +52,7 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
 	struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
 	struct mt6323_pwrc *pwrc;
 	struct resource *res;
+	int ret;
 
 	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
 	if (!pwrc)
@@ -63,19 +65,18 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
 	pwrc->base = res->start;
 	pwrc->regmap = mt6397_chip->regmap;
 	pwrc->dev = &pdev->dev;
-	mt_pwrc = pwrc;
 
-	pm_power_off = &mt6323_do_pwroff;
+	ret = devm_register_sys_off_handler(pwrc->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    mt6323_do_pwroff,
+					    pwrc);
+	if (ret)
+		return dev_err_probe(pwrc->dev, ret, "failed to register power-off handler\n");
 
 	return 0;
 }
 
-static void mt6323_pwrc_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == &mt6323_do_pwroff)
-		pm_power_off = NULL;
-}
-
 static const struct of_device_id mt6323_pwrc_dt_match[] = {
 	{ .compatible = "mediatek,mt6323-pwrc" },
 	{},
@@ -84,7 +85,6 @@ MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
 
 static struct platform_driver mt6323_pwrc_driver = {
 	.probe          = mt6323_pwrc_probe,
-	.remove_new     = mt6323_pwrc_remove,
 	.driver         = {
 		.name   = "mt6323-pwrc",
 		.of_match_table = mt6323_pwrc_dt_match,
-- 
2.39.2


