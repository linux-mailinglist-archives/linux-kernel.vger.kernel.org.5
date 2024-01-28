Return-Path: <linux-kernel+bounces-41697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE0583F6A3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FA3281F94
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63484EB22;
	Sun, 28 Jan 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u20FnNq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508D4D583;
	Sun, 28 Jan 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458319; cv=none; b=qFqAY14sKRNL70r22MHlAxwQFlFUloYECUraydqic7FQxLnzvMM8nP15s95RMk/Iyr+PoidX2Kot6yYQl+k6amJvgA+FmHqRjD/0Qj6B1s4QSR5VydryJoKij2GkHFdGAD+Fda5sB/9GrYuJtq6dC1/x+hWtKsnxoQFY5SBc6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458319; c=relaxed/simple;
	bh=IsjkGq7r2ZRS9Sa1YiAaxwYPtBr+IZGLQatioFb8px0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q++Hlru30NOoOR4S9z55lGGFVLUKmmslZSUESoY4kR6fDnlTwcgVOvNLZ7xqjD8x9MeqD2vgR5SrUQNXG1A33pccVRcOTp21OsaWEt3TbYb5ZAB9sS6KZCHzDia+N2vl2pVwcnX5xrbO0+oFghn5hVpC25fy+hPchFzGwipG1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u20FnNq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C0C433F1;
	Sun, 28 Jan 2024 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458319;
	bh=IsjkGq7r2ZRS9Sa1YiAaxwYPtBr+IZGLQatioFb8px0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u20FnNq4nfGWainyZpEgYhzq+QlCJY7mDumZH3XbxFEAYIKOuf2ZzM1vnwzctg3t4
	 1jsIsrP4nJnGZv84dn5DYETV3VsacEDEIAxfujm92DPM+QMOtYLk4arIRP6l6U5a2x
	 lV7qHWEA+ZBJFzkYStVz5hojq7KrMX87EGduy6GNQ820n2xT8M7f2iRMKbdAEAlSmL
	 7IVGkJRdrm/7L/uqUtSnDyNT42weVegpNA7ejv6wd6GPO718xnf+cJfWthuFBtvRYB
	 Ai2RmGvLSL+IouvtXcStVkqkL5fPeng1D4l4HMJ8RK+BlTpdt9crkq+P/2M4/G3CXq
	 cIbEbmGQUdBcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	andersson@kernel.org,
	sre@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 15/39] power: supply: qcom_battmgr: Register the power supplies after PDR is up
Date: Sun, 28 Jan 2024 11:10:35 -0500
Message-ID: <20240128161130.200783-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit b43f7ddc2b7a5a90447d96cb4d3c6d142dd4a810 ]

Currently, a not-yet-entirely-initialized battmgr (e.g. with pd-mapper
not having yet started or ADSP not being up etc.) results in a couple of
zombie power supply devices hanging around.

This is particularly noticeable when trying to suspend the device (even
s2idle): the PSY-internal thermal zone is inaccessible and returns
-ENODEV, which causes log spam.

Register the power supplies only after we received some notification
indicating battmgr is ready to take off.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://lore.kernel.org/r/20231218-topic-battmgr_fixture_attempt-v1-1-6145745f34fe@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 109 +++++++++++++++-------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index ec163d1bcd18..a12e2a66d516 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -282,6 +282,7 @@ struct qcom_battmgr_wireless {
 
 struct qcom_battmgr {
 	struct device *dev;
+	struct auxiliary_device *adev;
 	struct pmic_glink_client *client;
 
 	enum qcom_battmgr_variant variant;
@@ -1293,11 +1294,69 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
 }
 
+static char *qcom_battmgr_battery[] = { "battery" };
+
+static void qcom_battmgr_register_psy(struct qcom_battmgr *battmgr)
+{
+	struct power_supply_config psy_cfg_supply = {};
+	struct auxiliary_device *adev = battmgr->adev;
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &adev->dev;
+
+	psy_cfg.drv_data = battmgr;
+	psy_cfg.of_node = adev->dev.of_node;
+
+	psy_cfg_supply.drv_data = battmgr;
+	psy_cfg_supply.of_node = adev->dev.of_node;
+	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
+	psy_cfg_supply.num_supplicants = 1;
+
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			dev_err(dev, "failed to register battery power supply (%ld)\n",
+				PTR_ERR(battmgr->bat_psy));
+
+		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->ac_psy))
+			dev_err(dev, "failed to register AC power supply (%ld)\n",
+				PTR_ERR(battmgr->ac_psy));
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			dev_err(dev, "failed to register USB power supply (%ld)\n",
+				PTR_ERR(battmgr->usb_psy));
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
+				PTR_ERR(battmgr->wls_psy));
+	} else {
+		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
+		if (IS_ERR(battmgr->bat_psy))
+			dev_err(dev, "failed to register battery power supply (%ld)\n",
+				PTR_ERR(battmgr->bat_psy));
+
+		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->usb_psy))
+			dev_err(dev, "failed to register USB power supply (%ld)\n",
+				PTR_ERR(battmgr->usb_psy));
+
+		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
+		if (IS_ERR(battmgr->wls_psy))
+			dev_err(dev, "failed to register wireless charing power supply (%ld)\n",
+				PTR_ERR(battmgr->wls_psy));
+	}
+}
+
 static void qcom_battmgr_pdr_notify(void *priv, int state)
 {
 	struct qcom_battmgr *battmgr = priv;
 
 	if (state == SERVREG_SERVICE_STATE_UP) {
+		if (!battmgr->bat_psy)
+			qcom_battmgr_register_psy(battmgr);
+
 		battmgr->service_up = true;
 		schedule_work(&battmgr->enable_work);
 	} else {
@@ -1312,13 +1371,9 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{}
 };
 
-static char *qcom_battmgr_battery[] = { "battery" };
-
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
-	struct power_supply_config psy_cfg_supply = {};
-	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
 	struct device *dev = &adev->dev;
@@ -1328,14 +1383,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 		return -ENOMEM;
 
 	battmgr->dev = dev;
-
-	psy_cfg.drv_data = battmgr;
-	psy_cfg.of_node = adev->dev.of_node;
-
-	psy_cfg_supply.drv_data = battmgr;
-	psy_cfg_supply.of_node = adev->dev.of_node;
-	psy_cfg_supply.supplied_to = qcom_battmgr_battery;
-	psy_cfg_supply.num_supplicants = 1;
+	battmgr->adev = adev;
 
 	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
 	mutex_init(&battmgr->lock);
@@ -1347,43 +1395,6 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
-					     "failed to register battery power supply\n");
-
-		battmgr->ac_psy = devm_power_supply_register(dev, &sc8280xp_ac_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->ac_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
-					     "failed to register AC power supply\n");
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sc8280xp_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
-					     "failed to register USB power supply\n");
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sc8280xp_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
-	} else {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
-		if (IS_ERR(battmgr->bat_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
-					     "failed to register battery power supply\n");
-
-		battmgr->usb_psy = devm_power_supply_register(dev, &sm8350_usb_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->usb_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
-					     "failed to register USB power supply\n");
-
-		battmgr->wls_psy = devm_power_supply_register(dev, &sm8350_wls_psy_desc, &psy_cfg_supply);
-		if (IS_ERR(battmgr->wls_psy))
-			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
-					     "failed to register wireless charing power supply\n");
-	}
-
 	battmgr->client = devm_pmic_glink_register_client(dev,
 							  PMIC_GLINK_OWNER_BATTMGR,
 							  qcom_battmgr_callback,
-- 
2.43.0


