Return-Path: <linux-kernel+bounces-58418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE12384E644
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEAA28802F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2E134CD5;
	Thu,  8 Feb 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MCNL0fgc"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020D85C64;
	Thu,  8 Feb 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411881; cv=none; b=Is+IKLR2TlZfe5vUHJXf3wGjG7mEG6eYk+RS4VN/vgNYlHQnbbuEUMllK3c+tDUT1wDFgNawkgtiKFgbsQTqKljSKvIEoIRrQIibbTmbrrWwHDn3AuNmnyf2EtkSRgW/mWTwSkHyHYYsXY1crV0foMNdhOXDHEdkGzaL/2xblmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411881; c=relaxed/simple;
	bh=U/xNJvsHqsfXOh65drl1jswKSzMBpfTZVGXlt40OaSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYj6wyvUVIUAY90qDCVaO8hFhtzCmvKmuNQoh+3aTbBj79/QuLhwnu1iqCBavo9UXMjFr692aErcVhzCF9/B+s4Zeq49NkWoblJpNOLzm0i9BX051s5kpikWt7T62QozF6dqfPf+rVX1Ykb0qF762jl58MQeIYpha8pHXPv21kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MCNL0fgc; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4OTe095483;
	Thu, 8 Feb 2024 11:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411864;
	bh=OTPSp5L3TEtseuw9LbmVb9k85AOaeJB4drS3oC17zt4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MCNL0fgckDtKkTPAbOGTXp2pk9p0WnkZt5v4S4y/vkgZrYbFKnLzttYKvgilTuhmB
	 nB6D/9zkEjWhHOl/EiZ6eHOdzLoPBYtQXmSxsfTub/eF34d824cakIiJSrLWHvLJBv
	 whUBTZ9PDoBe2Ofx0ktR/MS7J3L9MGa9QrCFBMyA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4O1W042510
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:24 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:24 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6K091006;
	Thu, 8 Feb 2024 11:04:23 -0600
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
Subject: [PATCH v3 18/19] power: reset: syscon-poweroff: Move device data into a struct
Date: Thu, 8 Feb 2024 11:04:09 -0600
Message-ID: <20240208170410.67975-19-afd@ti.com>
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

Currently all these device data elements are top level global variables.
Move these into a struct. This will be used in the next patch when
the global variable usage is removed. Doing this in two steps makes
the patches easier to read.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/reset/syscon-poweroff.c | 36 +++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 1b2ce7734260c..4899a019256e8 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -15,15 +15,19 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 
-static struct regmap *map;
-static u32 offset;
-static u32 value;
-static u32 mask;
+struct syscon_poweroff_data {
+	struct regmap *map;
+	u32 offset;
+	u32 value;
+	u32 mask;
+};
+
+static struct syscon_poweroff_data *data;
 
 static void syscon_poweroff(void)
 {
 	/* Issue the poweroff */
-	regmap_update_bits(map, offset, mask, value);
+	regmap_update_bits(data->map, data->offset, data->mask, data->value);
 
 	mdelay(1000);
 
@@ -35,22 +39,22 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int mask_err, value_err;
 
-	map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
-	if (IS_ERR(map)) {
-		map = syscon_node_to_regmap(dev->parent->of_node);
-		if (IS_ERR(map)) {
+	data->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
+	if (IS_ERR(data->map)) {
+		data->map = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(data->map)) {
 			dev_err(dev, "unable to get syscon");
-			return PTR_ERR(map);
+			return PTR_ERR(data->map);
 		}
 	}
 
-	if (of_property_read_u32(dev->of_node, "offset", &offset)) {
+	if (of_property_read_u32(dev->of_node, "offset", &data->offset)) {
 		dev_err(dev, "unable to read 'offset'");
 		return -EINVAL;
 	}
 
-	value_err = of_property_read_u32(dev->of_node, "value", &value);
-	mask_err = of_property_read_u32(dev->of_node, "mask", &mask);
+	value_err = of_property_read_u32(dev->of_node, "value", &data->value);
+	mask_err = of_property_read_u32(dev->of_node, "mask", &data->mask);
 	if (value_err && mask_err) {
 		dev_err(dev, "unable to read 'value' and 'mask'");
 		return -EINVAL;
@@ -58,11 +62,11 @@ static int syscon_poweroff_probe(struct platform_device *pdev)
 
 	if (value_err) {
 		/* support old binding */
-		value = mask;
-		mask = 0xFFFFFFFF;
+		data->value = data->mask;
+		data->mask = 0xFFFFFFFF;
 	} else if (mask_err) {
 		/* support value without mask*/
-		mask = 0xFFFFFFFF;
+		data->mask = 0xFFFFFFFF;
 	}
 
 	if (pm_power_off) {
-- 
2.39.2


