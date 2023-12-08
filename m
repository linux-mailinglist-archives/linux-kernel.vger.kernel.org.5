Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0665080AA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574520AbjLHRSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjLHRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15119B4;
        Fri,  8 Dec 2023 09:17:30 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eiuzu+kdXHQQeo0yh16f9Iu6ApXODrsdCTQclFbsApY=;
        b=oh0SjXkpYyoKRDqiD3sc56TSeqe29yhprZ4neb8sNGb2/DMH3M2KuxCOMaoNST+aI70FrP
        V6FNVMmpXOh9r6SrH6oytTo7TSlrxtjR45xMYz+VV4Futg//SLuk2Waxq4sKbAPLFd2qFG
        9K10mnOQgFkafnGfVrgjPsKkQAVSoheV3uVWEa6sw6IBbcNMvd9NPZBQlVs8BJhXpsx/Z+
        M5KY7BtSWa6OkQri2PPIV7ZeESN0HD2/6xlBpbqVIoIyrLWo7+X7odylbagkzQahrip/kI
        rUAduJCv8Q1q/iTa9dvmaZUFhoUgF8nfsfYkke/OhO3m53YSz5UO4C47yh9Jiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Eiuzu+kdXHQQeo0yh16f9Iu6ApXODrsdCTQclFbsApY=;
        b=08Wph+eB1eq063sqmljbgkEEngPYi0R198o8sHQF5ti1/IWt0/wKFK5QNkvJlRdE5UW60q
        YZc5hyaZbjtzz3DA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Handle SEAMCALL no entropy error in common code
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirll.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584844.398.11207047321106370195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     1e66a7e275393055d98d2306771fe1feadeb1cd6
Gitweb:        https://git.kernel.org/tip/1e66a7e275393055d98d2306771fe1feadeb1cd6
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:24 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:06 -08:00

x86/virt/tdx: Handle SEAMCALL no entropy error in common code

Some SEAMCALLs use the RDRAND hardware and can fail for the same reasons
as RDRAND.  Use the kernel RDRAND retry logic for them.

There are three __seamcall*() variants.  Do the SEAMCALL retry in common
code and add a wrapper for each of them.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirll.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-4-dave.hansen%40intel.com
---
 arch/x86/include/asm/tdx.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e5dd1cb..24c0357 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -24,6 +24,11 @@
 #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
 #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
 
+/*
+ * TDX module SEAMCALL leaf function error codes
+ */
+#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -84,6 +89,27 @@ u64 __seamcall(u64 fn, struct tdx_module_args *args);
 u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
 u64 __seamcall_saved_ret(u64 fn, struct tdx_module_args *args);
 void tdx_init(void);
+
+#include <asm/archrandom.h>
+
+typedef u64 (*sc_func_t)(u64 fn, struct tdx_module_args *args);
+
+static inline u64 sc_retry(sc_func_t func, u64 fn,
+			   struct tdx_module_args *args)
+{
+	int retry = RDRAND_RETRY_LOOPS;
+	u64 ret;
+
+	do {
+		ret = func(fn, args);
+	} while (ret == TDX_RND_NO_ENTROPY && --retry);
+
+	return ret;
+}
+
+#define seamcall(_fn, _args)		sc_retry(__seamcall, (_fn), (_args))
+#define seamcall_ret(_fn, _args)	sc_retry(__seamcall_ret, (_fn), (_args))
+#define seamcall_saved_ret(_fn, _args)	sc_retry(__seamcall_saved_ret, (_fn), (_args))
 #else
 static inline void tdx_init(void) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
