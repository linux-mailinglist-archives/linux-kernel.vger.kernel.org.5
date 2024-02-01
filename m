Return-Path: <linux-kernel+bounces-48646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD9845F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE6B3083D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1712D156;
	Thu,  1 Feb 2024 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w1pNiTRg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EC8526D;
	Thu,  1 Feb 2024 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810498; cv=none; b=h+KoppKlwPtgNiyLzZG+jaagi+B8EfbdWbB5q/aLxTNiS31dsgoepU3nEpLji8AupM+bXv26QKp4K5jyKcjVi1doWc7Kg2lj3IGynxYGCGDyE310Hpc5R7biUf9NQPDDkhq4Olcs7zbhpIfW8wLpcOcJBRDdmPJwAyi9wX/KgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810498; c=relaxed/simple;
	bh=cM1cFjnSzQs76i3u0egboaHOZ+8JvQ6u6lgJc80Opuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IG6tCpP9EQGJTFvdstA/WlF1/SVbgQbhb7ignp90ZnO6nyqj9Y+Uxd8gzUKGLlwQ9KQtlQ9hO/oq4lqt8KO7+sohJm9Tj3ggYlayyUVjG+/prR47mchCLcsjGBqyUp95ph0S0cI/p2NY6Bbdijk+VdR2fDEaqX2kYAM0KML8u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w1pNiTRg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I16NW127754;
	Thu, 1 Feb 2024 12:01:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810466;
	bh=awh4L/FvuKTUk4LCovxuQcQcm/YmAlMhgCuKLpIU3pA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=w1pNiTRgiYLJ3cK7YvY8c2Pa4edi510sVdoaT8seLl/gN9yEbfAU6Nl/gX2KqZhQO
	 jQpE3eI6pz/LFdKE9c6sgY5455FAfFmj3+bpt38atd6cneNOvWGhnDOl3+cEWWiOyv
	 Xws7a6m7Jn2cXLLzac0mfvROnKD1dLeI5pESMkco=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I16oq120370
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:06 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Gj117221;
	Thu, 1 Feb 2024 12:01:06 -0600
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
Subject: [PATCH 05/18] power: reset: tps65086-restart: Remove unneeded device data struct
Date: Thu, 1 Feb 2024 12:00:49 -0600
Message-ID: <20240201180102.70395-6-afd@ti.com>
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


