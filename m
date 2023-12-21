Return-Path: <linux-kernel+bounces-8466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4403C81B7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E851C217C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0476DCC;
	Thu, 21 Dec 2023 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1Bbk7RM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965980590
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28659348677so575235a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703165132; x=1703769932; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/DS3plAsGGkfXvSea0H3Njbv+EkemNe6sD3VMx3Ho4=;
        b=B1Bbk7RMIlBBT9cB/8uT5iR5Knx4/pA2vnIOL5uz/IVVYngoTUC79dPJfZWABiSUIR
         iTP5LzAo6U2J6vimo/+MQiW79xaEnusIrBh60eQzjA97qQVM885JJts54C+6nDxpnoAQ
         +NAtNqe90/2ABARibHC8hJ8g/pO/r4afzcpEmEHbs/UlfFvSx903LX08akxVh7Ovcd8H
         ZbODhlQIeTfawtnzfNYwdY5uHyEJoLz5GW4A4rxCKW9mr3FlpVrC22rfO5KdBdzrKpaK
         0EcPV0On3cwzuRkX9mTxCfJVxTUdXtDztVtLMD2PD9hyC9uiSznUezhggDhASTObHHZj
         vLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703165132; x=1703769932;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/DS3plAsGGkfXvSea0H3Njbv+EkemNe6sD3VMx3Ho4=;
        b=rahyXq+l5G7EWYvy4ZXsoZ4dNhNcRmn47KGkXEZe85VzgbWK2Izpf0mst4ahYaUTgX
         +KzLc5xb6Wu7s47v2xHOWZI53KbTuMx4a8b+Zy851iNq+5AzdSznuIKCmoMc/BujBOy8
         5ILe0/I8wpNvII5CBMyaDuDDm7QBj15xeCxBpJ6yb5Zcs25jybh6zjiFFcY5q3uNGTuc
         KIVsP4ReXXuSb9CQfFMxkuKJFUHgLG+2MZBs6oxaEY1e5oUqhKOHZm56p+s+c9sRVyH+
         EQbNgeFI9dD3/PZworBBfD74LRl0rSBheKbOQMVGCaAp8GxPa9IBcKtqI8DWmjVjrJqQ
         jRIw==
X-Gm-Message-State: AOJu0Yx9XBmCyE6ec7nVZNpoq/jzrE84c9/42TzNlGDErJrBFzNQsKTB
	cuONQxps0S8uHGKEQ7WtsWU=
X-Google-Smtp-Source: AGHT+IGkXBT8oqblE3YuI1ThaXHFX3DcdNh1gfUXgs4jHaYsZd5D1avj3ud8huyGboP9iYvj7uDzTA==
X-Received: by 2002:a17:90b:4c12:b0:28b:cc1e:66f4 with SMTP id na18-20020a17090b4c1200b0028bcc1e66f4mr791145pjb.33.1703165132327;
        Thu, 21 Dec 2023 05:25:32 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090abe0300b0028bc09a5e1fsm1760016pjs.12.2023.12.21.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:25:31 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org
Cc: qiruipeng@lixiang.com,
	maz@kernel.org,
	lecopzer.chen@mediatek.com,
	ardb@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	arnd@arndb.de,
	mcgrof@kernel.org,
	brauner@kernel.org,
	dianders@chromium.org,
	maninder1.s@samsung.com,
	michael.christie@oracle.com,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH 2/7] osdump: reuse some code from crash_core to get vmcoreinfo
Date: Thu, 21 Dec 2023 21:25:22 +0800
Message-Id: <20231221132522.547-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: qiruipeng <qiruipeng@lixiang.com>

Osdump is a new crash dumping solution like crash. It is interested in
vmcoreinfo,too. Reuse some data and function from crash_core, but not full
of them. So pick some code to get vmcoreinfo as needed.

