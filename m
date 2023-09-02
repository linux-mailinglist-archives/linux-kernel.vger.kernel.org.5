Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5D7905D8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351764AbjIBHmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351762AbjIBHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:42:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C2BB4;
        Sat,  2 Sep 2023 00:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 362F1602E8;
        Sat,  2 Sep 2023 07:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448DFC433C7;
        Sat,  2 Sep 2023 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640556;
        bh=nr/LiziU0IRvRMml0QHsiD6WcZQCmPyO2Vb3XV3Yx1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PK1My+VeS/nBOvyBwSsX9SJWptxi6XSU4EoDBn72eRPoPCpnlYs+LCfeGq25Tq798
         uSe7moRDVjxzK8XX4Bk0PHR7JBbB2AgFvz5nSm2kPoYhUBxgInkkbKzq/BrG2Ag29Q
         cT/FFT7rkyt3DkrdrY/WCgnauUkNMC87DbrPbq7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.4.14
Date:   Sat,  2 Sep 2023 09:42:26 +0200
Message-ID: <2023090226-emu-cling-e968@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090225-upturned-taking-2bc4@gregkh>
References: <2023090225-upturned-taking-2bc4@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 732391193182..2b0cea8be740 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6240,10 +6240,6 @@
 			-1: disable all critical trip points in all thermal zones
 			<degrees C>: override all critical trip points
 
-	thermal.nocrt=	[HW,ACPI]
-			Set to disable actions on ACPI thermal zone
-			critical and hot trip points.
-
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
diff --git a/Makefile b/Makefile
index 900e515b87cf..97611fe99c8f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 4
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index f5a43fd8c163..da2ee8d6ef1a 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -251,7 +251,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type and symbol index */
 		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
 
-		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, dstsec->sh_addr, rels,
 						numrels, s->sh_info);
 		else
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 543493bf924d..bd69a4e7cd60 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/sort.h>
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
@@ -338,7 +339,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (nents)
 			sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, rels, numrels,
 						sechdrs[i].sh_info, dstsec);
 		else
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 39acccabf2ed..9915062d5243 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -24,6 +24,7 @@
 #include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/compat.h>
