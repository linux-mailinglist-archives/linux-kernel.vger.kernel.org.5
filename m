Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B857E4425
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjKGPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjKGPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:16:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867E5FFD;
        Tue,  7 Nov 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369321; x=1730905321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3N3LD/S0fSZ5eMOcVYbHNeOUnfB/WRenFvo4FrCZPtI=;
  b=Hlaq6yNw+8iKfVDQ+Cy8Z85NtmPPlZ2IQ277N7kVRhvO11Sv4JoYd+DP
   ZbTjGmmnOMfP2PWGr78yYV7BnNSr+lwkkdVDO1G9ylsJ8ekTWtx1IGHZT
   HZ0ac60MxtLp72mTEoHruiPu6L4Fw4YbAqvax/0LSlpL7O1ND7KqMLaoE
   IiAMIXTa7VWxc4Q0lVNvI77V9yfYldL0sTIe+isshWvGAZ4Q/kWcj+89f
   2WIJo5c51yTtaIiRDNpRaShTD/LHtOhf+VrQ0HiuR3I8NBF5pOVCfjyaZ
   BqschFJIJMHXxxTRPuYuIaGZr5csRtsZc43Koyr65bMhe32glFBGXbrzC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462643"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462643"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851627"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:27 -0800
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
Subject: [PATCH v17 103/116] KVM: TDX: Add methods to ignore guest instruction emulation
Date:   Tue,  7 Nov 2023 06:57:09 -0800
Message-Id: <5410aa9700b0c63be48fe31165605dce0dbbb8a4.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Because TDX protects TDX guest state from VMM, instructions in guest memory
cannot be emulated.  Implement methods to ignore guest instruction
emulator.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 9c70a9ebcffb..f09c4a0df11a 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -331,6 +331,30 @@ static void vt_enable_smi_window(struct kvm_vcpu *vcpu)
 }
 #endif
 
+static int vt_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
+					void *insn, int insn_len)
+{
+	if (is_td_vcpu(vcpu))
+		return X86EMUL_RETRY_INSTR;
+
+	return vmx_check_emulate_instruction(vcpu, emul_type, insn, insn_len);
+}
+
+static int vt_check_intercept(struct kvm_vcpu *vcpu,
+				 struct x86_instruction_info *info,
+				 enum x86_intercept_stage stage,
+				 struct x86_exception *exception)
+{
+	/*
+	 * This call back is triggered by the x86 instruction emulator. TDX
+	 * doesn't allow guest memory inspection.
+	 */
+	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
+		return X86EMUL_UNHANDLEABLE;
+
+	return vmx_check_intercept(vcpu, info, stage, exception);
+}
+
 static bool vt_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu))
@@ -954,7 +978,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.load_mmu_pgd = vt_load_mmu_pgd,
 
-	.check_intercept = vmx_check_intercept,
+	.check_intercept = vt_check_intercept,
 	.handle_exit_irqoff = vt_handle_exit_irqoff,
 
 	.request_immediate_exit = vt_request_immediate_exit,
@@ -983,7 +1007,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.enable_smi_window = vt_enable_smi_window,
 #endif
 
-	.check_emulate_instruction = vmx_check_emulate_instruction,
+	.check_emulate_instruction = vt_check_emulate_instruction,
 	.apic_init_signal_blocked = vt_apic_init_signal_blocked,
 	.migrate_timers = vmx_migrate_timers,
 
-- 
2.25.1

