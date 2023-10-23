Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D17D4195
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJWVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjJWVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C2110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7af20c488so38972517b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095864; x=1698700664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6iz2ek/tD2gffzEDkFQST98O3SckhijZstJ7BN63Is=;
        b=W6pthclQay7W24/niWlwnGJlaW+Ae2GitU6YPUonc9cqj+MqITGsluJp38wrKJwRD0
         Wxekt4eXiWKj+abcJCW8r99nrU0Eo88rhRnQcHL9HglmHuTjUvRcQ+RltKKVWVweCPPt
         LIDi8oe3MAb001blfaacovBfGrDNmVF0h4ztumZHHwoi5WG7umOzcbBXxWySPYDQPg54
         dA6ahS4IQUX8eo5wiYjKt9SXY0dNKImdfOGuDOPVhJZqOQAaqQOB1kFxV77Opr+PNtQ1
         PfKSgLoqzOLavyYCIEvZxgj/6d02RWnby1sf6Q+1jVxoJMbAvr8JPgEGmtgAkbWmClVA
         kw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095864; x=1698700664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6iz2ek/tD2gffzEDkFQST98O3SckhijZstJ7BN63Is=;
        b=MvkQINHzVXRzUtfDtZD/SuMZLrptkbB9+PGC6Pn7MdgVRh2R9N5bCW+ytu2FanzqOJ
         mVO1dp1rLDqPSkAKuNUvVrGYS4PXfs2j2Xy4+LUbg5Jq73Gt7rLcFsBhllK586wYzyqg
         Rgj2s5B8QMPHJBII64i8pF3dgWhcssPlW2NTYhKrU7JvHtVlW2uHNr2GAH8rBbizQII2
         yRevi89AemdMf0bLdVbVQJF/YWjePrW4eu+2TnHGPGKFCME9I+sKu/m5gayxOvyqrsBN
         CR1wk4+ETGPF49Vq/0XDYKQQV65WDYvmypliMPZmktT2nPLgeiYuz9aSQTpagbQHFRop
         L27Q==
X-Gm-Message-State: AOJu0Yz3gmKSNYWosHMe3Rrg27me79ywPAtFJW+yr54CDIkx7o5Icnz6
        AlppmKBJtq9GOBViy7Q9xlBHOcC5oA==
X-Google-Smtp-Source: AGHT+IF5HKtwMm1eK03XmvrPZeY/qkoyK3H/J0oEIxiOhKrrOvcFznXh3t3G10KbgyYWHMLwhjlijQ==
X-Received: by 2002:a0d:db45:0:b0:5a7:ba17:584b with SMTP id d66-20020a0ddb45000000b005a7ba17584bmr11342232ywe.1.1698095864474;
        Mon, 23 Oct 2023 14:17:44 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:44 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 7/9] x86/percpu/64: Remove INIT_PER_CPU macros
Date:   Mon, 23 Oct 2023 17:17:28 -0400
Message-ID: <20231023211730.40566-8-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
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
index bbcc1ca737f0..11f50ab32d0e 100644
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
index 8d8eb4d9ff9d..089d164164e8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -481,13 +481,6 @@ SECTIONS
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

