Return-Path: <linux-kernel+bounces-70180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7364859468
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1021C1C21440
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F317FF;
	Sun, 18 Feb 2024 03:34:17 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7C1C27;
	Sun, 18 Feb 2024 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708227256; cv=none; b=ngxWj/i1VMqWlsfh8Z5CZO06mn68xoxUq9gEVmmQ+ZRjUU12pzsJnyec11boJ4Pjtv22jzTmV6KaSN1aSlTIazMlT+6sFrnaKiVi7j1Z5E3kvrKoNfvDcndas0oqhr6kLHtN6/QBclOx2Qwjg+7IJZ3Z+EOef+nLv+W4pWMIHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708227256; c=relaxed/simple;
	bh=CxVKwUGLo7LecTQYrgFuAB5EEisKCsHAp17IP4LnF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ul4SK1VFx147ZY7kzk1Oeap9evRJvnnvCF0jCmtxgTvKXBUvAHGBxrQ7XhOtGaxVHpBzCbp8P/Xy77DXhzzBmxlOrqxZiIaUQgOgP8YQtOdOg+3So/WWFIQldN89hdt7L1kdfQPlpvgbhP493J8EDJ98K0Dpig5SkDcUj0oMgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rbXaP-00054G-35;
	Sun, 18 Feb 2024 03:11:26 +0000
Date: Sun, 18 Feb 2024 03:11:15 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Jianhui Zhao <zhaojh329@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: John Crispin <john@phrozen.org>, Steven Liu <steven.liu@mediatek.com>
Subject: [PATCH] clk: mediatek: mt7981-topckgen: flag SGM_REG_SEL as critical
Message-ID: <fc157139e6b7f8dfb6430ac7191ba754027705e8.1708221995.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Without the SGM_REG_SEL clock enabled the cpu freezes if trying to
access registers used by MT7981 clock drivers itself.
Mark SGM_REG_SEL as critical to make sure it is always enabled to
prevent freezes on boot even if the Ethernet driver which prepares
and enables the clock is not loaded or probed at a later point.

Fixes: 813c3b53b55b ("clk: mediatek: add MT7981 clock support")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 682f4ca9e89ad..493aa11d3a175 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -357,8 +357,9 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel",
 			     sgm_325m_parents, 0x050, 0x054, 0x058, 8, 1, 15,
 			     0x1C0, 21),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents,
-			     0x050, 0x054, 0x058, 16, 1, 23, 0x1C0, 22),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel", sgm_reg_parents,
+				   0x050, 0x054, 0x058, 16, 1, 23, 0x1C0, 22,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_EIP97B_SEL, "eip97b_sel", eip97b_parents,
 			     0x050, 0x054, 0x058, 24, 3, 31, 0x1C0, 23),
 	/* CLK_CFG_6 */
-- 
2.43.0


