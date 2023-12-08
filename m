Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB380A073
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573575AbjLHKKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573561AbjLHKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:09:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B9E1738
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:09:57 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dbc507311d7so739649276.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030197; x=1702634997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=VDr9tcj4StnA6acjRdrtszhpigA+LyEHfIwbdwp5vEDSLyQ2c06X0f1qayIhI8+EAM
         r6FhkDaaKJDAFG2WPAqaLSFgFJYgJTQmwSinohvw6fX9JU05gn1piF4HSMp1QyjuD+hc
         LlgfLm9xm/qiGoZ+JYDrryT6EFNdLOCNWFYWUNJJIkjz86006ehBfhgbvosPV1O4WBPU
         ABaqxj2OzKfF8pO28M7kbucpENFfkZVMQ+R/GvWK0j/oeVPrTz99IIeQ5nRoaxIhWa7G
         qQ5dED3iTrJbm5hEMRwp3R0L563dY3XUizJ0DaECRNx5LvnFnzhjznIrwqajOL4Tp+9H
         x8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030197; x=1702634997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=Yuzryeau+HcREo/Ar33fi+xZGq6o06clKp0ZUiQoJh7HadbvGsLJ1z6sOl3gWu5Q3E
         WYUzusAO7OdQ2P5Ba655labAV/itMCKPeLKu7tY5+ze0JsTOmXC/Itd26SClQE2MtVs8
         pSpz7dtX5jcC167Ut5AvnXg6t30lGGrp9FKGOE26c2gSBVwPN649yMDY8Dv4ZsxJT5sE
         mxeCD/bJz2pZf2BJ0OKnWU7+7CXq0Wk0gR++ENEkBICDwlsHlVwaRE7uFxnTmZwOZUM9
         UgyTa+ZLJ3dx3lg8a/xfs9OheXxepVh/gl+M2MX8/ffxftnPkiM5OfaPt11dGCszaj1N
         BAvQ==
X-Gm-Message-State: AOJu0YxIu693MvYRGLWmmOt9GYU/5d9db4WA7KxL9MAsg/pvDrQbhZew
        DCUHEGHkbtd0tA6bEBdMAAlnEry8GoD7hg==
X-Google-Smtp-Source: AGHT+IEoLvJsRYtYBtpiMYYBRwRZCWLln+T0Te5bpJ5ZhKJL6iGz1n9WIFhdhIvRsrqNCPNn+H/9E0PqoIsEoA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:fc12:0:b0:dbc:1b65:fd8c with SMTP id
 v18-20020a25fc12000000b00dbc1b65fd8cmr43469ybd.5.1702030196750; Fri, 08 Dec
 2023 02:09:56 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:09:30 +0800
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Mime-Version: 1.0
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231208-kunit_bus-v2-2-e95905d9b325@google.com>
Subject: [PATCH v2 2/4] fortify: test: Use kunit_device
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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/fortify_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..2e4fedc81621 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,6 +15,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	size_t len;							\
 									\
 	/* Create dummy device for devm_kmalloc()-family tests. */	\
-	dev = root_device_register(dev_name);				\
+	dev = kunit_device_register(test, dev_name);			\
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
 			       "Cannot register test device\n");	\
 									\
@@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
 		devm_kfree(dev, p));					\
 									\
-	device_unregister(dev);						\
+	kunit_device_unregister(test, dev);				\
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 

-- 
2.43.0.472.g3155946c3a-goog

