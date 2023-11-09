Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD797E715A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjKISYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344983AbjKISYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:24:12 -0500
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69F3C03;
        Thu,  9 Nov 2023 10:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
        :From; bh=H5OnRjJeb6gay/TORf53unMu50DnfuG1IYkUYrSoZq4=; b=XAEafdd739TYXpVF0uR
        oyS11WZe9uo/3GT4ILgXWcCSTyuTc8DIpq1lcd5CfT1gDgkfEoRphwzc+67iYbPX6d8pUTX6YYvy2
        lkIfrhXqvLl/y7ViYnGBY+f4XiHAeLBNlm6PRsCkFLTInZNon/zPe8wO0MZsUI3apSJAQvlUMrNqi
        9fwODGETaKOV3KySoaEil+wZ1T9v320l82kCTSE+SNjEqk5fQVLfRPRWvOxzSEqJgSLfMmuXD5y9h
        aum0sRct/i+nPYei8sVgxTn5/ZkyiAJIJ8T+jF59qdnGnzYZN5ynUOPeWAIT40IbWV8g2byAYvs6F
        T20rNl83eEzN4UA==;
Received: from [130.117.225.1] (helo=finist-alma9.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.96)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1r19Pe-00Eo8U-2X;
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
Subject: [PATCH 0/1] KVM: x86/vPMU: Speed up vmexit for AMD Zen 4 CPUs
Date:   Thu,  9 Nov 2023 21:06:45 +0300
Message-Id: <20231109180646.2963718-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have detected significant performance drop of our atomic test which
checks the rate of CPUID instructions rate inside an L1 VM on an AMD
node.

Investigation led to 2 mainstream patches which have introduced extra
events accounting:

   018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instructions")
   9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")

And on an AMD Zen 3 CPU that resulted in immediate 43% drop in the CPUID
rate.

Checking latest mainsteam kernel the performance difference is much less
but still quite noticeable: 13.4% and shows up on AMD CPUs only.

Looks like iteration over all PMCs in kvm_pmu_trigger_event() is cheap
on Intel and expensive on AMD CPUs.

So the idea behind this patch is to skip iterations over PMCs at all in
case PMU is disabled for a VM completely or PMU is enabled for a VM, but
there are no active PMCs at all.

Unfortunately
 * current kernel code does not differentiate if PMU is globally enabled
   for a VM or not (pmu->version is always 1)
 * AMD CPUs older than Zen 4 do not support PMU v2 and thus efficient
   check for enabled PMCs is not possible

=> the patch speeds up vmexit for AMD Zen 4 CPUs only, this is sad.
   but the patch does not hurt other CPUs - and this is fortunate!

i have no access to a node with AMD Zen 4 CPU, so i had to test on
AMD Zen 3 CPU and i hope my expectations are right for AMD Zen 4.

i would appreciate if anyone perform the test of a real AMD Zen 4 node.

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

   -----------------------------------------
   | Kernels       | CPUID rate            |
   -----------------------------------------
   | 1.            | 1360250               |
   | 2.            | 1365536 (+ 0.4%)      |
   | 3.            | 1541850 (+13.4%)      |
   -----------------------------------------

Measurement (2) gives some fluctuation, the performance is not increased
because the test was done on a Zen 3 CPU, so we are unable to use fast
check for active PMCs.
Measurement (3) shows expected performance boost on a Zen 4 CPU under
the same test.

The test used:
# cat at_cpu_cpuid.pub.cpp
/*
 * The test executes CPUID instruction in a loop and reports the calls rate.
 */

#include <stdio.h>
#include <time.h>

/* #define CPUID_EAX            0x80000002 */
#define CPUID_EAX               0x29a
#define CPUID_ECX               0

#define TEST_EXEC_SECS          30      // in seconds
#define LOOPS_APPROX_RATE       1000000

static inline void cpuid(unsigned int _eax, unsigned int _ecx)
{
        unsigned int regs[4] = {_eax, 0, _ecx, 0};

        asm __volatile__(
                "cpuid"
                : "=a" (regs[0]), "=b" (regs[1]), "=c" (regs[2]), "=d" (regs[3])
                :  "0" (regs[0]),  "1" (regs[1]),  "2" (regs[2]),  "3" (regs[3])
                : "memory");
}

double cpuid_rate_loops(int loops_num)
{
        int i;
        clock_t start_time, end_time;
        double spent_time, rate;

        start_time = clock();

        for (i = 0; i < loops_num; i++)
                cpuid((unsigned int)CPUID_EAX, (unsigned int)CPUID_ECX);

        end_time = clock();
        spent_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

        rate = (double)loops_num / spent_time;

        return rate;
}

int main(int argc, char* argv[])
{
        double approx_rate, rate;
        int loops;

        /* First we detect approximate CPUIDs rate. */
        approx_rate = cpuid_rate_loops(LOOPS_APPROX_RATE);

        /*
         * How many loops there should be in order to run the test for
         * TEST_EXEC_SECS seconds?
         */
        loops = (int)(approx_rate * TEST_EXEC_SECS);

        /* Get the precise instructions rate. */
        rate = cpuid_rate_loops(loops);

        printf( "CPUID instructions rate: %f instructions/second\n", rate);

        return 0;
}

Konstantin Khorenko (1):
  KVM: x86/vPMU: Check PMU is enabled for vCPU before searching for PMC

 arch/x86/kvm/pmu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.39.3

