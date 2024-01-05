Return-Path: <linux-kernel+bounces-17929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883B825540
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642611C208C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258152DF66;
	Fri,  5 Jan 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="syUyhaoa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215A2E3F2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Ll4Hrrgt1MVYzLl4HrM73m; Fri, 05 Jan 2024 15:21:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704464463;
	bh=RJ0XWALe6dWfEg66EbodA9CZbiV+eRkv/NLl4ru9Z8U=;
	h=From:To:Cc:Subject:Date;
	b=syUyhaoa2h1ABWLoupqzMOv8Yal2V2vKDFqdExiIscMRhIz7XJ0bsiUa/vRL9Wj7+
	 f9zpy9Gk3E2Ft6MuJxLVm6acvXVWAOPi+s4EJw5tVmmKCsLfpeT8YCMCYTW95sXnIc
	 JvI8+m1rDDS8pLWrU8iwqoBdPYwA771oeY/2/4bBt6KTVvwYIIyueWFk1hiYBVCZUM
	 ppsW3YP3En6hlfcIX2PVcGNpUuQ2BsSNMjJVJSgHrR2AR5G0tSveuAa1MKUGTPu1wW
	 GveiACXV5sjetNMh1wTkpdddQtGi3E7718tuf+kjoi35WqkCmH4PdZa8wGjk9ckcZ9
	 YE4bQrkdUqRZQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 15:21:03 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mark Brown <broonie@kernel.org>,
	Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from the remove function
Date: Fri,  5 Jan 2024 15:21:00 +0100
Message-Id: <6670aed303e1f7680e0911387606a8ae069e2cef.1704464447.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit in Fixes has changed a devm_clk_get()/clk_prepare_enable() into
a devm_clk_get_enabled().
It has updated the error handling path of the probe accordingly, but the
remove has been left unchanged.

Remove now the redundant clk_disable_unprepare() call from the remove
function.

Fixes: a90a987ebe00 ("spi: use devm_clk_get_enabled() in mcfqspi_probe()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-coldfire-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index f0b630fe16c3..b341b6908df0 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -441,7 +441,6 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
 	mcfqspi_cs_teardown(mcfqspi);
-	clk_disable_unprepare(mcfqspi->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


