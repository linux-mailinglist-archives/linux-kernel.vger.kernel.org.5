Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8405809D25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjLHHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573291AbjLHHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A91998
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702020670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+lB8OPeQJjgaWARqsUn13We4+TMzElto8Rr7ZVVZCOI=;
        b=ct8tB0rfx2AvLe2iGS4vnedRUp0qzWR5Nk2HoPR16YbrPboUsk3q1BMmR2cCZcd2Y81WgP
        2rn+zpqD70aKwG15PUbj7iQPES+bL+ay1S2eFoF/lPPYP+2Spcy5GO8Gd6Cxt1gL7vXBBO
        Px4eRs91TUJccgeBAE5zEfCJ6zF5NJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362--JrlYu-NMbW6mrd71_ScUw-1; Fri, 08 Dec 2023 02:31:05 -0500
X-MC-Unique: -JrlYu-NMbW6mrd71_ScUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93A4A831004;
        Fri,  8 Dec 2023 07:31:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D43C8CD1;
        Fri,  8 Dec 2023 07:31:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/5] sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
Date:   Fri,  8 Dec 2023 15:30:35 +0800
Message-ID: <20231208073036.7884-5-bhe@redhat.com>
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
dropped, then compiling errors will be triggered if below config
items are set:

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

Here, change the dependency of building kexec_core related object files,
and the ifdeffery on SuperH from CONFIG_KEXEC to CONFIG_KEXEC_CORE.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/sh/include/asm/kexec.h | 4 ++--
 arch/sh/kernel/Makefile     | 2 +-
 arch/sh/kernel/reboot.c     | 4 ++--
 arch/sh/kernel/setup.c      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/kexec.h b/arch/sh/include/asm/kexec.h
index 927d80ba2332..76631714673c 100644
--- a/arch/sh/include/asm/kexec.h
+++ b/arch/sh/include/asm/kexec.h
@@ -28,7 +28,7 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_SH
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 /* arch/sh/kernel/machine_kexec.c */
 void reserve_crashkernel(void);
 
@@ -67,6 +67,6 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 #else
 static inline void reserve_crashkernel(void) { }
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_KEXEC_CORE */
 
 #endif /* __ASM_SH_KEXEC_H */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 69cd9ac4b2ab..2d7e70537de0 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SH_STANDARD_BIOS)	+= sh_bios.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_MODULES)		+= sh_ksyms_32.o module.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index e8eeedc9b182..1de006b1c339 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -63,7 +63,7 @@ struct machine_ops machine_ops = {
 	.shutdown	= native_machine_shutdown,
 	.restart	= native_machine_restart,
 	.halt		= native_machine_halt,
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	.crash_shutdown = native_machine_crash_shutdown,
 #endif
 };
@@ -88,7 +88,7 @@ void machine_halt(void)
 	machine_ops.halt();
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	machine_ops.crash_shutdown(regs);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 3d80515298d2..d3175f09b3aa 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -220,7 +220,7 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 	request_resource(res, &code_resource);
 	request_resource(res, &data_resource);
 	request_resource(res, &bss_resource);
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	request_resource(res, &crashk_res);
 #endif
 
-- 
2.41.0

