Return-Path: <linux-kernel+bounces-6801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7369819DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D0D2883E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332821110;
	Wed, 20 Dec 2023 11:14:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4121103;
	Wed, 20 Dec 2023 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30E9D2018C6;
	Wed, 20 Dec 2023 12:14:26 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDE2820056C;
	Wed, 20 Dec 2023 12:14:25 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 46D741802200;
	Wed, 20 Dec 2023 19:14:24 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: pll14xx: change naming of fvco to fout
Date: Wed, 20 Dec 2023 18:33:09 +0800
Message-Id: <1703068389-6130-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

pll14xx_calc_rate() output the fout clock not the fvco clock
The relation of fvco and fout is:
	fout = fvco / (1 << sdiv)

So use correct naming for the clock.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-pll14xx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 0d58d85c375e..d63564dbb12c 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -104,15 +104,15 @@ static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 static long pll14xx_calc_rate(struct clk_pll14xx *pll, int mdiv, int pdiv,
 			      int sdiv, int kdiv, unsigned long prate)
 {
-	u64 fvco = prate;
+	u64 fout = prate;
 
-	/* fvco = (m * 65536 + k) * Fin / (p * 65536) */
-	fvco *= (mdiv * 65536 + kdiv);
+	/* fout = (m * 65536 + k) * Fin / (p * 65536) / (1 << sdiv) */
+	fout *= (mdiv * 65536 + kdiv);
 	pdiv *= 65536;
 
-	do_div(fvco, pdiv << sdiv);
+	do_div(fout, pdiv << sdiv);
 
-	return fvco;
+	return fout;
 }
 
 static long pll1443x_calc_kdiv(int mdiv, int pdiv, int sdiv,
@@ -131,7 +131,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 {
 	u32 pll_div_ctl0, pll_div_ctl1;
 	int mdiv, pdiv, sdiv, kdiv;
-	long fvco, rate_min, rate_max, dist, best = LONG_MAX;
+	long fout, rate_min, rate_max, dist, best = LONG_MAX;
 	const struct imx_pll14xx_rate_table *tt;
 
 	/*
@@ -143,6 +143,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 	 * d) -32768 <= k <= 32767
 	 *
 	 * fvco = (m * 65536 + k) * prate / (p * 65536)
+	 * fout = (m * 65536 + k) * prate / (p * 65536) / (1 << sdiv)
 	 */
 
 	/* First try if we can get the desired rate from one of the static entries */
@@ -173,8 +174,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 		pr_debug("%s: in=%ld, want=%ld Only adjust kdiv %ld -> %d\n",
 			 clk_hw_get_name(&pll->hw), prate, rate,
 			 FIELD_GET(KDIV_MASK, pll_div_ctl1), kdiv);
-		fvco = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
-		t->rate = (unsigned int)fvco;
+		fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
+		t->rate = (unsigned int)fout;
 		t->mdiv = mdiv;
 		t->pdiv = pdiv;
 		t->sdiv = sdiv;
@@ -190,13 +191,13 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 			mdiv = clamp(mdiv, 64, 1023);
 
 			kdiv = pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rate, prate);
-			fvco = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
+			fout = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, kdiv, prate);
 
 			/* best match */
-			dist = abs((long)rate - (long)fvco);
+			dist = abs((long)rate - (long)fout);
 			if (dist < best) {
 				best = dist;
-				t->rate = (unsigned int)fvco;
+				t->rate = (unsigned int)fout;
 				t->mdiv = mdiv;
 				t->pdiv = pdiv;
 				t->sdiv = sdiv;
-- 
2.34.1


