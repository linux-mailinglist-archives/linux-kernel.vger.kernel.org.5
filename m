Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8127EA9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjKNEf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKNEfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:35:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E01732;
        Mon, 13 Nov 2023 20:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699936537; x=1731472537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nfeXT50sTAyJBtXKek4qXyhfusub7uAOjNi7mOY3EjY=;
  b=VftsJ+6R5Y4GPBFaHi9XofVi5UHTjmNsiRTnP63er4jgCxAPQPLg/PHi
   RudUyK3DZybOex/b+pNAqB/3JHHUvdViv/JYgnfNppb4c6ldxV4DkfAB1
   5eAyL9B2oiiKRR88qGuvdCvlyA/qitcR4MyVmTaOhw1zqM9jep1ihwvpz
   WnWWx+FZGNs7d92R7qq11XVoL0s69SwVnrO3efg5QKRKtojoRpaA9wUG5
   /V1BnhhI/FguJolVPednujRPZI+U+qecFPbw33PlqNW3l8EYqUMAA1bMX
   D0O11YMGlRFpAOrh0jqnD69tR0bS1zOszQNSRslQskZy9K2hCfXSCAf95
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389437302"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="389437302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="830467505"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="830467505"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 20:35:32 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH v2 2/3] KVM: X86: Add a capability to configure bus frequency for APIC timer
Date:   Mon, 13 Nov 2023 20:35:03 -0800
Message-Id: <88774b9dc566c89141bf75aef341fdf7e238e60b.1699936040.git.isaku.yamahata@intel.com>
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

Add KVM_CAP_X86_BUS_FREQUENCY_CONTROL capability to configure the core
crystal clock (or processor's bus clock) for APIC timer emulation.  Allow
KVM_ENABLE_CAPABILITY(KVM_CAP_X86_BUS_FREQUENCY_CONTROL) to set the
frequency.

TDX virtualizes CPUID[0x15] for the core crystal clock to be 25MHz.  The
x86 KVM hardcodes its frequency for APIC timer to be 1GHz.  This mismatch
causes the vAPIC timer to fire earlier than the guest expects. [1] The KVM
APIC timer emulation uses hrtimer, whose unit is nanosecond.  Make the
parameter configurable for conversion from the TMICT value to nanosecond.

This patch doesn't affect the TSC deadline timer emulation.  The TSC
deadline emulation path records its expiring TSC value and calculates the
expiring time in nanoseconds.  The APIC timer emulation path calculates the
TSC value from the TMICT register value and uses the TSC deadline timer
path.  This patch touches the APIC timer-specific code but doesn't touch
common logic.

[1] https://lore.kernel.org/lkml/20231006011255.4163884-1-vannapurve@google.com/
Reported-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
Changes v2:
- Add check if vcpu isn't created.
- Add check if lapic chip is in-kernel emulation.
- Fix build error for i386
- Add document to api.rst
- typo in the commit message
---
 Documentation/virt/kvm/api.rst | 14 ++++++++++++++
 arch/x86/kvm/x86.c             | 35 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  1 +
 3 files changed, 50 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7025b3751027..cc976df2651e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7858,6 +7858,20 @@ This capability is aimed to mitigate the threat that malicious VMs can
 cause CPU stuck (due to event windows don't open up) and make the CPU
 unavailable to host or other VMs.
 
+7.34 KVM_CAP_X86_BUS_FREQUENCY_CONTROL
+--------------------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] is the value of apic bus clock frequency
+:Returns: 0 on success, -EINVAL if args[0] contains invalid value for the
+          frequency, or -ENXIO if virtual local APIC isn't enabled by
+          KVM_CREATE_IRQCHIP, or -EBUSY if any vcpu is created.
+
+This capability sets the APIC bus clock frequency (or core crystal clock
+frequency) for kvm to emulate APIC in the kernel.  The default value is 1000000
+(1GHz).
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a9f4991b3e2e..a8fb862c4f8e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4625,6 +4625,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ENABLE_CAP:
 	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
 	case KVM_CAP_IRQFD_RESAMPLE:
+	case KVM_CAP_X86_BUS_FREQUENCY_CONTROL:
 		r = 1;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
@@ -6616,6 +6617,40 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_X86_BUS_FREQUENCY_CONTROL: {
+		u64 bus_frequency = cap->args[0];
+		u64 bus_cycle_ns;
+
+		if (!bus_frequency)
+			return -EINVAL;
+		/* CPUID[0x15] only support 32bits.  */
+		if (bus_frequency != (u32)bus_frequency)
+			return -EINVAL;
+
+		/* Cast to avoid 64bit division on 32bit platform. */
+		bus_cycle_ns = 1000000000UL / (u32)bus_frequency;
+		if (!bus_cycle_ns)
+			return -EINVAL;
+
+		r = 0;
+		mutex_lock(&kvm->lock);
+		/*
+		 * Don't allow to change the frequency dynamically during vcpu
+		 * running to avoid potentially bizarre behavior.
+		 */
+		if (kvm->created_vcpus)
+			r = -EBUSY;
+		/* This is for in-kernel vAPIC emulation. */
+		else if (!irqchip_in_kernel(kvm))
+			r = -ENXIO;
+
+		if (!r) {
+			kvm->arch.apic_bus_cycle_ns = bus_cycle_ns;
+			kvm->arch.apic_bus_frequency = bus_frequency;
+		}
+		mutex_unlock(&kvm->lock);
+		return r;
+	}
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 211b86de35ac..d74a057df173 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1201,6 +1201,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
+#define KVM_CAP_X86_BUS_FREQUENCY_CONTROL 231
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.25.1

