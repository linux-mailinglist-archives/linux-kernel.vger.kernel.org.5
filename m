Return-Path: <linux-kernel+bounces-70020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190348591D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B18A1C21EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A697E118;
	Sat, 17 Feb 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="p0kanJWR"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3341A91;
	Sat, 17 Feb 2024 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195790; cv=none; b=cEzZ3uvTlx905hAhzHyc9yJXkNOfQiNUksYwld/LsvjW3TP530tqMLujJH+x/LEtIVy4j7VNUny5vpkSfXNNnbKk0jlPS++i71rWYG2tcWXeZZYv2yppQMojcoLEVnyG0ZMSd914nMgmOebPq++rpF8VmEDrLhCuwSVc/OlsWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195790; c=relaxed/simple;
	bh=P6v2JvS1OzYzht9jsA5pBiVpyCWfx3yjVjiid49u5/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTNpqS3+ro6XkZD+EHmu+S2iokblpYxJwW8U8cRk2Xs9KLOCevjiiNIwn0jLtXyaR5ccHLH27eBDlDoQ+16d40C6YO1vXPnsJYJYO8jnG36XX4tY42xiWfijPl/Up2/2qTa8gJ6CFS3BtsnRn7l2znPgsQQQ7/s+hihUi5YFf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=p0kanJWR; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708195786; bh=P6v2JvS1OzYzht9jsA5pBiVpyCWfx3yjVjiid49u5/w=;
	h=From:To:Cc:Subject:Date:From;
	b=p0kanJWRFlJOStFcRZd6OHuJj8qJIcMfZFEEegxQq5DwKlImYdrK+uyJIBAOKgqXr
	 03UvSjh3i3+1kZSwf3EDN4AEQFQxOPsfC1Ybw8wh34Bhxj83nAaSwO78S58+OSZRWQ
	 tZRVXXOf5Dc7WiKU8u6JwRQG1rJtTgw4DynssOP4=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org (open list:V4L2 LENS DRIVERS)
Subject: [PATCH] media: i2c: dw9714: Fix occasional probe errors
Date: Sat, 17 Feb 2024 19:49:11 +0100
Message-ID: <20240217184926.1754245-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

The powerup delay was not observed during probe, leading to occasional
I2C communication failures in RPM suspend callback. Power delay is
properly observed in resume callback already.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/media/i2c/dw9714.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index cc09b32ede60..84d29bcf0ccd 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -157,6 +157,8 @@ static int dw9714_probe(struct i2c_client *client)
 		return rval;
 	}
 
+	usleep_range(1000, 2000);
+
 	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
 	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
 				V4L2_SUBDEV_FL_HAS_EVENTS;
-- 
2.43.0


