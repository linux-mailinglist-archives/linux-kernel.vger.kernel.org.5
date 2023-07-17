Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD67756DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGQT6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGQT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:58:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9960F136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:58:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-668709767b1so3568071b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689623924; x=1692215924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rR/WXoMTQWpIUYil39t/+gnlISlq3LT4l8C56BzZmtA=;
        b=C9A5FyWyJdLMLcgM2nbvMhNVoYyvZsdYr3itLtwGmaidb2E+4aBz/cmsAH33eoyHHm
         HCpvp/J4RfFDFCtWouqvg1amXx83YA2jxeygypGCjGqAdDJQoWSg1o0iteaJhXtvF84u
         8LSOvuq1XeK7ByQO2HqaeNflruX/YGmWqgRAd6Gxng5vyPTZVK/6WcGmOBvWakftPVmg
         1EmdFzrKJuMdpztu4WZICYFzgPU4rq0+fV1Tp+0lHEr5oTCL7ZWi3Wh3rQHGAE0Dpy4k
         1SmEf1H363eCXej7FKrpIGgv+y7x4oAgCmP0iiEd2Jce5WIQI2xfFeG9amR6qCc9lUC1
         R2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623924; x=1692215924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR/WXoMTQWpIUYil39t/+gnlISlq3LT4l8C56BzZmtA=;
        b=Hu7TWsWqwbEEPZP5b0ZnzZJl3BH/Qb3xlPdx8pA3tzrLIWyFuH6a31o31M42jHM0QH
         k68Gm8f530NjIRDfaOxo/RKEjB5AXT4s94RNg8uGP184AffYMi3Hc3y3z8DbLatclB2z
         v2XvWUQpCULl9ShyixXZPr2HfKRruOd5uIWBHG1wyvvbEsxVBT3vQzUii9Qzdf+gUb2a
         QOM+X/8/PdR/93K9vKYNWpiFORwf9ZFoZj+76QgsKwu4axIR9oYUUhKbt+ZGwwYKkn3v
         MYo5wmFck8FmltP4rLCBBhVkMXpsT5yZhVjFaxO1a3nGjawzn0WdBOl5E3S2YZb4tEjr
         sjpA==
X-Gm-Message-State: ABy/qLZkheflaYEqJ5+H/CW0VxWM6vJHLUTaV6J0bQatMLgQkSEl4dP7
        4fMUI2gsBRXESgIO89uUREDb3CmyGe/Bjw==
X-Google-Smtp-Source: APBJJlFMy4/IrDNwje1azicy2QD5va5DF5szxQAAc7YOt0kfRukNidF+lJUKk5yNJi+cT6gcfNjVRQ==
X-Received: by 2002:a05:6a20:3c8c:b0:133:cf5c:4d2e with SMTP id b12-20020a056a203c8c00b00133cf5c4d2emr621393pzj.20.1689623923509;
        Mon, 17 Jul 2023 12:58:43 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b001ac2be26340sm246556pld.222.2023.07.17.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:58:43 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev
Subject: [PATCH] lib/bitmap: waive const_eval test as it breaks the build
Date:   Mon, 17 Jul 2023 12:58:13 -0700
Message-Id: <20230717195813.29059-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang, and when KASAN and GCOV_PROFILE_ALL are both
enabled, the test fails to build [1]:

>> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
           BUILD_BUG_ON(!__builtin_constant_p(res));
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:185:1: note: expanded from here
   __compiletime_assert_239

Originally it was attributed to s390, which now looks seemingly wrong. The
issue is also not related to bitmap code itself, but it breaks build for
a given configuration. So, disabling the test unless the compiler will
get fixed.

[1] https://github.com/ClangBuiltLinux/linux/issues/1874

Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/evaluations assertions")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf..a791fdb7a8c9 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1163,6 +1163,9 @@ static void __init test_bitmap_print_buf(void)
 
 static void __init test_bitmap_const_eval(void)
 {
+#if defined(CONFIG_CC_IS_CLANG) && defined(CONFIG_KASAN) && defined(CONFIG_GCOV_PROFILE_ALL)
+#warning "FIXME: Clang breaks compile time evaluations when KASAN and GCOV are enabled"
+#else
 	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
 	unsigned long initvar = BIT(2);
 	unsigned long bitopvar = 0;
@@ -1177,20 +1180,9 @@ static void __init test_bitmap_const_eval(void)
 	 * in runtime.
 	 */
 
-	/*
-	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
-	 * Clang on s390 optimizes bitops at compile-time as intended, but at
-	 * the same time stops treating @bitmap and @bitopvar as compile-time
-	 * constants after regular test_bit() is executed, thus triggering the
-	 * build bugs below. So, call const_test_bit() there directly until
-	 * the compiler is fixed.
-	 */
+	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
-#if defined(__s390__) && defined(__clang__)
-	if (!const_test_bit(7, bitmap))
-#else
 	if (!test_bit(7, bitmap))
-#endif
 		bitmap_set(bitmap, 5, 2);
 
 	/* Equals to `unsigned long bitopvar = BIT(20)` */
@@ -1220,6 +1212,7 @@ static void __init test_bitmap_const_eval(void)
 	/* ~BIT(25) */
 	BUILD_BUG_ON(!__builtin_constant_p(~var));
 	BUILD_BUG_ON(~var != ~BIT(25));
+#endif
 }
 
 static void __init selftest(void)
-- 
2.39.2

