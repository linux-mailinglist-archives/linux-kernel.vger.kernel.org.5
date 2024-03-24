Return-Path: <linux-kernel+bounces-115008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A7888CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA179B2E875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426071C0C3D;
	Mon, 25 Mar 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ8CzP7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434828454A;
	Sun, 24 Mar 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323791; cv=none; b=bUdqDlPZlxf7+HKU+Ro1D1sSKeCySM2TzloAVQ/L2YR4pF9xJrp7sEzdRoRuMgUm8i5exHvlKQtfWcZ5486IxZzHtb33h6lL8IVc0Y1/j4//xmyfvM673exn7XXy1yTghsJfV94jLnSJ6ckNpgLteIzc2NR0y/Pd5AwPCchb6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323791; c=relaxed/simple;
	bh=hWuy88Aup0z4nDe0WYD7we1a5sPl/yK3MAGontcn4X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpPcxBLfxRqwRpjCCjsF1Qc3QbecKeSYaRdt462s01w3MkyO1tm1esd7vj+BFXzMVlx6qKM3Yiyd/GaClvjKcKN5boSlHSbk3ipPpQQhRYYX5PYdEzPtb3gUHCsE1oQbvHmjzJq3o3MAkGrOiUnCvaET3qa4biO/812ulVDibfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ8CzP7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73601C43394;
	Sun, 24 Mar 2024 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323791;
	bh=hWuy88Aup0z4nDe0WYD7we1a5sPl/yK3MAGontcn4X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQ8CzP7zp/eKbgQACD/YebEl+SI4UkpZCL4KeqpRk4Qq/ARFUtzqlbDGzr+pjMHIh
	 oddRkxx7Ynb/j3gsgp2PZ/Ni9Uo75W4owPdqO7x/fDoKrEI9YRTlM1DFD0AV3JKLMk
	 ikUvk4KyIEgMSOGdfGasyD3IosxuueaMYPsn7CT9zIfGT0rnmTkF1ME6kz9oIFgLT6
	 bYTKtO5yuY2xoBAg27sI8zcX8USuU5qrjCh640/4NZfbnRYky4IFqAFm5EHB/NKgU5
	 6z5JwYZBPKrx7OLh4ZparBH1/k+ZYD5CAv6J2VBmvUHR40vYwmcC7RB6/B60txyZQk
	 +bZdbDqWGAYmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 168/238] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 19:39:16 -0400
Message-ID: <20240324234027.1354210-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 9e728c7317956..db228460a9079 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -304,8 +304,9 @@ static int lpc32xx_nand_device_ready(struct nand_chip *nand_chip)
 	return 0;
 }
 
-static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
+static irqreturn_t lpc3xxx_nand_irq(int irq, void *data)
 {
+	struct lpc32xx_nand_host *host = data;
 	uint8_t sr;
 
 	/* Clear interrupt flag by reading status */
@@ -780,7 +781,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
-- 
2.43.0


