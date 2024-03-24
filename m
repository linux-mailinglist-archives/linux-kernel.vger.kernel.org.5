Return-Path: <linux-kernel+bounces-113816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6029888E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7004728E378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA9130ACB;
	Sun, 24 Mar 2024 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiOjfjfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60D1E621B;
	Sun, 24 Mar 2024 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320844; cv=none; b=pJG9VMz7rXmGSJMc5GnYZIu9KAsAJNOUotwWLegY7k785TjkVjua/Pox817W8/E9vh+XssIYactR82ZYRNVVhwv6PZtYKp3hd80WQrErv4y0LMr5pBq/k7qGNHrQ+NIwAjTxO5TUS176UAOyZ7obJ5fPWG6PwO4Vr30cp68ojus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320844; c=relaxed/simple;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw9pofm69NpEZnjHYc2InVXXAPBER8H7M9waZjbogpmyG6RSwfRDiq5o4DdrEvY9KdJVYDQqfm/hzQ0s9JnSp9AlIolgYzI1BdAYVmm0e87pVloHNI13Ya4WOKRgdTuueQzEJzwL2lusDbGNLh478CmYPg8aGdvfSU+UpqakKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiOjfjfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC0EC433A6;
	Sun, 24 Mar 2024 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320842;
	bh=vwK9mT2SDzhQT/VK/uvqjMKc6ljiGp44qtXkgvlh3Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiOjfjfHgeUh4Cc1NanehTgPFGh31hV0/L+VvBkZ+dJULWP90CPuyzjXMfhkQ3ptQ
	 Vpa35EPeLOul933aIOyHokkFrpMymuq35L8dkIzQOjyh5HRLtAbGX65yJVO9YV+/74
	 XPUgcKciBiLQQ9r3o3OrELk4RSQvsMqcwAksmJ8FCFrSL481EGapzIuU7GNQvy64Ne
	 +dIIVaKqC6s1TXM2cCijKY4F4iwyldWfsG/u82WVIREyQ08pGFbFKrhbFEuE/lxjmv
	 QbKREkxt+wLYp5Vvo0+Y2cLfl4acp86znSzRrfQWcLRRFR5OOU9fQRZyy+MwffWRJs
	 MKVi3X7MumQEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 408/713] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 18:42:14 -0400
Message-ID: <20240324224720.1345309-409-sashal@kernel.org>
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


