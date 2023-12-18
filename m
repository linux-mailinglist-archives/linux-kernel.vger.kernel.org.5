Return-Path: <linux-kernel+bounces-3751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42837817090
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CC11F22625
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A052129EF2;
	Mon, 18 Dec 2023 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="WB3Doh5k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8751D136;
	Mon, 18 Dec 2023 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sv17K2gCpz9ssY;
	Mon, 18 Dec 2023 14:36:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1702906573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3knn0KnfHEWgYWaadr1J0evJJiSgFisyuPOwfE6u7RA=;
	b=WB3Doh5kKvL3k78nLJhWQFOk2fz64k4yLEVREuaYRL11WlmELNwJnVC4VMp90rfJ9MZ2ul
	dwbxOOckPhBVugw1Ja6zntM4xHkDYJxoYuCCiMKf25IhBnGbatVlzdZ/Bf7xBrFc3LYAjb
	UMkcloU9B44sJ+gLt0SAZXQKoBJmYDlhlDcN3bO6DvFaEjlsPdEuuneqRGEsUoErAJ0abH
	OrAFgyWCw2AEl6N/62c+eiR7zKJioQZTXYnnOKFp4gmZ7Uen2i+G7rtAASgJsQcJRZCbsH
	RzSxFpyKaGjap7H2pCuAxGqJ6PZetOb6i+qumcyTlMFXn51HRrIJBKQW1midvw==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 18 Dec 2023 14:35:22 +0100
Subject: [PATCH 4/5] clk: sunxi-ng: a64: Add constraints on PLL-VIDEO0's
 n/m ratio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-pinephone-pll-fixes-v1-4-e238b6ed6dc1@oltmanns.dev>
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=jj1kC8r64WXDg1/5wbxM9P8hCH8A2GebZKvM1vIvFPo=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBlgEq1xinOlh9sftstb32086w7Ky1jm6/lGaxZ5
 NrpDnJiE4+JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZYBKtQAKCRCaaaIIlErT
 x93iC/9GPVPladgryx1JLV+61g8cBhKv2Cudg3FL/5IIT/LP93v+OTcSmNzjfcQNGNz1czgvP3P
 m2srxWLpJXHtskjrNSrFM2K16MDEUHig33MfYl1n8Q4vN0taaY+bLFbKlFKZjhuMvuQte12QG1m
 oRbq5Gm6B1ss/VIjAksUn+QzzMjHz0xlllP894PtmNR7yrfYU7eBdvEnV1xx53Q0nVuWFfww7AZ
 dTdG+1RiE4j68NAnJtiB4E4nni7OITmxS1es1FK4UDLC/38jSLl2FjGkvv+kLLwAJGRcmVt49PS
 vIRWeslKFohfcV7CJDoVhuKX1vExq6PBoTiB94VCmo3DgsIJPgZ6k/XusI2eFYQxpaEuQcYhzFD
 bwSOtn2l6ZGTf+nCqnTLltr3qAFY/flWypH1qs1fNzWOHtXZoPBpct6xJU3pEe0XPkA9tpQmUPk
 RsrQui/HQyrioIOF9OI+iJFPG9ZxK8J0p0xV3Zx0ABNPxg6fDgalK/l4zkxh1LeH5WwHA=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4Sv17K2gCpz9ssY

The Allwinner A64 manual lists the following constraint for the
PLL-VIDEO0 clock: 8 <= N/M <= 25

Use this constraint.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index c034ac027d1c..75d839da446c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -68,7 +68,8 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				       BIT(28),	/* lock */
 				       CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk, "pll-video0",
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(pll_video0_clk,
+						"pll-video0",
 						"osc24M", 0x010,
 						192000000,	/* Minimum rate */
 						1008000000,	/* Maximum rate */
@@ -80,7 +81,10 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk, "pll-vid
 						297000000,	/* frac rate 1 */
 						BIT(31),	/* gate */
 						BIT(28),	/* lock */
-						CLK_SET_RATE_UNGATE);
+						CLK_SET_RATE_UNGATE,
+						CCU_FEATURE_FRACTIONAL |
+						CCU_FEATURE_CLOSEST_RATE,
+						8, 25);		/* min/max nm ratio */
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,

-- 
2.43.0


