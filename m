Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82527850CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjHWGu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjHWGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:50:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92079C7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692773424; x=1724309424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FT0AmmV+UdEA+O76fvY0KNZXkimMEhxZgEhtkqGSqLA=;
  b=jQgK/x3TXofNJPLVfaHLKwgKdVSrs1StoDN8sVzNrTHBk/vLHpZkzrNL
   CsqbAfcOxhvN9OifSdXSBr9hfztSgNSnYceTdSOaEfhs3qCEqoRh9isvh
   M0gzgpaEmox0+TN9aePRSBLCjzytgegv1a3vnmGMDSmTaOLrKXjZXNQ+W
   NjszM0dbuqG9hbnaeL2MnvXEU4ir4g30ldmyVi3ddWdTLcaxqT8j8AC1o
   KdgO1bauHZvELpl22tJZM8pZKqE8zxAB93I64IWBXwyNDNCL3cYjN88Fq
   1pCgxJXltma9NwJ41GiRMMV3RotbtRbRAaGYlrGfBW+WFUiYkcXbKLayX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="405085521"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405085521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 23:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713462953"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713462953"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2023 23:50:20 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4
Date:   Wed, 23 Aug 2023 14:57:47 +0800
Message-Id: <20230823065747.92257-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

And it makes 'X86_FEATURE_OSXSAVE' feature bit missed in cpu capability
setup. Many security module like 'camellia_aesni_avx_x86_64' depends on
this feature, and will fail to be loaded after the commit, causing the
regression.

So set X86_FEATURE_OSXSAVE feature right after OSXSAVE enabling to fix it.

[1]. https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com/

Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..8ebea0d522d2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -173,6 +173,9 @@ void fpu__init_cpu_xstate(void)
 
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
+	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
+		setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
+
 	/*
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
-- 
2.27.0

