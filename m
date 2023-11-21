Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9087F349E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjKURNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjKURMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:54 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C9D7E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:46 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso8450211a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586765; x=1701191565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHltNgoy4OLUCP42HJewI+Ou2KeBs8Yuv+VLShM29rY=;
        b=ihwL3iMdYzCWNcMGb7PQjJNyDGQf4E/rq2kOSi3adiiRlnrP++FsQevbdeMqR8ClFk
         b5siliwZHNzJYDSZ2kKfLSyAlWhTL0ERJTWlzRWUN5uhUtEoUsFpqFpg9LUGytGTP+xT
         RUcdFsNgPLQOJbMwn1hMiRhSS3UCz2R/f5J9e2NwyZw0Kadq7yAiynYE6sTE2Jg5aVnR
         ZrMla5cQK/en6N0TLgnFxYL6L+bhSlFLK5Cn5XCJbgI8UE7YCWpoNUTNqebmya9oWCSs
         A4XOdRGWyMXmA5uZ2qlBe53Vh23WGc0Dhmf82ebHxXdtQ3JHHibfk3PYa31dq0umV5Ud
         T0VA==
X-Gm-Message-State: AOJu0YxKm2yQyyNbeWGJhxooTnVeJMQQxqvddqFG3A1Gq6clSb//DPAy
        qoI/dn6LUdnyO/aO+cjp8S0=
X-Google-Smtp-Source: AGHT+IG2qsjgdu89Gm+fblV1VUkFtRbHeCF4TtMDunzcVS02/PzFbDKzCM4OuqF1nZHnyPpS2NP0Jw==
X-Received: by 2002:a05:6402:124a:b0:544:fc51:cd9f with SMTP id l10-20020a056402124a00b00544fc51cd9fmr2033103edw.42.1700586765171;
        Tue, 21 Nov 2023 09:12:45 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7db4a000000b005489dbe8ed3sm3122834edt.4.2023.11.21.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:44 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sven Joachim <svenjoac@gmx.de>, Ian Kent <raven@themaw.net>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jinghao Jia <jinghao@linux.ibm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v6 10/13] x86/bugs: Rename RETHUNK to MITIGATION_RETHUNK
Date:   Tue, 21 Nov 2023 08:07:37 -0800
Message-Id: <20231121160740.1249350-11-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU mitigations config entries are inconsistent, and names are hard to
related. There are concrete benefits for both users and developers of
having all the mitigation config options living in the same config
namespace.

The mitigation options should have consistency and start with
MITIGATION.

Rename the Kconfig entry from RETHUNK to MITIGATION_RETHUNK.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig                               | 8 ++++----
 arch/x86/Makefile                              | 2 +-
 arch/x86/configs/i386_defconfig                | 2 +-
 arch/x86/include/asm/disabled-features.h       | 2 +-
 arch/x86/include/asm/linkage.h                 | 4 ++--
 arch/x86/include/asm/nospec-branch.h           | 4 ++--
 arch/x86/include/asm/static_call.h             | 2 +-
 arch/x86/kernel/alternative.c                  | 4 ++--
 arch/x86/kernel/static_call.c                  | 2 +-
 arch/x86/lib/retpoline.S                       | 4 ++--
 scripts/Makefile.lib                           | 2 +-
 tools/arch/x86/include/asm/disabled-features.h | 2 +-
 12 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 30c2f880caf9..ee939de1bb05 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2465,7 +2465,7 @@ config FINEIBT
 
 config HAVE_CALL_THUNKS
 	def_bool y
-	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
+	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
@@ -2508,7 +2508,7 @@ config MITIGATION_RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config RETHUNK
+config MITIGATION_RETHUNK
 	bool "Enable return-thunks"
 	depends on MITIGATION_RETPOLINE && CC_HAS_RETURN_THUNK
 	select OBJTOOL if HAVE_OBJTOOL
@@ -2521,7 +2521,7 @@ config RETHUNK
 
 config MITIGATION_UNRET_ENTRY
 	bool "Enable UNRET on kernel entry"
-	depends on CPU_SUP_AMD && RETHUNK && X86_64
+	depends on CPU_SUP_AMD && MITIGATION_RETHUNK && X86_64
 	default y
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
@@ -2575,7 +2575,7 @@ config MITIGATION_IBRS_ENTRY
 
 config MITIGATION_SRSO
 	bool "Mitigate speculative RAS overflow on AMD"
-	depends on CPU_SUP_AMD && X86_64 && RETHUNK
+	depends on CPU_SUP_AMD && X86_64 && MITIGATION_RETHUNK
 	default y
 	help
 	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5ce8c30e7701..ba046afb850e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -22,7 +22,7 @@ RETPOLINE_VDSO_CFLAGS	:= -mretpoline
 endif
 RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 
-ifdef CONFIG_RETHUNK
+ifdef CONFIG_MITIGATION_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 73abbbdd26f8..91801138b10b 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -42,7 +42,7 @@ CONFIG_EFI_STUB=y
 CONFIG_HZ_1000=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
-# CONFIG_RETHUNK is not set
+# CONFIG_MITIGATION_RETHUNK is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 151f0d50e7e0..36d0c1e05e60 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -57,7 +57,7 @@
 				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 # define DISABLE_RETHUNK	0
 #else
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 09e2d026df33..dc31b13b87a0 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -40,7 +40,7 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_MITIGATION_SLS
@@ -52,7 +52,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
 #else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_MITIGATION_SLS
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 9ea93a298a43..33f76848c838 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -289,7 +289,7 @@
  * where we have a stack but before any RET instruction.
  */
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
+#if defined(CONFIG_MITIGATION_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -328,7 +328,7 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 extern void __x86_return_thunk(void);
 #else
 static inline void __x86_return_thunk(void) {}
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 343b722ccaf2..125c407e2abe 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -46,7 +46,7 @@
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp __x86_return_thunk")
 #else
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b01d49862497..f7c11bef19bb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -698,7 +698,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 	}
 }
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 
 /*
  * Rewrite the compiler generated return thunk tail-calls.
@@ -771,7 +771,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 }
 #else
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
-#endif /* CONFIG_RETHUNK */
+#endif /* CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 77a9316da435..4eefaac64c6c 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -172,7 +172,7 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 /*
  * This is called by apply_returns() to fix up static call trampolines,
  * specifically ARCH_DEFINE_STATIC_CALL_NULL_TRAMP which is recorded as
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 67b52cbec648..0045153ba222 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -127,7 +127,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #undef GEN
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 
 /*
  * Be careful here: that label cannot really be removed because in
@@ -386,4 +386,4 @@ SYM_CODE_START(__x86_return_thunk)
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
-#endif /* CONFIG_RETHUNK */
+#endif /* CONFIG_MITIGATION_RETHUNK */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0d5461276179..48a4a81edac1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -263,7 +263,7 @@ objtool-args-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
 endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
-objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
+objtool-args-$(CONFIG_MITIGATION_RETHUNK)		+= --rethunk
 objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 4b816f55c634..bd7071f34f6b 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -57,7 +57,7 @@
 				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 # define DISABLE_RETHUNK	0
 #else
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
-- 
2.34.1

