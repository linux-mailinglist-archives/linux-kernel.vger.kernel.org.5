Return-Path: <linux-kernel+bounces-144284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB08A4426
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8414F1F218EA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999913541A;
	Sun, 14 Apr 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1jXpuZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF34136995;
	Sun, 14 Apr 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112667; cv=none; b=AeRxHitD5/GQO/hWvuL/ztdhv4a+rI2YRPh2hGf55a/AHeCVuN9HJvhXW68MK4qcK64A6PvqKN42F+smjMYVrNA5wmNXopT5atiKfQyBBgmWhjljhETnJ/8p24+tiiaEXXXq44SBh6DbSoNqEueMwz7SGwxzUMObvP2dueXeJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112667; c=relaxed/simple;
	bh=I/kH75ChwTKatovUO+cVD/yXMeGrtVUzne0bWF7Bero=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co7BSPdhEP5oiyu15lt5I2TAnBrwohz9hxTAHi5O1wBZ9xC8g8omn7BVpPrVH3WiMEPl365CrztTtYJ+dtkgCpSp+bvxH4UUiCA2Hf0zi8we/5vxuNfzt3x1greSetQnWoN6R0moNVTPpgH/M8M9Mj9jCqfp3OK0HWJUi0Z022I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1jXpuZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC323C072AA;
	Sun, 14 Apr 2024 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112666;
	bh=I/kH75ChwTKatovUO+cVD/yXMeGrtVUzne0bWF7Bero=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r1jXpuZM094AG4sLOkIkdIPIfXrPsKTLcgdJoi8qm2StTaYtrKmCpdVsMJvkwlFoM
	 o5dFORCCyU2rb5LiXYwmbg9jPOR85fYhc13iZiLX1ifEiH8qIyVWWuQ104KRHb5+tA
	 T9X7AXJ6/heUNOaRwWJ76ShoY5sXfGhIMX1ihiLJwBw+mWKbRtGInLR3we6Xmmf/SZ
	 QZDTebzTfbLlZT++j5EqvHXlb19dq5gbPSLs6evIV79EeAXgQPPGza2yraquEO83cJ
	 QGuvGLKqoyvbBflAV+ob+MncvLq3IxCLpE5CcLGKjeIofur7VYiKkB3B5mepf5IlBR
	 kW/CvRKep1H/Q==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:14 +0200
Subject: [PATCH 16/18] fbdev: clps711x: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-16-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=krzk@kernel.org;
 h=from:subject:message-id; bh=I/kH75ChwTKatovUO+cVD/yXMeGrtVUzne0bWF7Bero=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAYAnrIYrAOTDHZlnP8WOV568OXufBGJkmSWK
 2M/WqLiZriJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwGAAAKCRDBN2bmhouD
 10odD/0YwUT2uItZP/jSF6IWzto56RNclF1/jdlmG9EV54NNKScB1thR2UzVNcf5UMWYzk/O/4d
 G6VlgyYkdgY98xvr+Xw1KTTNJEbt8CNBLw482bkZPU6jmkQejqZ+KPUFuXKBhLatcKJ0fTBMia7
 quIfrsHCqeWtvpemVHBU7/Xbm/amFPuuf1zKuziB9qBmptbIHvRdMNZccimd2IAxvYEizi7fIOQ
 gV68YHCOWruN2o5E+rq7XdL5VaKbBYdtOhylo+SO5SS2EbsHsNQ9DMEUB6TKV1l1fsCon8ikk38
 aZjhJBx8jZ1TWPTwRvAhTlQVvZSTt7Bw/JmizAAka1Cr70ALEFhLB2xTfzhBVqMt1Oq87Hq0tCq
 LWKms5Dkb1eYpxZWJC4w9eftkw8zS48TdKdIAevB9OAV10r3+UnH5jYkqnN2XgVznS+xeSldXCp
 ceL0E9hYFnYbEVJAKjVyEOhdubkMHvOuRluEDfamywF+5qa9PwbwVWVm8VvZHUn2IZtz/uVzbb6
 GBDG4h0oWOL4k9pCmYY4aCLZUKCx4f2Y3SNtIvrMmEO/O8xUR6HyuK6Dv2hs775l+phDUmKZR1D
 jTuLA9PWvEIEOjPvn3/IO6vRbu4vK8XNxVd7lh5RLXmDuGlAzIqnevAf4IDFuTHYQIBA3oPV73d
 +K/d+3trHJlfvlA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Depends on the first patch in the series.
---
 drivers/video/fbdev/clps711x-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index dcfd1fbbc7e1..6171a98a48fd 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -197,7 +197,7 @@ static int clps711x_lcd_set_power(struct lcd_device *lcddev, int blank)
 	return 0;
 }
 
-static struct lcd_ops clps711x_lcd_ops = {
+static const struct lcd_ops clps711x_lcd_ops = {
 	.check_fb	= clps711x_lcd_check_fb,
 	.get_power	= clps711x_lcd_get_power,
 	.set_power	= clps711x_lcd_set_power,

-- 
2.34.1


