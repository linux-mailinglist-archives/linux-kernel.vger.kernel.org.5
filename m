Return-Path: <linux-kernel+bounces-48644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23732845F35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EA91C2889A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C1127B60;
	Thu,  1 Feb 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TkMHSo1B"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7012880C;
	Thu,  1 Feb 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810496; cv=none; b=jR+clYl4utEf15MzrClt+GT51w7VJDKaSfz61g+PH3RoFnR8F9wTPu1VDIdLing3FejzIyOEpocESR9wOfD1rWw/kzfPpzJfQszVxRdHf47q3hnjMsAx6/HpcQM0w+cd4+DCY9dI2Xl5G/5rVwQbroQdjJt3DBJ+WUI9lTsCATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810496; c=relaxed/simple;
	bh=wOijXjJjHUtVV5dF2aD/1HsDkNeACwTKkwSZrl92nVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSyx2j54IwjhOaXUfRVG3YfwT9eKLJuAMA+ddSDUCDP1tT5T5SeACagRWGL+xSJaFU8HEGobgvGVdSDL6O9i5AdAe16+tXP53KZ3HYj82aY8Jr2SGHlnxWsh8f1NkTE6T50WUKOS8AEA5T4rVmia91gVDo2B1rYF+wsMz7QzKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TkMHSo1B; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I199X051703;
	Thu, 1 Feb 2024 12:01:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810469;
	bh=+6oayEskVPsQjbi/C7/hq7hBkB4TpvJeAVLuE/xrEZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TkMHSo1BMyKoOIbCWU3HX8M28fj0T0x3o3StVz6DcodkPqNOgrTa8GWGnzto05G1T
	 it5cLq9uOej23dW0hC4TOpK3HF215DWpczQB7yt0qw4HW/KjMOwQpPQ6MXblpItdsC
	 gAMSfCetLVILORJaDa6kR2UokQIXzowQPIEi5RVI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I19DL047540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:09 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:09 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Gn117221;
	Thu, 1 Feb 2024 12:01:08 -0600
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
Subject: [PATCH 09/18] power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTART)
Date: Thu, 1 Feb 2024 12:00:53 -0600
Message-ID: <20240201180102.70395-10-afd@ti.com>
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
 drivers/power/reset/rmobile-reset.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/rmobile-reset.c b/drivers/power/reset/rmobile-reset.c
index 29c17ed2d4de9..41e98ff33a3c3 100644
--- a/drivers/power/reset/rmobile-reset.c
+++ b/drivers/power/reset/rmobile-reset.c
@@ -19,12 +19,9 @@
 /* Reset Control Register 2 */
 #define RESCNT2_PRES	0x80000000	/* Soft power-on reset */
 
-static void __iomem *sysc_base2;
-
-static int rmobile_reset_handler(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int rmobile_reset_handler(struct sys_off_data *data)
 {
-	pr_debug("%s %lu\n", __func__, mode);
+	void __iomem *sysc_base2 = data->cb_data;
 
 	/* Let's assume we have acquired the HPB semaphore */
 	writel(RESCNT2_PRES, sysc_base2 + RESCNT2);
@@ -32,20 +29,20 @@ static int rmobile_reset_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block rmobile_reset_nb = {
-	.notifier_call = rmobile_reset_handler,
-	.priority = 192,
-};
-
 static int rmobile_reset_probe(struct platform_device *pdev)
 {
+	void __iomem *sysc_base2;
 	int error;
 
 	sysc_base2 = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sysc_base2))
 		return PTR_ERR(sysc_base2);
 
-	error = register_restart_handler(&rmobile_reset_nb);
+	error = devm_register_sys_off_handler(&pdev->dev,
+					      SYS_OFF_MODE_RESTART,
+					      SYS_OFF_PRIO_HIGH,
+					      rmobile_reset_handler,
+					      sysc_base2);
 	if (error) {
 		dev_err(&pdev->dev,
 			"cannot register restart handler (err=%d)\n", error);
@@ -55,11 +52,6 @@ static int rmobile_reset_probe(struct platform_device *pdev)
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
@@ -68,7 +60,6 @@ MODULE_DEVICE_TABLE(of, rmobile_reset_of_match);
 
 static struct platform_driver rmobile_reset_driver = {
 	.probe = rmobile_reset_probe,
-	.remove_new = rmobile_reset_remove,
 	.driver = {
 		.name = "rmobile_reset",
 		.of_match_table = rmobile_reset_of_match,
-- 
2.39.2


