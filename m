Return-Path: <linux-kernel+bounces-114590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6E888B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4279291A75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2CC29D38F;
	Sun, 24 Mar 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGocbP2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6952310CB;
	Sun, 24 Mar 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322238; cv=none; b=RxdfzkMbb8ld5mi+vOcMxauUjhQmb31e7zE5tCQOqyEpSGeTWVpjR2c3QHfmXhRVsb9FpDr4l6G2J2s8ObC9+fFK77f8wwBKSpgRFJrSF8lfbFUG24nnQ+ZR6VrW981eWED+G5voZUmlZ6rz45Z3AVM3eNDuv8la0boPJS1tyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322238; c=relaxed/simple;
	bh=a404h3DZ8kzeJTl67XyP9R7Nn6wjyD0ElQOcRCs+PRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRID7zy39zl9eFDLHTu/wUyXm1qyUGMUWbnryuGApBTp7x6kYtQcUwnPnFlE1JWdCOcUc+mpDkQT8nvt6teNzDoBqC0pTCSOYNeEl+3vZfMlg6cr28rw/KxAyXrjRgXPJwMcn7F/CeyIpEibZJbsUZ9iY3LrudlOvOmgkX469Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGocbP2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDC8C433C7;
	Sun, 24 Mar 2024 23:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322237;
	bh=a404h3DZ8kzeJTl67XyP9R7Nn6wjyD0ElQOcRCs+PRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGocbP2tZdI4qbsBILnY3LSSTeQmMu7QJYcqSNsQB1UX2fKRd8bmQmEevYwmr3WqV
	 vcYoajKsiXrm4QPYIm8X3xQx3pzijvRVrsjTysZusAncbZOlrT33spTGrpCksZOfG4
	 at1CsQe1kN4lOYyxbXqb1L25GacVY/yTKGHOx8aixJCThGAboNrnimvy3ssCngMPCJ
	 JFIHGu27t2VN3af1BuTQXoEc5Fy2aq8L75c2TEGLHKNjH9IV8ZHehTiBT46nLdH/zV
	 zgyErwObcpFtfGDz6SIPL4L47D8BC29YVG8ctsmgCedIKTCqC580JssKVCZkjsLALS
	 1c1Ri6kbldw1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 318/451] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 19:09:54 -0400
Message-ID: <20240324231207.1351418-319-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 452ecaf7775ac..1cfe3dd0bad4d 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -303,8 +303,9 @@ static int lpc32xx_nand_device_ready(struct nand_chip *nand_chip)
 	return 0;
 }
 
-static irqreturn_t lpc3xxx_nand_irq(int irq, struct lpc32xx_nand_host *host)
+static irqreturn_t lpc3xxx_nand_irq(int irq, void *data)
 {
+	struct lpc32xx_nand_host *host = data;
 	uint8_t sr;
 
 	/* Clear interrupt flag by reading status */
@@ -779,7 +780,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 		goto release_dma_chan;
 	}
 
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+	if (request_irq(host->irq, &lpc3xxx_nand_irq,
 			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
 		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
 		res = -ENXIO;
-- 
2.43.0


