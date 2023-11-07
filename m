Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB97E4377
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbjKGPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343825AbjKGPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:31:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948486185;
        Tue,  7 Nov 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369321; x=1730905321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nihhIarrSA6BKvrEupadPmJQ5aVN4hKrrazCKaag7KE=;
  b=jwdtHHcvVT5tiRUGElTUF1yDoWN9dB9ZIv81it3n0D3YASxMZl1/Sjci
   4isbfBW56m6MgOGo1XU+DCm00ejJTng0QZQFJAwzRP46hAv8FeRufkB6J
   RXgaUZRBmsosFG65yd/ixfAI7xYsMF3Wl6FcXCoWwFZk5jU7sN8/8qhen
   j2L1PCa4vRMNdWS/NTngWN1poD5YRiScQXH+7dFY3Zx999RtYWZAWGMuV
   XCWSBGSevI+D+CqdVh1TnKsnK3uy2zzK+2LQwe8FyL/x+1aTyeT1meGKm
   oEWFgFBBjN/4ojnSa+ruR2eoc/SfhaazK9tGwBn3ujUxnIz1oblSF0LvP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462660"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851645"
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
Subject: [PATCH v17 107/116] KVM: TDX: Ignore setting up mce
Date:   Tue,  7 Nov 2023 06:57:13 -0800
Message-Id: <0ac069bc39e37de9a3d0cdf3e63049eaab3e1542.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Because vmx_set_mce function is VMX specific and it cannot be used for TDX.
Add vt stub to ignore setting up mce for TDX.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 6c4afb524fe7..239723e46d2e 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -908,6 +908,14 @@ static void vt_cancel_hv_timer(struct kvm_vcpu *vcpu)
 }
 #endif
 
+static void vt_setup_mce(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_setup_mce(vcpu);
+}
+
 static int vt_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	if (!is_td(kvm))
@@ -1063,7 +1071,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.cancel_hv_timer = vt_cancel_hv_timer,
 #endif
 
-	.setup_mce = vmx_setup_mce,
+	.setup_mce = vt_setup_mce,
 
 #ifdef CONFIG_KVM_SMM
 	.smi_allowed = vt_smi_allowed,
-- 
2.25.1

