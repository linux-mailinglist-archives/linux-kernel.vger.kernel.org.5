Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1174D7D8666
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjJZQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345554AbjJZQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A8A1A2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a7dd65052aso8950407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336094; x=1698940894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WeYX5TweL3gBg8KtkuF5OPQydAmV7WW1ssTZwTj5jM=;
        b=i/h2yucjQZWyknL8+mXny1nbXvEWlyBmzdhK19SRcrZ+JQwRulUS6Si7xmKTPO5SGH
         BWD9OyinFMiQ6MNzz+pii1BY0bj/mnSAv5j+zPgjHoaYnUtbc0XNKocCVAl2G1mM/7Ke
         zlG4LmQ7AQyNTxqv5PVeeGWsn9oHIeXhQSsidPRZO6C+yjmWQnJ5yk84LlueujOtvFdc
         lCv5oqejDni3Al554GqEDVmUuN5pwdgilgWCkC4uagKvk449Lx1D5LRhWOhXUzzeUWC+
         oXlncicyLUi2aF0pcV9qJtOm2k97onEYhctYSD7OCnCxwv4c0QtiB6U4hjkkVllJPRuL
         IOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336094; x=1698940894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WeYX5TweL3gBg8KtkuF5OPQydAmV7WW1ssTZwTj5jM=;
        b=BilAp+OSd7RXbCdBbxWI3njJasoq8xYEkdzKhp27gIpzVxO+1coG/igxARgMwmdGAl
         irHfwl+kwLkudQ61UqmYqzgfYKhraPzx8IvWRJM/3rTLsevezCwdaL1ghmaL5avpi9dD
         cwCmvxgSuyrn0TnWeR/5JUTIg9C/OYMRwih//xrMpewrGJHiCoLlq1N7TIOGm60ylZk1
         g2MpTZkOMu78x6qb6ENVywirXpNV0h+4TLaMEnEYSY53oaHielFCbOQAHqdXywH31jPJ
         98RHMDJ5z21w04uOgCejaeT3dnR4XzlQ/FcWb8D1gCw8WkEFEuUKP1YYEl6pOn+/Cw2Z
         0h9A==
X-Gm-Message-State: AOJu0YxJcG0F2FxhEiY4wmGQps/BU8QCjraog8xdcodpoXRIucnNoMTB
        CIn47cg1QOkop7M21XodzFQZL32jPw==
X-Google-Smtp-Source: AGHT+IEF1A0y9hDwIX8Z4cR6MbUT1ctDytfAFH9w70a6RMyh3wavgEClRciDkjCWZ3bUGz1Ibr9urw==
X-Received: by 2002:a0d:f646:0:b0:5a4:3e67:35a3 with SMTP id g67-20020a0df646000000b005a43e6735a3mr17953461ywf.49.1698336094606;
        Thu, 26 Oct 2023 09:01:34 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:34 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 09/11] x86/percpu/64: Remove INIT_PER_CPU macros
Date:   Thu, 26 Oct 2023 12:00:58 -0400
Message-ID: <20231026160100.195099-10-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The load and link addresses of percpu variables are now the same, so
these macros are no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 22 ----------------------
 arch/x86/kernel/irq_64.c      |  1 -
 arch/x86/kernel/vmlinux.lds.S |  7 -------
 arch/x86/tools/relocs.c       |  1 -
 4 files changed, 31 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b86b27d15e52..7a176381ee01 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -20,12 +20,6 @@
 
 #define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
-#ifdef CONFIG_X86_64_SMP
-#define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-#else
-#define INIT_PER_CPU_VAR(var)  var
-#endif
-
 #else /* ...!ASSEMBLY */
 
 #include <linux/kernel.h>
@@ -96,22 +90,6 @@
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-/*
- * Initialized pointers to per-cpu variables needed for the boot
- * processor need to use these macros to get the proper address
- * offset from __per_cpu_load on SMP.
- *
- * There also must be an entry in vmlinux_64.lds.S
- */
-#define DECLARE_INIT_PER_CPU(var) \
-       extern typeof(var) init_per_cpu_var(var)
-
-#ifdef CONFIG_X86_64_SMP
-#define init_per_cpu_var(var)  init_per_cpu__##var
-#else
-#define init_per_cpu_var(var)  var
-#endif
-
 /* For arch-specific code, we can use direct single-insn ops (they
  * don't give an lvalue though). */
 
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index fe0c859873d1..30424f9876bc 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -26,7 +26,6 @@
 #include <asm/apic.h>
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct irq_stack, irq_stack_backing_store) __visible;
-DECLARE_INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_VMAP_STACK
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index efa4885060b5..9aea7b6b02c7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -482,13 +482,6 @@ SECTIONS
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
 #ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 7feb63179b62..931d90aa814c 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -83,7 +83,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"__vvar_page|"
-- 
2.41.0

