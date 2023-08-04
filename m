Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAD76FCEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjHDJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjHDJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:09:37 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4746587
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:06:51 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31797adfe97so1022703f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691140010; x=1691744810;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbDuRBO1V21kY8Ln+XMGj8tah/dM0ZngOK9DCSez6Ds=;
        b=5+NdHYLigl8F6LR7td6fJwq4mY9o+g31biS6M/x67uOl9aEZNMw4T8nENGruiRPiRB
         +Gw5NEcsPnW4zysL4GKnQBPK9MO8u0Fsh1G5fWlgkmiENC1pguO3W0zZ0X/9KVUs9XYc
         Tobr1N4uOqLruYOpHjKAtJJ2mDS90eZzDY6tlw9DthEFZ7ugqCsD5LBgD4MRn1hh6V3W
         c6lem7rrbgF4amzGiob51SzurdoFT2U3i2F0AvVFAwCHWg57HOfRNXyQL4/kaXiOsTGY
         Q4BSyO6jSC8eDLVGZOooU1CA1YZfiIB3t/WuaZY5AlYApLPEZnbtXoouz1qw8nB4BnEV
         78og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140010; x=1691744810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbDuRBO1V21kY8Ln+XMGj8tah/dM0ZngOK9DCSez6Ds=;
        b=WHFc5rwDiGqUO04zOvfdqfhSPUDeKbIoVEyu9gP8p3Yfw8EOjXW8Bj8LTnFL3gmTEX
         KmJmyYn0GsGb5TrkXPCDB69fCOf899LwjjxkvjY5wTlkgSVLieFLfA+ENO2wfha+v7Se
         tBLYZQ32D4r8BfqsfV9VlXxPUCa3mYN6HfBJ3bRAzV0HAusKXEty66XooMGVjfQgXnR5
         /CMoaKoY3yJDS/vqUZPIqW9nk7kqEcNO4/EenEB+nsj9k06l7HyW/+3Hz5iCnKnDwkC/
         EQxrnQAKw8ZPjyrosdRH7r/4b0uNXnGHeQh4a2JtgXNBJa8h6+bmw1CzuJ+2juiZ6+7K
         L4Xw==
X-Gm-Message-State: AOJu0Yy4HAHGRuYHIeLDftN+CfhZ/RGr4Zz4S6W5rjG1ffyv0q3SLWo8
        SRE05Ag2oW7x2pxI6e0zXA+qMLnRZA==
X-Google-Smtp-Source: AGHT+IEPvozwf23yi22U6OKa9kIgIghSUiAWRzblYbPC2JjxGfCAqNsiEHfVbqNraFFYkBMktGuoEKz+Fw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:2ebf:f3ea:4841:53b6])
 (user=elver job=sendgmr) by 2002:adf:f587:0:b0:313:e68e:885d with SMTP id
 f7-20020adff587000000b00313e68e885dmr6006wro.13.1691140009920; Fri, 04 Aug
 2023 02:06:49 -0700 (PDT)
Date:   Fri,  4 Aug 2023 11:02:56 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804090621.400-1-elver@google.com>
Subject: [PATCH v2 1/3] compiler_types: Introduce the Clang __preserve_most
 function attribute
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1]: "On X86-64 and AArch64 targets, this attribute changes the calling
convention of a function. The preserve_most calling convention attempts
to make the code in the caller as unintrusive as possible. This
convention behaves identically to the C calling convention on how
arguments and return values are passed, but it uses a different set of
caller/callee-saved registers. This alleviates the burden of saving and
recovering a large register set before and after the call in the
caller."

[1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most

Introduce the attribute to compiler_types.h as __preserve_most.

Use of this attribute results in better code generation for calls to
very rarely called functions, such as error-reporting functions, or
rarely executed slow paths.

Beware that the attribute conflicts with instrumentation calls inserted
on function entry which do not use __preserve_most themselves. Notably,
function tracing which assumes the normal C calling convention for the
given architecture.  Where the attribute is supported, __preserve_most
will imply notrace. It is recommended to restrict use of the attribute
to functions that should or already disable tracing.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Imply notrace, to avoid any conflicts with tracing which is inserted
  on function entry. See added comments.
---
 include/linux/compiler_types.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 547ea1ff806e..12c4540335b7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -106,6 +106,33 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 #define __cold
 #endif
 
+/*
+ * On x86-64 and arm64 targets, __preserve_most changes the calling convention
+ * of a function to make the code in the caller as unintrusive as possible. This
+ * convention behaves identically to the C calling convention on how arguments
+ * and return values are passed, but uses a different set of caller- and callee-
+ * saved registers.
+ *
+ * The purpose is to alleviates the burden of saving and recovering a large
+ * register set before and after the call in the caller.  This is beneficial for
+ * rarely taken slow paths, such as error-reporting functions that may be called
+ * from hot paths.
+ *
+ * Note: This may conflict with instrumentation inserted on function entry which
+ * does not use __preserve_most or equivalent convention (if in assembly). Since
+ * function tracing assumes the normal C calling convention, where the attribute
+ * is supported, __preserve_most implies notrace.
+ *
+ * Optional: not supported by gcc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#preserve-most
+ */
+#if __has_attribute(__preserve_most__)
+# define __preserve_most notrace __attribute__((__preserve_most__))
+#else
+# define __preserve_most
+#endif
+
 /* Builtins */
 
 /*
-- 
2.41.0.640.ga95def55d0-goog

