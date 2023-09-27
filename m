Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3887AFAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjI0GFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjI0GFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:05:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007DEE5;
        Tue, 26 Sep 2023 23:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89E30C433C7;
        Wed, 27 Sep 2023 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695794706;
        bh=dxVytm8peBK9ARsrywTYF+uWNd63jD+cCHCJtDKnwR0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=Nx96QQIeLfA6Wo4XWBoaWTNL8qjOrleHuRa9ZVi/o76Cser/RWiEIZkN7zY47Bjg0
         a+VtE5dgg31fwjoQOPlgDbXBbDTT3Z9187arvDSvoeBl86svDtdyYvCSVnrb9PCIqi
         RhuLd5lD/8uxTjoHXAW3KrFWm6cTBDbvUg6Ev5+y8u7nENTdvQOh/SGum8wkQnaKH/
         yDaPuK+qeAUEo2yPBR6o83lakSK6QrzjHK50YJBy3nv66PeDv5GxNjopd9zNyXoyoo
         4/vtjVYLsVboPnAGVWTbNv10xLogrbgquYuJQ2Hm8j8bec10cfbZlIKbnjZmZeDCpF
         Ukca4LTwK5AZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 6B24AE80A92;
        Wed, 27 Sep 2023 06:05:06 +0000 (UTC)
From:   Fenglin Wu via B4 Relay 
        <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date:   Wed, 27 Sep 2023 14:05:02 +0800
Subject: [PATCH v7 1/3] input: pm8xxx-vib: refactor to easily support new
 SPMI vibrator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-pm8xxx-vibrator-v7-1-b5d8c92ce818@quicinc.com>
References: <20230927-pm8xxx-vibrator-v7-0-b5d8c92ce818@quicinc.com>
In-Reply-To: <20230927-pm8xxx-vibrator-v7-0-b5d8c92ce818@quicinc.com>
To:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_kamalw@quicinc.com,
        jestar@qti.qualcomm.com, Luca Weiss <luca.weiss@fairphone.com>,
        Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695794704; l=7094;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=edsISTWo4DvHUFy8IoGl7O/e9THyTA4/ImPMjWn8NI0=;
 b=/rQVDWa2P+hc1WPtylLAl956sy4mNTQ4m0/XCSUUwl2lm/w3owx9D3k/g4k33+1ltzke4ZO0p
 9HIanDoB7wQDgRGQYiFVsHW3zfpJ45a8DEt1aOq1paOeLAZrM3xyckL
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Currently, all vibrator control register addresses are hard coded,
including the base address and the offset, it's not flexible to support
new SPMI vibrator module which is usually included in different PMICs
with different base address. Refactor this by defining register offset
with HW type combination, and register base address which is defined
in 'reg' property is added for SPMI vibrators.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 130 ++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 49 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..ba9be374f892 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -12,36 +12,44 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#define SSBI_VIB_DRV_REG		0x4A
+#define SSBI_VIB_DRV_EN_MANUAL_MASK	GENMASK(7, 2)
+#define SSBI_VIB_DRV_LEVEL_MASK		GENMASK(7, 3)
+#define SSBI_VIB_DRV_SHIFT		3
+
+#define SPMI_VIB_DRV_REG		0x41
+#define SPMI_VIB_DRV_LEVEL_MASK		GENMASK(4, 0)
+#define SPMI_VIB_DRV_SHIFT		0
+
+#define SPMI_VIB_EN_REG			0x46
+#define SPMI_VIB_EN_BIT			BIT(7)
+
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
 #define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
 
 #define MAX_FF_SPEED		0xff
 
