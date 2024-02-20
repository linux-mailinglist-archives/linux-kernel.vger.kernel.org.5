Return-Path: <linux-kernel+bounces-73121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AA85BDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6866B22B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50A6BB29;
	Tue, 20 Feb 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PRJWnwET"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E369E12
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437282; cv=none; b=S8vQJsBxcP4G/DloA7CVM0EfrQjryka8O7vcsM/M0xJADBoVX9038We2ENtMSX1rfVNGQX2PPafJLnI3TzalHQca/HgKEkICK2HhIgEE+KYmIjNBeBWNG/jguqTLH738ZpUI2W/hnkwAjLxpkDenqSwfVCfL8DbyW3/8QzAkNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437282; c=relaxed/simple;
	bh=vhKYdP7Qcdl4LkhlN58vv/A0U9JCapkwita7zLO8rvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SAMcJfJMnobhT+QuV8dpkPI0ZPvF3CFtf+bOMWy3gIZE1eh/xsO8T8tJ9+SKDfQ1WSGunoBOLcL0e14gSut8GNdsXS+W3gZmQWEuau9pilh+VnlUyn8KWXEHXg/ww/chvGFl64YDfYP6QsBJeMXbEY2zGp6Djz1QePoHvgJ+8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PRJWnwET; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d1094b5568so72427171fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708437279; x=1709042079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z6QC+M8rLwpgXw1ZcOkKOzv+dqQjnxMBuKDEQ++J9U=;
        b=PRJWnwETGQZJyL2+nPorLqBGIhODkpHMtQ1vBaERAP+q5ze9DWGyOLVtsKjE53O/V2
         ux5jXdoFWqZW6inTJQvsWS3Yifrb7vVsx4KQ5Qoja93wK1o1me3DpE6rj30zHUQECVEN
         ik/8UwoYai/Srj/JaltXF9kdPEI7BY7j5AlEQQOw2YK65quf4JmSYDh1ZBrNCB1KTJXl
         zljJOWvLcJLfzBFL8PBxgrhVpJmFPFumFWeIySAem1aprXi6ZphefFCgNj5rSEOWV14I
         k+Mc2KsRuyRbcnwUkLSCdrMGz8qaJQjX+zyTyYi8QVLXWqQe/R95/MmaX33gIKqbMkZv
         nO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437279; x=1709042079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z6QC+M8rLwpgXw1ZcOkKOzv+dqQjnxMBuKDEQ++J9U=;
        b=ZS8i0oS7oru5Xhe6FrwpqFMts27tDIzHBbl/ZjzB8bKrvQj+ie3pJY7gO+2123tPY+
         zvvsvsgIBuJkC47Y5Sa4mFcTfBmzpcvu6rjbY7jV+bkB0TRvxPL7G649DlxRUFF0IfL4
         u4Cc40Le+xBec5fw+dbQSTVgjvBAGIZfmAQZ4BWyXYjbx+q9CeCcLY/88kD/lwtO/GT6
         SMdygLJxvRQZ+ga+yoXUqvmMWy0GJqnfa+iEIQ0D6F9Y8u9p6Z4LcAKSWn/lcSiZOemu
         B4sH9wkR7NWCCgLQOR6uEX+U0SdbztEY1y41W5ZOMjlU5C1gYtaA65kiAifcf2XkQDfd
         t0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVnanqIkDP9vfTqwT/OUDgzJ8z3nmOOwTTFZK+RCeNYx38ZNk15r5vjVPecNGL3RyBVMCISMgsFqWUdZUrkdZudUSUk2aEaUbciDUfs
X-Gm-Message-State: AOJu0YxuwOurIQr81mPnCwzSlmqF8clQ8AmUXVWJqfBY65fT4e0w7Hg2
	4/tdmCLIZtM549x/f+VjoLRJQMth2fhEBkrqxDCtEfojFT1XnI79MOanoF/a0ZHZou/51wPeuOO
	q
X-Google-Smtp-Source: AGHT+IFcXwbv+TR2oQ4jVr9yzlD8x+FeeM4U1hY3A5l2IhXR9knwZN9vOF2kpx1wsm58C/m/wtq+EQ==
X-Received: by 2002:a2e:908c:0:b0:2d2:3b6a:b90a with SMTP id l12-20020a2e908c000000b002d23b6ab90amr3499040ljg.51.1708437279163;
        Tue, 20 Feb 2024 05:54:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c6ce:c6a0:43ac:8f8e])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b0040fe308ff25sm14441818wmb.24.2024.02.20.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:54:38 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: delimit the fwnode name with a ":" when generating labels
Date: Tue, 20 Feb 2024 14:54:31 +0100
Message-Id: <20240220135431.22910-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Typically, whenever a human-readable name is created for objects using
a software node, its name is delimited with ":" as dashes are often used
in other parts of the name. Make gpio-sim use the same pattern. This
results in better looking default names:

  gpio-sim.0:node0
  gpio-sim.0:node1
  gpio-sim.1:node0

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index c4106e37e6db..1f3dd95dd6da 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -420,7 +420,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 
 	ret = fwnode_property_read_string(swnode, "gpio-sim,label", &label);
 	if (ret) {
-		label = devm_kasprintf(dev, GFP_KERNEL, "%s-%pfwP",
+		label = devm_kasprintf(dev, GFP_KERNEL, "%s:%pfwP",
 				       dev_name(dev), swnode);
 		if (!label)
 			return -ENOMEM;
@@ -833,7 +833,7 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
 							  GFP_KERNEL);
 			else
 				hog->chip_label = kasprintf(GFP_KERNEL,
-							"gpio-sim.%u-%pfwP",
+							"gpio-sim.%u:%pfwP",
 							dev->id,
 							bank->swnode);
 			if (!hog->chip_label) {
-- 
2.40.1


