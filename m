Return-Path: <linux-kernel+bounces-61970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAAB851950
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723A31C21901
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2F47F64;
	Mon, 12 Feb 2024 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Am0deps7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B219405FB;
	Mon, 12 Feb 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755335; cv=none; b=CvXp4EHmHhNI9dJLvpE+NNHh48jkcRyoz8bVUO7zoZPTzLP7gLF2gMrwZgeKl8iJgI3Vl18XVhnXjJcMfnY0z/59aEpi56r4TRgpjF0E3qKCjU+FhsO061rRtkgFxhdVJ09iwNWRh2A0YR8ucdmA3r4upSk3dApdzQwrB9pt/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755335; c=relaxed/simple;
	bh=BuseNTmNQHKa6n9amDOBClsdZ0D9LZdzj/CNbNLRzZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0U/0Ruudu1i5MPixJs6T7g0YP+/pYJbQGfls7BQ9wN8QtSG8kzptXOfdXy66g+7OXGfOqda8EIveK2HfT1Ji+OuKjpZZPACcUpkaUr8pCVxu64l7xpd3hNJfIQQc7DZznIyi0aVtyMaK6o7QdjhtCFC1RfDwT3DQnXsA1lkxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Am0deps7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSfIH080188;
	Mon, 12 Feb 2024 10:28:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755321;
	bh=5yT8z6101FegqnCWOdNRzgX95I/RK7WLUUhdSWlfyIs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Am0deps7rurZ3m5+7WIRYEImqzpVhDUoJtS4qJdjbom+FBqGon9vKaG5loMrRQPUD
	 /ONxtxIPmcCIkon+2rjSHfDetSxan/bXJvaI9IMYM46oaGmnlTNLqGt3rg8M9+j/UX
	 5g4xHMLYzqC+xPoZqCdBaU+tpjBEnXjyMLNKaelQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSfGc024907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:41 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:41 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWR9090688;
	Mon, 12 Feb 2024 10:28:40 -0600
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
Subject: [PATCH v4 13/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 12 Feb 2024 10:28:25 -0600
Message-ID: <20240212162831.67838-14-afd@ti.com>
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

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/msm-poweroff.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index 3bf0ea06c4853..c7eb6dc8e90ae 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -14,23 +14,11 @@
 #include <linux/pm.h>
 
 static void __iomem *msm_ps_hold;
-static int deassert_pshold(struct notifier_block *nb, unsigned long action,
-			   void *data)
-{
-	writel(0, msm_ps_hold);
-	mdelay(10000);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block restart_nb = {
-	.notifier_call = deassert_pshold,
-	.priority = 128,
-};
 
 static int do_msm_poweroff(struct sys_off_data *data)
 {
-	deassert_pshold(&restart_nb, 0, NULL);
+	writel(0, msm_ps_hold);
+	mdelay(10000);
 
 	return NOTIFY_DONE;
 }
@@ -41,7 +29,8 @@ static int msm_restart_probe(struct platform_device *pdev)
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	register_restart_handler(&restart_nb);
+	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+				      128, do_msm_poweroff, NULL);
 
 	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
 				      SYS_OFF_PRIO_DEFAULT, do_msm_poweroff,
-- 
2.39.2


