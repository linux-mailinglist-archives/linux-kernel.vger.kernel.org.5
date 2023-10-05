Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACEE7BA742
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJEREh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJERDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:03:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D22052
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:50:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so2138574a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696524630; x=1697129430; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVP62JidTEWtgdpmasWslCtMYx2nHdn78C2J70yw09Q=;
        b=bkTZB0yS7hobifDyhk3CxAgTg1hSRbMqdBqvkJB+wXVDQZM1MqwURrpQs8BJoGd+vb
         SNqr4F4YlrtR6vHRTOELO7wWGOZ36Ve5UIqEKRLEHTq/dmTmbLEQHL+t22In9nyvF3HA
         vVBTzUkGMMLbhBaqiiusaIQXOJWGwDgY5HAd5GPBJ2kBGTwvtdfPoUVMNq1zdl3jIBVy
         7f+8YSiuENUk8vIcFr9z68WF8+bdStQ3+vqumSHALuASomFI/pWs3H8U2a+rBfUYrzvF
         3jHMMU4UX6Mla5e/DEtNUhW+VpwPEE2oJHYZtIybfRrJ8EdWoMI54CFm39JSXRk7eK1W
         vbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696524630; x=1697129430;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVP62JidTEWtgdpmasWslCtMYx2nHdn78C2J70yw09Q=;
        b=I02TZ5CtD3NBxR/vTiZ+IJPH8trucIi0XLVvNdBKZl3h2RDqkUGucKK7V/3PVCmvkn
         Pwalx0S95PisoP0GcB5acwFDY/0fQ9blenaIp7GTW7DgyT2DKXHMmSm0F52daVH6S5m+
         1NHAS2GGS4lWse3S4GFS13cSI00Y93OHFQukMA3YBDgE4ixjDU/XsHiEIWc53/koEzjT
         XpMOFjVBFq/DTBerRXZcO0rkQut5j78RgSWI8xyRtTLB6at/XnjRStddsXBmKxKZaUTe
         GuA8YSAiFimnLsU/V65fp+TNkGd+n/B54m4XCYsPaUtWXotSq0ntvnjwpold74un+Ee/
         R58g==
X-Gm-Message-State: AOJu0YwmaXlgQ+ty21CWxB7X1TZBqMHH98ojlOppSw7EikzB622n6U6f
        VjOPF2zuxMP6Q7gIEdYA1dEo36WZVQ==
X-Google-Smtp-Source: AGHT+IEwq07zIWtyOfxelS1GZD8CWHbODSAxUc+2ZLBuheWhfxtqbvmpqX/KRl574o9V7D0WIjfd4g==
X-Received: by 2002:a17:906:1ba1:b0:9a2:1d09:4eee with SMTP id r1-20020a1709061ba100b009a21d094eeemr5741848ejg.49.1696524629414;
        Thu, 05 Oct 2023 09:50:29 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709064e9300b00988e953a586sm1454268eju.61.2023.10.05.09.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:50:29 -0700 (PDT)
Date:   Thu, 5 Oct 2023 19:50:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH v2] auto: add and use "auto" keyword (alias for __auto_type)
Message-ID: <d4f87590-6cbb-4ee9-bead-7d958fc1fa83@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has similar semantics to "auto" keyword from a language
which can not be named on this mailing list, in particular:

	{
		int a;
		const auto b = a; // const int b = a;
		b = 1;	// compile error
	}
	{
		char a;
		auto b = a; // char b = a;
		// no integer promotions
		static_assert(sizeof(b) == 1);
	}
	{
		int a;
		const auto p = &a; // int *const p = &a;
		*p = 1;	// OK, const is applied to top-level only
	}

It can be used to save on macroexpansion inside macro forests which
use typeof() somewhere deep enough. It is cool regardless.

gcc 5.1 supports __auto_type.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/process/coding-style.rst |   31 +++++++++++++++++++++++++------
 arch/nios2/include/asm/uaccess.h       |    4 ++--
 arch/x86/include/asm/bug.h             |    2 +-
 include/linux/cleanup.h                |    2 +-
 include/linux/compiler_types.h         |    2 ++
 5 files changed, 31 insertions(+), 10 deletions(-)

--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -1018,7 +1018,26 @@ result.  Typical examples would be functions that return pointers; they use
 NULL or the ERR_PTR mechanism to report failure.
 
 
-17) Using bool
+17) Using auto
+--------------
+
+Use ``auto`` macro-keyword (alias for ``__auto_type`` extension) in macros
+with "evaluate argument once" idiom:
+
+.. code-block:: c
+
+        #define min2(a, b)              \
+        ({                              \
+                auto a_ = (a);          \
+                auto b_ = (b);          \
+                a_ < b_ ? a_ : b_;      \
+        })
+
+Read https://gcc.gnu.org/onlinedocs/gcc/Typeof.html before using ``auto`` or
+changing anything with ``auto`` in it.
+
+
+18) Using bool
 --------------
 
 The Linux kernel bool type is an alias for the C99 _Bool type. bool values can
@@ -1048,7 +1067,7 @@ readable alternative if the call-sites have naked true/false constants.
 Otherwise limited use of bool in structures and arguments can improve
 readability.
 
-18) Don't re-invent the kernel macros
+19) Don't re-invent the kernel macros
 -------------------------------------
 
 The header file include/linux/kernel.h contains a number of macros that
@@ -1071,7 +1090,7 @@ need them.  Feel free to peruse that header file to see what else is already
 defined that you shouldn't reproduce in your code.
 
 
-19) Editor modelines and other cruft
+20) Editor modelines and other cruft
 ------------------------------------
 
 Some editors can interpret configuration information embedded in source files,
@@ -1105,7 +1124,7 @@ own custom mode, or may have some other magic method for making indentation
 work correctly.
 
 
-20) Inline assembly
+21) Inline assembly
 -------------------
 
 In architecture-specific code, you may need to use inline assembly to interface
@@ -1137,7 +1156,7 @@ the next instruction in the assembly output:
 	     : /* outputs */ : /* inputs */ : /* clobbers */);
 
 
-21) Conditional Compilation
+22) Conditional Compilation
 ---------------------------
 
 Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
@@ -1186,7 +1205,7 @@ expression used.  For instance:
 	#endif /* CONFIG_SOMETHING */
 
 
-22) Do not crash the kernel
+23) Do not crash the kernel
 ---------------------------
 
 In general, the decision to crash the kernel belongs to the user, rather
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -172,14 +172,14 @@ do {									\
 
 #define __put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
+	auto __pu_ptr = (ptr);						\
 	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
 	__put_user_common(__pu_val, __pu_ptr);				\
 })
 
 #define put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
+	auto __pu_ptr = (ptr);						\
 	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
 	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
 		__put_user_common(__pu_val, __pu_ptr) :			\
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -78,7 +78,7 @@ do {								\
  */
 #define __WARN_FLAGS(flags)					\
 do {								\
-	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
+	auto __flags = BUGFLAG_WARNING|(flags);			\
 	instrumentation_begin();				\
 	_BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);		\
 	instrumentation_end();					\
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -40,7 +40,7 @@
 #define __free(_name)	__cleanup(__free_##_name)
 
 #define no_free_ptr(p) \
-	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
+	({ auto __ptr = (p); (p) = NULL; __ptr; })
 
 #define return_ptr(p)	return no_free_ptr(p)
 
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -76,6 +76,8 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 #ifdef __KERNEL__
 
+#define auto __auto_type
+
 /* Attributes */
 #include <linux/compiler_attributes.h>
 
