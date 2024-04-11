Return-Path: <linux-kernel+bounces-140220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913BE8A0D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E00B284D87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5E145B14;
	Thu, 11 Apr 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="X3aG5LED"
Received: from smtpcmd04132.aruba.it (smtpcmd04132.aruba.it [62.149.158.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D367145B2C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829892; cv=none; b=AefnvG3bhH2S4Oc/kEcwF/YXvQKityThpHW6vYMklc+TTFf8XI08Y9NGlOjZ3Sgr7VFC2TrtufKsmukWgH+lFv+WjN6LqhsxxUL6Vx5qZjBoqRg+jCHuMbaNlv/G0bfG6Cf2kk+/naolpP91jWYtuTHOWq/Mvuu1Qz7YQMKXjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829892; c=relaxed/simple;
	bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1GwriaAPwk5t3rTNuI0CLT4fMZPmHJemsnhdjkXbnl2kmejYklm2tTSVt9pHmp0saRYqfjSd0DSOkp9GrC5dqEqLqVe6VERvzNvq7tAphwY/qAGY8h4cSDR0K+/px+FcKOTEYZmub2fPkJcd1Sa1D8Wbfw/DPk9BHlLu2RyCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=X3aG5LED; arc=none smtp.client-ip=62.149.158.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id urFSrBEe8oq80urFTrClJm; Thu, 11 Apr 2024 12:01:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712829699; bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Subject:Date:MIME-Version;
	b=X3aG5LEDMXpZk721ByWqf9kJdE0VILEo0pAn//+f7bXYfHqeb+wySa3C41fJvbcey
	 0mRtdulmu4TFF4N1hbqHNADJfWTQed3+Eq1ANBIY4Y/567qKevSDmAHqZxz7Jamggm
	 pace/jQD+tGsHTCCazkVz0sugmGEnmnoC6wSQ4ybb98KGY2sfdsgV5T3M664WPzEfY
	 a5lHwcEOoTMs32qVYaFw/oZPpSshOk4plO44MxniZrBPbTZS+jWnOCwe/qJyOa5Lmq
	 vxUSHCmz3+nQu5PRHcTF+kDUs1WHATtNHfdgixQ5mQzQwqKOqZJzrWLhIvRu8cLjMO
	 2hzZCdBIF6kOQ==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v2 1/1] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 12:01:38 +0200
Message-Id: <20240411100138.366292-2-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411100138.366292-1-fabio.aiuto@engicam.com>
References: <20240411100138.366292-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfALfCiG6/UwoD22vS2fxw8jvM9zOcQ8+jsW//UGYiRrQgfSPAp+g5hff2ljnSOj3anJeb0ZuUA0A9zJO2MiEe2mV8wNcImFMTzxz7atg4GCslWx2GS7e
 3kVJdYJKbSEa+qS+uWvDRw5zoMUXXIn3LfbXqBkIBZC6Qgx/0B6eOw9qbowk1ppjIHskLFrBURG4aLcKSyeRc2ESFGu18BG7ah1PuFKmVOBm/seZad/VmQhl
 15p+7AIOJQ23kcYLAHYW6Tp3zbGbEbWbHlutaTCszs1jNUnxEVUT0uU/4WnFp/g4vh+wbtYGiuYlBp1rzlie2Prf+Ta+H7uflVLdnR/d4Lg=

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


