Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE177A220
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjHLUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjHLUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A501998
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:59:47 -0700 (PDT)
Message-ID: <20230812195727.660453052@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Om38mOGR5rsJ+3kNGer82JR+w3FtSUZk8MQVXgwmwBw=;
        b=HWheSECgs8fHA0pwSALBVWIHDDQWpxZArpuN8fup5l5Qc2d493d7zgXyDpd+pwVJhAtwpR
        ZOwSCdWdYoOY3uG7mg+FnwFl/bDDO9gu666ujoKGdzlm1aTB20X2ntzZ82YN+0rDOG2hn0
        cXFQh9hXAUEz5DJaD0HRzWRhyyiBANA5zW01GzyE2ltpGB5Cn8G9Ay6flDkW9wgsx1F/IZ
        2lUe33U6YWPmDLw9Ng97BAtqYpLmnuprwBwwQBCil7tkXpgMipw04RnySDb2Uk6lS9+IMX
        etqisTUYbGge31Ilnqcek/ry+RH2Jl7ysnSDqaUsTzdudIduG8pt8BegYvT76Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Om38mOGR5rsJ+3kNGer82JR+w3FtSUZk8MQVXgwmwBw=;
        b=D9YFE1jmwB2zsJ9vCq140UTrDSkeNM1bvbcX0su+/Alb1gBbXolfDE/+Lg0404YH2qVqgL
        J34xbMVZuoaSEUBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 02/37] x86/microcode: Hide the config knob
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:39 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
Intel or AMD support is enabled. Accomodate to reality.

Requested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig                       |   38 ---------------------------------
 arch/x86/include/asm/microcode.h       |    6 ++---
 arch/x86/include/asm/microcode_amd.h   |    2 -
 arch/x86/include/asm/microcode_intel.h |    2 -
 arch/x86/kernel/cpu/microcode/Makefile |    4 +--
 5 files changed, 8 insertions(+), 44 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
 	  Say N otherwise.
 
 config MICROCODE
-	bool "CPU microcode loading support"
-	default y
+	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
-	help
-	  If you say Y here, you will be able to update the microcode on
-	  Intel and AMD processors. The Intel support is for the IA32 family,
-	  e.g. Pentium Pro, Pentium II, Pentium III, Pentium 4, Xeon etc. The
-	  AMD support is for families 0x10 and later. You will obviously need
-	  the actual microcode binary data itself which is not shipped with
-	  the Linux kernel.
-
-	  The preferred method to load microcode from a detached initrd is described
-	  in Documentation/arch/x86/microcode.rst. For that you need to enable
-	  CONFIG_BLK_DEV_INITRD in order for the loader to be able to scan the
-	  initrd for microcode blobs.
-
-	  In addition, you can build the microcode into the kernel. For that you
-	  need to add the vendor-supplied microcode to the CONFIG_EXTRA_FIRMWARE
-	  config option.
-
-config MICROCODE_INTEL
-	bool "Intel microcode loading support"
-	depends on CPU_SUP_INTEL && MICROCODE
-	default MICROCODE
-	help
-	  This options enables microcode patch loading support for Intel
-	  processors.
-
-	  For the current Intel microcode data package go to
-	  <https://downloadcenter.intel.com> and search for
-	  'Linux Processor Microcode Data File'.
-
-config MICROCODE_AMD
-	bool "AMD microcode loading support"
-	depends on CPU_SUP_AMD && MICROCODE
-	help
-	  If you select this option, microcode patch loading support for AMD
-	  processors will be enabled.
 
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -54,16 +54,16 @@ struct ucode_cpu_info {
 extern struct ucode_cpu_info ucode_cpu_info[];
 struct cpio_data find_microcode_in_initrd(const char *path, bool use_pa);
 
-#ifdef CONFIG_MICROCODE_INTEL
+#ifdef CONFIG_CPU_SUP_INTEL
 extern struct microcode_ops * __init init_intel_microcode(void);
 #else
 static inline struct microcode_ops * __init init_intel_microcode(void)
 {
 	return NULL;
 }
-#endif /* CONFIG_MICROCODE_INTEL */
+#endif /* CONFIG_CPU_SUP_INTEL */
 
-#ifdef CONFIG_MICROCODE_AMD
+#ifdef CONFIG_CPU_SUP_AMD
 extern struct microcode_ops * __init init_amd_microcode(void);
 extern void __exit exit_amd_microcode(void);
 #else
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -43,7 +43,7 @@ struct microcode_amd {
 
 #define PATCH_MAX_SIZE (3 * PAGE_SIZE)
 
-#ifdef CONFIG_MICROCODE_AMD
+#ifdef CONFIG_CPU_SUP_AMD
 extern void load_ucode_amd_early(unsigned int cpuid_1_eax);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -71,7 +71,7 @@ static inline u32 intel_get_microcode_re
 	return rev;
 }
 
-#ifdef CONFIG_MICROCODE_INTEL
+#ifdef CONFIG_CPU_SUP_INTEL
 extern void __init load_ucode_intel_bsp(void);
 extern void load_ucode_intel_ap(void);
 extern void show_ucode_info_early(void);
--- a/arch/x86/kernel/cpu/microcode/Makefile
+++ b/arch/x86/kernel/cpu/microcode/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 microcode-y				:= core.o
 obj-$(CONFIG_MICROCODE)			+= microcode.o
-microcode-$(CONFIG_MICROCODE_INTEL)	+= intel.o
-microcode-$(CONFIG_MICROCODE_AMD)	+= amd.o
+microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o
+microcode-$(CONFIG_CPU_SUP_AMD)		+= amd.o

