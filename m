Return-Path: <linux-kernel+bounces-53850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391E84A74D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422BAB21D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688777622;
	Mon,  5 Feb 2024 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SUJ3YcvT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6C73189;
	Mon,  5 Feb 2024 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162309; cv=none; b=qnjkhtqUMt9w6L0bMqn44nsyW1nh0rubEgBhHAgR+Pa8xfTkWiozLLJuTCsgfrSjllhIYso1of83MaB7NgNfeCZzGU2iYrRDSrQ63MwDVwqJxdYMP/XiwobYArPzAPkZqP9Z46G0AtejebxpD/9lvD4AzNHAHiOGd7dSwja2cTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162309; c=relaxed/simple;
	bh=cM1cFjnSzQs76i3u0egboaHOZ+8JvQ6u6lgJc80Opuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enxxC+LA8+krPN2Cv5zy6ngOAeuBDH+bUz7aoz9Jb9qOV38a+eoLgo0y7VqUCW0mebnO5Ent89y3t7PpkKUtCPU9BhnFSoMsq8zhPR/0dK3bup98UGAPwtQKC12rHgDL6QAqi9cQ6IQ3ix0nKo5iJ8QSgB8bfF28Sb09FhKkfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SUJ3YcvT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jihna101188;
	Mon, 5 Feb 2024 13:44:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162283;
	bh=awh4L/FvuKTUk4LCovxuQcQcm/YmAlMhgCuKLpIU3pA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SUJ3YcvTszMWD1WwIh++hFLIxAH735PX7tg5KxFB7VOI+3a17kIUDuSe4PEEQZDuS
	 5QIVkmmSQcLgZzLloTbWW216lEPldOegGRwbs8noeAUq9DfrGCvk2wHbkddnzKlUA9
	 BODoYHr1wM3kOR1NThM0RZDx9PkTJD7p6dHu4vvw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JihKo071021
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:43 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:43 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQT028467;
	Mon, 5 Feb 2024 13:44:42 -0600
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
Subject: [PATCH v2 06/19] power: reset: tps65086-restart: Remove unneeded device data struct
Date: Mon, 5 Feb 2024 13:44:24 -0600
Message-ID: <20240205194437.180802-7-afd@ti.com>
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


