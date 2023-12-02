Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7751E801C1E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjLBKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjLBKFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:05:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E366B1A6;
        Sat,  2 Dec 2023 02:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701511531; x=1733047531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2TvSYcYyRxZJXd7jYUAEf7Q9pF2z8JkVIapNJrcQxZk=;
  b=KceNHWxVMoHHTCmvnwDci7v4XGhRA6PCaY/ADkAwT9wtdPMJuhU39Z95
   lNJ5WhQo/wnsCjMXGFEtTODwDNVqzp9y1mUfL8dRoVhX4WCCqcQvtvaTk
   4+3CCJHY3NTVG8LQiWyKwqMf1MIzguE8PFYHFVl+EFKwDwbYyLpfCm6Hg
   5tiZDzi4uOg9vfXeHZispiHtTJHqZ26+4nIzECS3tCMCqJuzCWtS+SaHk
   khXqUGefse4Nz4Tk7ZRAlBNHgCrZYzDzsK7jtC6kKOKe7JGac1QSwK5mK
   qbEAKQNj5TDE4m0oIEe+vBaUlu2T/D/LTYsQ4EXVAO3p0pTaTtwDr/lmN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="392459741"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="392459741"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887939973"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="887939973"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 02:05:28 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 41/42] KVM: VMX: Implement ops .flush_remote_tlbs* in VMX when EPT is on
Date:   Sat,  2 Dec 2023 17:36:33 +0800
Message-Id: <20231202093633.15991-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMX implementation of ops of flush_remote_tlbs* in kvm_x86_ops when
enable_ept is on and CONFIG_HYPERV is off.

Without ops flush_remote_tlbs* in VMX, kvm_flush_remote_tlbs*() just makes
all cpus request KVM_REQ_TLB_FLUSH after finding the two ops are
non-present.
So, by also making all cpu requests KVM_REQ_TLB_FLUSH in ops
flush_remote_tlbs* in VMX, no functional changes should be introduced.

The two ops allow vendor code (e.g. VMX) to control when to notify IOMMU
to flush TLBs. This is useful for contidions when sequence to flush CPU
TLBs and IOTLBs is important.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7965bc32f87de..2fec351a3fa5b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7544,6 +7544,17 @@ static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return err;
 }
 
+static int vmx_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, gfn_t nr_pages)
+{
+	kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH);
+	return 0;
+}
+
+static int vmx_flush_remote_tlbs(struct kvm *kvm)
+{
+	return vmx_flush_remote_tlbs_range(kvm, 0, -1ULL);
+}
+
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
@@ -8528,6 +8539,11 @@ static __init int hardware_setup(void)
 		vmx_x86_ops.flush_remote_tlbs = hv_flush_remote_tlbs;
 		vmx_x86_ops.flush_remote_tlbs_range = hv_flush_remote_tlbs_range;
 	}
+#else
+	if (enable_ept) {
+		vmx_x86_ops.flush_remote_tlbs = vmx_flush_remote_tlbs;
+		vmx_x86_ops.flush_remote_tlbs_range = vmx_flush_remote_tlbs_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
-- 
2.17.1

