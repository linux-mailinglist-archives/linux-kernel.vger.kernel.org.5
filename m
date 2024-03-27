Return-Path: <linux-kernel+bounces-120689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0388DB79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE811F2A6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA953397;
	Wed, 27 Mar 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaSyHLv0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88A524CE;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536292; cv=none; b=LmkqdmCkk6j/NGIJCXsz7DA9jd0ex+m9rS6uLVQD0cFjEszApEna8TgFVOpBQs8vLsmvMxmh4hBvnvtE9C1K39C6fWtOHmJ5X/QPcUe9W8fz78My8x6wGUmeIdLl0ranepkUeynaehyZ2fif5YDN8d6hBknbQUqVn9+1Z7KvLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536292; c=relaxed/simple;
	bh=rpDdqi9H/9+yY97geGXJz7EymWFNjuM/TNqVLXbS7jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwarIf68AuDwPbhKtqhZWOV9OskLwXXpreK6o3mIE1eVEcmbdqL+zs3CRlOIcx2MhtKq3ns0fSK3FEbFzwG1kZHx1NB8UGxrA10ECAwcpLeUCuc4zBoEYFEVOH9r4couzuUYNYdgl+0gAKQfZPUZ+Xq2jABP0eHeQGfjiWFn4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaSyHLv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFD69C433A6;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711536291;
	bh=rpDdqi9H/9+yY97geGXJz7EymWFNjuM/TNqVLXbS7jY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EaSyHLv0YBqbe9fVrkSH3v+BogorJ/tul+/vfmFQyBVy3K0z0BQAWZ/UxkgWyRd+U
	 9w4TUes1a6QzbMSN3J6WAruOwCVl9JKQVFxg1PDj+bey/nteHCS2eEfDHpI3z0kVz4
	 ZuOTg66TvPaDncMlAenMyQ+riPGyUl7v4dTv6wIk92PBISpgDQRBFW196PRqX/3vau
	 2HtNGHROfvFrVgGgi0Jl5sODTE16XQsoehOGpJBPzVl11JWi3l/N9hqdZTeICQe3Eh
	 /HbkaVxgE/WvjQhL0QTAvgN2YihiYJKfirwK5rY0OmcDuf9pw2NljXfolGjtpaPHNd
	 3K6H/U1JZHi3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9DCD1283;
	Wed, 27 Mar 2024 10:44:51 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Date: Wed, 27 Mar 2024 18:44:00 +0800
Subject: [PATCH v6 2/3] mtd: rawnand: Enable monolithic read when reading
 subpages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-loongson1-nand-v6-2-7f9311cef020@gmail.com>
References: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
In-Reply-To: <20240327-loongson1-nand-v6-0-7f9311cef020@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711536289; l=2162;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=lS2LSZ/s5Z4DeAh+vHqnlTAlI1Wu1nzKK/BPFHeBtfc=;
 b=jswAkTrM2ib8XVP9hzAqLEdJrjizPymy8TfvB7eIXISh60W8V0vf2sTb+pWo5AXZDxYFqVxq0
 TOgwt6PbWkYD9qEkmXxlJXaJWaV/TZCv+eBZKcqpxkLIwTTX4oWrFmH
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



