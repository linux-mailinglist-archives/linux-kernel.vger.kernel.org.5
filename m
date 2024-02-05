Return-Path: <linux-kernel+bounces-53842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EE84A72F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582FB28D3B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ABB67C4D;
	Mon,  5 Feb 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X27fViWT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551963509;
	Mon,  5 Feb 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162300; cv=none; b=Fs8Ygh337t0wbAmbO0GTHEuApksXKksqaRQkCFadi8qMgAtqzKr5PXNt6k4IiMpUE2jSxmSRZe7wnsyG8hXbz9UJ7038cGlKIhmcPWiTWRD+rfridhBlJ72ULUG6VuiOaabgIKknZh0/wXvDRekDn3m/cIiMb252wnrmMMU6dGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162300; c=relaxed/simple;
	bh=ig53Er0IQr8J52R1XJK5g8TmLfD/5crHUpIF26cVFwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkJjZjIYQrJs1EgUubbp+3RYRGaqANRRG2/fZ3jTTvgFsW6gqoAqNNW6X8JbfXuIHjpjHRLt0t2sq6Q/EkD0k30LUvJ6BExIfeQcGU8pqXTXH9p3nXkEAI1JnzpkBFxQ9a23XlUTk+OntNvD9SCdwCmWIClWCx23jGty4vpAgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X27fViWT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jik8o016359;
	Mon, 5 Feb 2024 13:44:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162286;
	bh=ngOnUmcKUfVk/SqAddQuFt8kMzihNR+9E3bjKI3tkA8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=X27fViWTupMnmxzyJy/auFJDnRqASH9CxNqLFuGZJk/+yYFjhGgHB1glVDBgk5B/S
	 mQIDuDBNodhOiXQWmQI8BkPx6H+KqwHWlF2zHA6szR2w1W8kfZq1jpm1yHfIjJUGqf
	 aEWS53lYyCCq05bLUW2msoG9vRorTDJgTANochWw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Jik4o073183
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:46 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:46 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQY028467;
	Mon, 5 Feb 2024 13:44:45 -0600
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
Subject: [PATCH v2 11/19] power: reset: mt6323-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 5 Feb 2024 13:44:29 -0600
Message-ID: <20240205194437.180802-12-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205194437.180802-1-afd@ti.com>
References: <20240205194437.180802-1-afd@ti.com>
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
 drivers/power/reset/mt6323-poweroff.c | 28 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
index 57a63c0ab7fb7..ca5d11b17ff03 100644
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
@@ -63,19 +65,20 @@ static int mt6323_pwrc_probe(struct platform_device *pdev)
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
+	if (ret) {
+		dev_err(pwrc->dev, "failed to register power-off handler: %d\n", ret);
+		return ret;
+	}
 
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
@@ -84,7 +87,6 @@ MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
 
 static struct platform_driver mt6323_pwrc_driver = {
 	.probe          = mt6323_pwrc_probe,
-	.remove_new     = mt6323_pwrc_remove,
 	.driver         = {
 		.name   = "mt6323-pwrc",
 		.of_match_table = mt6323_pwrc_dt_match,
-- 
2.39.2


