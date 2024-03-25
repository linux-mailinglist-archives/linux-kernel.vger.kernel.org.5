Return-Path: <linux-kernel+bounces-117236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5265288A8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8AE3664B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAB154BEA;
	Mon, 25 Mar 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhgXM9I2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CB12F5AE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376399; cv=none; b=L9L8nBZOP7NfU8jI8Zr96y+44wGuNmQpspSn8HLSh3DIdzKZTTZfc/0Gn4E9oF/6Dwu/qVTfsTq2PrFD2ee4+XZf9L2M/Kuoap/m28fzq6C+1xIvaMYjgv1KNO+MkVpbfu0T6SqYkHpJpJbI5TBPKbqY73QFq51gvaUbEDXDr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376399; c=relaxed/simple;
	bh=2dAG+Jyz81+oh8AF6DeyE+UyRu22SiDEL635nHH+73Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ghv0o6X6rJZ5FnDweeKsFPBe2P8+u6xHute7fsla9cmiO+dtT2HSU94RwtYPBqWKp8PMpzFtqr9yfxXKxc2Mh5ua8DDdJGtAh/y/Uxes/ZMthpEGgi9hwoNEKF7OZdS7HQtEY7Bp90nyvArF3gtzuphNrK4CQLbIOEUwR993HQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jhgXM9I2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430c76fbf05so28914481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711376397; x=1711981197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=jhgXM9I2GEmuSskr4OtEtPiiHHwjP90lmyWP1L3famVlnG1OyJVtBN7ClIVAram9OQ
         HOlJyC+Y6G3ZdIhk2nxfEIbE+sesdqx+F9GQi6LE2nIGu4p656yElb5XFvCVnAQiPWg0
         6L4Wa8MnSHZ5qHw3EeB8wso5H7ch8B+ZoA3X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376397; x=1711981197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8QTboKNFlxJkYJ1An2aW3V7umhSjhO/WM5O6LoVCcU=;
        b=M27qF9bFWEWo4YD3Z3pWYk325bBYXGAXXMjXJXcPsqhaSHFS0z8EXdnEXNZNKQchtg
         uHNPmj4c7fPp1en7gs6BX0iDSQqKgSbe+NVIa3o2EaDW3taRC/bSLzUJMtcbdwhEP3ND
         0XCzJ5D2ohNIp6NKZxkzPA2YURNd7SRx8wliYhYUAr2dpQnX90CvYScls+22am6SpwsU
         zyr48hzr4DoDpCcTXqu9QUMomenyrvTI0f3biqlXKOCmATtaEfT9Kn3kLLaqCOnN+wsS
         w1uxG3J0sWZ2RrzE0468Qhel8yMfg49XVQvS6cYoSK5Wd7QQJ3KG9nau/BpjHrAUBrF6
         PNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP4nQcBilKLSDPjASkx5NmtSEKqkmkTXIf6fmcRVmhtjJBwjIPvZQPB49JrtIJpjPiGLVU+V/U9CGslEwd9mV/bMk/823TmTf6SKOx
X-Gm-Message-State: AOJu0YxIw2LaVXOcMmQuvSwricf7pdEPMlaZVegdArXXW+z3ctFirPWQ
	DAH4VOE9RbMsmWjdzygUxiTAAf3lw6pXxR0fRwnBloUYSgmlxHC/A284Qx1I4Q==
X-Google-Smtp-Source: AGHT+IFz1M7TzNsRqhapaOB4EMIJCF8pxeNEAz5599OCzPaIO+sM6oRyyPofmo2f9pFg+HoTstBcEA==
X-Received: by 2002:a05:622a:652:b0:431:4905:bb79 with SMTP id a18-20020a05622a065200b004314905bb79mr5865639qtb.41.1711376397204;
        Mon, 25 Mar 2024 07:19:57 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id br11-20020a05622a1e0b00b00430a9b20a55sm2618759qtb.69.2024.03.25.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:19:56 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 14:19:54 +0000
Subject: [PATCH v2 2/3] media: radio-shark2: Avoid led_names truncations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240325-gcc-arm-warnings-v2-2-47523cf5c8ca@chromium.org>
References: <20240325-gcc-arm-warnings-v2-0-47523cf5c8ca@chromium.org>
In-Reply-To: <20240325-gcc-arm-warnings-v2-0-47523cf5c8ca@chromium.org>
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


