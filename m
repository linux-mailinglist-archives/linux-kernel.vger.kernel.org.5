Return-Path: <linux-kernel+bounces-113897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE2088873A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286581C26538
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA120FA9A;
	Sun, 24 Mar 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/5q7Fre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF012B17E;
	Sun, 24 Mar 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320981; cv=none; b=hL7FDCbupCUzWZ6MKvhBc/JaOATOuGfuIUuDRkvAK0vTF7ien+8RR3vxjS69iLRJ7hHKtyjXA8N6E5OllimDF/S6rEoYrSA3hwoxUz7nEMeC3mZd/wyy379+Y5ot6k/hR7yEXBazZIsJFQC4cMzueDLRj3j5KTAkgKyxE8rw7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320981; c=relaxed/simple;
	bh=ZvvuP1gdaEvy16AYadR6zQ+/sr0t4GLSEw8KeAIDwLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGyLQvlZRRdlvTgrwhLANVgbdVuFIuwzmYFF+taDpB0LeuMdq43ExpP9yxfGGHyjRREMk1y1oHj7tPTVfOuqIQZahTimP/HVKntVnMqnVtZgAXMnIBgZDP+xixTQTN+2BPC5uPYbWCSVNf6Vv/+XqJ4hlxcOcmgLxOIPf1lGKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/5q7Fre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AFAC43390;
	Sun, 24 Mar 2024 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320980;
	bh=ZvvuP1gdaEvy16AYadR6zQ+/sr0t4GLSEw8KeAIDwLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/5q7Fre5DY3BAUnv0CwvxomqULgIdH/fJ0JUiYsT/F0ZiRHT0PQwv8YM7GTEChpa
	 bqHhS3n3a2Syh8YKdce9rt6keb05i3oVmdcx+swr1+LOVN+N1sY6ozHNh6OGX3+EXg
	 l4GkYw5guIjtYVQajIziwbZgP/bv3hYeKdFfKYQsJDTWEsh5nkeramA9YmK9mrAaaT
	 68NNLEJ4k02w+4leTvVSEQmYfRZJg+2bItdIQYTnyZiqXzp9riewGh390y24heDFnq
	 0AuZfVfbz3ahdVhusuSVBF3DhosV8XVygqvzHRQhdIawtLmkX87Hf6/OD46E4EV1zk
	 CZv1BtVVzPaRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 543/713] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
Date: Sun, 24 Mar 2024 18:44:29 -0400
Message-ID: <20240324224720.1345309-544-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 2e2240b278482..7115d7bb2a141 100644
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
2.43.0


