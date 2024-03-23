Return-Path: <linux-kernel+bounces-112297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195A887810
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E2D28285F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083A2940D;
	Sat, 23 Mar 2024 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYOPYYbk"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359714A8C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190514; cv=none; b=k2bOyxYhUc6acZ8/NpHQ0bwkoRdxFh3p/r5A6nowo6rlSu1A8BRlpJWky1aI67uDa3xicYlDxPEPcJo8RlZps2lAVE3YZTiX2JJYtwlxGiLhFETTASFdoE0dqN1EPu6HniuWhpk3AgRUjNSk7sPC5SYK3PzGuWCNKQuJtCuUZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190514; c=relaxed/simple;
	bh=2dAG+Jyz81+oh8AF6DeyE+UyRu22SiDEL635nHH+73Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDq27nlDv3/WkM6TpDnM5vdknWeuXE6z9hNQINTZNnkyU2eYENVcIv6mRXexlmtunMqkcQyHzxqch5JNLOK79cNiR3XGWjWR+c1R5roTWvYhEynYUJedp+jgpvo/L5u59s3GbHXusbbIjmlLtwgVsApzALypp7Xmb4dwgixym8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OYOPYYbk; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69185f093f5so22341576d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190511; x=1711795311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=OYOPYYbkeqSi2WK/juteGiXBuhKsWZjsJQeMrLF4tfeainuFP5ToghClEJRiTdi7dy
         rLZfwgvQt3hvIQbDggswBT7PsLW+G9gC9i5lsraM75IksXfarmyvWE49wwwIVjKru/qZ
         v7zRYq7neJF2QRiPZjrae+fR6ti4CZchjKOFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190511; x=1711795311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=hrR3k2mTk5YV2YkOxaoNoreftx4C2V0+Vi0CmYdkv//uBaQJ0lGbT0o8Hw0Ir3MWEg
         5KrmlSWW+7Xd69zlHWMPYwWGo8ENBcGW6Psy+s17hNRSh/+pTlz1ZQWD2P1RgU553ljA
         zuOxWFbg1JgKm4XqvPm4eWcQspzuRCxzMykVjatnnTmMNOJ13qKPIr/PGRGG5mUiuf0O
         LzuCC9U+6dCGVVoxWOeFqAtkZJjufHgy7Ii8AM/XrQ5NPInwIXfAlg318ZZmUZ0C9Yil
         4UMeFmvlCF5Nom5dJbdQu0SrJstf2UNKy4s3I/cyPEmYnECIf2EY/x7LFkbbrEOfpYHI
         WjUg==
X-Forwarded-Encrypted: i=1; AJvYcCVxxlAI2NmbmG0OFpWbEANZAUw7oqVccDG2/8/kVNVmGj7waPJIq/QlZtNpqz3+uCu0l3nWDWjbwFBG3enzDzINtZiKHnZglx3aqoIw
X-Gm-Message-State: AOJu0YysrUhCfau8omngzdye9s6l5Yv0uTvpIPNQaWYlIY2JLLeAg4bm
	toN9B455XAUQ+1IWoRn+K/ibiMCMMRN3FvWGszmNlCZlwRU2SQARB89PG63nMA==
X-Google-Smtp-Source: AGHT+IGOP9NmNvjkaFj2nG43rNY03FVvY8JGudvMrkdWl0W6OiPHpehuLaE5+7bEg8g8j7jyhHLwOQ==
X-Received: by 2002:a05:6214:4009:b0:691:5ff2:6083 with SMTP id kd9-20020a056214400900b006915ff26083mr2009085qvb.36.1711190510703;
        Sat, 23 Mar 2024 03:41:50 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id 6-20020a0562140d4600b0068f75622543sm1998523qvr.1.2024.03.23.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:41:49 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 23 Mar 2024 10:41:46 +0000
Subject: [PATCH 2/3] media: radio-shark2: Avoid led_names truncations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-gcc-arm-warnings-v1-2-0b45cc52f39e@chromium.org>
References: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
In-Reply-To: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Increase the size of led_names so it can fit any valid v4l2 device name.

Fixes:
drivers/media/radio/radio-shark2.c:197:17: warning: ‘%s’ directive output may be truncated writing up to 35 bytes into a region of size 32 [-Wformat-truncation=]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/radio/radio-shark2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335c..e3e6aa87fe081 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif

-- 
2.44.0.396.g6e790dbe36-goog


