Return-Path: <linux-kernel+bounces-81055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F9866F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727EA1F27DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B157330;
	Mon, 26 Feb 2024 09:29:54 +0000 (UTC)
Received: from mail.tecon.ru (mail.tecon.ru [82.112.190.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17C5731A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.112.190.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939793; cv=none; b=oTXBraGrUfqucpIuS9NBVFmuolhqj50FTqLNyl3HRFhFEhPdA3yadjYhrIZj08J2vJuX0Q54A979O76WTYmoL4Cn1NZ2l+R8bgrqu9ep3hNk5vGL6ggh5+jr2q1MboR+ulki7fSeMLA2i/+LZ9j6Nhf+KZr3EA1Jg38t+xU40bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939793; c=relaxed/simple;
	bh=gYtBtcr/egSZXz7QFAh1aw4h4I+YrruWBeItmKKyOGI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YICLj1cb0/0C4sYh6YiWKD8yLR75xOEfdvu/Qs4aFT0yAKDqHbZ/X9S2GGcuWDQF7DXnc19cwFzMozEK3gjTMDwuF9C476tsITH4c+2h7i0PTgr60+JdabHj8isaIZ7aR54cAsqbZ5AJVnfQfBPLlYOVLDKPKtsFSIYmxTB8Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tecon.ru; spf=pass smtp.mailfrom=tecon.ru; arc=none smtp.client-ip=82.112.190.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tecon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecon.ru
From: Dmitry Dunaev <dunaev@tecon.ru>
To:
CC: <dunaich@mail.ru>, Dmitry Dunaev <dunaev@tecon.ru>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Michael
 Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: spi-nor: Add Puya Semiconductor chips driver
Date: Mon, 26 Feb 2024 12:23:10 +0300
Message-ID: <20240226092312.1834584-1-dunaev@tecon.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a SPI NOR manufacturer driver for Puya Semiconductor chips

Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
---
 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/puya.c   | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/puya.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 5e68468b72fc..3e22039d0432 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -10,6 +10,7 @@ spi-nor-objs			+= intel.o
 spi-nor-objs			+= issi.o
 spi-nor-objs			+= macronix.o
 spi-nor-objs			+= micron-st.o
+spi-nor-objs			+= puya.o
 spi-nor-objs			+= spansion.o
 spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
diff --git a/drivers/mtd/spi-nor/puya.c b/drivers/mtd/spi-nor/puya.c
new file mode 100644
index 000000000000..2198a9ed7101
--- /dev/null
+++ b/drivers/mtd/spi-nor/puya.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Tecon MT LLC.
+ */
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+/* Puya Semiconductor (Shanghai) Co., Ltd */
+static const struct flash_info puya_nor_parts[] = {
+	{
+		.id = SNOR_ID(0x85, 0x60, 0x10),
+		.name = "p25q05h",
+		.size = SZ_64K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x11),
+		.name = "p25q10h",
+		.size = SZ_128K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x12),
+		.name = "p25q20h",
+		.size = SZ_256K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x13),
+		.name = "p25q40h",
+		.size = SZ_512K,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x14),
+		.name = "p25q80h",
+		.size = SZ_1M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x15),
+		.name = "p25q16h",
+		.size = SZ_2M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x16),
+		.name = "p25q32h",
+		.size = SZ_4M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x17),
+		.name = "p25q64h",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}, {
+		.id = SNOR_ID(0x85, 0x60, 0x18),
+		.name = "p25q128h",
+		.size = SZ_8M,
+		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+	}
+};
+
+const struct spi_nor_manufacturer spi_nor_puya = {
+	.name = "puya",
+	.parts = puya_nor_parts,
+	.nparts = ARRAY_SIZE(puya_nor_parts),
+};
-- 
2.34.1


