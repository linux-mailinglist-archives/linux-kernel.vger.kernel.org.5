Return-Path: <linux-kernel+bounces-111822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F52887154
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8522882DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73BB60BA3;
	Fri, 22 Mar 2024 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcb9jEp5"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0A6086C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126384; cv=none; b=DDN+7fVETX4UFylMgOP+DltciwKhKcQhMGEqHrqie+lZo+lTumXRnB42hL4a387mqss87ISmt/H1kI+Tr+9nKwe6R8z7uRKfFZPsZjV/yoQHb4kFJ3O4y4T/l4z6OtjydeMv9T49VuavUk/w8k0Blhmq+REPXyMkypK9Euo0C3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126384; c=relaxed/simple;
	bh=8ZtYCXtgnnwm7AtoyNUej+XZO1HFRBmoCJyDMs9VzX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLSWaLHx5QndpepUjpbNuGl60vdMVfMSntRLRfyg7kEGtBLePAzoJAoMtR4D3aEW6vCDEx863fTQh/8qXmBTzOTnajm6JwGIQKM8ea8ENVlqQ4NjbMoHqaWonN0Id6WsalVMTl99fl2Gt9H3S2BMC5rHepiMVLfGgrnldNvlIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcb9jEp5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e674136ba4so1363484a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126381; x=1711731181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHxT6FSxev8VQpBaoe+RR19/PxZNROcYVuEUEA5+ZXs=;
        b=fcb9jEp5eoM1QtSz6uVxjy5n8nsfoZurQ1Pc70iuxX9xRD/dzbeDtQmuF1NLwH8Fja
         HuvYEypLL6ut5uo6RGhyvouz7VX6KWFtiyBVoDiHQj2jMsLrGhcLcM2loIBC3iAPQ1hq
         g7YOTZ+JxyRR/HSvNQVUIfZD43o6rO1wG3ReqmQ03Rue7fzTCAMZq09fV/BDlKzS8jaD
         FILvcZzj5badAva+C6qarsangeDf0KjOxkpqZh8CNvc6PLPhyu5jfriIFDlY/lb6dmeg
         tf5ulVuGdM/g96Zfd10Pc53/z7vZpApyklgaa9C7MbK0MWkuaXwBbMKFnvqrUS5Q9lmw
         fAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126381; x=1711731181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHxT6FSxev8VQpBaoe+RR19/PxZNROcYVuEUEA5+ZXs=;
        b=G2IZ1gT9z8bnxnlOZIbkj24xJz7W+//aU8C5jzWupnLY79O293PuEQRBEldTYnNTi2
         qEpUkcr2gAdaUlXv2o0+zEId4e3mIOUV+KlzBGG650GY12Wr0elgIsG0CeX4wJPfnq7x
         9eOYfoJWS3WR8GotmHjf0VX2aDEbhqvkZrvLDdJPmqOqdr41Wt2ktu2bjtGesohnQy3j
         68z6Gh/fDDNOmuWYKxkVRMsKhGFLszydwV9sT7ABVT3mr9cRcHlMckIhOLqCNEvu0jkB
         TYjBgASD6nDQ/iXsAEZTeFvD/4oPCUFSzSM4CESxvbxNvUplkZQWT8DsOwL3KppRim73
         QAmw==
X-Gm-Message-State: AOJu0Yz+Y+tcZKFQaEBQsP+yP3wujtTEjutQ7S1IyDLfrHFBnEfbNBli
	MUzLEmQzUJ7pnPSb+QNzz6PhyqQWZ0sw645vY7ABq++vIbyb9KLOvV9xT6s=
X-Google-Smtp-Source: AGHT+IFBIHRFPbnRJdlLPiZbQQMDkOQWh+QBM3w28nze8664BF4d6w4st8UmlHwoTeYt494QQGMHOQ==
X-Received: by 2002:a9d:7696:0:b0:6e6:80da:c34f with SMTP id j22-20020a9d7696000000b006e680dac34fmr199579otl.32.1711126381497;
        Fri, 22 Mar 2024 09:53:01 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:53:01 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 12/16] x86/percpu/64: Remove INIT_PER_CPU macros
Date: Fri, 22 Mar 2024 12:52:29 -0400
Message-ID: <20240322165233.71698-13-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the load and link addresses of percpu variables are the same,
these macros are no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/desc.h   |  1 -
 arch/x86/include/asm/percpu.h | 22 ----------------------
 arch/x86/kernel/head64.c      |  2 +-
 arch/x86/kernel/irq_64.c      |  1 -
 arch/x86/kernel/vmlinux.lds.S |  7 -------
 arch/x86/tools/relocs.c       |  1 -
 6 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 62dc9f59ea76..ec95fe44fa3a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,7 +46,6 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
-DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index f6ddbaaf80bc..59d91fdfe037 100644
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
 
 #include <linux/build_bug.h>
@@ -101,22 +95,6 @@
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
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e06aeba..5f0523610e92 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -564,7 +564,7 @@ void __head startup_64_setup_gdt_idt(void)
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.address = (unsigned long)&RIP_REL_REF(gdt_page.gdt),
 		.size    = GDT_SIZE - 1,
 	};
 
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
index 667202ebd37f..8d5bf4a71e39 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -467,13 +467,6 @@ SECTIONS
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
 #ifdef CONFIG_X86_64
-/*
- * Per-cpu symbols which need to be offset from __per_cpu_load
- * for the boot processor.
- */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
-INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e490297a486b..8db231affba2 100644
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
2.44.0


