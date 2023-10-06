Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2917BBAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjJFOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjJFOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:46:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF861E4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603577; x=1728139577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBcpvjCK4+25iq2YgElEdnQeYkCFUq/UFQ9ZwM6zUaA=;
  b=Qsxq2BLfkLlM/Jgl9M9VGM2gpGNr4+qx7KjdSIhxUYqGbH2Sx3gf2EWF
   Y3PgmTjRx+oTShkHti1dFLm7GZAL0L1E6QhiUhu2SXhQpKJda8sGEOvkj
   bB8LmjAjGm5FrJmPE8stMRBc10PCTGQB7ph1gU2LP5W7oUE1OHgWfsmX9
   ZpZFc0nrk+EdcwQOlnpHu4oU/tl5yjojo9HpMARsCLP4zvjq/t3N18dxE
   kXKw5NvVcA34VID39Xzv+u/VAOfL4IwM9HJLqWDa+JZTEOWKAxbU3fD8R
   WZd7LkSEOj8tjzL70lo6F3owjU/i9/UcIuBzzCD4wewyrGtb9dFkbrM1F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363116172"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363116172"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083474099"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083474099"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:46:12 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ABA8110A172; Fri,  6 Oct 2023 17:46:09 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Erdem Aktas <erdemaktas@google.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Kai Huang <kai.huang@intel.com>
Subject: [PATCHv3] x86/tdx: Mark TSC reliable
Date:   Fri,  6 Oct 2023 17:45:49 +0300
Message-ID: <20231006144549.2633-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86 virtualization environments, including TDX, RDTSC instruction is
handled without causing a VM exit, resulting in minimal overhead and
jitters. On the other hand, other clock sources (such as HPET, ACPI
timer, APIC, etc.) necessitate VM exits to implement, resulting in more
fluctuating measurements compared to TSC. Thus, those clock sources are
not effective for calibrating TSC.

The host TSC is invariant on platforms where TDX is available.

In TD guests, TSC is virtualized by the TDX module, which ensures:

  - Virtual TSC is monotonously incrementing for any single VCPU;
  - Virtual TSC values are consistent among all the TD’s VCPUs at the
    level supported by the CPU:
    + VMM is required to set the same TSC_ADJUST;
    + VMM must not modify from initial value of TSC_ADJUST before
      SEAMCALL;
  - The frequency is determined by TD configuration:
    + Virtual TSC frequency is specified by VMM on TDH.MNG.INIT;
    + Virtual TSC starts counting from 0 at TDH.MNG.INIT;

Reliable TSC is architectural guarantee for the TDX platform and it must
work for any sane TDX implementation.

Use TSC as the only reliable clock source in TD guests, bypassing
unstable calibration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---

 v3:
  - More details in the commit message;
  - Add Reviewed-bys and Acked-by;

 arch/x86/coco/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2199cf..2f27ae1e2c6b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -816,6 +816,9 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
-- 
2.41.0

