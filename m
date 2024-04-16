Return-Path: <linux-kernel+bounces-146131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654658A612C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8898B1C20849
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE2219E1;
	Tue, 16 Apr 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcU2nMsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9E1642B;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235481; cv=none; b=JJJTee6Oij7yXOklQYBRogEMML76rQF5JEhg0YTfmlWwKFV9b4zf5zlxekEgeB+X3UHhKoj7Uy2UDSsMSaYHPFDZajP4hOyFDVQc/aJWmaEM9VQDCuGouqrsF4ZNZaKFA2KSBTaLtHgTPCaQI6zwb3Troh98+fNYQLvUip2dM1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235481; c=relaxed/simple;
	bh=RQPT2yHDkY4Bh+F74lLjos1yV4PoydHJZ7SkgV2nvyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDsiCUExGeyBiE2h/B80/N7EeAIMPfeptYh5K/2fav7qwocHcWHcsfA6oD/jLTGOJKeFwtSGoosYSrqxWjaRqAB9c0vOEvbC2agGFrGQ++1LQf7fwaWwu0Es5QrIi9mrAbkJ+cbBdfgHOWVnFKyMYUhgkMiOsTfe/uWkerxNgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcU2nMsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53098C4AF07;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713235481;
	bh=RQPT2yHDkY4Bh+F74lLjos1yV4PoydHJZ7SkgV2nvyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CcU2nMsrXotmOr3X7SXf5f4fyNaFZ4balIVJvFm/S6YhhBIuWULZZ2eEVLs5rqlcZ
	 edxhwt88Wr7CTIBI2kvM9ozMAJ0raadsXtyWufFtOcki0R6lV8Aroo9yo9y4L62B3/
	 L3OFjTLx2/bq6NPWykyKc+zWbrKD6iRvc28xIi6scmdd/g+lgfYZNkCpOvZzYAqt2C
	 5CzYMFZ6At3oXwLpFtFcU4WuZrjVEhC4OD/98uwEU5KB959dAI+nya+AB6lQAltdSY
	 HUgtK5G6RO+N2KFjB2lxwLeofBYkvcihKZtxXR44uoaJrkUPk6yXM3ntPlh9zcK4WE
	 8Trxdcy4VMqIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2BC04FFF;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Tue, 16 Apr 2024 10:44:32 +0800
Subject: [PATCH v11 1/3] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-pm8xxx-vibrator-new-design-v11-1-7b1c951e1515@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713235479; l=4348;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=E2aBMQmVymx8Fv7BU5kutAgy8VZ4B8jp2W+Ab5rizqk=;
 b=rVI+3VcH5JY7i5YOiKUsw/R/fogkybTGfSLRTaJfn2NA50fUI1bU7ULSHqjsj7e7XR1Tw6H0+
 JFGv/hqAGJACMkssvRN0DUwgFNliMMBlArPt7j8St+q/3AtLnr/b1s3
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Currently, vibrator control register addresses are hard coded,
including the base address and offsets, it's not flexible to
support new SPMI vibrator module which is usually included in
different PMICs with different base address. Refactor it by using
the base address defined in devicetree.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 41 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 79f478d3a9b3..2bcfa7ed3d6b 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -19,27 +19,27 @@
 #define MAX_FF_SPEED		0xff
 
 struct pm8xxx_regs {
-	unsigned int enable_addr;
+	unsigned int enable_offset;
 	unsigned int enable_mask;
 
-	unsigned int drv_addr;
+	unsigned int drv_offset;
 	unsigned int drv_mask;
 	unsigned int drv_shift;
 	unsigned int drv_en_manual_mask;
 };
 
 static const struct pm8xxx_regs pm8058_regs = {
-	.drv_addr = 0x4A,
-	.drv_mask = 0xf8,
+	.drv_offset = 0,
+	.drv_mask = GENMASK(7, 3),
 	.drv_shift = 3,
 	.drv_en_manual_mask = 0xfc,
 };
 
 static struct pm8xxx_regs pm8916_regs = {
-	.enable_addr = 0xc046,
+	.enable_offset = 0x46,
 	.enable_mask = BIT(7),
-	.drv_addr = 0xc041,
-	.drv_mask = 0x1F,
+	.drv_offset = 0x41,
+	.drv_mask = GENMASK(4, 0),
 	.drv_shift = 0,
 	.drv_en_manual_mask = 0,
 };
@@ -50,6 +50,8 @@ static struct pm8xxx_regs pm8916_regs = {
  * @work: work structure to set the vibration parameters
  * @regmap: regmap for register read/write
  * @regs: registers' info
+ * @enable_addr: vibrator enable register
+ * @drv_addr: vibrator drive strength register
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -60,6 +62,8 @@ struct pm8xxx_vib {
 	struct work_struct work;
 	struct regmap *regmap;
 	const struct pm8xxx_regs *regs;
+	unsigned int enable_addr;
+	unsigned int drv_addr;
 	int speed;
 	int level;
 	bool active;
@@ -82,15 +86,15 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 	else
 		val &= ~regs->drv_mask;
 
-	rc = regmap_write(vib->regmap, regs->drv_addr, val);
+	rc = regmap_write(vib->regmap, vib->drv_addr, val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
 	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					regs->enable_mask, on ? ~0 : 0);
+		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
+					regs->enable_mask, on ? regs->enable_mask : 0);
 
 	return rc;
 }
@@ -102,11 +106,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 static void pm8xxx_work_handler(struct work_struct *work)
 {
 	struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
-	const struct pm8xxx_regs *regs = vib->regs;
-	int rc;
 	unsigned int val;
+	int rc;
 
-	rc = regmap_read(vib->regmap, regs->drv_addr, &val);
+	rc = regmap_read(vib->regmap, vib->drv_addr, &val);
 	if (rc < 0)
 		return;
 
@@ -169,7 +172,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
 	int error;
-	unsigned int val;
+	unsigned int val, reg_base = 0;
 	const struct pm8xxx_regs *regs;
 
 	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
@@ -187,15 +190,21 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	INIT_WORK(&vib->work, pm8xxx_work_handler);
 	vib->vib_input_dev = input_dev;
 
+	error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
+	if (error < 0)
+		return dev_err_probe(&pdev->dev, error, "Failed to read reg address\n");
+
 	regs = of_device_get_match_data(&pdev->dev);
+	vib->enable_addr = reg_base + regs->enable_offset;
+	vib->drv_addr = reg_base + regs->drv_offset;
 
 	/* operate in manual mode */
-	error = regmap_read(vib->regmap, regs->drv_addr, &val);
+	error = regmap_read(vib->regmap, vib->drv_addr, &val);
 	if (error < 0)
 		return error;
 
 	val &= regs->drv_en_manual_mask;
-	error = regmap_write(vib->regmap, regs->drv_addr, val);
+	error = regmap_write(vib->regmap, vib->drv_addr, val);
 	if (error < 0)
 		return error;
 

-- 
2.25.1



