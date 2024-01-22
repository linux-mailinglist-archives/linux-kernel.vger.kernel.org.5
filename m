Return-Path: <linux-kernel+bounces-33000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FBB83630C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CF1F21EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FA53D540;
	Mon, 22 Jan 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re/5/Mio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD323D3AE;
	Mon, 22 Jan 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926031; cv=none; b=DHb/mb1QVGkAaDF7KHVEb8rkkYmjV2GsEwGt1pywFbUGhYt4xea+VqNJ3xcVJBKymf2AxdVhBOsKURV32Eni2YonkTD9noc73KEgte9BVnEGw1A/2OCXJs/eyZ/X6hvl4CBhgM/DPQeytMjKupVLSfMko8toVC3eCAu6KyV5kVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926031; c=relaxed/simple;
	bh=GmakhWZIvNK9KdJIPMvodNUaR1Ey8Ali7Xmgiv67KOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAUy+3esyHIAZdP0h7HdqEQDyfg++JKeWcQAGYa4Jg9CQNrCPRNpeH+NYXMR8NNu1VnN/cJ2BeLhKOgQapASOliVm68884AwoW5jd/R51LrxjT/bU7/SrpJiYjrroi5Plcpzdnz30eCmjkMDPObZiuAHPaJ6cbLaM8e7Ila1omI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re/5/Mio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84254C433B1;
	Mon, 22 Jan 2024 12:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926030;
	bh=GmakhWZIvNK9KdJIPMvodNUaR1Ey8Ali7Xmgiv67KOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re/5/Mio0eDHFIi2vAEe02mJjIVEKosRbSMGcS0HJjQ7Y3cEqugSbfeAv/ms1bmI/
	 DWi991AwCzNTn2cyqNRbDNrZm2CgJdAjoHG0JgLbPMFxXNBkoX0sJdK+mTR65xHEH8
	 ILiOZykEOBzpotsG/rUkrfTw4Ff6Mey4uPKEmrQbW9XAiuyoxNxOa2yZPiwALNb24c
	 vWOer+HbBiUrbBFqJRBYast/t/MSqVzbYP94UOYFe4gjjDGt6Ia4vUeDKBi35HRn9/
	 Yh/7RAuNUsRLYaWZp7sEUK92YizEDQlsNwBRT9PHIuvOsZ/L5fIJk0LvPBnYwRH4fY
	 aDG8+zSj4rPSw==
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
Subject: [PATCH v2 4/7] clk: microchip: mpfs: setup for using other mss pll outputs
Date: Mon, 22 Jan 2024 12:19:52 +0000
Message-ID: <20240122-sprint-hacking-8d2f20654bf1@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=t4FAgw3fopovHlUFM1DCXwuCj6lBGSfP99KWVcOPLP0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlOeBpZyrb4z/7tEllyWxuwSk0q7AwlKBy423daUS n0XP39/RykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACayfwojw1SB7ZFr3NyPKT+c 8eofw6WKl4KhDjniFtPe/Pi/RaGx9Agjw9K9nwu+3/vlvr1hBm+IdsQ16x1Tb3B89n+8l2F506P 0VC4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Now that the MSSPLL is split, and the "postdiv" divider of the
cpu/AHB/AXI bus clock is represented by its own "hw" struct, make the
shifts, register offset and width a parameter of the initialisation
macro, rather than using defines that only work for one of the four
outputs.
Configuring this at initialisaion paves the way for using the other
three output clocks, where the register offset, and the bit shift
within that register, will differ.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index acf598a32ce0..911905d0433d 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -15,7 +15,8 @@
 
 /* address offset of control registers */
 #define REG_MSSPLL_REF_CR	0x08u
-#define REG_MSSPLL_POSTDIV_CR	0x10u
+#define REG_MSSPLL_POSTDIV01_CR	0x10u
+#define REG_MSSPLL_POSTDIV23_CR	0x14u
 #define REG_MSSPLL_SSCG_2_CR	0x2Cu
 #define REG_CLOCK_CONFIG_CR	0x08u
 #define REG_RTC_CLOCK_CR	0x0Cu
