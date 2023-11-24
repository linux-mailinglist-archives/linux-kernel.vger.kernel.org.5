Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A17F6AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjKXDh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjKXDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF2172B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700797039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kkmRVng/H+5xvIfC3pnGSESqdAmeGP3BqYdDpZBh2K4=;
        b=P0JCGSKQxHOum2own8n5BYqM85zHHDQ5aDgyBJMeh3iiFc1ITuq+aEyyc+dbIJcdtNNcDu
        Sf3xlwv6b58XHAdGfI/8SnZMDAtaSZiIU9mJmrrI/13pDQTvvp2hknx9xA6A+zwvLWyCnW
        sGhl8mNyPPlao7/JD3l/vCi3kQHCGzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Xw2wknElN-CG8sxYL3DIWg-1; Thu, 23 Nov 2023 22:37:16 -0500
X-MC-Unique: Xw2wknElN-CG8sxYL3DIWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754F1101A529;
        Fri, 24 Nov 2023 03:37:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E47492BE7;
        Fri, 24 Nov 2023 03:37:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, yujie.liu@intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 5/7] kexec_file, ricv: print out debugging message if required
Date:   Fri, 24 Nov 2023 11:36:40 +0800
Message-ID: <20231124033642.520686-6-bhe@redhat.com>
In-Reply-To: <20231124033642.520686-1-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

And also remove kexec_image_info() because the content has been printed
out in generic code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/kernel/elf_kexec.c     |  9 +++++----
 arch/riscv/kernel/machine_kexec.c | 26 --------------------------
 2 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index e60fbd8660c4..20d941e91b5e 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -216,7 +216,6 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	if (ret)
 		goto out;
 	kernel_start = image->start;
-	pr_notice("The entry point of kernel at 0x%lx\n", image->start);
 
 	/* Add the kernel binary to the image */
 	ret = riscv_kexec_elf_load(image, &ehdr, &elf_info,
@@ -252,7 +251,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		image->elf_load_addr = kbuf.mem;
 		image->elf_headers_sz = headers_sz;
 
-		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 		/* Setup cmdline for kdump kernel case */
@@ -275,6 +274,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		pr_err("Error loading purgatory ret=%d\n", ret);
 		goto out;
 	}
+	kexec_dprintk("Loaded purgatory at 0x%lx\n", kbuf.mem);
+
 	ret = kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry",
 					     &kernel_start,
 					     sizeof(kernel_start), 0);
@@ -293,7 +294,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 		if (ret)
 			goto out;
 		initrd_pbase = kbuf.mem;
-		pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
+		kexec_dprintk("Loaded initrd at 0x%lx\n", initrd_pbase);
 	}
 
 	/* Add the DTB to the image */
@@ -318,7 +319,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 	}
 	/* Cache the fdt buffer address for memory cleanup */
 	image->arch.fdt = fdt;
-	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
+	kexec_dprintk("Loaded device tree at 0x%lx\n", kbuf.mem);
 	goto out;
 
 out_free_fdt:
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2d139b724bc8..ed9cad20c039 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -18,30 +18,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
-/*
- * kexec_image_info - Print received image details
- */
-static void
-kexec_image_info(const struct kimage *image)
-{
-	unsigned long i;
-
-	pr_debug("Kexec image info:\n");
-	pr_debug("\ttype:        %d\n", image->type);
-	pr_debug("\tstart:       %lx\n", image->start);
-	pr_debug("\thead:        %lx\n", image->head);
-	pr_debug("\tnr_segments: %lu\n", image->nr_segments);
-
-	for (i = 0; i < image->nr_segments; i++) {
-		pr_debug("\t    segment[%lu]: %016lx - %016lx", i,
-			image->segment[i].mem,
-			image->segment[i].mem + image->segment[i].memsz);
-		pr_debug("\t\t0x%lx bytes, %lu pages\n",
-			(unsigned long) image->segment[i].memsz,
-			(unsigned long) image->segment[i].memsz /  PAGE_SIZE);
-	}
-}
-
 /*
  * machine_kexec_prepare - Initialize kexec
  *
@@ -60,8 +36,6 @@ machine_kexec_prepare(struct kimage *image)
 	unsigned int control_code_buffer_sz = 0;
 	int i = 0;
 
-	kexec_image_info(image);
-
 	/* Find the Flattened Device Tree and save its physical address */
 	for (i = 0; i < image->nr_segments; i++) {
 		if (image->segment[i].memsz <= sizeof(fdt))
-- 
2.41.0

