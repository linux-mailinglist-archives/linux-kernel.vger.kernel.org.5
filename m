Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9887E4243
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjKGO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjKGO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:57:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC1D7A;
        Tue,  7 Nov 2023 06:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369070; x=1730905070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLgUmjmBLc3J6I9Eg/cKgAU8/9ugkH9ESWoL90woQ1s=;
  b=PaoNax7s6zPkyYU0WFPWnwuQVGIgXc1onZr0x5lHRASY2MCZGZ9u0Ktp
   V12RIWGOe3MuGRedDIaZrtsgw8UzMPFZrmvQ7va+iYMZV4GZNrRFPdoR3
   dmb60tnKosAJYD5FA/Frns6ay5Pf0c/UOdt6IY4eGzZCRWcMqIZM9GQ1G
   bxvoAKxhcc5hf5crbIxjG1BjccTrxt0SxONQkiay8jMBUakBxZaleFunF
   NRKsUbXXuPzmQ6EuCcoHMqTLndnt2UkwL36+1oVaALK0up1QHevyqeUvy
   c38EeFaTtaxAbPOYR940gWJEsdu6qnxgwSqwN+ioRMy7QmuuQXiUlw/Jc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374555728"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374555728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10444001"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:47 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
Subject: [PATCH v17 012/116] KVM: TDX: Retry SEAMCALL on the lack of entropy error
Date:   Tue,  7 Nov 2023 06:55:38 -0800
Message-Id: <a67c877521a6913911bd569c38c772ade6a1403b.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Some SEAMCALL may return TDX_RND_NO_ENTROPY error when the entropy is
lacking.  Retry SEAMCALL on the error following rdrand_long() to retry
RDRAND_RETRY_LOOPS times.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/tdx_errno.h |  1 +
 arch/x86/kvm/vmx/tdx_ops.h   | 40 +++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/kvm/vmx/tdx_errno.h
index 7f96696b8e7c..bb093e292fef 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/kvm/vmx/tdx_errno.h
@@ -14,6 +14,7 @@
 #define TDX_OPERAND_INVALID			0xC000010000000000ULL
 #define TDX_OPERAND_BUSY			0x8000020000000000ULL
 #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
+#define TDX_RND_NO_ENTROPY			0x8000020300000000ULL
 #define TDX_VCPU_NOT_ASSOCIATED			0x8000070200000000ULL
 #define TDX_KEY_GENERATION_FAILED		0x8000080000000000ULL
 #define TDX_KEY_STATE_INCORRECT			0xC000081100000000ULL
diff --git a/arch/x86/kvm/vmx/tdx_ops.h b/arch/x86/kvm/vmx/tdx_ops.h
index 12fd6b8d49e0..a55977626ae3 100644
--- a/arch/x86/kvm/vmx/tdx_ops.h
+++ b/arch/x86/kvm/vmx/tdx_ops.h
@@ -6,6 +6,7 @@
 
 #include <linux/compiler.h>
 
+#include <asm/archrandom.h>
 #include <asm/cacheflush.h>
 #include <asm/asm.h>
 #include <asm/kvm_host.h>
@@ -17,25 +18,30 @@
 static inline u64 tdx_seamcall(u64 op, u64 rcx, u64 rdx, u64 r8, u64 r9,
 			       struct tdx_module_args *out)
 {
+	int retry;
 	u64 ret;
 
-	if (out) {
-		*out = (struct tdx_module_args) {
-			.rcx = rcx,
-			.rdx = rdx,
-			.r8 = r8,
-			.r9 = r9,
-		};
-		ret = __seamcall_ret(op, out);
-	} else {
-		struct tdx_module_args args = {
-			.rcx = rcx,
-			.rdx = rdx,
-			.r8 = r8,
-			.r9 = r9,
-		};
-		ret = __seamcall(op, &args);
-	}
+	/* Mimic the existing rdrand_long() to retry RDRAND_RETRY_LOOPS times. */
+	retry = RDRAND_RETRY_LOOPS;
+	do {
+		if (out) {
+			*out = (struct tdx_module_args) {
+				.rcx = rcx,
+				.rdx = rdx,
+				.r8 = r8,
+				.r9 = r9,
+			};
+			ret = __seamcall_ret(op, out);
+		} else {
+			struct tdx_module_args args = {
+				.rcx = rcx,
+				.rdx = rdx,
+				.r8 = r8,
+				.r9 = r9,
+			};
+			ret = __seamcall(op, &args);
+		}
+	} while (unlikely(ret == TDX_RND_NO_ENTROPY) && --retry);
 	if (unlikely(ret == TDX_SEAMCALL_UD)) {
 		/*
 		 * SEAMCALLs fail with TDX_SEAMCALL_UD returned when VMX is off.
-- 
2.25.1

