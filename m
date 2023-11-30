Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F97FE728
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjK3ClI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjK3Ckx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:40:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC91170B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701312040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8a+ellwCh/3V8BzkRuEVvsJ+8hxsTW4N92KLuW+8EyQ=;
        b=fdUcIIsFx8v+GW6QTbX5RSksDYfj6MCi8Vpfav/JFU6QOhIUgdLhHdbgqE1/GzPjj+mbmj
        /CzKeg0CMYcMjfYBT5QxdSQ782L5lWPv22x4foEVq+b0SxJP2ASClSMKfx4fUGd0a9XqUZ
        AR2vLz28IImRkxhDjxaxFT3qYZ5yhW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-xuchx3FxNBWjFxjNJEU3Uw-1; Wed, 29 Nov 2023 21:40:35 -0500
X-MC-Unique: xuchx3FxNBWjFxjNJEU3Uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2D01185A783;
        Thu, 30 Nov 2023 02:40:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 963822026D4C;
        Thu, 30 Nov 2023 02:40:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        joe@perches.com, nathan@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 7/7] kexec_file, parisc: print out debugging message if required
Date:   Thu, 30 Nov 2023 10:39:55 +0800
Message-ID: <20231130023955.5257-8-bhe@redhat.com>
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
 arch/parisc/kernel/kexec_file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/kexec_file.c b/arch/parisc/kernel/kexec_file.c
index 8c534204f0fd..3fc82130b6c3 100644
--- a/arch/parisc/kernel/kexec_file.c
+++ b/arch/parisc/kernel/kexec_file.c
@@ -38,8 +38,8 @@ static void *elf_load(struct kimage *image, char *kernel_buf,
 	for (i = 0; i < image->nr_segments; i++)
 		image->segment[i].mem = __pa(image->segment[i].mem);
 
-	pr_debug("Loaded the kernel at 0x%lx, entry at 0x%lx\n",
-		 kernel_load_addr, image->start);
+	kexec_dprintk("Loaded the kernel at 0x%lx, entry at 0x%lx\n",
+		      kernel_load_addr, image->start);
 
 	if (initrd != NULL) {
 		kbuf.buffer = initrd;
@@ -51,7 +51,7 @@ static void *elf_load(struct kimage *image, char *kernel_buf,
 		if (ret)
 			goto out;
 
-		pr_debug("Loaded initrd at 0x%lx\n", kbuf.mem);
+		kexec_dprintk("Loaded initrd at 0x%lx\n", kbuf.mem);
 		image->arch.initrd_start = kbuf.mem;
 		image->arch.initrd_end = kbuf.mem + initrd_len;
 	}
@@ -68,7 +68,7 @@ static void *elf_load(struct kimage *image, char *kernel_buf,
 		if (ret)
 			goto out;
 
-		pr_debug("Loaded cmdline at 0x%lx\n", kbuf.mem);
+		kexec_dprintk("Loaded cmdline at 0x%lx\n", kbuf.mem);
 		image->arch.cmdline = kbuf.mem;
 	}
 out:
-- 
2.41.0

