Return-Path: <linux-kernel+bounces-78133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1F860F59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9495F1C21468
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494A60B84;
	Fri, 23 Feb 2024 10:31:06 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C65DF1E;
	Fri, 23 Feb 2024 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684266; cv=none; b=VDlowCdedomEvgn0hs6JaOjDPDH9+UB81Pkm6X1Bq9PtzY3HfyCf8pRcOiEXEDJPudf3y8M9SgLIAMwkQWDKACFkbteCKeV63SrQJXndxzhBD6/iZHrxr2n/KfNHjVLwX3IhE/cJ44kmf0JDlf+4lthbdyh9TPmiWrZ2WtzLaXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684266; c=relaxed/simple;
	bh=D6bO7OzGqUljgDA4twduTq9DME6Aa10LBuM5fRsAoS8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XicILzr3zEKI+Cp3fafJYyd0bcJ3EWf0+2qGB68OQoSiO9/HDC1M69mNRVRs7XONc1/7BoS/oS0Y+Fh1bbdQrR0jX22Zdgj/G6RcCDakuM3oeTuN1dGnfHOyKCgPg+zC/eBbW3tP5yVVUHzwXnTzaB+qW77qXsV6gHrhsYsYpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3555B1A1317;
	Fri, 23 Feb 2024 11:31:03 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F2BC21A132A;
	Fri, 23 Feb 2024 11:31:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 30370183AC0A;
	Fri, 23 Feb 2024 18:31:01 +0800 (+08)
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
	shengjiu.wang@gmail.com,
	marex@denx.de,
	m.felsch@pengutronix.de
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: imx8mp: Fix SAI_MCLK_SEL definition
Date: Fri, 23 Feb 2024 18:15:51 +0800
Message-Id: <1708683351-8504-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

There is SAI1, SAI2, SAI3, SAI5, SAI6, SAI7 existing in this block
control, the order is discontinuous. The definition of SAI_MCLK_SEL(n)
is not match with the usage of CLK_SAIn(n).

So define SAI##n##_MCLK_SEL separately to fix the issue.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index e4300df88f1a..55ed211a5e0b 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -18,7 +18,12 @@
 
 #define CLKEN0			0x000
 #define CLKEN1			0x004
-#define SAI_MCLK_SEL(n)		(0x300 + 4 * (n))	/* n in 0..5 */
+#define SAI1_MCLK_SEL		0x300
+#define SAI2_MCLK_SEL		0x304
+#define SAI3_MCLK_SEL		0x308
+#define SAI5_MCLK_SEL		0x30C
+#define SAI6_MCLK_SEL		0x310
+#define SAI7_MCLK_SEL		0x314
 #define PDM_SEL			0x318
 #define SAI_PLL_GNRL_CTL	0x400
 
@@ -95,13 +100,13 @@ static const struct clk_parent_data clk_imx8mp_audiomix_pll_bypass_sels[] = {
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK1_SEL, {},		\
 		clk_imx8mp_audiomix_sai##n##_mclk1_parents,		\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai##n##_mclk1_parents), \
-		SAI_MCLK_SEL(n), 1, 0					\
+		SAI##n##_MCLK_SEL, 1, 0					\
 	}, {								\
 		"sai"__stringify(n)"_mclk2_sel",			\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_MCLK2_SEL, {},		\
 		clk_imx8mp_audiomix_sai_mclk2_parents,			\
 		ARRAY_SIZE(clk_imx8mp_audiomix_sai_mclk2_parents),	\
-		SAI_MCLK_SEL(n), 4, 1					\
+		SAI##n##_MCLK_SEL, 4, 1					\
 	}, {								\
 		"sai"__stringify(n)"_ipg_cg",				\
 		IMX8MP_CLK_AUDIOMIX_SAI##n##_IPG,			\
-- 
2.34.1


