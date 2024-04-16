Return-Path: <linux-kernel+bounces-146133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431EF8A612D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BE01C211D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832C22075;
	Tue, 16 Apr 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ40ErWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4480171D2;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235481; cv=none; b=YnkuggRMlpAbvY+1PggAMlmF5E2i5GbtYrbb20wG2/WQ7yaloxVvQRBScCF1rKD5o2YpAnr2BWvb/QD1X0lpf9pb1g1EJUY1m1RTDypilcSDhan7eP7SXyDcBe8/4o214Cimii/qSlIXj5JeoUTcC9Sg3t1KpOOVyRsWJEXpSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235481; c=relaxed/simple;
	bh=3ygo566KgNes/y1LnnasDIozu4wqPQgtkAmJdJFtQ0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxCiqFfEdNO7EHDCJRaPnKXKS2RV0IZt580Y8HSt6dxIH9Qae/Z0lfLI/6eqg6gBRQ8mXF+ssR4l6XKQLIhmu5EZpI3MatvvlfIRhyHuni2wwHv5n7iAPKqEdwPgGyxjGJI177bZoawGCBvBAtvxGvQiAJq8vVzZxMOJMXtuFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ40ErWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F17DC4AF0C;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713235481;
	bh=3ygo566KgNes/y1LnnasDIozu4wqPQgtkAmJdJFtQ0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QZ40ErWrn5XtEtonMojY5vHzFnnHAwMKEGafsomu8FfPecoagy8UIaz6TJ5C9VvE2
	 TpFJRy6PH+PayzGui8+OMBqhMFXrq3w9zaQ/KrE+VbRfMDnHRFNyvk//+cx/PA3KgV
	 Mmmb40/5HnY0pMiiHTxszGpWPfwmFSo9vKw+ps2hXA7BUVaw/AhrcymyQzLRuFRnYe
	 kIzzzgzFcygnb4SKwXDxipu9aol7b/m7qxELm6o0Cl8KTA3vTwfp1iVCzhleKBAB6M
	 0znEDxieW3OG1GzqyJ9URbPiGi9THpBTtX9zkhOJ+Xuxw1CveYr9/S07EEiHcGBhBd
	 1K3g3SuO7zvtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59803C04FFE;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Tue, 16 Apr 2024 10:44:34 +0800
Subject: [PATCH v11 3/3] input: pm8xxx-vibrator: add new SPMI vibrator
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-pm8xxx-vibrator-new-design-v11-3-7b1c951e1515@quicinc.com>
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713235479; l=5248;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=O6jY1vE2jMlOuUDvAlQRyMO4JqLMmvGnt6KvdZSWoX4=;
 b=DoVE674AWh7yt0zyoiZS7k+TyNiecyJD6qsCJWj6VcIDOmE8qE0HfBZR8zD/tDtfLs4P4Die3
 wPTFMEcosIoC5u84zbHjJVsJI1xojlhrLWDyobziNQDybr+cg6EEK1H
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Add support for a new SPMI vibrator module which is very similar
to the vibrator module inside PM8916 but has a finer drive voltage
step and different output voltage range, its drive level control
is expanded across 2 registers. The vibrator module can be found
in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 52 +++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 2bcfa7ed3d6b..381b06473279 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -11,10 +11,11 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define VIB_MAX_LEVEL_mV	(3100)
-#define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_PER_STEP_mV		(100)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
+#define VIB_MAX_LEVEL_mV(vib)	(vib->drv2_addr ? 3544 : 3100)
+#define VIB_MIN_LEVEL_mV(vib)	(vib->drv2_addr ? 1504 : 1200)
+#define VIB_PER_STEP_mV(vib)	(vib->drv2_addr ? 8 : 100)
+#define VIB_MAX_LEVELS(vib) \
+	(VIB_MAX_LEVEL_mV(vib) - VIB_MIN_LEVEL_mV(vib) + VIB_PER_STEP_mV(vib))
 
 #define MAX_FF_SPEED		0xff
 
