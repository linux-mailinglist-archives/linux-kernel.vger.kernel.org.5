Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4F7CB70A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbjJPXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJPXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40E9AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7CD9020B74C2;
        Mon, 16 Oct 2023 16:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CD9020B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499154;
        bh=MdSra1KJVnjMDs0z9VTV6dK5Bib2ved+sk8K2wmqT7s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LYBhRqvCQrkNqpEuRVU6G0Y3n/i0Dd1UvHXi9+DX9aBYvpoNdHGuk1TK3qjgQXmgj
         knwdmu6h5YR7HMOaI/pEWZRZT0yTwrZdvGyjMqNQso97FEKp0666XOJ/Mdlov3+ftm
         iP3W/XMnpB1icKl5T65yFmb9L7VfMalBia7UNNPE=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 02/10] mm/prmem: Reserve metadata and persistent regions in early boot after kexec
Date:   Mon, 16 Oct 2023 18:32:07 -0500
Message-Id: <20231016233215.13090-3-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016233215.13090-1-madvenka@linux.microsoft.com>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
 <20231016233215.13090-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Currently, only one memory region is given to prmem to store persistent
data. In the future, regions may be added dynamically.

The prmem metadata and the regions need to be reserved during early boot
after a kexec. For this to happen, the kernel must know where the metadata
is. To allow this, introduce a kernel command line parameter:

	prmem_meta=metadata_address

When a kexec image is loaded into the kernel, add this parameter to the
kexec cmdline. Upon a kexec boot, get the metadata page from the cmdline
and reserve it. Then, walk the list of regions in the metadata and reserve
the regions.

Note that the cmdline modification is done automatically within the kernel.
Userland does not have to do anything.

The metadata needs to be validated before it can be used. To allow this,
compute a checksum on the metadata and store it in the metadata at the end
of shutdown. During early boot, validate the metadata with the checksum.

If the validation fails, discard the metadata. Treat it as a cold boot.
That is, allocate a new metadata page and initial region and start over.
Similarly, if the reservation of the regions fails, treat it as a cold
boot and start over.

This means that all persistent data will be lost on any of these failures.
Note that there will be no memory leak when this happens.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 arch/x86/kernel/kexec-bzimage64.c |  5 +-
 arch/x86/kernel/setup.c           |  2 +
 include/linux/memblock.h          |  2 +
 include/linux/prmem.h             | 11 ++++
 kernel/prmem/Makefile             |  2 +-
 kernel/prmem/prmem_init.c         |  9 ++++
 kernel/prmem/prmem_misc.c         | 85 +++++++++++++++++++++++++++++++
 kernel/prmem/prmem_parse.c        | 29 +++++++++++
 kernel/prmem/prmem_reserve.c      | 70 ++++++++++++++++++++++++-
 kernel/reboot.c                   |  2 +
 mm/memblock.c                     | 12 +++++
 11 files changed, 226 insertions(+), 3 deletions(-)
 create mode 100644 kernel/prmem/prmem_misc.c

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..a19f172be410 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/prmem.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -82,6 +83,8 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 
 	cmdline_ptr[cmdline_len - 1] = '\0';
 
+	prmem_cmdline(cmdline_ptr);
+
 	pr_debug("Final command line is: %s\n", cmdline_ptr);
 	cmdline_ptr_phys = bootparams_load_addr + cmdline_offset;
 	cmdline_low_32 = cmdline_ptr_phys & 0xffffffffUL;
@@ -458,7 +461,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 */
 	efi_map_sz = efi_get_runtime_map_size();
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
-				MAX_ELFCOREHDR_STR_LEN;
+				MAX_ELFCOREHDR_STR_LEN + prmem_cmdline_size();
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
 	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f2b13b3d3ead..22f5cd494291 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1137,6 +1137,8 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	efi_reserve_boot_services();
 
