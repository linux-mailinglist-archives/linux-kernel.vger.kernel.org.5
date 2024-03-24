Return-Path: <linux-kernel+bounces-115969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B18898E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0324F29CF39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CEA3949B9;
	Mon, 25 Mar 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOOZJtJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31563232117;
	Sun, 24 Mar 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322257; cv=none; b=uNs+wNTK/TGEFns+T+rAix9wzacY5sYW71yDtkq3chaMX/L+XvEEcb/xvp7U5UABa1yh0A1oyQN85Jg7nIocDjuFqCBG4VdkxpztQIpAhFrSZ7A6R3bIHLGD9g9K1Kg5kdYyJe+yMQqGa7FxZsBpD3BYSYzlfn4KHzlhkL5ieGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322257; c=relaxed/simple;
	bh=qSKxe6142rJK0Ne88XZvstcmyQSGACKS9WVwUqirlh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/eHQpFCM1yLtez1w4NVTzKQY9h/elZBnjeWdbVSSF1W3xgjwKZ5sC5+yB6Rhh9/aa3Tu2uiQ+PI3IHD7ADNS4Up36tSO0PyLN5+TJ8QiFvEFt4YgSDyzm+JE94bsx6QeDmX3wTJsYp3vVVrIchGhQS3jftmal1fkRxueJztNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOOZJtJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C377C43399;
	Sun, 24 Mar 2024 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322257;
	bh=qSKxe6142rJK0Ne88XZvstcmyQSGACKS9WVwUqirlh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOOZJtJiw5aG/W42OcMtxjZhQh+/MsTYA8i3K30bxlYlB0ocyORvMqt0uhNPuYJNY
	 zL65MyqMBC8MS79pGQOa9HJ9Y7idGAMfrn442U3tRNmXTWdJWv2qUFxdgisues2av1
	 SfgcUypOIIkwWFWv62o7WBDG615/gSsNwRsanxZoOXPngYopOwZF1CYPEFEOf0tY4R
	 DfE/sIIEdhGUN9rqmcInETFB4VvoMHgwr5yd3GtsHaWP2JFK5yPy4bI7gRGw9YZqRi
	 LISDA+EHSDM7uH2c0XxH9QKuUQtU7et0qzNoGDs6D3R03uqCb8qzuJZH/SjayaQGeA
	 ROS7X4b+1Spqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 339/451] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
Date: Sun, 24 Mar 2024 19:10:15 -0400
Message-ID: <20240324231207.1351418-340-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit 4bf7ddd2d2f0f8826f25f74c7eba4e2c323a1446 ]

There's no need to set bl->props.brightness, the get_brightness function
is just supposed to return the current brightness and not touch the
struct.

With that done we can also remove the 'goto out' and just return the
value.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220-lm3630a-fixups-v1-2-9ca62f7e4a33@z3ntu.xyz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 855c275754578..0d43f6326750f 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -231,7 +231,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -242,11 +242,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 	rval = lm3630a_read(pchip, REG_BRT_A);
 	if (rval < 0)
 		goto out_i2c_err;
-	brightness = rval;
+	return rval;
 
-out:
-	bl->props.brightness = brightness;
-	return bl->props.brightness;
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access register\n");
 	return 0;
@@ -306,7 +303,7 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -317,11 +314,8 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 	rval = lm3630a_read(pchip, REG_BRT_B);
 	if (rval < 0)
 		goto out_i2c_err;
-	brightness = rval;
+	return rval;
 
-out:
-	bl->props.brightness = brightness;
-	return bl->props.brightness;
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access register\n");
 	return 0;
-- 
2.43.0