@@ -25,7 +26,11 @@ struct pm8xxx_regs {
 	unsigned int drv_offset;
 	unsigned int drv_mask;
 	unsigned int drv_shift;
+	unsigned int drv2_offset;
+	unsigned int drv2_mask;
+	unsigned int drv2_shift;
 	unsigned int drv_en_manual_mask;
+	bool	     drv_in_step;
 };
 
 static const struct pm8xxx_regs pm8058_regs = {
@@ -33,6 +38,7 @@ static const struct pm8xxx_regs pm8058_regs = {
 	.drv_mask = GENMASK(7, 3),
 	.drv_shift = 3,
 	.drv_en_manual_mask = 0xfc,
+	.drv_in_step = true,
 };
 
 static struct pm8xxx_regs pm8916_regs = {
@@ -42,6 +48,20 @@ static struct pm8xxx_regs pm8916_regs = {
 	.drv_mask = GENMASK(4, 0),
 	.drv_shift = 0,
 	.drv_en_manual_mask = 0,
+	.drv_in_step = true,
+};
+
+static struct pm8xxx_regs pmi632_regs = {
+	.enable_offset = 0x46,
+	.enable_mask = BIT(7),
+	.drv_offset = 0x40,
+	.drv_mask = GENMASK(7, 0),
+	.drv_shift = 0,
+	.drv2_offset = 0x41,
+	.drv2_mask = GENMASK(3, 0),
+	.drv2_shift = 8,
+	.drv_en_manual_mask = 0,
+	.drv_in_step = false,
 };
 
 /**
@@ -52,6 +72,7 @@ static struct pm8xxx_regs pm8916_regs = {
  * @regs: registers' info
  * @enable_addr: vibrator enable register
  * @drv_addr: vibrator drive strength register
+ * @drv2_addr: vibrator drive strength upper byte register
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -64,6 +85,7 @@ struct pm8xxx_vib {
 	const struct pm8xxx_regs *regs;
 	unsigned int enable_addr;
 	unsigned int drv_addr;
+	unsigned int drv2_addr;
 	int speed;
 	int level;
 	bool active;
@@ -81,6 +103,9 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 	unsigned int val = vib->reg_vib_drv;
 	const struct pm8xxx_regs *regs = vib->regs;
 
+	if (regs->drv_in_step)
+		vib->level /= VIB_PER_STEP_mV(vib);
+
 	if (on)
 		val |= (vib->level << regs->drv_shift) & regs->drv_mask;
 	else
@@ -92,6 +117,14 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 
 	vib->reg_vib_drv = val;
 
+	if (regs->drv2_mask) {
+		val = vib->level << regs->drv2_shift;
+		rc = regmap_write_bits(vib->regmap, vib->drv2_addr,
+				regs->drv2_mask, on ? val : 0);
+		if (rc < 0)
+			return rc;
+	}
+
 	if (regs->enable_mask)
 		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
 					regs->enable_mask, on ? regs->enable_mask : 0);
@@ -114,17 +147,16 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		return;
 
 	/*
-	 * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
+	 * pmic vibrator supports voltage ranges from MIN_LEVEL to MAX_LEVEL, so
 	 * scale the level to fit into these ranges.
 	 */
 	if (vib->speed) {
 		vib->active = true;
-		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
-						VIB_MIN_LEVEL_mV;
-		vib->level /= VIB_PER_STEP_mV;
+		vib->level = VIB_MIN_LEVEL_mV(vib);
+		vib->level += mult_frac(VIB_MAX_LEVELS(vib), vib->speed, MAX_FF_SPEED);
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
+		vib->level = VIB_MIN_LEVEL_mV(vib);
 	}
 
 	pm8xxx_vib_set(vib, vib->active);
@@ -197,6 +229,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	regs = of_device_get_match_data(&pdev->dev);
 	vib->enable_addr = reg_base + regs->enable_offset;
 	vib->drv_addr = reg_base + regs->drv_offset;
+	vib->drv2_addr = reg_base + regs->drv2_offset;
 
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, vib->drv_addr, &val);
@@ -251,6 +284,7 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
 	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
+	{ .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);

-- 
2.25.1



