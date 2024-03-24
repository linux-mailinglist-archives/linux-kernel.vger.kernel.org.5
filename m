Return-Path: <linux-kernel+bounces-115109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E0888D27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E92628C5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8E2FC042;
	Mon, 25 Mar 2024 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTXTHELu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6725181835;
	Sun, 24 Mar 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324096; cv=none; b=BF18wFdOtRidV0GYeVHqL91eg50pAQs0vcNto56mG6zFSRmrR3ksuuSJYFifYPHXhYrK1MMnFugRBPWjmbFUa/tzjWrUzPCFO8gBl5nwg7+eUDt8+8aNYN60fXLZR2vHc5/Bwidy0EnYM4S4wzF8PDITlPpYiTUp+Bie0SiQdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324096; c=relaxed/simple;
	bh=ZVMI9u3hWeyYxvmD5YmP6NstIdy1DXLiyWbxUzkS5nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKOdSMjqKX4m2Lk+vLGNPGuzv0E6bVjD0LX1HLdT9dF59NudF0kCND2xvYIRTgaRpHe0RPIm6v0JlkjZPcMpUKjSJPnHTH5mqwO8VkjsjYTc0n+NiIYMvyBIG1XsggpeqCK9ppGbqW5vfxtcXjMglCzYU4rBWhPeify/8i34DbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTXTHELu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A2CC433F1;
	Sun, 24 Mar 2024 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324095;
	bh=ZVMI9u3hWeyYxvmD5YmP6NstIdy1DXLiyWbxUzkS5nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eTXTHELuAwQ1rfQGfTDMH7VlTC6tJSKt2tljjrXFF7qF+bCABDMWu31KxmsfOSvDB
	 wFEyOtG//diRUWHZJpE9hbBNL+pPVSrQUnhhSGIUv/pbr9Y5392EQXh+lVdxVgks3I
	 MG1Benvg9po2KqmApUOKbsiF1tkrE7IsEdhj4agUoWr3YCe4XYPVz5Vf1RbUoU7q5j
	 uJbwjdFO2n4HU0pxmssLRkoI0QJySQ3J9uaMNcTKsxpePBwazhCBzKf8m5oap9VptZ
	 PP/e4dEkduvJkDq9LqNhV+ZcRleMhimED6stXlVTPQ3qnnEQ+ThsVRWOr87mKDwIVo
	 surAVcDTwE8eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/183] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 19:45:08 -0400
Message-ID: <20240324234638.1355609-96-sashal@kernel.org>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 87399f1ff92203d65f1febf5919429f4bb613a02 ]

Ensure the device has been setup correctly before registering the v4l2
async device, thus allowing userspace to access.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Fixes: 4c5211a10039 ("[media] tc358743: register v4l2 asynchronous subdevice")
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240110090111.458115-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358743.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 76c443067ec2d..ef1460c61bea0 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2107,9 +2107,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2167,6 +2164,10 @@ static int tc358743_probe(struct i2c_client *client)
 	if (err)
 		goto err_work_queues;
 
+	err = v4l2_async_register_subdev(sd);
+	if (err < 0)
+		goto err_work_queues;
+
 	v4l2_info(sd, "%s found @ 0x%x (%s)\n", client->name,
 		  client->addr << 1, client->adapter->name);
 
-- 
2.43.0


