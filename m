Return-Path: <linux-kernel+bounces-61964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AF85193A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5183B217B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82CA3FB31;
	Mon, 12 Feb 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NigIJQCP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5913E474;
	Mon, 12 Feb 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755331; cv=none; b=JzipcdtRnvINHCh6167uOlow1Y2EGrLsCbnf7AT2WRovbLT1CuYv7CTca84QB9resmlGwsLsRMlYwJU7JHnQcue1QHHwwoQaVdZGIVIzURRwinKas5iRzSFPxPD2YoYr7/q5cGhHQmYswcTWupQN9S/favp1kr9msMYuRMe/ZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755331; c=relaxed/simple;
	bh=hjODPAvfHHQsYQrgcPIWkoWLz7Tm/5vLqy/n+aT9TWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cK6y4q6yulMjuykqmxyuxlrBxeZFFJXrIsBZJEJm9MLAOhRVinETKvq4aOzAh7gA55q6P+7zf2gC90jAQdjYcxETDvnpaBRtZTpNLuDg3ToGqY9nOyUYcVF7DBnI8hq/kRdCMSN0lhkujcXx8O7xP2VDPN48LL+O/Pf3atTW+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NigIJQCP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSY9n080174;
	Mon, 12 Feb 2024 10:28:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755314;
	bh=eDTJGp1LNK+YD1bJfvgjkV/rIr2yWhv+8KTb7j41Dpg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NigIJQCP0PJXxoPX/D0CJJBkyc6Ign+K2fxu+Pg/Ua3l6FrsplqKGW0fkvCdS6lpb
	 SVxYwRWS20ulLDCENqizre0LaHd6uHZac5kBCCxQ4JraEiqt84K/sSkFmrnDUmZRJ5
	 sms8Nb0TTyQjvNjg4iGHJuEayQVM/x8BTYEXvONw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSYar008653
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:33 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWQv090688;
	Mon, 12 Feb 2024 10:28:33 -0600
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
Subject: [PATCH v4 01/19] power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(RESTART)
Date: Mon, 12 Feb 2024 10:28:13 -0600
Message-ID: <20240212162831.67838-2-afd@ti.com>
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
 drivers/power/reset/atc260x-poweroff.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/atc260x-poweroff.c b/drivers/power/reset/atc260x-poweroff.c
index b4aa50e9685e1..ce2748d3282c3 100644
--- a/drivers/power/reset/atc260x-poweroff.c
+++ b/drivers/power/reset/atc260x-poweroff.c
@@ -16,7 +16,6 @@
 struct atc260x_pwrc {
 	struct device *dev;
 	struct regmap *regmap;
-	struct notifier_block restart_nb;
 	int (*do_poweroff)(const struct atc260x_pwrc *pwrc, bool restart);
 };
 
@@ -172,11 +171,9 @@ static void atc260x_pwrc_pm_handler(void)
 	WARN_ONCE(1, "Unable to power off system\n");
 }
 
-static int atc260x_pwrc_restart_handler(struct notifier_block *nb,
-					unsigned long mode, void *cmd)
+static int atc260x_pwrc_restart_handler(struct sys_off_data *data)
 {
-	struct atc260x_pwrc *pwrc = container_of(nb, struct atc260x_pwrc,
-						 restart_nb);
+	struct atc260x_pwrc *pwrc = data->cb_data;
 	pwrc->do_poweroff(pwrc, true);
 
 	return NOTIFY_DONE;
@@ -194,8 +191,6 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->regmap = atc260x->regmap;
-	priv->restart_nb.notifier_call = atc260x_pwrc_restart_handler;
-	priv->restart_nb.priority = 192;
 
 	switch (atc260x->ic_type) {
 	case ATC2603C:
@@ -225,7 +220,11 @@ static int atc260x_pwrc_probe(struct platform_device *pdev)
 		dev_warn(priv->dev, "Poweroff callback already assigned\n");
 	}
 
-	ret = register_restart_handler(&priv->restart_nb);
+	ret = devm_register_sys_off_handler(priv->dev,
+					    SYS_OFF_MODE_RESTART,
+					    SYS_OFF_PRIO_HIGH,
+					    atc260x_pwrc_restart_handler,
+					    priv);
 	if (ret)
 		dev_err(priv->dev, "failed to register restart handler: %d\n",
 			ret);
@@ -241,8 +240,6 @@ static void atc260x_pwrc_remove(struct platform_device *pdev)
 		pm_power_off = NULL;
 		atc260x_pwrc_data = NULL;
 	}
-
-	unregister_restart_handler(&priv->restart_nb);
 }
 
 static struct platform_driver atc260x_pwrc_driver = {
-- 
2.39.2


