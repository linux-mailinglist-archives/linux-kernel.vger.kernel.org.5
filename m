Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4180A80A068
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573582AbjLHKKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573558AbjLHKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:09:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D62D1720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:10:02 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca26c07848so24805347b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030201; x=1702635001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkRyaEIclzm+ShIMyVUbqREgKKajNjynsQ0mobEpXzk=;
        b=Ia4PYyztigFmTktxZsK+SONpo6VUAt6QnxvhqOpLXF33toW7VSD3bVOBWvnjBHTItz
         1BiqSNITOd2BrYnyFCj+/YrVNw2lxIHD3FphQaJB2jhaf0Fa18PtGV7e70TwLAwuho+e
         9y6HwVXMdCuCn+zRNlHmqWpEuJEDComnl23WQvbPM/Zu5x7Dyhue5mPGDd3xfa9MG4/V
         40wNVnsHkktXzmXNVCaLBWL5IN3/3YcN69mbdi93FklJ52rnrxTijOmZJc2q7RFXEir3
         kexo8LGk8Ub+r3m7fg8+n861bs3PUZH8aSiVLqBhgd9lCIpX1uu4vbM/owGhXb8AjKIM
         KsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030201; x=1702635001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkRyaEIclzm+ShIMyVUbqREgKKajNjynsQ0mobEpXzk=;
        b=CxNhpK/r215V7ExOh6ljO/y84bnD3I6ww9manfjxFl56YSc/xIKB6JHwq08rROGYA2
         DBIB2Rnz9EyLE3dKWANOmj/rQIBjFGrebH9QMMR0jrU4ru4MqmYPsE+9UXyxPUs51nkZ
         EemfY3lpspUirFIkNbilTqYpsAb1L25TZ+rRQPcaBzKusbCZbhsBtNwhctqk6+ViMQRa
         F2forS7yMgPiBJ8Ujyz5PyMiKgHF0fLKquUZQcbkgrmr6lzRhWW11VJGLcVuelAsQ1o6
         PBm0+6cPaa4Rybw5CW9yA82qRRdQjDehsV6BSl3wx6jGAQXiE7e1MlIxaQaalMmTttCt
         yMVQ==
X-Gm-Message-State: AOJu0YxlkdHbnEgbwZucMqrd9/1YmEjl1hvm7feGTKB5y+gnyNgR7MxX
        mP+NCBETyzXgXTxA+B2Ykx9Ny7GBm4ECvg==
X-Google-Smtp-Source: AGHT+IHGF3yZf9WJj2lWCzBA+Zp1ww/Jd0TaRJ+ZbfD0tlPqmjYoZLAo7qIUoj8IifBSVJ/CH0LnfRQUmCKMLQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:3146:b0:5d7:4619:82dd with SMTP
 id fc6-20020a05690c314600b005d7461982ddmr53175ywb.6.1702030201444; Fri, 08
 Dec 2023 02:10:01 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:09:31 +0800
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Mime-Version: 1.0
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231208-kunit_bus-v2-3-e95905d9b325@google.com>
Subject: [PATCH v2 3/4] overflow: Replace fake root_device with kunit_device
From:   davidgow@google.com
To:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/overflow_kunit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 34db0b3aa502..c527f6b75789 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -618,7 +619,7 @@ static void overflow_allocation_test(struct kunit *test)
 } while (0)
 
 	/* Create dummy device for devm_kmalloc()-family tests. */
-	dev = root_device_register(device_name);
+	dev = kunit_device_register(test, device_name);
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),
 			       "Cannot register test device\n");
 
@@ -634,8 +635,6 @@ static void overflow_allocation_test(struct kunit *test)
 	check_allocation_overflow(devm_kmalloc);
 	check_allocation_overflow(devm_kzalloc);
 
-	device_unregister(dev);
-
 	kunit_info(test, "%d allocation overflow tests finished\n", count);
 #undef check_allocation_overflow
 }

-- 
2.43.0.472.g3155946c3a-goog

