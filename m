Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3A7E4337
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjKGPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjKGPRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:17:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79D59FD;
        Tue,  7 Nov 2023 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369317; x=1730905317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihUJVqxWKTzFAcLxrV10LihTCMy9+BG/T/LMnYYkxvA=;
  b=NJCeW0HZxYMhbZpuS99jbKGZ+9opOw1kxNrrriUWwd8rQvwc26JZJ7SP
   /sqHuVu50s7eo92snr9BsRAKktGTWCh/6gE2vftB+ZibLBdmlWjCazEx2
   VulteZVPPOvvFv98MRwQmOtqEMdRw+RBX1nGv9tMm9W2gIeabdUJVRuIx
   rhNNxtj8hEOaBSqrJ6jsiTZH2MYWDDrg25seVpP49iGipCJTMzjd5Cm4n
   YZXTMUYtldKBptHzkg79P+DjBVXqAlI9EldQkumz//p7v5IEhCvKEkLng
   QqZ8Ssbt236SrZOuz4VBJJ7ipHmgv3AgUv3gwS/NW9w0xCTxnbtIvgxo7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462555"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462555"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851542"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:23 -0800
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
Subject: [PATCH v17 084/116] KVM: TDX: handle EXIT_REASON_OTHER_SMI
Date:   Tue,  7 Nov 2023 06:56:50 -0800
Message-Id: <39eb8e437574969aa080e4eca682d31cbda0cda9.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

If the control reaches EXIT_REASON_OTHER_SMI, #SMI is delivered and
handled right after returning from the TDX module to KVM nothing needs to
be done in KVM.  Continue TDX vcpu execution.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/vmx.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index a5faf6d88f1b..b3a30ef3efdd 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -34,6 +34,7 @@
 #define EXIT_REASON_TRIPLE_FAULT        2
 #define EXIT_REASON_INIT_SIGNAL			3
 #define EXIT_REASON_SIPI_SIGNAL         4
+#define EXIT_REASON_OTHER_SMI           6
 
 #define EXIT_REASON_INTERRUPT_WINDOW    7
 #define EXIT_REASON_NMI_WINDOW          8
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 64570cedfd9a..bfa6c5e925aa 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1321,6 +1321,13 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	WARN_ON_ONCE(fastpath != EXIT_FASTPATH_NONE);
 
 	switch (exit_reason.basic) {
+	case EXIT_REASON_OTHER_SMI:
+		/*
+		 * If reach here, it's not a Machine Check System Management
+		 * Interrupt(MSMI).  #SMI is delivered and handled right after
+		 * SEAMRET, nothing needs to be done in KVM.
+		 */
+		return 1;
 	default:
 		break;
 	}
-- 
2.25.1

