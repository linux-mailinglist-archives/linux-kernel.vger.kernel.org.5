Return-Path: <linux-kernel+bounces-48650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556E2845F44
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA761F221F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83112EBE9;
	Thu,  1 Feb 2024 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UyO5EnnD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0712E1ED;
	Thu,  1 Feb 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810502; cv=none; b=qnnyfaE/QcqQqG7rFaPfUdBTLE+fdrlqZlX/cANwK+nO0+0ktmUrerVm3jGlOjE8DVq4rKv1EPfeGFINpNkBvx9lbIWJb9n404G5QbQjj/VmKx6QWlsxmCAeM35LZ1+ppTw78jqVgQkAQIze4A9Pyfz94adHUkCAZaKGNcR5xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810502; c=relaxed/simple;
	bh=piMJuCp6Oyf7VRRgvElf9jQlTaTY6OoJDvy6PpEE/uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKzF0EDq367etnYP5OoVEyHfVtPHDyZx0cEShMtK9f21QF3bsXMbOXxL2aHt9C4cB1dAM9Tu0yfV6K+Z64e4FRPZ9AxUhKMsD6fpzUOsWuYZz51it4t5n+Bm3O8WIuyWBMMWz90qFVSlvqoQpEesHzeEjSPIXR5QLf5iNSd+Jk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UyO5EnnD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I1C0e127793;
	Thu, 1 Feb 2024 12:01:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810472;
	bh=psW+zR+255VuGRBEiZa3qV2ZSoJCA9HDeWGIZlh4BNU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UyO5EnnDRngm9H5SGH1A+jEgO7wkevXIJJ227pxDcUetRFvBS9480xEhg15nfp+R+
	 nj4Su04MrkyrG0saepA77HVR2LW/DreMBTJ1KaHdr9Oo5AsU5avhRdjIixfbcnDmGI
	 snG8ICoQK2Ebi8klQh3Udfc9/3St+CDi3QE8n4v0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I1Ctb047604
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:12 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:12 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Gs117221;
	Thu, 1 Feb 2024 12:01:11 -0600
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
Subject: [PATCH 14/18] power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 1 Feb 2024 12:00:58 -0600
Message-ID: <20240201180102.70395-15-afd@ti.com>
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
 drivers/power/reset/as3722-poweroff.c | 30 ++++++++++-----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index ab3350ce2d621..bb26fa6fa67ca 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 
 struct as3722_poweroff {
@@ -18,22 +19,18 @@ struct as3722_poweroff {
 	struct as3722 *as3722;
 };
 
-static struct as3722_poweroff *as3722_pm_poweroff;
-
-static void as3722_pm_power_off(void)
+static int as3722_pm_power_off(struct sys_off_data *data)
 {
+	struct as3722_poweroff *as3722_pm_poweroff = data->cb_data;
 	int ret;
 
-	if (!as3722_pm_poweroff) {
-		pr_err("AS3722 poweroff is not initialised\n");
-		return;
-	}
-
 	ret = as3722_update_bits(as3722_pm_poweroff->as3722,
 		AS3722_RESET_CONTROL_REG, AS3722_POWER_OFF, AS3722_POWER_OFF);
 	if (ret < 0)
 		dev_err(as3722_pm_poweroff->dev,
 			"RESET_CONTROL_REG update failed, %d\n", ret);
+
+	return NOTIFY_DONE;
 }
 
 static int as3722_poweroff_probe(struct platform_device *pdev)
@@ -54,18 +51,14 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 
 	as3722_poweroff->as3722 = dev_get_drvdata(pdev->dev.parent);
 	as3722_poweroff->dev = &pdev->dev;
-	as3722_pm_poweroff = as3722_poweroff;
-	if (!pm_power_off)
-		pm_power_off = as3722_pm_power_off;
 
-	return 0;
-}
+	return devm_register_sys_off_handler(as3722_poweroff->dev,
+					     SYS_OFF_MODE_POWER_OFF,
+					     SYS_OFF_PRIO_DEFAULT,
+					     as3722_pm_power_off,
+					     as3722_poweroff);
 
-static void as3722_poweroff_remove(struct platform_device *pdev)
-{
-	if (pm_power_off == as3722_pm_power_off)
-		pm_power_off = NULL;
-	as3722_pm_poweroff = NULL;
+	return 0;
 }
 
 static struct platform_driver as3722_poweroff_driver = {
@@ -73,7 +66,6 @@ static struct platform_driver as3722_poweroff_driver = {
 		.name = "as3722-power-off",
 	},
 	.probe = as3722_poweroff_probe,
-	.remove_new = as3722_poweroff_remove,
 };
 
 module_platform_driver(as3722_poweroff_driver);
-- 
2.39.2


