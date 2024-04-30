Return-Path: <linux-kernel+bounces-163874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737E08B74F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FB81F22E28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E414291F;
	Tue, 30 Apr 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DyJgcIQP"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8E413D8A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478087; cv=none; b=FdPfw3RhXVJtad+5030Dt4yY13fRa+G2SIFu0o1XC2oiUgPJBGQgSZiwbGF7rV12BE4AG/PjT+WOhLnJzBNvksN1LyZcLJG1QBE6RxcDqbako4LTxekpS3ac8P35SNBwOGWFMzTxIobeTEk5RjCyETYujj0CgELg1MiwZenuvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478087; c=relaxed/simple;
	bh=xbu/88pNQJMGyYFWxPSQooiXbYc5BT6Brrv9un7SvOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG7/DS8HP/55twqM7dD30jTqf9GK4eJapwIiZV5ta1uRYG80ylVcWN5E0niycefOIVliodo4sEfT9aOcMMZyVPwoggnsc9yzHyg63uRAO/V4nPDshOOe0yESq7yMh7Cp2dEit/oK5I09v8GMb/YqpIDJ/pBqoJKBoejKdxujFhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DyJgcIQP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=G48sT4e7XwBEsyu30MJVKv/f1vEN7+9RZstqd76uKpg=; b=DyJgcI
	QPLZNzmqWc4gK8ouVyVvZZnkmFDc9ZHTKQ11ZFWWgWM2SsDhsmGFj80ct+K1e9Ic
	qQx91APc1gBWezGCLTle2VROw11Qt+1Mt6ZAPgrzKLtMhn3YeZuo4g0zIWqqVB0z
	eGngZwayDBIVtTWV+tmVHlPE891cnFkcQCoArdAmh19y2R4+nHvBP4MA4a9owZDL
	3MbDT+7K//EkHL5AHZE7aNF6wD7xtbt3wiog4JC/KeokmYCOfbOmOBzV0zRk0cwH
	UORzs+xgc+2bWYVbzwQZuxShvZ14BwCnwvbuvJg4tWTZUlKtLrvD7sAw1lVDj0YF
	RPh5c+RrsQKLY/RQ==
Received: (qmail 2621617 invoked from network); 30 Apr 2024 13:54:41 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:54:41 +0200
X-UD-Smtp-Session: l3s3148p1@11IFCU8X9o9ehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: alsa-devel@alsa-project.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ASoC: codecs: wm8996: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:54:37 +0200
Message-ID: <20240430115438.29134-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
References: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/codecs/wm8996.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index e738326e33ed..66096e09c953 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -655,28 +655,28 @@ static void wait_for_dc_servo(struct snd_soc_component *component, u16 mask)
 	struct i2c_client *i2c = to_i2c_client(component->dev);
 	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int ret;
-	unsigned long timeout = 200;
+	unsigned long time_left = 200;
 
 	snd_soc_component_write(component, WM8996_DC_SERVO_2, mask);
 
 	/* Use the interrupt if possible */
 	do {
 		if (i2c->irq) {
-			timeout = wait_for_completion_timeout(&wm8996->dcs_done,
-							      msecs_to_jiffies(200));
-			if (timeout == 0)
+			time_left = wait_for_completion_timeout(&wm8996->dcs_done,
+								msecs_to_jiffies(200));
+			if (time_left == 0)
 				dev_err(component->dev, "DC servo timed out\n");
 
 		} else {
 			msleep(1);
-			timeout--;
+			time_left--;
 		}
 
 		ret = snd_soc_component_read(component, WM8996_DC_SERVO_2);
 		dev_dbg(component->dev, "DC servo state: %x\n", ret);
-	} while (timeout && ret & mask);
+	} while (time_left && ret & mask);
 
-	if (timeout == 0)
+	if (time_left == 0)
 		dev_err(component->dev, "DC servo timed out for %x\n", mask);
 	else
 		dev_dbg(component->dev, "DC servo complete for %x\n", mask);
-- 
2.43.0


