Return-Path: <linux-kernel+bounces-141366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A48A1D53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9281F248FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC45165FDF;
	Thu, 11 Apr 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ew59QKNq"
Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8704F890
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854875; cv=none; b=fav5rciTK7gqPk5O1QMNIGUpk5IarzftRyGeazu3c7uxG68bPsq27vb2ytBBmxStZSNTsMR6pF0zLpQG6AA0hFiZb+TKnIxDwToBrlGacNc0ujLA46AsvGd1joCehVQYTNCXTjbUEGG2lvw/vNYMUt/DObEWQd4jgcVw4DpvZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854875; c=relaxed/simple;
	bh=KCcJfOmxJYJnvn9ISK24CrnwVdcYHY0uQ34DDVMZgBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQSSK0YZBsVGZnBDJljnDWA079n/i/fxysEUczAFYZfwooI+kvTN3o6dxGjgISmLjSzOlClTIqm9JUJ4/M6aKowvA+3vsgPh9ewEYXDPfrlfUiI7JzyMkI+qn7NTKujSyMERspSif0z1Z7Gy5FFbOSmLhk/BlyJtmN+sU2lNppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ew59QKNq; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uxkPr7ow7wcFeuxkQrcyee; Thu, 11 Apr 2024 18:58:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712854683; bh=KCcJfOmxJYJnvn9ISK24CrnwVdcYHY0uQ34DDVMZgBw=;
	h=From:To:Subject:Date:MIME-Version;
	b=ew59QKNq/dbvf09XUQXPFM11uk+0XOHJ0L01PPrB145QB6nseDenN0R/m6y0i2fMt
	 1lKGtSMvmbFnnxoz4obSrXvTJZiuub0+lopDsrR6qJwItZgPt9exbDDLauMnDnnIrs
	 oNaETgyzbnYUPYk6w+FOP05AmY67FgnOWMcCyCfq36BbblePZZUn8ZdCAx4UFepcOK
	 Jdi13I0WyL5QbxS8hPjdiFCSk6MPajnKA3/U0WM8uPmDnpgIyUhJG6cZeZ+/uk1v50
	 RT13Ocd8mYGQuqau2RZ2JApU7HemZxpRhix9AHFGTIQaE/54wfCOKPCHgBSoZqQC2F
	 DFqECU4xYBHNA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Robin Gong <yibin.gong@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v3 2/2] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Thu, 11 Apr 2024 18:58:01 +0200
Message-Id: <20240411165801.143160-3-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411165801.143160-1-fabio.aiuto@engicam.com>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOXgWXYZkPR/W7EqJpK6GrkzYKGI0D0u392Yt7Fs5V+n1UKQ0kZz1z5NNWtuu83KC+bc2AsD01BF4lsLIHtmmxD18xu/ggXjIkamosPq/eXf5voqd842
 OlWURp/RrHmZFQye1IKTPPMimN94zyC9ZbS7VyLC64ml7sMCQzTznDA/IR/oD1ui0pD6TW4Ls5tmkjoq5HOxLS4Y9RWrVAQbrjaL5hgF0/LhonKWESleI9Ek
 qa6UIESedr5cYNDiPAX9t9+nJ0bLKjlZcFO32o9zFoRO4XzRUk9wFRpcbrT3jp5BJKFpXlU5TqXhHf2ifQeRBJCrInROUd1p1ITKfnCl6CUy1lnBdpwxOJNE
 Tk/aVNelEWNbMN+685KH6GQQhdu/634q6TGbi/jJQJU9qbox7muBZGyOMqlL54aa42KGRab/aY7zG4G2z6cZMhA1ZN7U1+svjtK2mjrWSU07t7MzwNgqzPQQ
 eRkqrL6S9PT1kyjK

The default configuration of the PMIC behavior makes the PMIC
power cycle most regulators on PMIC_RST_B assertion. This power
cycling causes the memory contents of OCRAM to be lost.
Some systems needs some memory that survives reset and
reboot, therefore this patch is created.

This patch extends commit 2364a64d0673 ("regulator: pca9450:
Make warm reset on WDOG_B assertion") to the other reset
input source PMIC_RST_B as per pmic specs.

Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>
---
 drivers/regulator/pca9450-regulator.c | 11 ++++++++---
 include/linux/regulator/pca9450.h     |  6 ++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index be488c5dff14..3a7f238de1a5 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -999,11 +999,16 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	else
 		reset_ctrl = WDOG_B_CFG_COLD_LDO12;
 
-	/* Set reset behavior on assertion of WDOG_B signal */
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,pmic-rst-b-warm-reset"))
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


