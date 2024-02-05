Return-Path: <linux-kernel+bounces-53848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766AE84A743
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F4D1C2695B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF97318E;
	Mon,  5 Feb 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KGtXTaIK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3173188;
	Mon,  5 Feb 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162308; cv=none; b=pBQYZuThpTlTpSk3zc18gu6gRFYSq/eZ2bAuPtYLiJMCY3hvjxMDQ53YX74IlELDp7Br+LZ7RDpl2RH2vEph6O7D6k0m3NWwpKADinFBrlc4mg83khxapR6WyWH6Mrtene4hqgos2ko6EP0LXtwCYjyPS8jzYFDuZL/xYosGFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162308; c=relaxed/simple;
	bh=hjODPAvfHHQsYQrgcPIWkoWLz7Tm/5vLqy/n+aT9TWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT+57Zg8sOPYocbka7FeU81/OUBvUihepKBOZ1Uxuw3EJz5m6S+M3Vnhxwm8DbLtaUI4tXePTeOSf+TJGnD9wG1hjis6Ze3nqj8LXRMmcu6AjLPsBR9hWxhaoo/4/nH9Hezu3KmrKpvPCA6T5UuFHSVIrr4IGlOAYpU/a24nyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KGtXTaIK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jie0V101173;
	Mon, 5 Feb 2024 13:44:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162280;
	bh=eDTJGp1LNK+YD1bJfvgjkV/rIr2yWhv+8KTb7j41Dpg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KGtXTaIKNpTRCgWBMxGewdtW9tr/I49a7Z6K481Uik1P0I1jmVPDkLL4LC4RmiwSL
	 kbqjMOuV6A/o7E1vPAxfCQOecHNyXihZEC/UzRmE2nGNU1EY8C2LP6+VjYVJsqcqJZ
	 2Z5+sJAJ00dSOv36Teztbx8N5m0qnvRUl1yyo76E=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JielY090555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:40 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:39 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQO028467;
	Mon, 5 Feb 2024 13:44:39 -0600
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
Subject: [PATCH v2 01/19] power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 5 Feb 2024 13:44:19 -0600
Message-ID: <20240205194437.180802-2-afd@ti.com>
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
 drivers/power/reset/atc260x-poweroff.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
index b4aa50e9685e1..ce2748d3282c3 100644
--- a/drivers/power/reset/atc260x-poweroff.c
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -16,7 +16,6 @@
 struct atc260x_pwrc {
 	struct device *dev;
 	struct regmap *regmap;
-	struct notifier_block restart_nb;
 	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
 };
 
@@ -172,11 +171,9 @@ static void atc260x_pwrc_pm_handler(void)
 	WARN_ONCE(1, "Unable to power off system\n");
 }
 
-static int atc260x_pwrc_restart_handler(struct notifier_block *nb,
-					unsigned long mode, void *cmd)
+static int atc260x_pwrc_restart_handler(struct sys_off_data *data)
 {
-	struct atc260x_pwrc *pwrc = container_of(nb, struct atc260x_pwrc,
-						 restart_nb);
+	struct atc260x_pwrc *pwrc = data->cb_data;
 	pwrc->do_poweroff(pwrc, true);
 
 	return NOTIFY_DONE;
@@ -194,8 +191,6 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->regmap = atc260x->regmap;
-	priv->restart_nb.notifier_call = atc260x_pwrc_restart_handler;
-	priv->restart_nb.priority = 192;
 
 	switch (atc260x->ic_type) {
 	case ATC2603C:
@@ -225,7 +220,11 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 		dev_warn(priv->dev, "Poweroff callback already assigned\n");
 	}
 
-	ret = register_restart_handler(&priv->restart_nb);
+	ret = devm_register_sys_off_handler(priv->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_HIGH,
+					    atc260x_pwrc_restart_handler,
+					    priv);
 	if (ret)
 		dev_err(priv->dev, "failed to register restart handler: %d\n",
 			ret);
@@ -241,8 +240,6 @@ static void atc260x_pwrc_remove(struct platform_device *pdev)
 		pm_power_off = NULL;
 		atc260x_pwrc_data = NULL;
 	}
-
-	unregister_restart_handler(&priv->restart_nb);
 }
 
 static struct platform_driver atc260x_pwrc_driver = {
-- 
2.39.2


