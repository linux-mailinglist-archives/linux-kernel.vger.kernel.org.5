Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B34788136
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbjHYHrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243278AbjHYHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:47:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A651BD9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:47:42 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 816782127C8A;
        Fri, 25 Aug 2023 00:47:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 816782127C8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692949661;
        bh=Mj+igyGVyULDgQAO2+eawPlRILmtmYnhATNfNhnSKm4=;
        h=From:To:Cc:Subject:Date:From;
        b=TcFxQOMHMlxIYM7UMw2HuATmMyte6gMYWS0xAMF83Hn16rYcSEnq1So/k5ZSNFZld
         hhFuWUP1fQumQcVRa0B4rDeATviUMw4RHRT4R6XEuUjLlefxwggNL/FPro8GAY5y5V
         UkcIWxRi+qpyH+Lm0rUFXmURTsiBNMfnbHgyHFb0=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: [PATCH v2 1/2] x86/of: split x86_dtb_init for early x86_flattree_get_config call
Date:   Fri, 25 Aug 2023 00:47:36 -0700
Message-Id: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fetching the device tree configuration before initmem_init is necessary
to allow the parsing of NUMA node information. However moving entire
x86_dtb_init before initmem_init is not correct as APIC/IO-APIC enumeration
has to be after initmem_init. Thus, split the x86_dtb_init function to
incorporate a call to x86_flattree_get_config before initmem_init, and
leaving the ACPI/IOAPIC registration sequence as is.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]
 - split the x86_dtb_init to call x86_flattree_get_config early

 arch/x86/include/asm/prom.h  | 5 +++++
 arch/x86/kernel/devicetree.c | 6 +-----
 arch/x86/kernel/setup.c      | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index b716d291d0d4..65dee2420624 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -31,6 +31,11 @@ static inline void x86_dtb_init(void) { }
 #define of_ioapic 0
 #endif
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+void x86_flattree_get_config(void);
+#else
+static inline void x86_flattree_get_config(void) { }
+#endif
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 87d38f17ff5c..afd09924094e 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -278,7 +278,7 @@ static void __init dtb_apic_setup(void)
 }
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
-static void __init x86_flattree_get_config(void)
+void __init x86_flattree_get_config(void)
 {
 	u32 size, map_len;
 	void *dt;
@@ -300,14 +300,10 @@ static void __init x86_flattree_get_config(void)
 	unflatten_and_copy_device_tree();
 	early_memunmap(dt, map_len);
 }
-#else
-static inline void x86_flattree_get_config(void) { }
 #endif
 
 void __init x86_dtb_init(void)
 {
-	x86_flattree_get_config();
-
 	if (!of_have_populated_dt())
 		return;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b9145a63da77..ef73704fa27f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1221,6 +1221,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_acpi_boot_init();
 
+	x86_flattree_get_config();
+
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
-- 
2.34.1

