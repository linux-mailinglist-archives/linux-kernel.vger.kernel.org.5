Return-Path: <linux-kernel+bounces-142307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3418A2A02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E473B1F2309C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC558130A63;
	Fri, 12 Apr 2024 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="jVu0MBnx"
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCA12C47E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911482; cv=none; b=DpYZCj17NuvJN9D7fJlmxxqrLDiIo2dTNkHQN+SqNNzaPBc4Bo1ROTXZ4mNLj9IVGKq1hmHBdhU6S1DyehRtapmMED7BSRzFRKjre0+/s9736qau9ypJLiQec+duo8Qp+bCgs9zugHYtrnutqFGACnhjN+oC7DLHy24Q5pOJQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911482; c=relaxed/simple;
	bh=KCcJfOmxJYJnvn9ISK24CrnwVdcYHY0uQ34DDVMZgBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOhdhd1+MTTuJRq1Deo9nVqZCpesoCpt2UuiXdv+wI/0hw9rr8cdpC2t7s6q6Q0bFo2H065hw7z99fSHKWc8aXmRGViIe8uMbH3+tJeEHCGqD4jbdd+IKYHnikWsS6IIvZ9awe3qrOxpLuLuKOF3rxJVH1dKVnAw0/+UW/XuhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=jVu0MBnx; arc=none smtp.client-ip=62.149.155.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam.com ([77.32.11.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id vCWKrIsVvwWj2vCWLr0hxW; Fri, 12 Apr 2024 10:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712911469; bh=KCcJfOmxJYJnvn9ISK24CrnwVdcYHY0uQ34DDVMZgBw=;
	h=From:To:Subject:Date:MIME-Version;
	b=jVu0MBnxKKGm/ALzH+K3vsnfetEtVeOJ+hz1BjGSbsoIkfzQlsWGvvHxw8ztkVty9
	 qf6rdx7hj2QrR8u8iCOkCq1VwJPPvXNHRleoOUFmFUIum12mo9t28TysC+b/h03Mqq
	 mKWf+XX5lwCoXBcDEx+77eJzwbo0YzzSL1cvLh9+HlPU9N4C892mK02iaE7pP2A8G3
	 YCbmYbiXlmf9WBxSeSFEOHmFiZhcreM42LCLXrb6Z2InTFR8PwWdI/w1LUdolfTIfo
	 qXW2Hh9fJeF3KeVUxYkLpA/p4THaIuR5JfWS07XKlHXS7CCQs96QR5avW985P+3G0R
	 LXjMzg/2YPabA==
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: [PATCH v4 2/2] regulator: pca9450: make warm reset on PMIC_RST_B assertion
Date: Fri, 12 Apr 2024 10:44:28 +0200
Message-Id: <20240412084428.400607-3-fabio.aiuto@engicam.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412084428.400607-1-fabio.aiuto@engicam.com>
References: <20240412084428.400607-1-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK4oHPsPdScFzaYXVXev1tdi4Txm6ETsUGH2jspVbqAutHrXEIWcUrjnGZ9ffT8sz70SQGyAJhqLj1JpS2icoNVbYd+jE0GQMAhMTewqK0tdlAFaWc4P
 aSAA1Ufl4kz6ZD/yL1YyM+036tU2Adfcwmkb5y4mc1jDPKWQ5yPbDxqvn++pMVD65qNC+z+QDEMxboIHFcv1U1v9V6sr9ckSm1tadAs16zt1ogILT7M4HI84
 eBXxgiTKjCBfmPXIDUgpYVNGs08tIKr0C/7Eb7+lEeeqfEdqPbzjt1pZEV0qQV0PAXQZb9yejU6C7YJ63h2aedMe6ejlYBpJUXfPkqE8vd56g6+DI01K2UUF
 hZZ3tODALy3azWzjLCJBhKZ14Rq3AYuNIetp0he5MWieKgp8Ux6kcB88CsLtXNogBtsFgUBLjatCdXiZbKeGZDZKtd8+cb5tCRDqXw2+HHSI4pnSWUY=

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


