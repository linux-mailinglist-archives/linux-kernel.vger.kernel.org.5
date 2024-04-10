Return-Path: <linux-kernel+bounces-138255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F189EED8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C89B24418
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43D1591F8;
	Wed, 10 Apr 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KOU4JR8F"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBE15531D;
	Wed, 10 Apr 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741357; cv=none; b=g5p4o1Xd3DO4jnVilDGBDxj25UrivxLc6aLnBMeZmvIjnZ4FIwAGxGdIiM5PSvcaqUhEjXzLMZSjHzBCrKgPztysIBlUA1oDXgpgcKtCnvD6NaKcZH5vuGGa7nG3L4fC7NywXf/cLr5E0dJgKsKB7r2I18pSDkuTmVE1FsrNI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741357; c=relaxed/simple;
	bh=yknB+7qTEVSApo7twiMZf9uswY1p1QPEpYLKQmR+whs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6QoNPt8g+RMbaAEDIvRQfg/1BsnLlUTVXxIkPhnaKKPUbzNYTWIEOqMbDNINa+cxLz+OslEYponvRbw0KRtD3cvhpcT0z39r89R9DjEZokvpScs1zGxaEvK+pNiY2yGGJaO7PY8/AiJD3mIjjaGEdayQlLl/+U3n644rzjqS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KOU4JR8F; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3354C0010;
	Wed, 10 Apr 2024 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqn8emte3xu2XqiT6+4r45XXMdjD8s3EgYSdiWO/wSE=;
	b=KOU4JR8Fv1K2+w6GWVB0nXsk81F1XTXMY5fPJUgAAb2xvaeqnv16riK98g/vCcReurUCgk
	d0z7LvSlRqBuHAB7i4lmcJNnsqedCSJ52ug57vVhBxyMSvLwodMbgCCdG42D7VLQjdlTRI
	QxlsDnfjtaraXnyg7UaL4JSNgUhsFpI1KACnTg5Bru+C4OXdkk1OubbIHxg+W8mB8mcSKr
	9YM+efhdrVHSKS1tX+YT/OXxfED8F9op8P4cepmRtspa80hB+q70PlWNBkRmlTFjgGOrjo
	eyAz7ZRWqVAivIedZ3epFWI+1kA2m9h6B2gfHM8l8vKayh/KpqK+fBrS18oLQA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:09 +0200
Subject: [PATCH v3 6/9] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-6-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
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
index cde84d10678e..fecb76cfb932 100644
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


