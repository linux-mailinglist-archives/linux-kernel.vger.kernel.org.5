Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB630777207
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjHJIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHJIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:03:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7FED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691654617; x=1723190617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hteW6PqmZeyujVmvjbLpDcXu9AxpavNAj0WD6BhQAr4=;
  b=aI0LD2h25G/fy+fyn9HkIpm9YUgEt2+Qp5WYE97YJdg6NjBd/Fr1nlGX
   f1hTYpk/iNea5TzxDBgHAE8ZOYOUU5o5vZF8MzHEVmsCvxy91/p22fPxV
   kis0OdcXk5OT5BLABpwcJiLis7SIyslrtBseZZBQOpUv++f9jkxeyafiA
   ysn/nCWunCpePxa3s1rGD1e/vyCWV3TVKKpLviHf7FCBoHcmwnLzqQfO9
   oLuCIVl34ICDj39BMoI/wlgZQhy2pUOAswsujzVZJM63Dbjl2DtEn7Wrl
   SGtr/2JsvkcM2hF7kGSE29GzvMz9JX6JEHY1j6juPXxOSyKebieX+LSI7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368787504"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="368787504"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732114344"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="732114344"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 00:58:11 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     andrew.cooper3@citrix.com, arjan@linux.intel.com,
        dimitri.sivanich@hpe.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        ray.huang@amd.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
        x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 19/40] x86/apic: Use u32 for wakeup_secondary_cpu[_64]()
Date:   Thu, 10 Aug 2023 15:58:04 +0800
Message-Id: <20230810075804.667-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802101933.795537847@linutronix.de>
References: <20230802101933.795537847@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Thomas Gleixner <tglx@linutronix.de>
> ...
>Subject: [patch V3 19/40] x86/apic: Use u32 for wakeup_secondary_cpu[_64]()
>
>APIC IDs are used with random data types u16, u32, int, unsigned int,
>unsigned long.
>
>Make it all consistently use u32 because that reflects the hardware
>register width.
> ...

Hi Thomas,

Seems some other places (see the diff below) may also need to consistently
use u32 for APIC IDs. If need me to create a separate patch, please let me know.

-Qiuxu

---
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index efa8128437cb..723304e9b4cd 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -514,9 +514,9 @@ extern void generic_bigsmp_probe(void);
 
 extern struct apic apic_noop;
 
-static inline unsigned int read_apic_id(void)
+static inline u32 read_apic_id(void)
 {
-	unsigned int reg = apic_read(APIC_ID);
+	u32 reg = apic_read(APIC_ID);
 
 	return apic->get_apic_id(reg);
 }
@@ -539,7 +539,7 @@ extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
-static inline unsigned int read_apic_id(void) { return 0; }
+static inline u32 read_apic_id(void) { return 0; }
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index f63ab86f6d57..9e235b71b14e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1728,7 +1728,7 @@ static void __x2apic_enable(void)
 static int __init setup_nox2apic(char *str)
 {
 	if (x2apic_enabled()) {
-		int apicid = native_apic_msr_read(APIC_ID);
+		u32 apicid = native_apic_msr_read(APIC_ID);
 
 		if (apicid >= 255) {
 			pr_warn("Apicid: %08x, cannot enforce nox2apic\n",
@@ -2354,7 +2354,7 @@ static struct {
 	 */
 	int active;
 	/* r/w apic fields */
-	unsigned int apic_id;
+	u32 apic_id;
 	unsigned int apic_taskpri;
 	unsigned int apic_ldr;
 	unsigned int apic_dfr;
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index b54b2a6a4c32..28972a044be2 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -280,7 +280,7 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
-static int convert_apicid_to_cpu(int apic_id)
+static int convert_apicid_to_cpu(u32 apic_id)
 {
 	int i;
 
@@ -293,7 +293,8 @@ static int convert_apicid_to_cpu(int apic_id)
 
 int safe_smp_processor_id(void)
 {
-	int apicid, cpuid;
+	u32 apicid;
+	int cpuid;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
