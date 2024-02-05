Return-Path: <linux-kernel+bounces-53847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6784A73E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E03A1C267B0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6B7319E;
	Mon,  5 Feb 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fVK6Jrdp"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEB6A359;
	Mon,  5 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162306; cv=none; b=LUp1l/7YhiC4h0SmVW7qz8+ajMHQtpYDQFDkDFXC9urmKBlAsiorgvP+IzoNe+jq8oRPBj9qtpgVnqqDzK07oUnRuMZxCOVY519+oGTZd+uKdqFvy3Xlzn+vgdZhNXR+6ke3uN2dGV3aq/PQFhedDIyLyY9PSnl4rq13gvuNV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162306; c=relaxed/simple;
	bh=QekKnIF+GkovKO7gb14ZkIhecaU+qacpUcgS7SjOB24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTLUqypC4Yd8Oje/qYuP3LWyajqg4dlRozDBH0M+zq7wS45YA2qZs8ObLTWNYkQF62LMzjCXnotKvDOADjlGNj/xQxHonGemqn/tk3G6o4SI5VVmt+BteA6WkcktifCouGSjHnB8On3C1KCuSCVb9Lf0ovvwXF3B710gc/8oou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fVK6Jrdp; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jiiou010948;
	Mon, 5 Feb 2024 13:44:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162284;
	bh=2TI8f8x/5Y4Kr2Vxqhq6Wi5Pu8tSR0ICKXsQgkmtu64=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fVK6JrdpM2cJwetj/TG79ucMkxYwOcYhcSwbRobFnWuCJmLSCg3tfNl3Lvvas86H+
	 oMQCCdRDquJRW45mGtVxR66h8DW38oJ6JGE0UbeuranOEKBDAG7um9DpGPvRSMC5mB
	 TBmFHyOYh7GYSL6XtqQ8Ro+SRfBR/l5k3PLC8Quo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Jii1p090637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:44 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:44 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQV028467;
	Mon, 5 Feb 2024 13:44:43 -0600
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
Subject: [PATCH v2 08/19] power: reset: axxia-reset: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 5 Feb 2024 13:44:26 -0600
Message-ID: <20240205194437.180802-9-afd@ti.com>
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

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/axxia-reset.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index 24946766760c3..797bf6773860e 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -26,11 +26,10 @@
 #define SC_EFUSE_INT_STATUS	0x180c
 #define   EFUSE_READ_DONE	(1<<31)
 
-static struct regmap *syscon;
-
-static int axxia_restart_handler(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int axxia_restart_handler(struct sys_off_data *data)
 {
+	struct regmap *syscon = data->cb_data;
+
 	/* Access Key (0xab) */
 	regmap_write(syscon, SC_CRIT_WRITE_KEY, 0xab);
 	/* Select internal boot from 0xffff0000 */
@@ -44,14 +43,10 @@ static int axxia_restart_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block axxia_restart_nb = {
-	.notifier_call = axxia_restart_handler,
-	.priority = 128,
-};
-
 static int axxia_reset_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct regmap *syscon;
 	int err;
 
 	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
@@ -60,7 +55,8 @@ static int axxia_reset_probe(struct platform_device *pdev)
 		return PTR_ERR(syscon);
 	}
 
-	err = register_restart_handler(&axxia_restart_nb);
+	err = devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+					    128, axxia_restart_handler, syscon);
 	if (err)
 		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
 
-- 
2.39.2


