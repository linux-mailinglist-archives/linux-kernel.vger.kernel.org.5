Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F353C7E4375
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjKGPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjKGPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:31:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2DA6181;
        Tue,  7 Nov 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369321; x=1730905321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0KnJ0wRSEPKfMuBifQ0QnS3JufDfG3LkOdxHzqfRwp8=;
  b=WU2I+OV1yilU0898jFzsVvQ2IwZPjq/HRymhz8UTLkbTjOC1YZoHagX5
   yvfR/qocYhmAVpF6jDRYT7FfxEswgkzi6dwt9ls7ClCwX4i+d6f3yhzNu
   2LxpqJVhyUO85fWVXh3HBTdRIQXZuPzWApqGVXEQf+8d7fTiZ7Suj1JJv
   NLCn/DRv2716FCDA4CuMWNrKQvHYra10m2ylfkkPHwlvcdfIgcAZRhlsj
   V9m6R9UGPK3jp8gAsD5RySwgCkQs5sibHwvnQL+TjXeWxqTGFyLMEkVID
   vZU7w5kA88IAlUFeAO4uMwFPpWEh2rP9l3u64erLnnQ7YqIuiNYjcI8Z6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2462649"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2462649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10851631"
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
Subject: [PATCH v17 104/116] KVM: TDX: Add a method to ignore dirty logging
Date:   Tue,  7 Nov 2023 06:57:10 -0800
Message-Id: <8025f0ca1c592d53d0ddc3ef759a784b99f11567.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Currently TDX KVM doesn't support tracking dirty pages (yet).  Implement a
method to ignore it.  Because the flag for kvm memory slot to enable dirty
logging isn't accepted for TDX, warn on the method is called for TDX.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index f09c4a0df11a..8bda6a0a33cd 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -843,6 +843,14 @@ static u8 vt_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	return vmx_get_mt_mask(vcpu, gfn, is_mmio);
 }
 
+static void vt_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+{
+	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
+		return;
+
+	vmx_update_cpu_dirty_logging(vcpu);
+}
+
 static int vt_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
 {
 	if (!is_td(kvm))
@@ -986,7 +994,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.sched_in = vt_sched_in,
 
 	.cpu_dirty_log_size = PML_ENTITY_NUM,
-	.update_cpu_dirty_logging = vmx_update_cpu_dirty_logging,
+	.update_cpu_dirty_logging = vt_update_cpu_dirty_logging,
 
 	.nested_ops = &vmx_nested_ops,
 
-- 
2.25.1

