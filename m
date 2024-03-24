Return-Path: <linux-kernel+bounces-116168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C178899FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D381F36E63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D53B5A3A;
	Mon, 25 Mar 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REae+OKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B517BB0D;
	Sun, 24 Mar 2024 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323749; cv=none; b=rRjXX/GJED5AMTjscmVgugpQkXtd+Cl44/x0ykHYZ3ADnKwiWkxPoO9EuhwFbF0OwgHmKyjQE3Hm50XpavaaUXyoyxlltcjTRCFrRbF6K0OeQUp9yqFAW3FD19P6LDOBwvJjqxcauX9nfoeKtBK2UwF0PScM6RpqDBQ5Y1Z7atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323749; c=relaxed/simple;
	bh=UDJCJA68KZXVJvBT+zW2Mxy5ai0v5gJxejglB49KUjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3wI62vd9meQ7XKDhgdfm5J8PYcHOw0AYF30m32wIrADOuKsxC50KcTs5w8ZXD4F69g/h3Dso1AxlDtklM91uIx3voHfxe2Dwug02PMSg00pLnX4H+zS/SqQ0+IxwEMZ0XjWbhnWRU6wN3I5/HrYxr5loZZaW/nrFi/RvXHGdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REae+OKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2165C433C7;
	Sun, 24 Mar 2024 23:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323749;
	bh=UDJCJA68KZXVJvBT+zW2Mxy5ai0v5gJxejglB49KUjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REae+OKeWNCqD4cyjqR12EtSnVig8PP+0yGMQasvhlJHwKmEGDnAof3Xo3X+0SshU
	 1rYNBXgFoxFg8uD0IUx9cwdOk1ej5Qm3vazshYdAgrmaGcTNMxDVm+QpmxTazXj8TV
	 V6VE64f3yRv28GUWPY4l7gO54ypmWyELWYZ015TR1lmFBqc5GuVX6p2nfusSpz0Vt7
	 +rHl4tRUZymUIq+vLKsRHGZYGzOqXT9K/1qDgp3JFU6XQUsKARBm/J+z4u42Yz3rXH
	 dnPf097u8Em/eNhhRQh2giwzv60+s3NYBtr8Z1/meWqOXTGBq4mHQv5qC4FZoN8a+D
	 nJtJ/dlBe+6iA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 124/238] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 19:38:32 -0400
Message-ID: <20240324234027.1354210-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index f21da11caf224..8bcb4b354c895 100644
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


