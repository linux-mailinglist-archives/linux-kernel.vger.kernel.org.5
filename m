Return-Path: <linux-kernel+bounces-140187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E48A0C89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C7C28310E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F814533F;
	Thu, 11 Apr 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="mXwhYx2p"
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588614532B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828235; cv=none; b=VDrGDhz6UWVisTa80+iyxn9NdqNCCD4d1Zl1V2y+aNfqUgHcdXYkyPPoFWGlc9g4pMV1+iHm/UnxQQ954BlF7MYJ583rySMNcgrghC+fFuSCp+APuCNqPVWoVF8anlhc5PmLFCd3cKch9V0sJcCcNIN1vHnFX+/e8JkUNq9MCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828235; c=relaxed/simple;
	bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOLWStmU/mnig35nKRDRzoJIWJ7eOQ95kdBO8PETfclQTHUCCaDE0tP48BAkUp1uW2SS2tW/ch69+FWDTqaqXlgpC32Q8o2BGxZ5rQW4Z/C1hWHoqwyKPuOzDUJ54/BUCqHfX+6xJNDmv3Mt7WXT5OoOPBDqrLWAtjcjl2zYt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=mXwhYx2p; arc=none smtp.client-ip=62.149.158.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uqokrAj0ioq80uqokrCOjw; Thu, 11 Apr 2024 11:34:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712828043; bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Subject:Date:MIME-Version;
	b=mXwhYx2poT6NxxSnmGahZ2cdbNEnh1OKnGV4wcKTCPBQ3qTKd4FerGpyAQco4aGD/
	 9pgeMwxFerRXZwtWW/Ts8hU8jQE/Ri23QjfHxIh2TmoDYPW/O9xazCxOECr/rKAUxA
	 FqJpB3SS3k/L9i7FFLAWkTZyAl5ZAPq1kSYtig9SUPH4tHdYUhqrtSd41skRTf2x1D
	 Pt2XsCJD92Dt1NMsL07zcI1/IMRWenvS3bCfxuLFV8UF8mM+JBK7KRK9UwqgDggtPC
	 U3KNWSBzj+lzyk0AUOH4PrTI890dib5vgJDL1MH3KUbONYVhuaiseNaaD7am192onk
	 cgfFMMKV+nZRA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Liam Girdwood <lgirdwood@dmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 11:34:02 +0200
Message-Id: <20240411093402.365798-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDDp6ogaIiBoEkAIgQ97RWd+qbVYTyMMtdl0setns+0mU/6eS5C29FV01U7uArYjRfHG2v9yEFwSMfIsSFcrJsdSo2P33YP2ggM/6Hfp6H1YLCst6mD5
 ZTMfnwSSETD4IrREAcoJ8m2C56TusKfyEJr/ECyCMzbE3zoePFyfs89s6Jh8/COlggXyibAAjzOnj5vXt3mufzhiIZXArz+0tfoZECS0HrC0ADsyElN4WCJw
 kM2iaRTban4n3zwZi/23ZlrjcHFz8lkLLno+0VuEd2Ae6cy6EBmiE1emOT8yZNOtVCzSHVRrRw8mWpdu/LffP2LBvIAYX2bmMgaisgK3ENI=

The default configuration of the PMIC behavior makes the PMIC
power cycle most regulators on PMIC_RST_B assertion. This power
cycling causes the memory contents of OCRAM to be lost.
Some systems needs some memory that survives reset and
reboot, therefore this patch is created.

This patch extends commit 2364a64d0673 ("regulator: pca9450:
Make warm reset on WDOG_B assertion") to the other reset
input source PMIC_RST_B as per pmic specs.

CC: Matteo Lisi <matteo.lisi@engicam.com>
CC: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml     |  6 ++++++
 drivers/regulator/pca9450-regulator.c                 | 11 ++++++++---
 include/linux/regulator/pca9450.h                     |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 849bfa50bdba..1030375a8578 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -93,6 +93,12 @@ properties:
       When WDOG_B signal is asserted a warm reset will be done instead of cold
       reset.
 
+  nxp,pmic_rst_b-warm-reset:
+    type: boolean
+    description:
+      When PMIC_RST_B signal is asserted a warm reset will be done instead of cold
+      reset.
+
 required:
   - compatible
   - reg
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index be488c5dff14..6e3823032e6c 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -999,11 +999,16 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	else
 		reset_ctrl = WDOG_B_CFG_COLD_LDO12;
 
-	/* Set reset behavior on assertion of WDOG_B signal */
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,pmic_rst_b-warm-reset"))
+		reset_ctrl |= PMIC_RST_CFG_WARM;
+	else
+		reset_ctrl |= PMIC_RST_CFG_COLD_LDO12;
+
+	/* Set reset behavior on assertion of WDOG_B/PMIC_RST_B signal */
 	ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_RESET_CTRL,
-				 WDOG_B_CFG_MASK, reset_ctrl);
+				 WDOG_B_CFG_MASK | PMIC_RST_CFG_MASK, reset_ctrl);
 	if (ret) {
-		dev_err(&i2c->dev, "Failed to set WDOG_B reset behavior\n");
+		dev_err(&i2c->dev, "Failed to set WDOG_B/PMIC_RST_B reset behavior\n");
 		return ret;
 	}
 
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 243633c8dceb..d87f0b410b00 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -227,6 +227,12 @@ enum {
 #define WDOG_B_CFG_COLD_LDO12		0x80
 #define WDOG_B_CFG_COLD			0xC0
 
+#define PMIC_RST_CFG_MASK		0x30
+#define PMIC_RST_CFG_NONE		0x00
+#define PMIC_RST_CFG_WARM		0x10
+#define PMIC_RST_CFG_COLD_LDO12		0x20
+#define PMIC_RST_CFG_COLD		0x30
+
 /* PCA9450_REG_CONFIG2 bits */
 #define I2C_LT_MASK			0x03
 #define I2C_LT_FORCE_DISABLE		0x00
-- 
2.34.1


