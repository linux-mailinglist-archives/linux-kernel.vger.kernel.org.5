Return-Path: <linux-kernel+bounces-58178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEEA84E25F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F871C28899
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927178B5D;
	Thu,  8 Feb 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YcrtGknA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438978B44
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400259; cv=none; b=c4PlIzcCK2aaZ1GP4NI2ADEU2lPd4/95yLt4Tsi0bYfqUzrVpet4m2Tf5fSundb6DmXvV7yZWAhBHH6n1Uh60b35Rt/3GJyANfjg53c4XIOlgcl9DMifGqv++Dvy4DOj1SOOiW6yHGVH50L3G85F+3DcbASMUb9SfbfSb7W6MPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400259; c=relaxed/simple;
	bh=fUPem54IQJpvSE3lBoujmHjP+dsjs6xGb0nQzuWM0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SarGOVT4ElKKj4vvJv6CGHg16w/utaxcm73MIYf/a3jveCTV84EjHPxkey3/T0C2d24RzcBzIeAEkEqLtrELYnuz2XCkclbgo8MuGqmnq+rzLZK8cFWTFKhBHMkif66boErVoKMTUX3fWZpHMzvUwRWiHmW6P9zjoH4uYkt1jng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YcrtGknA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33934567777so1240263f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707400255; x=1708005055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UCCMmhJgpPZWbOVTAspr0xjn11XvYuA37qXyTRrUkA=;
        b=YcrtGknApRowax3Jv2EQbysooJ/vaE8us0r2HOuhiodYnCbNQh4byzxxeFW1UwN3HJ
         N7yG2lRZ5ZjJ3cvvis5eTzQwTW5DB4qrVpf54qR/5UaH/KCuRpam/2OxRhxcNXMbULQ2
         w+P2pVrAS4MTPNxZHuPzGg8vpcbrl3744hEXU9KeokbaZM0QsUKd3YgjcIR21hnT5CEh
         ya74WY+6rqIrNKlPvLhwPpW6T0UTbz0MqREYI49iD6Jb8IvaZkjQnOUGpxpSPlYrrGWM
         eo24ZQp0Pl3y7ExH27IOd1r/Cd+Fc+1FbhPVB+vE2e2ClyE5QgAaFGwFgqdn1zoE2LX/
         DHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400255; x=1708005055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UCCMmhJgpPZWbOVTAspr0xjn11XvYuA37qXyTRrUkA=;
        b=iHirQcp6fjhnY/e9C2p9vj2kynZGKZBKhmbrBMDYDPS2HtOcK60C8jZ3RvSkpbhnPy
         IG+cSUSluFzkvnAWK4ff+zQaMHPgRbURYMa75mUYGAbUMfg32aKIJvIQQh6dnjDl9lGg
         5pEv4f+DHhxLWRq6qchKv2ifhdH/2AvFD1S1zLKjIOIk0OxDCEB6TaT0x4V/oisSy459
         ZbMX/HDOSp6zvZWX75EQBpjWjnvRkgqzHVvC5a1dpPbJaXBlKLe8Se0EB8o8pCa7A0Lv
         rVp+V69os8cwjDL6ORRGeLdRWZTgK5OnpgwAeMIcuOEvbSvXMRpmIsTHTP+S608ById2
         +EMg==
X-Gm-Message-State: AOJu0Yylzk2IEx0PWRQyxxSfjOR4EN66DVaJALXMn4WU6WRgUDJ+dWep
	hWA+ooUIjbJ8s0AjSx1blKfLvqW7AyBz9jw6+BVvjJaRhydWnYND+/lytsZx2Do=
X-Google-Smtp-Source: AGHT+IEVlas5aC1YYkqnEkCuf/GE3JUtE+wPJtkAjHljvi3KS3HCSsI0jEORkOPkG2ErSDlBw1hRow==
X-Received: by 2002:a5d:638f:0:b0:33b:28af:56ac with SMTP id p15-20020a5d638f000000b0033b28af56acmr6779262wru.39.1707400255224;
        Thu, 08 Feb 2024 05:50:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7c1llJnJLhKJKOEH75qX2O+Ad2GQ0D9Iueip1cptPAfBg5GKASu+kkfTKfg5iYcGFMzwT9rrf/W6cqIS7m/3M/0V8foXlnEvKHk+9++6YL7yFg1YOJHhLChSnu7iLnhRWPoyjariL/9oI6d/PnfKhqnDd4BydrPK1JtaWfjh3vJUeiUM+6uSKzFTIlxEIDHqaaFrOj1GBhaZs7XJ8/zb8ggQekYMO0TD/PfZ0rQR8CAP1ma/ButcfjFfHJkJn53xgEx+Jfec0WlSDGMR39gIRfh49ItP+a/S2Y8o1ZwiU/cUG+6Opz20cjWl0Ey2FfI1o7wk4FiTDSJMyZkcWVu/PWtXjnTruV32X7fRcBVovY2V6d2P2rQey8gnq8+6CTIpgZ8XdwqxGIuiHG5QC5FFbRIfo+nfzM9GHWgjzsDd7PB/VwBw3GI8XI5g7quwe2bBRL+vy8x8aXJPE1JWFnrS984+HjnuO6BdEOYX2Zf+by67AHcdC/pKZus9MY/7NiQthNAX9AeECZjoBD0oqrLAUTLxgbV5sR06iKO5lo4g7ZxWGZTrh0QPrAfv2fec+nlgjXPInbMyD/6snZxZIV2YwhAHuSZeBWi10LI8mwQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0033b43a5f53csm3618820wrh.103.2024.02.08.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:50:54 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 03/12] spi: s3c64xx: allow full FIFO masks
