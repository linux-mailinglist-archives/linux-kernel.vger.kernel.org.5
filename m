Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF0756F97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGQWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:04:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53EE56
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:04:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66872d4a141so3242731b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689631480; x=1692223480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbBg1qhK9YTZ0sKHzhZcMzAk3NkTTX/1n/b9teLLE3k=;
        b=pKFC50AyGRPQt1B/FTQKbvTlG//MP6daamMY17PhBKatjdHCUeynXF4qBlwgQPcHVD
         TLFNA7cRdDtojThrqzBaWXlUCsdMtdUdn0l/JdVSr8DggO+cwEheGGBtXpoqO27wTpgG
         lcpAKzHO5Eqt64RiqkoXawdbWNm83QOqETOTH3+qgkY5VognwfniWLv/x5susfsMr5xL
         rostPYGWZzPTuWowdSXGmiLsqMLsQuHuFsxmDpbDjjc0MkltVAojPpNaqvuf+9VM2/+X
         ZTyQrgIrMaxuwaNRi+2UkzMzM421+DKJAWn1t6Ai4BDCbcRYA4R26PBNkKH6qgJYnuR8
         m4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689631480; x=1692223480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbBg1qhK9YTZ0sKHzhZcMzAk3NkTTX/1n/b9teLLE3k=;
        b=QCagg85K5tC4gl2t8L9KQiZ4WTTU6P5+JvcvJuF34ZmCi67pZCcPWmmXVcjALpeq3S
         MfvPoMg8KH01BuUNOgkSjf5k/LV580wgnTpk+2J61CoK8kpP/oXtNEOugNP6Of+0h/8p
         JLNDrBj2MHLSkyWiqRAoG9+FfPt0G1RIUlY4HaXBBF3jAPoyP2Yu1VI+mgakZHtGVVYV
         Btb2TkMTs27dg8GuJE3sX5+3ZU2m87xVZEcCPW2JCbCsP7xr2TqkTdiaC03evbiRihPI
         7A3thSy3TkHsB2X87Eg+BH9U5ddM/4MGBWIshrq2ebufsvigRAl9X/FVaLvR5MMDLrTu
         1NwA==
X-Gm-Message-State: ABy/qLZp30+/j3Zp3ccJWyBP+A1cIrEkpP6NGmzBDQD++InPINQtApO7
        zT+IVJodvAO9LEhHTe4/JfKARrlB+rqdDw==
X-Google-Smtp-Source: APBJJlHFav2HOy8yjaRTEjXbSFfJfB9R1L/v4XNmRQpLXJlO1CBfmH3qkIvoVRo9thSlgIkXMaicIg==
X-Received: by 2002:a05:6a20:8406:b0:104:ad71:f080 with SMTP id c6-20020a056a20840600b00104ad71f080mr14161794pzd.34.1689631479922;
        Mon, 17 Jul 2023 15:04:39 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id z68-20020a633347000000b0054fe7736ac1sm251622pgz.76.2023.07.17.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:04:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] lib/bitmap: workaround const_eval test build failure
Date:   Mon, 17 Jul 2023 15:04:35 -0700
Message-Id: <20230717220435.57640-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang, and when KASAN and GCOV_PROFILE_ALL are both
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
issue is not related to bitmap code itself, but it breaks build for a given
configuration.

Disabling the const_eval test under that config may potentially hide other
bugs. Instead, workaround it by disabling GCOV for the test_bitmap unless
the compiler will get fixed.

[1] https://github.com/ClangBuiltLinux/linux/issues/1874

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307171254.yFcH97ej-lkp@intel.com/
Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/evaluations assertions")
Co-developed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/Makefile      | 6 ++++++
 lib/test_bitmap.c | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 42d307ade225..1ffae65bb7ee 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,7 +82,13 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
+
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
+# FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
+GCOV_PROFILE_test_bitmap.o := n
+endif
+
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_MAPLE_TREE) += test_maple_tree.o
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf..4a678de9c350 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1161,6 +1161,10 @@ static void __init test_bitmap_print_buf(void)
 	}
 }
 
+/*
+ * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
+ * To workaround it, GCOV is force-disabled in Makefile for this configuration.
+ */
 static void __init test_bitmap_const_eval(void)
 {
 	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
@@ -1186,11 +1190,7 @@ static void __init test_bitmap_const_eval(void)
 	 * the compiler is fixed.
 	 */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
-#if defined(__s390__) && defined(__clang__)
-	if (!const_test_bit(7, bitmap))
-#else
 	if (!test_bit(7, bitmap))
-#endif
 		bitmap_set(bitmap, 5, 2);
 
 	/* Equals to `unsigned long bitopvar = BIT(20)` */
-- 
2.39.2

