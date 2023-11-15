Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F87EC1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjKOMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343607AbjKOMBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:01:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611B9120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049680; x=1731585680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3xuiVtppGTtNOfAwJhMe/qF1cFiWNEHa9BAkXdB+As=;
  b=B/Cc9Fytx2ykAXucScNIf4m9S8lKwEqVlOdpZv5bUAE+c3t3qfjrcMKe
   +HxGYmzTRi/tAVIF6xcaQMdvA9quSI1MjwdyL0mQF5vm6MAaIdVyemjg/
   h/9sR6/izGcb/LscpFtj+p9n6msRzbzVf1p6Ie6gGkWKfU/YAIzCoHk1O
   V2MbRVUKeO2RvKTC2yXBF3hYYsHvA5gQPyLrPDQtPN8r44dq6G9Psh2m/
   WQlfqtiXXMh12/vd11jTM7pdLfwmKYuG+AlqOODySGVregJmWs2D3qqxC
   o7dJujwVMYm1kofXIVC7zEijMbuQiVvqePlChhiCXq8ytA6/8Okkfmgde
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12411886"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="12411886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="6377673"
Received: from mituomis-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.135])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:01:15 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5A69510A119; Wed, 15 Nov 2023 15:01:12 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 04/14] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
Date:   Wed, 15 Nov 2023 15:00:34 +0300
Message-ID: <20231115120044.8034-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI MADT doesn't allow to offline CPU after it got woke up.

Currently hotplug prevented based on the confidential computing
attribute which is set for Intel TDX. But TDX is not the only possible
user of the wake up method.

Disable CPU offlining on ACPI MADT wakeup enumeration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c               |  1 -
 arch/x86/kernel/acpi/madt_wakeup.c |  3 +++
 include/linux/cc_platform.h        | 10 ----------
 kernel/cpu.c                       |  3 +--
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..f07c3bb7deab 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -20,7 +20,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_MEM_ENCRYPT:
 		return true;
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 38ffd4524e44..f7e33cea1be5 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -1,4 +1,5 @@
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/barrier.h>
@@ -75,6 +76,8 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
 
+	cpu_hotplug_disable_offlining();
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..d08dd65b5c43 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -80,16 +80,6 @@ enum cc_attr {
 	 * using AMD SEV-SNP features.
 	 */
 	CC_ATTR_GUEST_SEV_SNP,
-
-	/**
-	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
-	 *
-	 * The platform/OS is running as a guest/virtual machine does not
-	 * support CPU hotplug feature.
-	 *
-	 * Examples include TDX Guest.
-	 */
-	CC_ATTR_HOTPLUG_DISABLED,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/kernel/cpu.c b/kernel/cpu.c
index af8034ccda8e..a9e1628cebbb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1532,8 +1532,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
-	    cpu_hotplug_offline_disabled)
+	if (cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-- 
2.41.0

