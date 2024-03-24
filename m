Return-Path: <linux-kernel+bounces-113369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E908883C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E831B24921
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1719DF4C;
	Sun, 24 Mar 2024 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox3PRS0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8A19D8D1;
	Sun, 24 Mar 2024 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320170; cv=none; b=hea736+YSpGxMAru/zbKnTB6lQ3TqYtbVETVtzWUevDkYZvv4IFoRQvgOYSFtKPQydrwLrOjbfOa4MDO0KBwPwlGr8hP3K4ijXDFeiVvUBmvCNX0/ld3m/hKA7W9XqJIOuIXXDlUpr8rRgmt0+L2vJ+fFY71VMFH8XpDjuYn/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320170; c=relaxed/simple;
	bh=88D2h7ESbBu8z6z2H1BIcpBwdPI4hxWEwZy8Q42aC84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODhz3M7rudrOaH/DVNStMwtJdqBU6ZB3f3YMYR3ZnZQKLjtkQJCLbASVzQO4QOc4ecXF5cWumSDNUVUCmvh1aQNb7w342UF5l9vadQyEClCzrWv/TJOrRiI/ANitIZqx/fHN/5TKPdZ/+MtmF3nr7BX+LHswmUbjvR6u6JTcdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox3PRS0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD3EC433C7;
	Sun, 24 Mar 2024 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320170;
	bh=88D2h7ESbBu8z6z2H1BIcpBwdPI4hxWEwZy8Q42aC84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox3PRS0g1PNlFGBOMynOKaveZfiHinz1Kr6HNGtkpc7nKJHPvjKaNzqZzX0lm4LoD
	 OIsYYsz7bRbnAaKOxt7tNB3T+6HUuWJJa/eyEmMEXbxTl2c1IV97ers+kq6rMsXtfH
	 42Ti7432qB/4ahqTSw1bzRxV/H1ZCMCmWSUgpK2GfYlfWZtPTQMC0aWITYw8ZzjwHC
	 fAb3VhlXuunKbYUBO22zjBNs6mt35C9i53OUjny4QCScHPxE+r3ruUoZenlcwJpOXc
	 lakjY7iNuZmHs/O1kM+nfyL1laAUTXZCzFuTK4+aWspPzJzYbEZk1dGA4QMj78dcZM
	 eNCftgA0Npl6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 478/715] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Sun, 24 Mar 2024 18:30:57 -0400
Message-ID: <20240324223455.1342824-479-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 488fd452611a6..677fcb03f9bef 100644
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


