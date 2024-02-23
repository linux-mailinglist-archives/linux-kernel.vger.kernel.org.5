Return-Path: <linux-kernel+bounces-78295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE7861180
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63CA1C21EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9322EF5;
	Fri, 23 Feb 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cOrr36Ee"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF95CDC5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691471; cv=none; b=M9LkkzcWLtPmcxtckqi16VtIEcrHdFsDfdRiKyaa8BHnc5n2FKZI9gVvnk5aqPV9o+dKj13NVAo4pmn04LXHeNxPYT2eGhWUTLHYcDc/jpEhmy4oXRUT3P4Zjmbnss4LrCmT5ppwPRCdqoZv2wTd7A+I6/zYZtW5bzwuRxJZLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691471; c=relaxed/simple;
	bh=t2++uWVwSO0r6f8oCaq+FIBOtsO6LuaTMtSTxcBnocI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fsWkzfhDZhHX5LbsISndwQFO7fk8ZA2yy9YtwuPGkNVm2rgf4kPFtJW01DE0C0+fdUhZ0Ngtt3DvcNaPEObU4HdYeGEQFItB+AyhtxFBTMj4syqP8p8bW/Vynm+yUVzMbif462wBSIlSfDHHqZ/cg1l+aF99CHyFC9GNcb0+808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cOrr36Ee; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4128d787765so5548425e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708691468; x=1709296268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AScaNI57ZIJRJty0uC8JeEnCo2nJJuAIlpfEG/3GpQY=;
        b=cOrr36Ee6kIM7yLBZdh6bqXRJQ31sxp2ie9Tm48svxaNPEE/T1VztENQS5EM9PzKco
         IiLmndGTjhHCXpt7qbirB8xFVgGbSPDSEoXsQxEhCpaZFuwekRKsRGIC15Tc4f6dEWqN
         PS7eiwAIg0sykzeHFbK+HjqUD/vGr3iztJKJKGVxnr0Qssc/sX55EIVTQODNdrGgaPZc
         3s2Khiqj32wHivye9PUNildLEO7GepvsDWdty9YwDmjapih3mz2DBLGVS1lQrrNpiURM
         ZQew63ODx91qrO6XVS97mTCvzroQRdLMcZnqtSYDt9zTF6VT4Vg/o13czNajCBk7Xr4t
         3iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691468; x=1709296268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AScaNI57ZIJRJty0uC8JeEnCo2nJJuAIlpfEG/3GpQY=;
        b=UyXZzMLd5fAKr7a6AFS7xgE5N9QVYKu+qIrzL43gHVVzfT2UUdt2u2YdmfxNmnNVDi
         rrZiNAQIZ/e0w4QNO+RUEBoHGijIdkSXnVFVSCZH4UPqOryhBxJzeNj5pEiyaXEZ0bc5
         wo2jumRDAJUN5IU/KnSJuZr3eFfp2wj+ho4yseiBTjcEIXHvd9ZY9RrvOmjd3GOum3B0
         9BifqjLPfSVd1CvRe1ErI/wgEzL6DSfNvOaZJ76cBNRwoLO0yw1zxUx/9g1u2VGLYXrc
         8JFuX4Hn7cI/P2iGYh2Gl6rfdBeAaicntJ1WDG0sHbNiAcINmMYAuhqWhBSkImJybzMU
         cJEA==
X-Forwarded-Encrypted: i=1; AJvYcCXxCtwvKD2XT0Wz5PQ3VxzGLHEHC0v4I48IcFavDqtSgN5O3prZjVKH9mqR6P3AGJ70ON492JDgM5ITaaNK9347/mZsv8Il6VSOMoYd
X-Gm-Message-State: AOJu0YycFf08cQAW5AlAOF7ZB9awF9SQVrt77KfB6xMUDgF0o/xipcWo
	9hNB85XNjKj2knovfQSMmVN0N6kDbRknW8jhvF9gQ9aZEUP7lr56XhdR2E75Qh0=
X-Google-Smtp-Source: AGHT+IGQxmxZD9eGNqbkalWaSGVTAx9uZY6zmFHZ/hrvzYJB6zwaJc9o2zchkzq5b9/lfDMYPUK6jA==
X-Received: by 2002:a05:600c:46cd:b0:412:9434:fa28 with SMTP id q13-20020a05600c46cd00b004129434fa28mr1089220wmo.7.1708691467475;
        Fri, 23 Feb 2024 04:31:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d13b:cd88:628f:8c6e])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b004128808db91sm2292126wmb.23.2024.02.23.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:30:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	David Arcari <darcari@redhat.com>
Subject: [PATCH] pinctrl: don't put the reference to GPIO device in pinctrl_pins_show()
Date: Fri, 23 Feb 2024 13:30:28 +0100
Message-Id: <20240223123028.288038-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The call to gpiod_to_gpio_device() does not increase the reference count
of the GPIO device struct so it must not be decreased. Remove the buggy
__free() decorator.

Reported-by: David Arcari <darcari@redhat.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ee56856cb80c..bbcdece83bf4 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1644,7 +1644,7 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned int i, pin;
 #ifdef CONFIG_GPIOLIB
-	struct gpio_device *gdev __free(gpio_device_put) = NULL;
+	struct gpio_device *gdev = NULL;
 	struct pinctrl_gpio_range *range;
 	int gpio_num;
 #endif
-- 
2.40.1


