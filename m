Return-Path: <linux-kernel+bounces-98101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0CE877527
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 03:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29153B21110
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B01381;
	Sun, 10 Mar 2024 02:28:44 +0000 (UTC)
Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679B10E9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710037724; cv=none; b=D2BtA9xK+217i8rZ51dqisx2zDSu59gq8Ya05hdVbrAHPXCoILg+qhB/AiSM0PfCHSCd9Fg5aVxDSKMu07gv7bz7T05Ue5slD6Qfjgf3M2YceJA05wsjrbmUZZiyFnfSPF9NhECdjX9M5/ZycFlbR/Cljxg7P/pGnPueovyKZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710037724; c=relaxed/simple;
	bh=IX40CDGHbzLqJdPoJ3o3l2pH8QInHNKHlTJHgLVt5Gs=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type; b=g591IaHApa3FVSvQZTHglehYKQFPtKUDJJeKB75tMh8Tc/7InsqsEMizT8aZ3JnUk8sbLwN70ApTKOowUeDhoCdCi3RH2neNYkUh2v806e1PL2n1lwfBYRpUsN8BQJ1DFz8/Jt4WrdMMHNd2KG3qYIubdCIQthEWGWTWiFibyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=none smtp.mailfrom=jessamine.co.uk; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jessamine.co.uk
Received: from webmail07.plus.net ([84.93.237.82])
	by smtp with ESMTP
	id j8sWrrj4b7L1ij8sXru8X1; Sun, 10 Mar 2024 02:25:33 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XP2TShhE c=1 sm=1 tr=0 ts=65ed1a1d
 a=k49VtrWLZTL8DnM+6AvpWw==:117 a=8YZdF9bm7lDkcydB81w8Xw==:17
 a=8nJEP1OIZ-IA:10 a=K6JAEmCyrfEA:10 a=ZBkl__CYAAAA:8 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=VdYuLKcatEhD6b8jxZQA:9 a=wPNLvfGTeEIA:10
 a=d6WIyDdLbVARuAyufDlf:22 a=AjGcO6oz07-iQ99wixmX:22 a=ST-jHhOKWsTCqRlWije3:22
Received: from [127.0.0.1] (helo=webmail.plus.net)
	by webmail07.plus.net with esmtp (Exim 4.89)
	(envelope-from <adam@jessamine.co.uk>)
	id 1rj8sW-0002mW-1J; Sun, 10 Mar 2024 02:25:32 +0000
Received: from 84.92.42.80
        (SquirrelMail authenticated user jessaminenet+adam)
        by webmail.plus.net with HTTP;
        Sun, 10 Mar 2024 02:25:32 -0000
Message-ID: <a94544be59233be694b317df0a8cdeae.squirrel@webmail.plus.net>
Date: Sun, 10 Mar 2024 02:25:32 -0000
Subject: [PATCH] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
From: "Adam Butcher" <adam@jessamine.co.uk>
To: linux-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
User-Agent: SquirrelMail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-CMAE-Envelope: MS4xfG45LlQwTpDapLjLb9xgU+P5rCIm5OsNZddcGfFY3FSc+Qk5CT0M3U4IAl6emDH+euMHaVQFRC6OX+GXYrBR3uPrMFQM50ybUc3RyABtkkEXp9w3C7pX
 I/crLoThllJRckZS+RHfl7kymSQxf4JtthDFWk8s7YuZrnMDRpodaGpywKP6F0L1bmvpz5Nw5q4M5Gqs5biPmYD8BO2bvD7nUSg=

From: Adam Butcher <adam@jessamine.co.uk>

992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
corrects three cases of setting the ECSPI burst length but erroneously
leaves the in-range CPU case one bit to big (in that register a value of
0 means 1 bit).  The effect was that transmissions that should have been
8-bit bytes appeared as 9-bit causing failed communication with SPI
devices.

It seems the original patch submission up to v4 did not contain the bug.
It was introduced in the v5 update.

Link: https://lore.kernel.org/all/20240201105451.507005-1-carlos.song@nxp.com/
Link: https://lore.kernel.org/all/20240204091912.36488-1-carlos.song@nxp.com/
Fixes: 992e1211dc91 ("spi: imx: fix the burst length at DMA mode and CPU mode")
Signed-off-by: Adam Butcher <adam@jessamine.co.uk>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7c1fcd5ed52f7..100552e6c56bc 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -743,8 +743,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 			else
-				ctrl |= spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
-						BITS_PER_BYTE) * spi_imx->bits_per_word
+				ctrl |= (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
+						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.43.0




