Return-Path: <linux-kernel+bounces-98228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D924A877702
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E31B1F21307
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEC2E410;
	Sun, 10 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="PtV2RTRT"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D729411;
	Sun, 10 Mar 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076951; cv=none; b=pW6UJHIQzDbOsGc+nPNIo5/51WiVPQMS6EXg6A5MbNFDrL1a30TuFxMwVoe54GjwrmDM75NqQ052iqxw3vbTvoTc22msN0GsmEOG/GIxYZlk8C8DgFpXgbvRGzfUYjjA0N71hjK+urqG3Bt3wzhg3W4vA2XIkwLXmBUuCy+ZFVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076951; c=relaxed/simple;
	bh=cWJvD4kuynMAtMT5uLtxnwY8oLH1NsilC8b3ZEB8+cU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZL+nhGUL0IeQqVgMGlN+LCRizgY48/yk7NBO3Jz7V/j7lNxeOx2tWkaGeEhA3sgeJJQd/F+DpnvYRKxvKGVKhMXycbYBg9VpkR9URP/MGVN5YHODJBI8xi/atKaVdLZFcjOX57zDvgzf0Pnrpo4J9jlE+zLAn5y+jThMEc4KJUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=PtV2RTRT; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tt0v0060fz9sb6;
	Sun, 10 Mar 2024 14:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1710076940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tUAFtRbxGvc8iX6JY0PD4/Rc4PD2SEcW1+r17X7Ljv4=;
	b=PtV2RTRTPN8N2u0CbqIk/J2x29QlvCvhfSqZ9jvdnx5h1KlTJUgOsv9FPD36tVuGM8Ll7r
	ufXYBil6l95z/DoPr6cQX09Bk6e8YxJWcxXlTMkw3Sef8rEFkym5vtzKN7bz+70XohTV0q
	SaFw21g+kDqtvvXdP52avUU4Z72gbVev9WNLLj03M2Rig9ucpwGOt7rnk3Xu7ZdGDwENDJ
	SLCCZ4aTADDyJRNxowwriiA3lIUcNsJ9jDIB/IFa2Nm7c/nmc1GGq545htNocfQEpikZoF
	NOZ+c+akJRL5myjHnxqyErHyC2TjrTVAgX2e0CecgRNieiADS3BAAvoLrWcm1Q==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Sun, 10 Mar 2024 14:21:12 +0100
Subject: [PATCH v4 2/5] clk: sunxi-ng: a64: Set minimum and maximum rate
 for PLL-MIPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-pinephone-pll-fixes-v4-2-46fc80c83637@oltmanns.dev>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
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
 Frank Oltmanns <frank@oltmanns.dev>, Diego Roversi <diegor@tiscali.it>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=cWJvD4kuynMAtMT5uLtxnwY8oLH1NsilC8b3ZEB8+cU=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl7bP53Lez98R5l+BpPUkN4t68Hnq58iOfjCT0n
 da5fIrwczOJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZe2z+QAKCRCaaaIIlErT
 x5S3C/0ZYTeWiGBr+WsKmwU0bXaq4u1nkNKkN86DZhDhY7+qYYBhUS1VUprNX6a539W+8/J60UM
 X4E3yj8ku48Mr7w1+9dZC9H7bnzZEf6YMrdGrL2tg883LIKMgsvSyn+JgapZrTE+vG6USzZMDzc
 ptH9ALrIIN2f9Ih8D9drPECcKXhRzEweBhUpWoff18M5C25xew2/rJWqNebefGMwSoVEm/28h0i
 ECegQwZDItrOLlTeeYvmrXnURm71z2cIPB3QdUMYkB8z3CSZNvgSFuHykY4aJGJvZUsnR4/TNzy
 jhGXSXTF7dRShqnvO1C4xK5ZnRkya1xgOOe04U/k2sLekzL5y7VChTCnYZjiITZ79tb24Go/NDa
 LkTYoZIr0glgk8Zk8p4Pvp2lfs7xlxBR5Dr69ZnVvr62LNhKFGTy2gJy3w7MSn3bwwlTh9j7VTb
 ORbor/d01S4sFolpZHe7vMfLPIpsRxlh3KDWrfdMrxij9YdnKi1S/nrzhBTGfftAJPNos=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

When the Allwinner A64's TCON0 searches the ideal rate for the connected
panel, it may happen that it requests a rate from its parent PLL-MIPI
which PLL-MIPI does not support.

This happens for example on the Olimex TERES-I laptop where TCON0
requests PLL-MIPI to change to a rate of several GHz which causes the
panel to stay blank. It also happens on the pinephone where a rate of
less than 500 MHz is requested which causes instabilities on some
phones.

Set the minimum and maximum rate of Allwinner A64's PLL-MIPI according
to the Allwinner User Manual.

Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
Reported-by: Diego Roversi <diegor@tiscali.it>
Closes: https://groups.google.com/g/linux-sunxi/c/Rh-Uqqa66bw
Tested-by: Diego Roversi <diegor@tiscali.it>
Cc: stable@vger.kernel.org
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 8951ffc14ff5..6a4b2b9ef30a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -182,6 +182,8 @@ static struct ccu_nkm pll_mipi_clk = {
 					      &ccu_nkm_ops,
 					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
 		.features	= CCU_FEATURE_CLOSEST_RATE,
+		.min_rate	= 500000000,
+		.max_rate	= 1400000000,
 	},
 };
 

-- 
2.44.0


