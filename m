Return-Path: <linux-kernel+bounces-116290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8A889E05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F191A1C33C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E243CCC75;
	Mon, 25 Mar 2024 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI/8JcuG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66093180B7C;
	Sun, 24 Mar 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324149; cv=none; b=m8rYmS2/7CXC73lNHJVkVsOq4b1ZHA588V4HTioOif8gLXEOdKhDmxIFvxosjHUF6lbhb9mFq+DSviWStFXxbs+erOvVBJrd85SLeZ6kGKReM+0d7tRvTcA+nNFft0HEWFp8onmIunvj2SDFm7bgQGlBjHb9EYSdWY0FWXpa6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324149; c=relaxed/simple;
	bh=IzTEcDebd2Jwpb/mHtM3aH2GYrOGj5CQjm4gi4PxzwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4GpwGYmgGj+i9yalQ7XxGnu1XaW2bIvy/uDHWRa+N7949/zni2qss5QDV7RiFWuHKuujEL1Sa7msPNIkMcitm7qSh/brNh5NXPpmYiUzVJ3XVKNYdg02o8BRld2n/RzUFbAhEiErudThio4/B7rUmIvC19BemxxioR4Go0h+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI/8JcuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD58C43399;
	Sun, 24 Mar 2024 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324148;
	bh=IzTEcDebd2Jwpb/mHtM3aH2GYrOGj5CQjm4gi4PxzwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hI/8JcuGkwWhGVxBG8Sw5xLdBQIExdTHFxNGiUadVbmCBOk8vT/gC7ECD49HThaBo
	 i7tSaS4EhUTr1DPrasHSdZKu0hCQaI2GYD0M9dvL5ybAK2/AYPwQAT7Z0mBZUF9oQK
	 ixx1pAc9OQNe5FUc4FvdMvSj1EF3GZx0BvWjU9n4TENiF6zDRbq5O7gUhUj1uHQkGO
	 th931oj6oiVUdFYr67FkJZhtAmPTUHn50HQO1dZ0Aq5kfl/UUItzH9VHY6pK+lOllN
	 yawXk4/4JY7sQC0MdTj2epNI1aCf8o2R6vs9WxiIvRE8Cl55FhjzKiLxtR5FVE1L+J
	 wpEHEYaJxYEoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca@z3ntu.xyz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 144/183] backlight: lm3630a: Initialize backlight_properties on init
Date: Sun, 24 Mar 2024 19:45:57 -0400
Message-ID: <20240324234638.1355609-145-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit ad9aeb0e3aa90ebdad5fabf9c21783740eb95907 ]

The backlight_properties struct should be initialized to zero before
using, otherwise there will be some random values in the struct.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20240220-lm3630a-fixups-v1-1-9ca62f7e4a33@z3ntu.xyz
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8096202fbe5d5..a381b3990986d 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -337,6 +337,7 @@ static int lm3630a_backlight_register(struct lm3630a_chip *pchip)
 	struct backlight_properties props;
 	const char *label;
 
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	if (pdata->leda_ctrl != LM3630A_LEDA_DISABLE) {
 		props.brightness = pdata->leda_init_brt;
-- 
2.43.0


