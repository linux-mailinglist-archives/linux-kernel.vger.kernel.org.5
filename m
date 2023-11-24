Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C77F6D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjKXH7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjKXH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:58:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66865171D;
        Thu, 23 Nov 2023 23:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700812721; x=1732348721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MqLxwMAJxms+uuTstGvVmS/6CUfrp463NJ8UfpNe2ug=;
  b=VB8MP1qe/KtQy+OLbUsfQj8DHCGgfiuF+vzyOU0roBLxj3J4isyMvOoA
   tKe8z9QE+owT91acE1s0t3kRV8PcwBCp6aKZRWbm4iGZVwiIazS0NcSUp
   +ygFeLb/fXxeCFhmZLQjdAvY7ZwNqNeua1mreblSuZm0OtI7MkkYfbF7z
   q4HPD1tKDeaCRRUNpaYPokWDv6BItUqNTfCIZGUWQN4R8xlVu62n6qA2R
   PDehDku6VSnWWJzvThzcD5gQm3p3do5AgQrmd75mtJggPe28P51OmpAga
   6K6V/L0v6t5eaRlwxYBbhrSeXx+siGrcIWl/ochJ1aK6KGpBjMoxCedmB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458872292"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="458872292"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833629804"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833629804"
Received: from unknown (HELO embargo.jf.intel.com) ([10.165.9.183])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 23:58:36 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, mlevitsk@redhat.com,
        john.allen@amd.com, weijiang.yang@intel.com
Subject: [PATCH v7 05/26] x86/fpu/xstate: Introduce fpu_guest_cfg for guest FPU configuration
Date:   Fri, 24 Nov 2023 00:53:09 -0500
Message-Id: <20231124055330.138870-6-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231124055330.138870-1-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new fpu_guest_cfg to hold all guest FPU settings so that it can
differ from generic kernel FPU settings, e.g., enabling CET supervisor
xstate by default for guest fpstate while it's remained disabled in
kernel FPU config.

The kernel dynamic xfeatures are specifically used by guest fpstate now,
add the mask for guest fpstate so that guest_perm.__state_permit ==
(fpu_kernel_cfg.default_xfeature | XFEATURE_MASK_KERNEL_DYNAMIC). And
if guest fpstate is re-allocated to hold user dynamic xfeatures, the
resulting permissions are consumed before calculate new guest fpstate.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/include/asm/fpu/types.h |  2 +-
 arch/x86/kernel/fpu/core.c       | 14 +++++++++++---
 arch/x86/kernel/fpu/xstate.c     | 10 ++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index c6fd13a17205..306825ad6bc0 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -602,6 +602,6 @@ struct fpu_state_config {
 };
 
 /* FPU state configuration information */
-extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
+extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg, fpu_guest_cfg;
 
 #endif /* _ASM_X86_FPU_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a21a4d0ecc34..516af626bf6a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -33,9 +33,10 @@ DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
 DEFINE_PER_CPU(u64, xfd_state);
 #endif
 
-/* The FPU state configuration data for kernel and user space */
+/* The FPU state configuration data for kernel, user space and guest. */
 struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
 struct fpu_state_config fpu_user_cfg __ro_after_init;
+struct fpu_state_config fpu_guest_cfg __ro_after_init;
 
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
@@ -536,8 +537,15 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
 	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
-	/* Same defaults for guests */
-	fpu->guest_perm = fpu->perm;
+
+	/* Guest permission settings */
+	fpu->guest_perm.__state_perm	= fpu_guest_cfg.default_features;
+	fpu->guest_perm.__state_size	= fpu_guest_cfg.default_size;
+	/*
+	 * Set guest's __user_state_size to fpu_user_cfg.default_size so that
+	 * existing uAPIs can still work.
+	 */
+	fpu->guest_perm.__user_state_size = fpu_user_cfg.default_size;
 }
 
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index ba4172172afd..aa8f8595cd41 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -681,6 +681,7 @@ static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
 	unsigned int user_size, kernel_size, kernel_default_size;
+	unsigned int guest_default_size;
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
 
 	/* Uncompacted user space size */
@@ -702,13 +703,18 @@ static int __init init_xstate_size(void)
 	kernel_default_size =
 		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
 
+	guest_default_size =
+		xstate_calculate_size(fpu_guest_cfg.default_features, compacted);
+
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
 	fpu_kernel_cfg.max_size = kernel_size;
 	fpu_user_cfg.max_size = user_size;
+	fpu_guest_cfg.max_size = kernel_size;
 
 	fpu_kernel_cfg.default_size = kernel_default_size;
+	fpu_guest_cfg.default_size = guest_default_size;
 	fpu_user_cfg.default_size =
 		xstate_calculate_size(fpu_user_cfg.default_features, false);
 
@@ -829,6 +835,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
 	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
 
+	fpu_guest_cfg.max_features = fpu_kernel_cfg.max_features;
+	fpu_guest_cfg.default_features = fpu_guest_cfg.max_features;
+	fpu_guest_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;
 
-- 
2.27.0

