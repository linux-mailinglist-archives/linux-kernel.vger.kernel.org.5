Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4253A772496
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjHGMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjHGMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:29 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CE1BE1;
        Mon,  7 Aug 2023 05:44:22 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RKGGq0HCKz9snG;
        Mon,  7 Aug 2023 14:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lFYFCdN0sdgDJqab568y4FkGp83iqOD14+wLiTmK/k=;
        b=X+esrlXFZ/MEzzW7OH4/kL8xjhT4yVMKWsJ5rwQ2pis+OhbiLwOrAzmFdeCjIF4xBvzfq1
        h5pEqnjdul3/J+w59+Ai4b4d60AXkZk9TD9b+hW/utWoHSTc/4a14hq1RNfcOzkXHCvChk
        FIASFa1vjfsMgnBmlOuMV6BpTxuMW4plr4gEnU28BrAuVbgW7guqj7jjso/sucAeH9zyie
        aFfV/ZI8g0tRq6Qbk3dsCRHkyil6Vtucf/GsRJAVBKdrPMUGeP3I/h0Dq6C2w+ypJCUI6C
        vnJB7BP6ZzJvzJgYaYSSxlkRwBkDv/h/YX+v3uBj5+S66cN5fr5ElGCVJiA2VA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:42 +0200
Subject: [PATCH v6 09/11] clk: sunxi-ng: div: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-9-f173239a4b59@oltmanns.dev>
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
In-Reply-To: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2176; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=lF1bB9W1an2uvrdtnkgXzTklsJAiLLQesxIoCOqHDY4=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcLKCUZ4KFM13LA61e9BOpBla9sUzPL6WeP6
 Hn7EqWG2ZiJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCwAKCRCaaaIIlErT
 x2z+C/9qavB0kYFaXXtRGKJopVSzHgKC9VKmG3SqdHxyG8n9a4h66qSaL47rv0CEngYPlJ6PVVs
 8FxzFcBqT+1Xzy6/0ZMhCLo2ADnhUgsqVJX7FyR0iO6LeGzNB2chyZUzQP5dBlGozfSYu4bMiek
 5ZkXSV8g7fOMDim28WQ8uOMVa4Pv8XQVqjm4sichhiSZpy4V2wBTFuBPAq5v1eGZohKn3GmuWAm
 VaN5fugkDoRbzrEOX/IpcV0NTk0O2XCUX4Q8NiCobERNlqRMLwqX8FgGy83AB1tu2Bumbj/adpz
 gFPPK/iSP3FEr4F7Kn32YzaSDD9BqtWXmcbvP8fYxLgMBM2RcBaTcXr4cVHSrTDLmbbJNIF4yy/
 SGRAUOIMUxSQt5SVtfEcAYeKS83+a6/HCXFtTHsVu4ONnM23d+ssYfnA8XX+PbT325r695Tgdv2
 fXuIqA0vfT8TaqbTafAcyDmzN8+XE1UtThaNmhy8Sc4zptakKYaFsE1lIH4Sq7GUmXXQY=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initalization macros for divisor clocks with mux
(SUNXI_CCU_M_WITH_MUX) to support finding the closest rate. This clock
type requires the appropriate flags to be set in the .common structure
(for the mux part of the clock) and the .div part.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_div.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
index 948e2b0c0c3b..90d49ee8e0cc 100644
--- a/drivers/clk/sunxi-ng/ccu_div.h
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -143,6 +143,26 @@ struct ccu_div {
 		},							\
 	}
 
+#define SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		\
+						_parents, _table,	\
+						_reg,			\
+						_mshift, _mwidth,	\
+						_muxshift, _muxwidth,	\
+						_gate, _flags)		\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV_FLAGS(_mshift, _mwidth, CLK_DIVIDER_ROUND_CLOSEST), \
+		.mux	= _SUNXI_CCU_MUX_TABLE(_muxshift, _muxwidth, _table), \
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_div_ops, \
+							      _flags),	\
+			.features	= CCU_FEATURE_CLOSEST_RATE,	\
+		},							\
+	}
+
 #define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
 				  _mshift, _mwidth, _muxshift, _muxwidth, \
 				  _gate, _flags)			\
@@ -152,6 +172,16 @@ struct ccu_div {
 					_muxshift, _muxwidth,		\
 					_gate, _flags)
 
+#define SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(_struct, _name, _parents,	\
+					  _reg, _mshift, _mwidth,	\
+					  _muxshift, _muxwidth,		\
+					  _gate, _flags)		\
+	SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(_struct, _name,		\
+						_parents, NULL,		\
+						_reg, _mshift, _mwidth,	\
+						_muxshift, _muxwidth,	\
+						_gate, _flags)
+
 #define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,		\
 			     _mshift, _mwidth, _muxshift, _muxwidth,	\
 			     _flags)					\

-- 
2.41.0

