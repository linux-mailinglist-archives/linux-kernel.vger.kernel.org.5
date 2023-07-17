Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924BE756E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjGQUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQUbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF9188
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FF346124A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B5C433C8;
        Mon, 17 Jul 2023 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689625867;
        bh=speJUgxSauJb1B97mFzBthgQeNkIXMJQ46d1kG1IBpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5yuNuQ1k00JkD9oSP99xNX3im7OVU9ke1O/ZJxzB5liJ3nS6KJ2q72BNShSb8I7N
         xppmSyS3mUTrvFrkFzJ6J5Yw3LZXsB9RD6iUirXgxE3ablVVioaCTngcISqjmlozVU
         gM5C0SHbQBOzZ3Ij/zMvrL9c8QRxdOFSMi+Qp5Zckvnne5ZjBFWrgeyni0U8xyxxok
         fU7tH/sJXbgeCL7j5rOm0FP8u9kTsuCKd92YiIpBjzWUk2xb01vmp7Ypw8dMNf1LN0
         dNIGJJxYGwf1mnzOR0t44YMDNIxi2jaFUurlzb8nT6xsXEEMOkm/MQ+LdvDLIWoA+L
         X4btRRdqJSTvQ==
Date:   Mon, 17 Jul 2023 13:31:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tom Rix <trix@redhat.com>, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] lib/bitmap: waive const_eval test as it breaks the build
Message-ID: <20230717203105.GA2212488@dev-arch.thelio-3990X>
References: <20230717195813.29059-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717195813.29059-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On Mon, Jul 17, 2023 at 12:58:13PM -0700, Yury Norov wrote:
> When building with clang, and when KASAN and GCOV_PROFILE_ALL are both
> enabled, the test fails to build [1]:
> 
> >> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
>            BUILD_BUG_ON(!__builtin_constant_p(res));
>            ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>            BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>            ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^
>    include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
>            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>            ^
>    include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
>            __compiletime_assert(condition, msg, prefix, suffix)
>            ^
>    include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
>                            prefix ## suffix();                             \
>                            ^
>    <scratch space>:185:1: note: expanded from here
>    __compiletime_assert_239
> 
> Originally it was attributed to s390, which now looks seemingly wrong. The
> issue is also not related to bitmap code itself, but it breaks build for
> a given configuration. So, disabling the test unless the compiler will
> get fixed.
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/1874
> 
> Fixes: dc34d5036692 ("lib: test_bitmap: add compile-time optimization/evaluations assertions")
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/test_bitmap.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 187f5b2db4cf..a791fdb7a8c9 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -1163,6 +1163,9 @@ static void __init test_bitmap_print_buf(void)
>  
>  static void __init test_bitmap_const_eval(void)
>  {
> +#if defined(CONFIG_CC_IS_CLANG) && defined(CONFIG_KASAN) && defined(CONFIG_GCOV_PROFILE_ALL)
> +#warning "FIXME: Clang breaks compile time evaluations when KASAN and GCOV are enabled"

Making this a '#warning' will basically just replace the current error
with a different one in the face of CONFIG_WERROR, which seems pointless
to me:

  lib/test_bitmap.c:1167:2: error: "FIXME: Clang breaks compile time evaluations when KASAN and GCOV are enabled" [-Werror,-W#warnings]
   1167 | #warning "FIXME: Clang breaks compile time evaluations when KASAN and GCOV are enabled"
        |  ^
  1 error generated.

Could we just opt out of GCOV for test_bitmap.c if KASAN is enabled with
clang? That does not seem too bad of a workaround. I highly doubt there
are many people who are interested in debugging test_bitmap.c with KASAN
while profiling it with GCOV when building with clang, since they would
have hit this already and reported it already; as far as I can tell,
only the Intel robot has reported this with a randconfig.

diff --git a/lib/Makefile b/lib/Makefile
index 42d307ade225..c6f60ae42769 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -83,6 +83,10 @@ obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
+# https://github.com/ClangBuiltLinux/linux/issues/1874
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
+GCOV_PROFILE_test_bitmap.o := n
+endif
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_MAPLE_TREE) += test_maple_tree.o

Cheers,
Nathan

> +#else
>  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
>  	unsigned long initvar = BIT(2);
>  	unsigned long bitopvar = 0;
> @@ -1177,20 +1180,9 @@ static void __init test_bitmap_const_eval(void)
>  	 * in runtime.
>  	 */
>  
> -	/*
> -	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
> -	 * Clang on s390 optimizes bitops at compile-time as intended, but at
> -	 * the same time stops treating @bitmap and @bitopvar as compile-time
> -	 * constants after regular test_bit() is executed, thus triggering the
> -	 * build bugs below. So, call const_test_bit() there directly until
> -	 * the compiler is fixed.
> -	 */
> +	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
>  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> -#if defined(__s390__) && defined(__clang__)
> -	if (!const_test_bit(7, bitmap))
> -#else
>  	if (!test_bit(7, bitmap))
> -#endif
>  		bitmap_set(bitmap, 5, 2);
>  
>  	/* Equals to `unsigned long bitopvar = BIT(20)` */
> @@ -1220,6 +1212,7 @@ static void __init test_bitmap_const_eval(void)
>  	/* ~BIT(25) */
>  	BUILD_BUG_ON(!__builtin_constant_p(~var));
>  	BUILD_BUG_ON(~var != ~BIT(25));
> +#endif
>  }
>  
>  static void __init selftest(void)
> -- 
> 2.39.2
> 
