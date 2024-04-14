Return-Path: <linux-kernel+bounces-144274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2D8A43FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD91F21046
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29301135A59;
	Sun, 14 Apr 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJns8/57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B617135A47;
	Sun, 14 Apr 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112615; cv=none; b=XLEao4B9g6Rx/q14OanJSA1ODnw5npZ+oUbU6i2mikVH0hKWeB0giKz+ICyYiVlRAP0ie6JdKRi5CNoY9IcIlf9++NYd/zf7o1QTbeA70w7nqgZgd+gYMuy20jYSn4rLnRrHAVKMVKQnkTePdBI8LYFdedtvUbqbH6dPybYCK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112615; c=relaxed/simple;
	bh=FAuYOIrTLgKRaRcSRARSU7zwjltAT4O+9HdDJwuD8ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXjDKTlFYoi6Sd4kn1CIG/NMvpbJuxBDpU/uNpxDRg92B7gshP3AQuaOv8B3dz7DC56jtgampyl/u/K8eI0nuX/R1I084Fy5AgNttd+Ako/rqglRX6FGdu5nfba4iBMaSXI4SZBIjvQsdkGhxt0cdkyqnRX+EMgPNsnMDBhAFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJns8/57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815F0C32783;
	Sun, 14 Apr 2024 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112614;
	bh=FAuYOIrTLgKRaRcSRARSU7zwjltAT4O+9HdDJwuD8ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vJns8/57ERxdLuquGGs0ZVc2oUuWC2VralonWNd8YTD/YSVwkzSxsOTfINZj89z1Z
	 /Qscc/gpKeaqB5ZdK614E1pgQZk0p/hu5FQd82puJyxY9qiX0sM8Wfl6vzhnz7cO8t
	 BVoYeHeMeFQwC9GtHROIOGGxhcEZj/KkCEXKPljOagTpfxYZghk+cGNYOI6+wNVVCq
	 tGKkw3pI58jtcC+A6nbn/ksup4vqfnxbuam5Ye+UCIbMP/6+lm+Ux9wom7gr5WW4Vc
	 prJuv/SNZ3B4gy+KahcEmdggcRzy+9U+e+507dmVkWDichrh2s1nMP+sRzv/bYYiO1
	 yrimmWk+jVJ4Q==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:04 +0200
Subject: [PATCH 06/18] backlight: ili9320: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-6-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=krzk@kernel.org;
 h=from:subject:message-id; bh=FAuYOIrTLgKRaRcSRARSU7zwjltAT4O+9HdDJwuD8ag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX4uTf50/e5WzpwRZXFIhHsruOa+96lTtLda
 uXa+GcN/E2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF+AAKCRDBN2bmhouD
 1+OVD/0THs/Cz2UP+kdGP9h4rjM0ye8ChOEfbSBRSP5rdKoTYcydrMRVV/GuKPWw9mfpjY5ZHUy
 ub+uUBXwv4cdy+KU3N756O2qBkgxVYKz/tQ4rGC4isAHbmUppPN3Y6ICwX5fyXRbgdsCrk5otKg
 LkpoM4bBVzr2Hv88ZDEqAyOkhenTjlhddmzjjKQsoAt6VBWn0UEWZlbA88zKjFUOnZ2dENdFf5Y
 RhUbb+OqhyM5mqyXZ9gHDVpuxtwV34kAHEGzPq7G5w4I6GOcZTO0Hv9Xpj/M4tFxEqgZ+yDM4t/
 eHlRpc6WCoU9fkqatFxThhvYM6Y0FnLDPvn3HJ/fj+LXbsYKMHKtUM9IGWL9OeIhb2o+BG7o6F2
 V3AFljgHqYvqzm1w3sNhQ9BwRscfGho9HM6jOxYkWzOTd0WiVXgKGVWFqZQ1KcgJ/u0aqV9J3lM
 6wQHTK64pPF4PjC9ZGT8ZoArU5koJ7hIP7hQ1Ug6PMkQmWWroGdFcQLPEMHxNbcaar9NFOBPdzm
 XbI/jVXQa1n3TUQVYkdkhcGvqN5sYOJmGrYz1GOKfpddMuOlYTv9DKGj6HDIllJ+3+3cCzSz8b2
 7yYcGNtvqUoZD4QdQrpAANp9eIyFK1MmQ+4qGocUqx9jMot5LVhgVXDur1JX0sLShdC7Xjp8ol6
 yAosqP5p7RW+PBQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 2acd2708f8ca..3e318d1891b6 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -161,7 +161,7 @@ static int ili9320_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static struct lcd_ops ili9320_ops = {
+static const struct lcd_ops ili9320_ops = {
 	.get_power	= ili9320_get_power,
 	.set_power	= ili9320_set_power,
 };

-- 
2.34.1


