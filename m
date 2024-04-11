Return-Path: <linux-kernel+bounces-140092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805148A0B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3676E281EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191F14830D;
	Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMmMevMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A3146A89;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824327; cv=none; b=OT7cChLBKZlyUE4g4zVWN3Fc34eUOttyIaHvse9Q6SbNZsyjApvWgz3GiFJ1eZ75WxIknexKZfFrmfXR2cCmqOSCFzDBZhTtuohu3si2V14tnQg9hwe8YvbLih8i7sEOyaSGWZW182EP+sl09hvp04zQ0lATV9/rUkAtrEyhgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824327; c=relaxed/simple;
	bh=t0BFVQH3c9KhLWbAWpY27qKlp18EmcbQmBMeJCcdds8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjcQtc9HXo0zrKeJmqA98wt+NYEgP5sJpiOFVa9cSvlM4n6VYv32VpETtOTibpQfyxY9ZQUGyqteNJdKL5SK3AWX5CP/PYuxnlfoDGeMcO72LVdGuXGkA6egFVFDs58YN6PS3bP/RwFXf3T3ZNFkKKg2JaD4Ua1c7IIu9dZtf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMmMevMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EC5EC43143;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824327;
	bh=t0BFVQH3c9KhLWbAWpY27qKlp18EmcbQmBMeJCcdds8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rMmMevMoH0eC3QDGUSgOXDZhUZVPpHPAo3mpIl+uqvsxIkZ4gGjkvvk74OLdzibYa
	 9YELC7frhPh3b7VVwA/JEEJNgUGRvnMxLuZIQcak8PWK6twlw/A959wYPZxrMxMBJr
	 +92CQ5hOB75TYajF20u3k1sn8kOE4nVytlkXqk1mbqk3RS6Oy/MK4ibGOw+kNL6zgG
	 k9HS8WoSnXf7nSypO1HAQRQO4JlItCoSs7vTXvY1tp5jGoOjCgcEE4d2etffAVzFng
	 DlulDaMKxXSzKwzUaSgudrmiH9GQ1GOOl2C/IRdI+dNbNayOssDiYgrJGWs2dlxEuA
	 fDG4JS0n+LgTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0729ECD129D;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Thu, 11 Apr 2024 16:31:00 +0800
Subject: [PATCH v9 4/4] input: pm8xxx-vibrator: add new SPMI vibrator
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-pm8xxx-vibrator-new-design-v9-4-7bf56cb92b28@quicinc.com>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
In-Reply-To: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712824325; l=5033;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=pTrC3cQoxz8pNZ4KpoF3OkEKSt7RYrt88MbWTTuCxL8=;
 b=TIEmWRFBPPnL83zharf5f0HHXbluRZMLc0eHt4/Lk+TBjGNhrYdxoj/1mo83UJyaUdCFlnWZa
 OahhOq+XR31DswuGEuPgOZCz8ovvvyM3c56rs3R4g2B/TiYXJ2Ww60s
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
 drivers/input/misc/pm8xxx-vibrator.c | 51 +++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 2959edca8eb9..35bb6f450fd2 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -12,10 +12,10 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#define VIB_MAX_LEVEL_mV	(3100)
-#define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_PER_STEP_mV	(100)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
+#define VIB_MAX_LEVEL_mV(vib)	(vib->drv2_addr ? 3544 : 3100)
+#define VIB_MIN_LEVEL_mV(vib)	(vib->drv2_addr ? 1504 : 1200)
+#define VIB_PER_STEP_mV(vib)	(vib->drv2_addr ? 8 : 100)
+#define VIB_MAX_LEVELS(vib)	(VIB_MAX_LEVEL_mV(vib) - VIB_MIN_LEVEL_mV(vib) + VIB_PER_STEP_mV(vib))
 
 #define MAX_FF_SPEED		0xff
 
@@ -26,6 +26,9 @@ struct pm8xxx_regs {
 	unsigned int drv_offset;
 	unsigned int drv_mask;
 	unsigned int drv_shift;
+	unsigned int drv2_offset;
+	unsigned int drv2_mask;
+	unsigned int drv2_shift;
 	unsigned int drv_en_manual_mask;
 };
 
@@ -45,6 +48,18 @@ static struct pm8xxx_regs pm8916_regs = {
 	.drv_en_manual_mask = 0,
 };
 
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
+};
+
 /**
  * struct pm8xxx_vib - structure to hold vibrator data
  * @vib_input_dev: input device supporting force feedback
@@ -53,6 +68,7 @@ static struct pm8xxx_regs pm8916_regs = {
  * @regs: registers' info
  * @enable_addr: vibrator enable register
  * @drv_addr: vibrator drive strength register
+ * @drv2_addr: vibrator drive strength upper byte register
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -65,6 +81,7 @@ struct pm8xxx_vib {
 	const struct pm8xxx_regs *regs;
 	unsigned int enable_addr;
 	unsigned int drv_addr;
+	unsigned int drv2_addr;
 	int speed;
 	int level;
 	bool active;
@@ -82,6 +99,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 	unsigned int val = vib->reg_vib_drv;
 	const struct pm8xxx_regs *regs = vib->regs;
 
+	/* vibrator without drv2_addr needs be programmed in step increments */
+	if (!vib->drv2_addr)
+		vib->level /= VIB_PER_STEP_mV(vib);
+
 	if (on)
 		val |= (vib->level << regs->drv_shift) & regs->drv_mask;
 	else
@@ -93,6 +114,17 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 
 	vib->reg_vib_drv = val;
 
+	if (regs->drv2_mask) {
+		if (on)
+			val = (vib->level << regs->drv2_shift) & regs->drv2_mask;
+		else
+			val = 0;
+
+		rc = regmap_write_bits(vib->regmap, vib->drv2_addr, regs->drv2_mask, val);
+		if (rc < 0)
+			return rc;
+	}
+
 	if (regs->enable_mask)
 		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
 					regs->enable_mask, on ? regs->enable_mask : 0);
@@ -115,17 +147,16 @@ static void pm8xxx_work_handler(struct work_struct *work)
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
@@ -203,6 +234,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 
 	vib->enable_addr = reg_base + regs->enable_offset;
 	vib->drv_addr = reg_base + regs->drv_offset;
+	vib->drv2_addr = reg_base + regs->drv2_offset;
 
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, vib->drv_addr, &val);
@@ -257,6 +289,7 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
 	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
 	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
+	{ .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);

-- 
2.25.1



