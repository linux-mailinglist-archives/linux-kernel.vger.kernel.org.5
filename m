Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10567FE727
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjK3Ck5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344296AbjK3Ckl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1F19BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701312035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdwBdzw1OKhTav+YH8fRcY/9XRVbx1jKltcdxPMZtNM=;
        b=PS8SGIHmgH8dKQdgQ4+GiV7Epn5WapR1OwD0qBM2jUBaFtop7WBAu9+zU0jA0iest3dv3B
        vu75o1S/ppx4Xq5x7hUbiC98SklkKBudzHZrtG0ib4w3S5qfSC3ZXHERWcSWFjLIEyYtXk
        b83TiGvWeHQTWpsOYkpnQqYzxZH6o/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-z7H-g0mWPeOtPLBUD5zPOA-1; Wed,
 29 Nov 2023 21:40:30 -0500
X-MC-Unique: z7H-g0mWPeOtPLBUD5zPOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0121A3C027E4;
        Thu, 30 Nov 2023 02:40:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA7602026D4C;
        Thu, 30 Nov 2023 02:40:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 6/7] kexec_file, power: print out debugging message if required
Date:   Thu, 30 Nov 2023 10:39:54 +0800
Message-ID: <20231130023955.5257-7-bhe@redhat.com>
In-Reply-To: <20231130023955.5257-1-bhe@redhat.com>
References: <20231130023955.5257-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/kexec/elf_64.c       |  8 ++++----
 arch/powerpc/kexec/file_load_64.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
index eeb258002d1e..904016cf89ea 100644
--- a/arch/powerpc/kexec/elf_64.c
+++ b/arch/powerpc/kexec/elf_64.c
@@ -59,7 +59,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out;
 
-	pr_debug("Loaded the kernel at 0x%lx\n", kernel_load_addr);
+	kexec_dprintk("Loaded the kernel at 0x%lx\n", kernel_load_addr);
 
 	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
@@ -67,7 +67,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 		goto out;
 	}
 
-	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	kexec_dprintk("Loaded purgatory at 0x%lx\n", pbuf.mem);
 
 	/* Load additional segments needed for panic kernel */
 	if (image->type == KEXEC_TYPE_CRASH) {
@@ -99,7 +99,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 			goto out;
 		initrd_load_addr = kbuf.mem;
 
-		pr_debug("Loaded initrd at 0x%lx\n", initrd_load_addr);
+		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_load_addr);
 	}
 
 	fdt = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
@@ -132,7 +132,7 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
 
 	fdt_load_addr = kbuf.mem;
 
-	pr_debug("Loaded device tree at 0x%lx\n", fdt_load_addr);
+	kexec_dprintk("Loaded device tree at 0x%lx\n", fdt_load_addr);
 
 	slave_code = elf_info.buffer + elf_info.proghdrs[0].p_offset;
 	ret = setup_purgatory_ppc64(image, slave_code, fdt, kernel_load_addr,
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 961a6dd67365..5b4c5cb23354 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -577,7 +577,7 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 		       NODE_PATH_LEN, dn);
 		return -EOVERFLOW;
 	}
-	pr_debug("Memory node path: %s\n", path);
+	kexec_dprintk("Memory node path: %s\n", path);
 
 	/* Now that we know the path, find its offset in kdump kernel's fdt */
 	node = fdt_path_offset(fdt, path);
@@ -590,8 +590,8 @@ static int add_usable_mem_property(void *fdt, struct device_node *dn,
 	/* Get the address & size cells */
 	n_mem_addr_cells = of_n_addr_cells(dn);
 	n_mem_size_cells = of_n_size_cells(dn);
-	pr_debug("address cells: %d, size cells: %d\n", n_mem_addr_cells,
-		 n_mem_size_cells);
+	kexec_dprintk("address cells: %d, size cells: %d\n", n_mem_addr_cells,
+		      n_mem_size_cells);
 
 	um_info->idx  = 0;
 	if (!check_realloc_usable_mem(um_info, 2)) {
@@ -664,7 +664,7 @@ static int update_usable_mem_fdt(void *fdt, struct crash_mem *usable_mem)
 
 	node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
 	if (node == -FDT_ERR_NOTFOUND)
-		pr_debug("No dynamic reconfiguration memory found\n");
+		kexec_dprintk("No dynamic reconfiguration memory found\n");
 	else if (node < 0) {
 		pr_err("Malformed device tree: error reading /ibm,dynamic-reconfiguration-memory.\n");
 		return -EINVAL;
@@ -776,8 +776,8 @@ static void update_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr)
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		if (phdr->p_paddr == BACKUP_SRC_START) {
 			phdr->p_offset = image->arch.backup_start;
-			pr_debug("Backup region offset updated to 0x%lx\n",
-				 image->arch.backup_start);
+			kexec_dprintk("Backup region offset updated to 0x%lx\n",
+				      image->arch.backup_start);
 			return;
 		}
 	}
@@ -850,7 +850,7 @@ int load_crashdump_segments_ppc64(struct kimage *image,
 		pr_err("Failed to load backup segment\n");
 		return ret;
 	}
-	pr_debug("Loaded the backup region at 0x%lx\n", kbuf->mem);
+	kexec_dprintk("Loaded the backup region at 0x%lx\n", kbuf->mem);
 
 	/* Load elfcorehdr segment - to export crashing kernel's vmcore */
 	ret = load_elfcorehdr_segment(image, kbuf);
@@ -858,8 +858,8 @@ int load_crashdump_segments_ppc64(struct kimage *image,
 		pr_err("Failed to load elfcorehdr segment\n");
 		return ret;
 	}
-	pr_debug("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf->bufsz, kbuf->memsz);
+	kexec_dprintk("Loaded elf core header at 0x%lx, bufsz=0x%lx memsz=0x%lx\n",
+		      image->elf_load_addr, kbuf->bufsz, kbuf->memsz);
 
 	return 0;
 }
-- 
2.41.0

