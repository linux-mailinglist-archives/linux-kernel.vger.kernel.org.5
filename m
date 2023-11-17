Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCB7EF4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKQO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:56:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CEA130;
        Fri, 17 Nov 2023 06:56:05 -0800 (PST)
Date:   Fri, 17 Nov 2023 14:56:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700232963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KEHIeQZ3G9vznPEBdGw4NHDfFJdLPaFTS3rqt0y9BFM=;
        b=PU0zCbJ9bg28EjT6y1UqX3TvSBsMCyifjslipAnn0GcSmZTakQaMvfNJIoOwZlXvWj7cE6
        oD729wLdvFZs8K6DefWDsKTEQq2iGgWcgk0SHqVCLcDHHUves2TtCJRFgFtdlEmSYpswLF
        TrSfNvoenWIPKgb63WinOMpegOcYqYiRlC+KFS9oSQT+NZwqcEH1FCRmfAiKb9bsDDZ/LL
        nWqdq/G+7CPGIj5TWDKpvLb6n3IFDTPPoOULcfZPLMHOj6EUR1njCu1xsjRydsc1kRuEfd
        O0VNhqaZIACs14gzta9qGwrTUdtKSzTBhwOLROxJfkNdF904LRxCh0BUngHj0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700232963;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KEHIeQZ3G9vznPEBdGw4NHDfFJdLPaFTS3rqt0y9BFM=;
        b=g/RIa53cWpEFlnoCvob/a4cd6T1MoYZgFdoCHmjsGlLcT1zbWEnaL52W2dLuX1pmr6oWeH
        Fd241nI6JVeAIwBA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use %RIP-relative address in untagged_addr()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradaed.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170023296234.391.6891224487945079423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bc5607d7777423b742f5b0f7a760d074154c613f
Gitweb:        https://git.kernel.org/tip/bc5607d7777423b742f5b0f7a760d074154c613f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 16 Nov 2023 20:10:59 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 17 Nov 2023 06:27:29 -08:00

x86/mm: Use %RIP-relative address in untagged_addr()

%RIP-relative addresses are nowadays correctly handled in alternative
instructions, so remove misleading comment and improve assembly to
use %RIP-relative address.

Also, explicitly using %gs: prefix will segfault for non-SMP builds.
Use macros from percpu.h which will DTRT with segment prefix register
as far as SMP/non-SMP builds are concerned.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20231116191127.3446476-1-ubizjak%40gmail.com
---
 arch/x86/include/asm/uaccess_64.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4..01455c0 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -11,6 +11,7 @@
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
+#include <asm/percpu.h>
 
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -18,14 +19,10 @@
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	/*
-	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
-	 * in alternative instructions. The relocation gets wrong when gets
-	 * copied to the target place.
-	 */
 	asm (ALTERNATIVE("",
-			 "and %%gs:tlbstate_untag_mask, %[addr]\n\t", X86_FEATURE_LAM)
-	     : [addr] "+r" (addr) : "m" (tlbstate_untag_mask));
+			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	     : [addr] "+r" (addr)
+	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 
 	return addr;
 }
