Return-Path: <linux-kernel+bounces-115247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A73088936D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3005F1F32C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB91CD9D7;
	Mon, 25 Mar 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcFs2qBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8E2987A1;
	Sun, 24 Mar 2024 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324356; cv=none; b=V65F03TQN+WTZVmDHpNuWN81rtq9PI5uI6iFWND6O79lPawJZzRQpuLopm7kW68X3o1cdXN77LCeUXXvcrld8dOYaKZrsDDlzF2/EzSEAKkHbCLwDPejqizJBDj3p1aeV+Nfc1Clva1IPKTgfzqX9zNf7JosWl6aHEhp3RRXpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324356; c=relaxed/simple;
	bh=mdotRbRW3+D/0FDAKISCwVBK6CS6MfBHluslxDPlEfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnaF83anlnPllf5KVNkSdMnE0XP8/IQB99UytOvNARJmWGlK/Pm66b9+K1dT+NbQgEtSiuRBN0Iq+N6K2OA+z9zMPOIoWU9x15sPTf6o6B6RMmsp957DzIqQN9bK/dUVq57unzMojXE+ZTuqoDaj8qfYFy6F/27r5V5FYhhPnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcFs2qBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9705C43399;
	Sun, 24 Mar 2024 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324354;
	bh=mdotRbRW3+D/0FDAKISCwVBK6CS6MfBHluslxDPlEfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OcFs2qBGUXqCsxzMsNd+EFtaGwNOpa9lRSqrwBk6qdCsiwACEhiF0DQF911wNxnSt
	 FoKzmGnAoArZYILlaSAQ3ZnlsJzVra4xrUidCslfq9vUA3VHRQXFcUUD69OV4WxxbT
	 NtgwFFxzQel07s1U8ximqCnrL/68vQzVeFBrp1GXIsaXARWsioAWgloUE+F3OPDLgm
	 KAZrdfW/EvqUJ7r+8Byud+qM9rFb80HJacnN0o5uJ3+V3eh/b4FVZg7nbTnMKiBw+m
	 iVftqw+KjkIAQUAalO6MQmMsyPfkr7MzRYdUgg4w9a9bhfdUGQXMhb7m4Nk9aqTGeH
	 j9LckluphYyFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/148] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
Date: Sun, 24 Mar 2024 19:49:46 -0400
Message-ID: <20240324235012.1356413-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 70f5ea5f210cc..874040c465f20 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -223,7 +223,7 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -234,11 +234,8 @@ static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
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
@@ -300,7 +297,7 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
 		if (rval < 0)
 			goto out_i2c_err;
 		brightness |= rval;
-		goto out;
+		return brightness;
 	}
 
 	/* disable sleep */
@@ -311,11 +308,8 @@ static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
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


