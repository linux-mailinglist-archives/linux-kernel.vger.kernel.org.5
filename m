Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3180037E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377582AbjLAGDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjLAGDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1515193
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701410617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/TeMDmB7LckIZA4USFVQUlo1F06QQ0tuHG6egKrLc10=;
        b=RrlBLpCde+5PinvISKDPEUXeVNJUaxs7ALn3rFE38lXOU0NRGp/flGen/TUnBgA+GyhGOa
        VXaFVVvVOs2CWEZdRg8qjCDacIv59KcJUpmzLQB1936Kmcf242/xzuut0QrjJ6AeJD2GnI
        LpTLOLfavHKDkDVQAEPUfYoiSHaxlPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-d749Q2UvPqiCzf1p7FVvXQ-1; Fri, 01 Dec 2023 01:03:34 -0500
X-MC-Unique: d749Q2UvPqiCzf1p7FVvXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DA7D85A58A;
        Fri,  1 Dec 2023 06:03:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED9E31121307;
        Fri,  1 Dec 2023 06:03:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com, lkp@intel.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] kexec_core: change dependency of object files
Date:   Fri,  1 Dec 2023 14:03:25 +0800
Message-ID: <20231201060325.26940-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

When dropping the select of KEXEC for CRASH_DUMP, compiling error
will be triggered if below config items are set on some architectures.

===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

E.g the building error on loongarch:
---------------------------------------------------------------
loongarch64-linux-ld: kernel/kexec_core.o: in function `.L209':
>> kexec_core.c:(.text+0x1660): undefined reference to `machine_kexec_cleanup'
   loongarch64-linux-ld: kernel/kexec_core.o: in function `.L287':
>> kexec_core.c:(.text+0x1c5c): undefined reference to `machine_crash_shutdown'
>> loongarch64-linux-ld: kexec_core.c:(.text+0x1c64): undefined reference to `machine_kexec'
   loongarch64-linux-ld: kernel/kexec_core.o: in function `.L2^B5':
>> kexec_core.c:(.text+0x2090): undefined reference to `machine_shutdown'
   loongarch64-linux-ld: kexec_core.c:(.text+0x20a0): undefined reference to `machine_kexec'
---------------------------------------------------------------

The reason is that currently in arch/loongarch/kernel/Makefile, building
machine_kexec.o relocate_kernel.o depends on CONFIG_KEXEC. So the
building of the two object files is skipped because CONFIG_KEXEC=n in
that case.

And this situation exists in m68k, mips and sh ARCH too.

Here, changing the dependency of machine_kexec.o relocate_kernel.o to
CONFIG_KEXEC_CORE for all relevant architectures.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311300946.kHE9Iu71-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- V1 only includes fix on loongarch. Add m68k, mips, sh fix in v2 too.

 arch/loongarch/kernel/Makefile | 2 +-
 arch/m68k/kernel/Makefile      | 2 +-
 arch/mips/kernel/Makefile      | 2 +-
 arch/sh/kernel/Makefile        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 4fcc168f0732..3c808c680370 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index 01fb69a5095f..f335bf3268a1 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_PCI) += pcibios.o
 
 obj-$(CONFIG_M68K_NONCOHERENT_DMA) += dma.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_BOOTINFO_PROC)	+= bootinfo_proc.o
 obj-$(CONFIG_UBOOT)		+= uboot.o
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 853a43ee4b44..ecf3278a32f7 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -90,7 +90,7 @@ obj-$(CONFIG_GPIO_TXX9)		+= gpio_txx9.o
 
 obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_EARLY_PRINTK_8250)	+= early_printk_8250.o
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
-- 
2.41.0