@@ -26,7 +27,7 @@
 #define MSSPLL_FBDIV_WIDTH	0x0Cu
 #define MSSPLL_REFDIV_SHIFT	0x08u
 #define MSSPLL_REFDIV_WIDTH	0x06u
-#define MSSPLL_POSTDIV_SHIFT	0x08u
+#define MSSPLL_POSTDIV02_SHIFT	0x08u
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
@@ -62,6 +63,9 @@ struct mpfs_msspll_out_hw_clock {
 	struct clk_hw hw;
 	struct clk_init_data init;
 	unsigned int id;
+	u32 reg_offset;
+	u32 shift;
+	u32 width;
 	u32 flags;
 };
 
@@ -175,11 +179,11 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
 static unsigned long mpfs_clk_msspll_out_recalc_rate(struct clk_hw *hw, unsigned long prate)
 {
 	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + REG_MSSPLL_POSTDIV_CR;
+	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
 	u32 postdiv;
 
-	postdiv = readl_relaxed(postdiv_addr) >> MSSPLL_POSTDIV_SHIFT;
-	postdiv &= clk_div_mask(MSSPLL_POSTDIV_WIDTH);
+	postdiv = readl_relaxed(postdiv_addr) >> msspll_out_hw->shift;
+	postdiv &= clk_div_mask(msspll_out_hw->width);
 
 	return prate / postdiv;
 }
@@ -189,19 +193,19 @@ static long mpfs_clk_msspll_out_round_rate(struct clk_hw *hw, unsigned long rate
 {
 	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
 
-	return divider_round_rate(hw, rate, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+	return divider_round_rate(hw, rate, prate, NULL, msspll_out_hw->width,
 				  msspll_out_hw->flags);
 }
 
 static int mpfs_clk_msspll_out_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
 {
 	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + REG_MSSPLL_POSTDIV_CR;
+	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
 	u32 postdiv;
 	int divider_setting;
 	unsigned long flags;
 
-	divider_setting = divider_get_val(rate, prate, NULL, MSSPLL_POSTDIV_WIDTH,
+	divider_setting = divider_get_val(rate, prate, NULL, msspll_out_hw->width,
 					  msspll_out_hw->flags);
 
 	if (divider_setting < 0)
@@ -210,7 +214,7 @@ static int mpfs_clk_msspll_out_set_rate(struct clk_hw *hw, unsigned long rate, u
 	spin_lock_irqsave(&mpfs_clk_lock, flags);
 
 	postdiv = readl_relaxed(postdiv_addr);
-	postdiv &= ~(clk_div_mask(MSSPLL_POSTDIV_WIDTH) << MSSPLL_POSTDIV_SHIFT);
+	postdiv &= ~(clk_div_mask(msspll_out_hw->width) << msspll_out_hw->shift);
 	writel_relaxed(postdiv, postdiv_addr);
 
 	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
@@ -224,14 +228,18 @@ static const struct clk_ops mpfs_clk_msspll_out_ops = {
 	.set_rate = mpfs_clk_msspll_out_set_rate,
 };
 
-#define CLK_PLL_OUT(_id, _name, _parent, _flags) {				\
+#define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {	\
 	.id = _id,								\
+	.shift = _shift,							\
+	.width = _width,							\
+	.reg_offset = _offset,							\
 	.flags = _flags,							\
 	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_msspll_out_ops, 0),	\
 }
 
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
-	CLK_PLL_OUT(CLK_MSSPLL0, "clk_msspll", "clk_msspll_internal", 0),
+	CLK_PLL_OUT(CLK_MSSPLL0, "clk_msspll", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
 };
 
 static int mpfs_clk_register_msspll_outs(struct device *dev,
-- 
2.43.0


