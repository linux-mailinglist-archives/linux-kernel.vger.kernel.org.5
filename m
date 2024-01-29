Return-Path: <linux-kernel+bounces-42833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253DC84076B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01BE28C688
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDF657BA;
	Mon, 29 Jan 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1mSpROY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4E65BA6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536257; cv=none; b=G2lGGGnQhEmQMjvMLFgYL/zJX80cwB9p6tqweQEtXgkUeoCp31Wi7Gpabh/CqBUOXtG9y/sgIqtEFHBgX9Q/GI+L0ryK2PXBWFw3lIAu8ILbrOwn/FEpol3HTUUT19tPtLihrQuheaCQBcIIxoaesM33S3emiQf8UfFpbdIUAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536257; c=relaxed/simple;
	bh=tQTvvRl9OvzN6zpSdpQcBzQhreh8MyO/2Wtk4J7nQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=sTcFDhPUBu1cBRjTwG4W/qOhkUfJnVtck6utI4h82MTeTl/JVurAMilHkyxmsrMcqljuMSkXZZOrvMyl9Buxf8s4B/lKNjdCheU/53F8TzEenvaVPbtUxCUk7h4zrYFOyxDnhyA39E2Peobpy0eMutLi/4CxyuzlQkhxzFMFYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1mSpROY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706536254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75S7nZ64UnAF9qceiwWx9BHlJYFt/uNOyQt1Jso/DHk=;
	b=L1mSpROY6uvqZTc0wQead6oH9c/d8uB3Bku2r82jieH5CwQH4LrxtFXbVmZl4eQCnggGD8
	ItksG4vkn6cTDuqdo1hW589U19tlIM8iurGfUeg/qPKBoXS/do6R0Le5Cjs6cUlCw2Hp5E
	vsxG5CfYfBaW+m+5ed0sRazsTT/wMFQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-d5dO4PAtO-Calcv1XMdhbg-1; Mon,
 29 Jan 2024 08:50:50 -0500
X-MC-Unique: d5dO4PAtO-Calcv1XMdhbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C60D3C2A1CC;
	Mon, 29 Jan 2024 13:50:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77CD6488;
	Mon, 29 Jan 2024 13:50:45 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	nathan@kernel.org,
	mhklinux@outlook.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next 3/3] arch, crash: move arch_crash_save_vmcoreinfo() out to file vmcore_info.c
Date: Mon, 29 Jan 2024 21:50:33 +0800
Message-ID: <20240129135033.157195-3-bhe@redhat.com>
In-Reply-To: <20240129135033.157195-1-bhe@redhat.com>
References: <20240129135033.157195-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Nathan reported below building error:

=====
$ curl -LSso .config https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.armv7
$ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- olddefconfig all
..
arm-linux-gnueabi-ld: arch/arm/kernel/machine_kexec.o: in function `arch_crash_save_vmcoreinfo':
machine_kexec.c:(.text+0x488): undefined reference to `vmcoreinfo_append_str'
====

On architecutres, like arm, s390, ppc, sh, function
arch_crash_save_vmcoreinfo() is located in machine_kexec.c and it can
only be compiled in when CONFIG_KEXEC_CORE=y.

That's not right because arch_crash_save_vmcoreinfo() is used to export
arch specific vmcoreinfo. CONFIG_VMCORE_INFO is supposed to control its
compiling in. However, CONFIG_VMVCORE_INFO could be independent of
CONFIG_KEXEC_CORE, e.g CONFIG_PROC_KCORE=y will select CONFIG_VMVCORE_INFO.
Or CONFIG_KEXEC/CONFIG_KEXEC_FILE is set while CONFIG_CRASH_DUMP is
not set, it will report linking error.

