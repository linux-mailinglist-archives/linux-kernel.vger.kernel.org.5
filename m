Return-Path: <linux-kernel+bounces-33003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB01836319
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8811F23D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D13C464;
	Mon, 22 Jan 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGUqRyUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7A3D990;
	Mon, 22 Jan 2024 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926040; cv=none; b=d3nVfOaSZipGBIDWMoC9ryK2Sw6TZYR5hENJkOPvBtVrQ5zhmvjb0BvsWQ+hDrtOi+GF4K9UQPMcjKtEVUHHxOGBXPWUEeAoi1n/g9ynkuGHRN47XUJfEEbvepJOiMH5wYhtmCTDvAmoVLVf7+GWjXXfnWfBulobcDqzTM3e2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926040; c=relaxed/simple;
	bh=QV+x2Fo//YjJSJ0LUtc4qQeX5SsBa9GHRzYL4hGBQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvCWIHxkteX3Cp7G2WFd/uL9Lg8pc2kod43lCX6eTZxjfW4Wct1FutCPK0Q/UCGu4VkhK7BtVv1L6UWoSWgpojA2JH304OqyVxin9zls8QTQaIKEaVR3kqGRAAJznQZC2dDxmo7qlYjEx9sBmyJX1dXGmWnTLyB/yb9i9Q4IpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGUqRyUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175C1C433A6;
	Mon, 22 Jan 2024 12:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926040;
	bh=QV+x2Fo//YjJSJ0LUtc4qQeX5SsBa9GHRzYL4hGBQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGUqRyUFr33p5AHnUWU8wg/h4kIw6o0o6tNCCkrpV1gfPmTy4BSHOnWAnh+AyY/zX
	 4xzJBIJvxEALgfuTc3dnsPvRVfnz0ncdEv/PWGpkQYiFXoJkn2xpdhtQyUsp4+QYD4
	 3b5cTYhe9mCP4WZa9Nnk+lajfHMJF8CzB09gvlik/wl18oyfHICUyugM1tMUeTNTQe
	 UotfiEspRht3/aef+Ht/R+A/UOnGPbCwGs3o2C39ye+vCMP/Dr8vhXoXG9v6i7sSsj
	 G4mmzRv6w51pvZKtIXFW48nCYdpQImPpe3FYBkhD2EF0OZuB5f3GjzQn+vPmpQzmai
	 lENNNJ9sLh18g==
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
Subject: [PATCH v2 6/7] clk: microchip: mpfs: convert MSSPLL outputs to clk_divider
Date: Mon, 22 Jan 2024 12:19:54 +0000
Message-ID: <20240122-drop-down-kooky-1fdc850c16b6@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5154; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GstYXae7YmaE0PSrBEvAfhgo8lU9+0CrRNVIt4fzA+k=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlPLRXftesahl2KR0/pwwgmP9JDY1Ad2N82lW92ND r25z5HdUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgImU5jIynDAuWLrR4WuVhQ+L SsmPo3eTEuxWs61gtDkqeubh9f/fChkZfgmVqKat7979P2LT7E3XJJzc5p5k6LzGfOdTYpR+dLg hAwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

After splitting the MSSPLL in two, the PLL outputs have become
open-coded versions of clk_divider. Drop the custom clk ops structs, and
instead use the generic clk_divider_ops.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 81 ++++++--------------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index bed6adbb8a70..22eab91a6712 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -61,13 +61,10 @@ struct mpfs_msspll_hw_clock {
 
 struct mpfs_msspll_out_hw_clock {
 	void __iomem *base;
-	struct clk_hw hw;
+	struct clk_divider output;
 	struct clk_init_data init;
 	unsigned int id;
 	u32 reg_offset;
-	u32 shift;
-	u32 width;
-	u32 flags;
 };
 
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
@@ -177,75 +174,25 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
  * MSS PLL output clocks
  */
 
-static unsigned long mpfs_clk_msspll_out_recalc_rate(struct clk_hw *hw, unsigned long prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
-	u32 postdiv;
-
-	postdiv = readl_relaxed(postdiv_addr) >> msspll_out_hw->shift;
-	postdiv &= clk_div_mask(msspll_out_hw->width);
-
-	return prate / postdiv;
-}
-
-static long mpfs_clk_msspll_out_round_rate(struct clk_hw *hw, unsigned long rate,
-					   unsigned long *prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-
-	return divider_round_rate(hw, rate, prate, NULL, msspll_out_hw->width,
-				  msspll_out_hw->flags);
-}
-
-static int mpfs_clk_msspll_out_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
-	u32 postdiv;
-	int divider_setting;
-	unsigned long flags;
-
-	divider_setting = divider_get_val(rate, prate, NULL, msspll_out_hw->width,
-					  msspll_out_hw->flags);
-
-	if (divider_setting < 0)
-		return divider_setting;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-
-	postdiv = readl_relaxed(postdiv_addr);
-	postdiv &= ~(clk_div_mask(msspll_out_hw->width) << msspll_out_hw->shift);
-	writel_relaxed(postdiv, postdiv_addr);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-
-	return 0;
-}
-
-static const struct clk_ops mpfs_clk_msspll_out_ops = {
-	.recalc_rate = mpfs_clk_msspll_out_recalc_rate,
-	.round_rate = mpfs_clk_msspll_out_round_rate,
-	.set_rate = mpfs_clk_msspll_out_set_rate,
-};
-
 #define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {	\
 	.id = _id,								\
-	.shift = _shift,							\
-	.width = _width,							\
+	.output.shift = _shift,							\
+	.output.width = _width,							\
+	.output.table = NULL,							\
 	.reg_offset = _offset,							\
-	.flags = _flags,							\
-	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_msspll_out_ops, 0),	\
+	.output.flags = _flags,							\
+	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),	\
+	.output.lock = &mpfs_clk_lock,						\
 }
 
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
-	CLK_PLL_OUT(CLK_MSSPLL0, "clk_msspll", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL0, "clk_msspll", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
-	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
-	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
-	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
 };
 
@@ -259,13 +206,13 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_msspll_out_hw_clock *msspll_out_hw = &msspll_out_hws[i];
 
-		msspll_out_hw->base = data->msspll_base;
-		ret = devm_clk_hw_register(dev, &msspll_out_hw->hw);
+		msspll_out_hw->output.reg = data->msspll_base + msspll_out_hw->reg_offset;
+		ret = devm_clk_hw_register(dev, &msspll_out_hw->output.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register msspll out id: %d\n",
 					     msspll_out_hw->id);
 
-		data->hw_data.hws[msspll_out_hw->id] = &msspll_out_hw->hw;
+		data->hw_data.hws[msspll_out_hw->id] = &msspll_out_hw->output.hw;
 	}
 
 	return 0;
-- 
2.43.0


