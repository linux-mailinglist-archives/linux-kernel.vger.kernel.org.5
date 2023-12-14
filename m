Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03F2812AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443437AbjLNItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443425AbjLNIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:49:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21510118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:49:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcca4c56b9so2382325276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543784; x=1703148584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=aRByfs6jJv1pPl+XO5MRrqPIEKLf20hbEIpup6djP2bJKRqLu9PMErZeB6Wn/uAKpr
         G91nfjkpuuoXv581ZhCxU44bDu3oeBDHIkwI09alP0Ei6zXO3GqXx746/JAUu7mA0xcZ
         d91pIaanzP9lwQUmw+P/4oFZGlKa/+nHsmOJs04dVVrtgq+bIgsnbKqbeAE/LxiIKWVd
         60NngqrtSB8o79W+YfxOKpRVq0hfRyhbEwcvaOK1cQeq1+2uYNL4S8nvfNv2HpGi31C0
         o1wkxhUq292fLKjC+F2uw5swWgMqpmvbjIW4rR/a2FH33eNGai5C4mUhzFKD8p5yLD2i
         3AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543784; x=1703148584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=RGjHlPYUiZPCSg1r3qsEsSHQ/58KcPBxyNLH1w8i2IM4vi+IlHqh3zNzBERnmYSwKD
         quZ+miJw8flm04IwLkMURfdozu57ceo7r45oj7YI+Ah11jjLRGAe3SRyxkwY9myYFZOe
         hKNfwF6Fx0VwAsrkRsNxWQv3Bi+QhdY3Kaa3GutkT1CE4sYQIyo69hY7Pqg5/y5M2uu0
         t/m0hmyU1u4cOE3QKJPBGwsRxH5TTqGMI/RgkmmZteRpltYsZwItKeWBkKlDG1lxw+Br
         H5725WI2TKlrf7Bma8U6t4clGfAv5sPVEsTwzHJ6MxkLfcjIWKg5tJxOfWlQA5ERtzc4
         CHbA==
X-Gm-Message-State: AOJu0Yy3P9HLEJgJ36yXkiEXCEBdJ3OLoAi/rRPA3Qq/17OkMmnEWFFw
        8m/4XCyFeDJuCUiXnsw/kv+icElorpVeqg==
X-Google-Smtp-Source: AGHT+IFVOYWdsgVT9nhqnqJRy5ZyN3SJnHb/wvN1UGFrpdBCV2Uk0Ui6lM09NFUHkZEBROCN/4reVrGN3Guhgw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:ca92:0:b0:dbc:cb73:15c8 with SMTP id
 a140-20020a25ca92000000b00dbccb7315c8mr38319ybg.5.1702543784333; Thu, 14 Dec
 2023 00:49:44 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:49:16 +0800
In-Reply-To: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Mime-Version: 1.0
References: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-2-7e9a287d3048@google.com>
Subject: [PATCH v3 2/5] fortify: test: Use kunit_device
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

