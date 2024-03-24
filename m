Return-Path: <linux-kernel+bounces-115243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64371888F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573B4B24D64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17692313E64;
	Mon, 25 Mar 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhy6Nzjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056422D8B0;
	Sun, 24 Mar 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324342; cv=none; b=IONnZBOiR2PsT0U8c0wd8o8TPAbtF5Ul0h6ZbN+EdKyKwTx/Wk9nDCe2G/n264icR48qvpH4+V67Ldu+53HjMBrKX6JSbdMcFPGtrEOgnnrlq4UEwcgziUGFJBgRN/UwAZWOCp8u9V9+oc55Plw7fsiOQcoXFPgqORdJ5zI/3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324342; c=relaxed/simple;
	bh=LMaHUsLZCx3wS/MdEVXY4na3Ng6kslGf1QlQOmafudU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlrjfLXqDbmScAZI+tTKCFZQFZp2mzgzfMRSM6bsS4JF+BAQVGiO24jekn1YjWFFNfOheMxwDlGMLNZ2Ky9qCjtmWCY/F3EyLGQlIuPlMrWlY/HIrFOkQUB9zBpULDWNKdlTIEs1gHWPc5Uo0r8c1sGp8ygSNpDrUu2KiB+Qp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhy6Nzjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782A3C433B1;
	Sun, 24 Mar 2024 23:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324342;
	bh=LMaHUsLZCx3wS/MdEVXY4na3Ng6kslGf1QlQOmafudU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nhy6Nzjd2tzXpUmABLU6zptE290DRP2VM60zR3CoRJIYpsMtwrDj15rNeQ7CI3/yb
	 sBPisFXc9IBGyKAhc/TQL1Q7CfeJZF0IOQYI8jfqbMHdjNRd/zSMjHCmSWZnRebfjD
	 xCXilocUX7MW3rE33OLRdkUm4VsWimHF776qe1IAnQcSqM5g6xETZWyrm4ahkC+bjT
	 oAITGGDHu3bbnYDgTizE7HBPADpp/NC4/xbtP70RKB147ewzsLpQ7gBs7HmZvlayOB
	 bZT0jSlrPr+jSWXxaaXiYgxuaXOzWb6glFFCHVN/HL+r8Uw74wCKvGNfiJEfFG1n11
	 p5O43cDWsGhKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/148] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 19:49:36 -0400
Message-ID: <20240324235012.1356413-113-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 347b828882e6334690e7003ce5e2fe5f233dc508 ]

clang-16 warns about mismatched function prototypes:

drivers/mtd/nand/raw/lpc32xx_mlc.c:783:29: error: cast from 'irqreturn_t (*)(int, struct lpc32xx_nand_host *)' (aka 'enum irqreturn (*)(int, struct lpc32xx_nand_host *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Change the interrupt handler to the normal way of just passing
a void* pointer and converting it inside the function..

Fixes: 70f7cb78ec53 ("mtd: add LPC32xx MLC NAND driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240213100146.455811-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index d240b8ff40cad..507b2bd58f734 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -316,8 +316,9 @@ static int lpc32xx_nand_device_ready(struct mtd_info *mtd)
 	return 0;
 }
 
-static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
+static irqreturn_t lpc3xxx_nand_irq(int irq, void *data)
 {
+	struct lpc32xx_nand_host *host = data;
 	uint8_t sr;
 
 	/* Clear interrupt flag by reading status */
@@ -790,7 +791,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
-- 
2.43.0


