Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5958E7E8064
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbjKJSKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjKJSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B633A210;
        Fri, 10 Nov 2023 07:01:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 13727218F3;
        Fri, 10 Nov 2023 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699628474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaOyrMjgzqxGqLlUoaKBH8sQiEaSYEnLmKrg7NNWeXQ=;
        b=uoVMcnjaJus7WsnjZUngsMirERxYwRO7/ybLF03jMz/lO8Sj+huP9z/tnpECJnfkZET+bs
        5l2jBFiReHL2oGs+R9JsfMXe13LtNgVjXryRZ8/bjJS0CpiiEY4ieSJfUoMCHl0fYLIGy+
        NaD4DrEKs30dK1Dq3ZwjRZXvF/YnZCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699628474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaOyrMjgzqxGqLlUoaKBH8sQiEaSYEnLmKrg7NNWeXQ=;
        b=3yqADet8Sv0uqEdyOWro6UJMTufQyCjQXBM5GvEYxh5+gBmaTCrVwYHaskfIT1EdrMqD5j
        ZlnSmI+3dhVRusDA==
Received: from localhost.cz (unknown [10.100.229.110])
        by relay2.suse.de (Postfix) with ESMTP id A97862C54D;
        Fri, 10 Nov 2023 15:01:13 +0000 (UTC)
From:   Lukas Hruska <lhruska@suse.cz>
To:     linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Koutny <mkoutny@suse.com>,
        YOSHIDA Masanori <masanori.yoshida.tv@hitachi.com>
Subject: [RFC PATCH 1/4 v1] crash/vmcore: VMCOREINFO creation from non-kdump kernel
Date:   Fri, 10 Nov 2023 16:00:54 +0100
Message-ID: <20231110150057.15717-2-lhruska@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231110150057.15717-1-lhruska@suse.cz>
References: <20231110150057.15717-1-lhruska@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is only fs/vmcore which requires generation of
VMCOREINFO and modification of ELF notes. That is why there are some
functions which expects they will be called only once and do not try to
recover their previous state. Because livedump output is similar to
vmcore file, it needs to do the same, only from non-kdump kernel.  To
prevent code duplicity and re-use already existing functions they must
be modified to properly restore their state.

Export VMCORE's ELF header creating functing. This way it can be used not only
for kdump ELF file generation.

Correctly restore the original pointer to VMCOREINFO destination in
crash_update_vmcoreinfo_safecopy so it can be used more than once.

Add check if elfcorehdr_read_* functions are being called from original kernel
or kdump kernel and correctly pick from which memory to read from.

Signed-off-by: Lukas Hruska <lhruska@suse.cz>
---
 fs/proc/vmcore.c           | 57 ++++++++++++--------------------------
 include/linux/crash_dump.h |  2 ++
 kernel/crash_core.c        | 10 ++++++-
 kernel/crash_dump.c        | 38 +++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 09a81e4b1273..806420d07d8c 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -191,33 +191,6 @@ int __weak elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size)
 void __weak elfcorehdr_free(unsigned long long addr)
 {}
 
-/*
- * Architectures may override this function to read from ELF header
- */
-ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
-{
-	struct kvec kvec = { .iov_base = buf, .iov_len = count };
-	struct iov_iter iter;
-
-	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
-
-	return read_from_oldmem(&iter, count, ppos, false);
-}
-
-/*
- * Architectures may override this function to read from notes sections
- */
-ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
-{
-	struct kvec kvec = { .iov_base = buf, .iov_len = count };
-	struct iov_iter iter;
-
-	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
-
-	return read_from_oldmem(&iter, count, ppos,
-			cc_platform_has(CC_ATTR_MEM_ENCRYPT));
-}
-
 /*
  * Architectures may override this function to map oldmem
  */
@@ -721,7 +694,7 @@ static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
  * program header table pointed to by @ehdr_ptr to real size of ELF
  * note segment.
  */
