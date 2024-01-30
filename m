Return-Path: <linux-kernel+bounces-44642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11B6842568
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D61F2CC40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E61486ACC;
	Tue, 30 Jan 2024 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wgFSpbwk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54081ACC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618936; cv=none; b=Q2k5huTo5SniyPGpCiLvjFZfqPijvWGKh2TWdX/EP495pwl2MZaA9BACwluqSTVizZz8FaThWv4wXtSDv6pHnQoSgEdh2Vh05Oj0XyKQ3KJqVDHgHVBTd4DYRq0VSYL/eS/mKwXPWCSuhIICzMHZk1ZZXrv0Dvn5o83Nfe4jK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618936; c=relaxed/simple;
	bh=S/S9UlkjefltQgrEp3M5f/11AKo1XM9FdDOMZKtbq60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSiq7QWilOByBBAH02cHmm1Kr95s/MKMbo/ylHJCbsiRpkh8h+jDJOe01WOmuL464pwLvklAJcOQXysZW+mogKMe2czRcLsHRzBou+0PQC34njyxE0ReWylmpmFXbz/U4jBGbeB7vT34SXKzub+HVcFh9BpspjAhhoYd1WzOFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wgFSpbwk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3394ca0c874so3295723f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618933; x=1707223733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9yRKACq6Zf8ZvW2ea3mANAIDDLr8fldFns82V5nX1A=;
        b=wgFSpbwkSHnA8mqaaHJ7AHRJ05bw78v4GKWvArV0SlWAdAruKZfBQCyrQ+8+6VMJJu
         n2Aw4rpmwIwoMJoNq0ymAbmTZRAQoOpqWWm1OrOGpPpdI5Fa0G847U9LWSIRXnVijzKk
         bNaSU9VVQnsEtG+LIoCx18/e55U4lL7qutIlqohlUd5jUSYkr2segJR3vfsfH6rRjdnw
         RE9T23fvfexywTZ7ln+kzaKnoqd3G7sRFmcnzj3NXVtKY77cyGsd8jPuJLHH1t+GQLG/
         Nj3tSePOeLQVrfu1kDKdiuOyrBF1CARsw4FouFRiGM6FOV1pJzB6tz6B3tu8wkOhpWum
         OKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618933; x=1707223733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9yRKACq6Zf8ZvW2ea3mANAIDDLr8fldFns82V5nX1A=;
        b=D4QedVNrKaz3N6fu3hLtVYIIbDQNKMBgwufzInHwGhLgYHCEFdIQYCfOYYkBho10yP
         4gGBekNfS9r/4qTXcq5UHktKR0TS0SDVlUcFqIY71oK8XTIzZGvNgcjNdboTdNHI5HhA
         gytC3hbIRZLpBycr4KzMnW26E+vC0PPGzArz2yD0lMTNgBcgY0e+0PZkXoY6ZAMy8wV0
         gog/+TZkmMbOuuW5egKIE8BSMRH6SshC+SUiEax+e4aZL+2faUM3YWNkK4T3csSl/N4/
         bW9xRnzUshuG1LlMcsTZeXrAygUld9lTrW9qilB9OEo2xMc6GiEOuOXxAW5A2gpKZerI
         fqXQ==
X-Gm-Message-State: AOJu0Yx3z1DrZXbevYboeNzAoPzcBKH2RbYYW9PkDHzFYiHsdu0Dg1NL
	/2SkXXCUeuoZm04phn3YF+gIaLI4RgRy03ALQTZegg3aDnPVJItjWO6iYWLp2SU=
X-Google-Smtp-Source: AGHT+IFq2Sj2t60XDvla1vwwvYgm5Q6Ksyx2vxV8ANhxHcJ+3TUQ3o6Zn45a6XSfyiUWV3Pn2rO8gg==
X-Received: by 2002:a5d:4a05:0:b0:33a:e9d5:3fe4 with SMTP id m5-20020a5d4a05000000b0033ae9d53fe4mr4947789wrq.27.1706618933272;
        Tue, 30 Jan 2024 04:48:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 15/22] gpio: cdev: don't access gdev->chip if it's not needed
Date: Tue, 30 Jan 2024 13:48:21 +0100
Message-Id: <20240130124828.14678-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130124828.14678-1-brgl@bgdev.pl>
References: <20240130124828.14678-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The variable holding the number of GPIO lines is duplicated in GPIO
device so read it instead of unnecessarily dereferencing the chip
pointer.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 8e37e3befa08..e993c6a7215a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2701,7 +2701,7 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (!cdev)
 		return -ENODEV;
 
-	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
+	cdev->watched_lines = bitmap_zalloc(gdev->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
 		goto out_free_cdev;
 
-- 
2.40.1


