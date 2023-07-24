Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004E97602EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGXXEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjGXXDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:03:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D910F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690239834; x=1721775834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EE3wLlgMjMJ6tNmR3nPj7f0Ul8eVVgw5R+jSgXC8ftk=;
  b=KWbx6t8AWA/wa492xZIOlXYErL6an+4xLq7VgYQ4Z/p0QV4ap41xYCVM
   5q8nASdIQoHDEKHZGt2wokr+Av8MRlIvPgCWzciT+fMxIU5ie7iOnBkKo
   v4bu70kq5Ov4JLUwlaCtPgsN9BeR+CrLt7d5derpAaL46vdrqpdcSre8e
   bAjjB+lFVBZpINJsJdKdt24Qbk2oPl6uEfLdie22kATuaTxisjQu13M0u
   r5Y4gTWl0fAs7FAP3Dma2YvM1kaMQNrSIeozjFZBfHL2OJ2i/OFT7rX2V
   OzKwyNBOwiAyUxdewVTeeBlqKiq8h6dtxW9qnHqr1XrbdNeTjVZhGTCwf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431368040"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="431368040"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 16:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839632269"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="839632269"
Received: from asmaaabd-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 16:03:51 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7BC5B103A25; Tue, 25 Jul 2023 02:03:48 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     x86@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory
Date:   Tue, 25 Jul 2023 02:03:29 +0300
Message-ID: <20230724230329.3970-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c4e34dd99f2e ("x86: simplify load_unaligned_zeropad()
implementation") changes how exceptions around load_unaligned_zeropad()
handled. Kernel now relies on fault_address in fixup_exception() to
detect that the exception happened due to load_unaligned_zeropad().

It works fine for #PF, but breaks on #VE since no fault address is
passed down to fixup_exception().

Propagating ve_info.gla down to fixup_exception() resolves the issue.

See commit 1e7769653b06 ("x86/tdx: Handle load_unaligned_zeropad()
page-cross to a shared page") for more context.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Michael Kelley <mikelley@microsoft.com>
Fixes: c4e34dd99f2e ("x86: simplify load_unaligned_zeropad() implementation")
---
 arch/x86/kernel/traps.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..4a817d20ce3b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -697,9 +697,10 @@ static bool try_fixup_enqcmd_gp(void)
 }
 
 static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
-				    unsigned long error_code, const char *str)
+				    unsigned long error_code, const char *str,
+				    unsigned long address)
 {
-	if (fixup_exception(regs, trapnr, error_code, 0))
+	if (fixup_exception(regs, trapnr, error_code, address))
 		return true;
 
 	current->thread.error_code = error_code;
@@ -759,7 +760,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		goto exit;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
 		goto exit;
 
 	if (error_code)
@@ -1357,17 +1358,20 @@ DEFINE_IDTENTRY(exc_device_not_available)
 
 #define VE_FAULT_STR "VE fault"
 
-static void ve_raise_fault(struct pt_regs *regs, long error_code)
+static void ve_raise_fault(struct pt_regs *regs, long error_code,
+			   unsigned long address)
 {
 	if (user_mode(regs)) {
 		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
 		return;
 	}
 
-	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
+	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code,
+				    VE_FAULT_STR, address)) {
 		return;
+	}
 
-	die_addr(VE_FAULT_STR, regs, error_code, 0);
+	die_addr(VE_FAULT_STR, regs, error_code, address);
 }
 
 /*
@@ -1431,7 +1435,7 @@ DEFINE_IDTENTRY(exc_virtualization_exception)
 	 * it successfully, treat it as #GP(0) and handle it.
 	 */
 	if (!tdx_handle_virt_exception(regs, &ve))
-		ve_raise_fault(regs, 0);
+		ve_raise_fault(regs, 0, ve.gla);
 
 	cond_local_irq_disable(regs);
 }
-- 
2.41.0

