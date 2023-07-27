Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4A765B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjG0SG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjG0SGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:06:50 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A030F4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690481208; x=1722017208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ou+7XfN+1f2cTllTnn7hZn4iUyiMerEMeSBG9j8AO/g=;
  b=SW0M6hxc7TN5go3Ly3D+W3VhLhFLPGwznFyYOqD8aexHfkstqKKLp+9/
   HcyD5o7sBDz9YZAY8YTnWoIMG+FQ0C1tpT9stjWJdlX1TcwmAbJO2Woex
   T6uA5YJnmN46P7+0eu5P1uU6KmrD97BKDjMXSrWpH1nDF8hPsQ1htCVdX
   4S1uPTAeZs+nPG9CQ5BTp7V3F+SXGoZvAQW2Gu6bQTdnH9jc+NmiFLRGX
   NjdtIVvPyEesQmTN8z5FmLT/QmivjZnoqPT59SeNsUxss4p2rG5/Ff460
   noATdy0FuyKhS1IWsPVqjpJTZfpu3KUREXT1Yc+bapIWAW7Srulkb13lp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454760103"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454760103"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 11:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870523929"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 11:06:50 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] x86/smpboot: Change smp_store_boot_cpu_info() to static
Date:   Thu, 27 Jul 2023 18:05:33 +0000
Message-Id: <20230727180533.3119660-4-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727180533.3119660-1-sohil.mehta@intel.com>
References: <20230727180533.3119660-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is only used locally. Convert it to a static one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/smp.h | 2 --
 arch/x86/kernel/smpboot.c  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 094f31d3f950..cf7217ad5701 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -134,8 +134,6 @@ void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
 
 bool smp_park_other_cpus_in_init(void);
-
-void smp_store_boot_cpu_info(void);
 void smp_store_cpu_info(int id);
 
 asmlinkage __visible void smp_reboot_interrupt(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 6a09a021b534..28c590b4b1b1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -422,7 +422,7 @@ int topology_update_die_map(unsigned int die, unsigned int cpu)
 	return 0;
 }
 
-void __init smp_store_boot_cpu_info(void)
+static void __init smp_store_boot_cpu_info(void)
 {
 	int id = 0; /* CPU 0 */
 	struct cpuinfo_x86 *c = &cpu_data(id);
-- 
2.34.1