-static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
+static int update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 {
 	int i, rc=0;
 	Elf64_Phdr *phdr_ptr;
@@ -735,14 +708,17 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 			continue;
 		max_sz = phdr_ptr->p_memsz;
 		offset = phdr_ptr->p_offset;
-		notes_section = kmalloc(max_sz, GFP_KERNEL);
-		if (!notes_section)
-			return -ENOMEM;
-		rc = elfcorehdr_read_notes(notes_section, max_sz, &offset);
-		if (rc < 0) {
-			kfree(notes_section);
-			return rc;
-		}
+		if (is_kdump_kernel()) {
+			notes_section = kmalloc(max_sz, GFP_KERNEL);
+			if (!notes_section)
+				return -ENOMEM;
+			rc = elfcorehdr_read_notes(notes_section, max_sz, &offset);
+			if (rc < 0) {
+				kfree(notes_section);
+				return rc;
+			}
+		} else
+			notes_section = __va(phdr_ptr->p_paddr);
 		nhdr_ptr = notes_section;
 		while (nhdr_ptr->n_namesz != 0) {
 			sz = sizeof(Elf64_Nhdr) +
@@ -756,7 +732,8 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
-		kfree(notes_section);
+		if (is_kdump_kernel())
+			kfree(notes_section);
 		phdr_ptr->p_memsz = real_sz;
 		if (real_sz == 0) {
 			pr_warn("Warning: Zero PT_NOTE entries found\n");
@@ -784,7 +761,7 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
  * and each of PT_NOTE program headers has actual ELF note segment
  * size in its p_memsz member.
  */
-static int __init get_note_number_and_size_elf64(const Elf64_Ehdr *ehdr_ptr,
+static int get_note_number_and_size_elf64(const Elf64_Ehdr *ehdr_ptr,
 						 int *nr_ptnote, u64 *sz_ptnote)
 {
 	int i;
@@ -819,7 +796,7 @@ static int __init get_note_number_and_size_elf64(const Elf64_Ehdr *ehdr_ptr,
  * and each of PT_NOTE program headers has actual ELF note segment
  * size in its p_memsz member.
  */
-static int __init copy_notes_elf64(const Elf64_Ehdr *ehdr_ptr, char *notes_buf)
+static int copy_notes_elf64(const Elf64_Ehdr *ehdr_ptr, char *notes_buf)
 {
 	int i, rc=0;
 	Elf64_Phdr *phdr_ptr;
@@ -842,7 +819,7 @@ static int __init copy_notes_elf64(const Elf64_Ehdr *ehdr_ptr, char *notes_buf)
 }
 
 /* Merges all the PT_NOTE headers into one. */
-static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
+int merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 					   char **notes_buf, size_t *notes_sz)
 {
 	int i, nr_ptnote=0, rc=0;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 0f3a656293b0..53cc971cf5b6 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -28,6 +28,8 @@ ssize_t copy_oldmem_page(struct iov_iter *i, unsigned long pfn, size_t csize,
 		unsigned long offset);
 ssize_t copy_oldmem_page_encrypted(struct iov_iter *iter, unsigned long pfn,
 				   size_t csize, unsigned long offset);
+int merge_note_headers_elf64(char *elfptr, size_t *elfsz,
+					   char **notes_buf, size_t *notes_sz);
 
 void vmcore_cleanup(void);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 87ef6096823f..e90fd3a79411 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -357,15 +357,23 @@ void crash_update_vmcoreinfo_safecopy(void *ptr)
 
 void crash_save_vmcoreinfo(void)
 {
+	unsigned char *tmp_vmcoreinfo_data;
+
 	if (!vmcoreinfo_note)
 		return;
 
 	/* Use the safe copy to generate vmcoreinfo note if have */
-	if (vmcoreinfo_data_safecopy)
+	if (vmcoreinfo_data_safecopy) {
+		tmp_vmcoreinfo_data = vmcoreinfo_data;
 		vmcoreinfo_data = vmcoreinfo_data_safecopy;
+	}
 
 	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
 	update_vmcoreinfo_note();
+
+	/* Restore the original destination so it can be used multiple times */
+	if (vmcoreinfo_data_safecopy)
+		vmcoreinfo_data = tmp_vmcoreinfo_data;
 }
 
 void vmcoreinfo_append_str(const char *fmt, ...)
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 92da32275af5..0122c1694111 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -39,3 +39,41 @@ static int __init setup_elfcorehdr(char *arg)
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);
+
+/*
+ * Architectures may override this function to read from ELF header
+ */
+ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	if (!is_kdump_kernel()) {
+		memcpy(buf, ppos, count);
+		return count;
+	}
+
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos, false);
+}
+
+/*
+ * Architectures may override this function to read from notes sections
+ */
+ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
+{
+	struct kvec kvec = { .iov_base = buf, .iov_len = count };
+	struct iov_iter iter;
+
+	if (!is_kdump_kernel()) {
+		memcpy(buf, __va(*ppos), count);
+		return count;
+	}
+
+	iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, count);
+
+	return read_from_oldmem(&iter, count, ppos,
+			cc_platform_has(CC_ATTR_MEM_ENCRYPT));
+}
+
-- 
2.39.2

