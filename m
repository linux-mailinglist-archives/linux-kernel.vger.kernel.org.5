Return-Path: <linux-kernel+bounces-113566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E23888559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48161C24ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945E1C7387;
	Sun, 24 Mar 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Gqucvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E271C7370;
	Sun, 24 Mar 2024 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320368; cv=none; b=Gh1aPYyPYVBsS3NQ0KQpzbhNmJi2ilKB6GB8bOcFhR/0Uzph/kKBqTrmPBxEacddoVj2s50UokLZfi3eqdYYXjn4YvKPSrr5gamc/FmL0TkbZAVH8RWzbcihygpKshci2OdOwTiIwIL/NhygXXxv667a6Lz6GaVK6lHBeMu+j5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320368; c=relaxed/simple;
	bh=bkGq9iUT+nnPa7tdEFRqKN4z32Q0SFoomCET4P7d3/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2arp9ae5T1TPgPVTGeiKq7rg6mI6o+uQ6eiDmsz088f5nsqgkCGJBwTuqCqpewDoJOwt6Wx2KttRdDQv2/qfCPKG7g/5u2GWkLAxDh9XdjLiIUKV80UxXruD546+Rll9baWToM/jcK5QViXoZ1wdnS9ykzRVtbIun/0NNIZhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Gqucvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE70C433F1;
	Sun, 24 Mar 2024 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320368;
	bh=bkGq9iUT+nnPa7tdEFRqKN4z32Q0SFoomCET4P7d3/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8GqucvwIH6rd4pcfg3QeaZv8mjwEQPNHGCjyjPL+b+BKcM9/ERcK58UWHRdQwShd
	 w6NcDBG9NGJnfuboLcOa8lW0yX49yiFTVih/gWzNMvVidf1rces6Hj+uy6sXY9BWmg
	 eFheFIphXK+R/H2fNLrUFLgQMTSsZfeiKd2lOpoQ6LC8rA5PdKrNePh6ibfuaSSZro
	 xXhSe7OLAy2yNYmqgrWeX6IZQHWbEzMPE8jJVGSOS8Agl71rOKwVoY/ylXF7kuS/95
	 9t1IB1FNjoI8TTFuzWm6ctNj0Jv4Tef3gvnaPzDNqaSRBfyhv3tYsKbagwweumCYba
	 ytkGWOVuh6/OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Butcher <adam@jessamine.co.uk>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 675/715] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length
Date: Sun, 24 Mar 2024 18:34:14 -0400
Message-ID: <20240324223455.1342824-676-sashal@kernel.org>
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
index 833a1bb7a9143..c3e5cee18bea7 100644
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


