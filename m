Return-Path: <linux-kernel+bounces-163872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E68B74F6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B169D1F228B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6D13DDA1;
	Tue, 30 Apr 2024 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Wd/kYC5C"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56213D26F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478084; cv=none; b=OsIF7sCFTZT4ESOq0Jd6kbh2vsONsgARTrl+Aj0rZh/7sv9woB1ZB315XxQI8XqT73va2UfNnz2nrSbip9g18s24Zin8GI4Dbs1SN+hUnqoMqC7baQQSMW81BvQVGvGzd9HNbbtt+Wp+eWFZ5vTtKsNDPuK2ZAwgRLY7QPzgVsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478084; c=relaxed/simple;
	bh=MM2TeqomfLXF5s7OrDSUWwcq6LVqngUnCrjYhWJ7hBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqI1yhHiKwC/UjIoc8lniTuKxMKPHwffOredAkvVhhcjk4LXTz81QYTIvmqnmwt9cCK9/P+5GqQ8FnElEDMpMRMqkwB0qvqvgCveqvXJ8CK9QcGYwIuYPnU2eO0iaX0ccU2aqO1+qhLZjZnUcc7s3HY0EXj6RmNGiFxwYWnSfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Wd/kYC5C; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=vYs2g0fBsI7wQB63+nPXWqKZGlsYANFKOFZ/hv64BS0=; b=Wd/kYC
	5CQ6oeRH1lqxcink1OFkJq7SK9ydmWIuUkfwhtsubJG1896kvaWoX2vXY22Vy8mq
	9gNjDiNQWVpSdWZdd+S8n5Nt5lNFD8AGaiP3U+ymnyw2DjvJw2zCq5FGFn6ugXbB
	9IDqbeEss2MsSMJkXz1wNe6fi9pPlTgvic2iXNTfLiSCqPkulPLQ2C1XZdPZqLsL
	0WcZXPESAZB+ucHhEG654zIVG7RRmBrcmc6ef+Csu6MKCW2wMxvByGw7FseR+sX2
	5Dxob1ituo1N5ADvDIRK7gag83hNCNJUbTKrHMkPbzKUmezhz3vFIL7NT6E8kcD4
	sEew3XPoKODvfVbA==
Received: (qmail 2621543 invoked from network); 30 Apr 2024 13:54:40 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:54:40 +0200
X-UD-Smtp-Session: l3s3148p1@DWnvCE8XQqtehhrb
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
Subject: [PATCH 2/4] ASoC: codecs: wm8993: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:54:35 +0200
Message-ID: <20240430115438.29134-3-wsa+renesas@sang-engineering.com>
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

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/codecs/wm8993.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 5b788f35e5e4..dcc6301223bc 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -470,7 +470,7 @@ static int _wm8993_set_fll(struct snd_soc_component *component, int fll_id, int
 	struct i2c_client *i2c = to_i2c_client(component->dev);
 	u16 reg1, reg4, reg5;
 	struct _fll_div fll_div;
-	unsigned int timeout;
+	unsigned long time_left;
 	int ret;
 
 	/* Any change? */
@@ -543,19 +543,19 @@ static int _wm8993_set_fll(struct snd_soc_component *component, int fll_id, int
 
 	/* If we've got an interrupt wired up make sure we get it */
 	if (i2c->irq)
-		timeout = msecs_to_jiffies(20);
+		time_left = msecs_to_jiffies(20);
 	else if (Fref < 1000000)
-		timeout = msecs_to_jiffies(3);
+		time_left = msecs_to_jiffies(3);
 	else
-		timeout = msecs_to_jiffies(1);
+		time_left = msecs_to_jiffies(1);
 
 	try_wait_for_completion(&wm8993->fll_lock);
 
 	/* Enable the FLL */
 	snd_soc_component_write(component, WM8993_FLL_CONTROL_1, reg1 | WM8993_FLL_ENA);
 
-	timeout = wait_for_completion_timeout(&wm8993->fll_lock, timeout);
-	if (i2c->irq && !timeout)
+	time_left = wait_for_completion_timeout(&wm8993->fll_lock, time_left);
+	if (i2c->irq && !time_left)
 		dev_warn(component->dev, "Timed out waiting for FLL\n");
 
 	dev_dbg(component->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
-- 
2.43.0


