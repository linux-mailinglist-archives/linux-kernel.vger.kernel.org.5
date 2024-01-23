Return-Path: <linux-kernel+bounces-35611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985D83940B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C33C1C25F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AAC612ED;
	Tue, 23 Jan 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpONMdBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD55FBA0;
	Tue, 23 Jan 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025689; cv=none; b=mtgrizh/8yTUPLzX8DCE76aG7S1Kr9p6xOVMjkco+kuY1huq6LiZ9Kd/E4bNEqtRoFeyCsEvb+DTPzophs2cNLKiAK+BTFAXzzpz3Cfm8FDozrjUX/5D+5Cacnik1loaaeoAz+FkGD0SV6kM8g9UQdDPLM6nGJk4/YD1hb6yB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025689; c=relaxed/simple;
	bh=6Mqw4U9lSxqIWa9FJ6sWmZqd9ZOUZYznzU3IIg45qQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt7ARdrZB+SlbOh99KMD+QTahWrIXHtnm9FsO6Iq0zfRiRWSOpDQ9VbXWic7hO4KwiB62Mpl0lRDikGT/9mOkIS3T1GEVbJGMXmXzsooHkfmIdkbcyLP/hJ6o7XHeKSHpiQWcfPWM5jeyXmSsCLYu5WDtT8BJZztF3gjz8PPzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpONMdBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3A2C433C7;
	Tue, 23 Jan 2024 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025688;
	bh=6Mqw4U9lSxqIWa9FJ6sWmZqd9ZOUZYznzU3IIg45qQs=;
	h=From:To:Cc:Subject:Date:From;
	b=VpONMdBAKu8uw1JfEZF3S9P5RDExUDcoxM5mNdwYld/md1bNNQ60ij1/Bg+zz5MLn
	 Pl8PaeRNdhI0XH7U1EMa018oQqfhzPfLT06zAIWoOF8ltGYzgH31KZh/jeiZOrjDxE
	 /TtD8aU7XX5mccoAg+Lq91TQsDi9kAzKClLZdt2LoQvNb0PRsdD0eG47gJuRu0/3r6
	 tel+htjiw1RY3eN0EzhGtI/GFEDALGwwN3/RriTl0uDYM6Q36BiP9QVD3oPqeQyFKw
	 T8biAjvuYVb7G0v5CSIl+a4SHndfRMCs6/GLz9A1wha0QepusDqOfUvm4pFX565S1z
	 eFKRCFKSRhAew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rSJDZ-000000004mH-3Pib;
	Tue, 23 Jan 2024 17:01:41 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] Revert "power: supply: qcom_battmgr: Register the power supplies after PDR is up"
Date: Tue, 23 Jan 2024 17:00:53 +0100
Message-ID: <20240123160053.18331-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit b43f7ddc2b7a5a90447d96cb4d3c6d142dd4a810.

The offending commit deferred power-supply class device registration
until the service-started notification is received.

This triggers a NULL pointer dereference during boot of the Lenovo
ThinkPad X13s and SC8280XP CRD as battery status notifications can be
received before the service-start notification:

	Unable to handle kernel NULL pointer dereference at virtual address 00000000000005c0
	...
	Call trace:
	 _acquire+0x338/0x2064
	 acquire+0x1e8/0x318
	 spin_lock_irqsave+0x60/0x88
	 _supply_changed+0x2c/0xa4
	 battmgr_callback+0x1d4/0x60c [qcom_battmgr]
	 pmic_glink_rpmsg_callback+0x5c/0xa4 [pmic_glink]
	 qcom_glink_native_rx+0x58c/0x7e8
	 qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
	 __handle_irq_event_percpu+0xb0/0x2d4
	 handle_irq_event+0x4c/0xb8

As trying to serialise this is non-trivial and risks missing
notifications, let's revert to registration during probe so that the
driver data is all set up once the service goes live.

