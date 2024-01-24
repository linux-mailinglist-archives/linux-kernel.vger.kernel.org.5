Return-Path: <linux-kernel+bounces-37319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A03883AE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF451C215D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230B87CF1A;
	Wed, 24 Jan 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AwEsD74k"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624597E59B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113052; cv=none; b=LjFagXJ/xZo8MJ8BDwvDul+V0AZ7q9ZUDfSyA9AK2MVjBS67S0ETg9WWixAQ3ZXyzOQu63AVLU9TYL5FwV+gUTvfhgFhBdxsilZAbFESHcBdALqriAVLD+Mua0PDoyRcXZ2QvGhAL2Rtg7RRbSij4u7mYbERsx0te0E9vuIkxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113052; c=relaxed/simple;
	bh=VAsb6eqfeLYmu0jkFcyOCz0ft3WU1lhaOoQGrRSaFgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fajVGb6tTDNqsN1IhSMYt2F41rPbmRXOzfuFueWI2e561lN8sIcwx16xvNFiF0Dn8MRh3oCf6acgSA6qqQXg6CGOIIDiwlskJ6WSKQocGX2uE2VscwFN3FuHgAqBu3oIIg154h4jHm20es6mzv/xVvtRnY4b0z6X1yg77XINaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AwEsD74k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33934567777so3760076f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706113048; x=1706717848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jO5aQGUKaS/fQM2T1bnOFpERKUWDVkmi7oXuFEYw4zk=;
        b=AwEsD74kl7eG/nzhJfyNqM3SEWFfdh2UxWGFoL/pk8bvOs6f8OCnMoNAzgRfm1dEh7
         NHwlGzyiSGOCD8Sqe5XVHDAKoMT0ffB62Xprmd5NuAlf2DQt96gIvR+UhMkDffKgth7U
         yLgBmU4ZsjVxc200Z2HowsMrd1XkLFSm1B7jRJbweRl9dlcSezeAl0o64MiYrPCBzYYj
         uiCPR7NSXZDAxdXY0jUHbCqw1Yr0aOv3oguHmukZZaSGGmBcPiRLKpit7WdIp5Alzo3x
         3EjITa53LVfB4Bb6hEDtCvwa3zvXZHQA2XlnoSt5xkxvEAuDUDydvvE4Cbklpqoqa+0r
         9yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113048; x=1706717848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO5aQGUKaS/fQM2T1bnOFpERKUWDVkmi7oXuFEYw4zk=;
        b=fSpufSMV2u75x/p6OmFdwZFgygdQvISY1O/CueMNXXDvK8jTBdUowOCbhCvlz90smh
         z59JzpD8KBLFZsOOGYOdHzhDSnWvYsL30oInV0vg4R3SrVkeuM/v8z97KjvLUNM0wdyx
         uGa3mzcRg+BiaVHHIfthn5h25NLRHYJoP1KPO9npmzzberEem8F55IWrkQ7zM7EAMKV4
         RreNl8TFzFAp+CHZJ0/KIxChyf8x4fZjwHW1BbZ1RwomdgMV3ObN5fjGHL3DaHyWm6C/
         dk7dXGUXh8FjXK+4GQ230m5t2ipc0b+jWx/hOr/hQ8PFZi+8glK32G6MLipY/+0aHHgS
         fVpg==
X-Gm-Message-State: AOJu0YxaDRbo9moprx80lPTq6eXVuPW9/anWzebazhZOu6cjdsBfqlrI
	SkPpbfDJHOkStrb3UnanNOjRKBIlOME98VAG24QpSbMY+jVe/z9gG2xKLVdy/DE=
X-Google-Smtp-Source: AGHT+IGGN2cmVGtzO+EblLJMs22ucaqzXyOuBysf4VltLySs2AOpjH5IouqQDI6L7STaLhSzNaUe1A==
X-Received: by 2002:a05:6000:104c:b0:337:d649:da70 with SMTP id c12-20020a056000104c00b00337d649da70mr679971wrx.138.1706113048439;
        Wed, 24 Jan 2024 08:17:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e737:cf8b:25f7:e0ad])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0033928aadde1sm2764761wrx.48.2024.01.24.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:17:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: cdev: remove leftover function pointer typedefs
Date: Wed, 24 Jan 2024 17:17:25 +0100
Message-Id: <20240124161725.79582-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The locking wrappers were replaces with lock guards. These typedefs are
no longer needed.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2a88736629ef..34d6712fa07c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -61,11 +61,6 @@ static_assert(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
  * interface to gpiolib GPIOs via ioctl()s.
  */
 
-typedef __poll_t (*poll_fn)(struct file *, struct poll_table_struct *);
-typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
-typedef ssize_t (*read_fn)(struct file *, char __user *,
-			   size_t count, loff_t *);
-
 /*
  * GPIO line handle management
  */
-- 
2.40.1


