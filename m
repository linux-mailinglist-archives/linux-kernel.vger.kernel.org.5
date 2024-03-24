Return-Path: <linux-kernel+bounces-115524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B5889D62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D05C5B35F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389C23E425;
	Mon, 25 Mar 2024 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Msof+9h+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0811494D4;
	Sun, 24 Mar 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320977; cv=none; b=KdsIcP4kJGyjUVibvJOWtbUrgU3jb2qfa9hhtZ/IPkmYZgI8WABlArMroiOiDCizckZmFNm2CK6XX15NVcNX8fZUOUA6/dmPaH4LbIepYV6vMrEE6n4dLqqvZNhP0iDyNhfkVDfJ4uUJK/k2gDydhkCWM9pgGAbrZbkFHeW/LhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320977; c=relaxed/simple;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwEwNtcdPr9fFZwqHVcVfNxAuX9IDudD5yedNGxbeKVOB8SyF0ZR1/R8BbnZRiujdqtkeKHSxpI++tk8+6UVkft3h18Qy7s/RPFt24/brm7efsH0O3/ZOdqdOvRnnt2UTLfeOLlV1kP5hu6tYK4xp1LaDifcVCgD8LNNKQbnLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Msof+9h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B60C43390;
	Sun, 24 Mar 2024 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320976;
	bh=1L5gyKnUNDWV2C0YYKufGqLKY6PpoYok9dEErj71eac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Msof+9h+vA3zF9+SnUOy6G/WmX2lrLjG62KbpDl00P0/BIZAnixYLjmL0ove8zy4z
	 MWsnAKTrm7OHIT30aPVmbuoW8n7o4rYTBwahT6XoVzVqb2eI4BUxMgj0ubZJSaSFBy
	 oY0cqxzgVI6xHYV0Y4Y8qHMEt1AjpJZ7Meh3NaOsuY+Mo7Qrkkh+ez6KAKhbFxiQtf
	 1deXkf/sQMKLA/LGfpbtxXJtmxXRC23nwYinm4OjZXE2LkHl0ct3PhMAhdP0uZ8ijT
	 YFgJQ4uveAOrVE+UCpKhTu/z69YWIAU7CFOmmnnGwk6CuzE3DhOMYRM2cQ3PT+AWrd
	 thbNHvCmdXs7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: George Stark <gnstark@salutedevices.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 539/713] leds: aw2013: Unlock mutex before destroying it
Date: Sun, 24 Mar 2024 18:44:25 -0400
Message-ID: <20240324224720.1345309-540-sashal@kernel.org>
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

From: George Stark <gnstark@salutedevices.com>

[ Upstream commit 6969d0a2ba1adc9ba6a49b9805f24080896c255c ]

In the probe() callback in case of error mutex is destroyed being locked
which is not allowed so unlock the mutex before destroying.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20231214173614.2820929-2-gnstark@salutedevices.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-aw2013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 91f44b23cb113..17235a5e576ae 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -405,6 +405,7 @@ static int aw2013_probe(struct i2c_client *client)
 			       chip->regulators);
 
 error:
+	mutex_unlock(&chip->mutex);
 	mutex_destroy(&chip->mutex);
 	return ret;
 }
-- 
2.43.0