So, on arm, s390, ppc and sh, move arch_crash_save_vmcoreinfo out to
a new file vmcore_info.c. Let CONFIG_VMCORE_INFO decide if compiling in
arch_crash_save_vmcoreinfo().

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240126045551.GA126645@dev-arch.thelio-3990X/T/#u
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/kernel/Makefile         |  1 +
 arch/arm/kernel/machine_kexec.c  |  7 -------
 arch/arm/kernel/vmcore_info.c    | 10 ++++++++++
 arch/powerpc/kexec/Makefile      |  1 +
 arch/powerpc/kexec/core.c        | 28 --------------------------
 arch/powerpc/kexec/vmcore_info.c | 34 ++++++++++++++++++++++++++++++++
 arch/s390/kernel/Makefile        |  1 +
 arch/s390/kernel/machine_kexec.c | 15 --------------
 arch/s390/kernel/vmcore_info.c   | 23 +++++++++++++++++++++
 arch/sh/kernel/Makefile          |  1 +
 arch/sh/kernel/machine_kexec.c   | 11 -----------
 arch/sh/kernel/vmcore_info.c     | 17 ++++++++++++++++
 12 files changed, 88 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/kernel/vmcore_info.c
 create mode 100644 arch/powerpc/kexec/vmcore_info.c
 create mode 100644 arch/s390/kernel/vmcore_info.c
 create mode 100644 arch/sh/kernel/vmcore_info.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 771264d4726a..6a9de826ffd3 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)		+= patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 5d07cf9e0044..80ceb5bd2680 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -198,10 +198,3 @@ void machine_kexec(struct kimage *image)
 
 	soft_restart(reboot_entry_phys);
 }
-
-void arch_crash_save_vmcoreinfo(void)
-{
-#ifdef CONFIG_ARM_LPAE
-	VMCOREINFO_CONFIG(ARM_LPAE);
-#endif
-}
diff --git a/arch/arm/kernel/vmcore_info.c b/arch/arm/kernel/vmcore_info.c
new file mode 100644
index 000000000000..1437aba47787
--- /dev/null
+++ b/arch/arm/kernel/vmcore_info.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmcore_info.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_ARM_LPAE
+	VMCOREINFO_CONFIG(ARM_LPAE);
+#endif
+}
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 0c2abe7f9908..91e96f5168b7 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -8,6 +8,7 @@ obj-y				+= core.o crash.o core_$(BITS).o
 obj-$(CONFIG_PPC32)		+= relocate_32.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 27fa9098a5b7..3ff4411ed496 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -53,34 +53,6 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void arch_crash_save_vmcoreinfo(void)
