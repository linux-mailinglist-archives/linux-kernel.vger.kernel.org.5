Return-Path: <linux-kernel+bounces-114835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF08891A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4951C2D575
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795271BAC20;
	Mon, 25 Mar 2024 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dps6SYB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFE17653B;
	Sun, 24 Mar 2024 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323470; cv=none; b=ffy+8JmqnvHQw73/5nyhSoXsAYf+oj3mKX8gqvLeF5tbFg8qRQ8afIFLAeDY0/mW8lbTU/6sYmgq/vGJd1GJeYEmugNJV5g3ofmJuCaADMKKXN9uBF6I69GBctzVOwXCWhQpT/0Hy0HuTWvEK2dzcV3FUNHXEvQycils67PNfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323470; c=relaxed/simple;
	bh=YQYjx84VF8Ytr/8x1QtpeDDlDyUAUDgeseEHLG2KJkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDIcc1Rc/vpy+rp5sszDTFMV0YQUmgzn2hYKfef+qu0RFInk4PoKgVlPun++o18GIewgcQEOSqwmMzA6VG0vEkuwUkpRCk5PuDyKYa/luwcDAb9U0oi28tmrJHplvUs5VFeKDqqvotLwSTiZ8xa5LkRfEhukc8/3Vgj6U4KV5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dps6SYB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A44C43390;
	Sun, 24 Mar 2024 23:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323469;
	bh=YQYjx84VF8Ytr/8x1QtpeDDlDyUAUDgeseEHLG2KJkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dps6SYB7MzXBll5ZfPH2Os65ikZ7sMAWUUCOgE9oai8uL663QDj8dUykz+T1ThUeP
	 1GkMFlyxNwOKJ4A2VyEWiVOROmtGTS2UuSSlYQjopoXz5ldGMf4s7F4TMHzuSy4IRK
	 BMJxnr4m6MCjjwx8ZV5WJXrwW3mtykOcDy4wMEcJ62fklSoivQLzvx81SvewJZywfY
	 2H6kFTIx/tqpznkyNMxmEBHwwJoGXfIF3m6Y2SwakItEFcVojVjtD6vENpI5smdzZx
	 CBYjYaFNLXCaPyMSjEeLYHv8kVOOGLYoMEKdrvbRbn8A0zKCW9qB8cYZJTpN5tupOF
	 UrBf9nJ0Gcmrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/317] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 19:32:34 -0400
Message-ID: <20240324233458.1352854-175-sashal@kernel.org>
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
index 3205cd8298dd8..4c6852dc40a90 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2108,9 +2108,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2168,6 +2165,10 @@ static int tc358743_probe(struct i2c_client *client)
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


