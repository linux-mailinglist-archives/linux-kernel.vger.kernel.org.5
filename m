Return-Path: <linux-kernel+bounces-58421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2A84E648
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF928CCCE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105B1350E1;
	Thu,  8 Feb 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DFuhy6df"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A782D61;
	Thu,  8 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411890; cv=none; b=uShuCvmYin51CZs3+qWiFpCRo0net2/wekgon+3Wn/UvC8LAugK83u9TQw1Fsn2nhL32efo1rySLh0FQiYMycLHGAzeSgZybqXG0JgJhJEpGCGugOp0NQYK023rhxF7M5OLErhK9RY7JPvDbYQGMKVEaX4JosN6/DSyAq9zEotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411890; c=relaxed/simple;
	bh=X6xRv8ZmzjUFGThF5eIFsolt+SQ3arFoHgRmBYQ550I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/nSwQSQRiEZAzXB/5dwIPhZpJJVtWtPQNr/OHNDpeC6oRkqMtGssAhgYrV4acysE2ZrhZuTKYipnX5JeGMzEFXBteT6Tt7VpN0P6GSSoTP4GbsYQv29qEuYo/gcKn0+ysnC8PZbZIJ6GqaUygHTAeEeOl2rtgnCXXYhSFGlOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DFuhy6df; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4Pki004982;
	Thu, 8 Feb 2024 11:04:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411865;
	bh=MeE+f3axegAXGv9AlMEePhEt4yt01moBec9QtZ5EkhI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DFuhy6dflnTf+UjeWx8yI7a/sW5DIr9cLsKU1BaqzpHDhkjA6wc8HK+LWwNcLBCAA
	 ZoPWVcawohUwdJDl/SoffeaAP/nXBcmWPtEb1qda/4tmc5fVZhuABwElmFoww1TQKf
	 72skFySYelSDo9drSgXwCbxsPIU3tuFgtBRmllFk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4PcI023458
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:25 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:24 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6L091006;
	Thu, 8 Feb 2024 11:04:24 -0600
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
Subject: [PATCH v3 19/19] power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 8 Feb 2024 11:04:10 -0600
Message-ID: <20240208170410.67975-20-afd@ti.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/reset/syscon-poweroff.c | 34 ++++++++++++---------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 4899a019256e8..203936f4c544f 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 struct syscon_poweroff_data {
@@ -22,23 +23,30 @@ struct syscon_poweroff_data {
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
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	data->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
 	if (IS_ERR(data->map)) {
 		data->map = syscon_node_to_regmap(dev->parent->of_node);
@@ -69,21 +77,10 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
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
@@ -93,7 +90,6 @@ static const struct of_device_id syscon_poweroff_of_match[] = {
 
 static struct platform_driver syscon_poweroff_driver = {
 	.probe = syscon_poweroff_probe,
-	.remove_new = syscon_poweroff_remove,
 	.driver = {
 		.name = "syscon-poweroff",
 		.of_match_table = syscon_poweroff_of_match,
-- 
2.39.2


