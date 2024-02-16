Return-Path: <linux-kernel+bounces-68151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060985768B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4531E284DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21011C6A1;
	Fri, 16 Feb 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r513Bqbn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2F1BC39
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067174; cv=none; b=arG9bpfE/cps2Z1w68J8Sjv38CP4NK6awmFfJXUGK4HIjT/AO0ZoGuxUOxZUiM8WR6HHI/lq6txokp16TwmliK3zSULF9PGlmLTjxvZ0qvPxWOWHqFe4osuQTKfke0MQbK2GbEcxmjTt0kiiJ36sS9gt+95zcZM5zXfM1xhmB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067174; c=relaxed/simple;
	bh=eW18x24oV6Qaw0s/6pJnVe7Q9DGOkuWPal5+0q/PzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMhYWPr6HuCZUmdUuIMeSDrQb2c7sGkKE2ca0AamW4NsD6vGU/4/ObIzS/C6DlnywrpB1KexPSCGbThfI2geG7vmzAdsYCiLeg4nc3wg1XRqPCLLtD/2x6/gSoakD2u5m+LgToruiR2KJ1hoNdu0lluMDAycDbu61bMrrsqCXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r513Bqbn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337d05b8942so1091575f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708067171; x=1708671971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSklTkqrMVAq4VBR2iaN0vU9yUuhpA9uZMhYyUvuCP8=;
        b=r513Bqbnp1tFGbwienoxoECN/VoyCiz+DZqFiH2me7nuwEDbSNeScck8OAOBXvfEFU
         4Ce29nAiSUgrDwUrj8McKxOCwNChEsxJcxtKKXW3517gM6Mi7bsAADOMkEnNFj1dVBPo
         RVLTAKzhh4CCsd1lr6gaISnImKKAPj0lFyYYtRI5ojD0Wm+cBWCdHCM16/UcMQ8uoWyd
         j1PYQhKyT6JKAUQeribTBeFc1V4NIAcVAjTAQ6TOKh1z5KDles4W6S+z6MAsSkEgl1bA
         PVdrQQllDkwUppKLmjc3FiWu1CjXhaATe2f5ixiUkCEXmZTiKV27h6p1IolKDb/4C7O2
         VZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708067171; x=1708671971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSklTkqrMVAq4VBR2iaN0vU9yUuhpA9uZMhYyUvuCP8=;
        b=XXIjMNlp0WI8uWkl3i7h/1UNBoj5OJnhHp2ORu4uU3Yf0do1xWa9DlaQKvNXqSC8We
         t8UhHv7GWr8kNGdTIwNyjRu1ZFn3w5JCfFxnV89QCqWZNfyvI9IlL8DC7dNIBnxDebsr
         gXPhXtEP9s6oB47nDlHJQDpL99SLL6Gx4PsDa3lm0bWB3zaku6y3S+0dt0MihLkWxr5R
         meMt0YWILvFdiSlv4F3GLW/TP0+6i1CtXIhOudDiN1f/xHngfSOIRilbWBLEEam3OwY6
         TRRkOU4Did16vyYLSgkrqPc5P8nDrTy0SQHOd3M37s+JQ2Y5kXOjcmllkvTBnS6ZBFDi
         BvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVMETYmVIh10iRPPLOZdCqKhIJShBY+n4BXUFuGhSqhn8lv8WopphRWu+W/vyXjqietTi8jLYLNGVx9oaJ6pXKJI8qVvxeMuTYQgYYS
X-Gm-Message-State: AOJu0YxNvveM3NfUrpC/qYzmNg6DOWDkVWGxjr9X3RJTpaWZwXkwBuQR
	AAiLF4l7gMclei3MG3QQR5Y8cOrIfcjPfN3k+0bj3wf8TQlEtteMUbUMxEVDhtY=
X-Google-Smtp-Source: AGHT+IEgEqsW1jfM+8a6dt2FCiNnr68V+blpGZzq7yJnR8tIFzU2QbB8/07AIATZ8OSq23VijWAKgw==
X-Received: by 2002:a5d:4d0d:0:b0:33b:481e:8ddd with SMTP id z13-20020a5d4d0d000000b0033b481e8dddmr2570619wrt.62.1708067170878;
        Thu, 15 Feb 2024 23:06:10 -0800 (PST)
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d66d2000000b0033940016d6esm1298839wrw.93.2024.02.15.23.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 23:06:10 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 10/12] spi: s3c64xx: deprecate fifo_lvl_mask, rx_lvl_offset and port_id
Date: Fri, 16 Feb 2024 07:05:53 +0000
Message-ID: <20240216070555.2483977-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deprecate fifo_lvl_mask, rx_lvl_offset and port_id. One shall use
{rx, tx}_fifomask instead. Add messages to each port configuration.

Suggested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d2d1c9767145..128f4a7c4bd9 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -135,8 +135,8 @@ struct s3c64xx_spi_dma_data {
 
 /**
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
- * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
- * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
+ * @fifo_lvl_mask: [DEPRECATED] use @{rx, tx}_fifomask instead.
+ * @rx_lvl_offset: [DEPRECATED] use @{rx,tx}_fifomask instead.
  * @fifo_depth: depth of the FIFO.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
@@ -192,7 +192,7 @@ struct s3c64xx_spi_port_config {
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
- * @port_id: Port identification number
+ * @port_id: [DEPRECATED] use @{rx,tx}_fifomask instead.
  * @fifo_depth: depth of the FIFO.
  * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
  *               length and position.
@@ -1508,7 +1508,9 @@ static const struct dev_pm_ops s3c64xx_spi_pm = {
 };
 
 static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
@@ -1516,14 +1518,18 @@ static const struct s3c64xx_spi_port_config s3c2443_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 13,
 	.tx_st_done	= 21,
 	.clk_div	= 2,
 };
 
 static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1531,7 +1537,9 @@ static const struct s3c64xx_spi_port_config s5pv210_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1541,7 +1549,9 @@ static const struct s3c64xx_spi_port_config exynos4_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7F, 0x7F, 0x7F, 0x7F, 0x1ff},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1551,7 +1561,9 @@ static const struct s3c64xx_spi_port_config exynos7_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1562,7 +1574,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
@@ -1573,8 +1587,10 @@ static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
@@ -1586,7 +1602,9 @@ static const struct s3c64xx_spi_port_config exynosautov9_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 2,
@@ -1597,8 +1615,10 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
 };
 
 static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
+	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
 	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
 			    0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
+	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
 	.rx_lvl_offset	= 15,
 	.tx_st_done	= 25,
 	.clk_div	= 4,
-- 
2.44.0.rc0.258.g7320e95886-goog


