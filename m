Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D57FECDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbjK3K1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjK3K13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:27:29 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F093
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:27:35 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so764305b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701340055; x=1701944855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5biSPjpUhFmS7S7cTsjVh9feb56GTutqbWDSkSEiUc=;
        b=fYgv3qVbFMyfaQ4OGZd3PacdUdOtlEdT4xl4JB7/LiO9QtKBU2kKOu0Pb5qOgM/cRr
         2LeR2bga9nk1SrDntZ5kOzPoTHS8LMA0FZZ/6r+WujTYEBleln191XIR5daS3SE7fNEt
         g72qEyrdvctd4GAlgX0XW17h5UgyKWK7c1+oRF9I00EJPCenUwrrHYyAPWA4SfvXAFxE
         sBuEHmPmnfOg/RUR6lntnqopCQNjaBv1DUVrdRdyrNX4Ayz3JX0yg4EBa7Jga8c96Yn5
         4+AQJsfxRVz0jPpED4psZjF1LDjkxUADTTzVK9Q87WdTiFN8kr01ut0KyECEgVs331oU
         8ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340055; x=1701944855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i5biSPjpUhFmS7S7cTsjVh9feb56GTutqbWDSkSEiUc=;
        b=dHHFstJdh3pK0tyseSBLcW9TwaVKPmuVSfypuEForEXXQ3AhPscNUXx7W2gIKRvfyi
         y3oc3TiXrxxodr/EyFOemZ2VI/B1HS6jiZ046KSE3YH7aRyUtvGBYoQrU3B1XD8pXgzi
         RNPcpHvEzrr/vxF39ufbvmREbZHpCn1uvunlMFgO5QUfeXN/56NglaviO0sxOlV4VgPE
         mFw2nB18H8vyr3DxQe5jPDJfpUOa0x0MiSmpGrzLH/cneXV99CEt+7YlEtM2auFaBtsG
         XH28q5GcaGLV/dQpamhjGVnRa5CGiQRnDjNCWDin0HNoEfVsTElkJ5R/+JbohWXw0gRq
         tB/w==
X-Gm-Message-State: AOJu0Yx+0leA55P2bA9OrTFu5HD64QjIzj29ejOuqCJ5PJDemI7gYfAW
        WwqsfMa5g3wbeae+dWTs/68=
X-Google-Smtp-Source: AGHT+IE4TW98BjKnZUeBoxsrdWrYpDL83KvEMg0aEsh1jLeOkdcayCQ4w4gIrgMFfBo+SIZ4bxH9UQ==
X-Received: by 2002:a05:6a00:2d06:b0:6cd:ec64:a886 with SMTP id fa6-20020a056a002d0600b006cdec64a886mr1017096pfb.2.1701340054813;
        Thu, 30 Nov 2023 02:27:34 -0800 (PST)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id p24-20020a62ab18000000b006cb574445efsm874243pff.88.2023.11.30.02.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 02:27:34 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marco Elver <elver@google.com>
Subject: [PATCH v2] lib: test_bitops: add compile-time optimization/evaluations assertions
Date:   Thu, 30 Nov 2023 19:27:17 +0900
Message-Id: <20231130102717.1297492-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function in the bitops test suite to assert that the bitops
helper correctly fold constant expressions (or trigger a build bug
otherwise). This should work on all the optimization levels supported
by Kbuild.

The function doesn't perform any runtime tests and gets optimized out to
nothing after passing the build assertions.

Architectures which fail that test should adjust their
arch/*/include/asm/bitops.h in order to use the compiler's generic
__builitn implementation if the argument is a constant expression
(similar to [1]).

[1] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate
    constant expressions")

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This is tested on x86, x86_64, arm and arm64.

Other architectures were not tested. My idea would be to add this
patch to any kind of CI which runs on all architecture (linux-next?)
and see if anything breaks.

Or maybe I should send a message to the maintainers of all of the
arch/*/include/asm/bitops.h files?

Tell me what you think.

** Changelog **

v1 -> v2:

  - Drop the RFC patch. v1 was not ready to be applied on x86 because
    of pending changes in arch/x86/include/asm/bitops.h. This was
    finally fixed by Nick in commit 3dae5c43badf ("x86/asm/bitops: Use
    __builtin_clz{l|ll} to evaluate constant expressions"). Thanks Nick!

  - Update the commit description.

  - Introduce the test_const_eval() macro to factorize code.

  - No functional changes.

  Link: https://lore.kernel.org/all/20221111081316.30373-1-mailhol.vincent@wanadoo.fr/
---
 lib/Kconfig.debug |  4 ++++
 lib/test_bitops.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..c97d818dbc30 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2454,6 +2454,10 @@ config TEST_BITOPS
 	  compilations. It has no dependencies and doesn't run or load unless
 	  explicitly requested by name.  for example: modprobe test_bitops.
 
+	  In addition, check that the compiler is able to fold the bitops
+	  function into a compile-time constant (given that the argument is also
+	  a compile-time constant) and trigger a build bug otherwise.
+
 	  If unsure, say N.
 
 config TEST_VMALLOC
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 3b7bcbee84db..49e2f76575e4 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,6 +50,35 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
+/* Assert that a boolean expression can be folded in a constant and is true. */
+#define test_const_eval(test_expr)				\
+({								\
+	/* Evaluate once so that compiler can fold it. */	\
+	bool __test_expr = test_expr;				\
+								\
+	BUILD_BUG_ON(!__builtin_constant_p(__test_expr));	\
+	BUILD_BUG_ON(!__test_expr);				\
+})
+
+static void test_bitops_const_eval(void)
+{
+	/*
+	 * On any supported optimization level (-O2, -Os) and if
+	 * invoked with a compile-time constant argument, the compiler
+	 * must be able to fold into a constant expression all the bit
+	 * find functions. Namely: __ffs(), ffs(), ffz(), __fls(),
+	 * fls() and fls64(). Otherwise, trigger a build bug.
+	 */
+	const int n = 10;
+
+	test_const_eval(__ffs(BIT(n)) == n);
+	test_const_eval(ffs(BIT(n)) == n + 1);
+	test_const_eval(ffz(~BIT(n)) == n);
+	test_const_eval(__fls(BIT(n)) == n);
+	test_const_eval(fls(BIT(n)) == n + 1);
+	test_const_eval(fls64(BIT_ULL(n)) == n + 1);
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -94,6 +123,8 @@ static int __init test_bitops_startup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
+	test_bitops_const_eval();
+
 	pr_info("Completed bitops test\n");
 
 	return 0;
-- 
2.25.1

