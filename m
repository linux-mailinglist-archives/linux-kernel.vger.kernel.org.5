Return-Path: <linux-kernel+bounces-114912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E073888D29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B915B29A35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA31BDB80;
	Mon, 25 Mar 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkGn5Fc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B187178CDC;
	Sun, 24 Mar 2024 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323579; cv=none; b=lzgBWUS7ncQssMK2Jl/x/lSYP2gO3umjXVITqRPgPQ8UDtKB759Quro9p2mcNpVdvgkZ/Xt0zDTzNIrB6WlysWCMT93BUy4qC+g0uaqdt2jl5iMFz/jv9VbFxZ2wsr4Vxhv8byYtuZmcL4z57OJl0XIKPXWc4+L5vMhb0DsCDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323579; c=relaxed/simple;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGk1NnY0tLm9sTi0bFMoLcq9dEuwjNBmgrRGWEAORdPml+st+pSt1ETKhso+gFS0ySMhVayuEI+qTT1maYyABo3oNlKXzeRp2e5pJ2uuUyWBWvMri9FNQBigUPSHbgUkeJpffDkPLVMrHhdahNZ09GAygp/aO6Pe8KECqmjzb4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkGn5Fc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE1FC43390;
	Sun, 24 Mar 2024 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323579;
	bh=8ZKUgi6Zm68D4WzC4t+cU2OxTpDWbRbA9/z+ZTeTjWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkGn5Fc+/RBxXR8DBGprckP5kxVjYKQY5Pvb7cEehL3i2PM1z4OnWL4bHqT5WV/bJ
	 Nyv3JXJgEQMRT34QLwS10+EL48ydnjxzdPcaKcSS6s4Y31/CPm0nY8b8p8w9K2CFGI
	 nP7V76wIcjVCxC5/dC4Lzn0tV11p6J1FPyMGt6H5huth3MVFUu7WG/7ZCBUByYIrqA
	 jnLPQAPAW6NqXNTzeOFQSjxCrWn6G56i3n5RLZ0P6cmHS/eSOZocH8wikS+j2bjXEA
	 tWRoEHi4QYOfa2MWD4ONIAYAv+yua4oWXVp3DDxzmrwEXa1ElFavNRaLbNT8DZuIOS
	 Iyfy3xGFSk5ZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 285/317] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 19:34:25 -0400
Message-ID: <20240324233458.1352854-286-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


