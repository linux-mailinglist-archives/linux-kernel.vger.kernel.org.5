Return-Path: <linux-kernel+bounces-113416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37535888426
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696A11C23BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2FF6FE0A;
	Sun, 24 Mar 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFnP4UBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEED1A7748;
	Sun, 24 Mar 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320218; cv=none; b=sj96FebuRpXvFqj0D5/WcaMZny1gWGRya7bpjzXoS3Fkmok0Dt/nx9H0/fG/o1GmFJUd+PGX9M2WvOhEwa7AT1PB41wc8ucLBLFuFhutYq4eh5UhG94oeByNP90y5HBGULQQ1MooaC8hph5psZtjAKFwbWD/Zdo5ji/GuTLLuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320218; c=relaxed/simple;
	bh=KnQngKGxdKRkjwaTzXWgBKDVujPnpf3a2kI3BMOlzY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSRndEr5YJlp0aMtF1AKIc+jC72ZqleQo9PirY8dNx6I54lw3vjHQjQ0XhzTzCl7Ou2XF+Hfs2D3tQHGDNmsgW9QV0EYEGjZeTIjqAcbyJx5AZU+QqxZ4NxweDf8raFDZf52fCcj1lqAngu8Xy2F1kEipid3z5Oyj2CoCpItaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFnP4UBp reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB79C433C7;
	Sun, 24 Mar 2024 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320218;
	bh=KnQngKGxdKRkjwaTzXWgBKDVujPnpf3a2kI3BMOlzY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFnP4UBp2hhScCUf1ribuZhAF9qP8fu/g5zK8KTUxunzjgY1/6qTp59tKL28CfX00
	 1j6I93ZvZ8HrL3YYIPhrkmhgCRCgfVnNNTnoSnticuFMgBUbkY7gXpadTuOWzjYP5M
	 y7FbLgRQTq9N8EaSttzQV5B3hSSHxti1jExYcM/c8l4JDou6lALTx+wsxWU6BA39P+
	 IPx7gLSd+3z1ntjF9teSlyux6vsgc2NwO76+PAh9cWzvMDXVLiXQId6MdhRljRMUKe
	 mW0i5/DcmIk4UxeMpGX5gwMzvrfcNcTxhYuIwnCly1r3DUIoLDejTcfFYab+pdzIHG
	 wM9XrE1wYEyhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 525/715] backlight: lm3630a: Don't set bl->props.brightness in get_brightness
Date: Sun, 24 Mar 2024 18:31:44 -0400
Message-ID: <20240324223455.1342824-526-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 8e275275b808f..26ff4178cc161 100644
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


