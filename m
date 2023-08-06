Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF13D771530
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHFNHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHFNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:39 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE219A6;
        Sun,  6 Aug 2023 06:07:38 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RJfr70V79z9scB;
        Sun,  6 Aug 2023 15:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulpryhyL1fmeYsGJ/YbYMV/lxBA4ghi1gWFL1YwCRLA=;
        b=KsXWslPsWmf9NXndeQm54LZV4BcpuJ6wHnsIP/f/GlTaE1Mgo+jE4KlLvddkd8vg6tAP84
        01zIaaxSGLIQo2tDkHSJB4YUP9kfNwmZdkdd0DjcQ2GL2qFsTtOJY6kMiNdw0+jrwUlyrV
        AEHVl51tGoKTfLdobt0lmrG5mMVY2ex6qMlaciwTK/AmHuibxIqhCKTl9NLRcRcTzeynuV
        bIqC8LV0QHDSU7RTPA8mQNO2AM9FVFkQnKB3ZUE3DrL1CYwGZuQiCrRAsdFtajLWzTRPzF
        t1M+3g1sj9qj+w67sXYSDjCrl0bhYCsZTiCFBL+DvCbCSvEMDYOxF5aFlsM26Q==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:51 +0200
Subject: [PATCH v5 06/11] clk: sunxi-ng: nm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-6-db4f5ca33fc3@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5235; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=eW6KkKaJ9BQvJtir1IykKZIae/DH/+72MOsKsB7WpzM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sHaCe4x63fqDVI2fzQrrTVMflGiKCkwMDd2
 uHSSYPnV/aJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 x+wCC/4/kr9Lq69CJmJGUjpmSqRJ4YQouLR0zby+65slLsTDPXnS/S1Mh8su03yaIX+OPwkMEo8
 Riyo7dzalkvoL/7xe64MeBvDMzOipw77vLWb8mY4bh66hiYE6LwyF+qpkdyKdY1ac613l+kPBBP
 YAC/gxRlDyDYoELTswccVFpOP+2j1kg5qMHrqdrx2HYI2hzYtwuAkWRnQS1t0qmNAEIGPxXX6M5
 7/a7z/CcSMbnfAoH6layOojzAbeVjzw3lL6vyRggcYBMq5b+E0LrO9DUb+WneTBLdCebL9zEiaS
 E91yqmZVafz9wevFW3jaQ/T60kfRSxmW3Zw3p2rUtqy9Vp8+ZOoET6Tz4zo+CDCSUSDX8cTrRts
 bTKZbzgBKnWusFuf6Wz7xkDUhztgyqROgkj2J5e5Bkp0WgnL+DtUBTWKXHnbq8by6rzE7USGPBQ
 9OSI9dXNRzpgJIBuFIdmsVXj8Vj3d1RglOpSf9fjIqhgMwKn4+xc4tvrN03TvItfEP+2A=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfr70V79z9scB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function ccu_is_better_rate() to determine the rate that
is closest to the requested rate, thereby supporting rates that are
higher than the requested rate if the clock uses the
CCU_FEATURE_CLOSEST_RATE.

Add the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST which
sets CCU_FEATURE_CLOSEST_RATE.

To avoid code duplication, add the macros
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT that allows selecting
arbitrary features and use it in the original
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX as well as the newly introduced
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST macros.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 13 +++++-------
 drivers/clk/sunxi-ng/ccu_nm.h | 48 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c1fd11542c45..ffac3deb89d6 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -27,8 +27,8 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
 	return rate;
 }
 
-static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
-				      struct _ccu_nm *nm)
+static unsigned long ccu_nm_find_best(struct ccu_common *common, unsigned long parent,
+				      unsigned long rate, struct _ccu_nm *nm)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_m = 0;
@@ -39,10 +39,7 @@ static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
 								  _n, _m);
 
-			if (tmp_rate > rate)
-				continue;
-
-			if ((rate - tmp_rate) < (rate - best_rate)) {
+			if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 				best_rate = tmp_rate;
 				best_n = _n;
 				best_m = _m;
@@ -159,7 +156,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
+	rate = ccu_nm_find_best(&nm->common, *parent_rate, rate, &_nm);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -210,7 +207,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 					   &_nm.m, &_nm.n);
 	} else {
 		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
-		ccu_nm_find_best(parent_rate, rate, &_nm);
+		ccu_nm_find_best(&nm->common, parent_rate, rate, &_nm);
 	}
 
 	spin_lock_irqsave(nm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index 2904e67f05a8..93c11693574f 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -108,7 +108,7 @@ struct ccu_nm {
 		},							\
 	}
 
-#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
 						 _parent, _reg,		\
 						 _min_rate, _max_rate,	\
 						 _nshift, _nwidth,	\
@@ -116,7 +116,8 @@ struct ccu_nm {
 						 _frac_en, _frac_sel,	\
 						 _frac_rate_0,		\
 						 _frac_rate_1,		\
-						 _gate, _lock, _flags)	\
+						 _gate, _lock, _flags,	\
+						 _features)		\
 	struct ccu_nm _struct = {					\
 		.enable		= _gate,				\
 		.lock		= _lock,				\
@@ -129,7 +130,7 @@ struct ccu_nm {
 		.max_rate	= _max_rate,				\
 		.common		= {					\
 			.reg		= _reg,				\
-			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.features	= _features,			\
 			.hw.init	= CLK_HW_INIT(_name,		\
 						      _parent,		\
 						      &ccu_nm_ops,	\
@@ -137,6 +138,47 @@ struct ccu_nm {
 		},							\
 	}
 
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
+						 _parent, _reg,		\
+						 _min_rate, _max_rate,	\
+						 _nshift, _nwidth,	\
+						 _mshift, _mwidth,	\
+						 _frac_en, _frac_sel,	\
+						 _frac_rate_0,		\
+						 _frac_rate_1,		\
+						 _gate, _lock, _flags)	\
+	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
+						_parent, _reg,		\
+						_min_rate, _max_rate,	\
+						_nshift, _nwidth,	\
+						_mshift, _mwidth,	\
+						_frac_en, _frac_sel,	\
+						_frac_rate_0,		\
+						_frac_rate_1,		\
+						_gate, _lock, _flags,	\
+						CCU_FEATURE_FRACTIONAL)
+
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(_struct, _name, \
+						 _parent, _reg,		\
+						 _min_rate, _max_rate,	\
+						 _nshift, _nwidth,	\
+						 _mshift, _mwidth,	\
+						 _frac_en, _frac_sel,	\
+						 _frac_rate_0,		\
+						 _frac_rate_1,		\
+						 _gate, _lock, _flags)	\
+	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
+						_parent, _reg,		\
+						_min_rate, _max_rate,	\
+						_nshift, _nwidth,	\
+						_mshift, _mwidth,	\
+						_frac_en, _frac_sel,	\
+						_frac_rate_0,		\
+						_frac_rate_1,		\
+						_gate, _lock, _flags,	\
+						CCU_FEATURE_FRACTIONAL |\
+						CCU_FEATURE_CLOSEST_RATE)
+
 #define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
 				    _nshift, _nwidth,			\
 				    _mshift, _mwidth,			\

-- 
2.41.0

