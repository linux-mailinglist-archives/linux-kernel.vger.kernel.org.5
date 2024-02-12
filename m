Return-Path: <linux-kernel+bounces-61960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB2A851930
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791C22824E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6393EA71;
	Mon, 12 Feb 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i4FPyRbs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8103D39F;
	Mon, 12 Feb 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755329; cv=none; b=o0sH0AIri3kjlbb6Q3K+LRvOPCD4A88xgui1PABC902dOubOUxWNrDUShLAexZVn0yB1bEG9ijrAbHsDs0AXmllh9a15oOqDmI3W9ZF1JSYlDrIked/k5UtviUq+K4zGbKiBzFspEH/OojPXHCz8AnQM0L7QR4ow5SB56gKQVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755329; c=relaxed/simple;
	bh=Lm8ufyWOJHp/dqvPwPh3Hgph+gKZYEOGeH+5IYuik28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGvJNFybfeuM3I6tYg0mnz+O7ASMIvQ9lQd4vcm3jHhf/4N75wHQimAVLf3wCh4XbNdh6qcjcRNwBdwfW9HN3pouUn4nj9IcARJF8beX0eih10QSrWQdKvmVG6+0difEQzamTY+al0oxLBEjwFJAEGqGNCw6SWmuajNdtfcdxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i4FPyRbs; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSahR004148;
	Mon, 12 Feb 2024 10:28:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755316;
	bh=WrDlA3MVIblMNMt/x1ENZcDUaj6UX9hq3LACckiD2VI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i4FPyRbsyjmPOO8wC3nNU+9otcmKAlUJpjCdCZtEo9ZkAi7c6ZdvNnuDpyFcY3ttW
	 RbU/qIIRFgQB+rnnXLnPbIw4x2hsp8q4JrfYLQgEGWfjYBeCXSE6vfzE/N99UQTY3I
	 3YnRcEPwpr7W75QIWiPZl23BiMP0tWuDfReiaJTQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSaYa024858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:36 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:36 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR1090688;
	Mon, 12 Feb 2024 10:28:35 -0600
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
Subject: [PATCH v4 05/19] power: reset: tps65086-restart: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 12 Feb 2024 10:28:17 -0600
Message-ID: <20240212162831.67838-6-afd@ti.com>
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

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/tps65086-restart.c | 35 ++++++--------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index ee8e9f4b837ea..82d7a761a0385 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -10,15 +10,12 @@
 #include <linux/reboot.h>
 
 struct tps65086_restart {
-	struct notifier_block handler;
 	struct device *dev;
 };
 
-static int tps65086_restart_notify(struct notifier_block *this,
-				   unsigned long mode, void *cmd)
+static int tps65086_restart_notify(struct sys_off_data *data)
 {
-	struct tps65086_restart *tps65086_restart =
-		container_of(this, struct tps65086_restart, handler);
+	struct tps65086_restart *tps65086_restart = data->cb_data;
 	struct tps65086 *tps65086 = dev_get_drvdata(tps65086_restart->dev->parent);
 	int ret;
 
@@ -46,13 +43,13 @@ static int tps65086_restart_probe(struct platform_device *pdev)
 	if (!tps65086_restart)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, tps65086_restart);
-
-	tps65086_restart->handler.notifier_call = tps65086_restart_notify;
-	tps65086_restart->handler.priority = 192;
 	tps65086_restart->dev = &pdev->dev;
 
-	ret = register_restart_handler(&tps65086_restart->handler);
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_HIGH,
+					    tps65086_restart_notify,
+					    tps65086_restart);
 	if (ret) {
 		dev_err(&pdev->dev, "%s: cannot register restart handler: %d\n",
 			__func__, ret);
@@ -62,23 +59,6 @@ static int tps65086_restart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void tps65086_restart_remove(struct platform_device *pdev)
-{
-	struct tps65086_restart *tps65086_restart = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = unregister_restart_handler(&tps65086_restart->handler);
-	if (ret) {
-		/*
-		 * tps65086_restart_probe() registered the restart handler. So
-		 * unregistering should work fine. Checking the error code
-		 * shouldn't be needed, still doing it for completeness.
-		 */
-		dev_err(&pdev->dev, "%s: cannot unregister restart handler: %d\n",
-			__func__, ret);
-	}
-}
-
 static const struct platform_device_id tps65086_restart_id_table[] = {
 	{ "tps65086-reset", },
 	{ /* sentinel */ }
@@ -90,7 +70,6 @@ static struct platform_driver tps65086_restart_driver = {
 		.name = "tps65086-restart",
 	},
 	.probe = tps65086_restart_probe,
-	.remove_new = tps65086_restart_remove,
 	.id_table = tps65086_restart_id_table,
 };
 module_platform_driver(tps65086_restart_driver);
-- 
2.39.2


