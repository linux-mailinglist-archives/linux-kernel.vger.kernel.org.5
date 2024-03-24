Return-Path: <linux-kernel+bounces-115214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A736688935A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478061F3016B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E441CB69A;
	Mon, 25 Mar 2024 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4kly8S/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72A22E7EE;
	Sun, 24 Mar 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324302; cv=none; b=VaKWmHC2K2KsJgEdqY240mNCmqJ9KF+f4Cpn8+c/637LemAs3xYEmzaW6SgiCQU69upkT/Cv4VgW7Tpf77BdZZn62AdLgN1n7VKlrSZDm+j4eZjx2K7DciJR2+G/UO5aBrI3fR47tm1BhNZNgM658EFLnRlRMna/EWPl4OYyFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324302; c=relaxed/simple;
	bh=C+/70BqqoyuoI5rGiAd0yfx6Jfh9xe8UtZavuyGWL7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGlkpncpAmRySBmVRKLD8faMFb1CocjhUDE5PkC5DVk9nbrYPB8USPUJ3cnYWEj33xF9IgshVvg6ajdSJc0QgmBv20oY+4kIMNBwVgvv/yT/uRjdOmdbd9KrD4q97BrKagIpG+Q+LxVdUuI+3hBE5/mjZdyWT9PEOHN6Y6iPnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4kly8S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA5CC433C7;
	Sun, 24 Mar 2024 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324301;
	bh=C+/70BqqoyuoI5rGiAd0yfx6Jfh9xe8UtZavuyGWL7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4kly8S/Psnianm9om9dt9zjWpNyxNc9dRCpobL67lSivDB4daq2uAdkaE613sXx5
	 53uXUw1ytRJqqkj9SZaB0wl9LhdDpddlVxSkFLLrKooQY5elfh/1n6VaWGWVxYpt+O
	 5FoV6Z1UVkxVghIContedz2XKxCGwxAIlAbKj3Ew7gq3mloNFIpcDUBzzGu1QfTr/Y
	 rFDqeRtP762lzHlp2yKr09OMtoD/iDddq6Ylxe25Xc+j3Z7zBZJnj1kEEoGVpE8SfN
	 4pE62tiFixsFNzaLD9pXvvyKC8ToCsVMh37hJ/8HTEtW+qgKygkWV0hiKoRcSRimFL
	 bgoqA7O9Xfu/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/148] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 19:48:59 -0400
Message-ID: <20240324235012.1356413-76-sashal@kernel.org>
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
index 079b8db4bc48b..2650be358b027 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2107,9 +2107,6 @@ static int tc358743_probe(struct i2c_client *client,
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2167,6 +2164,10 @@ static int tc358743_probe(struct i2c_client *client,
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


