Return-Path: <linux-kernel+bounces-40419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D312183DFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8914B281C33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DC224A1F;
	Fri, 26 Jan 2024 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkBp0x9w"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBE24215
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289374; cv=none; b=cVFEfgNxxhlfkK3kgpSl0PRwJUlZKE7I4RO2zsWUSFX00tLX/yA41fEX7hAAY/6IDw1ny1lhVhaOdZtbtW+BVm4cWKJ4ssIWHvTfd8OscMWu/4W7MIpp+y7DEj+hi1RxT04e+tSoHltMtI2cNLR+Ueh/THl0MrOfSPUe94oLf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289374; c=relaxed/simple;
	bh=u43UIwJQQPRd8BMB6oRBKWy41Vqtce0E/hu8vqcFXqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFWmW5oHbam/69xclinKcEAUruXNvINaALrHSQ5qaPs7zyr9Ps73nmiotHgCJf94OYV2c5VfOvpxbBLrNo5zw0RjrJk1AdvIHWwuU7/MxI0J4Txg0yzEW51j0qfpcW0tpTi0D7rPxynW+zCoeUtcmD1J/sCsS/w5qF1L3vzx2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkBp0x9w; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ee705e9bfso7330205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289369; x=1706894169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4eHVujQrbVd61QBJFM5PhcAZf81EZ3ospR7GnzZm9Y=;
        b=RkBp0x9wVviuoEdARkeZxjcm8s2eJv59bpm4rv7tbqwtDFJsQEK0cxHtSmATEdcU+G
         Q7L3PSR8MqoFIp6apYEG/iwCcMal45nJ+9rS88cDam/44ALNcit6LPolCZuDoSech/6H
         7P6rHB0M56WxpsgYJj9I1X+NRM55v5bOPrDyi0Y1HTo0MJDh/jzgvYfchgmzVcJk8zHc
         es/7H+sTrtmw6QsWLl4vaOdEUmtrxOLKuKU1TJ64IZu+evsx2l3iniynTtOmr6K6o9ou
         2gx5V6NK1kTUBlDeL4kgUe8Np9ty76qs25D+QNOU6LFLn3LOGujxCZDxD9qKnAkwLMgk
         BLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289369; x=1706894169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4eHVujQrbVd61QBJFM5PhcAZf81EZ3ospR7GnzZm9Y=;
        b=nZVS/adttJYdwBgV/zTeZHkLy/ppdLmaDInj46K/oPcfB2jEjqwTd3SrkZsP995DLU
         uTi7FZ9jxL0aqqygVcGlmWAb4G6pU07SfLpTY0lAX9SLeeQ8/JeGHZ3E6ogsIX2FwHsf
         oUm/pSOub5ysBxWDqfcrL/nToJ6l4Nbw2/Mdwsqc2uNoyubENRPoHBzKZA/IWfqhqjtq
         p96wp/1hWuKSp3bNWzjGr+mHxn2ToTr7kBocWTInTlWSGhsTUi2wU00TWzFDNv8/CzKw
         vzL26bAva9MpR5nfcgZgPV5gurmcDhar4lzeHyL5XhMCcfrgZK0MGgVz/0YOh3mXESVo
         mo/A==
X-Gm-Message-State: AOJu0YwVboc40bC8WNLbZPpWrU9DlUQyFv/D7gPTlF7UWotbg5xmcMpR
	mfhDtj8JjlXCzWzgUvYnOJlVTKpQxyUgnQev2Z22A54tpI9+H0abc6td75+YP8w=
X-Google-Smtp-Source: AGHT+IGgmi+uKf/WzzdNGcx4Ui9dyO/h8yxsArsC5YJk2EuQYEgheINIrJVpVI8edVXHS/kCEj6IxQ==
X-Received: by 2002:a05:600c:190b:b0:40e:3b1c:d3a2 with SMTP id j11-20020a05600c190b00b0040e3b1cd3a2mr80118wmq.126.1706289369258;
        Fri, 26 Jan 2024 09:16:09 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:08 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
Date: Fri, 26 Jan 2024 17:15:45 +0000
Message-ID: <20240126171546.1233172-18-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the bitfield access macros in order to clean and to make the driver
easier to read. Introduce S3C64XX_SPI_MAX_TRAILCNT_MASK to replace value
and offset equivalents (S3C64XX_SPI_MAX_TRAILCNT,
S3C64XX_SPI_TRAILCNT_OFF). While touching the register definitions, align
their values to the same offset.

