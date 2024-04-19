Return-Path: <linux-kernel+bounces-151562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AB8AB07C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DBB28155D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9412F38E;
	Fri, 19 Apr 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLl+bryC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549212F361
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536053; cv=none; b=ZVTrrTNXmQ/9Xm3oOK0YNdKtzF1MrWOVWSlZqM2NTg8InyPdMGlBMKV/v0bI7K8QBrZCRrFNIxaiF0pnoaSPJOVy2Bd26V3L/uIQrKG03nR86jeVzgXjih5uctBAQ+9/37ThcdGRSceBedrcFZ5tHCoRNnsfV2bWrlwZ1GHzW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536053; c=relaxed/simple;
	bh=eu/b53uh7QEFQfeTA4Rx9Iizk5MHoafPYkrPYXyPtFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+u3YT9Bu0gquoMQJoHu+XQ+3ZUoLtyqx1dD0e3kZwHqhuq9Qh6sfVoNQHYI9NZFhnFFbCFGY9s4uYVXg5KxNGWybD0uiZlS1mA0oVISFmfSRA+m9feHt72GcO26OJ3Nz6sBSQMk3x2pdxI1FxIcQsw8z9XmULXPVgZoWZWaYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLl+bryC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8952C32781;
	Fri, 19 Apr 2024 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536053;
	bh=eu/b53uh7QEFQfeTA4Rx9Iizk5MHoafPYkrPYXyPtFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLl+bryCZObdL2ffb7sW5QC3jVBjzYkzfaV9dUxZUtCxNHCLyq/LZq4ncPugboy8f
	 Q/599cuOFSG/hNlOFcpLRuef+Y+BnQN+h6081JDRYArHG/PNrf77TJbHmeS7iNpqgt
	 OtFilIw1nOaIXUUWkYVV/2/CrwaQirZY+UindCrZvR615g3ailFIL4OI1bwjHE4SlI
	 u+LU3L2mHurSnrOeKUw98PeTXBAWpUxEnnGWYyoEyf1nGAn97NqVPwxiSVc4vWKNp0
	 cL4MyRYyX4GImZ00GH+OXje7NmqporXnlw+EHjgybGdy7f0rm1FHQnx9qSCK7ESLb4
	 YyOUUAxa9XG8Q==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 3/6] mtd: spi-nor: remove .setup() callback
Date: Fri, 19 Apr 2024 16:12:46 +0200
Message-Id: <20240419141249.609534-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419141249.609534-1-mwalle@kernel.org>
References: <20240419141249.609534-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the removal of the Xilinx flashes, there is no more flash driver
using that hook. The original intention was to let the driver configure
special requirements like page size an opcodes.  This is already
possible by other means and it is unlikely a flash will overwrite the
(more or less complex) setup function.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 105 ++++++++++++++++---------------------
 drivers/mtd/spi-nor/core.h |   5 --
 2 files changed, 45 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 31dfdbf96765..f4c0b5185818 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2554,8 +2554,51 @@ static int spi_nor_select_erase(struct spi_nor *nor)
 	return 0;
 }
 
