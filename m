Return-Path: <linux-kernel+bounces-97376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B58769B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F411C2096B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DA5E09A;
	Fri,  8 Mar 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bfnk+POY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7A5787D;
	Fri,  8 Mar 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918312; cv=none; b=mwXQfK6DLNhG40G56kjGfC2aTHbopSZSDTQqkUxbiyqR8Jt3ic/fIZA768WS9Bg6L8hbCobILaiDKTPB1twYQCaLMgudGLFBlXUcRgw/9/NiKEEiHckHSFZxkpPH3eK6E1MnmRIZhsPfVH7pAQnIPynORMq5P04IeBxQjGop0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918312; c=relaxed/simple;
	bh=JTu/Ri2/gtdgFmXJ0bMlqA5f8zzCSoBcLIvuAlQqjTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ea3r1kHGCxCdZDfW68JD5ZH+zeBwb0E2uJaHg76qkCeZsq5Af2JpFyuktuN5kMgTfCJhElXgMcknb7SRBbS9w07v04tskI6NLLw+8wOK9KxuRv45EuvjgzErjC1rtc6/3pR33/jbnFjrbdRn5uQctGUXS1+KWO84yEaD5m9hoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bfnk+POY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59F23C000C;
	Fri,  8 Mar 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snXfAL/ISLez0yxPxF8EY5sTF1V0n6/HA3n4V2ckkr0=;
	b=bfnk+POYQxg+wF6/DDH5TiggB95GchX4TXSML6GfUQFSuHUXWBV/xCQ79HE3sYNqAJV7pF
	CrpyIWYL0Walp55NFYvO7PwLpew+nsdJ1FmaDHSqmkLZf0rLMb+4dbqeyXqoAZrkSAmfYu
	SLbCBf82xPFoHd5fho3lq8+ay3N6HMCNvjPZU/xToMQ6kjMVcz0wmITJ5rt9u48TR3YT94
	FhX9/urFdFXj2j7sGpSSK9R656SwmZvzbF+1nyqOWCs3kjL2cG2f+vWwLsNp2bMJDvPraZ
	PWB4KBWVjSYq/TxTp/84BI+V6ZAFXA6DUZzIZ64KYNQptZjjeYM0fYojSqygqA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:23 +0100
Subject: [PATCH 08/11] spi: cadence-qspi: add early busywait to
 cqspi_wait_for_bit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-8-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

If the CQSPI_BUSYWAIT_EARLY quirk flag is on, call
readl_relaxed_poll_timeout() with no sleep at the start of
cqspi_wait_for_bit(). If its short timeout expires, a sleeping
readl_relaxed_poll_timeout() call takes the relay.

Behavior is hidden behind a quirk flag to keep the previous behavior the
same on all platforms.

The reason is to avoid hrtimer interrupts on the system. All read
operations take less than 100µs.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 973ea4edbe3a..2ad9c736f85f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -44,6 +44,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_DETECT_FIFO_DEPTH		BIT(6)
 #define CQSPI_RD_NO_IRQ			BIT(7)
+#define CQSPI_BUSYWAIT_EARLY		BIT(8)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -110,7 +111,7 @@ struct cqspi_st {
 
 struct cqspi_driver_platdata {
 	u32 hwcaps_mask;
-	u8 quirks;
+	u16 quirks;
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
@@ -121,6 +122,7 @@ struct cqspi_driver_platdata {
 /* Operation timeout value */
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
+#define CQSPI_BUSYWAIT_TIMEOUT_US		500
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -299,13 +301,27 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
-static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
+static int cqspi_wait_for_bit(const struct cqspi_driver_platdata *ddata,
+			      void __iomem *reg, const u32 mask, bool clr,
+			      bool busywait)
 {
+	u64 timeout_us = CQSPI_TIMEOUT_MS * USEC_PER_MSEC;
 	u32 val;
 
+	if (busywait && ddata && ddata->quirks & CQSPI_BUSYWAIT_EARLY) {
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
@@ -435,8 +451,8 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
 
 	/* Polling for completion. */
-	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_CMDCTRL,
-				 CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1);
+	ret = cqspi_wait_for_bit(cqspi->ddata, reg_base + CQSPI_REG_CMDCTRL,
+				 CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1, true);
 	if (ret) {
 		dev_err(&cqspi->pdev->dev,
 			"Flash command execution timed out.\n");
@@ -791,8 +807,8 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	}
 
 	/* Check indirect done status */
-	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
-				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
+	ret = cqspi_wait_for_bit(cqspi->ddata, reg_base + CQSPI_REG_INDIRECTRD,
+				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0, true);
 	if (ret) {
 		dev_err(dev, "Indirect read completion error (%i)\n", ret);
 		goto failrd;
@@ -1092,8 +1108,8 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
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