The warning message during resume in case the aDSP firmware is not
running that motivated the change can be considered a feature and should
not be suppressed.

Fixes: b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power supplies after PDR is up")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 109 +++++++++++++---------------
 1 file changed, 49 insertions(+), 60 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index a12e2a66d516..ec163d1bcd18 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -282,7 +282,6 @@ struct qcom_battmgr_wireless {
 
 struct qcom_battmgr {
 	struct device *dev;
-	struct auxiliary_device *adev;
 	struct pmic_glink_client *client;
 
 	enum qcom_battmgr_variant variant;
@@ -1294,69 +1293,11 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
 }
 
-static char *qcom_battmgr_battery[] = { "battery" };
-
-static void qcom_battmgr_register_psy(struct qcom_battmgr *battmgr)
-{
-	struct power_supply_config psy_cfg_supply = {};
-	struct auxiliary_device *adev = battmgr->adev;
-	struct power_supply_config psy_cfg = {};
-	struct device *dev = &adev->dev;
-
-	psy_cfg.drv_data = battmgr;
-	psy_cfg.of_node = adev->dev.of_node;
-
-	psy_cfg_supply.drv_data = battmgr;
-	psy_cfg_supply.of_node = adev->dev.of_node;
-	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
-	psy_cfg_supply.num_supplicants = 1;
-
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			dev_err(dev, "failed to register battery power supply (%ld)\n",
-				PTR_ERR(battmgr->bat_psy));
-
-		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->ac_psy))
-			dev_err(dev, "failed to register AC power supply (%ld)\n",
-				PTR_ERR(battmgr->ac_psy));
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			dev_err(dev, "failed to register USB power supply (%ld)\n",
-				PTR_ERR(battmgr->usb_psy));
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
-				PTR_ERR(battmgr->wls_psy));
-	} else {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			dev_err(dev, "failed to register battery power supply (%ld)\n",
-				PTR_ERR(battmgr->bat_psy));
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			dev_err(dev, "failed to register USB power supply (%ld)\n",
-				PTR_ERR(battmgr->usb_psy));
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
-				PTR_ERR(battmgr->wls_psy));
-	}
-}
-
 static void qcom_battmgr_pdr_notify(void *priv, int state)
 {
 	struct qcom_battmgr *battmgr = priv;
 
 	if (state == SERVREG_SERVICE_STATE_UP) {
-		if (!battmgr->bat_psy)
-			qcom_battmgr_register_psy(battmgr);
-
 		battmgr->service_up = true;
 		schedule_work(&battmgr->enable_work);
 	} else {
@@ -1371,9 +1312,13 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{}
 };
 
+static char *qcom_battmgr_battery[] = { "battery" };
+
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
+	struct power_supply_config psy_cfg_supply = {};
+	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
 	struct device *dev = &adev->dev;
@@ -1383,7 +1328,14 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 		return -ENOMEM;
 
 	battmgr->dev = dev;
-	battmgr->adev = adev;
+
+	psy_cfg.drv_data = battmgr;
+	psy_cfg.of_node = adev->dev.of_node;
+
+	psy_cfg_supply.drv_data = battmgr;
+	psy_cfg_supply.of_node = adev->dev.of_node;
+	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
+	psy_cfg_supply.num_supplicants = 1;
 
 	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
@@ -1395,6 +1347,43 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
+					     "failed to register battery power supply\n");
+
+		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->ac_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
+					     "failed to register AC power supply\n");
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
+					     "failed to register USB power supply\n");
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
+					     "failed to register wireless charing power supply\n");
+	} else {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
+					     "failed to register battery power supply\n");
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
+					     "failed to register USB power supply\n");
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
+					     "failed to register wireless charing power supply\n");
+	}
+
 	battmgr->client = devm_pmic_glink_register_client(dev,
 							  PMIC_GLINK_OWNER_BATTMGR,
 							  qcom_battmgr_callback,
-- 
2.43.0


