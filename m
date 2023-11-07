Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCF7E4232
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjKGO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjKGO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:57:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2423120;
        Tue,  7 Nov 2023 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369064; x=1730905064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NecVbGHHCyQtzLmEwFOsvUh9HAGJADDZV1+nGp6pu58=;
  b=WmzZRIoHfg5DQdGwTRYzsvzrwU7iT4kqxFEE8X/3g8WDxa7+6DK195Od
   9DSn6dOjKjjbafsr+xFvmGUla3gYfMI7muAKCqf25HNmDUhrToSdb7mE5
   3URsLSCVh6aWzDSpKYWELJX40DhC2vSVZ2fanuJbi4AjC6WLxm2Q3zqeX
   fZvfGVJzIzAvAaju3tAu3njk43IQa4Yw5VFrSPFOPKG91CE41D/THDf8/
   E6+Gnp9nSbrUehTehgNo3XcrayGvHPJze5zj+WirZ9i/gOxM9uloqofKn
   RH60fyHuSzdjxh8qWC4eENnW3ZLY+/31yQjoOXUoOzapiKDwhxNH+auwZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374555641"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374555641"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="886319171"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="886319171"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 06:57:38 -0800
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
Subject: [PATCH v17 002/116] KVM: x86/vmx: initialize loaded_vmcss_on_cpu in vmx_hardware_setup()
Date:   Tue,  7 Nov 2023 06:55:28 -0800
Message-Id: <2909211f19ff00fccbfeb9dee396a891384333f2.1699368322.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368322.git.isaku.yamahata@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

vmx_hardware_disable() accesses loaded_vmcss_on_cpu via
hardware_disable_all().  To allow hardware_enable/disable_all() before
kvm_init(), initialize it in vmx_hardware_setup() so that tdx module
initialization, hardware_setup method, can reference the variable.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0e081c964e7a..0f3769cc3741 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8263,8 +8263,12 @@ __init int vmx_hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
 	struct desc_ptr dt;
+	int cpu;
 	int r;
 
+	/* vmx_hardware_disable() accesses loaded_vmcss_on_cpu. */
+	for_each_possible_cpu(cpu)
+		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
 	store_idt(&dt);
 	host_idt_base = dt.address;
 
@@ -8507,11 +8511,8 @@ static int __init vmx_init(void)
 	if (r)
 		goto err_l1d_flush;
 
-	for_each_possible_cpu(cpu) {
-		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-
+	for_each_possible_cpu(cpu)
 		pi_init_cpu(cpu);
-	}
 
 	cpu_emergency_register_virt_callback(vmx_emergency_disable);
 
-- 
2.25.1

