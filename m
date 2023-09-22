Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDE7AAC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjIVIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjIVIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:13:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B9310CE;
        Fri, 22 Sep 2023 01:12:55 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695370374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1bPKF4uXOWTIoSsqQJPw+pS2Gpmo355eDwJrUxOtjwg=;
        b=xhk+63Cch3cU+uADvC7IlKAW251DYefsBjQKhB36n+0f+s9hGNNL8CJ8PZAsuAyXG79kvS
        PBgqDAtVuPyuLvshILyqxY4+nauqbn76tvuy8BR9Xut7VdIaURnAvcsBpccLCd6FVa7+eI
        TybtSMBNNDTYAjt7dm3/ep/3WFTtlFSC6RXjygdKX3DK1fmTDNJtv7St12frs8pXtjHd+X
        nN0GhK5D9rCxaLjGSMxgKhD8dEnuxRRD3g9v+lju4tvz8mUshzK/atXlrIFtvcc4InucZz
        Eb93rkDKfS7kIvZEmdpz9sYfRTu93Vlr9j5fOYZBGrP2qwZSdg85sK92vtl27g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695370374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1bPKF4uXOWTIoSsqQJPw+pS2Gpmo355eDwJrUxOtjwg=;
        b=ze/9UF+wpgyZYw2ONIWYn5fw3d5ljqxSZyOkg7xFD8WJEhE6qu8VEY+zntInDYMve+HdNQ
        c0711NAZvSCtjeBA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Move arch_memory_failure() and
 arch_is_platform_page() definitions from <asm/processor.h> to <asm/pgtable.h>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <169537037363.27769.8863382611473061727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d73a105586434ca919a1a487a467e5664f9300c4
Gitweb:        https://git.kernel.org/tip/d73a105586434ca919a1a487a467e5664f9300c4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 22 Sep 2023 09:29:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 09:32:03 +02:00

x86/mm: Move arch_memory_failure() and arch_is_platform_page() definitions from <asm/processor.h> to <asm/pgtable.h>

<linux/mm.h> relies on these definitions being included first,
which is true currently due to historic header spaghetti,
but in the future <asm/processor.h> will not guaranteed to be
included by the MM code.

Move these definitions over into a suitable MM header.

This is a preparatory patch for x86 header dependency simplifications
and reductions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/pgtable.h   | 8 ++++++++
 arch/x86/include/asm/processor.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d6ad98c..1e12e61 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1708,6 +1708,14 @@ static inline bool pud_user_accessible_page(pud_t pud)
 }
 #endif
 
+#ifdef CONFIG_X86_SGX
+int arch_memory_failure(unsigned long pfn, int flags);
+#define arch_memory_failure arch_memory_failure
+
+bool arch_is_platform_page(u64 paddr);
+#define arch_is_platform_page arch_is_platform_page
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920..1b2b138 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -726,14 +726,6 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
-#ifdef CONFIG_X86_SGX
-int arch_memory_failure(unsigned long pfn, int flags);
-#define arch_memory_failure arch_memory_failure
-
-bool arch_is_platform_page(u64 paddr);
-#define arch_is_platform_page arch_is_platform_page
-#endif
-
 extern bool gds_ucode_mitigated(void);
 
 #endif /* _ASM_X86_PROCESSOR_H */
