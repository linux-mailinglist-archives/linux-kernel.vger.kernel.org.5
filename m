Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9F7742F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjHHRxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHHRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:53:30 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AA2956F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:23:52 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-3fe210c47acso32080545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691511824; x=1692116624;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hmnOfvRNRbQKO2Fig5tO7oMJZvMK80sR98XXmZHYIOg=;
        b=RarQiWbSLFNVWbsaPmvVR8B9n/vSl/5FCPVCXAJmHHpiVCEBWBPvMcorW1/bzDGbBc
         mk7irX8Tiv3Vjb46PZiPJYYLalii7S0OdMY4H9i3dgdnnBNSJc1a8JAkpO6iWPpv+MlB
         Yq13DoM3m+RP0U3hnzWYUyz9/b6bMV8R+4gbE9OrTdxoaiHeNPX2OSqDXEqnyGM4q71C
         c8cyvA5W6ov5E2IiKg7MNsigjy7p4juvHZgUWz9uD8v8hcu6gsVvfaUxH1cTfSO5D09z
         fCgTrwMNN+dmyYQ/i1a5XGBy5EYOWjDULgq8CoRBdAA5W/h4YoQzjdGx+V1eLSzRbixH
         OLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511824; x=1692116624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmnOfvRNRbQKO2Fig5tO7oMJZvMK80sR98XXmZHYIOg=;
        b=Dt13J+pPDRxLU649SffG5JMLP39xMjjlpkX29e8XpXFEm6BX9/f47ppEPY1jmJl2PR
         9ddLPWVDbFX/Ezpc35oVSyBVjEATHVR0/4Q5IL7Dqw+uzSKWPNbWR61ffPseehvcZU5C
         Lzxv3aSyZVgRdCNKCnAsyjmrQQ02gt7rd5ak51JPV3f2se5acTi/mDd7BWhrcIjaj0i0
         ImKhIDpxef6vJuyTFjSrAh8OcIIN/77Tj6mx9t/2HLj6/LI8MnIEuIQ/J4p2up55IGwt
         CBBlvBd3kqu0um4vTcMYbUcEHJ368jgSLzVIDY9bHGnf+JL/nnwcYZpAH8ue6I+hIdYT
         taVQ==
X-Gm-Message-State: AOJu0YwQOaHzQc/o+2W5IRiKYKZ2WMf02HxDIcwjuRE/wG+e5RU/nC+1
        lFtrgP61DdTUcIBiNg/DHlEV6wjyBQ==
X-Google-Smtp-Source: AGHT+IFO91+Sq0a4bROaXXMkpleB+MNLqFDhhb5O1iR8Zhdu/8OTj2ivFrTXYjJox8ukr1691thj7vV+Eg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:39c0:833d:c267:7f64])
 (user=elver job=sendgmr) by 2002:adf:f0cb:0:b0:317:5e4f:9097 with SMTP id
 x11-20020adff0cb000000b003175e4f9097mr74564wro.7.1691490086705; Tue, 08 Aug
 2023 03:21:26 -0700 (PDT)
Date:   Tue,  8 Aug 2023 12:17:25 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230808102049.465864-1-elver@google.com>
Subject: [PATCH v3 1/3] compiler_types: Introduce the Clang __preserve_most
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
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
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
recovering a large register set before and after the call in the caller.
If the arguments are passed in callee-saved registers, then they will be
preserved by the callee across the call. This doesn't apply for values
returned in callee-saved registers.

 * On X86-64 the callee preserves all general purpose registers, except
   for R11. R11 can be used as a scratch register. Floating-point
   registers (XMMs/YMMs) are not preserved and need to be saved by the
   caller.

 * On AArch64 the callee preserve all general purpose registers, except
   x0-X8 and X16-X18."

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

The attribute may be supported by a future GCC version (see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899).

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
v3:
* Quote more from LLVM documentation about which registers are
  callee/caller with preserve_most.
* Code comment to restrict use where tracing is meant to be disabled.

v2:
* Imply notrace, to avoid any conflicts with tracing which is inserted
  on function entry. See added comments.
---
 include/linux/compiler_types.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 547ea1ff806e..c88488715a39 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -106,6 +106,34 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
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
+ * is supported, __preserve_most implies notrace.  It is recommended to restrict
+ * use of the attribute to functions that should or already disable tracing.
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