+	prmem_reserve_early();
+
 	/* preallocate 4k for mptable mpc */
 	e820__memblock_alloc_reserved_mpc_new();
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f71ff9f0ec81..584bbb884c8e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -114,6 +114,8 @@ int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_phys_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
+void memblock_unreserve(phys_addr_t base, phys_addr_t size);
+
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 #endif
diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index 7f22016c4ad2..bc8054a86f49 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -48,12 +48,16 @@ struct prmem_region {
 /*
  * PRMEM metadata.
  *
+ * checksum	Just before reboot, a checksum is computed on the metadata. On
+ *		the next kexec reboot, the metadata is validated with the
+ *		checksum to make sure that the metadata has not been corrupted.
  * metadata	Physical address of the metadata page.
  * size		Size of initial memory allocated to prmem.
  *
  * regions	List of memory regions.
  */
 struct prmem {
+	unsigned long		checksum;
 	unsigned long		metadata;
 	size_t			size;
 
@@ -65,12 +69,19 @@ extern struct prmem		*prmem;
 extern unsigned long		prmem_metadata;
 extern unsigned long		prmem_pa;
 extern size_t			prmem_size;
+extern bool			prmem_inited;
 
 /* Kernel API. */
+void prmem_reserve_early(void);
 void prmem_reserve(void);
 void prmem_init(void);
+void prmem_fini(void);
+int  prmem_cmdline_size(void);
 
 /* Internal functions. */
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
+unsigned long prmem_checksum(void *start, size_t size);
+bool __init prmem_validate(void);
+void prmem_cmdline(char *cmdline);
 
 #endif /* _LINUX_PRMEM_H */
diff --git a/kernel/prmem/Makefile b/kernel/prmem/Makefile
index 11a53d49312a..9b0a693bfee1 100644
--- a/kernel/prmem/Makefile
+++ b/kernel/prmem/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += prmem_parse.o prmem_reserve.o prmem_init.o prmem_region.o
+obj-y += prmem_parse.o prmem_reserve.o prmem_init.o prmem_region.o prmem_misc.o
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
index 97b550252028..9cea1cd3b6a5 100644
--- a/kernel/prmem/prmem_init.c
+++ b/kernel/prmem/prmem_init.c
@@ -25,3 +25,12 @@ void __init prmem_init(void)
 	}
 	prmem_inited = true;
 }
+
+void prmem_fini(void)
+{
+	if (!prmem_inited)
+		return;
+
+	/* Compute checksum over the metadata. */
+	prmem->checksum = prmem_checksum(prmem, sizeof(*prmem));
+}
diff --git a/kernel/prmem/prmem_misc.c b/kernel/prmem/prmem_misc.c
new file mode 100644
index 000000000000..49b6a7232c1a
--- /dev/null
+++ b/kernel/prmem/prmem_misc.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Persistent-Across-Kexec memory (prmem) - Miscellaneous functions.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+#define MAX_META_LENGTH	31
+
+/*
+ * On a kexec, modify the kernel command line to include the boot parameter
+ * "prmem_meta=" so that the metadata can be found on the next boot. If the
+ * parameter is already present in cmdline, overwrite it. Else, add it.
+ */
+void prmem_cmdline(char *cmdline)
+{
+	char		meta[MAX_META_LENGTH], *str;
+	unsigned long	metadata;
+
+	metadata = prmem_inited ? prmem->metadata : 0;
+	snprintf(meta, MAX_META_LENGTH, " prmem_meta=0x%.16lx", metadata);
+
+	str = strstr(cmdline, " prmem_meta");
+	if (str) {
+		/*
+		 * Boot parameter already exists. Overwrite it. We deliberately
+		 * use strncpy() and rely on the fact that it will not NULL
+		 * terminate the copy.
+		 */
+		strncpy(str, meta, MAX_META_LENGTH - 1);
+		return;
+	}
+	if (prmem_inited) {
+		/* Boot parameter does not exist. Add it. */
+		strcat(cmdline, meta);
+	}
+}
+
+/*
+ * Make sure that the kexec command line can accommodate the prmem_meta
+ * command line parameter.
+ */
+int prmem_cmdline_size(void)
+{
+	return MAX_META_LENGTH;
+}
+
+unsigned long prmem_checksum(void *start, size_t size)
+{
+	unsigned long	checksum = 0;
+	unsigned long	*ptr;
+	void		*end;
+
+	end = start + size;
+	for (ptr = start; (void *) ptr < end; ptr++)
+		checksum += *ptr;
+	return checksum;
+}
+
+/*
+ * Check if the metadata is sane. It would not be sane on a cold boot or if the
+ * metadata has been corrupted. In the latter case, we treat it as a cold boot.
+ */
+bool __init prmem_validate(void)
+{
+	unsigned long		checksum;
+
+	/* Sanity check the boot parameter. */
+	if (prmem_metadata != prmem->metadata || prmem_size != prmem->size) {
+		pr_warn("%s: Boot parameter mismatch\n", __func__);
+		return false;
+	}
+
+	/* Compute and check the checksum of the metadata. */
+	checksum = prmem->checksum;
+	prmem->checksum = 0;
+
+	if (checksum != prmem_checksum(prmem, sizeof(*prmem))) {
+		pr_warn("%s: Checksum mismatch\n", __func__);
+		return false;
+	}
+	return true;
+}
diff --git a/kernel/prmem/prmem_parse.c b/kernel/prmem/prmem_parse.c
index 191655b53545..6c1a23c6b84e 100644
--- a/kernel/prmem/prmem_parse.c
+++ b/kernel/prmem/prmem_parse.c
@@ -31,3 +31,32 @@ static int __init prmem_size_parse(char *cmdline)
 	return 0;
 }
 early_param("prmem", prmem_size_parse);
