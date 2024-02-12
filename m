Return-Path: <linux-kernel+bounces-61968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA8851949
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5920E2814C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DC46420;
	Mon, 12 Feb 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lHv0ZreW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5F3F9F0;
	Mon, 12 Feb 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755334; cv=none; b=AbspU/3uWc4Owd7qePvDuHatwT+EFVOO5kTqtzCDTSqpTmN39HkJW3VY+jjX3VHlMEtYGY76mh5ggfyAx2wn2SLEuL/Vs9lJ3WD1uk03uWa0aRJMCwfHpzWjMKkxVnBLM+1hBITdHh07AByKIBix4vhV1eOSvnCACS154ZbZhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755334; c=relaxed/simple;
	bh=BDfN2nf0FtNoFJUROgfPRBi9IPv21+42h664up+VGOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfLSY09VK2u7Jzup37w0rdcAyNwNEu9lId20m3FhdsUkvTsseff5BlpnRnN6agogfngkoAJ9W3GLe+wHgZgh+x4iOg3rdysPVrpg4E4e0BebN3aXO0NCFIpP5vQJvodz44TEaR0LQM2+SKqpyMX3hTUd4gquKd20AgwfeVVfZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lHv0ZreW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSdBe068407;
	Mon, 12 Feb 2024 10:28:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755319;
	bh=xaEkc9P0QHDNnu0iRVj8KaMT84h1o2uYT86tsdK5kok=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lHv0ZreWE3UBn256s2mL98nqw/dZm1ThSWgI/EPkdWnPMwY1+s9y+XpIdM6sqUXAM
	 QxxVBiA3uE9+uBKxtFD7yrxq9AfybhpI54XR7m+sjJavyHKyovbyz9GiAryUwXsvQZ
	 AUMOasH7NyKUvefcOzCc+iwQzTkcMUAMpT4GS2X8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSdGf024890
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:39 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:39 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR6090688;
	Mon, 12 Feb 2024 10:28:38 -0600
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
Subject: [PATCH v4 10/19] power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 12 Feb 2024 10:28:22 -0600
Message-ID: <20240212162831.67838-11-afd@ti.com>
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
 drivers/power/reset/rmobile-reset.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
index 29c17ed2d4de9..80265608c18e0 100644
--- a/drivers/power/reset/rmobile-reset.c
+++ b/drivers/power/reset/rmobile-reset.c
@@ -21,22 +21,14 @@
 
 static void __iomem *sysc_base2;
 
-static int rmobile_reset_handler(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int rmobile_reset_handler(struct sys_off_data *data)
 {
-	pr_debug("%s %lu\n", __func__, mode);
-
 	/* Let's assume we have acquired the HPB semaphore */
 	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rmobile_reset_nb = {
-	.notifier_call = rmobile_reset_handler,
-	.priority = 192,
-};
-
 static int rmobile_reset_probe(struct platform_device *pdev)
 {
 	int error;
@@ -45,7 +37,11 @@ static int rmobile_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(sysc_base2))
 		return PTR_ERR(sysc_base2);
 
-	error = register_restart_handler(&rmobile_reset_nb);
+	error = devm_register_sys_off_handler(&pdev->dev,
+					      SYS_OFF_MODE_RESTART,
+					      SYS_OFF_PRIO_HIGH,
+					      rmobile_reset_handler,
+					      NULL);
 	if (error) {
 		dev_err(&pdev->dev,
 			"cannot register restart handler (err=%d)\n", error);
@@ -55,11 +51,6 @@ static int rmobile_reset_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void rmobile_reset_remove(struct platform_device *pdev)
-{
-	unregister_restart_handler(&rmobile_reset_nb);
-}
-
 static const struct of_device_id rmobile_reset_of_match[] = {
 	{ .compatible = "renesas,sysc-rmobile", },
 	{ /* sentinel */ }
@@ -68,7 +59,6 @@ MODULE_DEVICE_TABLE(of, rmobile_reset_of_match);
 
 static struct platform_driver rmobile_reset_driver = {
 	.probe = rmobile_reset_probe,
-	.remove_new = rmobile_reset_remove,
 	.driver = {
 		.name = "rmobile_reset",
 		.of_match_table = rmobile_reset_of_match,
-- 
2.39.2


