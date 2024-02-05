Return-Path: <linux-kernel+bounces-53839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B394A84A728
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E68A289E7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2564A9B;
	Mon,  5 Feb 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R3yRjmdB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF2634FD;
	Mon,  5 Feb 2024 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162299; cv=none; b=sd4P5aROgEqyb9xTTZt4dpa47/5mPG0XUYw/2r+IChj9c/i+d8xew4PqOyN7A0bpFebZRH1UEDFhPIML9TEz0o626vJdNvFLJy0Nf9DbB46ByYpQB7OsHxIbYv+Kb9IJxCJXoE2PI0+e9NMq+y/sMTM+DJd76IlXWuaHJTlAnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162299; c=relaxed/simple;
	bh=BDfN2nf0FtNoFJUROgfPRBi9IPv21+42h664up+VGOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX4HdwcYAigwXLeidm9fDClMKVjNP83J9NuA8xFKxlaC9l6R4bASDJHIzk3JPFk8VlSQyjyCm8INpx1Pl9pwRN+rR67QpxFK52+2eTnlUH1j1XkXOGnDfP2MBz4Kg+bLIY5aaJFJiV/4uQfZdX5DixDauaDnTyX2UNdnJNER0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R3yRjmdB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JijoD016354;
	Mon, 5 Feb 2024 13:44:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162285;
	bh=xaEkc9P0QHDNnu0iRVj8KaMT84h1o2uYT86tsdK5kok=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R3yRjmdBHuYHapf0HnrgDpEAzbHbM55+XT9JFPsuhyTrYvK1160tynFOJH5lOM/+1
	 PVlGQbGm7CUNXDrxeGoZiUz+06zibPLpSdYze0/HzKzQ2xEvZipwJAzyyqHkDGuTUM
	 6gs7bdZ+xTBZGch868y37IEILV1D2trKYjeYa6uM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JijhR003481
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:45 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQX028467;
	Mon, 5 Feb 2024 13:44:44 -0600
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
Subject: [PATCH v2 10/19] power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 5 Feb 2024 13:44:28 -0600
Message-ID: <20240205194437.180802-11-afd@ti.com>
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


