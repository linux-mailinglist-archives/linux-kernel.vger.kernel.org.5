Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94727797671
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbjIGQJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbjIGQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:31 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C0284FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:02:33 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31aeee69de0so1057892f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694102426; x=1694707226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HijaDWjtU9+MMMmQDH1Rm0HmHWsQfV4zHlVWc3shxSo=;
        b=zT8e224Cf3jwAOgcQC20YZD2ti2kGivhecvkzeMw7uGCccFQ0Tw4+1tf1KODYNsd1A
         QMSOFkaoTLc9AVMf4H1alX6iJi6IxFdNYIOW6NzDxFhGyHlVa3QKS7S3yLmlNSObKufP
         sSItlP96FB6ww2mye0orLFubdvaaPt2AY0DBvsRmS54gFdShPJjcbkxGIRJJq6eiEUCm
         k9+9r+UwsM+VtId327utfQ53kCT+/25r4JBeLY4YS5JA2mk6EqcGaa2qQJUu5nvJu/vm
         Hnp0sPZAvIMeUC0S9f6qFAEkXnVCXFDtbZxC/p3C8MdCzLcCWQOYEtN+32vdBBgSTuey
         mCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102426; x=1694707226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HijaDWjtU9+MMMmQDH1Rm0HmHWsQfV4zHlVWc3shxSo=;
        b=dQGad9aGXAM7Th3mVJ+F6oJbwIEWzJHzDkZXFDX2O0UGYklLX748I5fF0TX4Cz6sMa
         p3yRFo6kFbxdIqXeYPaxfpAJDeO3NHdNVlsNj0JdiXn0NDSo9jLIzu4n3nm3dyastwaz
         +Iuu8t+ylxQvTgO2kMwbf4e03l0XdMtjm9Tqu3AzZuTyCUk8YWlyvShiUytq6Slod4ZU
         oooL6CMML1jumn+G2cVcDx989s44Pdhcs215f3riP6cfR/0JYXAnz8Rkjcd+5keGrPKZ
         OPVCMv40sZrVWOJvXZ9rLQ8ydfMN4mLiK/Fh5NMUHL04EDFkUXYf/Q6Z1KgK8pcpsTb/
         mEeg==
X-Gm-Message-State: AOJu0YzY0HZ+ClXj8OvL5drQYZJqEkgIs2lsf/usfQTKDOt/BWzvJPxT
        h0d4iw6kJsOo4mOEJ0072WSZe4aJppPiVImoph4=
X-Google-Smtp-Source: AGHT+IGMfrd68cQiTItvDb+O04EvbhJPhzV/s88UZI49HyvK3RoNa7kYSWHBGxozNXZDNyvX7p4BiA==
X-Received: by 2002:a05:600c:224e:b0:401:b2c7:349d with SMTP id a14-20020a05600c224e00b00401b2c7349dmr4904033wmm.29.1694098353082;
        Thu, 07 Sep 2023 07:52:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003feef82bbefsm2757588wmi.29.2023.09.07.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:52:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/5] gpio: mockup: fix kerneldoc
Date:   Thu,  7 Sep 2023 16:52:26 +0200
Message-Id: <20230907145230.44085-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The pull field of the line state struct is undocumented. Fix it.

Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index b32063ac845a..17d4d48524b7 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -39,6 +39,8 @@
  * struct gpio_pin_status - structure describing a GPIO status
  * @dir:       Configures direction of gpio as "in" or "out"
  * @value:     Configures status of the gpio as 0(low) or 1(high)
+ * @pull:      Configures the current pull of the GPIO as 0 (pull-down) or
+ *             1 (pull-up)
  */
 struct gpio_mockup_line_status {
 	int dir;
-- 
2.39.2

