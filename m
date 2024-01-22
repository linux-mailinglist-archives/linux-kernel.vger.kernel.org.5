Return-Path: <linux-kernel+bounces-33440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88F8369D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11523B2B274
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929412A158;
	Mon, 22 Jan 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMaJfmTP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737F12A14E;
	Mon, 22 Jan 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936305; cv=none; b=AgS3g2KbKszJYyo6blZOusgDGPQ1KG44NWUE5T/srUZhaVt+DzHzJOpgC0F7haEokZFDRJcSuLMEVFHctmfRVMhxs4nfXdc/Y+SCL+HZoHe+3yMlBpd6qpLJVhJtxr0kCi5wN01iPg1mS0HMzXE1+fjiGfO9htVX9ce0tZp0Sy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936305; c=relaxed/simple;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfzCxxjfamFC6xip/i4gz/2f8RtxHPEIKe5n0CipvWJ2hbxIN3NxkJj6xrAbpwOmhocqNuARDRPlaY+CviaT8uqLn+jYR/WPiclmcQseit4plajvKAbJYObHXkwZd4gGJX7gqzqhROTmN9htAq+p9zGdiw9qe1UoOIQMzQnvi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMaJfmTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DABC433F1;
	Mon, 22 Jan 2024 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936304;
	bh=92b830oToNjFrAIGCBJANFHKYGaZdy69fCCXmkLLrD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMaJfmTPxptjYHnJtwKVTEWjF3mUVWx6ovB447Ksmh6jAW3rHB1GarHjfIcDbedjM
	 PW1xLBMHHUTripPadpjCdJeLijsOcVwyluD8FFfTmE1shUyj3UGsO20uAlhE1HYggC
	 zikDg0p1j8tUI37r15ieSdmEZ7T9/R13b/YVHwq0AOu9G5pWBlh8aY8Jem/gN8erGd
	 wgIpxBdveiUfDV3VpNacI149wadsDl462H4PSjElBRN0CLOVSegsqBjVxIQgCqqA6d
	 RmacB+c9zhTMyylUha2y2C06XaYDxGttu6UNVHUU2A3NtIJ2+uB9Ab6z0b0swtyWMr
	 Z/Lx7A45VfdFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	geert+renesas@glider.be,
	abel.vesa@linaro.org,
	krzysztof.kozlowski@linaro.org,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 39/53] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:08:40 -0500
Message-ID: <20240122150949.994249-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit bfbea9e5667cfa9552c3d88f023386f017f6c308 ]

In cases where kcalloc() fails for the 'clk_data->clks' allocation, the
code path does not handle the failure gracefully, potentially leading
to a memory leak. This fix ensures proper cleanup by freeing the
allocated memory for 'clk_data' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20231210165040.3407545-1-visitorckw@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3620.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3da8..eb9c139babc3 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -467,8 +467,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-- 
2.43.0