-{
-
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-#ifndef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(contig_page_data);
-#endif
-#if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
-	VMCOREINFO_SYMBOL(vmemmap_list);
-	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
-	VMCOREINFO_SYMBOL(mmu_psize_defs);
-	VMCOREINFO_STRUCT_SIZE(vmemmap_backing);
-	VMCOREINFO_OFFSET(vmemmap_backing, list);
-	VMCOREINFO_OFFSET(vmemmap_backing, phys);
-	VMCOREINFO_OFFSET(vmemmap_backing, virt_addr);
-	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
-	VMCOREINFO_OFFSET(mmu_psize_def, shift);
-#endif
-	VMCOREINFO_SYMBOL(cur_cpu_spec);
-	VMCOREINFO_OFFSET(cpu_spec, cpu_features);
-	VMCOREINFO_OFFSET(cpu_spec, mmu_features);
-	vmcoreinfo_append_str("NUMBER(RADIX_MMU)=%d\n", early_radix_enabled());
-	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
-}
-
 /*
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
diff --git a/arch/powerpc/kexec/vmcore_info.c b/arch/powerpc/kexec/vmcore_info.c
new file mode 100644
index 000000000000..c15f0adaaab5
--- /dev/null
+++ b/arch/powerpc/kexec/vmcore_info.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmcore_info.h>
+#include <asm/pgalloc.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+#ifndef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(contig_page_data);
+#endif
+#if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
+	VMCOREINFO_SYMBOL(vmemmap_list);
+	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
+	VMCOREINFO_SYMBOL(mmu_psize_defs);
+	VMCOREINFO_STRUCT_SIZE(vmemmap_backing);
+	VMCOREINFO_OFFSET(vmemmap_backing, list);
+	VMCOREINFO_OFFSET(vmemmap_backing, phys);
+	VMCOREINFO_OFFSET(vmemmap_backing, virt_addr);
+	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
+	VMCOREINFO_OFFSET(mmu_psize_def, shift);
+#endif
+	VMCOREINFO_SYMBOL(cur_cpu_spec);
+	VMCOREINFO_OFFSET(cpu_spec, cpu_features);
+	VMCOREINFO_OFFSET(cpu_spec, mmu_features);
+	vmcoreinfo_append_str("NUMBER(RADIX_MMU)=%d\n", early_radix_enabled());
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+}
+
+
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 7a562b4199c8..fa029d0dc28f 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index aa22ffc16bcd..10277a460204 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -209,21 +209,6 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void arch_crash_save_vmcoreinfo(void)
-{
-	struct lowcore *abs_lc;
-
-	VMCOREINFO_SYMBOL(lowcore_ptr);
-	VMCOREINFO_SYMBOL(high_memory);
-	VMCOREINFO_LENGTH(lowcore_ptr, NR_CPUS);
-	vmcoreinfo_append_str("SAMODE31=%lx\n", (unsigned long)__samode31);
-	vmcoreinfo_append_str("EAMODE31=%lx\n", (unsigned long)__eamode31);
-	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
-	abs_lc = get_abs_lowcore();
-	abs_lc->vmcore_info = paddr_vmcoreinfo_note();
-	put_abs_lowcore(abs_lc);
-}
-
 void machine_shutdown(void)
 {
 }
diff --git a/arch/s390/kernel/vmcore_info.c b/arch/s390/kernel/vmcore_info.c
new file mode 100644
index 000000000000..eccb6b20b505
--- /dev/null
+++ b/arch/s390/kernel/vmcore_info.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmcore_info.h>
+#include <asm/abs_lowcore.h>
+#include <linux/mm.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	struct lowcore *abs_lc;
+
+	VMCOREINFO_SYMBOL(lowcore_ptr);
+	VMCOREINFO_SYMBOL(high_memory);
+	VMCOREINFO_LENGTH(lowcore_ptr, NR_CPUS);
+	vmcoreinfo_append_str("SAMODE31=%lx\n", (unsigned long)__samode31);
+	vmcoreinfo_append_str("EAMODE31=%lx\n", (unsigned long)__eamode31);
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+	abs_lc = get_abs_lowcore();
+	abs_lc->vmcore_info = paddr_vmcoreinfo_note();
+	put_abs_lowcore(abs_lc);
+}
+
+
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 2d7e70537de0..ba917008d63e 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_MODULES)		+= sh_ksyms_32.o module.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 8daa8a6e6fa6..8321b31d2e19 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -137,17 +137,6 @@ void machine_kexec(struct kimage *image)
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
 
-void arch_crash_save_vmcoreinfo(void)
-{
-#ifdef CONFIG_NUMA
-	VMCOREINFO_SYMBOL(node_data);
-	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
-#endif
-#ifdef CONFIG_X2TLB
-	VMCOREINFO_CONFIG(X2TLB);
-#endif
-}
-
 void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
diff --git a/arch/sh/kernel/vmcore_info.c b/arch/sh/kernel/vmcore_info.c
new file mode 100644
index 000000000000..04c4387e6315
--- /dev/null
+++ b/arch/sh/kernel/vmcore_info.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/vmcore_info.h>
+#include <linux/mm.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+#ifdef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(node_data);
+	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
+#endif
+#ifdef CONFIG_X2TLB
+	VMCOREINFO_CONFIG(X2TLB);
+#endif
+}
+
+
-- 
2.41.0


