Return-Path: <linux-kernel+bounces-63298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB133852D66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A4A1C21089
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4E374C9;
	Tue, 13 Feb 2024 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czb4jvH3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23F37152;
	Tue, 13 Feb 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818515; cv=none; b=VSX2WmivFhPV5hL2ET3PyJWgzIwKttyjzMoPCvGSPiRE64nllGms11eHDhO9V8Joyc6lJwPnV4RwvCvt55i/YZwvEtHn3+kUiFkmPP93Czd631dKi1J3AZGjPVzv9g/8Cn5qqk7SxG6lPlTaENhSQsmOXuOLTVOOUMVMyAOTkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818515; c=relaxed/simple;
	bh=UU+zpA7I6z15NuI2JwEPZ/xh+eLMAyrqwwsqp31LEJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gO0thIpzbGuqxH0YGeZoLGtpmVCKi30BlMapNiQcIU8nL1nVyUF4lgLODoQG3JrAcWeza4ydj6Nzg7O3LnEvCGBD7Ah/QeHBxrD3mVnEOsYgn1y6qBKPuVXGMNmVJqnssQSeOtPgfb8fv3lOMeKGeXM1XVQq7batcayPFgkNGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czb4jvH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAECC433F1;
	Tue, 13 Feb 2024 10:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818515;
	bh=UU+zpA7I6z15NuI2JwEPZ/xh+eLMAyrqwwsqp31LEJg=;
	h=From:To:Cc:Subject:Date:From;
	b=Czb4jvH3IBvNqc4VVgfDnGhlWAHmrbg0er9XeuGRTRJyBYbX1aLruGawaJ/efSjbN
	 hvx3wypXmh45CQpK34csnhnhCrGdyiVZ5watoCo/kn1e8vUUhAPsI3NPdZqkhsqPFR
	 8LjDk5B483FVmf6LNZ3ctHxF2AwjQ6F4cgKbjl1YUdRG1KKMLi2rHQQFpxbv/lK121
	 qZUlVKOoNld+fAIHMdg1qe/44wJjux8c1gsbpy6uIVATHgdLsb8aIDVSext6PzV/rB
	 A/JqmINItFaOMmStnFRpOTMhI+s5xGAvrZUaZ5g6Alg0yCBFdWEjiwqnqj/hJSYd18
	 SfSeF0dZ3x38Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Roland Stigge <stigge@antcom.de>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Tue, 13 Feb 2024 11:00:09 +0100
Message-Id: <20240213100146.455811-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about mismatched function prototypes:

drivers/mtd/nand/raw/lpc32xx_mlc.c:783:29: error: cast from 'irqreturn_t (*)(int, struct lpc32xx_nand_host *)' (aka 'enum irqreturn (*)(int, struct lpc32xx_nand_host *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Change the interrupt handler to the normal way of just passing
a void* pointer and converting it inside the function..

Fixes: 70f7cb78ec53 ("mtd: add LPC32xx MLC NAND driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 488fd452611a..677fcb03f9be 100644
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
2.39.2


