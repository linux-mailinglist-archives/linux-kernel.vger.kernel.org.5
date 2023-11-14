Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F77EB3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjKNPdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjKNPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393513A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699976008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqW5rMmhMyyQqUsWMnNu9qdUWQsPZPZ9QZziOkr38Pc=;
        b=YhxDHWmkxXbA7OPdmLYx/wXPo+eutdn0BfFy0BwfLxwjhULoQQloxlwnBCK2XIa/t3odVS
        M+yywjPm2+S5Ct1Z42vj3hOVj2YTEjOc9SnBlDWTeLdY0tnSuZ1pr3GLf5+W2bV25onerz
        3vmV/yo2WrwsQs2/bblhS5XUDhoh34E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-5YGHyBdvMFyk6fY-3gacPg-1; Tue, 14 Nov 2023 10:33:27 -0500
X-MC-Unique: 5YGHyBdvMFyk6fY-3gacPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 482E5858A28;
        Tue, 14 Nov 2023 15:33:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC781C060B0;
        Tue, 14 Nov 2023 15:33:03 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/7] kexec_file: print out debugging message if required
Date:   Tue, 14 Nov 2023 23:32:48 +0800
Message-ID: <20231114153253.241262-3-bhe@redhat.com>
In-Reply-To: <20231114153253.241262-1-bhe@redhat.com>
References: <20231114153253.241262-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
loading related codes.

And also print out type/start/head of kimage and flags to help debug.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c                | 3 ++-
 kernel/kexec_file.c                | 7 ++++++-
 security/integrity/ima/ima_kexec.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..41001ffbaa99 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -551,7 +551,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
+			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
 		phdr++;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 4c35500ae40a..7ae1b0901aa4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -206,6 +206,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret < 0)
 		return ret;
 	image->kernel_buf_len = ret;
+	kexec_dprintk("kernel: %p kernel_size: %#lx\n",
+		      image->kernel_buf, image->kernel_buf_len);
 
 	/* Call arch image probe handlers */
 	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
@@ -389,11 +391,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
 	for (i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
 		ksegment = &image->segment[i];
-		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
+		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
 			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
 			 ksegment->memsz);
 
@@ -408,6 +411,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (ret)
 		goto out;
 
+	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
+		      image->type, image->start, image->head, flags);
 	/*
 	 * Free up any temporary buffers allocated which are not needed
 	 * after image has been loaded
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index ad133fe120db..e692624bcab3 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -129,7 +129,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 	image->ima_buffer_size = kexec_segment_size;
 	image->ima_buffer = kexec_buffer;
 
-	pr_debug("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
+	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
 		 kbuf.mem);
 }
 #endif /* IMA_KEXEC */
-- 
2.41.0