No functional change intended, the bit operations shall be equivalent.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 193 ++++++++++++++++++++------------------
 1 file changed, 101 insertions(+), 92 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 43b888c8812e..7f052d6cd2ba 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -4,6 +4,7 @@
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -18,91 +19,96 @@
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
-#define MAX_SPI_PORTS		12
-#define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-#define AUTOSUSPEND_TIMEOUT	2000
+#define MAX_SPI_PORTS				12
+#define S3C64XX_SPI_QUIRK_CS_AUTO		BIT(1)
+#define AUTOSUSPEND_TIMEOUT			2000
 
 /* Registers and bit-fields */
 
-#define S3C64XX_SPI_CH_CFG		0x00
-#define S3C64XX_SPI_CLK_CFG		0x04
-#define S3C64XX_SPI_MODE_CFG		0x08
-#define S3C64XX_SPI_CS_REG		0x0C
-#define S3C64XX_SPI_INT_EN		0x10
-#define S3C64XX_SPI_STATUS		0x14
-#define S3C64XX_SPI_TX_DATA		0x18
-#define S3C64XX_SPI_RX_DATA		0x1C
-#define S3C64XX_SPI_PACKET_CNT		0x20
-#define S3C64XX_SPI_PENDING_CLR		0x24
-#define S3C64XX_SPI_SWAP_CFG		0x28
-#define S3C64XX_SPI_FB_CLK		0x2C
-
-#define S3C64XX_SPI_CH_HS_EN		(1<<6)	/* High Speed Enable */
-#define S3C64XX_SPI_CH_SW_RST		(1<<5)
-#define S3C64XX_SPI_CH_SLAVE		(1<<4)
-#define S3C64XX_SPI_CPOL_L		(1<<3)
-#define S3C64XX_SPI_CPHA_B		(1<<2)
-#define S3C64XX_SPI_CH_RXCH_ON		(1<<1)
-#define S3C64XX_SPI_CH_TXCH_ON		(1<<0)
-
-#define S3C64XX_SPI_CLKSEL_SRCMSK	(3<<9)
-#define S3C64XX_SPI_CLKSEL_SRCSHFT	9
-#define S3C64XX_SPI_ENCLK_ENABLE	(1<<8)
-#define S3C64XX_SPI_PSR_MASK		0xff
-
-#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		(0<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	(1<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_WORD		(2<<29)
-#define S3C64XX_SPI_MODE_CH_TSZ_MASK		(3<<29)
-#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE		(0<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	(1<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_WORD		(2<<17)
-#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		(3<<17)
+#define S3C64XX_SPI_CH_CFG			0x00
+#define S3C64XX_SPI_CLK_CFG			0x04
+#define S3C64XX_SPI_MODE_CFG			0x08
+#define S3C64XX_SPI_CS_REG			0x0C
+#define S3C64XX_SPI_INT_EN			0x10
+#define S3C64XX_SPI_STATUS			0x14
+#define S3C64XX_SPI_TX_DATA			0x18
+#define S3C64XX_SPI_RX_DATA			0x1C
+#define S3C64XX_SPI_PACKET_CNT			0x20
+#define S3C64XX_SPI_PENDING_CLR			0x24
+#define S3C64XX_SPI_SWAP_CFG			0x28
+#define S3C64XX_SPI_FB_CLK			0x2C
+
+#define S3C64XX_SPI_CH_HS_EN			BIT(6)	/* High Speed Enable */
+#define S3C64XX_SPI_CH_SW_RST			BIT(5)
+#define S3C64XX_SPI_CH_SLAVE			BIT(4)
+#define S3C64XX_SPI_CPOL_L			BIT(3)
+#define S3C64XX_SPI_CPHA_B			BIT(2)
+#define S3C64XX_SPI_CH_RXCH_ON			BIT(1)
+#define S3C64XX_SPI_CH_TXCH_ON			BIT(0)
+
+#define S3C64XX_SPI_CLKSEL_SRCMSK		GENMASK(10, 9)
+#define S3C64XX_SPI_ENCLK_ENABLE		BIT(8)
+#define S3C64XX_SPI_PSR_MASK			GENMASK(7, 0)
+
+#define S3C64XX_SPI_MODE_CH_TSZ_MASK		GENMASK(30, 29)
+#define S3C64XX_SPI_MODE_CH_TSZ_BYTE		0
+#define S3C64XX_SPI_MODE_CH_TSZ_HALFWORD	1
+#define S3C64XX_SPI_MODE_CH_TSZ_WORD		2
+#define S3C64XX_SPI_MAX_TRAILCNT_MASK		GENMASK(28, 19)
+#define S3C64XX_SPI_MODE_BUS_TSZ_MASK		GENMASK(18, 17)
+#define S3C64XX_SPI_MODE_BUS_TSZ_BYTE		0
+#define S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD	1
+#define S3C64XX_SPI_MODE_BUS_TSZ_WORD		2
 #define S3C64XX_SPI_MODE_RX_RDY_LVL		GENMASK(16, 11)
