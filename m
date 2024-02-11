Return-Path: <linux-kernel+bounces-60693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A7850899
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F8B2820B7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD759B77;
	Sun, 11 Feb 2024 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV1O5a4E"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56459B40;
	Sun, 11 Feb 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707646493; cv=none; b=a/+48eJ7OSdmvf8iYKadASmv6jzftN8n4n+LieMJF3y8trUh0gwWrfuqEUWblqqR1OT2lSdHCCWiq0xk00mppp/ZHqz9leJle9DPYLMWXk5JF6YooBZQlP1sgtB2rFmgDKvG6vp/Ah+UAFIjkFarJS+IKxVjgWPN6S2itBrl5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707646493; c=relaxed/simple;
	bh=5HxlEksVyEjp5vwu1YWeFpsI9Pu5L4mnVbXPjNxQXSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QHu89p+9oFFO8J4BdK6Wpcte9RwrithoxbHlJ0lXQYR9UexI05iFWAqIyTuMY/FSNENCuLeNoZx0RBjWHmmTq3qXMIajr2FLtpbgwi5qlpYB30UPUX0Xzh63ozmnHg9JlhkwmfzSOksB2EFTnH0WdvntvMjzx89NDsz4YqVwN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV1O5a4E; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1766550a12.3;
        Sun, 11 Feb 2024 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707646491; x=1708251291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Blc6hLuk1jJGYRb9CW+5BR8z1UC6d8gl1Uq+cUruLp8=;
        b=QV1O5a4Ee4SIW2+j2kVK5kliRGFZgJj7b8IG8qqsqp+zPZlaleGSqk2++vlsDcNbpF
         qVyYC4LE5kABA69JU0mxbBw+YPlVNOI7A3ufNq0E4m2SSAZlq4yU28YGkEKcSa0ktrR3
         3qq8ZKX9XW2Mqpwp9ssHPGVlNMGxb86gnbwlGyPaCuSZtsr9OsQRgEtCqB2uJ9I0+JAO
         WRysEhP44/KCYop8K8eDH/le4GQuFSDf8J3Oe2dyLa8baFHxUE0MyaeVJK3VE8fTvms5
         zvsZ1+XKiXv6LleeOgEjCJPDqsBCB+9L9u8zYk6d3+cubGB5OYgQ1fpyE/kjrMzrO3lm
         w9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707646491; x=1708251291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Blc6hLuk1jJGYRb9CW+5BR8z1UC6d8gl1Uq+cUruLp8=;
        b=nMGSNgLdzo0O5Iu8ZJl/3NDeq7y1STWDcA92qJgbM4oXnbC1mjuiuUcilYQ3zsYIiS
         lV4TbYAVFlTMHN1IHeM34g5whYhKFrpX8J3GZZ9x1CWVDLX61w5BDq4/3E0gRlDwTvhF
         l0mrH74wFOsvGbAp8klYb20PlzbzJ+vCjTLpH1NYvpI/OVe3IVN0gPzuYSKqBY1U/RHJ
         vxq52Pr4oi4dWsdBzpDCJNR7WZXVcI1Esa2GRN+BrQGWTBMcdiPYM1RXp68/+HNwYB9S
         DTjh5eYVFXGUst1s6+B2C3At3lP01iEgLmS93LY/po5qsHiJlzJghibhtPeUW+/aY2zw
         Hp9g==
X-Forwarded-Encrypted: i=1; AJvYcCUlmE55MLUyYLnd+Bb335Qbsuqga9wrnEejHwEMKfhAifRGLs8uiTrTyN2BQN3hH9rPjFY0zaH+5ADmJfZuCBAKfW8gHRJdM0USLg==
X-Gm-Message-State: AOJu0YwQrVPHI9Z16UcJwbnHg1OImC8F8Id+6IZAJARZUFvZ+MRNcIZf
	xJy7kHO/GlKy35M6snwfi1ANX8vGpVgBT4s6aIIPVl4o15uOD+OioYWlw1VE
X-Google-Smtp-Source: AGHT+IEKbH4BiX5HkwywENkildjj28TRbPnYV/wqK6VmGDwBHihdVYOJ5Ixai7bSDMkeiwIy7a6Ofw==
X-Received: by 2002:a05:6a21:9188:b0:19e:8b31:f1ae with SMTP id tp8-20020a056a21918800b0019e8b31f1aemr6804727pzb.29.1707646491257;
        Sun, 11 Feb 2024 02:14:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCx+RIFOebjwfywA0OkLnpAhcJ1BFPAb+3VGchp0s+0NSim3fyKZKJFc1Lu7pxbyc87ffxWxRHPw+utCuqmQh41uKn1/o/siHifU9XMiAvmnEYVd6XsBhyiel4yjYMpyLXMA4V3i2t/xYMYOWmIIkj9Wqi/7KC5TljkqcF8+pmVOWzA0g=
Received: from rigel.home.arpa ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b006e09ec69d7dsm3184009pfn.98.2024.02.11.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 02:14:50 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpio: uapi: clarify default_values being logical
Date: Sun, 11 Feb 2024 18:14:21 +0800
Message-Id: <20240211101421.166779-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for default_values mentions high/low which can be
confusing, particularly when the ACTIVE_LOW flag is set.

Replace high/low with active/inactive to clarify that the values are
logical not physical.

Similarly, clarify the interpretation of values in struct gpiohandle_data.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 include/uapi/linux/gpio.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 103cd3c6c81e..f7cb8ae87df7 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -399,8 +399,8 @@ struct gpioline_info_changed {
  * a batch of input or output lines, but they must all have the same
  * characteristics, i.e. all inputs or all outputs, all active low etc
  * @default_values: if the %GPIOHANDLE_REQUEST_OUTPUT is set for a requested
- * line, this specifies the default output value, should be 0 (low) or
- * 1 (high), anything else than 0 or 1 will be interpreted as 1 (high)
+ * line, this specifies the default output value, should be 0 (inactive) or
+ * 1 (active).  Anything other than 0 or 1 will be interpreted as active.
  * @consumer_label: a desired consumer label for the selected GPIO line(s)
  * such as "my-bitbanged-relay"
  * @lines: number of lines requested in this request, i.e. the number of
@@ -426,8 +426,8 @@ struct gpiohandle_request {
  * %GPIOHANDLE_REQUEST_OUTPUT, %GPIOHANDLE_REQUEST_ACTIVE_LOW etc, added
  * together
  * @default_values: if the %GPIOHANDLE_REQUEST_OUTPUT is set in flags,
- * this specifies the default output value, should be 0 (low) or
- * 1 (high), anything else than 0 or 1 will be interpreted as 1 (high)
+ * this specifies the default output value, should be 0 (inactive) or
+ * 1 (active).  Anything other than 0 or 1 will be interpreted as active.
  * @padding: reserved for future use and should be zero filled
  *
  * Note: This struct is part of ABI v1 and is deprecated.
@@ -443,7 +443,8 @@ struct gpiohandle_config {
  * struct gpiohandle_data - Information of values on a GPIO handle
  * @values: when getting the state of lines this contains the current
  * state of a line, when setting the state of lines these should contain
- * the desired target state
+ * the desired target state.  States are 0 (inactive) or 1 (active).
+ * When setting, anything other than 0 or 1 will be interpreted as active.
  *
  * Note: This struct is part of ABI v1 and is deprecated.
  * Use ABI v2 and &struct gpio_v2_line_values instead.
-- 
2.39.2


