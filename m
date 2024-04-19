Return-Path: <linux-kernel+bounces-151561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14EC8AB07B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D8B1F2650F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD512E1F3;
	Fri, 19 Apr 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+pT+XHE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DF12E1DA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536051; cv=none; b=msQilXWvPWARdLj/urLUFuRkL44G48x257ECY5WU1KU9N/qnPSXivx0wBJP2xaF5c53aKJH2ufYSupvViY6+yCyhnX1x9Edm9CFIyf9wEdVzwvsIj/7Id0O1K61TOwVErQ625YhdROth6wl+vT13YWL2ErmIjo64RcYSO7kJVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536051; c=relaxed/simple;
	bh=q2bEZDZIudIS1aIa7CkbX4KQHDVLkk1sD20tkmStKgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2OwJCcMdmKtem5deTkehugpWsphQ5vo8kUIUrBVbn7BzI9123wg6hR6W26zMSaLpjIwVTIjmXg4P5gkxrnUbNSCZsy2zypyCOXtodAAIC+q9+VQRd9hyhWKy/XNU0lk1WTQTztxbABTxG3NKuxnsbEp3VLefqNWs7JsjWMkjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+pT+XHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D068C3277B;
	Fri, 19 Apr 2024 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713536051;
	bh=q2bEZDZIudIS1aIa7CkbX4KQHDVLkk1sD20tkmStKgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+pT+XHEQrmbwKuAGXrFAPoJzygazswmUPaVuAbqaudckIJXqbZYvfTbyFkk/tWnP
	 sG7XtRzpei9J+MiWAoFJoCMDckSUtF98Kks8UiEm5kM5UnBEAPiLjlGu6acnOkzU5P
	 Irar+7lFMBF9zl1INSMepDc2gzARH4HUmPxxAR9X5yTv7ZzZ4Gi05GI0kYCHTeyKPs
	 /7Tad5JZCoQOA96NHTFQ7/Onrk6cKv7JHDIrZ/K/Bn6RsdByTGVkMqEFUCXN6fSqmH
	 pVfw7HWDHpxjWcSCyFxUO2wr6uURB9eIVppuGwtq+kOOxJP/vNhN/7AU8KZtrzn15G
	 VhsTHZgHUAoXQ==
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
Subject: [PATCH v2 2/6] mtd: spi-nor: get rid of non-power-of-2 page size handling
Date: Fri, 19 Apr 2024 16:12:45 +0200
Message-Id: <20240419141249.609534-3-mwalle@kernel.org>
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

The Xilinx flashes were the only user of the page sized that were no
power of 2. Support for them were dropped, thus we can also get rid of
the special page size handling for it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.c | 41 ++++++++++----------------------------
 drivers/mtd/spi-nor/core.h |  4 ----
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cbe5f92eb0af..31dfdbf96765 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1463,14 +1463,6 @@ static void spi_nor_unlock_and_unprep_rd(struct spi_nor *nor, loff_t start, size
 	spi_nor_unprep(nor);
 }
 
-static u32 spi_nor_convert_addr(struct spi_nor *nor, loff_t addr)
-{
-	if (!nor->params->convert_addr)
-		return addr;
-
-	return nor->params->convert_addr(nor, addr);
-}
-
 /*
  * Initiate the erasure of a single sector
  */
@@ -1478,8 +1470,6 @@ int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 {
 	int i;
 
-	addr = spi_nor_convert_addr(nor, addr);
-
 	if (nor->spimem) {
 		struct spi_mem_op op =
 			SPI_NOR_SECTOR_ERASE_OP(nor->erase_opcode,
@@ -2064,8 +2054,6 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	while (len) {
 		loff_t addr = from;
 
-		addr = spi_nor_convert_addr(nor, addr);
-
 		ret = spi_nor_read_data(nor, addr, len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
@@ -2098,7 +2086,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	size_t page_offset, page_remain, i;
+	size_t i;
 	ssize_t ret;
 	u32 page_size = nor->params->page_size;
 
@@ -2111,23 +2099,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
-
-		/*
-		 * If page_size is a power of two, the offset can be quickly
-		 * calculated with an AND operation. On the other cases we
-		 * need to do a modulus operation (more expensive).
-		 */
-		if (is_power_of_2(page_size)) {
-			page_offset = addr & (page_size - 1);
-		} else {
-			u64 aux = addr;
-
-			page_offset = do_div(aux, page_size);
-		}
+		size_t page_offset = addr & (page_size - 1);
 		/* the size of data remaining on the first page */
-		page_remain = min_t(size_t, page_size - page_offset, len - i);
-
-		addr = spi_nor_convert_addr(nor, addr);
+		size_t page_remain = min_t(size_t, page_size - page_offset, len - i);
 
 		ret = spi_nor_lock_device(nor);
 		if (ret)
@@ -3054,7 +3028,14 @@ static int spi_nor_init_params(struct spi_nor *nor)
 		spi_nor_init_params_deprecated(nor);
 	}
 
-	return spi_nor_late_init_params(nor);
+	ret = spi_nor_late_init_params(nor);
+	if (ret)
+		return ret;
+
+	if (WARN_ON(!is_power_of_2(nor->params->page_size)))
+		return -EINVAL;
+
+	return 0;
 }
 
 /** spi_nor_set_octal_dtr() - enable or disable Octal DTR I/O.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 072c69b0d06c..3043d583eac2 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -366,9 +366,6 @@ struct spi_nor_otp {
  * @set_octal_dtr:	enables or disables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
- * @convert_addr:	converts an absolute address into something the flash
- *                      will understand. Particularly useful when pagesize is
- *                      not a power-of-2.
  * @setup:		(optional) configures the SPI NOR memory. Useful for
  *			SPI NOR flashes that have peculiarities to the SPI NOR
  *			standard e.g. different opcodes, specific address
@@ -403,7 +400,6 @@ struct spi_nor_flash_parameter {
 	int (*set_octal_dtr)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
-	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 	int (*ready)(struct spi_nor *nor);
 
-- 
2.39.2


