Return-Path: <linux-kernel+bounces-154830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845D8AE1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29621F24047
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF122F11;
	Tue, 23 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IWB+ViNj"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820E5FBA6;
	Tue, 23 Apr 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866515; cv=none; b=IWL+mcUE1xg+nkXATJivQ24mMvBFUCGewZS7Dsn2Sxq1RTbu0A08ptNgK9p6BSkjTBp9ztk7lbV5fAnQFiP1aqFes7o6aG0UQhGMeua0OzSQXsO85UVqXkVFQxbeMHVB05Ro8MGdpHyhVVwGH+BMVQo49WyE+24KkjUpuO5qeAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866515; c=relaxed/simple;
	bh=2Zz3RXshc8WET0P4aEvTzfn2hm0aXcIB9jA/MA1isRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwuBFc32R/ftOojOhzCI7kdW6S/k5w93ze0jOwvSrkXC/Zm5zQjF41myM8LEYSWPGxSvI92fZvUEIz5jk2L/ERUBekE1I4398Uy7LJhvklJRtwMGjAjvN+FS9yhtVrDl7gY32AXx+Qz4ynC5x1wRRFMJ6uyrgwJBFMO2I2DZaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IWB+ViNj; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB4241C0014;
	Tue, 23 Apr 2024 10:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69cnUQUcGYJmLIaC0THyrs7sb2kh2LjvS2li/WRvhmg=;
	b=IWB+ViNjDlwEDhQ0mU6ufOVJejzzXLai/lEyNOE7G/lilUbSF+mSHCkCfrsekEHbnM6Q4M
	k42SHhMZINUZJi4/55djZmTBgvXCmqf7IL2GLm1a50Zy/VE3kqhcIp3fhiAJM807Cq+YvN
	qQksQiVEc2Lwp0vQa0v2uueqeFxeeyRXqg2/2T3+9tjb+Hdn76+NjlLQ1nbeh9nOtCcWvp
	YY5TqkOBgeMd41f8fSJw9w5080f1fFl/SagcXgKxboEeuCn2K7KKFYFlzvIawod6r+JB6F
	0cLbYlQ8mNvac75PwQRZLA0mva4mhSbKyOJMFNK9tIClzXqE7b7dJMaW42nIAw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:42 +0200
Subject: [PATCH v4 3/6] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-3-3d2a7b535ad0@bootlin.com>
References: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
In-Reply-To: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Call readl_relaxed_poll_timeout() with no sleep at the start of
cqspi_wait_for_bit(). If its short timeout expires, a sleeping
readl_relaxed_poll_timeout() call takes the relay.

The reason is to avoid hrtimer interrupts on the system. All read
operations are expected to take less than 100µs.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a82e23526a6f..87c88ee708e4 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -120,6 +120,7 @@ struct cqspi_driver_platdata {
 /* Operation timeout value */
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
+#define CQSPI_BUSYWAIT_TIMEOUT_US		500
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -298,13 +299,27 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
-static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
+static int cqspi_wait_for_bit(const struct cqspi_driver_platdata *ddata,
+			      void __iomem *reg, const u32 mask, bool clr,
+			      bool busywait)
 {
+	u64 timeout_us = CQSPI_TIMEOUT_MS * USEC_PER_MSEC;
 	u32 val;
 
+	if (busywait) {
+		int ret = readl_relaxed_poll_timeout(reg, val,
+						     (((clr ? ~val : val) & mask) == mask),
+						     0, CQSPI_BUSYWAIT_TIMEOUT_US);
+
+		if (ret != -ETIMEDOUT)
+			return ret;
+
+		timeout_us -= CQSPI_BUSYWAIT_TIMEOUT_US;
+	}
+
 	return readl_relaxed_poll_timeout(reg, val,
 					  (((clr ? ~val : val) & mask) == mask),
-					  10, CQSPI_TIMEOUT_MS * 1000);
+					  10, timeout_us);
 }
 
 static bool cqspi_is_idle(struct cqspi_st *cqspi)
@@ -434,8 +449,8 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
 
 	/* Polling for completion. */
-	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_CMDCTRL,
-				 CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1);
+	ret = cqspi_wait_for_bit(cqspi->ddata, reg_base + CQSPI_REG_CMDCTRL,
+				 CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1, true);
 	if (ret) {
 		dev_err(&cqspi->pdev->dev,
 			"Flash command execution timed out.\n");
@@ -790,8 +805,8 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	}
 
 	/* Check indirect done status */
-	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
-				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
+	ret = cqspi_wait_for_bit(cqspi->ddata, reg_base + CQSPI_REG_INDIRECTRD,
+				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0, true);
 	if (ret) {
 		dev_err(dev, "Indirect read completion error (%i)\n", ret);
 		goto failrd;
@@ -1091,8 +1106,8 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	}
 
 	/* Check indirect done status */
-	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTWR,
-				 CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
+	ret = cqspi_wait_for_bit(cqspi->ddata, reg_base + CQSPI_REG_INDIRECTWR,
+				 CQSPI_REG_INDIRECTWR_DONE_MASK, 0, false);
 	if (ret) {
 		dev_err(dev, "Indirect write completion error (%i)\n", ret);
 		goto failwr;

-- 
2.44.0


