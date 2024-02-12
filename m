Return-Path: <linux-kernel+bounces-61974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DD85195E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB121F22A19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6E4D5B7;
	Mon, 12 Feb 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TviMBq6w"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCEC482D4;
	Mon, 12 Feb 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755338; cv=none; b=WytZ14pykWY5ZSE5343BMZKF6VopuUb/Xmr4brQhxbjcvpzYPFBGS8jHGE5eTJ+Ko1iHszijEJV6h5M3pc07IuLVZCAgJSrzzaY1IKTLpkjXc10gntxin+NSUiCw5gRNUZvMwCsFaiUud/KqesxF6IUpJytrVyzFXQ8T9EWCI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755338; c=relaxed/simple;
	bh=IuAlQRQxIKplKocYo89p9ZMqFmjlfm9M52X+Y3/F7BM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6hEbTi3ZvngevECihA62K2fxFdxN5TI0S1ySHDYRT0dif3Jdg96c9yP3vRNFkJtjrHEGTuvRTtVbdOd/W6Q/3QEyDFYjm6OjO7X12ANUaKqtH1wy/O05/7U4QMYDvK1q1ZwgsqzCj90pDe61YKMVreDgPtJrqby/SlMj2PUSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TviMBq6w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSjVK004185;
	Mon, 12 Feb 2024 10:28:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755325;
	bh=PD7pULEBclq1+qdU6GR6A9JMygAqQNWEIr/SChGU3tQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TviMBq6wzruyjKrS8U9onTXbRWeFf+NpX35hobiHda4CVQ/ilYOxEhBCfjAxrFxBb
	 6+pYImHIomSti4oBmX5Eoxs31S6tI1+KIx7dNNZwlW0JGFcQ+uNvKDENQVbTD7EVZH
	 RJ+sg1wreUuxCG9M3GP4mty93csDJQKzoUykiLpA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSjMv024963
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:45 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:44 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWRF090688;
	Mon, 12 Feb 2024 10:28:44 -0600
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
Subject: [PATCH v4 19/19] power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 12 Feb 2024 10:28:31 -0600
Message-ID: <20240212162831.67838-20-afd@ti.com>
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

This also makes our data struct per-device and not global, which allows
for more than one instance of this device.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/reset/syscon-poweroff.c | 30 ++++++++++-----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 19c8da997b4c8..203936f4c544f 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 struct syscon_poweroff_data {
@@ -22,21 +23,24 @@ struct syscon_poweroff_data {
 	u32 mask;
 };
 
-static struct syscon_poweroff_data *data;
-
-static void syscon_poweroff(void)
+static int syscon_poweroff(struct sys_off_data *off_data)
 {
+	struct syscon_poweroff_data *data = off_data->cb_data;
+
 	/* Issue the poweroff */
 	regmap_update_bits(data->map, data->offset, data->mask, data->value);
 
 	mdelay(1000);
 
 	pr_emerg("Unable to poweroff system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int syscon_poweroff_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct syscon_poweroff_data *data;
 	int mask_err, value_err;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -73,21 +77,10 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 		data->mask = 0xFFFFFFFF;
 	}
 
-	if (pm_power_off) {
-		dev_err(dev, "pm_power_off already claimed for %ps",
-			pm_power_off);
-		return -EBUSY;
-	}
-
-	pm_power_off = syscon_poweroff;
-
-	return 0;
-}
-
-static void syscon_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == syscon_poweroff)
-		pm_power_off = NULL;
+	return devm_register_sys_off_handler(&pdev->dev,
+					     SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_DEFAULT,
+					     syscon_poweroff, data);
 }
 
 static const struct of_device_id syscon_poweroff_of_match[] = {
@@ -97,7 +90,6 @@ static const struct of_device_id syscon_poweroff_of_match[] = {
 
 static struct platform_driver syscon_poweroff_driver = {
 	.probe = syscon_poweroff_probe,
-	.remove_new = syscon_poweroff_remove,
 	.driver = {
 		.name = "syscon-poweroff",
 		.of_match_table = syscon_poweroff_of_match,
-- 
2.39.2


