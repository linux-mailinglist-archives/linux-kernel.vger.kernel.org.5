Return-Path: <linux-kernel+bounces-113263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE95F8882EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF671C2267F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C771892B4;
	Sun, 24 Mar 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjJpLL18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00287189299;
	Sun, 24 Mar 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320063; cv=none; b=bqA5IYFeIAsiksmF+6HRwWSB+TUpaLzuJ+aRTTHBG6JCc8sXAdJuPWBgZnXBCeRE6Mz/L/VAKB5ZWtNuj28B9vLcILOhelRjV9yPOQ9DLlBCiJsBscYEgY4uZo4jLFKhtJ2j3280w3H8LUBimYxPSdtVxP5nnlbcQRS3Fi9mgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320063; c=relaxed/simple;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjbYkcgW0TYhskTZmLd+vQMZ2u6QoAH3ifWyOA2zjn+0tpDoMG48aul+PGH+5L3I78GkZPjlkIQthrC+1quOkTwEq926/Q32hk821etnpu1d7QFqB1o/pxC/ucl8O+BHWPSXCRJ7QVXOnFYqOAKCoFmUPRILGM6IPK9B+AUsqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjJpLL18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EFBC43390;
	Sun, 24 Mar 2024 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320062;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjJpLL18EQGnOpp86meQ1tarYk2LavsUV/j+FCiDGaREGeaoPcjQyJphCKNvGiGpJ
	 vkonVi7rcgHp4WewDslNtUfEJtHtGl5kY5VXEkdwjCfF957Vdme32Xuzy+KtAuV/Yu
	 t+obh3od9ZZsQ4ZI2f5Pis2b/OeXKzyG/J5pnrEwSyOHjazR72JaEwSHoVP+lteN0D
	 l0H9gOoWzAf5Ofrs4ooHBr8VnTHQZWWoc17WiyfFynHDbSGglmc3oooQdGkBaKMVwH
	 /OvpIc1uE+nPJDaHVbTeYtuqwdE96qcdiabORYjEzbzRE8Rl0rTyqDKlen3ImiW4ov
	 FJ0Rc2+AZsdCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 372/715] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 18:29:11 -0400
Message-ID: <20240324223455.1342824-373-sashal@kernel.org>
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
index 2785935da497b..558152575d102 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2091,9 +2091,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2151,6 +2148,10 @@ static int tc358743_probe(struct i2c_client *client)
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


