Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2877F6AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 04:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjKXDhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjKXDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 22:37:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BEC1724
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 19:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700797035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF9bfgcu6bElrANFusvIx8X6eyNFwMmAeJtPRaeeIEU=;
        b=AG0L2NjF/8qyRSYxjv6Mm7t2z7FgENItTnpDV8YEXxboTveQQr7rjA4HalxEBtSgM8aLUW
        nwwBxPqYb78IvzMjxfRi6sDbFmewnNBBq8+QL7pIIk3ra6RTd6xQrU+qEDlCfLAs9zLEHj
        AtmZaV8vJaffLhjcAl9JDIbV4FYI7og=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-fIjiuphYN7SH2UI09nZQug-1; Thu,
 23 Nov 2023 22:37:10 -0500
X-MC-Unique: fIjiuphYN7SH2UI09nZQug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E7E81C0434A;
        Fri, 24 Nov 2023 03:37:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F381492BE7;
        Fri, 24 Nov 2023 03:37:05 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, yujie.liu@intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 4/7] kexec_file, arm64: print out debugging message if required
Date:   Fri, 24 Nov 2023 11:36:39 +0800
Message-ID: <20231124033642.520686-5-bhe@redhat.com>
In-Reply-To: <20231124033642.520686-1-bhe@redhat.com>
References: <20231124033642.520686-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

And also remove the kimage->segment[] printing because the generic code
has done the printing.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/kexec_image.c        |  2 +-
 arch/arm64/kernel/machine_kexec.c      | 26 ++++++--------------------
 arch/arm64/kernel/machine_kexec_file.c |  6 +++---
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 636be6715155..df71965178f5 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -122,7 +122,7 @@ static void *image_load(struct kimage *image,
 	kernel_segment->memsz -= text_offset;
 	image->start = kernel_segment->mem;
 
-	pr_debug("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 				kernel_segment->mem, kbuf.bufsz,
 				kernel_segment->memsz);
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 078910db77a4..b38aae5b488d 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -32,26 +32,12 @@
 static void _kexec_image_info(const char *func, int line,
 	const struct kimage *kimage)
 {
-	unsigned long i;
-
-	pr_debug("%s:%d:\n", func, line);
-	pr_debug("  kexec kimage info:\n");
-	pr_debug("    type:        %d\n", kimage->type);
-	pr_debug("    start:       %lx\n", kimage->start);
-	pr_debug("    head:        %lx\n", kimage->head);
-	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
-	pr_debug("    dtb_mem: %pa\n", &kimage->arch.dtb_mem);
-	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
-	pr_debug("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
-
-	for (i = 0; i < kimage->nr_segments; i++) {
-		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
-			i,
-			kimage->segment[i].mem,
-			kimage->segment[i].mem + kimage->segment[i].memsz,
-			kimage->segment[i].memsz,
-			kimage->segment[i].memsz /  PAGE_SIZE);
-	}
+	kexec_dprintk("%s:%d:\n", func, line);
+	kexec_dprintk("  kexec kimage info:\n");
+	kexec_dprintk("    type:        %d\n", kimage->type);
+	kexec_dprintk("    head:        %lx\n", kimage->head);
+	kexec_dprintk("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	kexec_dprintk("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 }
 
 void machine_kexec_cleanup(struct kimage *kimage)
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..9f82401d99f4 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -127,7 +127,7 @@ int load_other_segments(struct kimage *image,
 		image->elf_load_addr = kbuf.mem;
 		image->elf_headers_sz = headers_sz;
 
-		pr_debug("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
@@ -148,7 +148,7 @@ int load_other_segments(struct kimage *image,
 			goto out_err;
 		initrd_load_addr = kbuf.mem;
 
-		pr_debug("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		kexec_dprintk("Loaded initrd at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 				initrd_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
 
@@ -179,7 +179,7 @@ int load_other_segments(struct kimage *image,
 	image->arch.dtb = dtb;
 	image->arch.dtb_mem = kbuf.mem;
 
-	pr_debug("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+	kexec_dprintk("Loaded dtb at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			kbuf.mem, kbuf.bufsz, kbuf.memsz);
 
 	return 0;
-- 
2.41.0

