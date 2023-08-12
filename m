Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89B677A1EB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjHLS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:57:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3B4E5B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:57:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317744867a6so2701798f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691866672; x=1692471472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/21GGjh/2DenAK5c5S8Pb9LJSQSqgcb2AvAsLRxUD2Q=;
        b=F74QE+uPqtWJYURaqGyvnfDvThlu/FFgWs/dbbuo66q1Gw0QmoPp0MrGAqaKCJ6NIg
         d/4WfGt0ScPefRGWTb7PSRAV6HErD5HmR+a9rh4fYfBF2P3Xs9bT/yk6oCkH47dqhCfM
         CC36Y79dj5XXSHfTck8JMibjQM2UP9lBFNX0yfMebYe9Fb6vRiah/iXgoXrNN/rASbYs
         h1vsBswZwWYFSAnPLw3zBZis4WSc2cwYimqcF/5hF6X7i6nzEjek62T+xTN/MZdxvdxc
         uOe4a/KY3+k2MNwzzpf7mQqnNucRxrwn09OHHral6lRvE7aTXuS1pmXbziDozBzDUQWe
         heRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691866672; x=1692471472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/21GGjh/2DenAK5c5S8Pb9LJSQSqgcb2AvAsLRxUD2Q=;
        b=S1fQP3ERYYV91CHk1B8cSIrJPkbYOogwIpECGzkmlVO0BcdPRf7Y3uR+Rg5WH7QOPv
         TIxuyFHFtHxircGdO8nzwfJpTNqXXbRyl13P9OtVHlTHVBn7r//A9QjBYW+RJnLKIDF4
         W9lITVN0hlhgMjFfvVjL7kkP1c4hLFTyDJChMTr72H9BoiqaOH5whsU9Pkt8MNzKvoGM
         +E3GQg8tgGwFjrjcmEZQnx/KSKkPduS2YmDlYUVb+sInFstNsdLyKdJNtPV27t/fJUxo
         5b9l5FsHr5jXE7bI3CJAvKWIsra1d7WbPL8y/VzwvxBQfTc2mVXenZnTbC9boofE6lWn
         Yrlw==
X-Gm-Message-State: AOJu0YzA7rrWpcry56wkINE1Wyd9LvQjXCUobXTCe7sVE8pcuXuPoXSV
        4lFJlvKcsjhOT1LzZkEgdtGoniTLRG4HbrU7XLBcvg==
X-Google-Smtp-Source: AGHT+IEGU8nf/GDvFc8rqXPJa7PmOMEtg578xY3TuYtL0jHYRvZ7Xc6BenGhARYiL4neWvVlA5UC6w==
X-Received: by 2002:adf:fd50:0:b0:317:55c:4936 with SMTP id h16-20020adffd50000000b00317055c4936mr3760656wrs.9.1691866672157;
        Sat, 12 Aug 2023 11:57:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b003143ba62cf4sm9286044wrw.86.2023.08.12.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 11:57:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: replace memmove() + strstrip() with skip_spaces() + strim()
Date:   Sat, 12 Aug 2023 20:57:48 +0200
Message-Id: <20230812185748.5799-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Turns out we can avoid the memmove() by using skip_spaces() and strim().
We did that in gpio-consumer, let's do it in gpio-sim.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index bb8fcf2a794c..106a73263f49 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -633,16 +633,15 @@ static bool gpio_sim_device_is_live_unlocked(struct gpio_sim_device *dev)
 
 static char *gpio_sim_strdup_trimmed(const char *str, size_t count)
 {
-	char *dup, *trimmed;
+	char *trimmed;
 
-	dup = kstrndup(str, count, GFP_KERNEL);
-	if (!dup)
+	trimmed = kstrndup(skip_spaces(str), count, GFP_KERNEL);
+	if (!trimmed)
 		return NULL;
 
-	trimmed = strstrip(dup);
-	memmove(dup, trimmed, strlen(trimmed) + 1);
+	strim(trimmed);
 
-	return dup;
+	return trimmed;
 }
 
 static ssize_t gpio_sim_device_config_dev_name_show(struct config_item *item,
-- 
2.39.2

