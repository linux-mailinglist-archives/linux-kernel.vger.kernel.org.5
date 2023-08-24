Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E880D7867A5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjHXGm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbjHXGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:42:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88510F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692859342; x=1724395342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5+O8zxYvDFzyzEpO5do45/63yitfgQyrGVGG+U71C0=;
  b=NWRNXpbTLInFuKREuwx2elTSpkS6Obbqzi9y/o0b+JD9EDfTSIIIkYjI
   rI0nKkLEtwQJ+WeJzfMNv9sCZgpsFiL2I5xOm9XqfzEh43cEP1Q+mnXE8
   NCpAMLTWgqB7CYkOR//pqvbk4E4tlljsGHw3UBZLbzOqvTSbmVPCFIjKJ
   ly40dXrUSmgQ2UxNQk777wyh0sEoO4GIvBeliTnCex8rM0DHQVpXdCK3J
   +4V89tTKVZURmjoDVe+A+5sOClziKf7tDFwwpGRiouWkeS8QLUp3H8/YM
   fjw1UOtnRaynISvzWfufbkkvniX0NodNth4u9yB+q1dFfyd9WLd4CeTNv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359342340"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359342340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 23:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="806986843"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="806986843"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2023 23:42:13 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4
Date:   Thu, 24 Aug 2023 14:49:39 +0800
Message-Id: <20230824064939.54207-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0Day found a 34.6% regression in stress-ng's 'af-alg' test case [1], and
bisected it to commit b81fac906a8f ("x86/fpu: Move FPU initialization
into arch_cpu_finalize_init()"), which optimizes the FPU init order,
and moves the CR4_OSXSAVE enabling into a later place:

   arch_cpu_finalize_init
       identify_boot_cpu
	   identify_cpu
	       generic_identify
                   get_cpu_cap --> setup cpu capability
       ...
       fpu__init_cpu
           fpu__init_cpu_xstate
               cr4_set_bits(X86_CR4_OSXSAVE);

'X86_FEATURE_OSXSAVE' feature bit maps to bit 27 of output in ECX from
cpuid(0x00000001), which will be '1' once CR4.OSXSAVE is set. From the
call sequence above, CR4.OSXSAVE is set after cpu capability setup,
causing 'X86_FEATURE_OSXSAVE' feature bit not being set.

Many security module like 'camellia_aesni_avx_x86_64' depends on
this feature, and will fail to be loaded after the commit, causing the
regression.

So set X86_FEATURE_OSXSAVE feature right after OSXSAVE enabling to fix it.

[1]. https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com/

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com/
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changelog:

  since v1:
    * Add more background info to commit log and code comments (Rick Edgecombe)

 arch/x86/kernel/fpu/xstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..9de551662624 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -173,6 +173,13 @@ void fpu__init_cpu_xstate(void)
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
+	/*
+	 * CPUID bit for X86_FEATURE_OSXSAVE value will change once
+	 * CR4.OSXSAVE is set, so update it manually.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
+		setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	/*
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
-- 
2.27.0

