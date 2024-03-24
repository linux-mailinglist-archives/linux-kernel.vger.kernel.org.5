Return-Path: <linux-kernel+bounces-114875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018E88891E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86761F297CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC82CB3E4;
	Mon, 25 Mar 2024 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK3KCgvo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B221C170;
	Sun, 24 Mar 2024 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323519; cv=none; b=opRf3CsWRaF0XMdFhpxJ9FrvPf2FspRA+G89DrQDDd/CdqPlS58PkmqFhus/QpPnO/W0myDRzNTgMP7+dwNucKR667UA35+OH2Q7XTr+5skP+qJ/GlPxn7VubNEI0M9gFm9aWhbrJV9koSzvp86Fvc4IJJVSbxtOFPILmwMFv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323519; c=relaxed/simple;
	bh=a404h3DZ8kzeJTl67XyP9R7Nn6wjyD0ElQOcRCs+PRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geOhwdaodyu/ySAXi4zvDLHqixbNaAureaAOSNWXdDJYTlJ6500pp2cy78vZfzipgg4l3V8aiS3B2N/LbTnm0w/Xd6bMPWurGk6AJqfkwJLMAGVWYRIpozYruQSbzu03mORVm8RjznRUdaJsdeDAkLE8M4pGWYaftD9FXtgzZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK3KCgvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7170C43399;
	Sun, 24 Mar 2024 23:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323518;
	bh=a404h3DZ8kzeJTl67XyP9R7Nn6wjyD0ElQOcRCs+PRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK3KCgvoQVuP3LnSVMc7kXfFoCBHau9FlvX2OX2Kn+CnzI+9cGma6QC+XRiz6K+1h
	 c0avRsZnFs1QTiME3uhBjd5LBbesQv7Qwr2iMf3CeCdgYQjSOBknQ3eZgG3xtV92yE
	 BVlSXK7tOaAj1577D4dqngtHjST2GwBG/9sTNWUPf/CpFuCodHn1zGLiFXYIteYH/I
	 1koQASVLTboSG79h1jRfxCVUVuvKMtAEv0bjGhb/ybKUYPUiaLtMmhfNzSmeUdQX6d
	 nQdBY7bZ3dD9Te/DCweNCzDf8pFnupNRSLUeDL/hv9cjZnNQih98f5c4/sZZ4d2fu+
	 csZBwrzE++zjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 225/317] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 19:33:25 -0400
Message-ID: <20240324233458.1352854-226-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


