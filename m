Return-Path: <linux-kernel+bounces-142749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27A8A2FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318F2285D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86C84DF0;
	Fri, 12 Apr 2024 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP1cF5Qh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA584A5C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929456; cv=none; b=Ln+f4EXbAzDzwh/Pp+PUxJbABvpIZuvLiC8N1PX2KnOgLXLKagd/z4SwQrS3sXmpJq/TOf8Fxb1qOOIn7Z52mIEjxlnQqWRN9G6eFpSLXrgD0wZ5j74RUGQ9lCi48lGzSZZ7f1EXijHUPwg9Ith6JqrOgiH4TN6dNoFU5/tPUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929456; c=relaxed/simple;
	bh=QVHvqJfpR6HpyyA7+X+VGVBwzk2Mqc1k3kJ/dIAhUrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuZ7S20DI2JbOvwUPd4VNnLPiiL3Mi6z1yTqYCLz96jf/StrCuhZQmjdp6Y+c4EJorvV/6go7n5tsiHyHmwJOaeR6Sh6TO3xvY54QyIXbm9fVqDi0NB8wYIK5Y3jr8j4VjW2d64K7B7cFIe3TFPzKj8EwWIHOsUS62p3Whgppes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP1cF5Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CEAC2BD10;
	Fri, 12 Apr 2024 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929456;
	bh=QVHvqJfpR6HpyyA7+X+VGVBwzk2Mqc1k3kJ/dIAhUrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WP1cF5QhBykq4x7XD5/jiX0GC/x54f1IsADqN8ZfcHbGEtONmV8pqlnuENU6hGHW6
	 +Pu5WSpww2r4SS2rCBx712bRuQNxIokkeKd6KFBuvlz7XfHt5VCJ0eB4aN0aNX15fd
	 yidrOYlzgVqYrWf0Hs1ykqeLar34dBV5I8CSvv4bKT97TMdxvki+IRc6AK7XFlBpZc
	 B6oFmN/9WTLwxxAcurW6b69pzl9gPX8mumYAJN+zrkOjLouRBygLdEv06QoKe1Yqrr
	 iq3XqyA3SVoCwXQhfFQ5OUhnZ75vh7xN647iDZoVi9QRYfEY6O1AvTTzzb0vl8EtO7
	 8WsvejyW/zCeQ==
From: Michael Walle <mwalle@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 1/6] mtd: spi-nor: Remove support for Xilinx S3AN flashes
Date: Fri, 12 Apr 2024 15:44:00 +0200
Message-Id: <20240412134405.381832-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412134405.381832-1-mwalle@kernel.org>
References: <20240412134405.381832-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These flashes are kind of an oddball for the very old Xilinx Spartan 3
FPGAs to store their bitstream. More importantly, they reuse the Atmel
JEDEC manufacturer ID and in fact the at45db081d already blocks the use
of the 3S700AN flash chip. It's time to sunset support for these
flashes.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/Makefile |   1 -
 drivers/mtd/spi-nor/core.c   |   1 -
 drivers/mtd/spi-nor/core.h   |   1 -
 drivers/mtd/spi-nor/xilinx.c | 169 -----------------------------------
 4 files changed, 172 deletions(-)
 delete mode 100644 drivers/mtd/spi-nor/xilinx.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 5e68468b72fc..5dd9c35f6b6f 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -13,7 +13,6 @@ spi-nor-objs			+= micron-st.o
 spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
-spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
 spi-nor-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e1f1913536b..cbe5f92eb0af 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1986,7 +1986,6 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_spansion,
 	&spi_nor_sst,
 	&spi_nor_winbond,
-	&spi_nor_xilinx,
 	&spi_nor_xmc,
 };
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..072c69b0d06c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -603,7 +603,6 @@ extern const struct spi_nor_manufacturer spi_nor_st;
 extern const struct spi_nor_manufacturer spi_nor_spansion;
 extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
-extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
 
 extern const struct attribute_group *spi_nor_sysfs_groups[];
diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
deleted file mode 100644
index f99118c691b0..000000000000
--- a/drivers/mtd/spi-nor/xilinx.c
+++ /dev/null
@@ -1,169 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2005, Intec Automation Inc.
- * Copyright (C) 2014, Freescale Semiconductor, Inc.
- */
-
-#include <linux/mtd/spi-nor.h>
-
-#include "core.h"
-
-#define XILINX_OP_SE		0x50	/* Sector erase */
-#define XILINX_OP_PP		0x82	/* Page program */
-#define XILINX_OP_RDSR		0xd7	/* Read status register */
-
-#define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
-#define XSR_RDY			BIT(7)	/* Ready */
-
-#define XILINX_RDSR_OP(buf)						\
-	SPI_MEM_OP(SPI_MEM_OP_CMD(XILINX_OP_RDSR, 0),			\
-		   SPI_MEM_OP_NO_ADDR,					\
-		   SPI_MEM_OP_NO_DUMMY,					\
-		   SPI_MEM_OP_DATA_IN(1, buf, 0))
-
-#define S3AN_FLASH(_id, _name, _n_sectors, _page_size)		\
-	.id = _id,						\
-	.name = _name,						\
-	.size = 8 * (_page_size) * (_n_sectors),		\
-	.sector_size = (8 * (_page_size)),			\
-	.page_size = (_page_size),				\
-	.flags = SPI_NOR_NO_FR
-
-/* Xilinx S3AN share MFR with Atmel SPI NOR */
-static const struct flash_info xilinx_nor_parts[] = {
-	/* Xilinx S3AN Internal Flash */
-	{ S3AN_FLASH(SNOR_ID(0x1f, 0x22, 0x00), "3S50AN", 64, 264) },
-	{ S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S200AN", 256, 264) },
-	{ S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S400AN", 256, 264) },
-	{ S3AN_FLASH(SNOR_ID(0x1f, 0x25, 0x00), "3S700AN", 512, 264) },
-	{ S3AN_FLASH(SNOR_ID(0x1f, 0x26, 0x00), "3S1400AN", 512, 528) },
-};
-
-/*
- * This code converts an address to the Default Address Mode, that has non
- * power of two page sizes. We must support this mode because it is the default
- * mode supported by Xilinx tools, it can access the whole flash area and
- * changing over to the Power-of-two mode is irreversible and corrupts the
- * original data.
- * Addr can safely be unsigned int, the biggest S3AN device is smaller than
- * 4 MiB.
- */
-static u32 s3an_nor_convert_addr(struct spi_nor *nor, u32 addr)
-{
-	u32 page_size = nor->params->page_size;
-	u32 offset, page;
-
-	offset = addr % page_size;
-	page = addr / page_size;
-	page <<= (page_size > 512) ? 10 : 9;
-
-	return page | offset;
-}
-
-/**
- * xilinx_nor_read_sr() - Read the Status Register on S3AN flashes.
- * @nor:	pointer to 'struct spi_nor'.
- * @sr:		pointer to a DMA-able buffer where the value of the
- *              Status Register will be written.
- *
- * Return: 0 on success, -errno otherwise.
- */
-static int xilinx_nor_read_sr(struct spi_nor *nor, u8 *sr)
-{
-	int ret;
-
-	if (nor->spimem) {
-		struct spi_mem_op op = XILINX_RDSR_OP(sr);
-
-		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = spi_nor_controller_ops_read_reg(nor, XILINX_OP_RDSR, sr,
-						      1);
-	}
-
-	if (ret)
-		dev_dbg(nor->dev, "error %d reading SR\n", ret);
-
-	return ret;
-}
-
-/**
- * xilinx_nor_sr_ready() - Query the Status Register of the S3AN flash to see
- * if the flash is ready for new commands.
- * @nor:	pointer to 'struct spi_nor'.
- *
- * Return: 1 if ready, 0 if not ready, -errno on errors.
- */
-static int xilinx_nor_sr_ready(struct spi_nor *nor)
-{
-	int ret;
-
-	ret = xilinx_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	return !!(nor->bouncebuf[0] & XSR_RDY);
-}
-
-static int xilinx_nor_setup(struct spi_nor *nor,
-			    const struct spi_nor_hwcaps *hwcaps)
-{
-	u32 page_size;
-	int ret;
-
-	ret = xilinx_nor_read_sr(nor, nor->bouncebuf);
-	if (ret)
-		return ret;
-
-	nor->erase_opcode = XILINX_OP_SE;
-	nor->program_opcode = XILINX_OP_PP;
-	nor->read_opcode = SPINOR_OP_READ;
-	nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
-
-	/*
-	 * This flashes have a page size of 264 or 528 bytes (known as
-	 * Default addressing mode). It can be changed to a more standard
-	 * Power of two mode where the page size is 256/512. This comes
-	 * with a price: there is 3% less of space, the data is corrupted
-	 * and the page size cannot be changed back to default addressing
-	 * mode.
-	 *
-	 * The current addressing mode can be read from the XRDSR register
-	 * and should not be changed, because is a destructive operation.
-	 */
-	if (nor->bouncebuf[0] & XSR_PAGESIZE) {
-		/* Flash in Power of 2 mode */
-		page_size = (nor->params->page_size == 264) ? 256 : 512;
-		nor->params->page_size = page_size;
-		nor->mtd.writebufsize = page_size;
-		nor->params->size = nor->info->size;
-		nor->mtd.erasesize = 8 * page_size;
-	} else {
-		/* Flash in Default addressing mode */
-		nor->params->convert_addr = s3an_nor_convert_addr;
-		nor->mtd.erasesize = nor->info->sector_size;
-	}
-
-	return 0;
-}
-
-static int xilinx_nor_late_init(struct spi_nor *nor)
-{
-	nor->params->setup = xilinx_nor_setup;
-	nor->params->ready = xilinx_nor_sr_ready;
-
-	return 0;
-}
-
-static const struct spi_nor_fixups xilinx_nor_fixups = {
-	.late_init = xilinx_nor_late_init,
-};
-
-const struct spi_nor_manufacturer spi_nor_xilinx = {
-	.name = "xilinx",
-	.parts = xilinx_nor_parts,
-	.nparts = ARRAY_SIZE(xilinx_nor_parts),
-	.fixups = &xilinx_nor_fixups,
-};
-- 
2.39.2


