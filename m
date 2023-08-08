Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B95B7747C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbjHHTTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjHHTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:18:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C73CD32
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512912; x=1723048912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0z1l/njVD+UEzwVIY4bLXSqHss3Uzx8s2RCDApioNEA=;
  b=Wwd84tJMgkhhVANO2Sd9wBfweXP3Lu2kFmcGRUc4IJLat7EJyexeu+Cf
   lQs1LC0wwpnRzS25DrNA8r5cRoY9LkIYQfEGbxpHL+TJczxviNhRoboS+
   Y6HxFwE226HLAzLVtGFpeT3h+vH8R/eIDXKqXO6ZIMReGs4mLfUq6Rt5k
   iOmyjzPL+Nxrt6kKSM8r6dqElywEOUWWu9SQXmx6L4m46gLTylpd1z7PL
   gcAdU8/CLiibkr9ikvfBEcN0+y2/B4h8VUu69LfxAQUmJyxy366mQiVP8
   QhiJ9MF1kPlItWpMONcB5gRYnnu7bdiqGrT4IVCFijsem9WYf+FNCBXYV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374551726"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="374551726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977932468"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="977932468"
Received: from vevladis-mobl.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.49.245])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:23:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E348C10A12B; Tue,  8 Aug 2023 19:23:24 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/tdx: Mark TSC reliable
Date:   Tue,  8 Aug 2023 19:23:20 +0300
Message-ID: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

In TD guests, TSC is virtualized by the TDX module, which ensures:

  - Virtual TSC values are consistent among all the TD’s VCPUs;
  - Monotonously incrementing for any single VCPU;
  - The frequency is determined by TD configuration. The host TSC is
    invariant on platforms where TDX is available.

Use TSC as the only reliable clock source in TD guests, bypassing
unstable calibration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..1583ec64d92e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -769,6 +769,9 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	cc_vendor = CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
-- 
2.41.0

