Return-Path: <linux-kernel+bounces-3752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8563D817092
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C5F282343
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D74129EDD;
	Mon, 18 Dec 2023 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="eLflKYcE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84D1D15C;
	Mon, 18 Dec 2023 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sv17Q1Z1Cz9sv0;
	Mon, 18 Dec 2023 14:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1702906578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHjXX8T22A8vSDhmcbXCgVqx2gpy6+LirkB+PVRAonw=;
	b=eLflKYcE7WuO2izSmh+X4mn7M4W4r5tiLf9tLy/gpwJ+HYuWpLQlyVLDfp3gMot+v2Cv2N
	EiK/PmJIEErOafvsXPHmGQY90NZMbO/zi1o7/xuzR2ocO/zYJ/N6j/s/YVYfb39sT3SwtT
	aoww2i0Hke2YsfumQiIWt5egYYkJCVFq9CmRzwfLV3N+waySq5cjnUT1xoiZ3BSY9ChWB3
	U7I7zD9g71JhPSGIUVT448PdHgMiaNjileX7O6INdR6Jrij23kJ3GNRPPEaVbmlIW+BcsX
	1DwPFtGSrXbqD8QVz8/tksdd7MGBqGQ42fZMYiESibwLRyicfQwoUSb2sybBmQ==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 18 Dec 2023 14:35:23 +0100
Subject: [PATCH 5/5] drm/panel: st7703: Drive XBD599 panel at higher clock
 rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-pinephone-pll-fixes-v1-5-e238b6ed6dc1@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=SAMO997ikQjd5G5gtpw1xcptKu2mOxUiT+50d/YBtmI=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBlgEq1fGk87SLdf4iGeylAn1TQ+0H3qF+BNVT6u
 HjpEFxEqgCJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZYBKtQAKCRCaaaIIlErT
 x9WPC/97CEvcAl7/lqqTgFUkj4zb5ppCtk9rJIICkdmTftzH99U8PSxmXE0nEf8iTgYdjng9Bx0
 k8h58NQZlu9Ps/sbc+lo0PbQuWCGnDUYRSw3H97Ct1ju7uKs714t69LhGUtgBK1JFsg4vrhv9Ch
 d9E6vrurGJ+KKUbl1lHArTu3cD9ygcg1q6K1kfD1AsHzfH/dQWXUYjSTsrv8jgagl7VerjnL4r6
 dqLNaVl1q5iSJV/RqerAulhUjp6A0frnJOsnltaZiECVdfsoa2ermOBOgrApTJHE8wsJwTw0FXy
 pkBvnm9ZXsaQNI+jbMt5sWUZDld7hwsIn15rF6BpanhgXL0XS8fDVgpKQFLfLK6+HyfkX8js4u5
 X9xCCISayV/Nd+L7Wlx0um2UprwxuUoJ5uwkLqD9urRVV6ievIWaBnoNMSnOoQs5Xk8GancYKVF
 Tun737PSoCemEJMoweiWRqO/Jb7lnbvPtEmDmapfv8mKeBY6rfIUXBPJc2BlVRJ+rq9Gs=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

This panel is used in the pinephone that runs on a Allwinner A64 SOC.
Acoording to it's datasheet, the SOC requires PLL-MIPI to run at more
than 500 MHz.

Therefore, change [hv]sync_(start|end) so that we reach a clock rate
that is high enough to drive PLL-MIPI within its limits.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index b55bafd1a8be..6886fd7f765e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 *ctx)
 
 static const struct drm_display_mode xbd599_mode = {
 	.hdisplay    = 720,
-	.hsync_start = 720 + 40,
-	.hsync_end   = 720 + 40 + 40,
-	.htotal	     = 720 + 40 + 40 + 40,
+	.hsync_start = 720 + 65,
+	.hsync_end   = 720 + 65 + 65,
+	.htotal      = 720 + 65 + 65 + 65,
 	.vdisplay    = 1440,
-	.vsync_start = 1440 + 18,
-	.vsync_end   = 1440 + 18 + 10,
-	.vtotal	     = 1440 + 18 + 10 + 17,
-	.clock	     = 69000,
+	.vsync_start = 1440 + 30,
+	.vsync_end   = 1440 + 30 + 22,
+	.vtotal	     = 1440 + 30 + 22 + 29,
+	.clock	     = (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 / 1000,
 	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 	.width_mm    = 68,
 	.height_mm   = 136,

-- 
2.43.0


