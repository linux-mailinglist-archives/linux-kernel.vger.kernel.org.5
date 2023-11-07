Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF557E4276
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjKGPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjKGPA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:00:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593710C2;
        Tue,  7 Nov 2023 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369115; x=1730905115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=687sCXXnwyags3BQL0hhStRbdAsoDV6LQ3d5PokSvsQ=;
  b=FO4Vhx/sIpuMMxMWmCvYbp01o5edwjrT/gkczpfpSxA2iDhXGqYSxZvA
   WX4mHqXAp60g0cILt4zBiBf4kpPVWDkwwkuNFJt4QzSGc/Gk/pSfTE8r/
   3+XPEBX0gjkNQnCtoPxxhcsvp8en1+8ghSXN1I9Q1DtBPJ31sD8HUKmwu
   f+N7k+HRrM952ef10k4KHpEGn2vIJH4uc2HCFSnXQi7//j1MJ6im0n4d9
   2hupdiYaLMzw4uvoJI+5XVuE9B1690TlOZe//Y5nFd7ap+ljOWSA8rSPF
   26YIot2y8bkYRgF+g39Uw0UThHWl0UHivWN2OYpmYdUOFdCcJyIvCAUo4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462259"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851359"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:10 -0800
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
        Chao Gao <chao.gao@intel.com>
Subject: [PATCH v17 040/116] KVM: x86/mmu: Assume guest MMIOs are shared
Date:   Tue,  7 Nov 2023 06:56:06 -0800
Message-Id: <b1b66a75ed51235eca6765e96eaf4d5b79efd772.1699368322.git.isaku.yamahata@intel.com>
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

From: Chao Gao <chao.gao@intel.com>

Guest TD doesn't necessarily invoke MAP_GPA to convert the virtual MMIO
range to shared before accessing it.  When TD tries to access the virtual
device's MMIO as shared, an EPT violation is raised first.
kvm_mem_is_private() checks whether the GFN is shared or private.  If
MAP_GPA is not called for the GPA, KVM thinks the GPA is private and
refuses shared access, and doesn't set up shared EPT entry.  The guest
can't make progress.

Instead of requiring the guest to invoke MAP_GPA for regions of virtual
MMIOs assume regions of virtual MMIOs are shared in KVM as well (i.e., GPAs
either have no kvm_memory_slot or are backed by host MMIOs). So that guests
can access those MMIO regions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5f29e6422434..a9bc545c8735 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4375,7 +4375,12 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			return RET_PF_EMULATE;
 	}
 
-	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
+	/*
+	 * !fault->slot means MMIO.  Don't require explicit GPA conversion for
+	 * MMIO because MMIO is assigned at the boot time.
+	 */
+	if (fault->slot &&
+	    fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
 		if (vcpu->kvm->arch.vm_type == KVM_X86_SW_PROTECTED_VM)
 			return RET_PF_RETRY;
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
-- 
2.25.1

