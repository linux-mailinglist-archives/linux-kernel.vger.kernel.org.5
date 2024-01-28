Return-Path: <linux-kernel+bounces-41669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F149783F629
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD6D284024
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAC25635;
	Sun, 28 Jan 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="B8ikNft5";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="BVNGuGDP"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D425772;
	Sun, 28 Jan 2024 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706456966; cv=none; b=MbA4G6v7gv8QSmOdElvMYlDi5iizOoVmQwmQUlefK5CGX9hJQ2AeKBBpV8RC+dT8cDa699c71fRSQru6b95Zb3LPvc8ukPORHiuruVgChdhYWlx7gz1shMKvWZ938F14XDQbhvbYpLoohDpgPjCSY0GZnETBZoSvqgZonozJRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706456966; c=relaxed/simple;
	bh=pIUGZH0WA/dnmasx5Fb75KygIBvTRFfwHo3C1qQyatU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKSTIurqmvR5S2ibaXOLgNH72y99w4xbL+uY2iwS8eFPbFO3Mzyh6bLm/iCg8r8UqloMJ25KCssSuJrb52VFyc0zn1ApozSxADj37TwqIYxg9LXrd5D9GX2l/Yy128g0QowTOnndDufSwGorC+y98gEBF5sSqMwe89sGuBlmjow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=B8ikNft5; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=BVNGuGDP; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706456955; bh=pIUGZH0WA/dnmasx5Fb75KygIBvTRFfwHo3C1qQyatU=;
	h=From:To:Cc:Subject:Date:From;
	b=B8ikNft5M3ZiBK7NHoTnEBITCVUwtkDt3vhcDOlGKG73fUvC4g6x3TU6T44ygh5UI
	 gRTvSkr5wZqCV+YFsQNvxJ9vl8RfDZTeLHuefPmyhKaXDcEnnxmS3PcfCU9PhpouMZ
	 o5whQIGNAhwCzLw0fhFftjg8k+aA/4JXpjKqKPvOOrPqu/kc8/mFM3VJ6cFka8JsCL
	 QA2dQRjY83Ty4WZNDe6k5R1nbLT/uGJjIt1Flwx8eH6xnuPFLNghFbNaA7pkjzM4QW
	 cCVl0seEh0CL0giiin4fmbOQU5o1ueKMN2+RRxWK2AJj/rsadpRegN40o+t19qqCMr
	 6cv2/+nzY+sBQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 999141009C0; Sun, 28 Jan 2024 15:49:15 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706456953; bh=pIUGZH0WA/dnmasx5Fb75KygIBvTRFfwHo3C1qQyatU=;
	h=From:To:Cc:Subject:Date:From;
	b=BVNGuGDPkHcq680/07H+MZm6kSMUHplL3QA/QQ1CydeLArEadowfvbwxBbASXbF0n
	 baez3+xNJuwljbqm8wU8V4zzh5hww0sWtfqzGOwJJDxcxOJdDHYe0uXx3dWQLTOSb+
	 5tgaLO5pon+/1mF7hZ4q+c6qFSXEjv5qEVq8sMp/jbzKUsj8Nl2/BZD8j6GAB6Q2mk
	 FDqCWXWGeJGkJhqdF035VBmEhOJEfIH6nFJyz3aGzhpzkFzZHtdW6srpYnvnsReaYI
	 ovnTJGJudjBtRV9DhZOBpSSVlfhR9E+KBVQd+mQeF6H1qz3aiBoK8s3LTVMo4/WFgT
	 AJmVh+swGsFtw==
Received: from bigcore.mess.org (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 6CFC91000B2;
	Sun, 28 Jan 2024 15:49:13 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sean Young <sean@mess.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] backlight: mp3309c: Use pwm_apply_might_sleep()
Date: Sun, 28 Jan 2024 15:49:04 +0000
Message-ID: <20240128154905.407302-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pwm_apply_state() is deprecated since commit c748a6d77c06a ("pwm: Rename
pwm_apply_state() to pwm_apply_might_sleep()"). This is the final user
in the tree.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/video/backlight/mp3309c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 34d71259fac1d..b0d9aef6942b3 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -131,7 +131,7 @@ static int mp3309c_bl_update_status(struct backlight_device *bl)
 					    chip->pdata->levels[brightness],
 					    chip->pdata->levels[chip->pdata->max_brightness]);
 		pwmstate.enabled = true;
-		ret = pwm_apply_state(chip->pwmd, &pwmstate);
+		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
 		if (ret)
 			return ret;
 
@@ -393,7 +393,7 @@ static int mp3309c_probe(struct i2c_client *client)
 					    chip->pdata->default_brightness,
 					    chip->pdata->max_brightness);
 		pwmstate.enabled = true;
-		ret = pwm_apply_state(chip->pwmd, &pwmstate);
+		ret = pwm_apply_might_sleep(chip->pwmd, &pwmstate);
 		if (ret)
 			return dev_err_probe(chip->dev, ret,
 					     "error setting pwm device\n");
-- 
2.43.0


