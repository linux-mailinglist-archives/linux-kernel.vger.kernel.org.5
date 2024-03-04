Return-Path: <linux-kernel+bounces-90134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB286FAD9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E96F1F20EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52829171AC;
	Mon,  4 Mar 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="hnMUE94e"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015A17998;
	Mon,  4 Mar 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537427; cv=none; b=Br0PxxK1F3q3MkuaX53d3gYgtGYEMj2epR3Js7gCgM3uHdjLc284sWrOs5sDm5/O8FnkgAwUs1SN+aXkWDP43rc2tO4e07D+uLJdYegpJ0FCDo8+Nu7Ff2ia8ttTJG6zcfzYgUTZLgLKqFrdJh9TUBMkd8HcwO7W+mI30Kt2DsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537427; c=relaxed/simple;
	bh=ZV5lBxre/6M2MuCOOKXnH1cRS8cfBKGM9w8C16rRn4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QheKfF0Dqhe/DTvVD/wnMtkDGumDeQBkCInCdpshDUnocP9xrkh9ghvz2FDqpSmxI9+fyn7ySDkifuO/qPVTP+W7IGXa2SH7aLqONWUHnSHoy7kc83QwNKFT2JkxtwLOVP1INO3musaqsqMrLfIYIcnQgAnVTots0Ti2efGV4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=hnMUE94e; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tp9Mf6Gchz9t4Q;
	Mon,  4 Mar 2024 08:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1709537422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSwEbrk7HLbiVNg/S8Upg2syVPjC3LO4YtPCBym8jns=;
	b=hnMUE94eFTk7/3meSA3lPUDhcANmAyf2OUzRmyopRvTRkekdefVX8wzpnGkQp1sv9KhyBv
	IfbW+QDMSmLZ3+GtT9bmG4vV/JFVhhYTeoq9Mh8yIdUAyuByhivftGfdQqgPN4s5S5nUbA
	DS+vI8hhRGsWZfOzlxJMRvjySh/6xytKadDJO0ys2VPduDKes1pyEC0rP5OgR2X1Dh2ts4
	k+ZJN3+DZ5cNgL5pS+Y+MhPiUKLIWKmZV26ne42vy2RRb3RcFqTb+dgzIzKZLaDeDg3OP9
	vR9tjS7btxDq9J1M1P0j2ZZQ9cJejnD5SEUkW+c99b9SdaN8TJMPhX3KBkjGxQ==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 04 Mar 2024 08:29:20 +0100
Subject: [PATCH v3 4/5] clk: sunxi-ng: a64: Add constraints on PLL-MIPI's
 n/m ratio and parent rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pinephone-pll-fixes-v3-4-94ab828f269a@oltmanns.dev>
References: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
In-Reply-To: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=ZV5lBxre/6M2MuCOOKXnH1cRS8cfBKGM9w8C16rRn4M=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl5XhwFVzk+/GW3jkZnWJuuvcW4xKCX3diggNku
 IU4NbYB8UmJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZeV4cAAKCRCaaaIIlErT
 x9bJC/9xR++p84oDgVv3w52KqA8uBXC2Fg6k0iu8fhrFt0qsCrVVLLCid0pYuJ4Mci4xU6I7rCV
 HqHUPillvCPJXD8KNdu9HfNUWnb7WzreaG7FVJSzokn1wM0FfmJ+Fz/AFGIEx1owOCxcDAX6kg5
 Spn86gIkA84i5ZadXuR/WGVdAVuWuC2NesdXK+I9vCOaHw51GGLG91CZiTsD/bZpwt5EolJxcuI
 bxAQjqTIoNZIDo/ThKA+GSnY9+JCiNSDRorLQpNIRMg3w5RXDhR9aJ6q9CSh8ZFs467EPG34Bek
 lRRnGeQEZiXDDvRbB9u0lc2h4XH0rUQWDXupeAe06MLdZYMc+JS2CZ7SM+0MoUN+nT1FOd6oU50
 PTQ0bJz50Wy93qdaVlLl/bVCTaQMiFBTEhwZzun3OauZTyB81vSdaDg00LSdY2a5qncY5tBav2P
 eIxJ19djY1yMBMyqrebFT10UDcvcI4+tmd+cjzXSZyf8u2cYnqlOuFh7wMVOOLPFTetGc=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4Tp9Mf6Gchz9t4Q

The Allwinner A64 manual lists the following constraints for the
PLL-MIPI clock:
 - M/N <= 3
 - (PLL_VIDEO0)/M >= 24MHz

Use these constraints.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 6a4b2b9ef30a..07796c79a23e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -171,11 +171,13 @@ static struct ccu_nkm pll_mipi_clk = {
 	 * user manual, and by experiments the PLL doesn't work without
 	 * these bits toggled.
 	 */
-	.enable		= BIT(31) | BIT(23) | BIT(22),
-	.lock		= BIT(28),
-	.n		= _SUNXI_CCU_MULT(8, 4),
-	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
-	.m		= _SUNXI_CCU_DIV(0, 4),
+	.enable			= BIT(31) | BIT(23) | BIT(22),
+	.lock			= BIT(28),
+	.n			= _SUNXI_CCU_MULT(8, 4),
+	.k			= _SUNXI_CCU_MULT_MIN(4, 2, 2),
+	.m			= _SUNXI_CCU_DIV(0, 4),
+	.max_m_n_ratio		= 3,
+	.min_parent_m_ratio	= 24000000,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",

-- 
2.44.0


