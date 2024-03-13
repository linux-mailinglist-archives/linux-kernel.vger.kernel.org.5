Return-Path: <linux-kernel+bounces-102341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11887B0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096171F24A90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313796CDD1;
	Wed, 13 Mar 2024 18:17:13 +0000 (UTC)
Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6716CDA5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353832; cv=none; b=rWu0HO+/LquT3TEkW19fH+zLMrcHWAuni3pTWiN9vfRr8mGgo+XC8//qU8ALXNwq4vz7VnZbvanqubhsWgDyaq5DwQ9ZUaH8tPFsCAx0eK8XJ3Y2YqNkUQGeF3WRqQMGs7tRK3cQPNFH8kaspb3KpYctyfnlPiH699cQraSUZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353832; c=relaxed/simple;
	bh=/ynVUGcijeIjfROVq7PRXn35lD8jorRFN6NALcKHW9M=;
	h=Message-ID:In-Reply-To:References:Date:Subject:From:To:Cc:
	 MIME-Version:Content-Type; b=ebGUOpZu4tZI/VcTz7iLcFrYdFIOb+bdqHzZ2Jga16kDiWjhrKbqM/d4V2RChK47xul/IPU0JvI5jmbmFMGRA95fivsbdefpyaHdBQ3i8PT/GfQiL2TL5+ZxIRZzG37PqoyoyMIrke74x4enXfC4bzfSx5mMqxKUvMESIQx+JKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk; spf=none smtp.mailfrom=jessamine.co.uk; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jessamine.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jessamine.co.uk
Received: from webmail07.plus.net ([84.93.237.82])
	by smtp with ESMTP
	id kT6wr5aKcKQLgkT6xr4ZkU; Wed, 13 Mar 2024 18:13:56 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JtdSr94C c=1 sm=1 tr=0 ts=65f1ece4
 a=k49VtrWLZTL8DnM+6AvpWw==:117 a=8YZdF9bm7lDkcydB81w8Xw==:17
 a=8nJEP1OIZ-IA:10 a=K6JAEmCyrfEA:10 a=ZBkl__CYAAAA:8 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=VdYuLKcatEhD6b8jxZQA:9 a=wPNLvfGTeEIA:10
 a=d6WIyDdLbVARuAyufDlf:22 a=AjGcO6oz07-iQ99wixmX:22 a=ST-jHhOKWsTCqRlWije3:22
Received: from [127.0.0.1] (helo=webmail.plus.net)
	by webmail07.plus.net with esmtp (Exim 4.89)
	(envelope-from <adam@jessamine.co.uk>)
	id 1rkT6w-0004xq-CB; Wed, 13 Mar 2024 18:13:54 +0000
Received: from 84.92.42.80
        (SquirrelMail authenticated user jessaminenet+adam)
        by webmail.plus.net with HTTP;
        Wed, 13 Mar 2024 18:13:54 -0000
Message-ID: <41a7e7e46baa40ce28ad0dcb2ee455df.squirrel@webmail.plus.net>
In-Reply-To: <30b2a315b36e1ee16c0217b32b95a605@jessamine.co.uk>
References: <30b2a315b36e1ee16c0217b32b95a605@jessamine.co.uk>
Date: Wed, 13 Mar 2024 18:13:54 -0000
Subject: Re: [PATCH] spi: spi-imx: fix off-by-one in mx51 CPU mode burst
 length
From: "Adam Butcher" <adam@jessamine.co.uk>
To: "Mark Brown" <broonie@kernel.org>,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 kernel@pengutronix.de,
 linux-imx@nxp.com,
 benjamin@bigler.one,
 stefanmoring@gmail.com,
 carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
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
X-CMAE-Envelope: MS4xfJ/HiBvFrqoc6yzrxa12l12e8Z9iHnxHbPSPCRKDs7g1raAnUiG/+3aDW4v9Qr7pj/zkjrfgjAj7eMVaqXweQufriTfeVj7UkX08FlQUEFTPkR7ncHGD
 mvq1PLNIIIrBraF1L0EwMjIqGy09R5iedDcn9nalQHbRbl9lrFv45khvM02Y0nsm8DluL1UEbW1PWBgrYe0CxOAPGw5En3qET0o=

From: Adam Butcher <adam@jessamine.co.uk>

[Apologies, rubbish mailer corrupted the previous re-addressed post]

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





