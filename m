Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058717E7158
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbjKISYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjKISYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:24:07 -0500
X-Greylist: delayed 1013 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Nov 2023 10:24:04 PST
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35FD30CF;
        Thu,  9 Nov 2023 10:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
        :From; bh=BXpVce+kqExxqq8mEkIr6YLCv6YVYrkcxppHUHFKRtc=; b=rc/ynbwCEtZ51WsJdjp
        hiGHlN9MsCWXbL1LUbvVzMvtpHbe8ZpABrcBuohM0ITAsyWs2Thr21KiJ5j/wF6pjdKyIzdUJgJQh
        elRoaLrpoZosdruXPiVoEOeANgEqK9CZ7CqpcmIt9cSMbtmLMWcRPL1ItzUHZrSjdp8xVNfXkliPv
        mIfI95pF9jWEHL8xdrou0yI8IVGzxKzTzPtM/zyFsyx4iVq2NtVPmBCj4gP7QoZEtwxWAdpMJVjeZ
        d7mQX0agxnJPRHF73MuasLd+nkoSOx8jOzkBWlG0BnXPckFnXYS737lqGZNYljqp+7Cs/yKrWMc4v
        Tqf1LITSJBFNluQ==;
Received: from [130.117.225.1] (helo=finist-alma9.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.96)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1r19Pe-00Eo8U-2i;
        Thu, 09 Nov 2023 19:06:46 +0100
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH 1/1] KVM: x86/vPMU: Check PMU is enabled for vCPU before searching for PMC
Date:   Thu,  9 Nov 2023 21:06:46 +0300
Message-Id: <20231109180646.2963718-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231109180646.2963718-1-khorenko@virtuozzo.com>
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following 2 mainstream patches have introduced extra
events accounting:

  018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instructions")
  9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")

kvm_pmu_trigger_event() iterates over all PMCs looking for enabled and
this appeared to be fast on Intel CPUs and quite expensive for AMD CPUs.

kvm_pmu_trigger_event() can be optimized not to iterate over all PMCs in
the following cases:

  * if PMU is completely disabled for a VM, which is the default
    configuration
  * if PMU v2 is enabled, but no PMCs are configured

For Intel CPUs:
  * By default PMU is disabled for KVM VMs (<pmu state='off'/> or absent
    in the VM config xml which results in "-cpu pmu=off" qemu option).
    In this case pmu->version is reported as 0 for the appropriate vCPU.

  * According to Intel® 64 and IA-32 Architectures Software Developer’s
    Manual PMU version 2 and higher provide IA32_PERF_GLOBAL_CTRL MSR
    which in particular contains bits which can be used for efficient
    detection which fixed-function performance and general-purpose
    performance monitoring counters are enabled at the moment.

  * Searching for enabled PMCs is fast and the optimization does not
    bring noticeable performance increase.

For AMD CPUs:
  * For CPUs older than Zen 4 pmu->version is always reported as "1" for
    the appropriate vCPU, no matter if PMU is disabled for KVM VMs
    (<pmu state='off'/>) or enabled.
    So for "old" CPUs currently it's impossible to detect when PMU is
    disabled for a VM and skip the iteration by PMCs efficiently.

  * Since Zen 4 AMD CPUs support PMU v2 and in this case pmu->version
    should be reported as "2" and IA32_PERF_GLOBAL_CTRL MSR is available
    and can be used for fast and efficient check for enabled PMCs.
    https://www.phoronix.com/news/AMD-PerfMonV2-Linux-Patches
    https://www.phoronix.com/news/AMD-PerfMonV2-Guests-KVM

  * Optimized preliminary check for enabled PMCs on AMD Zen 4 CPUs
    should give quite noticeable performance improvement.

AMD performance results:
CPU: AMD Zen 3 (three!): AMD EPYC 7443P 24-Core Processor

 * The test binary is run inside an AlmaLinux 9 VM with their stock kernel
   5.14.0-284.11.1.el9_2.x86_64.
 * Test binary checks the CPUID instractions rate (instructions per sec).
 * Default VM config (PMU is off, pmu->version is reported as 1).
 * The Host runs the kernel under test.

 # for i in 1 2 3 4 5 ; do ./at_cpu_cpuid.pub ; done | \
   awk -e '{print $4;}' | \
   cut -f1 --delimiter='.' | \
   ./avg.sh

Measurements:
1. Host runs stock latest mainstream kernel commit 305230142ae0.
2. Host runs same mainstream kernel + current patch.
3. Host runs same mainstream kernel + current patch + force
   guest_pmu_is_enabled() to always return "false" using following change:

   -       if (pmu->version >= 2 && !(pmu->global_ctrl & ~pmu->global_ctrl_mask))
   +       if (pmu->version == 1 && !(pmu->global_ctrl & ~pmu->global_ctrl_mask))

   --------------------------------------
   | Kernels	| CPUID rate		|
   --------------------------------------
   | 1.		| 1360250		|
   | 2.		| 1365536 (+ 0.4%)	|
   | 3.		| 1541850 (+13.4%)	|
   --------------------------------------

Measurement (2) gives some fluctuation, the performance is not increased
because the test was done on a Zen 3 CPU, so we are unable to use fast
check for active PMCs.
Measurement (3) shows expected performance boost on a Zen 4 CPU under
the same test.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 arch/x86/kvm/pmu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9ae07db6f0f6..290d407f339b 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -731,12 +731,38 @@ static inline bool cpl_is_matched(struct kvm_pmc *pmc)
 	return (static_call(kvm_x86_get_cpl)(pmc->vcpu) == 0) ? select_os : select_user;
 }
 
+static inline bool guest_pmu_is_enabled(struct kvm_pmu *pmu)
+{
+	/*
+	 * Currently VMs do not have PMU settings in configs which defaults
+	 * to "pmu=off".
+	 *
+	 * For Intel currently this means pmu->version will be 0.
+	 * For AMD currently PMU cannot be disabled:
+	 * pmu->version should be 2 for Zen 4 cpus and 1 otherwise.
+	 */
+	if (pmu->version == 0)
+		return false;
+
+	/*
+	 * Starting with PMU v2 IA32_PERF_GLOBAL_CTRL MSR is available and
+	 * it can be used to check if none PMCs are enabled.
+	 */
+	if (pmu->version >= 2 && !(pmu->global_ctrl & ~pmu->global_ctrl_mask))
+		return false;
+
+	return true;
+}
+
 void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 perf_hw_id)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
 	int i;
 
+	if (!guest_pmu_is_enabled(pmu))
+		return;
+
 	for_each_set_bit(i, pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX) {
 		pmc = static_call(kvm_x86_pmu_pmc_idx_to_pmc)(pmu, i);
 
-- 
2.39.3

