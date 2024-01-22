Return-Path: <linux-kernel+bounces-33444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D23C836A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60457B2308E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91D4F5E5;
	Mon, 22 Jan 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDNHjb37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E912AAF0;
	Mon, 22 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936317; cv=none; b=p8/q8NGQ/DBY0owAq04nEM6EiY+VMl1gecvnVzGmL+LiRbLEonzYNxdHIZInEv//OFayFB64l4CnMFoIo8RgJDQ00I2XKVrkKAWL7FyuAA6ipohc3Gy+Y0IBxee/i1taZDBIyLagMFixl7bh9XXKpGzfHYvMkBbLI/IqxhXYKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936317; c=relaxed/simple;
	bh=Vnjgf4dqkyGDz4b/kMEZ3z7g1junkaXLE1bZZe7eqvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQX58FVL5pIpy5hYYW9oEZsCDK1VgUscJJHzWgTu02ip4szNU0ADhRnXk19qUay5WRXKL9k+ed07C5HuBQTtRiHNBqoOOeXY/H9k/dSGTyLjObQblS4RCfhmqDFHvLiGoNTE8dHXlD4krukhcxACnW4QfiaotG8hVoj8UUdPqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDNHjb37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ECDC43390;
	Mon, 22 Jan 2024 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936316;
	bh=Vnjgf4dqkyGDz4b/kMEZ3z7g1junkaXLE1bZZe7eqvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDNHjb37rYqIAwm0KlnqqkdVlDWCfq1mY4bC0m/XXfaDF+nqv6Oqbp1F7PFI1uUfJ
	 AvfER1sJqxOLmaEk7dnnyUv0S42ptjPd2dVQ4Mdz2c8W3nBB2nTzP4l7qDfZjjUrP9
	 fy8EIC4ExwVO8hL3OEgf17oaoWnFvXpAenOxGkF2QK7ord2+K4AfU47RHPTL7LSA+R
	 /+A2FR5HzOKrwIoArMg+STw32O/EelQrdbhfCRgzZZL7vBUcZ4IizrBP/sUcxWLVwr
	 xzbPMZxBQ55rnVTUXs3vEmeOJtyG1lwupiEsTbqazU2N+bXI9j1lRmFU5PI/9Tax8G
	 hoi+tegPugMxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	"Oliver F . Brown" <oliver.brown@oss.nxp.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	linux-clk@vger.kernel.org,
	linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 43/53] clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks
Date: Mon, 22 Jan 2024 10:08:44 -0500
Message-ID: <20240122150949.994249-43-sashal@kernel.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 3f5f63adeea7e7aa715e101ffe4b4ac9705f9664 ]

To be compatible with SCU firmware based on 1.15 a different clock
routing for LVDS is needed.

Signed-off-by: Oliver F. Brown <oliver.brown@oss.nxp.com>
Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20231218122407.2757175-1-alexander.stein@ew.tq-group.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx8qxp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 273de1f29307..1066ea16de62 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -67,6 +67,22 @@ static const char * const lcd_pxl_sels[] = {
 	"lcd_pxl_bypass_div_clk",
 };
 
+static const char *const lvds0_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"mipi0_lvds_bypass_clk",
+};
+
+static const char *const lvds1_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"clk_dummy",
+	"mipi1_lvds_bypass_clk",
+};
+
 static const char * const mipi_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
@@ -201,9 +217,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi0_lvds_pixel_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi0_lvds_phy_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu2("mipi0_lvds_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("mipi0_lvds_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
@@ -213,9 +229,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi1_lvds_pixel_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi1_lvds_phy_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu2("mipi1_lvds_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("mipi1_lvds_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
-- 
2.43.0