-struct pm8xxx_regs {
-	unsigned int enable_addr;
-	unsigned int enable_mask;
+enum vib_hw_type {
+	SSBI_VIB,
+	SPMI_VIB,
+};
 
-	unsigned int drv_addr;
-	unsigned int drv_mask;
-	unsigned int drv_shift;
-	unsigned int drv_en_manual_mask;
+struct pm8xxx_vib_data {
+	enum vib_hw_type	hw_type;
+	unsigned int		enable_addr;
+	unsigned int		drv_addr;
 };
 
-static const struct pm8xxx_regs pm8058_regs = {
-	.drv_addr = 0x4A,
-	.drv_mask = 0xf8,
-	.drv_shift = 3,
-	.drv_en_manual_mask = 0xfc,
+static const struct pm8xxx_vib_data ssbi_vib_data = {
+	.hw_type	= SSBI_VIB,
+	.drv_addr	= SSBI_VIB_DRV_REG,
 };
 
-static struct pm8xxx_regs pm8916_regs = {
-	.enable_addr = 0xc046,
-	.enable_mask = BIT(7),
-	.drv_addr = 0xc041,
-	.drv_mask = 0x1F,
-	.drv_shift = 0,
-	.drv_en_manual_mask = 0,
+static const struct pm8xxx_vib_data spmi_vib_data = {
+	.hw_type	= SPMI_VIB,
+	.enable_addr	= SPMI_VIB_EN_REG,
+	.drv_addr	= SPMI_VIB_DRV_REG,
 };
 
 /**
@@ -49,7 +57,8 @@ static struct pm8xxx_regs pm8916_regs = {
  * @vib_input_dev: input device supporting force feedback
  * @work: work structure to set the vibration parameters
  * @regmap: regmap for register read/write
- * @regs: registers' info
+ * @data: vibrator HW info
+ * @reg_base: the register base of the module
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -59,7 +68,8 @@ struct pm8xxx_vib {
 	struct input_dev *vib_input_dev;
 	struct work_struct work;
 	struct regmap *regmap;
-	const struct pm8xxx_regs *regs;
+	const struct pm8xxx_vib_data *data;
+	unsigned int reg_base;
 	int speed;
 	int level;
 	bool active;
@@ -75,24 +85,39 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 {
 	int rc;
 	unsigned int val = vib->reg_vib_drv;
-	const struct pm8xxx_regs *regs = vib->regs;
+	u32 mask, shift;
+
+	switch (vib->data->hw_type) {
+	case SSBI_VIB:
+		mask = SSBI_VIB_DRV_LEVEL_MASK;
+		shift = SSBI_VIB_DRV_SHIFT;
+		break;
+	case SPMI_VIB:
+		mask = SPMI_VIB_DRV_LEVEL_MASK;
+		shift = SPMI_VIB_DRV_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+
+	}
 
 	if (on)
-		val |= (vib->level << regs->drv_shift) & regs->drv_mask;
+		val |= (vib->level << shift) & mask;
 	else
-		val &= ~regs->drv_mask;
+		val &= ~mask;
 
-	rc = regmap_write(vib->regmap, regs->drv_addr, val);
+	rc = regmap_update_bits(vib->regmap, vib->reg_base + vib->data->drv_addr, mask, val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
-	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					regs->enable_mask, on ? ~0 : 0);
+	if (vib->data->hw_type == SSBI_VIB)
+		return 0;
 
-	return rc;
+	mask = SPMI_VIB_EN_BIT;
+	val = on ? SPMI_VIB_EN_BIT : 0;
+	return regmap_update_bits(vib->regmap, vib->reg_base + vib->data->enable_addr, mask, val);
 }
 
 /**
@@ -102,13 +127,6 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 static void pm8xxx_work_handler(struct work_struct *work)
 {
 	struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
-	const struct pm8xxx_regs *regs = vib->regs;
-	int rc;
-	unsigned int val;
-
-	rc = regmap_read(vib->regmap, regs->drv_addr, &val);
-	if (rc < 0)
-		return;
 
 	/*
 	 * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
@@ -168,9 +186,9 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 {
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
+	const struct pm8xxx_vib_data *data;
 	int error;
-	unsigned int val;
-	const struct pm8xxx_regs *regs;
+	unsigned int val, reg_base;
 
 	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
 	if (!vib)
@@ -187,19 +205,33 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	INIT_WORK(&vib->work, pm8xxx_work_handler);
 	vib->vib_input_dev = input_dev;
 
-	regs = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
-	/* operate in manual mode */
-	error = regmap_read(vib->regmap, regs->drv_addr, &val);
-	if (error < 0)
-		return error;
+	if (data->hw_type != SSBI_VIB) {
+		error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
+		if (error < 0) {
+			dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
+			return error;
+		}
+
+		vib->reg_base += reg_base;
+	}
 
-	val &= regs->drv_en_manual_mask;
-	error = regmap_write(vib->regmap, regs->drv_addr, val);
+	error = regmap_read(vib->regmap, vib->reg_base + data->drv_addr, &val);
 	if (error < 0)
 		return error;
 
-	vib->regs = regs;
+	/* operate in manual mode */
+	if (data->hw_type == SSBI_VIB) {
+		val &= SSBI_VIB_DRV_EN_MANUAL_MASK;
+		error = regmap_write(vib->regmap, vib->reg_base + data->drv_addr, val);
+		if (error < 0)
+			return error;
+	}
+
+	vib->data = data;
 	vib->reg_vib_drv = val;
 
 	input_dev->name = "pm8xxx_vib_ffmemless";
@@ -239,9 +271,9 @@ static int pm8xxx_vib_suspend(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pm8xxx_vib_pm_ops, pm8xxx_vib_suspend, NULL);
 
 static const struct of_device_id pm8xxx_vib_id_table[] = {
-	{ .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
-	{ .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
+	{ .compatible = "qcom,pm8058-vib", .data = &ssbi_vib_data },
+	{ .compatible = "qcom,pm8921-vib", .data = &ssbi_vib_data },
+	{ .compatible = "qcom,pm8916-vib", .data = &spmi_vib_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);

-- 
2.25.1

