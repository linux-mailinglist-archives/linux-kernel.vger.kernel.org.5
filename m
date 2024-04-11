Return-Path: <linux-kernel+bounces-140186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1D8A0C84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D501C20B52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A914534A;
	Thu, 11 Apr 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="VHcT8km1"
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B135144D2B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828210; cv=none; b=Ks3UTnIsAwkb+OsoDv7eTjwoPNcPWQwP1LCPI8vt3aIwNjA8OR9SGHkgMiBCicoSQ/xdUhYsF4HCUfv+VpsFJUfICan1sdV93CbZ8aJaWyVrfB3kquUj3ilQMDKpXeW5VI7/PK7CXuNdlUEurXquaIkdyr69StLmYMwG5Er12n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828210; c=relaxed/simple;
	bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2ZF56nXbHBPeqCNZ37UySHng9gqWVhWsSvXlyIEb3FvE5UXSKdRM/9963AvJUUCR/aZj0NSqFmY6xeCrkcfsHUMZ9VQYIiAuaOcZgW7E2PL52qT3tJOuoSWzproDlT0zAK+QEHmUlMBQtMesm+Ns/S1RaoHsGSzHkSnOioko1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=VHcT8km1; arc=none smtp.client-ip=62.149.158.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uqrJrAlrVoq80uqrKrCQnx; Thu, 11 Apr 2024 11:36:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712828202; bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Subject:Date:MIME-Version;
	b=VHcT8km1b1diUleodSL4bdkFHyS61zSJ5RfO/2XAtTEDWToPmazufxTCc9wSx69Ys
	 BAZyGqeYwP5+UVEWq6khJaAdquvUCkUqT7gPlsLBy5ve6OydbMIPjHpUbiWdixgydA
	 vd1KygdsINrjtb7PM7KRgVIsJT/k+cKj4HtO9vpnAsuHB9ymY/2i5cdrdASRjEpwoZ
	 6NfXjHtucaQVDuELGssLPXaAFj7cJVsdv9IfvRBVyiCHLpFmZE2Cfaw+gR5F4fga1N
	 Cbf/5N6oRo951uqg3z9dzZWgR77nZ+5rxUtFbdyW177dYZxrADUrAb3NXp9SrIzH3P
	 Xyf3c26xFiXlg==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 11:36:41 +0200
Message-Id: <20240411093641.365827-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLp8+anvDNffhddjleYkNcPKNXymGreKGdIhHLoA+CxZhfn00zwlkvFiv5sdfeoy/Fl7WkLW+W4Tw1v+igB0xgLJsBkbvBsh5HwoPoZw0bSXRay8ohf4
 ONYrroqHB31BDlkNlGPFBkUoyD47UYsBRsdpcDQJU7Jq+Rdeh/SzBaNKlFjAd+l2MHWzQx0t/3ZaXKweVpxe836qhTJH7VMw5568R6S5pM4vOTn3PqS40wF7
 t+twSH6mCInXOOtqe65D1UtntcojNK8ALJinxvSdmmr3/ZSs5AreH5K3+tkQEpv/ljnSLpffHKv1ehSX5KjoqbXHAzvzufH/M0/cxYta7+E=

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


