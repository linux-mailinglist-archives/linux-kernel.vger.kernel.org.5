Return-Path: <linux-kernel+bounces-115258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2560F888E02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31432905F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F84316EAC;
	Mon, 25 Mar 2024 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKVN2H6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C322F502;
	Sun, 24 Mar 2024 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324374; cv=none; b=J4h4OnLrEK4kWds6xi5P4YWg3RWyIq5IBMq1JHylm+LlkeCsvr96C1Fvgr4zcsoQlglhI8xJ0gPYmRFDwNu/qlOaE1P3kdVAuk6DNGD6zc9JJf4CubhK72/DevP8wZgqZ1ocaCfudY6uLFHLNpaNTQsA3/WBdf40BPG5+y3NuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324374; c=relaxed/simple;
	bh=stj3yIGL6BZHpi7EgfUVHmgxD/4JfLOOJXM7o+vgo1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYjfL4M1oh7AJJqQwT6y971M+uMSi4ek1MU+W2axfKKPVM7JBU60z4efTT0/Ku7QoRpcRvEv79MCLwnCqmudnR5EGLbUi+f97Akxpa6GWnzxauOzJdvCh3bZlNznxFXPUl5w5O9qMSzN0iNyu8nOvziIjsNUZgU5Bw1vyipLJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKVN2H6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57B0C43394;
	Sun, 24 Mar 2024 23:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324374;
	bh=stj3yIGL6BZHpi7EgfUVHmgxD/4JfLOOJXM7o+vgo1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKVN2H6Fx18jHIaVERBsk7EewKIEOoQNjDPjgZ2kzTwDGix7Xhm7CgB0SW0i3YeMa
	 2bopDt2urelxwacumf113aa2Z/4ngWtj6uMbLp8ubsSClaPsCmuyXyozqs4jB6JwzQ
	 q1GJq2C4qej+DQWHWQTcSjWEEqrG6CQRPixR7f8l8iBBMiOYmoDJToOcPelkalfBx0
	 FTa70Y2OLr5fZiZxukSOFzOWVtg1azRnuTP5szCDckf8j2DWA8blQNnsbm1oziWZmh
	 lvbLqZv8c3srAih1LfKiQN84jqMDLn5fv/9Bfb27YL1ca8DU+tFjAMrnxfmrP7n/sp
	 af7dp09EQz0qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/148] staging: greybus: fix get_channel_from_mode() failure path
Date: Sun, 24 Mar 2024 19:50:04 -0400
Message-ID: <20240324235012.1356413-141-sashal@kernel.org>
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
index db06cd544af58..8c5819d1e1abe 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -102,15 +102,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
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


