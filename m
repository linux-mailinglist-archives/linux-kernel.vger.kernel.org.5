Return-Path: <linux-kernel+bounces-52893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E90849DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE771F212BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233752D05D;
	Mon,  5 Feb 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="K+kMj2W+"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7843A1B6;
	Mon,  5 Feb 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146594; cv=none; b=qOPzP2zZmn2rs4QmVqwNRmNjxeTcwolDCwRQRVeWyOaWjTrCU0nThVpjZLmkF22QdAHF1DcM0+GGff9btw3BYSR3VWnOOneMYElAN9hAZ8BLSeENda/31KmBBzcXBtV7N4vgorjvg8KgZB+DZMY37Y8YmfczchazLFDLnP80qto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146594; c=relaxed/simple;
	bh=IJ2XTYWEqbQDEDOuM1uZXEh/F0ICX+aNVO21sCOdmPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paCTGSplAvS73uvTqRJy9hzqNz35M5hU0D41gMZ80333iYlk6E9v0VijgEHhLg1X4/O8VbiMfNP4GG1X4Qy3OhkE9tL8KmnKI5kNehAXt24InvQQKEF77ZZjz1bMxklfPG/BYBGD76Lx7p4VHFKc48xqHFGycN8Gtom1Q1bdUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=K+kMj2W+; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TT9B539gnz9t42;
	Mon,  5 Feb 2024 16:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707146589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBDoGEw5H7zjvt4Tn4WN7vmGiia6CbPYmP+MFo66pMQ=;
	b=K+kMj2W+vma/KQ9lAWxsYbj+TWWA3C2lkGsfIe6441w1ujtQ2uNtMn6ZUO7h5vb4SIHRBr
	Jzmb5bqn+dwiDBPrnXeU5V6iOsR8gkYsw9lxyBowwqW31AbcbuSEyn/IGt9kRlM3eH5y56
	4eqitwpRFKd3OKpGpg3za4bMpBgjeGhA+CczJZ3AGol9ULQUmB3sfV63QZr2Wt1XRsUfXp
	4+FeUMH7ElT+IL0RtfEKiiFqjHYx2ilENgx+8F5Oj1b5VQkdXqni9KShvH9lK07JVJYD9D
	DqnQk5K7D7expRK/BSqA9G74tW7ywW3qfBdg8pSAzrGrLTuLobnHCzuRwcweLw==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 05 Feb 2024 16:22:27 +0100
Subject: [PATCH v2 4/6] clk: sunxi-ng: a64: Set minimum and maximum rate
 for PLL-MIPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-pinephone-pll-fixes-v2-4-96a46a2d8c9b@oltmanns.dev>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
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
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=IJ2XTYWEqbQDEDOuM1uZXEh/F0ICX+aNVO21sCOdmPI=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBlwP0/l0UwLaujQoqVqlgAplWnj9SkVd43u27AR
 hJ8ppQSdNeJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZcD9PwAKCRCaaaIIlErT
 x7FXC/90qKkh7DIYRrFjWYgNWY0/pU4JrxhWDBtAHt5wJpTbydki4DTNL+Q1Fn3RK90LKDg1II8
 lByqgCm7+mE5XoGJaawBugzun8o0ScmhgkL08Jh+qfmb6nW/TKHXK7Fnt930z/k8dEbA229cxcE
 ASuS6FKwzV5bMoLe9PLDgbCuN+qbLvaPFq0XI7CV3pbKlasuOZ7IeC31au5eqAyLFJLO3Z6N5yI
 Ze35tLjN4dvaESV5GOJIBFsVxeai4Gl0gjkPLU+ls+W9BHJWVGtvuLiQLnF3xzvuJXZ26rOf3Xa
 4AXWLf6S6J49g1SIO58p7ZOEdMy8nrgMgNZJcLgFcJcihRtO+unPygRjBxaeGD4q8HL7KLr4fwS
 TX4zIQFIbeDigF8Nuzgh/J54TwigFxXduAEif32q3xH1wLbMeioZ8SW/SUC60jQAvpXADOrf4YA
 qg7rZVpM5e/yaZmTs9o85fHF8F/k2HyRF2Xe52/BI+Bl5TlplgEJ8G82yD4oMsFclQiW0=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4TT9B539gnz9t42

Set the minimum and maximum rate of Allwinner A64's PLL-MIPI according
to the Allwinner User Manual.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index df679dada792..99c2ce11da74 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -178,6 +178,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.m			= _SUNXI_CCU_DIV(0, 4),
 	.max_m_n_ratio		= 3,
 	.min_parent_m_ratio	= 24000000,
+	.min_rate		= 500000000,
+	.max_rate		= 1400000000,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",

-- 
2.43.0


