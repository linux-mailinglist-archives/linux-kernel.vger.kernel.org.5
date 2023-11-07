Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5C7E434B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbjKGPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjKGPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:18:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59C5FD9;
        Tue,  7 Nov 2023 07:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369319; x=1730905319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFe97r0IFPBKhdaTOSedc51npmLY26TZ0rOptuo2w7Q=;
  b=Uea/Q4wRBIhjEPvCP1a/z1H7Ziexf/kwLw/TANwrP6cMs7ScRG0gzjgy
   YZ5uM4NMwN4jSL8+sy3RKppeK3VjYziLwnCyFhnlnYMnVS3Nvw+0Xj4bO
   p1Vl7JWEIYHsR0sBFBtmJuC0+23oIzXgvklDcGIIBIxWZSJ3oxySR4q/h
   Jg3+rpU3azHZvy4Xm/ds0xaFz9e9IHxcbhUlBWfdUxFy+vHbagtp5sIf3
   /Vh1pzGIGc+ox6wmwrx26UKIeUOvecDW6MTiiTONycWoEVyUWIxRdc570
   IHnlvWturVY/msMazHANySU0QrXxq4n9MvrAf5ZY13JMpleVQBNnrjkrq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="388397521"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="388397521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10446531"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:00:53 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v6 04/16] KVM: TDX: Pass size to tdx_measure_page()
Date:   Tue,  7 Nov 2023 07:00:31 -0800
Message-Id: <7b024367db5909ffc22e6762acd0569c3a82ccd3.1699368363.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368363.git.isaku.yamahata@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

Extend tdx_measure_page() to pass size info so that it can measure
large page as well.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 2d5c86e06c5f..a728175c4a6d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1434,13 +1434,15 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa & PAGE_MASK);
 }
 
-static void tdx_measure_page(struct kvm_tdx *kvm_tdx, hpa_t gpa)
+static void tdx_measure_page(struct kvm_tdx *kvm_tdx, hpa_t gpa, int size)
 {
 	struct tdx_module_args out;
 	u64 err;
 	int i;
 
-	for (i = 0; i < PAGE_SIZE; i += TDX_EXTENDMR_CHUNKSIZE) {
+	WARN_ON_ONCE(size % TDX_EXTENDMR_CHUNKSIZE);
+
+	for (i = 0; i < size; i += TDX_EXTENDMR_CHUNKSIZE) {
 		err = tdh_mr_extend(kvm_tdx->tdr_pa, gpa + i, &out);
 		if (KVM_BUG_ON(err, &kvm_tdx->kvm)) {
 			pr_tdx_error(TDH_MR_EXTEND, err, &out);
@@ -1544,7 +1546,7 @@ static int tdx_sept_page_add(struct kvm *kvm, gfn_t gfn,
 		tdx_unpin(kvm, pfn);
 		return -EIO;
 	} else if (measure)
-		tdx_measure_page(kvm_tdx, gpa);
+		tdx_measure_page(kvm_tdx, gpa, KVM_HPAGE_SIZE(level));
 
 	return 0;
 
-- 
2.25.1

