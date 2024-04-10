Return-Path: <linux-kernel+bounces-139394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C618A0278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB91C2224B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240F190691;
	Wed, 10 Apr 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dj0O1aJc"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B21184115
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786091; cv=none; b=MEBdWA4RRcqNzwd/juqlNweqw1PGbSKbNqBg7kJCU8LjKe28mUSHSVfd7I4Z5kAqdN221KPE8a42baWjbk1Q81O8bC4k8/o9RIlPWOofe1fE1UCqu51LK5+BScWNachD96bP6kF6N5FAFJwGcWahjcvWVGJcvqv2Fp+yD0cx5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786091; c=relaxed/simple;
	bh=erFijxCE7zR4MV8ri3c+dXbrtlOTrRZHHMfpIM9iaXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EG2qCWrvXcZwxlFC19FGbncHdcWO6EO5cVlv3KsN04h+kz/ic8VLhFYfz/l1JSZIH/D0z6Vw7CyiyS9grySCV2htVJlVTSDCEFCJCtvwRx/toGM4wc++tqzTWOUHg3byedGYLlQKziHC/dIUrhXuNNJ7p5V+Odjoa7N59X8lrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dj0O1aJc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436433a44bcso4289171cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712786089; x=1713390889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qecfLVtRY76Bzg8oTSRe9RiU8Ab1ycKtqOn34KzQpM=;
        b=dj0O1aJcd8aLrfFIDPAHRcIK0AoBdX/2TG3hNhzkW/pkpX4cQ3HNqIG32rAX5V/c++
         2yBq0kx0oOgpcQOcbBwtKsm72jiUIrvuG+hPgJzmhpmEhO3fnnihkkOwqfSY6viUeqVR
         Mch4HjnRyMWJkzTxbKkEdsmEatC4ucBWeHFG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712786089; x=1713390889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qecfLVtRY76Bzg8oTSRe9RiU8Ab1ycKtqOn34KzQpM=;
        b=oepgDmh+NAaeVzRZVsLKyhocZwSfjqpV+pzercZ3/M2D5uZ48PYkcP0K5jUAvbPvkM
         1qCE1+Vk+sBcCmKRMvEovNdo8vvd8t+ljCtz4NG0y+/VbYLzqHV7ibm1g2JyYhskbkP5
         ZteM/W2lG3GP7ybPNYuHnXfeup0VK/LW3uBAxe9C1taCuavixUjWD3o4ua1lcFDjemcH
         PwSYgbPO84HVBRIJNcimQBIZqIdldQi9+R61XXTxyHbOgViBOIzTs6AqOGX5P2d9TBsY
         EIAdKUiZDt75soMQV63jtrlRh0zvzOVqZINdSxFbFKnucFe8IxiNYOQB+M1eyL+uwBYa
         CiuA==
X-Forwarded-Encrypted: i=1; AJvYcCV+UulxHDZDzfcZkmtJF/1kTqCw2j9J0/38iyw5KDOHuzQS7TQuZq9EumStWHRNGqc3neikrVcelSM9A+0VAm2k97KDvTALykApGYPO
X-Gm-Message-State: AOJu0Yw+ZcTcl71Qyl0AlfDR1QHnoc006X/yGFewScwUXAiJGxeLuCD9
	9nLIAgoftISr96mB4PinwxNQMOgGlq2mLtybTTwOe6AeaSkbLtNJ+2bxy/7ewg==
X-Google-Smtp-Source: AGHT+IHWRJcHJfSG5kAL0HKOg8jZfMWKObhg9YFida2UCaj9AtmVdqisiCqcJB1326MCtC9PfVIBrQ==
X-Received: by 2002:ac8:7f42:0:b0:434:8cf5:b274 with SMTP id g2-20020ac87f42000000b004348cf5b274mr4147900qtk.59.1712786089349;
        Wed, 10 Apr 2024 14:54:49 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id kg26-20020a05622a761a00b00434c1eedb0esm67330qtb.36.2024.04.10.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:54:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 10 Apr 2024 21:54:42 +0000
Subject: [PATCH 5/6] media: adv7180: Only request valids IRQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-smatch-v1-5-785d009a852b@chromium.org>
References: <20240410-smatch-v1-0-785d009a852b@chromium.org>
In-Reply-To: <20240410-smatch-v1-0-785d009a852b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

i2c_device_probe(), seems to assume that irq = 0 means that there is no
irq to request.

The driver also believes that on the clean path. So lets be consistent
here.

Also make smatch happy.

Fix:
drivers/media/i2c/adv7180.c:1526 adv7180_probe() warn: 'client->irq' from request_threaded_irq() not released on lines: 1526

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/adv7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 4829cbe324198..819ff9f7c90fe 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -1486,7 +1486,7 @@ static int adv7180_probe(struct i2c_client *client)
 	if (ret)
 		goto err_media_entity_cleanup;
 
-	if (state->irq) {
+	if (state->irq > 0) {
 		ret = request_threaded_irq(client->irq, NULL, adv7180_irq,
 					   IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
 					   KBUILD_MODNAME, state);

-- 
2.44.0.478.gd926399ef9-goog


