Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF30180AA84
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjLHRSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjLHRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0919B1;
        Fri,  8 Dec 2023 09:17:30 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9LECQYRaoajueYiL8r27FFdNIwCTLyQSJjrD0Rjlm9Q=;
        b=SqndClhG9PQQaw5Pwtq6EO3FXYnPh2dOKnumbWq7td/e9xDhmSNW8o08Gz+dNiSZAlAEyp
        FB8SvycxT1cz6e4aDscaypoOegtMsDS+eppdxIMS16HO4BYPKdSNg2Wp1EKPRNmCjHL/0f
        m6ukgjbcZp10vP08lQ56dDAYyHFOvMrsPIlNdPKAqJeWn7paJ0JhUSnCwJHG54WHVsq1OV
        +uqsN5GBHt84DuohPPt/2fCFtuX11m2hHgymK3eTrtiPhmGL0q+EyAi/wgmkfJXvWONiWk
        HTIT2T2QGcvsQ3XZDLASP3jrjJpY6XYLQK7YteOGlq9aMRnIrnKx3kauTboMtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9LECQYRaoajueYiL8r27FFdNIwCTLyQSJjrD0Rjlm9Q=;
        b=cz6l8qD2Q37g6oGWrwtIYKIlps0nW4s2CWN3Z4waWnwEj1z2OaDBMfvGU3Kv8nYetrhdhi
        WV9YefFTktX6jfBQ==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Add SEAMCALL error printing for module
 initialization
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584772.398.2888327908513033283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     df01f5ae07dd9ca0c755943a5cfcc4e78e480f99
Gitweb:        https://git.kernel.org/tip/df01f5ae07dd9ca0c755943a5cfcc4e78e480f99
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:25 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:08 -08:00

x86/virt/tdx: Add SEAMCALL error printing for module initialization

The SEAMCALLs involved during the TDX module initialization are not
expected to fail.  In fact, they are not expected to return any non-zero
code (except the "running out of entropy error", which can be handled
internally already).

Add yet another set of SEAMCALL wrappers, which treats all non-zero
return code as error, to support printing SEAMCALL error upon failure
for module initialization.  Note the TDX module initialization doesn't
use the _saved_ret() variant thus no wrapper is added for it.

SEAMCALL assembly can also return kernel-defined error codes for three
special cases: 1) TDX isn't enabled by the BIOS; 2) TDX module isn't
loaded; 3) CPU isn't in VMX operation.  Whether they can legally happen
depends on the caller, so leave to the caller to print error message
when desired.

Also convert the SEAMCALL error codes to the kernel error codes in the
new wrappers so that each SEAMCALL caller doesn't have to repeat the
conversion.

[ dhansen: Align the register dump with show_regs().  Zero-pad the
	   contents, split on two lines and use consistent spacing. ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-5-dave.hansen%40intel.com
---
 arch/x86/include/asm/tdx.h  |  1 +-
 arch/x86/virt/vmx/tdx/tdx.c | 44 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 24c0357..2c0f416 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -27,6 +27,7 @@
 /*
  * TDX module SEAMCALL leaf function error codes
  */
+#define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 94689ae..262b9b6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -21,6 +21,50 @@ static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
 
+typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
+
+static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
+{
+	pr_err("SEAMCALL (0x%016llx) failed: 0x%016llx\n", fn, err);
+}
+
+static inline void seamcall_err_ret(u64 fn, u64 err,
+				    struct tdx_module_args *args)
+{
+	seamcall_err(fn, err, args);
+	pr_err("RCX 0x%016llx RDX 0x%016llx R08 0x%016llx\n",
+			args->rcx, args->rdx, args->r8);
+	pr_err("R09 0x%016llx R10 0x%016llx R11 0x%016llx\n",
+			args->r9, args->r10, args->r11);
+}
+
+static inline int sc_retry_prerr(sc_func_t func, sc_err_func_t err_func,
+				 u64 fn, struct tdx_module_args *args)
+{
+	u64 sret = sc_retry(func, fn, args);
+
+	if (sret == TDX_SUCCESS)
+		return 0;
+
+	if (sret == TDX_SEAMCALL_VMFAILINVALID)
+		return -ENODEV;
+
+	if (sret == TDX_SEAMCALL_GP)
+		return -EOPNOTSUPP;
+
+	if (sret == TDX_SEAMCALL_UD)
+		return -EACCES;
+
+	err_func(fn, sret, args);
+	return -EIO;
+}
+
+#define seamcall_prerr(__fn, __args)						\
+	sc_retry_prerr(__seamcall, seamcall_err, (__fn), (__args))
+
+#define seamcall_prerr_ret(__fn, __args)					\
+	sc_retry_prerr(__seamcall_ret, seamcall_err_ret, (__fn), (__args))
+
 static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
 {
