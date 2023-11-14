Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DE7EA99D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjKNEfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjKNEfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:35:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F310D9;
        Mon, 13 Nov 2023 20:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699936533; x=1731472533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ohZsrXP6UHQf4faA9ChPPQDmGsKpLbWNW4PKmZA5GO8=;
  b=nE+F6fNnYck2fNKnqVZzAR57VnZo07EMaBLM35bZ3yvPPKmK2HpvDrCn
   8yVtp51a39ZndApaceP8ms9b/CUKiqEJ74kiQvlZWWUPkd/3gRMtz/Ogg
   K8Ba1xQ43WsmsGilb5KmkeDBInrLUVmxPRBblMYkIW/hM13qsGflzMk2y
   cQKOtCUaYs9ZSOKAvXMblsZA8IWUWrc/4nqxv8iQSxqxo4LcLQa9st2Yl
   VAy562ZGIIaER0zGCUVVdLSVE+QtHA7BWhwXRJ9/mRdN3jEVXUTTa5m+t
   drgvm+1cLSI4Q0euM/7npc6t/wADDPIBmLkGms4igoHIMCKqfgZrC+zFc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389437297"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="389437297"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830467502"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830467502"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:35:31 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 1/3] KVM: x86: Make the hardcoded APIC bus frequency vm variable
Date:   Mon, 13 Nov 2023 20:35:02 -0800
Message-Id: <1c12f378af7de16d7895f8badb18c3b1715e9271.1699936040.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699936040.git.isaku.yamahata@intel.com>
References: <cover.1699936040.git.isaku.yamahata@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX virtualizes the advertised APIC bus frequency to be 25MHz.  The KVM
hardcodedes it to be 1GHz.  This mismatch causes the vAPIC timer to fire
earlier than the TDX guest expects.  In order to reconcile this mismatch,
make the frequency configurable for the user space VMM.  As the first step,
Replace the constants with the VM value in struct kvm.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
Changes v2:
- no change
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/hyperv.c           | 2 +-
 arch/x86/kvm/lapic.c            | 6 ++++--
 arch/x86/kvm/lapic.h            | 4 ++--
 arch/x86/kvm/x86.c              | 2 ++
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7036982332e..f2b1c6b3fb11 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1334,6 +1334,8 @@ struct kvm_arch {
 
 	u32 default_tsc_khz;
 	bool user_set_tsc;
+	u64 apic_bus_cycle_ns;
+	u64 apic_bus_frequency;
 
 	seqcount_raw_spinlock_t pvclock_sc;
 	bool use_master_clock;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 238afd7335e4..995ce2c74ce0 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1687,7 +1687,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = (u64)vcpu->arch.virtual_tsc_khz * 1000;
 		break;
 	case HV_X64_MSR_APIC_FREQUENCY:
-		data = APIC_BUS_FREQUENCY;
+		data = vcpu->kvm->arch.apic_bus_frequency;
 		break;
 	default:
 		kvm_pr_unimpl_rdmsr(vcpu, msr);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 245b20973cae..73956b0ac1f1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1542,7 +1542,8 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
 		remaining = 0;
 
 	ns = mod_64(ktime_to_ns(remaining), apic->lapic_timer.period);
-	return div64_u64(ns, (APIC_BUS_CYCLE_NS * apic->divide_count));
+	return div64_u64(ns, (apic->vcpu->kvm->arch.apic_bus_cycle_ns *
+			      apic->divide_count));
 }
 
 static void __report_tpr_access(struct kvm_lapic *apic, bool write)
@@ -1960,7 +1961,8 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
 
 static inline u64 tmict_to_ns(struct kvm_lapic *apic, u32 tmict)
 {
-	return (u64)tmict * APIC_BUS_CYCLE_NS * (u64)apic->divide_count;
+	return (u64)tmict * apic->vcpu->kvm->arch.apic_bus_cycle_ns *
+		(u64)apic->divide_count;
 }
 
 static void update_target_expiration(struct kvm_lapic *apic, uint32_t old_divisor)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 0a0ea4b5dd8c..3a425ea2a515 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -16,8 +16,8 @@
 #define APIC_DEST_NOSHORT		0x0
 #define APIC_DEST_MASK			0x800
 
-#define APIC_BUS_CYCLE_NS       1
-#define APIC_BUS_FREQUENCY      (1000000000ULL / APIC_BUS_CYCLE_NS)
+#define APIC_BUS_CYCLE_NS_DEFAULT	1
+#define APIC_BUS_FREQUENCY_DEFAULT	(1000000000ULL / APIC_BUS_CYCLE_NS_DEFAULT)
 
 #define APIC_BROADCAST			0xFF
 #define X2APIC_BROADCAST		0xFFFFFFFFul
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c924075f6f1..a9f4991b3e2e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12466,6 +12466,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 
 	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
+	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
+	kvm->arch.apic_bus_frequency = APIC_BUS_FREQUENCY_DEFAULT;
 	kvm->arch.guest_can_read_msr_platform_info = true;
 	kvm->arch.enable_pmu = enable_pmu;
 
-- 
2.25.1

