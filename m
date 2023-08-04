Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0466876FEBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjHDKox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjHDKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:44:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E4246BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:44:43 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B52AB1AB3;
        Fri,  4 Aug 2023 12:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691145816;
        bh=TUkJXEdGx2L3x9eOO5C14gMRZFfjPUo5XB/iG7hSXNo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZBKaogA8fDtPzUHgLJ47o74td6AxNRtTuZ0YDFbVcXz2cO8MWPFItGTgP+VyoU7Is
         X4J7VUL5w15BSA33yIKC0wCZ8j1l4YbXOLg5p/Z40rHSvW27t2RfRwjzkDSIz66qaw
         WPuVYrpiJMXWFd4/nib02sVqMUF+nwr07AYpCFBc=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:44:08 +0300
Subject: [PATCH 03/11] drm/bridge: tc358768: Cleanup PLL calculations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-tc358768-v1-3-1afd44b7826b@ideasonboard.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
In-Reply-To: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TUkJXEdGx2L3x9eOO5C14gMRZFfjPUo5XB/iG7hSXNo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNaRbMCh94UFjagognh3oJEUiI6qNt+gM+fzG
 Yv/rFC3ImWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzWkQAKCRD6PaqMvJYe
 9dNsD/0UNDVcvUORRAtGZiv2RIJjqZLr5U/45ualp74tfJ9OTV89JWa2IrNOMeHrsrJFISQ4LJs
 iAgOMgOAFINCQiCMeBPRJwCjaWBNr6Y3yWmUkIuHcGIpYpf2uq9QcgPHtI2fbGqrYRsNVK80Vn8
 Qlb5BSltsktT4Y4TVlFFMnyNOSKQMd63cGKTY2oQgZKSkeD+MKC8AOJqUAqwEdD8SnmV7tdhifk
 oGrT3y4K+LlS88kACQyjmfqyn+plqzZ5O/Yd1a4/nD7kK3OKTgYDt0mE+fItq+c3uvbCvL6IiYm
 vxXmrSOqlPb4bFVYNlIjmchhY7TMq8rQabtnNv7ELvUNT+O2UGrMMY8eqlrF2CNqYZXc1Es2OJz
 AZ/YsJog7994aGwkE5kBGz2V02CXcnYTtISRgFClbKICbSENUaGMSNMO4XjvPWVlWVmMm5oS5N6
 XCUzqIlciigPUo/msfredtN1E65XFdxwX0q6l99r48T+okcdI2Yf4CA2YgCpYevMxEoEN3rWXEt
 +J+PX/1D2OUhhuwutu8oQ9LGt2teasgouJtoMSkDmXtVrvY0Vim4VC4YPM1VScaQlwFEJBchczr
 pM2i2gJ045jjjyA8h1p/z4VPvSN29soY4lp96V64xoSDNYZKw/ogBTUidUpmInaJi81br24qAF5
 +70lWAqiaoul+bw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As is quite common, some of TC358768's PLL register fields are to be
programmed with (value - 1). Specifically, the FBD and PRD, multiplier
and divider, are such fields.

However, what the driver currently does is that it considers that the
formula used for PLL rate calculation is:

RefClk * [(FBD + 1)/ (PRD + 1)] * [1 / (2^FRS)]

where FBD and PRD are values directly from the registers, while a more
sensible way to look at it is:

RefClk * FBD / PRD * (1 / (2^FRS))

and when the FBD and PRD values are written to the registers, they will
be subtracted by one.

Change the driver accordingly, as it simplifies the PLL code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index b668f77673c3..d5831a1236e9 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -316,7 +316,7 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 
 	target_pll = tc358768_pclk_to_pll(priv, mode->clock * 1000);
 
-	/* pll_clk = RefClk * [(FBD + 1)/ (PRD + 1)] * [1 / (2^FRS)] */
+	/* pll_clk = RefClk * FBD / PRD * (1 / (2^FRS)) */
 
 	for (i = 0; i < ARRAY_SIZE(frs_limits); i++)
 		if (target_pll >= frs_limits[i])
@@ -336,19 +336,19 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
 	best_prd = 0;
 	best_fbd = 0;
 
-	for (prd = 0; prd < 16; ++prd) {
-		u32 divisor = (prd + 1) * (1 << frs);
+	for (prd = 1; prd <= 16; ++prd) {
+		u32 divisor = prd * (1 << frs);
 		u32 fbd;
 
-		for (fbd = 0; fbd < 512; ++fbd) {
+		for (fbd = 1; fbd <= 512; ++fbd) {
 			u32 pll, diff, pll_in;
 
-			pll = (u32)div_u64((u64)refclk * (fbd + 1), divisor);
+			pll = (u32)div_u64((u64)refclk * fbd, divisor);
 
 			if (pll >= max_pll || pll < min_pll)
 				continue;
 
-			pll_in = (u32)div_u64((u64)refclk, prd + 1);
+			pll_in = (u32)div_u64((u64)refclk, prd);
 			if (pll_in < 4000000)
 				continue;
 
@@ -611,7 +611,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 		mode->clock * 1000);
 
 	/* PRD[15:12] FBD[8:0] */
-	tc358768_write(priv, TC358768_PLLCTL0, (prd << 12) | fbd);
+	tc358768_write(priv, TC358768_PLLCTL0, ((prd - 1) << 12) | (fbd - 1));
 
 	/* FRS[11:10] LBWS[9:8] CKEN[4] RESETB[1] EN[0] */
 	tc358768_write(priv, TC358768_PLLCTL1,

-- 
2.34.1

