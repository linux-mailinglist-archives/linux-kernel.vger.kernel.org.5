Return-Path: <linux-kernel+bounces-61975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856285195F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF2BB22921
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A24D9EA;
	Mon, 12 Feb 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oHPBkh5n"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D2487B3;
	Mon, 12 Feb 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755338; cv=none; b=oZIA3dd3Zk7hPM82MvRQYJ6Fv8GR2WgBPpMZxKnrMCwdbSIrbsvmW8huJXHntpqVIl1GkbmWy5jwPlaqe+DcZKGJWhzEXOHQRsFxc3Mbpn7YntMSdZmlSKWAdLTARKzahWxyLBEXm2s5ULXadhDE8cxxGY8tEA69j2YeVLI2/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755338; c=relaxed/simple;
	bh=SgJH3Y/k6PSY61jd629jA/U3cLCCWfZBB34w3kIbRpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avXx4iwtqBIcKoT2yYbusGfTt2NETeroazSfmHC2zr/r7dk8LF0BREGJYX4rWAabdzwiMUPBIUUwHaAzmh70trFkH/dk9ViYI1ZvlD8I++w2mCYH+hZPT735xszg/1dp5irAvZcn7Os804+WRo7poYfS+oJSuIvV9zuc7qzHi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oHPBkh5n; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSe7R045208;
	Mon, 12 Feb 2024 10:28:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755320;
	bh=tQD/ZFj+g03UN+0Ct3lIkEa6cwgymbRiKX/WFX6uZkY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oHPBkh5nKsWmJzcR+3qt8mWT8R5f2QSw9OfqV0xq68vZx91t+F2FXjofLHUcmHsmH
	 Z+iXD7h0cIftBWtRTuF0CMX02BQfN5EzrNQN56rFrsOtB0UaHNhF7q/LLSaqZk1rEv
	 3zpgfqsfmRQvy1hjQGFUtrSXTKSKU/JuH7BbBeUA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSe4D008748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:40 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:39 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR7090688;
	Mon, 12 Feb 2024 10:28:39 -0600
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
Subject: [PATCH v4 11/19] power: reset: mt6323-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 12 Feb 2024 10:28:23 -0600
Message-ID: <20240212162831.67838-12-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212162831.67838-1-afd@ti.com>
References: <20240212162831.67838-1-afd@ti.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


