Return-Path: <linux-kernel+bounces-163830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEB8B72C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4B31C23188
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129912DD94;
	Tue, 30 Apr 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKuhx1K+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2912D74F;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475494; cv=none; b=Op9XRxX6+mIxcGrVQLuN5GpRxJpJr8WCKcIfgDNP7M5QfxZRPaQxT/hDF/jHJIr5O8/kfukTOqV9qh+t8aDqNiN+b2qiHM8F2DvjOflw7Z5kElUUTccfBRNiMC7yVeRFIMA21yNmLx+QSzP2rOT5+bCJjgXh8lS07eu4e6l6G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475494; c=relaxed/simple;
	bh=2n6RKhZ6Alf/wZaO1MKOWwaDevD0k3b+5zSEVw4UWKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtemA7mA/nCPiamVq15942YQt3wHKS4dp62xf9/I8/Ibtr2m+sD0ST/vRb4Uw9xXBDXPK5k3DbVfbxTFQTTpKVyVFVfNgG7MTQovwvH085pg2cc/EukTCfhhoINiRkP0iYjFcE7cEk4ibxhUzt+ZrMTcvV/H3YULGMENcrJHnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKuhx1K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6393C4AF1A;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714475493;
	bh=2n6RKhZ6Alf/wZaO1MKOWwaDevD0k3b+5zSEVw4UWKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eKuhx1K+SwtgMP71K/LghjaKXGuYS90nfXBjhKShGHvmuGy54dtW31bs4aznwXVR8
	 +Xq3Ts6cFAtynwNPEjMa/cxE0Ieql0KT+Mz0A6Q2H8ZJivSQy9CgnMy95/6AkC2101
	 2Q0CLoHSinF6U5aoP6Lvei/5WkCoZqob+tf+B+7h/xdqAf/g9kBNsg0eP8V6IdxbuK
	 NwWAE/QeISov9QZlHSnPn6SY4SkzlY8CAuoJFo+iq9/6QJHydHNYeEq4VhlbtdXgWx
	 Jbgj7JphcSX7ZKcszIA0CgCPRKI3Anpr41p6ywaBsem4nPoJ7I9qHFc/4hIezW16zZ
	 l8g04i9weF70w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D70C4345F;
	Tue, 30 Apr 2024 11:11:33 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Tue, 30 Apr 2024 19:11:11 +0800
Subject: [PATCH v7 2/3] mtd: rawnand: Enable monolithic read when reading
 subpages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-loongson1-nand-v7-2-60787c314fa4@gmail.com>
References: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
In-Reply-To: <20240430-loongson1-nand-v7-0-60787c314fa4@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714475491; l=2188;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=wxQD1HBRVqdAYZRkfcNz/OdgGE3Cin/b3Ag8hRQf9EE=;
 b=qDOtiX5d4aKcQL2FPn2OyNayDTvIp5rLphjmsU/ftUr6P5kvU+uapKzBtmSJ/WRUiabEBChwh
 aCMaYeMxjLVBrdMF8NlJVpvxvgOeSPpm4aw4cFeheZOOjofdE3W3IPl
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com

From: Keguang Zhang <keguang.zhang@gmail.com>

nand_read_subpage() reads data and ECC data by two separate
operations.
This patch allows the NAND controllers who support
monolithic page read to do subpage read by a single operation,
which is more effective than nand_read_subpage().
---
Changes in v7:
- None

Changes in v6:
- A newly added patch

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/mtd/nand/raw/nand_base.c | 5 +++--
 include/linux/mtd/rawnand.h      | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d7dbbd469b89..eeb654c6b4fc 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3630,7 +3630,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 							      oob_required,
 							      page);
 			else if (!aligned && NAND_HAS_SUBPAGE_READ(chip) &&
-				 !oob)
+				 !NAND_HAS_MONOLITHIC_READ(chip) && !oob)
 				ret = chip->ecc.read_subpage(chip, col, bytes,
 							     bufpoi, page);
 			else
@@ -3648,7 +3648,8 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 			 * partial pages or when a bounce buffer is required.
 			 */
 			if (use_bounce_buf) {
-				if (!NAND_HAS_SUBPAGE_READ(chip) && !oob &&
+				if ((!NAND_HAS_SUBPAGE_READ(chip) ||
+				     NAND_HAS_MONOLITHIC_READ(chip)) && !oob &&
 				    !(mtd->ecc_stats.failed - ecc_stats.failed) &&
 				    (ops->mode != MTD_OPS_RAW)) {
 					chip->pagecache.page = realpage;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e84522e31301..92d3ab491c9c 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -150,6 +150,11 @@ struct gpio_desc;
 /* Device needs 3rd row address cycle */
 #define NAND_ROW_ADDR_3		BIT(14)
 
+/* Device supports monolithic reads */
+#define NAND_MONOLITHIC_READ	BIT(15)
+/* Macros to identify the above */
+#define NAND_HAS_MONOLITHIC_READ(chip) ((chip->options & NAND_MONOLITHIC_READ))
+
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
 #define NAND_SKIP_BBTSCAN	BIT(16)

-- 
2.40.1



