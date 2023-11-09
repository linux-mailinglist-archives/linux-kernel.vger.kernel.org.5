Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33A7E6A02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjKIL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjKIL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:56:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA1258A;
        Thu,  9 Nov 2023 03:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699531007; x=1731067007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E2LIAFh/IrogizgMIxQnR6vkAoXLaTONKab0ZSp7Cg8=;
  b=XobDRleSa6BBWU7ZjVqJWZkDm+xz8gkpNDrRPNpUD0VWkdG748ImGvwl
   5T2Jbhte55iLEUNMwEmWn64LugRrtf7F2ZUpbNgqjNjzmyCt3PtLIVpct
   PGYLmkHZ9ODDFFqyNJyyRFLyk9K+rMwCo+OZLnHNaCM6TXtcl7Nnrw1m1
   M9g7dIPUxf072drQn0bw16r+2anrwmXRsDgcNpIuXNxJUl14LooXzJNPm
   GntOF6KUQRurUkhmNk50NLni539wSh7y8xy3DrvCuB2G29tZluVelUecB
   jYVcZu3EQ1MEwreENC+sPF4AxF3UA5thBmU7gpoBj7oHNjfLNS0gbKRnl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2936374"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2936374"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766976648"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="766976648"
Received: from shadphix-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.83.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:56:40 -0800
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
Subject: [PATCH v15 05/23] x86/virt/tdx: Handle SEAMCALL no entropy error in common code
Date:   Fri, 10 Nov 2023 00:55:42 +1300
Message-ID: <9565b2ccc347752607039e036fd8d19d78401b53.1699527082.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699527082.git.kai.huang@intel.com>
References: <cover.1699527082.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SEAMCALLs use the RDRAND hardware and can fail for the same reasons
as RDRAND.  Use the kernel RDRAND retry logic for them.

There are three __seamcall*() variants.  Do the SEAMCALL retry in common
code and add a wrapper for each of them.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kirill A. Shutemov <kirll.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

v14 -> v15:
 - Added Sathy's tag.

v13 -> v14:
 - Use real function sc_retry() instead of using macros. (Dave)
 - Added Kirill's tag.

v12 -> v13:
 - New implementation due to TDCALL assembly series.

---
 arch/x86/include/asm/tdx.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ea9a0320b1f8..f1c0c15469f8 100644
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
+
 bool platform_tdx_enabled(void);
 #else
 static inline bool platform_tdx_enabled(void) { return false; }
-- 
2.41.0