+#include <linux/elf-randomize.h>
 
 /*
  * Construct an artificial page offset for the mapping based on the physical
@@ -339,7 +340,7 @@ asmlinkage long parisc_fallocate(int fd, int mode, u32 offhi, u32 offlo,
 			      ((u64)lenhi << 32) | lenlo);
 }
 
-long parisc_personality(unsigned long personality)
+asmlinkage long parisc_personality(unsigned long personality)
 {
 	long err;
 
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index a6e8373a5170..3fa87e5e11ab 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H
 
-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
@@ -18,20 +16,4 @@ extern char __end_of_kernel_reserve[];
 
 extern unsigned long _brk_start, _brk_end;
 
-static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	/*
-	 * If _brk_start has not been cleared, brk allocation is incomplete,
-	 * and we can not make assumptions about its use.
-	 */
-	if (_brk_start)
-		return 0;
-
-	/*
-	 * After brk allocation is complete, space between _brk_end and _end
-	 * is available for allocation.
-	 */
-	return addr >= _brk_end && addr < (unsigned long)&_end;
-}
-
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 4720a3649a61..dd89c28fa736 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -59,10 +59,6 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
-static int nocrt;
-module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
-
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
@@ -1143,7 +1139,7 @@ static int thermal_act(const struct dmi_system_id *d) {
 static int thermal_nocrt(const struct dmi_system_id *d) {
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
-	nocrt = 1;
+	crt = -1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
diff --git a/drivers/thunderbolt/tmu.c b/drivers/thunderbolt/tmu.c
index d9544600b386..49146f97bb16 100644
--- a/drivers/thunderbolt/tmu.c
+++ b/drivers/thunderbolt/tmu.c
@@ -416,6 +416,7 @@ int tb_switch_tmu_disable(struct tb_switch *sw)
 		 * mode.
 		 */
 		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
+		if (ret)
 			return ret;
 
 		tb_port_tmu_time_sync_disable(up);
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 03be088fb439..001b2ce83832 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -42,6 +42,11 @@ bool module_init_section(const char *name);
  */
 bool module_exit_section(const char *name);
 
+/* Describes whether within_module_init() will consider this an init section
+ * or not. This behaviour changes with CONFIG_MODULE_UNLOAD.
+ */
+bool module_init_layout_section(const char *sname);
+
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
  * or 0.
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4874508bb950..7c3882b9133c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -188,16 +188,13 @@ static bool cleanup_symbol_name(char *s)
 
 static int compare_symbol_name(const char *name, char *namebuf)
 {
-	int ret;
-
-	ret = strcmp(name, namebuf);
-	if (!ret)
-		return ret;
-
-	if (cleanup_symbol_name(namebuf) && !strcmp(name, namebuf))
-		return 0;
-
-	return ret;
+	/* The kallsyms_seqs_of_names is sorted based on names after
+	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
+	 * To ensure correct bisection in kallsyms_lookup_names(), do
+	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
+	 */
+	cleanup_symbol_name(namebuf);
+	return strcmp(name, namebuf);
 }
 
 static unsigned int get_symbol_seq(int index)
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index a2e3745d15c4..e05ddc33a752 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -196,7 +196,7 @@ static bool match_cleanup_name(const char *s, const char *name)
 	if (!IS_ENABLED(CONFIG_LTO_CLANG))
 		return false;
 
-	p = strchr(s, '.');
+	p = strstr(s, ".llvm.");
 	if (!p)
 		return false;
 
@@ -344,27 +344,6 @@ static int test_kallsyms_basic_function(void)
 			goto failed;
 		}
 
-		/*
-		 * The first '.' may be the initial letter, in which case the
-		 * entire symbol name will be truncated to an empty string in
-		 * cleanup_symbol_name(). Do not test these symbols.
-		 *
-		 * For example:
-		 * cat /proc/kallsyms | awk '{print $3}' | grep -E "^\." | head
-		 * .E_read_words
-		 * .E_leading_bytes
-		 * .E_trailing_bytes
-		 * .E_write_words
-		 * .E_copy
-		 * .str.292.llvm.12122243386960820698
-		 * .str.24.llvm.12122243386960820698
-		 * .str.29.llvm.12122243386960820698
-		 * .str.75.llvm.12122243386960820698
-		 * .str.99.llvm.12122243386960820698
-		 */
-		if (IS_ENABLED(CONFIG_LTO_CLANG) && !namebuf[0])
-			continue;
-
 		lookup_addr = kallsyms_lookup_name(namebuf);
 
 		memset(stat, 0, sizeof(*stat));
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4dfd2f3e09b2..c6fd60ceb04a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -817,34 +817,26 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-/*
- * Check if an address is part of freed initmem. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (system_state < SYSTEM_FREEING_INITMEM)
-		return 0;
-
-	return init_section_contains((void *)addr, 1);
-}
-#endif
-
 static int static_obj(const void *obj)
 {
-	unsigned long start = (unsigned long) &_stext,
-		      end   = (unsigned long) &_end,
-		      addr  = (unsigned long) obj;
+	unsigned long addr = (unsigned long) obj;
 
-	if (arch_is_kernel_initmem_freed(addr))
-		return 0;
+	if (is_kernel_core_data(addr))
+		return 1;
+
+	/*
+	 * keys are allowed in the __ro_after_init section.
+	 */
+	if (is_kernel_rodata(addr))
+		return 1;
 
 	/*
-	 * static variable?
+	 * in initdata section and used during bootup only?
+	 * NOTE: On some platforms the initdata section is
+	 * outside of the _stext ... _end range.
 	 */
-	if ((addr >= start) && (addr < end))
+	if (system_state < SYSTEM_FREEING_INITMEM &&
+		init_section_contains((void *)addr, 1))
 		return 1;
 
 	/*
diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 8a5d6d63b06c..87440f714c0c 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	}
 
 	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
-	wksp = kmalloc(wksp_size, GFP_KERNEL);
+	wksp = vmalloc(wksp_size);
 	if (!wksp) {
 		retval = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	retval = new_size;
 
  out:
-	kfree(wksp);
+	vfree(wksp);
 	return retval;
 }
 #else
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4e2cf784cf8c..f1facc898a64 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1491,7 +1491,7 @@ long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
 	return offset | mask;
 }
 
-static bool module_init_layout_section(const char *sname)
+bool module_init_layout_section(const char *sname)
 {
 #ifndef CONFIG_MODULE_UNLOAD
 	if (module_exit_section(sname))
