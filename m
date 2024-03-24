Return-Path: <linux-kernel+bounces-115946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADB98898D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92022A83B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C295B227E03;
	Mon, 25 Mar 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0K+fzYU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F022BC1A;
	Sun, 24 Mar 2024 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322174; cv=none; b=DroJlGl8I4Rz/Zyun/vmIRxgVSjtF+KwFXSsHtme2WjhjrM9X1qUdltonTh8sLXEBeZUVjVZ28rtC0O7bz1oZk0Yx6H/u7fcF3MgJh2WTtvHd46sqmfdPPkn4O/o8PW/cFzEDTmHlYg7VS+pVofBviw/hyGfjQvQNTL0xweUpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322174; c=relaxed/simple;
	bh=zeB+hCTFAkXCutCoUYbjRdpphjBZfVd4YFr1luGBKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKv8D3yVaas99QCss07I+I1QhXdN5XTaJHbFHq4UtTgLFSVS1b3d5LWPsNtsn37H96/r4074PK97OvLPJSIF+oo63kVe1C9861T8gPSPKvRV8e5dFEQTQRMggi0bff8owYC3HWR9Atf9Z5H4OcdCsZFwAwTaXjpo9i8CPcQuzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0K+fzYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195FFC43394;
	Sun, 24 Mar 2024 23:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322174;
	bh=zeB+hCTFAkXCutCoUYbjRdpphjBZfVd4YFr1luGBKC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0K+fzYU9gtiDuZotY5/BDRisThx2s8DsowGKQRiFV074yQxvMyznLMv+hTlT6tlW
	 jJfN67bh+x9kjDCXmeAQdTEo0StOZKnVtattMPCCvvEOrvQ2e8z7+2R1jQwqaqbSuZ
	 vAwom7b7QVzRtBV+WmDk4zbHCj8pi3xfZ4N4aoeNaIeZS+D2i5ozBOT5gmH6BySFCS
	 8dOki0s5X5mKOsC5BMl5wJEnzl7LOzVTOj7Qfjf/XoQPAwQnxy72QF9oMBW1s6uQC2
	 6zhbgzfwV1yatIMck2GpfftWz3ho9ZcbY8VjCrKmOZlUBvyHYCD797wG/8puIwPhlr
	 LnsHJ/HC+zRkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 253/451] media: tc358743: register v4l2 async device only after successful setup
Date: Sun, 24 Mar 2024 19:08:49 -0400
Message-ID: <20240324231207.1351418-254-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 200841c1f5cf0..68628ccecd161 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -2094,9 +2094,6 @@ static int tc358743_probe(struct i2c_client *client)
 	state->mbus_fmt_code = MEDIA_BUS_FMT_RGB888_1X24;
 
 	sd->dev = &client->dev;
-	err = v4l2_async_register_subdev(sd);
-	if (err < 0)
-		goto err_hdl;
 
 	mutex_init(&state->confctl_mutex);
 
@@ -2154,6 +2151,10 @@ static int tc358743_probe(struct i2c_client *client)
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


