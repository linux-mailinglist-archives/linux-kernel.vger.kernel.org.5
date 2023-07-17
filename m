Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4E756528
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjGQNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGQNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:17 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF319A;
        Mon, 17 Jul 2023 06:35:03 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R4NP01KS4z9snf;
        Mon, 17 Jul 2023 15:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/3jUW02TnjdYtDtyTpuIK2UaIeAHqfX2p8U1BU0MxI=;
        b=tOkN5pKOx/QG66krLStl+PVvmmizHhe6WeGPOaHcsKbRx0zyT9QEL9xH5fbcBgmndHgaSl
        jEwpeR5witjvILRLvw+wXqCwiyUPDZQfWpfvZJouX35rxgZop454TQGi2xEbTy1oSFebF3
        LwmvMkuCnzMK4FLu5vUYJy7fyid1jWRUoBgi72iGhNLLpYu6p8LUXoLn006oXWb7eIVcav
        XvQSWS8bGD6AX3j1aL9yUJm5JzvijZo6vqLYJ+Qh6NBVnsxZERBQbqYlNJ6/18+8uPDmMf
        h7Qml49y2dVuslyPbD2qj5Niz2ICPX9M+/gSUJrrSO8Q8AO3MWqsaLrK+93MGg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:34 +0200
Subject: [PATCH v4 10/11] clk: sunxi-ng: div: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-10-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=BCjq/TvLd7Vyg2yzlkEqCcyLfH3Gamqs91hzh7NVMYE=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNoT0Lb/4aaPfEOSUZsD95gYYYEFGS8osezM
 eZygrPXQfWJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDaAAKCRCaaaIIlErT
 x3jmC/9sXIxogKJxgU6bUUqiFwW1lk3xSpv3r/WTMY+DG0XznivmpDmsp9Sm5kyboIMsiqO0w6W
 mfp86U/AfzP96aY1SdfyF6ELHDsHc3mAt6qrbcx3Nueiu8OQsfuneHb2l3TANOjI5Iilh0jeUoi
 941jnUi8UgAIBo/iEJmRkEAkAe04OnIg/pmfFiFN45PLOkNw/FmERTDHzbbaQpZEQ0RJcurxQuc
 x5b9yE38lNteWYtAsMFZ2h5pAzhVzLN80EtNbQTa3CWkDWV1GN29zdbUa25Ptc9agSFo9emHgwy
 TKYFEgYIqs35pYJ1tCp+Dr0o4JD7LUwsAnev2DPweEYNqsNRgGw7uCN9uL8VT2VqehJCoR2hcmO
 mul8vBYdlSA8sOxfRnhOK3aZAM8a8CgZwvOojoVElE0s/JWCUB3g6NObldSuhRlSERph1TIpdSV
 75uMLcAPwkgbw7a6w8AWvW7heRPRDpes/+QZYAWl3mFrjNxGKvYkvMHr7N8po0YGGF3fQ=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

