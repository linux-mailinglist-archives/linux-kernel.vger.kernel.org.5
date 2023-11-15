Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EF7EC2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbjKOMvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84B11C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700052675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ehFjwhsPPcv7nimSjR09jzg4Dqe1DEZTTTAxghtYd8o=;
        b=Bbx7OUieKyLhEbhg8f/de496HWsERiEdaT/xSroutd79BNgLmrtUdInZAZwKopz82ZGCH+
        T7aIvJV8lnSKPeJwshbok2E6AT9oaPJNbCrQ0VCxtNheaq78YvLZnHy3RNTjURQg4yYQoC
        xLRzSkVvzkBTK9RJK6g7llQD89VSqa8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-LR_rUWiCNDKtUhiOdXXDbA-1; Wed,
 15 Nov 2023 07:51:13 -0500
X-MC-Unique: LR_rUWiCNDKtUhiOdXXDbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AB1C1C068CA;
        Wed, 15 Nov 2023 12:51:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5CD41121307;
        Wed, 15 Nov 2023 12:51:09 +0000 (UTC)
Date:   Wed, 15 Nov 2023 20:51:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 1/7] kexec_file: add kexec_file flag to control debug
 printing
Message-ID: <ZVS+usu5jCveUIiv@MiWiFi-R3L-srv>
References: <20231114153253.241262-1-bhe@redhat.com>
 <20231114153253.241262-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114153253.241262-2-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

When specifying 'kexec -c -d', kexec_load interface will print loading
information, e.g the regions where kernel/initrd/purgatory/cmdline
are put, the memmap passed to 2nd kernel taken as system RAM ranges,
and printing all contents of struct kexec_segment, etc. These are
very helpful for analyzing or positioning what's happening when
kexec/kdump itself failed. The debugging printing for kexec_load
interface is made in user space utility kexec-tools.

Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
Because kexec_file code is mostly implemented in kernel space, and the
debugging printing functionality is missed. It's not convenient when
debugging kexec/kdump loading and jumping with kexec_file_load
interface.

Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
message printing. And add global variable kexec_file_dbg_print and
macro kexec_dprintk() to facilitate the printing.

This is a preparation, later kexec_dprintk() will be used to replace the
existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
kexec/kdump loading information at KERN_INFO level. If '-d' is not
specified, it regresses to print message at KERN_DEBUG level.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- Rewrite the kexec_dprintk() macro as Joe suggested to reduce kernel
  text size.

 include/linux/kexec.h      | 10 +++++++++-
 include/uapi/linux/kexec.h |  1 +
 kernel/kexec_file.c        |  5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8227455192b7..66997efe36f1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -264,6 +264,14 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
 	return -ENOEXEC;
 }
 #endif
+
+extern bool kexec_file_dbg_print;
+
+#define kexec_dprintk(fmt, ...)					\
+	printk("%s" fmt,					\
+	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
+	       ##__VA_ARGS__)
+
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
@@ -403,7 +411,7 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 01766dd839b0..c17bb096ea68 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -25,6 +25,7 @@
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_DEBUG	0x00000008
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..4c35500ae40a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -38,6 +38,8 @@ void set_kexec_sig_enforced(void)
 }
 #endif
 
+bool kexec_file_dbg_print;
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /* Maximum size in bytes for kernel/initrd files. */
@@ -123,6 +125,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	 */
 	kfree(image->image_loader_data);
 	image->image_loader_data = NULL;
+
+	kexec_file_dbg_print = false;
 }
 
 #ifdef CONFIG_KEXEC_SIG
@@ -278,6 +282,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	if (!image)
 		return -ENOMEM;
 
+	kexec_file_dbg_print = !!(flags & KEXEC_FILE_DEBUG);
 	image->file_mode = 1;
 
 	if (kexec_on_panic) {
-- 
2.41.0

