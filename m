Return-Path: <linux-kernel+bounces-61961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9ED851935
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDAB280D74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985FD3FB19;
	Mon, 12 Feb 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KhuSzMZZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F73D547;
	Mon, 12 Feb 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755329; cv=none; b=X/ko19/bWOUtp6IfG2uZTiRatoCD0BJNdyVEdSnr/bYg0RwWUTwbWap+Bpp0Gv/71qHcaZYn+t/tBDSSli1ttfz2WZELr0Mg1vvXijMbNAI6fd1uFetlSNAUNJnq0jcGqIzSdxQbTPh6jLUETMhmCdHqBtdl764dMlBFcdwLbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755329; c=relaxed/simple;
	bh=cM1cFjnSzQs76i3u0egboaHOZ+8JvQ6u6lgJc80Opuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AavhmC3rqduI5O6MeyNLiubp7JbAccjqJBiTcpXkZnSGVBcCX21hTMg8TGbLTwMko5NboCrHl5oonXiQbJfuJquT3PT5uxRVHgQkzyqmO2vs5xi0BCAkaA4BJX1bSIAImrku6PkAau9bB1B8x8Y30CmJBRNbPsr18eEEvXSiNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KhuSzMZZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSbjh004152;
	Mon, 12 Feb 2024 10:28:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755317;
	bh=awh4L/FvuKTUk4LCovxuQcQcm/YmAlMhgCuKLpIU3pA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KhuSzMZZYFT9Ke/54Lqtd9TYN3hzuoQkiUVlJ2lrixh98IkZwXcgQvD8PZ+sqkVwv
	 XcyRVSoiFslc7QvGR/xbaGtbD+AzPY4tk3fqkoFnijfXcZ1Wrf+MUI4Ut3P3lpee2N
	 lBq15gp2HugbTofud/HgeBujqU7ml9dr56lCv91o=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSb6v024867
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:37 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:36 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR2090688;
	Mon, 12 Feb 2024 10:28:36 -0600
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
Subject: [PATCH v4 06/19] power: reset: tps65086-restart: Remove unneeded device data struct
Date: Mon, 12 Feb 2024 10:28:18 -0600
Message-ID: <20240212162831.67838-7-afd@ti.com>
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

We only need one member of the struct tps65086_restart, pass that
tps65086_restart_notify() directly. Remove that struct and its
allocation.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/tps65086-restart.c | 35 ++++++--------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index 82d7a761a0385..6976dbcac74fa 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -9,19 +9,14 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 
-struct tps65086_restart {
-	struct device *dev;
-};
-
 static int tps65086_restart_notify(struct sys_off_data *data)
 {
-	struct tps65086_restart *tps65086_restart = data->cb_data;
-	struct tps65086 *tps65086 = dev_get_drvdata(tps65086_restart->dev->parent);
+	struct tps65086 *tps65086 = data->cb_data;
 	int ret;
 
 	ret = regmap_write(tps65086->regmap, TPS65086_FORCESHUTDN, 1);
 	if (ret) {
-		dev_err(tps65086_restart->dev, "%s: error writing to tps65086 pmic: %d\n",
+		dev_err(tps65086->dev, "%s: error writing to tps65086 pmic: %d\n",
 			__func__, ret);
 		return NOTIFY_DONE;
 	}
@@ -36,27 +31,13 @@ static int tps65086_restart_notify(struct sys_off_data *data)
 
 static int tps65086_restart_probe(struct platform_device *pdev)
 {
-	struct tps65086_restart *tps65086_restart;
-	int ret;
-
-	tps65086_restart = devm_kzalloc(&pdev->dev, sizeof(*tps65086_restart), GFP_KERNEL);
-	if (!tps65086_restart)
-		return -ENOMEM;
-
-	tps65086_restart->dev = &pdev->dev;
-
-	ret = devm_register_sys_off_handler(&pdev->dev,
-					    SYS_OFF_MODE_RESTART,
-					    SYS_OFF_PRIO_HIGH,
-					    tps65086_restart_notify,
-					    tps65086_restart);
-	if (ret) {
-		dev_err(&pdev->dev, "%s: cannot register restart handler: %d\n",
-			__func__, ret);
-		return -ENODEV;
-	}
+	struct tps65086 *tps65086 = dev_get_drvdata(pdev->dev.parent);
 
-	return 0;
+	return devm_register_sys_off_handler(&pdev->dev,
+					     SYS_OFF_MODE_RESTART,
+					     SYS_OFF_PRIO_HIGH,
+					     tps65086_restart_notify,
+					     tps65086);
 }
 
 static const struct platform_device_id tps65086_restart_id_table[] = {
-- 
2.39.2


