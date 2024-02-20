Return-Path: <linux-kernel+bounces-73245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FFE85BFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39852842E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A29C763FE;
	Tue, 20 Feb 2024 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7FNHgwr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA3763EE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443025; cv=none; b=bdxBh50mT0F+FI+Ivxx9mStMPiv/iL/YCFUdFZL+jnn86rEFWdjKVlMfIun4Pkg+CZSwQO8LX6pAZAeRUutAfIU7p7BEuWf3JKtWXLAH04LmJEypHKbE8+6gNWoWRqwcF+PSmk0pcQXP5iAopLG8873yr1GjADi28RGsKM9ojtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443025; c=relaxed/simple;
	bh=qYHC0DIL9EkTejQxo0dNu3EOioYY1QzCa+VXZLu5HiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYRFfO69y4PQs1MYXO2aokC904LHboW1AuXJXQlbWd3Wiw/kQnJfdS427riesJJ+6GnYbkVeVPN3LJJWhDoCjTcDAfJIM850kOZRLGXbo2aMTlakjVE+l1dbDt/zYJRaH7nAFJTRssnxS9Xcb6OajtxKL1Wqy0u7OVjm5AILTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7FNHgwr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4126fda8ef8so4616015e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708443022; x=1709047822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=c7FNHgwrqAoCvO0G0cQ7kwC8S+uOlPtFbjY113GjE7pbjgX7wAoF4kzSvpbDSB7F89
         x97ZRe3cKmlGLaXTTMbz8Gk9iLHlMTfmOGj9uWHl7fWfv/+hg1d/ZmQlx7AKMX7cmpLs
         AdP66eAp0Y9V7nvFzc/zlubtrSbLz0r2ai6bh/5uEMHgOK1TrH41w9RFtqd6RFBtDjNN
         KCSmcg5yHp8ayC6BB3v23UCWYog4H1D4vjRB13vh2v8Z0AUZD95vGzXDmm4k42Wq+Z3/
         dYaqJ8YQqDIE/9DRdmyCcKl3Wt+4CP9cIUAaek+jzv2k8xx2XFZcs65iV9Sx/1HnFN8a
         CwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443022; x=1709047822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwLWP4/vhF0uIJPtwS5+bkpQQd9v2zac6pd8EH25YT0=;
        b=ReP9/riWQRGq0LfXU5w41ile02wR6oovKr+3FLpEurIwNQPKwKYmlYldaS61l+0glC
         jPkC5+shsgfZzc6v86ZFLkRLqVZkVKTIeU1flNgp4+qtfu+gOPrVg7XiquTadY5MFLGm
         zl/G3AHtmIXCQu6wQ1Z/D6g429UVT6S09DICbYU0vlydM0VrWi08uS5slX3oMvstkPG+
         GJNxSh7xOLfHtcc3GE9OXXc2ar5tEX0Jq/2ZzbkH6v97+Fw7rY4pH8RuvUgZHV63xwc7
         nyolaedsKpIaM7BtMtznfCCpzPslaUbFNNhv8j/hQK8WmWTEOm5GfJi7J6sFM4Nye7zL
         +VKg==
X-Forwarded-Encrypted: i=1; AJvYcCWvQUpKSi5B79hhqpDJgrPKnAL6q5Jm3lIUJX6VXEahiGcPoVe6OFob5innBfgTjNPwRJQpNWJpxNj3s00zM+elmfnJZ5oS7YxHyZfn
X-Gm-Message-State: AOJu0YyPtrsyZiHxKof027kqmsstqEWC5SMWQHxQpgs5cNAD2xiPVfiw
	3rEVEYjtOutJaFhy3lZDYJPn0w/BfQinq4esegzaOC4zOd/Y6siG9ClpSE7EibE=
X-Google-Smtp-Source: AGHT+IEGWcSQbhDlP9tq4t7O/sVQt2zHCnqWm9u68HuVcuEt7FNSTdwzCSXTgIgXE/i7RnLhBW0X2w==
X-Received: by 2002:a05:600c:2805:b0:411:a5f9:26f5 with SMTP id m5-20020a05600c280500b00411a5f926f5mr13067635wmb.38.1708443022356;
        Tue, 20 Feb 2024 07:30:22 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14691564wmb.24.2024.02.20.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:30:21 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Lee Jones <lee.jones@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] backlight: mp3309c: Fully initialize backlight_properties during probe
Date: Tue, 20 Feb 2024 15:30:08 +0000
Message-ID: <20240220153010.76238-5-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220153010.76238-1-daniel.thompson@linaro.org>
References: <20240220153010.76238-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

props is stack allocated and, although this driver initializes all the
fields that are not "owned" by the framework, we'd still like to ensure
it is zeroed to avoid problems from this driver if the fields change.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/mp3309c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 34d71259fac1d..cdf302d6f1cb5 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -373,6 +373,7 @@ static int mp3309c_probe(struct i2c_client *client)
 	chip->pdata = pdata;
 
 	/* Backlight properties */
+	memset(&props, 0, sizeof(struct backlight_properties));
 	props.brightness = pdata->default_brightness;
 	props.max_brightness = pdata->max_brightness;
 	props.scale = BACKLIGHT_SCALE_LINEAR;
-- 
2.43.0


