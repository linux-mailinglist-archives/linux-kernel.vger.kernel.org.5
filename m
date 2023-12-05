Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E99804B28
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbjLEHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbjLEHby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:31:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC40129
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:32:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db98b9c0fceso307702276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701761520; x=1702366320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0zdW7CBKdTcyZ6NkC3IZ70G/WJIHzJoU6Zyjp/hyXw=;
        b=ODWFWSuEFkV8GCsHmRatZGcony01v/uW8FqEAWHZ6v9DKNcJr7LGwv6RREzSth54Ij
         0tfb8D/Yqk1dy4XES+mC+pN1hzucQVSEC9EOKMcy/fxjQWqNvBxTlrsBBdTmUqe4+BcV
         23Gnvl2glpk7aWBBBKV3CcfznbCgyqtAF6kecf22J5aL9mSFLJnZxzbvnm88zivJP3Xe
         utUwuAIb000bpYgKsIoQTqrexGfTygbx3GIu8xqVFNjGrQ3fftlD3K+8Lh/1JjeQwZPM
         DpLH1qS04Or6194+Zs/o3+dYTeFTyJgJOE9Pv3GmrqU9H7CCms4burSVn3G3KME2vDuM
         wlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701761520; x=1702366320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0zdW7CBKdTcyZ6NkC3IZ70G/WJIHzJoU6Zyjp/hyXw=;
        b=GiHoe4HXHbiqBJjFnn3pQHVhFEd945rseoP1Q9ePCKYQfFQhvFF70NIg2DRR/P0Bp5
         GHqlJhPfEaGoC28+3omF88LBCGA3/x4WUI6uQd5mDFPDA6lwxsi0wrCZ/+5Ehb9QZMsc
         6rzM/+dqZGqau/VCs0NfyzOZtQAokVoalA4XMSuE7jhSuykfoT7EvxiuMmKN/HR1ex8U
         zzf41nB+A5y0egxeS+032ce/+nHKilykOn1Eq2ZdXrUahAsv+qW0GUV0Cbi0JKkkPYzN
         7i+vQVzbiaP0L09OloAy0KwGPVy543ZwEMSHnB6A1+qPFnVo9RPwi6P7os/ePgP83QZp
         nRdw==
X-Gm-Message-State: AOJu0YyT8Hw3b+GK/xlm6z7/ts0xPTS4/uzTTGLgwDKMzUNvKSUILoxU
        NPpjMVT29QELTPzMdM35ImE5PO6tY/SV7g==
X-Google-Smtp-Source: AGHT+IFoVz0OcZkIRG5/Sf50+3F5qfsDJpbbL6ah305RE6J1zf52P+Ky7oV+UR+nfZA3THFYH0yVogxgbzcb5g==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d04c:0:b0:db5:4b1d:c63c with SMTP id
 h73-20020a25d04c000000b00db54b1dc63cmr312842ybg.11.1701761520168; Mon, 04 Dec
 2023 23:32:00 -0800 (PST)
Date:   Tue, 05 Dec 2023 15:31:34 +0800
In-Reply-To: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
Mime-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
Subject: [PATCH 2/4] fortify: test: Use kunit_device
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/fortify_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..f7a1fce8849b 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <kunit/test.h>
+#include <kunit/device.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
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
2.43.0.rc2.451.g8631bc7472-goog

