Return-Path: <linux-kernel+bounces-113961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC15888EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730AB1C2529E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522B21C985;
	Sun, 24 Mar 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEhXRFQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7831F10C2;
	Sun, 24 Mar 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321073; cv=none; b=ACodIMvEEKcGhkQmIemBuKFVLf6cX7HGx32WfSd5aco6FGwOsBDE3YrHrGPnVeTLxHobh7Cuxb2GKc9TSNcMJc6nx6S4o8N30usxRKxeuqJassHuy3gKkBdQIiZNJKaADhJqsMU1s2/wPfY0hKg1gHWuQOtWVRVfHxh4IGoJCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321073; c=relaxed/simple;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyzfNrJcPKWFBFExh98NRoPyQGmnllR8Q+Ox2S0BtNpdtG3Lc5B1EbImbgzovUeHGR9LF1KEEwRaLT0fcigv/GIMNotkJkqXkYOPF6vmYS9oV8R77GjKDCdxxkfO2kIct0/7KavIU26HYn7quoyMtJClXeHRy+ja43nCrnf/y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEhXRFQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330BC433F1;
	Sun, 24 Mar 2024 22:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321072;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEhXRFQ8rn9Bk/8ir2I1gPSx3qwaqtfLpfhDbxsNMxeZl7HjCG81iICYGwgiRMrwc
	 1CaMSUSpSoVzSWqiXRxOHzfdHFb/HKNclM6NNR48jR6lXtsLS/xq8HS5mpGBDSSde3
	 4wUyvMidAq58VA7aeoRqEZbgu5nRhIItJgbwWWu8sYcF9lbBkuBTKG90/G6rfa+oPZ
	 QvMe5iHJBW6WYvr24RqzfaaiKPll4lnGXVAbYcj3KbbsdDtWfVGA71m+AdIk79UlLs
	 rGr0JMH/kIf/b5Nys5XmrIVz/C5t9hBiPlz2Z6ay3c4AHAsLMbOQM4u5jWPgjL4dGv
	 Yni/6LLzKrKMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 635/713] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 18:46:01 -0400
Message-ID: <20240324224720.1345309-636-sashal@kernel.org>
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


