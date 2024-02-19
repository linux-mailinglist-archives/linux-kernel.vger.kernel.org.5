Return-Path: <linux-kernel+bounces-72123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF885AFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D036B2107A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585C56B98;
	Mon, 19 Feb 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="1bEuaatO"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F5C54BD3;
	Mon, 19 Feb 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384309; cv=none; b=Yi+YUSvU5U3XC7CMVResLtc3Y2O45PQqYCiTxIa6/LbCXkpcLz6iPcmyDi292pFow2ue/dkuutBAZWDeH2/TuzpJXbsJbg5LKOCeRbLZiX3ts/Jyi/3ceJCpDDQ0tVkP5/MMH+phLd1GV01zYgF3qo3ItEnwbvkPFdzqmEi3wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384309; c=relaxed/simple;
	bh=4FVN1lsdigo7viniW4HQplRB1ye5k50DGqYItrjf0oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/R4GOIP6Q2ykrWawnmuPXfiSygmWgpX1JJoH/0SpXC3WZQfeIW91N2ksL7XkpH8+c963G42sYdZ/fkbpeUZV4tLgFJXqq5vY28fhCqSoNYcXyao3LphLur8x0E1RanblNaRsWOyYNtxxdzZBPCZFeLwvFl2bLTEleQCKiHhm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=1bEuaatO; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708384300; bh=4FVN1lsdigo7viniW4HQplRB1ye5k50DGqYItrjf0oQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=1bEuaatOD1fd9xD70XSQxeSdxxdIvvmBFP2Gdb9ZbycwZtGPxi8rlZJkihq0UWmFe
	 rcthh3ZWuu1dzYuxfTwxCsHH4GG4h33s5o6JRgO+rD6tZuPyKiJERctJm4IBkZHYpc
	 9d2mJJxvitmqJT7tYY7+YbT4WJzy6aDVfjrkAwr8=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Tue, 20 Feb 2024 00:11:20 +0100
Subject: [PATCH 2/4] backlight: lm3630a: Don't set bl->props.brightness in
 get_brightness
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-lm3630a-fixups-v1-2-9ca62f7e4a33@z3ntu.xyz>
References: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
In-Reply-To: <20240220-lm3630a-fixups-v1-0-9ca62f7e4a33@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "G.Shark Jeong" <gshark.jeong@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Weigand <mweigand@mweigand.net>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=4FVN1lsdigo7viniW4HQplRB1ye5k50DGqYItrjf0oQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0+AnYpKXaDh4PR2QorZC1//Jx6rBuSWTvVmRQ
 ss0kIhVH7mJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdPgJwAKCRBy2EO4nU3X
 VpElEADPFLgNHVWgOTwC2O0e7/NUR5zzEQnnFlqCsJBvQqF8rZ/gmLqtpf1YSlBjltHklrDcCM4
 gnHZ5XCeF+JQqGh+5w3Y3xRDhM8EVtv10ubomUNe3h2jbLyb26lt5/vUz2GfoJJTBN/2yQPZMMI
 jwzpQ8T5ojxpYeKlsRhTZ8cAtu7dobFXxxwjeI+kj+diFjnh57XbS3ddJAaI+tXKAC5fb798oNd
 VzVsNUg79xo6ZWYsJdvhyNMyxg3TuqVUYeV2yvy/vWX9Z3Y0fOTGWFwY5OyGBqd+Zu1i7Yl5/c4
 Kg7Ijq0Q2Lkx5rhD+k+VUNW3mNGwYO77xYre8C+DBvtE37DqJz8GrdhSe1sXKeVSnYoy1hJ2j6p
 OltUTu/OKh/K/VK24W/Ldj42oEYAyYM4t6/J0f5Qf1LGm6I4Z/IC5qcBOgyOZ8QZK04alIxBCZ+
 7sk+Lp5bE/zBSGw7EOcgZKo8hnQaqk3tfSo4Bdna2B7KUaJtabDwDbTv1lJf31u006rkkG/2Hhb
 VRiNJYWlDbF+ZhRXr4sr5bwNKxRPJRoqiDZzpXxdOfuNyBy89DUA+hx4frbZ+nn3owi6HyiZdh+
 7DE8RTwwEN6DNh4iajbZ9eJOtuNWe/Be8n/l3FN79wR1EzdbkZxpfnR/fxJdotAs2Cxi+nVlO8l
 iFu1Pjz0fHEmQXg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

There's no need to set bl->props.brightness, the get_brightness function
is just supposed to return the current brightness and not touch the
struct.

With that done we can also remove the 'goto out' and just return the
value.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/video/backlight/lm3630a_bl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8e275275b808..26ff4178cc16 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -233,7 +233,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -244,11 +244,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
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
@@ -310,7 +307,7 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -321,11 +318,8 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
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
2.43.2


