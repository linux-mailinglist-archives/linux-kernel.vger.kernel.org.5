Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448767EC9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjKORiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjKORiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:38:08 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F9F1724
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:43 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778ac9c898dso371860885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069861; x=1700674661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhFnq9Ngmt9wj9jeMbM3jBJDuaOt4o4B8wK/xZ02mGU=;
        b=T/cxrHaG0mZMvP2jpdukb0SLqXkvsj1XoaDnGyezN8MPu0+Ueb7/bfljOaEYwWQJXU
         CnRcWxJXiKltjAy/IrJk8Q30BF8PYKeDRiK+290y2N5yPXVgP3PC/W/jLVIam8Dm4nt3
         q2GSjnF13FeZ6N6IqxGuuF202G9vdMrvYbo184vgACYTVkjFrRuHjFwp5dghK1dg04Nh
         MQeiil0hyendsMIey1fgWr4RGqkRzugEKIcEmAfR0/45BRyMOny93O4gCiI5rzftXPbc
         uN4wsU9kXIsKPIJ7kKH1dLNIhPOLuwJStN51JnXKwOJuWufpbFD29susP+i1OSwDiF9v
         G5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069861; x=1700674661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhFnq9Ngmt9wj9jeMbM3jBJDuaOt4o4B8wK/xZ02mGU=;
        b=eTN8t330X5xyEv7Es8P2Q0iL4V+sWIUjQ4p6MaXeSeToDMIBOJvQ//l3JMwKRqK1+s
         0XMxaIEacIMDGlb8BStDBKEVVSpvhPmye8U6n2e/C8nn5LsPgmNjanSsQIrU1s+I3aR6
         2xhLjJaTGa9E/a5HHy90QvlWdBIBQdF9nSkrLj1axOW6O1SKeBuREn2Mfe9elvKhBdmG
         Z4iNQbJXRVljlLkNXwcFn9oq6wCiHkmkLktIVYIMEwh8NJXIwcWk/OfZ58YzVemnzNts
         RvNPhmZcdkczMw6ADtEvy/PB3w29K65st1NEfW2osjnTNuldATKjDYZp6cyEkbs1uYcG
         ymqg==
X-Gm-Message-State: AOJu0Yy3CR7x0UNVgy4IdhrK8bSuu92yto9mUpe3bimESA4AbWA7djsw
        UrdY4BEazZQJ2/F+CHiVYo5iK9Lf7g==
X-Google-Smtp-Source: AGHT+IEAC5Qw0c2DGcdRu+XAfLZHT0LeaPcaMiUc/D+j7PvvIhx0XA4IDNz5R3/au6vbzlcFh/dj9w==
X-Received: by 2002:a05:620a:f02:b0:778:91f0:e559 with SMTP id v2-20020a05620a0f0200b0077891f0e559mr6431724qkl.78.1700069861182;
        Wed, 15 Nov 2023 09:37:41 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:40 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 12/14] x86/percpu/64: Remove INIT_PER_CPU macros
Date:   Wed, 15 Nov 2023 12:37:06 -0500
Message-ID: <20231115173708.108316-13-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
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
index ae9bbf634826..70b7b0bf33d0 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -88,7 +88,6 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
 	"__vvar_page|"
-- 
2.41.0

