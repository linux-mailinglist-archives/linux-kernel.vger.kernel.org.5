Return-Path: <linux-kernel+bounces-113521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506E8884FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466E41C2438B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26277352B;
	Sun, 24 Mar 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1vjtTmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B41BDBA6;
	Sun, 24 Mar 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320323; cv=none; b=Hyrn4UWsVW1CPufZwT8XFOopKQqUdjR/vwShZM4ZVsG9z+QTm713vZ/8D4c5phG7R1hLwm1bpu4C2Y15hwc7iNl1inGD6UABleYQ0X1rFkvWH8hO72OHB6TLW2JxprkbznaitPmkl6hBAVRPpsSvF5y9WpJGysbLMMBKnDFBto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320323; c=relaxed/simple;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6k2COOr7hJqYN5i0OZmSij+yCaerr6AvHJup8jwdvHVVSuCqyYwYD7tEQi8Xug12gPUtUsz7Xz1z52fYE2vWET+1VXM7SGw+A3+8h7wPdj8hxzOiPJdaPjhM6gus/eRhDvF995pFlRWPUFIOoekIyg/lgvX7QLBzKWzoKAyRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1vjtTmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B3CC433C7;
	Sun, 24 Mar 2024 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320323;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1vjtTmrpSloYKyhjMJJ9XDnZz+R5oC2JHuVwlOflTRiuQYgXmBGOTnAtrNRVlDq6
	 Gqm55jpK1IFQla3SBT75R0j3aV19db1VJZUEcwHlOKqpafldLt1grcd9RhY4qnR5y0
	 0zNeKNL5y/aX/PU8RQT9OTdPafYKrpjcV/SB64UyRR5fUvXLIMguBfuSsYlA4KGmbc
	 UPE+xAZ7UHxxq3px5hcnscaVoc+7ixiQZAjbCerL+w/3vHLfu0fS1eqsvLALYdiJNz
	 XMvq7XeJP8k7JqaBcA7YvzBU0Wi27G+H/yIJcJA1waVS9o0JXoPlsJ+5CXCUE5CzsM
	 +WKBupIdYoXbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 630/715] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 18:33:29 -0400
Message-ID: <20240324223455.1342824-631-sashal@kernel.org>
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


