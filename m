Return-Path: <linux-kernel+bounces-115135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB36888D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F8428D65C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022CA1C6FE3;
	Mon, 25 Mar 2024 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOqsvwZp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C2229C04;
	Sun, 24 Mar 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324134; cv=none; b=jTLPivObf37tvYzjBqeYnSJdGfeao1CuYKsUKeknlZIGIyHk9QICzYNTJEiYnZZd95NcdQIMiSws1LGnJsgmQNO2ajRDhgy3gRXZd1P/NpzT6pqZnGah2ustcCCACLbZWtP6EzZ27PR2c0xH+ysKN8UCXbm1Yxgol6Tsrp2zkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324134; c=relaxed/simple;
	bh=AzJDd6RMY3BBgLb2b4nm2mnDH2oSiiGl+bC7buMZM0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjQm6kSUhhm1xmTnG5oI8VN4LtYGjdds/Hjxfo7pNlRA0Bmm9Y39xpcAhydCHQhyAjiOVty3/W+g/sUicCMIVEqdFp878H86Afnz9cVXJjwruoD3w+GG/CcFs/VgbZ7fmpcAxDPedpiZM8kuAVfF7O4zOUQ/dR49NgzvYpZDixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOqsvwZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D121C43399;
	Sun, 24 Mar 2024 23:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324133;
	bh=AzJDd6RMY3BBgLb2b4nm2mnDH2oSiiGl+bC7buMZM0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vOqsvwZpoHeh+O/+jDgX34Hfhrf2vySlYNhGh5Ga+PW3uyhe3gGq1oir+ynurA95u
	 2jjDezagnGwdjoLgqwzoNjPLEskgdr037ExRHJPp+YskhGMT/KoGnvjywzogjyWyM7
	 5WpDK/H89uAvBQYEHMZ70Z+fFvv+JED88T+xHY/jCEZCQahcH8+idVGerVv6Dy5XMv
	 /G28JO+FZqi3QxrHghfP0F0WCjt+wmDoo1I0ddGv0qwHLrfIClc8Vun4HAI5b7Dxa9
	 mQoRL/HGp7h/Bp/Y/WM1EZAweUoHnrpVuFsQynUuGWG8pJJBfnrfB9lHgj7mEoQtRe
	 MmoqzpO9GgWAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 130/183] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 19:45:43 -0400
Message-ID: <20240324234638.1355609-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 78b31f845c50a..a7d0a76eee7f4 100644
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
@@ -778,7 +779,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
-- 
2.43.0


