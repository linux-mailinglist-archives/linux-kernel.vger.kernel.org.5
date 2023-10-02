Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6067B5B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjJBTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbjJBTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:41:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A24B3;
        Mon,  2 Oct 2023 12:41:05 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:41:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696275664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqlF5EVuQLFpWE0VicqrDur8NnlddH+WVSgjgHI93gQ=;
        b=d1lSSuBT56yRLNBYTUXGs5riRDUOw4o+gByfhuHKyHRVKdXH9TgWm5LC2aY0Pl/h1zy4wB
        6FLhzbn9+VJQ2hyQKqrWVRy6vSSFJyyh0Z92+sQAx0yuAJQln3dOnPWWUSl40KDZJzdmYU
        Q7wugn2Kwyk0UxllSY169AUzA43v2jJtDNEc873IeUU1RxpjlvZYOt+Yhz4Ig9o9Twv5YT
        QO2TZDx2lGDAG1zD2iFYBomKr4NloiFTprEePRd6d3O1uPQdbSZ4h2Sq19Nhy2t08bWgFZ
        +DKihTSMhal84GFhFqshTn562WdzcO37KCPvMbMcW9Khc/oXEu5GuBlYg3qesQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696275664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqlF5EVuQLFpWE0VicqrDur8NnlddH+WVSgjgHI93gQ=;
        b=8yVNKGn6AKcvR1BdzXfoIzQOrkHakU2C0FzQCXD74Z7OAQ1AmrAWH8Ls4KQ2JOEw/sM2uV
        BOxmNnK8VsWhYbAw==
From:   "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/of: Move the x86_flattree_get_config() call
 out of x86_dtb_init()
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
References: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Message-ID: <169627566397.3135.7322755812726837535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0d294c8c4efa5c0f283a6dfc82dc014a5dbd9308
Gitweb:        https://git.kernel.org/tip/0d294c8c4efa5c0f283a6dfc82dc014a5dbd9308
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Fri, 25 Aug 2023 00:47:36 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 21:30:09 +02:00

x86/of: Move the x86_flattree_get_config() call out of x86_dtb_init()

Fetching the device tree configuration before initmem_init() is necessary
to allow the parsing of NUMA node information. However moving the entire
x86_dtb_init() call before initmem_init() is not correct as APIC/IO-APIC enumeration
has to be after initmem_init().

Thus, move the x86_flattree_get_config() call out of x86_dtb_init(),
into setup_arch(), to call it before initmem_init(), and
leave the ACPI/IOAPIC registration sequence as-is.

[ mingo: Updated the changelog for clarity. ]

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/include/asm/prom.h  | 5 +++++
 arch/x86/kernel/devicetree.c | 6 +-----
 arch/x86/kernel/setup.c      | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index b716d29..65dee24 100644
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
index 87d38f1..afd0992 100644
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
index b9145a6..ef73704 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1221,6 +1221,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_acpi_boot_init();
 
+	x86_flattree_get_config();
+
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
