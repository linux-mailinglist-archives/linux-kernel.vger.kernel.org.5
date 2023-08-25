Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8D5788631
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbjHYLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbjHYLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDC1FF7;
        Fri, 25 Aug 2023 04:43:24 -0700 (PDT)
Date:   Fri, 25 Aug 2023 11:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692963802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FfPtUpd0X5JOPZ4F00k/2tyeNozgYadcVwQROCZOAg=;
        b=G6u37uGVzdcTxgN8oNPx/vtvXjLK+ARPzCcBt8jMV/PBipAq2TkHD3AtXaMuQnC8nuzADI
        v5QBPn+hTe/Gk1i3UiW0fZt0AbAaqFGxYP/kEM6CylH13rzpPdFBUQ+NP5Sh+RZeK37C4T
        IVybFoPrDppmWZn1neq+U7YmItuTtM8OwI80kIoBZJvrlMiFivHPcAm3oGHJcGYAh5SA+Q
        7ZdPyulXHoACr4fVq+9kiCbDLnAcgJ5Xbs9leYdfW7YYWT+z7njNlzSuAjTABinA2zWaEv
        WYdyHWZ+2eBdH6sVYevdwAVcwLseukjBh6mUkrWvMXlT2csGtqw532NFOuaOpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692963802;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FfPtUpd0X5JOPZ4F00k/2tyeNozgYadcVwQROCZOAg=;
        b=tA6QzbmuloJIU71VdM/d1439eMXDSrynKSUh7cRVMlr2GcDBzfsKiYjQHZUCNWAcIJgbek
        7FY+ElFolgxllGBA==
From:   "tip-bot2 for Steve Rutherford" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Make enc_dec_hypercall() accept a size
 instead of npages
Cc:     Steve Rutherford <srutherford@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Ben Hillier <bhillier@google.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230824223731.2055016-1-srutherford@google.com>
References: <20230824223731.2055016-1-srutherford@google.com>
MIME-Version: 1.0
Message-ID: <169296380171.27769.17128376044443888216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2
Gitweb:        https://git.kernel.org/tip/ac3f9c9f1b37edaa7d1a9b908bc79d843955a1a2
Author:        Steve Rutherford <srutherford@google.com>
AuthorDate:    Thu, 24 Aug 2023 15:37:31 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 13:33:48 +02:00

x86/sev: Make enc_dec_hypercall() accept a size instead of npages

enc_dec_hypercall() accepted a page count instead of a size, which
forced its callers to round up. As a result, non-page aligned
vaddrs caused pages to be spuriously marked as decrypted via the
encryption status hypercall, which in turn caused consistent
corruption of pages during live migration. Live migration requires
accurate encryption status information to avoid migrating pages
from the wrong perspective.

Fixes: 064ce6c550a0 ("mm: x86: Invoke hypercall when page encryption status is changed")
Signed-off-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Ben Hillier <bhillier@google.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230824223731.2055016-1-srutherford@google.com
---
 arch/x86/include/asm/mem_encrypt.h |  6 +++---
 arch/x86/kernel/kvm.c              |  4 +---
 arch/x86/mm/mem_encrypt_amd.c      | 13 ++++++-------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 7f97a8a..473b16d 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -50,8 +50,8 @@ void __init sme_enable(struct boot_params *bp);
 
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
-void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
-					    bool enc);
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr,
+					    unsigned long size, bool enc);
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
@@ -85,7 +85,7 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; 
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 static inline void __init
-early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
+early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 1cceac5..526d4da 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -966,10 +966,8 @@ static void __init kvm_init_platform(void)
 		 * Ensure that _bss_decrypted section is marked as decrypted in the
 		 * shared pages list.
 		 */
-		nr_pages = DIV_ROUND_UP(__end_bss_decrypted - __start_bss_decrypted,
-					PAGE_SIZE);
 		early_set_mem_enc_dec_hypercall((unsigned long)__start_bss_decrypted,
-						nr_pages, 0);
+						__end_bss_decrypted - __start_bss_decrypted, 0);
 
 		/*
 		 * If not booted using EFI, enable Live migration support.
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 54bbd51..6faea41 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -288,11 +288,10 @@ static bool amd_enc_cache_flush_required(void)
 	return !cpu_feature_enabled(X86_FEATURE_SME_COHERENT);
 }
 
-static void enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
+static void enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 {
 #ifdef CONFIG_PARAVIRT
-	unsigned long sz = npages << PAGE_SHIFT;
-	unsigned long vaddr_end = vaddr + sz;
+	unsigned long vaddr_end = vaddr + size;
 
 	while (vaddr < vaddr_end) {
 		int psize, pmask, level;
@@ -342,7 +341,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 		snp_set_memory_private(vaddr, npages);
 
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		enc_dec_hypercall(vaddr, npages, enc);
+		enc_dec_hypercall(vaddr, npages << PAGE_SHIFT, enc);
 
 	return true;
 }
@@ -466,7 +465,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	early_set_mem_enc_dec_hypercall(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	early_set_mem_enc_dec_hypercall(start, size, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -482,9 +481,9 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 	return early_set_memory_enc_dec(vaddr, size, true);
 }
 
-void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool enc)
 {
-	enc_dec_hypercall(vaddr, npages, enc);
+	enc_dec_hypercall(vaddr, size, enc);
 }
 
 void __init sme_early_init(void)
