Return-Path: <linux-kernel+bounces-57807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AE84DD9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7499FB219FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76476C72;
	Thu,  8 Feb 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LcvLjqIA"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B3763E8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386388; cv=none; b=YsjFfyHi5Unz/r8urCfvXYAguf/uJoDkT7/KT6tG4usiAKaVAc7DBaDooGiX/ebBt6IVg+ngrsMgFosK2+C+eeEGgiOuLj1gUlOv+p9RhCo1sGQ3jE2ja9rtJUv2rcNG2jGzd5VYW1ZMPWuBNM+Mj7B5HFe+WD1rIV3wovPalu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386388; c=relaxed/simple;
	bh=zyYRmke/1SCtbqMjlRvTGUpu/1RsBvW/3TjBpD2c1Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4yA+IN2ODVDZBLaK3mLnsc+D93xYr1yBLHOlDtJGwDM8v23XzKRC92tGjHPg/UCSGsvIZBCE3xzroDmtDoKWqJVI/mGc4f1gLyqtCTkR4oDw1lNxdAqkSQfuQKeBgEIMj+csXHZVHfaTLSTIQzRL99/sxGn/w/PUDYQf9AkeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LcvLjqIA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so11526565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707386384; x=1707991184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYIRlc5OkrwZx92ZtvrH7YghLqa9zERXf/+sLJWSs1w=;
        b=LcvLjqIARyhPHJeE+GFYZBV5UxQZzWZ0ij/9yf8Ngehd0w3F2g5D04+RrkJVTCqvBB
         RMB48xYbJWcgD4UK+JuFGYGWE4TjBiLX00L53ltF0fztELSUgrC4YN2cek7/GR1yxOjG
         f+kwbqUQA06VBoRHS3e5F1toEE2PwHyz9WoZWbNIVspTg+tT++K8y7Q0JDqsv3VecyMD
         a1UT4ARal0RrWdwmo/IAIA6peSyJtThQOxZ7xwlaMjVwev2Ry6J409fj3gRCWDz75lxn
         QhUBxzhlosS4Kg+K5nilCmrzcZtqIAErZmkOg2PqICPkmd36n3XAq3bcTtWfEBZg5Q9X
         gGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386384; x=1707991184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYIRlc5OkrwZx92ZtvrH7YghLqa9zERXf/+sLJWSs1w=;
        b=fJmv12wMqT6FgTIZxunVAyB8dqTVgELPSu8VIaeHP8qUxKW4OoMc9BNld7hIjbpNN+
         qBtvSl3pMurwJGs4K+2noCMOCmWFoERFA85msjrAhye2gHm1IF+CjXC6rcHe3Qd80oFT
         g0B5/cfu6FbXj2Qgb6Geza6FWO2G6UUl6a/i8QyI0u7599gZO0ml+36jV8tJehcHHn4Q
         XbiFhovSdpZ7+g0VCH7mrNtJCNQ2UsV9FXf7nBKsvsDpjyfBucnCKTlYjTG7rIZ/p4dR
         ezdMHbdtjr4/wAwBCU84ETrqXZ9pQiMufpnOFB3Giov56YkNYG7IjxjqgMuKcVhHW5u7
         pFcw==
X-Forwarded-Encrypted: i=1; AJvYcCUD4UvRHhakNXYo7dm2N7O3V+4wA4yqBpfhH25PkDFfh5mDAXB65gow+uAFfjTCBKpSjJM178X30ALPRB+e1AguPlN43lor7H6uTjKT
X-Gm-Message-State: AOJu0Ywg6XW/Hdk+HhomF9dfMDUfUIZH6pXOxGTpIQF972192FP+Hd2f
	2+eAVPJDdOpISKDWXh4zkSfUxKwFsU30H3vuKBVE5Rjr8tzvsmZPWT8PHL2a9bI=
X-Google-Smtp-Source: AGHT+IGmjI3oUCT6UGyEZLyHOIfrA6gY0gJbhE50NLpRBeSQx92Z/ddnY3cwTtLCzY6EZet+u3ke7g==
X-Received: by 2002:a5d:5905:0:b0:33b:28df:c370 with SMTP id v5-20020a5d5905000000b0033b28dfc370mr5240161wrd.14.1707386384098;
        Thu, 08 Feb 2024 01:59:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViQt0ORtUTwvgRsnwaxwfM9LU+1xPs52gzk/iVEXu3OHYomnxR4eYemcPqJP25T2cd28tqXed7sdF+8igZtyf/dHBDKXDm3jSYxaCQkQKqu1BfSc6k3hJvq+mDOwqfaX9jLa5S2pINY9+/dFo05YgavaF5YixHlIxhga+1Enjzw0YppwtRHXEX8B4Psmem6OjvYrTOaE2U2FiKmCWwXHwsh/oFxkTMsfS3YAJMCWvOBYjX8XDdc/taQNCOvcExbe5qj2Y1Jjrw0Nt1X4Xv7qvtvLNLshQkRchFXcYTpj+tDvQqiIZQ/jXnyKFbP9Dk1vkKtUzzOnGj+Hb81o1Cg+j9U+N/0pnI+A==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:44bd:e160:131:19a4])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0033af5086c2dsm3265963wrt.58.2024.02.08.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:59:43 -0800 (PST)
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
Subject: [PATCH v3 18/24] gpio: reduce the functionality of validate_desc()
Date: Thu,  8 Feb 2024 10:59:14 +0100
Message-Id: <20240208095920.8035-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208095920.8035-1-brgl@bgdev.pl>
References: <20240208095920.8035-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Checking desc->gdev->chip for NULL without holding it in place with some
serializing mechanism is pointless. Remove this check. Also don't check
desc->gdev for NULL as it can never happen. We'll be protecting
gdev->chip with SRCU soon but we will provide a dedicated, automatic
class for that.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6598960b29de..9be7ec470cc0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2257,19 +2257,12 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
 {
 	if (!desc)
 		return 0;
+
 	if (IS_ERR(desc)) {
 		pr_warn("%s: invalid GPIO (errorpointer)\n", func);
 		return PTR_ERR(desc);
 	}
-	if (!desc->gdev) {
-		pr_warn("%s: invalid GPIO (no device)\n", func);
-		return -EINVAL;
-	}
-	if (!desc->gdev->chip) {
-		dev_warn(&desc->gdev->dev,
-			 "%s: backing chip is gone\n", func);
-		return 0;
-	}
+
 	return 1;
 }
 
@@ -2345,12 +2338,7 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 void gpiod_free(struct gpio_desc *desc)
 {
-	/*
-	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
-	 * may already be NULL but we still want to put the references.
-	 */
-	if (!desc)
-		return;
+	VALIDATE_DESC_VOID(desc);
 
 	if (!gpiod_free_commit(desc))
 		WARN_ON(1);
-- 
2.40.1


