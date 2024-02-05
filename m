Return-Path: <linux-kernel+bounces-53855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99B84A759
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199BD28F288
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734167C081;
	Mon,  5 Feb 2024 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IvTDUc1A"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A89745FA;
	Mon,  5 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162310; cv=none; b=D41G+XhDuawZSDVOHWQ03OOKaiA/oVnUMVYkMcqqAOCkRUTcBYeEVYJQQYmoLqlW9XwrfuUh/QhCgj/TzCNecotpdntTp0Of4TMrElNHUJZtRvxxz9Lfz7oE5mbv04nIchtXePqVpcV7gfGt5sqZtQg0lfQp5x5KfWbTy5FHQ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162310; c=relaxed/simple;
	bh=4I1vc+9qiFHbkF+qYQtdPfpYZxXqQl61oW4rBcSj/cM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCCoKgp5oLYx2+c2UNZWkxLlO7hFHRoFF+P9CUGdC9oWGLHoQIah+MNc6dZcMNY2v1Sq7B9soyBl9l87Cla0FWRiNguothoWpZVE+/5pEZwD/gCePC18lBWcXhngT3j3O0OnNZpb4gcuywjwLBPDLElWW4AHf5CzY+rZGFOUHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IvTDUc1A; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jip8j016374;
	Mon, 5 Feb 2024 13:44:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162291;
	bh=rjOs3HQelK8dD7ON+CKELNocYhGYtTpRb3RjtcpZp+M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IvTDUc1AcaZKT3LzhAh3725W3cPc+vgKIt6Ifl23KPLJZBfkVCuePHss9pFGG2aEP
	 Mel/MjKplcGrtmDsN+u+TjEMF4dXq5OsRWYTqUOsvfT3ejwSx/k6izAxxfmZrr52cG
	 08uO0v4issu64ydcSdipSD5o/DKjtN5rwZULp6FA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JipiG090728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:51 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:50 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQf028467;
	Mon, 5 Feb 2024 13:44:50 -0600
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
Subject: [PATCH v2 18/19] power: reset: syscon-poweroff: Move device data into a struct
Date: Mon, 5 Feb 2024 13:44:36 -0600
Message-ID: <20240205194437.180802-19-afd@ti.com>
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

Currently all these device data elements are top level global variables.
Move these into a struct. This will be used in the next patch when
the global variable usage is removed. Doing this in two steps makes
the patches easier to read.

Signed-off-by: Andrew Davis <afd@ti.com>
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


