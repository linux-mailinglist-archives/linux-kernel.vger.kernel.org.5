Return-Path: <linux-kernel+bounces-140189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79B8A0C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A5E1F24783
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14356145335;
	Thu, 11 Apr 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="XBAG+9iT"
Received: from smtpcmd13146.aruba.it (smtpcmd13146.aruba.it [62.149.156.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16745144D2B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828351; cv=none; b=e/vYnV8UX6+nVUXRKeR1eFA2wNuoT9vZty/MA2jL5CgOGCUoPmz09GQlD1m4lBZdaAepilDJGMAWwHWYdE+kJ0AF7ip2YIhJEIQ2EYH9iHBOAQux04d3K2Fwqwb1rSAVuZWcrPQGhUXZLReeGXX15mkN9bWA/rq4VmUkjhE5cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828351; c=relaxed/simple;
	bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6o3uOPkn6cVNh6jLqDrAGbFzclZs8SVkuF2a+ssS3MhhO2Z13Asfv6AP2G5thtJOdvYhzDtjPPO8WDV2r4e80/G6uWtNgLL64o1+awupVZ7bAED3qXdq2dWNSoXPWohwtb9rs6yD3FgqLMiWiBNyLkxDfVcUmkWI+XwTRTnWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=XBAG+9iT; arc=none smtp.client-ip=62.149.156.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uqqartivkiznzuqqbrkOpz; Thu, 11 Apr 2024 11:35:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712828157; bh=bd3RHSHXqw7tx+hIYChwRjq7T4Nyu2hNejvq5QDXPyk=;
	h=From:To:Subject:Date:MIME-Version;
	b=XBAG+9iT3sHAV9623iwwEsuhp9mu5wJPQ+yviiwcr0P2lUxXy6yhGiFwQ2T9p01j5
	 aHEihb+FkSADy3c7YxcXQoinUaw2ftpbPn4yzW/uiLkSFMKVU884cAAelMbGPvPt7r
	 mA1OHqiEUATp2ia4h888NMm6eWuHlFMR4N+nGj/FfzVP6Bdkgml96cFcu+uyf8AhSM
	 New+sqrRvDUriSiHsNsqzQDYhzOUUEA0GfPueRWIh8DLVxZHrWSDwY6fj0dBAc98C3
	 ukGPeVbGths8p3b35D4crV7+P2a9LXTosp72f9KWv/90jNpX/J//Ap218ePOPyfda1
	 fCTms3//WZ3Lg==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 11:35:56 +0200
Message-Id: <20240411093556.365814-1-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPK223tCjlqFVuOp2qrYA8Ldaj71HEYTkShhHbmsVF7UqjhDJZM2Cn+N99/Gw2G2WTUp6U0xvMw6PJ0wCHfkUfGSrsFcOgKKjJfgmFpMYNVN/ytvRpTE
 rvagk/eVaCAaaP0b3YpT/SFC/YUwanrJwe+5AC/JwYkIi2ljq5YxWQPWm+8OPG3SGcM1cGlbpu2ScphjjwYnwfUik/4uwUc3sauxI9r/8DGNzor5hDhWUaC3
 d6R58lURRCPpAv9WIIdMPqhlcJXRNEbH3+M/cK7KUr9BlitJAmkP6Y7XO8BLDAqTLO+0CYzLyXFPOnK9+DFZ8f4x2Pt45nDEcZXUgzg4pWw=

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


