Return-Path: <linux-kernel+bounces-70034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D48085921A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6BF282743
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528E37E57E;
	Sat, 17 Feb 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="koCjUDST"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2977C6C4;
	Sat, 17 Feb 2024 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198490; cv=none; b=LQLyL9jqN72N9RHhz7K+94XE0muLcMfpa4OYIFUKO5o9s1CGqOPKSzMHsFIdQ24PMAPQqWQUTQGeKTb5JPx5aB/+CTPusvQUK/+srr8gHwdGtcIg3XoFbVCo2uLYjwEhH1SqKcd6d6aMW90RC9YkWYj7wyMjy+Q3VHFtvDxuBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198490; c=relaxed/simple;
	bh=GDFM2rZjlq+HPVr5razRyWgRuOojfXjQpD41VCj6WJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMke5kKguqIarzNZ7W/ACj5/4xVTZlUULjoYU7qcp4pbSDrdkEE079ssd0MOZxLHv54A9w+iL7SAYeSu3Tk32sO3+nl46biaj+KtnHI0/IXTV8JLh79k0wWigwoPO33hxYl5As6dStnvlA3xPDzYIOaKSTpmBVVmSOL6g5BVHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=koCjUDST; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708198486; bh=GDFM2rZjlq+HPVr5razRyWgRuOojfXjQpD41VCj6WJY=;
	h=From:To:Cc:Subject:Date:From;
	b=koCjUDSTKjRT3baQHGvj+LqngJ9+yqKbWdCO+vXaVwYn6hV/KgPGObAmwnk5sQluq
	 6iRuz4k3AF54CcMNRhSX+gC/HMCJR+xyIJ3vMOb+uLv0DId1tI3lQ+qEeZ0+xFdxSO
	 2lhUMqp1AWmtA4BcN5zsLg9LtWJLooreCPzePf6k=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] clk: rk3399: Allow to set rate of clk_i2s0_frac's parent
Date: Sat, 17 Feb 2024 20:34:38 +0100
Message-ID: <20240217193439.1762213-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Otherwise when when clk_i2s0 muxes to clk_i2s0_div which requires
setting high divider value on clk_i2s0_div, and then muxes back to
clk_i2s0_frac, clk_i2s0_frac would have no way to change the
clk_i2s0_div's divider ratio back to 1 so that it can satisfy the
condition for m/n > 20 for fractional division to work correctly.

Bug is reproducible by playing 44.1k audio, then 48k audio, and then
44.1k audio again. This results in clk_i2s0_div being set to 49 and
clk_i2s0_frac not being able to cope with such a low input clock rate
and audio playing extremely slowly.

The identical issue is on i2s1 and i2s2 clocks, too.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/clk/rockchip/clk-rk3399.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5efac2ca3048..a17996acd065 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -597,7 +597,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s0_div", mux_pll_src_cpll_gpll_p, 0,
 			RK3399_CLKSEL_CON(28), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3399_CLKGATE_CON(8), 3, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s0_frac", "clk_i2s0_div", 0,
+	COMPOSITE_FRACMUX(0, "clk_i2s0_frac", "clk_i2s0_div", CLK_SET_RATE_PARENT,
 			RK3399_CLKSEL_CON(96), 0,
 			RK3399_CLKGATE_CON(8), 4, GFLAGS,
 			&rk3399_i2s0_fracmux),
@@ -607,7 +607,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s1_div", mux_pll_src_cpll_gpll_p, 0,
 			RK3399_CLKSEL_CON(29), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3399_CLKGATE_CON(8), 6, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s1_frac", "clk_i2s1_div", 0,
+	COMPOSITE_FRACMUX(0, "clk_i2s1_frac", "clk_i2s1_div", CLK_SET_RATE_PARENT,
 			RK3399_CLKSEL_CON(97), 0,
 			RK3399_CLKGATE_CON(8), 7, GFLAGS,
 			&rk3399_i2s1_fracmux),
@@ -617,7 +617,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE(0, "clk_i2s2_div", mux_pll_src_cpll_gpll_p, 0,
 			RK3399_CLKSEL_CON(30), 7, 1, MFLAGS, 0, 7, DFLAGS,
 			RK3399_CLKGATE_CON(8), 9, GFLAGS),
-	COMPOSITE_FRACMUX(0, "clk_i2s2_frac", "clk_i2s2_div", 0,
+	COMPOSITE_FRACMUX(0, "clk_i2s2_frac", "clk_i2s2_div", CLK_SET_RATE_PARENT,
 			RK3399_CLKSEL_CON(98), 0,
 			RK3399_CLKGATE_CON(8), 10, GFLAGS,
 			&rk3399_i2s2_fracmux),
-- 
2.43.0


