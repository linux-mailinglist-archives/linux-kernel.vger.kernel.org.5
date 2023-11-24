Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BDE7F6AED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjKXDhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjKXDhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:37:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EBD10E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700797029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oH4a1eMA3o2aCIb7hj/C0FDGAKl9TVykYxTnGxkMIo=;
        b=M4dkEdK5KlDW3DCdYGqD7Ykf75XI6CNjKABOANow2Y3bTgJY6wCLCsPtwDE2FXsaXhWvjB
        gCUHeXNfTXaDDTuFdGyhClTS/ff6UySDnC+uHRNVWy8Cd1R0/Vp+L6n/nsM+7cSSwo5X0p
        M+Vvqri0xccdCGjGHfQrsczgVqWyPaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Js8XAS9MOZ2h9k-HTQUu3w-1; Thu, 23 Nov 2023 22:37:05 -0500
X-MC-Unique: Js8XAS9MOZ2h9k-HTQUu3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 068C5185A782;
        Fri, 24 Nov 2023 03:37:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85F5A492BE7;
        Fri, 24 Nov 2023 03:37:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, yujie.liu@intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 3/7] kexec_file, x86: print out debugging message if required
Date:   Fri, 24 Nov 2023 11:36:38 +0800
Message-ID: <20231124033642.520686-4-bhe@redhat.com>
In-Reply-To: <20231124033642.520686-1-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

And also print out e820 memmap passed to 2nd kernel just as kexec_load
interface has been doing.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c           |  2 +-
 arch/x86/kernel/kexec-bzimage64.c | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..df4dbd3aa08c 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -386,7 +386,7 @@ int crash_load_segments(struct kimage *image)
 	if (ret)
 		return ret;
 	image->elf_load_addr = kbuf.mem;
-	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+	kexec_dprintk("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..e9ae0eac6bf9 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -82,7 +82,7 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 
 	cmdline_ptr[cmdline_len - 1] = '\0';
 
-	pr_debug("Final command line is: %s\n", cmdline_ptr);
+	kexec_dprintk("Final command line is: %s\n", cmdline_ptr);
 	cmdline_ptr_phys = bootparams_load_addr + cmdline_offset;
 	cmdline_low_32 = cmdline_ptr_phys & 0xffffffffUL;
 	cmdline_ext_32 = cmdline_ptr_phys >> 32;
@@ -272,7 +272,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 
 	nr_e820_entries = params->e820_entries;
 
+	kexec_dprintk("E820 memmap:\n");
 	for (i = 0; i < nr_e820_entries; i++) {
+		kexec_dprintk("%016llx-%016llx (%d)\n",
+			      params->e820_table[i].addr,
+			      params->e820_table[i].addr + params->e820_table[i].size - 1,
+			      params->e820_table[i].type);
 		if (params->e820_table[i].type != E820_TYPE_RAM)
 			continue;
 		start = params->e820_table[i].addr;
@@ -424,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
+		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -445,7 +450,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		return ERR_PTR(ret);
 	}
 
-	pr_debug("Loaded purgatory at 0x%lx\n", pbuf.mem);
+	kexec_dprintk("Loaded purgatory at 0x%lx\n", pbuf.mem);
 
 
 	/*
@@ -490,8 +495,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	if (ret)
 		goto out_free_params;
 	bootparam_load_addr = kbuf.mem;
-	pr_debug("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
+	kexec_dprintk("Loaded boot_param, command line and misc at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      bootparam_load_addr, kbuf.bufsz, kbuf.bufsz);
 
 	/* Load kernel */
 	kbuf.buffer = kernel + kern16_size;
@@ -505,8 +510,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 		goto out_free_params;
 	kernel_load_addr = kbuf.mem;
 
-	pr_debug("Loaded 64bit kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 kernel_load_addr, kbuf.bufsz, kbuf.memsz);
+	kexec_dprintk("Loaded 64bit kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      kernel_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	/* Load initrd high */
 	if (initrd) {
@@ -520,8 +525,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 			goto out_free_params;
 		initrd_load_addr = kbuf.mem;
 
-		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-				initrd_load_addr, initrd_len, initrd_len);
+		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+			      initrd_load_addr, initrd_len, initrd_len);
 
 		setup_initrd(params, initrd_load_addr, initrd_len);
 	}
-- 
2.41.0