Signed-off-by: qiruipeng <qiruipeng@lixiang.com>
---
 arch/arm64/kernel/Makefile |   1 +
 include/linux/buildid.h    |   3 +-
 kernel/Makefile            |   1 +
 kernel/crash_core_mini.c   | 275 +++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c     |   2 +-
 lib/buildid.c              |   3 +-
 6 files changed, 282 insertions(+), 3 deletions(-)
 create mode 100644 kernel/crash_core_mini.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index d95b3d6b471a..fd6d06e44ae2 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
 obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
+obj-$(CONFIG_OS_MINIDUMP)              += crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 8a582d242f06..157edba44068 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -11,7 +11,8 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE) \
+	|| IS_ENABLED(CONFIG_OS_MINIDUMP)
 extern unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX];
 void init_vmlinux_build_id(void);
 #else
diff --git a/kernel/Makefile b/kernel/Makefile
index dc2b4ba5c953..14b7002f3279 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
+obj-$(CONFIG_OS_MINIDUMP) += crash_core_mini.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
diff --git a/kernel/crash_core_mini.c b/kernel/crash_core_mini.c
new file mode 100644
index 000000000000..a0f8d0c79bba
--- /dev/null
+++ b/kernel/crash_core_mini.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * crash.c - kernel crash support code.
+ * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
+ */
+
+#include <linux/buildid.h>
+#include <linux/init.h>
+#include <linux/utsname.h>
+#include <linux/vmalloc.h>
+#include <linux/sizes.h>
+#include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
+#include <linux/memblock.h>
+#include <linux/kexec.h>
+#include <linux/kmemleak.h>
+
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <crypto/sha1.h>
+
+#include "kallsyms_internal.h"
+#include "kexec_internal.h"
+
+/* Per cpu memory for storing cpu states in case of system crash. */
+note_buf_t __percpu *crash_notes;
+
+/* vmcoreinfo stuff */
+unsigned char *vmcoreinfo_data;
+size_t vmcoreinfo_size;
+u32 *vmcoreinfo_note;
+
+/* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
+static unsigned char *vmcoreinfo_data_safecopy;
+
+
+Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
+			  void *data, size_t data_len)
+{
+	struct elf_note *note = (struct elf_note *)buf;
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = data_len;
+	note->n_type   = type;
+	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf_Word));
+	memcpy(buf, name, note->n_namesz);
+	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf_Word));
+	memcpy(buf, data, data_len);
+	buf += DIV_ROUND_UP(data_len, sizeof(Elf_Word));
+
+	return buf;
+}
+
+void final_note(Elf_Word *buf)
+{
+	memset(buf, 0, sizeof(struct elf_note));
+}
+
+static void update_vmcoreinfo_note(void)
+{
+	u32 *buf = vmcoreinfo_note;
+
+	if (!vmcoreinfo_size)
+		return;
+	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
+			      vmcoreinfo_size);
+	final_note(buf);
+}
+
+void crash_update_vmcoreinfo_safecopy(void *ptr)
+{
+	if (ptr)
+		memcpy(ptr, vmcoreinfo_data, vmcoreinfo_size);
+
+	vmcoreinfo_data_safecopy = ptr;
+}
+
+void crash_save_vmcoreinfo(void)
+{
+	if (!vmcoreinfo_note)
+		return;
+
+	/* Use the safe copy to generate vmcoreinfo note if have */
+	if (vmcoreinfo_data_safecopy)
+		vmcoreinfo_data = vmcoreinfo_data_safecopy;
+
+	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
+	update_vmcoreinfo_note();
+}
+
+void vmcoreinfo_append_str(const char *fmt, ...)
+{
+	va_list args;
+	char buf[0x50];
+	size_t r;
+
+	va_start(args, fmt);
+	r = vscnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	r = min(r, (size_t)VMCOREINFO_BYTES - vmcoreinfo_size);
+
+	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
+
+	vmcoreinfo_size += r;
+
+	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
+		  "vmcoreinfo data exceeds allocated size, truncating");
+}
+
+/*
+ * provide an empty default implementation here -- architecture
+ * code may override this
+ */
+void __weak arch_crash_save_vmcoreinfo(void)
+{}
+
+phys_addr_t __weak paddr_vmcoreinfo_note(void)
+{
+	return __pa(vmcoreinfo_note);
+}
+EXPORT_SYMBOL(paddr_vmcoreinfo_note);
+
+int get_note_size(void)
+{
+	return VMCOREINFO_NOTE_SIZE;
+}
+
+static int __init crash_save_vmcoreinfo_init(void)
+{
+	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+	if (!vmcoreinfo_data) {
+		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
+		return -ENOMEM;
+	}
+
+	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!vmcoreinfo_note) {
+		free_page((unsigned long)vmcoreinfo_data);
+		vmcoreinfo_data = NULL;
+		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
+		return -ENOMEM;
+	}
+
+	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
+	VMCOREINFO_BUILD_ID();
+	VMCOREINFO_PAGESIZE(PAGE_SIZE);
+
+	VMCOREINFO_SYMBOL(init_uts_ns);
+	VMCOREINFO_OFFSET(uts_namespace, name);
+	VMCOREINFO_SYMBOL(node_online_map);
+#ifdef CONFIG_MMU
+	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
+#endif
+	VMCOREINFO_SYMBOL(_stext);
+	VMCOREINFO_SYMBOL(vmap_area_list);
+
+#ifndef CONFIG_NUMA
+	VMCOREINFO_SYMBOL(mem_map);
+	VMCOREINFO_SYMBOL(contig_page_data);
+#endif
+#ifdef CONFIG_SPARSEMEM
+	VMCOREINFO_SYMBOL_ARRAY(mem_section);
+	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
+	VMCOREINFO_STRUCT_SIZE(mem_section);
+	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
+	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
+#endif
+	VMCOREINFO_STRUCT_SIZE(page);
+	VMCOREINFO_STRUCT_SIZE(pglist_data);
+	VMCOREINFO_STRUCT_SIZE(zone);
+	VMCOREINFO_STRUCT_SIZE(free_area);
+	VMCOREINFO_STRUCT_SIZE(list_head);
+	VMCOREINFO_SIZE(nodemask_t);
+	VMCOREINFO_OFFSET(page, flags);
+	VMCOREINFO_OFFSET(page, _refcount);
+	VMCOREINFO_OFFSET(page, mapping);
+	VMCOREINFO_OFFSET(page, lru);
+	VMCOREINFO_OFFSET(page, _mapcount);
+	VMCOREINFO_OFFSET(page, private);
+	VMCOREINFO_OFFSET(page, compound_head);
+	VMCOREINFO_OFFSET(pglist_data, node_zones);
+	VMCOREINFO_OFFSET(pglist_data, nr_zones);
+#ifdef CONFIG_FLATMEM
+	VMCOREINFO_OFFSET(pglist_data, node_mem_map);
+#endif
+	VMCOREINFO_OFFSET(pglist_data, node_start_pfn);
+	VMCOREINFO_OFFSET(pglist_data, node_spanned_pages);
+	VMCOREINFO_OFFSET(pglist_data, node_id);
+	VMCOREINFO_OFFSET(zone, free_area);
+	VMCOREINFO_OFFSET(zone, vm_stat);
+	VMCOREINFO_OFFSET(zone, spanned_pages);
+	VMCOREINFO_OFFSET(free_area, free_list);
+	VMCOREINFO_OFFSET(list_head, next);
+	VMCOREINFO_OFFSET(list_head, prev);
+	VMCOREINFO_OFFSET(vmap_area, va_start);
+	VMCOREINFO_OFFSET(vmap_area, list);
+	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
+	log_buf_vmcoreinfo_setup();
+	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
+	VMCOREINFO_NUMBER(NR_FREE_PAGES);
+	VMCOREINFO_NUMBER(PG_lru);
+	VMCOREINFO_NUMBER(PG_private);
+	VMCOREINFO_NUMBER(PG_swapcache);
+	VMCOREINFO_NUMBER(PG_swapbacked);
+	VMCOREINFO_NUMBER(PG_slab);
+#ifdef CONFIG_MEMORY_FAILURE
+	VMCOREINFO_NUMBER(PG_hwpoison);
+#endif
+	VMCOREINFO_NUMBER(PG_head_mask);
+#define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
+	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
+#ifdef CONFIG_HUGETLB_PAGE
+	VMCOREINFO_NUMBER(PG_hugetlb);
+#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
+	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
+#endif
+
+#ifdef CONFIG_KALLSYMS
+	VMCOREINFO_SYMBOL(kallsyms_names);
+	VMCOREINFO_SYMBOL(kallsyms_num_syms);
+	VMCOREINFO_SYMBOL(kallsyms_token_table);
+	VMCOREINFO_SYMBOL(kallsyms_token_index);
+#ifdef CONFIG_KALLSYMS_BASE_RELATIVE
+	VMCOREINFO_SYMBOL(kallsyms_offsets);
+	VMCOREINFO_SYMBOL(kallsyms_relative_base);
+#else
+	VMCOREINFO_SYMBOL(kallsyms_addresses);
+#endif /* CONFIG_KALLSYMS_BASE_RELATIVE */
+#endif /* CONFIG_KALLSYMS */
+
+	arch_crash_save_vmcoreinfo();
+	update_vmcoreinfo_note();
+
+	return 0;
+}
+
+subsys_initcall(crash_save_vmcoreinfo_init);
+
+static int __init crash_notes_memory_init(void)
+{
+	/* Allocate memory for saving cpu registers. */
+	size_t size, align;
+
+	/*
+	 * crash_notes could be allocated across 2 vmalloc pages when percpu
+	 * is vmalloc based . vmalloc doesn't guarantee 2 continuous vmalloc
+	 * pages are also on 2 continuous physical pages. In this case the
+	 * 2nd part of crash_notes in 2nd page could be lost since only the
+	 * starting address and size of crash_notes are exported through sysfs.
+	 * Here round up the size of crash_notes to the nearest power of two
+	 * and pass it to __alloc_percpu as align value. This can make sure
+	 * crash_notes is allocated inside one physical page.
+	 */
+	size = sizeof(note_buf_t);
+	align = min(roundup_pow_of_two(sizeof(note_buf_t)), PAGE_SIZE);
+
+	/*
+	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
+	 * definitely will be in 2 pages with that.
+	 */
+	BUILD_BUG_ON(size > PAGE_SIZE);
+
+	crash_notes = __alloc_percpu(size, align);
+	if (!crash_notes) {
+		pr_warn("Memory allocation for saving cpu register states failed\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+subsys_initcall(crash_notes_memory_init);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..f4dea403bda7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -951,7 +951,7 @@ const struct file_operations kmsg_fops = {
 	.release = devkmsg_release,
 };
 
-#ifdef CONFIG_CRASH_CORE
+#if defined(CONFIG_CRASH_CORE) || defined(CONFIG_OS_MINIDUMP)
 /*
  * This appends the listed symbols to /proc/vmcore
  *
diff --git a/lib/buildid.c b/lib/buildid.c
index e3a7acdeef0e..78d7ce03b34e 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -174,7 +174,8 @@ int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
 	return parse_build_id_buf(build_id, NULL, buf, buf_size);
 }
 
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE)
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_CRASH_CORE) \
+		|| (IS_ENABLED(CONFIG_OS_MINIDUMP))
 unsigned char vmlinux_build_id[BUILD_ID_SIZE_MAX] __ro_after_init;
 
 /**
-- 
2.17.1


