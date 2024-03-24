Return-Path: <linux-kernel+bounces-114450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F25888A88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F8328C923
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB213179FAA;
	Sun, 24 Mar 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI/+qOee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACA21F9EE;
	Sun, 24 Mar 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321877; cv=none; b=adDlBVHZSB09ttu9ZmnGVmX6uzdyCzVgwFVoT1z3cOXs0e6lZOCJqE45FaPZzqJ+vWeXX3SWo6/L/PFOEbpRn7njmjAoGP1uQ48j6drmPE1N2hP5eLZ2oar/qICTKw2b7OMrH+uPO/WpotA2k9tYt4met+bPgCi+vzRUbYwiEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321877; c=relaxed/simple;
	bh=a+19uE9pstQ7kpZpoBubeHqBkGRUhM1ZZ2pWPXDeJAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0mIcLcIkpPIllKtBAwPD+Gbscm1fTSXIFEMEjaBGlpjrKHifmRgoJvbdKosP1TG54m6slE+8Thp2t/iFIXOwuTNSKWQizgDvAbqdLKEr9lTajuKOAZhdmr61UvG/ccQpk2iBL0JI+tmAXaKWErzcpd9vUKkVzvYLDi03wCm6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI/+qOee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D415C43390;
	Sun, 24 Mar 2024 23:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321875;
	bh=a+19uE9pstQ7kpZpoBubeHqBkGRUhM1ZZ2pWPXDeJAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RI/+qOeekBohK6/hkaXhUchtXmmGTBHifIN+ViVnUgfIb2lQKwDrLz0yyxQxSAIFF
	 FlK/tOWSbxkajesLvP/IhF9SPXK4le2lIdy8gY670vDMc0Rv/SE2ojYu7XfERmRUx5
	 7Tb5GzXk+a9NrCSupk6X8iDS9DEkMXsOMuHM+YP+gzKLcv9iQGJExZlRHiB7lwfXXH
	 SijIDsJYl91bc7alg47Tc8JnkDHnRDRNY2HeCXb+ybfGfrKNztGNJLueYaYpI8ZHib
	 ByKkN9aIkP9HbEm+MxBtj4V6f4d/F/3reCJSEiqIYfb23aBw5D/sm+yvjJyAWjZn9j
	 +nvCVBPSIc6tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Butcher <adam@jessamine.co.uk>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 604/638] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Sun, 24 Mar 2024 19:00:41 -0400
Message-ID: <20240324230116.1348576-605-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Adam Butcher <adam@jessamine.co.uk>

[ Upstream commit cf6d79a0f5769b5f4d9579ddaf88d2c30b03b873 ]

c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
corrects three cases of setting the ECSPI burst length but erroneously
leaves the in-range CPU case one bit to big (in that field a value of
0 means 1 bit).  The effect was that transmissions that should have been
8-bit bytes appeared as 9-bit causing failed communication with SPI
devices.

Link: https://lore.kernel.org/all/20240201105451.507005-1-carlos.song@nxp.com/
Link: https://lore.kernel.org/all/20240204091912.36488-1-carlos.song@nxp.com/
Fixes: c712c05e46c8 ("spi: imx: fix the burst length at DMA mode and CPU mode")
Signed-off-by: Adam Butcher <adam@jessamine.co.uk>
Link: https://msgid.link/r/20240318175119.3334-1-adam@jessamine.co.uk
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e2d3e3ec13789..0e479c5406217 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -668,8 +668,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
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


