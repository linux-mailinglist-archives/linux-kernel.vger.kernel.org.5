Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE66771533
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjHFNH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHFNHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:50 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D860797;
        Sun,  6 Aug 2023 06:07:43 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RJfrD33wsz9sW4;
        Sun,  6 Aug 2023 15:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/3jUW02TnjdYtDtyTpuIK2UaIeAHqfX2p8U1BU0MxI=;
        b=gE7Qe3FRFfS94coh3aDOD8vptroCe3bBW+0OxrKURdeA3qO5Ju1i3fiatm7ld2i9Cb4pih
        ZSLBYQsXzfxcKogOwUvKKMk6r73PE0iW+vK1bIUTk7Xq9pivsMGGtRQJxyAigKI4qunryr
        hz6vbUGlnzBwyD+/hy7jlGkYxhTixrljqUcddK5rANl281G8UlXGSLEMYwjS9c+iWAI+cA
        lnFJCxZmIrpoSw1kHGw3Eb59hArMs20dh8jea63dNOlMtiFJUmPIuw69VRQYR7hXUGHvaY
        MP2ywuLMlrJYqfhWvWIb0caXFfxntEqLuJWRuj/lwZLnd6i0zKXe5MNpMxNvFg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:54 +0200
Subject: [PATCH v5 09/11] clk: sunxi-ng: div: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-9-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
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
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sIf22ZiEzq9muhL+X98DikF0J5zWcMcfZ/X
 JEogB868vCJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bCAAKCRCaaaIIlErT
 x0KHC/9K9WzyLIVvorKsrsgQ0ioaRIfo7CZj7TNN8U43TMKhkP3w8KNLB06KXAc44ncAaVr2VTq
 rbJjUSPcSOR7JOAl1n4ViT4rTmULgcBXJXuHSHz2uvU1+6JonUqsZQn5i1ug2ikBDXFQXUFuPf5
 VK3opMLlzgsVK06LrxsvkznBDULFAyWLfN4SAMnz7IuRsKaXR1lgwrMFiQ+t5kmcI8vwZagiiuC
 hq0XZNza6EZBAfkGO2RwfCd6116bcbXGs7BtNe1mDKivmc6dov4ePoR58MQb1y977nPJPRpYzR9
 zm7PTQFjx9HIyV1ILniEC5xu1/8UWKyOkdZqyeTvPr6HHxUoEmS6TKPOfEJd4c7DnGaioTgzVZj
 4/2eOvlbnbfBARSo/vcEXMF/xGwd2BGYNYQxgh8p/v9V0inCm5KPzmGpuka4KloQYjRA/Ak0Hup
 MfeV1lUJlxgVnek3hus37oxUyXowYFfRfJVIOPhR4Inf+P0K/2nr7CbJR+11cgC/W5kxM=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfrD33wsz9sW4
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

