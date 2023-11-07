Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842477E4424
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjKGPt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbjKGPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:15:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3E6180;
        Tue,  7 Nov 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369321; x=1730905321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vlml1HZZ9O+CmP/TT38zvPt5lM6+SP2ZXa932guNVU0=;
  b=C0L/JlH3w78OJL9pjldCtI3/0DSLleWKwDIoaoSSqIlvMY2psVwoOzNF
   4nLrnQuyy8mRZgK0fmnZUHnSpMq+Uux7W72IglRS96ZfOdcVzAAtCVu74
   IUAY5KjmmnduAAvY78xxey1yOJcPVjO97VGJAr/295kvSDoXcDYlFt4zH
   Mf5toMW7wOow6Ee2H7qJAs2p47QOXowcWYDa18Dus/7BR4o/1iG1NNoru
   UfxD3Rvrgor30EuoZtCIa7T3Pgrn5IFzq3+HHQjaEW6/6duJcgcs3Gqfe
   yMmcVrJdLWK/vzBdIDlVOHUngZ1AFu05CvOoS3Zh3JMbCOsYqwZWONFjD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462652"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462652"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851636"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:28 -0800
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
Subject: [PATCH v17 105/116] KVM: TDX: Add methods to ignore VMX preemption timer
Date:   Tue,  7 Nov 2023 06:57:11 -0800
Message-Id: <f61f12c8dd101a2cdec3bc436ba26c1fed642667.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX doesn't support VMX preemption timer.  Implement access methods for VMM
to ignore VMX preemption timer.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 8bda6a0a33cd..30d28b3d22c5 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -851,6 +851,27 @@ static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 	vmx_update_cpu_dirty_logging(vcpu);
 }
 
+#ifdef CONFIG_X86_64
+static int vt_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
+			      bool *expired)
+{
+	/* VMX-preemption timer isn't available for TDX. */
+	if (is_td_vcpu(vcpu))
+		return -EINVAL;
+
+	return vmx_set_hv_timer(vcpu, guest_deadline_tsc, expired);
+}
+
+static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
+{
+	/* VMX-preemption timer can't be set.  See vt_set_hv_timer(). */
+	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
+		return;
+
+	vmx_cancel_hv_timer(vcpu);
+}
+#endif
+
 static int vt_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	if (!is_td(kvm))
@@ -1002,8 +1023,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.pi_start_assignment = vmx_pi_start_assignment,
 
 #ifdef CONFIG_X86_64
-	.set_hv_timer = vmx_set_hv_timer,
-	.cancel_hv_timer = vmx_cancel_hv_timer,
+	.set_hv_timer = vt_set_hv_timer,
+	.cancel_hv_timer = vt_cancel_hv_timer,
 #endif
 
 	.setup_mce = vmx_setup_mce,
-- 
2.25.1

