Return-Path: <linux-kernel+bounces-48212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8DF8458A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9571F2801E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737EA53380;
	Thu,  1 Feb 2024 13:15:48 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293D5336F;
	Thu,  1 Feb 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793348; cv=none; b=W375kFv3MEWG/01oUL6RUlX4oZdzirBmetHJD3/hyK8tm/nVWCTE6hpCZe42fhZkF7b3H0wdtVOzFS2+dlDSa5CObK/yQ5HBrlqmMEzH1hlvQLl3oNJNR/c4tjnwoqtzkHLC1CEj3fzoT5TWsbZQPvsF7UnFakr8o2ZXNNVH9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793348; c=relaxed/simple;
	bh=CN3V6/jyU6TYc7JhVGapD4+ahcpnC9dXp60iMREooAc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MQW3wLd06wODxi1t8ZCU6X3XTGvd6BTQ11UEe1WqKpn2VILa6uaBWY9rPijXA8QCqVDNdmYbSH8CF13pEyE7P2xTRGEt3+IXYy/Ft9UCiMvhMXDOXEcAxJCDlBkHsWtz5qwso7JOv9V76zn6Z4aK7MWvP2MQ+1kzzg5libIot5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 8D3E06EF8E;
	Thu,  1 Feb 2024 14:15:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id d--Q9PqJXrM2; Thu,  1 Feb 2024 14:15:42 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id 7A6BA6EF20;
	Thu,  1 Feb 2024 14:15:41 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id 0BC85469; Thu,  1 Feb 2024 14:15:40 +0100 (CET)
Date: Thu, 1 Feb 2024 14:15:40 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ray: beware
User-Agent: NeoMutt/20180716

There was a change in the mxs-dma engine that uses a new custom flag.
The change was not applied to the mxs spi driver.
This results in chipselect being deasserted too early.
This fixes the chipselect problem by using the new flag in the mxs-spi
driver.

Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")
Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
---
For oscilloscope screenshots and a verbose explanation see my blog post
at https://blog.runtux.com/posts/2024/02/01/

 drivers/spi/spi-mxs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 1bf080339b5a..a296050c8bd3 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -39,6 +39,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/mxs-spi.h>
 #include <trace/events/spi.h>
+#include <linux/dma/mxs-dma.h>
 
 #define DRIVER_NAME		"mxs-spi"
 
@@ -251,8 +252,9 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi,
 
 		desc = dmaengine_prep_slave_sg(ssp->dmach,
 				&dma_xfer[sg_count].sg, 1,
-				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
-				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+				(flags & TXRX_WRITE)
+				? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | MXS_DMA_CTRL_WAIT4END);
 
 		if (!desc) {
 			dev_err(ssp->dev,
-- 
2.20.1

-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