-static int spi_nor_default_setup(struct spi_nor *nor,
-				 const struct spi_nor_hwcaps *hwcaps)
+static int spi_nor_set_addr_nbytes(struct spi_nor *nor)
+{
+	if (nor->params->addr_nbytes) {
+		nor->addr_nbytes = nor->params->addr_nbytes;
+	} else if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
+		/*
+		 * In 8D-8D-8D mode, one byte takes half a cycle to transfer. So
+		 * in this protocol an odd addr_nbytes cannot be used because
+		 * then the address phase would only span a cycle and a half.
+		 * Half a cycle would be left over. We would then have to start
+		 * the dummy phase in the middle of a cycle and so too the data
+		 * phase, and we will end the transaction with half a cycle left
+		 * over.
+		 *
+		 * Force all 8D-8D-8D flashes to use an addr_nbytes of 4 to
+		 * avoid this situation.
+		 */
+		nor->addr_nbytes = 4;
+	} else if (nor->info->addr_nbytes) {
+		nor->addr_nbytes = nor->info->addr_nbytes;
+	} else {
+		nor->addr_nbytes = 3;
+	}
+
+	if (nor->addr_nbytes == 3 && nor->params->size > 0x1000000) {
+		/* enable 4-byte addressing if the device exceeds 16MiB */
+		nor->addr_nbytes = 4;
+	}
+
+	if (nor->addr_nbytes > SPI_NOR_MAX_ADDR_NBYTES) {
+		dev_dbg(nor->dev, "The number of address bytes is too large: %u\n",
+			nor->addr_nbytes);
+		return -EINVAL;
+	}
+
+	/* Set 4byte opcodes when possible. */
+	if (nor->addr_nbytes == 4 && nor->flags & SNOR_F_4B_OPCODES &&
+	    !(nor->flags & SNOR_F_HAS_4BAIT))
+		spi_nor_set_4byte_opcodes(nor);
+
+	return 0;
+}
+
+static int spi_nor_setup(struct spi_nor *nor,
+			 const struct spi_nor_hwcaps *hwcaps)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 	u32 ignored_mask, shared_mask;
@@ -2612,64 +2655,6 @@ static int spi_nor_default_setup(struct spi_nor *nor,
 		return err;
 	}
 
-	return 0;
-}
-
-static int spi_nor_set_addr_nbytes(struct spi_nor *nor)
-{
-	if (nor->params->addr_nbytes) {
-		nor->addr_nbytes = nor->params->addr_nbytes;
-	} else if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
-		/*
-		 * In 8D-8D-8D mode, one byte takes half a cycle to transfer. So
-		 * in this protocol an odd addr_nbytes cannot be used because
-		 * then the address phase would only span a cycle and a half.
-		 * Half a cycle would be left over. We would then have to start
-		 * the dummy phase in the middle of a cycle and so too the data
-		 * phase, and we will end the transaction with half a cycle left
-		 * over.
-		 *
-		 * Force all 8D-8D-8D flashes to use an addr_nbytes of 4 to
-		 * avoid this situation.
-		 */
-		nor->addr_nbytes = 4;
-	} else if (nor->info->addr_nbytes) {
-		nor->addr_nbytes = nor->info->addr_nbytes;
-	} else {
-		nor->addr_nbytes = 3;
-	}
-
-	if (nor->addr_nbytes == 3 && nor->params->size > 0x1000000) {
-		/* enable 4-byte addressing if the device exceeds 16MiB */
-		nor->addr_nbytes = 4;
-	}
-
-	if (nor->addr_nbytes > SPI_NOR_MAX_ADDR_NBYTES) {
-		dev_dbg(nor->dev, "The number of address bytes is too large: %u\n",
-			nor->addr_nbytes);
-		return -EINVAL;
-	}
-
-	/* Set 4byte opcodes when possible. */
-	if (nor->addr_nbytes == 4 && nor->flags & SNOR_F_4B_OPCODES &&
-	    !(nor->flags & SNOR_F_HAS_4BAIT))
-		spi_nor_set_4byte_opcodes(nor);
-
-	return 0;
-}
-
-static int spi_nor_setup(struct spi_nor *nor,
-			 const struct spi_nor_hwcaps *hwcaps)
-{
-	int ret;
-
-	if (nor->params->setup)
-		ret = nor->params->setup(nor, hwcaps);
-	else
-		ret = spi_nor_default_setup(nor, hwcaps);
-	if (ret)
-		return ret;
-
 	return spi_nor_set_addr_nbytes(nor);
 }
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3043d583eac2..497957b64906 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -366,10 +366,6 @@ struct spi_nor_otp {
  * @set_octal_dtr:	enables or disables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
- * @setup:		(optional) configures the SPI NOR memory. Useful for
- *			SPI NOR flashes that have peculiarities to the SPI NOR
- *			standard e.g. different opcodes, specific address
- *			calculation, page size, etc.
  * @ready:		(optional) flashes might use a different mechanism
  *			than reading the status register to indicate they
  *			are ready for a new command
@@ -400,7 +396,6 @@ struct spi_nor_flash_parameter {
 	int (*set_octal_dtr)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
-	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 	int (*ready)(struct spi_nor *nor);
 
 	const struct spi_nor_locking_ops *locking_ops;
-- 
2.39.2