Date: Thu,  8 Feb 2024 13:50:36 +0000
Message-ID: <20240208135045.3728927-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is wrong because is using partial register field masks for the
SPI_STATUS.{RX, TX}_FIFO_LVL register fields.

We see s3c64xx_spi_port_config.fifo_lvl_mask with different values for
different instances of the same IP. Take s5pv210_spi_port_config for
example, it defines:
	.fifo_lvl_mask  = { 0x1ff, 0x7F },

fifo_lvl_mask is used to determine the FIFO depth of the instance of the
IP. In this case, the integrator uses a 256 bytes FIFO for the first SPI
instance of the IP, and a 64 bytes FIFO for the second instance. While
the first mask reflects the SPI_STATUS.{RX, TX}_FIFO_LVL register
fields, the second one is two bits short. Using partial field masks is
misleading and can hide problems of the driver's logic.

Allow platforms to specify the full FIFO mask, regardless of the FIFO
depth.

Introduce {rx, tx}_fifomask to represent the SPI_STATUS.{RX, TX}_FIFO_LVL
register fields. It's a shifted mask defining the field's length and
position. We'll be able to deprecate the use of @rx_lvl_offset, as the
shift value can be determined from the mask. The existing compatibles
shall start using {rx, tx}_fifomask so that they use the full field mask
and to avoid shifting the mask to position, and then shifting it back to
zero in the {TX, RX}_FIFO_LVL macros.

@rx_lvl_offset will be deprecated in a further patch, after we have the
infrastructure to deprecate @fifo_lvl_mask as well.

No functional change intended.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 40 +++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6ff3b25b6feb..338ca3f03ea5 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -109,10 +110,10 @@
 #define FIFO_LVL_MASK(i) ((i)->port_conf->fifo_lvl_mask[i->port_id])
 #define S3C64XX_SPI_ST_TX_DONE(v, i) (((v) & \
 				(1 << (i)->port_conf->tx_st_done)) ? 1 : 0)
-#define TX_FIFO_LVL(v, i) (((v) >> S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT) &	\
-			   FIFO_LVL_MASK(i))
-#define RX_FIFO_LVL(v, i) (((v) >> (i)->port_conf->rx_lvl_offset) & \
-					FIFO_LVL_MASK(i))
+#define TX_FIFO_LVL(v, sdd)	(((v) & (sdd)->tx_fifomask) >>		\
+				 __ffs((sdd)->tx_fifomask))
+#define RX_FIFO_LVL(v, sdd)	(((v) & (sdd)->rx_fifomask) >>		\
+				 __ffs((sdd)->rx_fifomask))
 #define FIFO_DEPTH(i) ((FIFO_LVL_MASK(i) >> 1) + 1)
 
 #define S3C64XX_SPI_MAX_TRAILCNT	0x3ff
@@ -136,6 +137,10 @@ struct s3c64xx_spi_dma_data {
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
  * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
+ * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
+ * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
  * @quirks: Bitmask of known quirks
@@ -154,6 +159,8 @@ struct s3c64xx_spi_dma_data {
 struct s3c64xx_spi_port_config {
 	int	fifo_lvl_mask[MAX_SPI_PORTS];
 	int	rx_lvl_offset;
+	u32	rx_fifomask;
+	u32	tx_fifomask;
 	int	tx_st_done;
 	int	quirks;
 	int	clk_div;
@@ -184,6 +191,10 @@ struct s3c64xx_spi_port_config {
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
+ * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
+ * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the field's
+ *               length and position.
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
@@ -203,6 +214,8 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
+	u32				rx_fifomask;
+	u32				tx_fifomask;
 };
 
 static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -1183,6 +1196,23 @@ static inline const struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 	return (const struct s3c64xx_spi_port_config *)platform_get_device_id(pdev)->driver_data;
 }
 
+static void s3c64xx_spi_set_fifomask(struct s3c64xx_spi_driver_data *sdd)
+{
+	const struct s3c64xx_spi_port_config *port_conf = sdd->port_conf;
+
+	if (port_conf->rx_fifomask)
+		sdd->rx_fifomask = port_conf->rx_fifomask;
+	else
+		sdd->rx_fifomask = FIFO_LVL_MASK(sdd) <<
+			port_conf->rx_lvl_offset;
+
+	if (port_conf->tx_fifomask)
+		sdd->tx_fifomask = port_conf->tx_fifomask;
+	else
+		sdd->tx_fifomask = FIFO_LVL_MASK(sdd) <<
+			S3C64XX_SPI_ST_TX_FIFO_LVL_SHIFT;
+}
+
 static int s3c64xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*mem_res;
@@ -1231,6 +1261,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	s3c64xx_spi_set_fifomask(sdd);
+
 	sdd->cur_bpw = 8;
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
-- 
2.43.0.687.g38aa6559b0-goog


