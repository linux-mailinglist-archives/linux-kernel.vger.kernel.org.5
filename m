Return-Path: <linux-kernel+bounces-113984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61818887C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4645EB23D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC922190A;
	Sun, 24 Mar 2024 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLoxsz0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D112D21C;
	Sun, 24 Mar 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321114; cv=none; b=kiDEYyuIcTiEcT+bODwVRJADbrrNhR8wMt0uTECpO0EBxRzjgQ8U/+SBlvvkU7Qb91/JZTFVD4IqFDkib4v8qbdGUVMS6ClzJ+2jCw41FVhCrNq3LZG3F/Vp6LFmHk+K/CE8O+7y0t/HzoWKy8uIGwRhV7fB1aG9w07TyFaZXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321114; c=relaxed/simple;
	bh=a+19uE9pstQ7kpZpoBubeHqBkGRUhM1ZZ2pWPXDeJAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke8sq+lhpIzhyGwgYdLPKNVHpybVWuFaFzG1xDs7EHL9teY9pPnU5n50aGEtAtDSfSyFBT6NsgyepmyXSoHxJZJmMpB1FR+ua/S/mPtGJAhkKn2jwjuuzS3emhY5kWvYiJrAY5lishEGhf4+YQnZxNWshT1vJxHRchJmlzQ0gg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLoxsz0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F20DC43399;
	Sun, 24 Mar 2024 22:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321112;
	bh=a+19uE9pstQ7kpZpoBubeHqBkGRUhM1ZZ2pWPXDeJAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLoxsz0r7fAI2YC85fdikU2FdLZIqBPldixTW//iFgD5ZJnsS2+EvYN3bs19dU1wI
	 aWbru+nqGkNOcb386ccae4r70jbX40k9Y7/vVUfNr0DnJQf0vfv3rSDDrEiagwGFWc
	 YD8UPFboUnTs98mpvvsKRcM8LnWoUUlTZMtFXJelaXrgGeTZ/qUuQ4ZIEAVep/qpTo
	 e2aLTMERnnB8Zo2arqLo8Uu5z9RrShtW4KLTzNRvobUqOGtRkycb1fKSUK8KcNpRER
	 DGnmKWlkZDWdSFLU9ewpeF6MJSKFjM5bj1Mg4AjPwfj9aRxgfvUOydTWuW+vUgiSyK
	 B7npK/1f8u3Ig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Butcher <adam@jessamine.co.uk>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 675/713] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Sun, 24 Mar 2024 18:46:41 -0400
Message-ID: <20240324224720.1345309-676-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