-#define S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT	11
-#define S3C64XX_SPI_MODE_SELF_LOOPBACK		(1<<3)
-#define S3C64XX_SPI_MODE_RXDMA_ON		(1<<2)
-#define S3C64XX_SPI_MODE_TXDMA_ON		(1<<1)
-#define S3C64XX_SPI_MODE_4BURST			(1<<0)
-
-#define S3C64XX_SPI_CS_NSC_CNT_2		(2<<4)
-#define S3C64XX_SPI_CS_AUTO			(1<<1)
-#define S3C64XX_SPI_CS_SIG_INACT		(1<<0)
-
-#define S3C64XX_SPI_INT_TRAILING_EN		(1<<6)
-#define S3C64XX_SPI_INT_RX_OVERRUN_EN		(1<<5)
-#define S3C64XX_SPI_INT_RX_UNDERRUN_EN		(1<<4)
-#define S3C64XX_SPI_INT_TX_OVERRUN_EN		(1<<3)
-#define S3C64XX_SPI_INT_TX_UNDERRUN_EN		(1<<2)
-#define S3C64XX_SPI_INT_RX_FIFORDY_EN		(1<<1)
-#define S3C64XX_SPI_INT_TX_FIFORDY_EN		(1<<0)
-
-#define S3C64XX_SPI_ST_RX_OVERRUN_ERR		(1<<5)
-#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		(1<<4)
-#define S3C64XX_SPI_ST_TX_OVERRUN_ERR		(1<<3)
-#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		(1<<2)
-#define S3C64XX_SPI_ST_RX_FIFORDY		(1<<1)
-#define S3C64XX_SPI_ST_TX_FIFORDY		(1<<0)
-
-#define S3C64XX_SPI_PACKET_CNT_EN		(1<<16)
+#define S3C64XX_SPI_MODE_SELF_LOOPBACK		BIT(3)
+#define S3C64XX_SPI_MODE_RXDMA_ON		BIT(2)
+#define S3C64XX_SPI_MODE_TXDMA_ON		BIT(1)
+#define S3C64XX_SPI_MODE_4BURST			BIT(0)
+
+/*
+ * S3C64XX_SPI_CS_NSC_CNT_2 is a value into the NCS_TIME_COUNT field. In newer
+ * datasheets this field is defined as GENMASK(9, 4). We don't know if this mask
+ * applies to all the versions of the IP, thus we can't yet define
+ * S3C64XX_SPI_CS_NSC_CNT_2 as a value and the register field as a mask.
+ */
+#define S3C64XX_SPI_CS_NSC_CNT_2		(2 << 4)
+#define S3C64XX_SPI_CS_AUTO			BIT(1)
+#define S3C64XX_SPI_CS_SIG_INACT		BIT(0)
+
+#define S3C64XX_SPI_INT_TRAILING_EN		BIT(6)
+#define S3C64XX_SPI_INT_RX_OVERRUN_EN		BIT(5)
+#define S3C64XX_SPI_INT_RX_UNDERRUN_EN		BIT(4)
+#define S3C64XX_SPI_INT_TX_OVERRUN_EN		BIT(3)
+#define S3C64XX_SPI_INT_TX_UNDERRUN_EN		BIT(2)
+#define S3C64XX_SPI_INT_RX_FIFORDY_EN		BIT(1)
+#define S3C64XX_SPI_INT_TX_FIFORDY_EN		BIT(0)
+
+#define S3C64XX_SPI_ST_RX_OVERRUN_ERR		BIT(5)
+#define S3C64XX_SPI_ST_RX_UNDERRUN_ERR		BIT(4)
+#define S3C64XX_SPI_ST_TX_OVERRUN_ERR		BIT(3)
+#define S3C64XX_SPI_ST_TX_UNDERRUN_ERR		BIT(2)
+#define S3C64XX_SPI_ST_RX_FIFORDY		BIT(1)
+#define S3C64XX_SPI_ST_TX_FIFORDY		BIT(0)
+
+#define S3C64XX_SPI_PACKET_CNT_EN		BIT(16)
 #define S3C64XX_SPI_PACKET_CNT_MASK		GENMASK(15, 0)
 
-#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR		(1<<4)
-#define S3C64XX_SPI_PND_TX_OVERRUN_CLR		(1<<3)
-#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR		(1<<2)
-#define S3C64XX_SPI_PND_RX_OVERRUN_CLR		(1<<1)
-#define S3C64XX_SPI_PND_TRAILING_CLR		(1<<0)
+#define S3C64XX_SPI_PND_TX_UNDERRUN_CLR		BIT(4)
+#define S3C64XX_SPI_PND_TX_OVERRUN_CLR		BIT(3)
+#define S3C64XX_SPI_PND_RX_UNDERRUN_CLR		BIT(2)
+#define S3C64XX_SPI_PND_RX_OVERRUN_CLR		BIT(1)
+#define S3C64XX_SPI_PND_TRAILING_CLR		BIT(0)
 
