Return-Path: <linux-kernel+bounces-98229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1723877704
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27F21C20E84
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2094381AA;
	Sun, 10 Mar 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="X+LJ+PCX"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB34CD5;
	Sun, 10 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076954; cv=none; b=dpuJWGwx5fnXVMQqg0FB51JafFw0c+s0/vOFsj6Up2VBmARB0fvdHarAKpf3O4VkuTBojnITx7Kj269rK4uY+skHvQcHQPPIXhIB3bTJYs34aRhda1cDsveLqrUfwng5Iig+1QekabVfkzKQY2/Qfarks69uXaHpDaoy6XjJuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076954; c=relaxed/simple;
	bh=ZV5lBxre/6M2MuCOOKXnH1cRS8cfBKGM9w8C16rRn4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnt4jxNsAND5AMKdP5L8JYcra6gPY8ZtJaDVNa4JUDo5QL5UeUCVrH03YeWLcHIxHS7r4TnnDvzRwbqLd8gW/wVlyqlZF7DrPa712gMhnFNaCL2h7L8PngtnrdWyHbZozbJH+DjVCqbJqRB/9BDIbc+bXxCT15lMAlM8o9VsQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=X+LJ+PCX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tt0v91JvGz9sqF;
	Sun, 10 Mar 2024 14:22:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1710076949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSwEbrk7HLbiVNg/S8Upg2syVPjC3LO4YtPCBym8jns=;
	b=X+LJ+PCXGwxG9G4WS/TRRQQWedm3WrIvjNGcf3IyPuDYlUdkiR8+aKGzow9mcas8qKnQRc
	YGAWtICRa3gwaSG28TKplt4sqEY+4NUQmZ0zL+6hYrWsIWUtn91n5bqKyqg2Wjd1mQXvBL
	adkL/gXYJtM6gtLySg6aq4Ut0PxfzncW71dPvTN5I8wlyeutdRULyOCh6mRDQZJAXyeCni
	4GFFGLolP9o/Ouaog8EbHezhjNKSdGhE0vDOe+xPOOfrSr2GrUqJfB3tyy7cmzKo4fjzwG
	NiwFP9RBa/Et2VvysOvVi9wnvUOaU3baDGHcIoqF2ihzLO2IaBWLZDMIXpSV5Q==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Sun, 10 Mar 2024 14:21:14 +0100
Subject: [PATCH v4 4/5] clk: sunxi-ng: a64: Add constraints on PLL-MIPI's
 n/m ratio and parent rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-pinephone-pll-fixes-v4-4-46fc80c83637@oltmanns.dev>
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
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=ZV5lBxre/6M2MuCOOKXnH1cRS8cfBKGM9w8C16rRn4M=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl7bP5PzKfaGxOhYTmRIANrgQLfc29z0qkcLMY5
 hLBpAPDsGyJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZe2z+QAKCRCaaaIIlErT
 x4qGC/9nHquFxNJvKofeUqKDlB8/fyTNUMkYgkr2J09KVCyCOfKhKLCLPq1RbvhQHYMFO+KkUVi
 y09BPXCYu7AzXNqEIRKtZukM9fWHve4cd4fn87D+lG71JxXN00HbEXZm1dgoL0g7PPhI1rtkpkh
 cEQk4PpdAm5ES+3EA0gIisbpVs2dDJiBke4aib93cTm0KUGdaLdePvgGbiqRI5oW0h85QSEDYCZ
 bN5UgmdeX2wdyPM9YAgVh0eK7uzfFYC0lXvOBN+Tf2gWOYWTQTcerLgSAzSyAvt7YSBwFd8rmxC
 mbBedFXmxAD1HzkgRCB+raRJF2V6Gx8Itmz78c15p0/X5+Ci0BURgx74ArMWF3d+o96FD30kvh9
 MURe4DjLkNSjQ1wlKtBIerPYzvzllO/ffiZYcBxhFF0qy6WFQ4BDY6xBsayaq5T2Kxb8N13aMp/
 S77ODkYZ1lsCkQhkMtZ/6r4PLF3vDI+AiEsk02A0igrDst6vqtx9CCYEGZxXgJEMDgCH0=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4Tt0v91JvGz9sqF

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


