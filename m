Return-Path: <linux-kernel+bounces-116198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2748895B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB6A1C2FB98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074C0290BB3;
	Mon, 25 Mar 2024 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcUbY8Xq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366317CF4B;
	Sun, 24 Mar 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323806; cv=none; b=qIuq+pOK5DnqpRuFE7O2kWzMnYxw6yM96n8dN/ZBTxgucpbO8tftOOZtCT1h4h+zH6WN0+lo0OoX46zJTYHohtkH0LDM4pQ6fB0z4f1B5bo+1rUQQFXSqfH6y8pzXMfkSJ2dEvDW6De9r1j+WnHXjYfydvDHD7yH+1BgsvDCqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323806; c=relaxed/simple;
	bh=GjnkixaYReP4YOiLR6rVD7j38RgaCnm3GMPZmZvMefg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amMSKSvOoscDrd0bFryZUf9LrvCmQYKSuCX/oBy+4twVhaYgsLNS9nQffzIu37o4F8h9I7KQSKUVwSVFcD6t0Juo7q3fokgUCXQJINQ2POe5dCsPSZX22KfJ4EeOJsNfhfUPjn449SGT613/tsZSVzBBde29LwghslGZKoTbTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcUbY8Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787BBC433C7;
	Sun, 24 Mar 2024 23:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323806;
	bh=GjnkixaYReP4YOiLR6rVD7j38RgaCnm3GMPZmZvMefg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcUbY8Xqo/lwdFkWGsON7qSkri1HItutfMmU7mXcP8P8Hp3Rc60LGRTS380CJUsmS
	 YC4ykzxRg/N5+TFrq03+ijSTcHKbnB0U3DbKAW/QWtw0jblvHyddJnjlCI2mZw+uou
	 +vEkckc11Ar9jkwSV1Dx6XYlmvNtQ9qjbvXo4ytWByd4wZDlwQk9w3bDJ3WH5nGK9P
	 M+Ua/xIDV4WOs7JKrJKPnE2TVDPFqGQuMamLaR0u42gxuC48GKgEK2S1sBLcAzsayq
	 8jnxTG/YhK/ztnBSi7dPe1AhcXGXRNa9c5BViR2VEZBW0lR8XTIF3VNryKhCV2+wJC
	 KppxcafWaO6MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 184/238] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
Date: Sun, 24 Mar 2024 19:39:32 -0400
Message-ID: <20240324234027.1354210-185-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 2aade66db3cf4..2134342c2c97d 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -229,7 +229,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -240,11 +240,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
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


