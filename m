Return-Path: <linux-kernel+bounces-44639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411F84255F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAA828E2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F781AA5;
	Tue, 30 Jan 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H2bkYibW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7176919
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618934; cv=none; b=IlzsowsWBo2cajv5bJ4R/OY79Z9JEsqPYpW6Tpi/tfN5kLKlWYSD0sDVXtgFE+AnLGDbNF5/A1woxrlrvtWxIWqXxoLOUuKCIiHNxXuOeNPqJdQhRiRkU2xEW0Saz5s3LDDN8k9kLgcpFCc7loqmx/nwxMGIH9K2b3bvCvejL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618934; c=relaxed/simple;
	bh=rpDac9gg6movVuL1e6sh06EenSTRMk7AFcaCXg+P2A8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DgneOX16vuJhrnXO/2dMrZlo4jbR/1V2vlJFhXZxNM3FFrUiq1cRCajiOEIlhovb9m3RfNiLuBq9Tw+Ei7fWs6XxSO08a/f8KQxE6g0flzvH32yyRVTSFZhn/iwAGdTe++2kZXbeREvQV5AnXl/LSPfrUowHhJQxkGruV3/kuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H2bkYibW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae2d80b70so1888981f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618930; x=1707223730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM21fAXHDQoD3/XsnlkXEmpL0zhUIy1jPwVUkTUkjn4=;
        b=H2bkYibWWX5CaswbL4vmwqsMr262ApMdV7kTsBgrTG52rXdvGtm0ZCV1WPsXzgsZ1S
         T/eHEenALKBt9bDOUIm0Bx/YdTIu7EkGJ3V+CE13HYHNDPJc6TdZapAbKXe+tIDTO5EL
         nD7zjKeby0rsFVuhD9tqQWicdsKqvVbrVqJ6A6DLJmzR3kJ+Ce9vIWOOmEPK9aCiwyxO
         X7DPXYDJeS+8m/zE81uQ9Mnm/2iCguSxjiRXwr/ag2t6J0Yy2wyoR7O89eiEGI5O6Wku
         JxBOls0WK7LHVfjv2VzBIE4vnAtqTZ9NQnjzV9cBrqnigf9m5V2MT5SZd2NrL6CxKiv6
         zpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618930; x=1707223730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM21fAXHDQoD3/XsnlkXEmpL0zhUIy1jPwVUkTUkjn4=;
        b=lxDXF0+dV8SfBugrGoHFwfXFT06mwNqij2NbVPN725XKQzCOue2n+sUMfvAVV4VAbF
         mrG9Zbv5+3LUfbdd7htdYV6S67nKmcz1/gsZgdbQjuh5L+zdBjV1hVCG/sKuEzLwylDE
         s3gah5pFLEmYE3aTkYuvYmCJ563y96oCI1MYdR4j1tgD4w6OwdtW84sw21s83X0b6Azv
         AAxuY11mVexP3v1RgJCdImAPQ9uheobz3gPJHGcRQtEtN7/fI9l0CwB7Q6Iavmyzfpf4
         yc1+W+rY4WBkkTUIaklvHwE4/b2rDs14ESbnu3DOc/JbKcG2PD5d1DkPiWxc2zHpE5CS
         FwwQ==
X-Gm-Message-State: AOJu0Yz8bki5PbNoWpimQqQ1wrU4WwToEqFbeGvL8XjCMvOBdwix4QAR
	v6SwBFxpMH82LFdxi0yemhNsEn/xj0cc1r7Dw2hlo3No8FpqIZrmjrPKkM2niec=
X-Google-Smtp-Source: AGHT+IHJkklHElRz9zZaMAQVBuiyldPe5m6d76wouXJfRiBOAVIK9zHCKIAYgSMf/z9fN1pO0/9Kbw==
X-Received: by 2002:a05:6000:1544:b0:33a:ed19:9f37 with SMTP id 4-20020a056000154400b0033aed199f37mr5186238wry.47.1706618930522;
        Tue, 30 Jan 2024 04:48:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:50 -0800 (PST)
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
Subject: [PATCH 12/22] gpio: sysfs: extend the critical section for unregistering sysfs devices
Date: Tue, 30 Jan 2024 13:48:18 +0100
Message-Id: <20240130124828.14678-13-brgl@bgdev.pl>
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

Checking the gdev->mockdev pointer for NULL must be part of the critical
section.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 1cc707685f87..5da316ea9cc7 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/init.h>
@@ -768,15 +769,15 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	struct gpio_desc *desc;
 	struct gpio_chip *chip = gdev->chip;
 
-	if (!gdev->mockdev)
-		return;
+	scoped_guard(mutex, &sysfs_lock) {
+		if (!gdev->mockdev)
+			return;
 
-	device_unregister(gdev->mockdev);
+		device_unregister(gdev->mockdev);
 
-	/* prevent further gpiod exports */
-	mutex_lock(&sysfs_lock);
-	gdev->mockdev = NULL;
-	mutex_unlock(&sysfs_lock);
+		/* prevent further gpiod exports */
+		gdev->mockdev = NULL;
+	}
 
 	/* unregister gpiod class devices owned by sysfs */
 	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS) {
-- 
2.40.1


