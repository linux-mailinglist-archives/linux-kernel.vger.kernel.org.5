Return-Path: <linux-kernel+bounces-58414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A184E63C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5E81C20AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34312BF26;
	Thu,  8 Feb 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a2mm/96D"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECD84FB4;
	Thu,  8 Feb 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411879; cv=none; b=kYB7s1jIYPi5Q7YOLZjeUmt08AAubI45xFIVQrDFuYQsfVpNXGk4yOUEF1uOkobCzTARnqWxGuMfqVpurS8MDRz9HM2fhC7LigoW+7UezqUVJthG0EuSnCO7geBmIlqyrUlmqy2lI+Mqge5472BkMMODKPLokxqXFmH48FUdmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411879; c=relaxed/simple;
	bh=piwvd9XDrLI4E6nIns4idZqQIBccnh+XSsbLYNv6vd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p90RG+GHZe0r1ntiT3k7bRbFcpWRlufmVIaAfvOhhLYf0R+kxBCKhDFgRt2W6Jh1LURllTRgPGGGvE3WgAyt4z0XWiEPdWQoFe3F9KG5K6ISZqWPKuGHKxtobSMx146fiYM8Y1LOuUSn0J+cs/J3dZp0hxNEK81ds7U23+5ejZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a2mm/96D; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4EgM018136;
	Thu, 8 Feb 2024 11:04:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411854;
	bh=2cm9ruqVmpJKRpRfi1ywbymPKB5JK0jfSdZffEo1IXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=a2mm/96D/h/wVGxYXwiMncfstNtfHFmpzKH4wJTmb/tRA4GbRPKHCEmsMhR6ksrDN
	 urzQNhBn9oLvRVQ0HWXMs+XhpBCybLK44kPY1M3x6JnCFcartY68vi/0oHCYR5HW7F
	 kRoT+U7jAtnCV2bfcagQrDO0gjGiOTLVt3nYn19s=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4DxE023306
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:14 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:13 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B64091006;
	Thu, 8 Feb 2024 11:04:13 -0600
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
Subject: [PATCH v3 02/19] power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 8 Feb 2024 11:03:53 -0600
Message-ID: <20240208170410.67975-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208170410.67975-1-afd@ti.com>
References: <20240208170410.67975-1-afd@ti.com>
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
 drivers/power/reset/atc260x-poweroff.c | 38 ++++++++++----------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
index ce2748d3282c3..e3e4621ccb1dd 100644
--- a/drivers/power/reset/atc260x-poweroff.c
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -19,9 +19,6 @@ struct atc260x_pwrc {
 	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
 };
 
-/* Global variable needed only for pm_power_off */
-static struct atc260x_pwrc *atc260x_pwrc_data;
-
 static int atc2603c_do_poweroff(const struct atc260x_pwrc *pwrc, bool restart)
 {
 	int ret, deep_sleep = 0;
@@ -164,11 +161,15 @@ static int atc2609a_init(const struct atc260x_pwrc *pwrc)
 	return ret;
 }
 
-static void atc260x_pwrc_pm_handler(void)
+static int atc260x_pwrc_pm_handler(struct sys_off_data *data)
 {
-	atc260x_pwrc_data->do_poweroff(atc260x_pwrc_data, false);
+	struct atc260x_pwrc *pwrc = data->cb_data;
+
+	pwrc->do_poweroff(pwrc, false);
 
 	WARN_ONCE(1, "Unable to power off system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int atc260x_pwrc_restart_handler(struct sys_off_data *data)
@@ -211,14 +212,14 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
-
-	if (!pm_power_off) {
-		atc260x_pwrc_data = priv;
-		pm_power_off = atc260x_pwrc_pm_handler;
-	} else {
-		dev_warn(priv->dev, "Poweroff callback already assigned\n");
-	}
+	ret = devm_register_sys_off_handler(priv->dev,
+					    SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    atc260x_pwrc_pm_handler,
+					    priv);
+	if (ret)
+		dev_err(priv->dev, "failed to register power-off handler: %d\n",
+			ret);
 
 	ret = devm_register_sys_off_handler(priv->dev,
 					    SYS_OFF_MODE_RESTART,
@@ -232,19 +233,8 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void atc260x_pwrc_remove(struct platform_device *pdev)
-{
-	struct atc260x_pwrc *priv = platform_get_drvdata(pdev);
-
-	if (atc260x_pwrc_data == priv) {
-		pm_power_off = NULL;
-		atc260x_pwrc_data = NULL;
-	}
-}
-
 static struct platform_driver atc260x_pwrc_driver = {
 	.probe = atc260x_pwrc_probe,
-	.remove_new = atc260x_pwrc_remove,
 	.driver = {
 		.name = "atc260x-pwrc",
 	},
-- 
2.39.2


