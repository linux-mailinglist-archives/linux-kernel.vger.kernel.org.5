Return-Path: <linux-kernel+bounces-33001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3212A836312
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E97B1C22A54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2C3D574;
	Mon, 22 Jan 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d39xi6db"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64B3BB3F;
	Mon, 22 Jan 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926036; cv=none; b=uy12PQR8VVwrhdQilyfI7Wwl+sC20dzCQtKUkvAvYe33ZqsO2rdvWs3wF6A+eC1Yt4lkjItNDb+A7WViezSpVMWXb3Kafvbmxh1FXSrHbNeBCWKmp3v4DeJgCnMYUxyOpM2FhXB245d87DZHx/2SstBCRlE8tscSuz9yH/x+KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926036; c=relaxed/simple;
	bh=tebc2epqBPqi3q6nwRuHzvgjiwhDevUi+LtXh9FShW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npQI4ep4Cb95zqwSWdoIvFhz7ZDGvEH2dUQfy+PKL1FOdCGhyBferBr3h0G8KhwZRnw3d+ndFpSI9uWBS/yQJbg1plGU7q7qzPG6WU2tMlXJW8oAs1YjLo7aG1vDWWB8AS8p3wakrRwsQC8kwBSz9/oDOfDkiTtv56MOiP2qFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d39xi6db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD11C43390;
	Mon, 22 Jan 2024 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926035;
	bh=tebc2epqBPqi3q6nwRuHzvgjiwhDevUi+LtXh9FShW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d39xi6db5ggCp+RmilEG82Cw9t3JzSuihoMmextnDsrpiac5WF2FYM9xtMbYTsZhd
	 gg1TVEJIxBuI8dWXqC5YyD0NLvgJ83BNRytMIc2Y58yxFN/pGdyHfqp4vGl1KHECBO
	 xQcVeiqpy69wAC2PQiGYY0+wpiUB/YXFmE9ggje4IyR9ctb+m/DnDYp7+g87pnagRt
	 YiM7BPGhsWm6acnIecy+zNOjgpEx1021GKPKDAYz56NJUiclVhIf6SnlYLN1pp7F/z
	 qHrAD6Xz0r+Dkby7a+xFW+0piYlfl5eLWNxXjgCU7M3hUo8Bc5isbLaDkHRROab0mO
	 7I/2++UtIizFQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 5/7] clk: microchip: mpfs: add missing MSSPLL outputs
Date: Mon, 22 Jan 2024 12:19:53 +0000
Message-ID: <20240122-scarring-auction-b13c25a422bd@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1OkhpL0+t001V44z+z0voVrWBZYio2gp1txLGSVnNbo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlP3b48MMc7LmOpeONVl+ZN3Wi3azvNyyuOFVm489 4R5HbNZRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbypIGRYdWbLRoPHrc907lS dppBYWmKnll0tqplgMev0M8egmvWJDMyPLe/2pW153XCpOTFKn36lx/WV5atsZE2FPtYEjevevs 3VgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The MSSPLL has 4 outputs, of which only the cpu/axi/ahb clock parent is
currently implemented.
Add the CAN clock too, as that'll be needed by the driver for the CAN
controller and uses output 3.
While we are here, the other two missing clocks, used by the eMMC/SD
controller and by the "user crypto".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 911905d0433d..bed6adbb8a70 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -28,6 +28,7 @@
 #define MSSPLL_REFDIV_SHIFT	0x08u
 #define MSSPLL_REFDIV_WIDTH	0x06u
 #define MSSPLL_POSTDIV02_SHIFT	0x08u
+#define MSSPLL_POSTDIV13_SHIFT	0x18u
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
@@ -240,6 +241,12 @@ static const struct clk_ops mpfs_clk_msspll_out_ops = {
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
 	CLK_PLL_OUT(CLK_MSSPLL0, "clk_msspll", "clk_msspll_internal", 0,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
+	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
+	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
+	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
 };
 
 static int mpfs_clk_register_msspll_outs(struct device *dev,
-- 
2.43.0


