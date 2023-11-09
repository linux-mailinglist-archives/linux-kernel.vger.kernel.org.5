Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8897E6A04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjKIL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjKIL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:56:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF830E4;
        Thu,  9 Nov 2023 03:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699531014; x=1731067014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j52Wj6lupzqv7odjRLEphY/7WAzNZKlD6Vy50dH6ya0=;
  b=EYc79rgepHqqvu8S2thB5MPCOViArlShYlJtD63yzJDjfIxBAMw1CsWn
   ariofHEOT8raqvMFuxqfShJ96+AeQVFO0FKQdY6PMT842R0h+9qpKK8R4
   BGEHznL/QbaNdhY2nKCm4nzPs21F1tRMbCX7ln8paaGaol/QjrvKOk1y3
   7I/ChaYRuUuZFujuVikkqerFyAI3TAMOeVv8eEK+J6vVDPhAGiU5JqCkf
   3qW6pdweYn10DhgVOnqb0taJGf2nRZnlXhdgYUAbzuE5pNTWx9IaJzpv2
   UV6XoIa/57Wxvfe/pXggxbtXvGGfoi1hMGzE2DkDXMK5zUalXsq0BQeB2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2936405"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2936405"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766976675"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="766976675"
Received: from shadphix-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.83.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:47 -0800
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        tony.luck@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, seanjc@google.com,
        pbonzini@redhat.com, rafael@kernel.org, david@redhat.com,
        dan.j.williams@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, ying.huang@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, nik.borisov@suse.com,
        bagasdotme@gmail.com, sagis@google.com, imammedo@redhat.com,
        kai.huang@intel.com
Subject: [PATCH v15 06/23] x86/virt/tdx: Add SEAMCALL error printing for module initialization
Date:   Fri, 10 Nov 2023 00:55:43 +1300
Message-ID: <3075e45fbb3f4e70c393de5d06ba02ab0774dbed.1699527082.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699527082.git.kai.huang@intel.com>
References: <cover.1699527082.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

v14 -> v15:
 - Remove unneeded seamcall_err_saved_ret() -- Nikolay
 - Added Sathy's tag

v13 -> v14:
 - Use real functions to replace macros. (Dave)
 - Moved printing error message for special error code to the caller
   (internal)
 - Added Kirill's tag

v12 -> v13:
 - New implementation due to TDCALL assembly series.

---
 arch/x86/include/asm/tdx.h  |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f1c0c15469f8..9c35cd4ae0dc 100644
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
index 13d22ea2e2d9..12e519c5c45c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -20,6 +20,49 @@ static u32 tdx_global_keyid __ro_after_init;
 static u32 tdx_guest_keyid_start __ro_after_init;
 static u32 tdx_nr_guest_keyids __ro_after_init;
 
+typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
+
+static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
+{
+	pr_err("SEAMCALL (0x%llx) failed: 0x%llx\n", fn, err);
+}
+
+static inline void seamcall_err_ret(u64 fn, u64 err,
+				    struct tdx_module_args *args)
+{
+	seamcall_err(fn, err, args);
+	pr_err("RCX 0x%llx RDX 0x%llx R8 0x%llx R9 0x%llx R10 0x%llx R11 0x%llx\n",
+			args->rcx, args->rdx, args->r8, args->r9,
+			args->r10, args->r11);
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
 static int __init record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
 {
-- 
2.41.0

