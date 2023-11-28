Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57037FB180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjK1Fpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbjK1FpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045319AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701150308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DkFOYUhEAoDi41UNIQLbbZKM5BkyisGjvMBAr8Dzpp4=;
        b=UC6uMP89GRA20ba+XMVnkkuIej7wHTfZGVKVl/OVfBSytwl5LCtI/7ye4c7Ys0dBY3xLou
        qOwXOaSsssq/U7787h2P5mQP/V/P7EILxeDTM6EeUQod8ZEnTy9PO+3X0mfmjGb/4XmzMv
        i8+VVIxbfYQtt3Ns7jCqfH9DbB/B+eU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-m6uElDqCN9--93qcEkaJNw-1; Tue, 28 Nov 2023 00:45:04 -0500
X-MC-Unique: m6uElDqCN9--93qcEkaJNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1800E185A780;
        Tue, 28 Nov 2023 05:45:04 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8C685028;
        Tue, 28 Nov 2023 05:45:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, ignat@cloudflare.com,
        eric_devolder@yahoo.com, agordeev@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Date:   Tue, 28 Nov 2023 13:44:57 +0800
Message-ID: <20231128054457.659452-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignat Korchagin complained that a potential config regression was
introduced by commit 89cde455915f ("kexec: consolidate kexec and
crash options into kernel/Kconfig.kexec"). Before the commit,
CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=y
as long as CONFIG_CRASH_DUMP=Y which people may not want.

In Ignat's case, he sets CONFIG_CRASH_DUMP=y, CONFIG_KEXEC_FILE=y and
CONFIG_KEXEC=n because kexec_load interface could have security issue if
kernel/initrd has no chance to be signed and verified.

CRASH_DUMP has select of KEXEC because Eric, author of above commit,
met a LKP report of build failure when posting patch of earlier version.
Please see below link to get detail of the LKP report:

    https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.com/T/#u

In fact, that LKP report is triggered because arm's <asm/kexec.h> is
wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
controls the enabling/disabling of kexec_load interface, but not kexec
feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
<asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.
Meanwhile, change arch/arm/kernel/Makefile to let machine_kexec.o
relocate_kernel.o depend on KEXEC_CORE.

Fixes: commit 89cde455915f ("kexec: consolidate kexec and crash options into kernel/Kconfig.kexec")
Reported-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/include/asm/kexec.h | 4 ----
 arch/arm/kernel/Makefile     | 2 +-
 kernel/Kconfig.kexec         | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index e62832dcba76..a8287e7ab9d4 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -2,8 +2,6 @@
 #ifndef _ARM_KEXEC_H
 #define _ARM_KEXEC_H
 
-#ifdef CONFIG_KEXEC
-
 /* Maximum physical address we can use pages from */
 #define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
@@ -82,6 +80,4 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* CONFIG_KEXEC */
-
 #endif /* _ARM_KEXEC_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index d53f56d6f840..771264d4726a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)		+= patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 7aff28ded2f4..1cc3b1c595d7 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -97,7 +97,6 @@ config CRASH_DUMP
 	depends on ARCH_SUPPORTS_KEXEC
 	select CRASH_CORE
 	select KEXEC_CORE
-	select KEXEC
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
-- 
2.41.0

