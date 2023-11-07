Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7407E4302
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjKGPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjKGPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:12:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01B268F;
        Tue,  7 Nov 2023 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369149; x=1730905149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8RiGxxFbNSJhzHxCNwUp87RyBuZB46rcBhwPrqRZK8=;
  b=Q9inc3VMi5ScPuTlFHnpr9oLNj4B5QDqXSEgXC5l0yri8v5NG37qyXHk
   N31M0JgQtezfgVF5jwzTCW1Uw/afDFII31nUV9weWKhvOz6zULU8G1vj0
   IR9zF28hcLtdFrtqpdxuONRU48n4QiLcSPsDyUY5dFpUYpzVPmIJ3IC5E
   60yY26Viere3B0kT75pGTn/hyruevV8SgRl0g4yixznIyUhTOmW6lhNrY
   6cBUfZX91NBo4D9od6yzkDLSNNrpkRq7qOCJoKMq9T6D5mGRprnt10VFd
   cVpxeNEDwxUb+6GkET4pAhF/NvT56ndm7sS2HJU0Cp3lIdNLHHijKTYIw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462359"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851414"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:14 -0800
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
Subject: [PATCH v17 054/116] KVM: TDX: Require TDP MMU and mmio caching for TDX
Date:   Tue,  7 Nov 2023 06:56:20 -0800
Message-Id: <64823009614101cc7c01e1c3f54bf3ee89c232d5.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

As TDP MMU is becoming main stream than the legacy MMU, the legacy MMU
support for TDX isn't implemented.  TDX requires KVM mmio caching.  Disable
TDX support when TDP MMU or mmio caching aren't supported.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/mmu/mmu.c  |  1 +
 arch/x86/kvm/vmx/main.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d5dfd74ba19f..44d9c3d2f7d9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -104,6 +104,7 @@ module_param_named(flush_on_reuse, force_flush_and_sync_on_reuse, bool, 0644);
  * If the hardware supports that we don't need to do shadow paging.
  */
 bool tdp_enabled = false;
+EXPORT_SYMBOL_GPL(tdp_enabled);
 
 static bool __ro_after_init tdp_mmu_allowed;
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4a8fd03d2d0b..457310186255 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -58,6 +58,17 @@ static __init int vt_hardware_setup(void)
 	if (enable_ept)
 		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
 				      cpu_has_vmx_ept_execute_only());
+	/* TDX requires KVM TDP MMU. */
+	if (enable_tdx && !tdp_enabled) {
+		enable_tdx = false;
+		pr_warn_ratelimited("TDX requires TDP MMU.  Please enable TDP MMU for TDX.\n");
+	}
+
+	/* TDX requires MMIO caching. */
+	if (enable_tdx && !enable_mmio_caching) {
+		enable_tdx = false;
+		pr_warn_ratelimited("TDX requires mmio caching.  Please enable mmio caching for TDX.\n");
+	}
 
 	enable_tdx = enable_tdx && !tdx_hardware_setup(&vt_x86_ops);
 
-- 
2.25.1

