Return-Path: <linux-kernel+bounces-114671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BD888BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C41F28017
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC2018AFE5;
	Sun, 24 Mar 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pewN/9CY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7318237B7A;
	Sun, 24 Mar 2024 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322316; cv=none; b=snw/V3LvFVG2aGN1TAgxA/9JAjbc2yaUnSID0heIEeWozH4TZ6pobzN6PR39C2pU9iIaioNBSYyumE4/5uGG8Par9QdCHK1AGjCQ9bdv030u8J212Zm9HRWHIIHl3+fX0hVFC+2yTT+HbPJsXl6tYCPT3QNsRNjiK8KHADX09Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322316; c=relaxed/simple;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsJvoJcv6ZFIOvoWHS8UCX6nTpgOKQ9JnYHILVVz9SXv/6kq/ei19pVGVLxUFGgzDqkdWDfIi8vsaTZyvgp+B8eeBi+CMFdaMhBRs5OxSzLj6qjW4Xxac/Ikg+4geK5AOn3EByzt5L6AF2oW/nr/zwV+9WPmn4CE7VjlzZ0wbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pewN/9CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B5C43399;
	Sun, 24 Mar 2024 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322315;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pewN/9CYLxpD93shOidL3wqjw3uzBt4KlUEpPthK0MYiodPef98j5aadVV7zC1NwG
	 SHO3qZnwjYkck/Y4NjdsbMU7dqfoa8HrsTrBuMz0+hCeqyOT9cTYYAQwSr8aItjFg4
	 q2ic4QjJG2qw2HoTBn5jFUolGBg/Sm0rxKTUXP9uyDWjHfQ2eve9rLXHG1eENVVqyH
	 06a7hI3mDH7+HKVuFSLawY//eJMnYGhXouOEJZCgdZUSy/nBbmrGUs00JGfhxoX0sn
	 itd8sRfm1SY8u/WJLSNQ/2DAtYzW93IVG941/+kmZEhcGXXJClrgCgdON3NttMVIjO
	 KRbt4y2zJi8Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 398/451] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 19:11:14 -0400
Message-ID: <20240324231207.1351418-399-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 34164202a5827f60a203ca9acaf2d9f7d432aac8 ]

The get_channel_from_mode() function is supposed to return the channel
which matches the mode.  But it has a bug where if it doesn't find a
matching channel then it returns the last channel.  It should return
NULL instead.

Also remove an unnecessary NULL check on "channel".

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/379c0cb4-39e0-4293-8a18-c7b1298e5420@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index 87d36948c6106..c6bd86a5335ab 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -100,15 +100,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
-		if (channel && channel->mode == mode)
-			break;
+		if (channel->mode == mode)
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,
-- 
2.43.0