-#define S3C64XX_SPI_SWAP_RX_HALF_WORD		(1<<7)
-#define S3C64XX_SPI_SWAP_RX_BYTE		(1<<6)
-#define S3C64XX_SPI_SWAP_RX_BIT			(1<<5)
-#define S3C64XX_SPI_SWAP_RX_EN			(1<<4)
-#define S3C64XX_SPI_SWAP_TX_HALF_WORD		(1<<3)
-#define S3C64XX_SPI_SWAP_TX_BYTE		(1<<2)
-#define S3C64XX_SPI_SWAP_TX_BIT			(1<<1)
-#define S3C64XX_SPI_SWAP_TX_EN			(1<<0)
+#define S3C64XX_SPI_SWAP_RX_HALF_WORD		BIT(7)
+#define S3C64XX_SPI_SWAP_RX_BYTE		BIT(6)
+#define S3C64XX_SPI_SWAP_RX_BIT			BIT(5)
+#define S3C64XX_SPI_SWAP_RX_EN			BIT(4)
+#define S3C64XX_SPI_SWAP_TX_HALF_WORD		BIT(3)
+#define S3C64XX_SPI_SWAP_TX_BYTE		BIT(2)
+#define S3C64XX_SPI_SWAP_TX_BIT			BIT(1)
+#define S3C64XX_SPI_SWAP_TX_EN			BIT(0)
 
-#define S3C64XX_SPI_FBCLK_MSK			(3<<0)
+#define S3C64XX_SPI_FBCLK_MASK			GENMASK(1, 0)
 
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
@@ -112,16 +118,13 @@
 					FIFO_LVL_MASK(i))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
-#define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
-#define S3C64XX_SPI_TRAILCNT_OFF	19
-
 #define S3C64XX_SPI_POLLING_SIZE	32
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 #define is_polling(x)	(x->cntrlr_info->polling)
 
-#define RXBUSY    (1<<2)
-#define TXBUSY    (1<<3)
+#define RXBUSY    BIT(2)
+#define TXBUSY    BIT(3)
 
 struct s3c64xx_spi_dma_data {
 	struct dma_chan *ch;
@@ -664,16 +667,22 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	switch (sdd->cur_bpw) {
 	case 32:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_WORD;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_WORD;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_WORD) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_WORD);
 		break;
 	case 16:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
 		break;
 	default:
-		val |= S3C64XX_SPI_MODE_BUS_TSZ_BYTE;
-		val |= S3C64XX_SPI_MODE_CH_TSZ_BYTE;
+		val |= FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
+				  S3C64XX_SPI_MODE_BUS_TSZ_BYTE) |
+		       FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
+				  S3C64XX_SPI_MODE_CH_TSZ_BYTE);
 		break;
 	}
 
@@ -799,7 +808,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 
 			val = readl(sdd->regs + S3C64XX_SPI_MODE_CFG);
 			val &= ~S3C64XX_SPI_MODE_RX_RDY_LVL;
-			val |= (rdy_lv << S3C64XX_SPI_MODE_RX_RDY_LVL_SHIFT);
+			val |= FIELD_PREP(S3C64XX_SPI_MODE_RX_RDY_LVL, rdy_lv);
 			writel(val, sdd->regs + S3C64XX_SPI_MODE_CFG);
 
 			/* Enable FIFO_RDY_EN IRQ */
@@ -1072,8 +1081,8 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 	writel(0, regs + S3C64XX_SPI_INT_EN);
 
 	if (!sdd->port_conf->clk_from_cmu)
-		writel(sci->src_clk_nr << S3C64XX_SPI_CLKSEL_SRCSHFT,
-				regs + S3C64XX_SPI_CLK_CFG);
+		writel(FIELD_PREP(S3C64XX_SPI_CLKSEL_SRCMSK, sci->src_clk_nr),
+		       regs + S3C64XX_SPI_CLK_CFG);
 	writel(0, regs + S3C64XX_SPI_MODE_CFG);
 	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
 
@@ -1089,7 +1098,7 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd)
 
 	val = readl(regs + S3C64XX_SPI_MODE_CFG);
 	val &= ~S3C64XX_SPI_MODE_4BURST;
-	val |= (S3C64XX_SPI_MAX_TRAILCNT << S3C64XX_SPI_TRAILCNT_OFF);
+	val |= S3C64XX_SPI_MAX_TRAILCNT_MASK;
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
 	s3c64xx_flush_fifo(sdd);
-- 
2.43.0.429.g432eaa2c6b-goog