+
+/*
+ * Syntax: prmem_meta=metadata_address
+ *
+ *	Specifies the address of a single page where the prmem metadata resides.
+ *
+ * On a kexec, the following will be appended to the kernel command line -
+ * "prmem_meta=metadata_address". This is so that the metadata can be located
+ * easily on kexec reboots.
+ */
+static int __init prmem_meta_parse(char *cmdline)
+{
+	char			*tmp, *cur = cmdline;
+	unsigned long		addr;
+
+	if (!cur)
+		return -EINVAL;
+
+	/* Get metadata address. */
+	addr = memparse(cur, &tmp);
+	if (cur == tmp || addr & (PAGE_SIZE - 1)) {
+		pr_warn("%s: Incorrect address %lx\n", __func__, addr);
+		return -EINVAL;
+	}
+
+	prmem_metadata = addr;
+	return 0;
+}
+early_param("prmem_meta", prmem_meta_parse);
diff --git a/kernel/prmem/prmem_reserve.c b/kernel/prmem/prmem_reserve.c
index e20e31a61d12..8000fff05402 100644
--- a/kernel/prmem/prmem_reserve.c
+++ b/kernel/prmem/prmem_reserve.c
@@ -12,11 +12,79 @@ unsigned long		prmem_metadata;
 unsigned long		prmem_pa;
 unsigned long		prmem_size;
 
+void __init prmem_reserve_early(void)
+{
+	struct prmem_region	*region;
+	unsigned long		nregions;
+
+	/* Need to specify an initial size to enable prmem. */
+	if (!prmem_size)
+		return;
+
+	/* Nothing to be done if it is a cold boot. */
+	if (!prmem_metadata)
+		return;
+
+	/*
+	 * prmem uses direct map addresses. If PAGE_OFFSET is randomized,
+	 * these addresses will change across kexecs. Persistence cannot
+	 * be supported.
+	 */
+	if (kaslr_memory_enabled()) {
+		pr_warn("%s: Cannot support persistence because of KASLR.\n",
+			__func__);
+		return;
+	}
+
+	/*
+	 * This is a kexec reboot. If any step fails here, treat this like a
+	 * cold boot. That is, forget all persistent data and start over.
+	 */
+
+	/* Reserve metadata page. */
+	if (memblock_reserve(prmem_metadata, PAGE_SIZE)) {
+		pr_warn("%s: Unable to reserve metadata at %lx\n", __func__,
+			prmem_metadata);
+		return;
+	}
+	prmem = __va(prmem_metadata);
+
+	/* Make sure that the metadata is sane. */
+	if (!prmem_validate())
+		goto unreserve_metadata;
+
+	/* Reserve regions that were added to prmem. */
+	nregions = 0;
+	list_for_each_entry(region, &prmem->regions, node) {
+		if (memblock_reserve(region->pa, region->size)) {
+			pr_warn("%s: Unable to reserve %lx, %lx\n", __func__,
+				region->pa, region->size);
+			goto unreserve_regions;
+		}
+		nregions++;
+	}
+	return;
+
+unreserve_regions:
+	/* Unreserve regions. */
+	list_for_each_entry(region, &prmem->regions, node) {
+		if (!nregions)
+			break;
+		memblock_unreserve(region->pa, region->size);
+		nregions--;
+	}
+
+unreserve_metadata:
+	/* Unreserve the metadata page. */
+	memblock_unreserve(prmem_metadata, PAGE_SIZE);
+	prmem = NULL;
+}
+
 void __init prmem_reserve(void)
 {
 	BUILD_BUG_ON(sizeof(*prmem) > PAGE_SIZE);
 
-	if (!prmem_size)
+	if (!prmem_size || prmem)
 		return;
 
 	/*
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..b4595b7e77f3 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/prmem.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -84,6 +85,7 @@ void kernel_restart_prepare(char *cmd)
 	system_state = SYSTEM_RESTART;
 	usermodehelper_disable();
 	device_shutdown();
+	prmem_fini();
 }
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index f9e61e565a53..1f5070f7b5bc 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -873,6 +873,18 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
 }
 
+void __init_memblock memblock_unreserve(phys_addr_t base, phys_addr_t size)
+{
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
+		     &base, &end, (void *)_RET_IP_);
+
+	if (memblock_remove_range(&memblock.reserved, base, size))
+		return;
+	memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 {
-- 
2.25.1

