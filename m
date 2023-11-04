Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097F07E0FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKDN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:29:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3DBFB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:29:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so6857a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699104576; x=1699709376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNK3NjfbGqMxsYvwn1DRzRaXW3FkS/zIZAg5B8erSe8=;
        b=EzmkZJWyHADldOXdXdCZTsTwuJ7jS2MtyBLww/Myqd5KLgnC3Yk12qTQlON5fB/Lou
         GIIXzi7VE0wipTi3N4HEllpYamJNB7DV+F9Gv8piGgge2rUweicDEePSH3QST2mI0aGQ
         6mc43SfRG4kDobrrg5emLYOe1BSplf+7ozdYaMqROLyGMxswQihli1ht4rsm41lsTA8s
         07sko3zb/NyiwctlY0xthcUddluieCH2ox17fX2fx6ikSsdOap+K2ATNx85CbX0ULLDE
         VBoCANQVAUlhrjmuIS1yrN48E++0gswQcfnqrbThy4vINy2fQxY3gWZIsd9HqXlG9jKo
         eBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699104576; x=1699709376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNK3NjfbGqMxsYvwn1DRzRaXW3FkS/zIZAg5B8erSe8=;
        b=knzO1Ek21tWjYDk4B7T9p2Wa57wzn3pN+jqa8StfXje4JDyNvraYZFdXNBTOhyGqYT
         rQUlEEi5kfcxVZD6VEK6/HcyyXZfvjYBTJBlkJaVlaZasGizmOopDxNxLl1a81JxS1cS
         Lt90KzrgbWXNLPnqXVCbqJL5kCbgPcw/HhF6ph93Ez9ueRALfLk8zgJzJERtCyd1IsIf
         erUhgn2gpdkCxsPg/01R/hw1GqW1G/55nIqf4f5JHiPCU+V32A0dXMO/QliQH+Jz/8m1
         X2uwMuhNAFnICg48LvI0KBAYlX7OAgL3WmpjCSKUZlrDzEwLZMyo62DvBFvBYLuJP4/2
         rkVQ==
X-Gm-Message-State: AOJu0YzIpQ0L7cYepzDraDSBVF1dDd8Z47eMCQYnbonSNJh40Cx7Ee9g
        c3ota5+CN6et/AZzYHE+xC22eR86bO5kVYweBzUNfQ==
X-Google-Smtp-Source: AGHT+IEA0D8KTVTlIBQhpcTRxfY3uH82MpNPQjM5rxkxZcAN/gUOSu1SnjFaOMcfdwMpfA0ucLzmKsNyHaYZJXsDFUE=
X-Received: by 2002:a50:951e:0:b0:542:d737:dc7e with SMTP id
 u30-20020a50951e000000b00542d737dc7emr84427eda.0.1699104576442; Sat, 04 Nov
 2023 06:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-11-seanjc@google.com>
In-Reply-To: <20231104000239.367005-11-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 06:29:22 -0700
Message-ID: <CALMp9eSt06g00pD6Gu+UU+CjGWOAoehjTAAspOGjp9LWmu83_Q@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] KVM: selftests: Test Intel PMU architectural
 events on gp counters
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 5:03=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Add test cases to verify that Intel's Architectural PMU events work as
> expected when the are (un)available according to guest CPUID.  Iterate
> over a range of sane PMU versions, with and without full-width writes
> enabled, and over interesting combinations of lengths/masks for the bit
> vector that enumerates unavailable events.
>
> Test up to vPMU version 5, i.e. the current architectural max.  KVM only
> officially supports up to version 2, but the behavior of the counters is
> backwards compatible, i.e. KVM shouldn't do something completely differen=
t
> for a higher, architecturally-defined vPMU version.  Verify KVM behavior
> against the effective vPMU version, e.g. advertising vPMU 5 when KVM only
> supports vPMU 2 shouldn't magically unlock vPMU 5 features.
>
> According to Intel SDM, the number of architectural events is reported
> through CPUID.0AH:EAX[31:24] and the architectural event x is supported
> if EBX[x]=3D0 && EAX[31:24]>x.  Note, KVM's ABI is that unavailable event=
s
> do not count, even though strictly speaking that's not required by the
> SDM (the behavior is effectively undefined).
>
> Handcode the entirety of the measured section so that the test can
> precisely assert on the number of instructions and branches retired.
>
> Co-developed-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/pmu_counters_test.c  | 321 ++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/pmu_counters_test.=
c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 44d8d022b023..09f5d6fe84de 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -91,6 +91,7 @@ TEST_GEN_PROGS_x86_64 +=3D x86_64/mmio_warning_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/monitor_mwait_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/nested_exceptions_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/platform_info_test
> +TEST_GEN_PROGS_x86_64 +=3D x86_64/pmu_counters_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/pmu_event_filter_test
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/set_boot_cpu_id
>  TEST_GEN_PROGS_x86_64 +=3D x86_64/set_sregs_test
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/too=
ls/testing/selftests/kvm/x86_64/pmu_counters_test.c
> new file mode 100644
> index 000000000000..dd9a7864410c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023, Tencent, Inc.
> + */
> +
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <x86intrin.h>
> +
> +#include "pmu.h"
> +#include "processor.h"
> +
> +/* Number of LOOP instructions for the guest measurement payload. */
> +#define NUM_BRANCHES           10
> +/*
> + * Number of "extra" instructions that will be counted, i.e. the number =
of
> + * instructions that are needed to set up the loop and then disabled the
> + * counter.  2 MOV, 2 XOR, 1 WRMSR.
> + */
> +#define NUM_EXTRA_INSNS                5
> +#define NUM_INSNS_RETIRED      (NUM_BRANCHES + NUM_EXTRA_INSNS)
> +
> +static uint8_t kvm_pmu_version;
> +static bool kvm_has_perf_caps;
> +
> +static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu=
,
> +                                                 void *guest_code,
> +                                                 uint8_t pmu_version,
> +                                                 uint64_t perf_capabilit=
ies)
> +{
> +       struct kvm_vm *vm;
> +
> +       vm =3D vm_create_with_one_vcpu(vcpu, guest_code);
> +       vm_init_descriptor_tables(vm);
> +       vcpu_init_descriptor_tables(*vcpu);
> +
> +       sync_global_to_guest(vm, kvm_pmu_version);
> +
> +       /*
> +        * Set PERF_CAPABILITIES before PMU version as KVM disallows enab=
ling
> +        * features via PERF_CAPABILITIES if the guest doesn't have a vPM=
U.
> +        */
> +       if (kvm_has_perf_caps)
> +               vcpu_set_msr(*vcpu, MSR_IA32_PERF_CAPABILITIES, perf_capa=
bilities);
> +
> +       vcpu_set_cpuid_property(*vcpu, X86_PROPERTY_PMU_VERSION, pmu_vers=
ion);
> +       return vm;
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +       struct ucall uc;
> +
> +       do {
> +               vcpu_run(vcpu);
> +               switch (get_ucall(vcpu, &uc)) {
> +               case UCALL_SYNC:
> +                       break;
> +               case UCALL_ABORT:
> +                       REPORT_GUEST_ASSERT(uc);
> +                       break;
> +               case UCALL_PRINTF:
> +                       pr_info("%s", uc.buffer);
> +                       break;
> +               case UCALL_DONE:
> +                       break;
> +               default:
> +                       TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
> +               }
> +       } while (uc.cmd !=3D UCALL_DONE);
> +}
> +
> +static uint8_t guest_get_pmu_version(void)
> +{
> +       /*
> +        * Return the effective PMU version, i.e. the minimum between wha=
t KVM
> +        * supports and what is enumerated to the guest.  The host delibe=
rately
> +        * advertises a PMU version to the guest beyond what is actually
> +        * supported by KVM to verify KVM doesn't freak out and do someth=
ing
> +        * bizarre with an architecturally valid, but unsupported, versio=
n.
> +        */
> +       return min_t(uint8_t, kvm_pmu_version, this_cpu_property(X86_PROP=
ERTY_PMU_VERSION));
> +}
> +
> +/*
> + * If an architectural event is supported and guaranteed to generate at =
least
> + * one "hit, assert that its count is non-zero.  If an event isn't suppo=
rted or
> + * the test can't guarantee the associated action will occur, then all b=
ets are
> + * off regarding the count, i.e. no checks can be done.
> + *
> + * Sanity check that in all cases, the event doesn't count when it's dis=
abled,
> + * and that KVM correctly emulates the write of an arbitrary value.
> + */
> +static void guest_assert_event_count(uint8_t idx,
> +                                    struct kvm_x86_pmu_feature event,
> +                                    uint32_t pmc, uint32_t pmc_msr)
> +{
> +       uint64_t count;
> +
> +       count =3D _rdpmc(pmc);
> +       if (!this_pmu_has(event))
> +               goto sanity_checks;
> +
> +       switch (idx) {
> +       case INTEL_ARCH_INSTRUCTIONS_RETIRED:
> +               GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
> +               break;
> +       case INTEL_ARCH_BRANCHES_RETIRED:
> +               GUEST_ASSERT_EQ(count, NUM_BRANCHES);
> +               break;
> +       case INTEL_ARCH_CPU_CYCLES:
> +       case INTEL_ARCH_REFERENCE_CYCLES:
> +               GUEST_ASSERT_NE(count, 0);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +sanity_checks:
> +       __asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
> +       GUEST_ASSERT_EQ(_rdpmc(pmc), count);
> +
> +       wrmsr(pmc_msr, 0xdead);
> +       GUEST_ASSERT_EQ(_rdpmc(pmc), 0xdead);
> +}
> +
> +static void __guest_test_arch_event(uint8_t idx, struct kvm_x86_pmu_feat=
ure event,
> +                                   uint32_t pmc, uint32_t pmc_msr,
> +                                   uint32_t ctrl_msr, uint64_t ctrl_msr_=
value)
> +{
> +       wrmsr(pmc_msr, 0);
> +
> +       /*
> +        * Enable and disable the PMC in a monolithic asm blob to ensure =
that
> +        * the compiler can't insert _any_ code into the measured sequenc=
e.
> +        * Note, ECX doesn't need to be clobbered as the input value, @pm=
c_msr,
> +        * is restored before the end of the sequence.
> +        */
> +       __asm__ __volatile__("wrmsr\n\t"
> +                            "mov $" __stringify(NUM_BRANCHES) ", %%ecx\n=
\t"
> +                            "loop .\n\t"
> +                            "mov %%edi, %%ecx\n\t"
> +                            "xor %%eax, %%eax\n\t"
> +                            "xor %%edx, %%edx\n\t"
> +                            "wrmsr\n\t"
> +                            :: "a"((uint32_t)ctrl_msr_value),
> +                               "d"(ctrl_msr_value >> 32),
> +                               "c"(ctrl_msr), "D"(ctrl_msr)
> +                            );
> +
> +       guest_assert_event_count(idx, event, pmc, pmc_msr);
> +}
> +
> +static void guest_test_arch_event(uint8_t idx)
> +{
> +       const struct {
> +               struct kvm_x86_pmu_feature gp_event;
> +       } intel_event_to_feature[] =3D {
> +               [INTEL_ARCH_CPU_CYCLES]            =3D { X86_PMU_FEATURE_=
CPU_CYCLES },
> +               [INTEL_ARCH_INSTRUCTIONS_RETIRED]  =3D { X86_PMU_FEATURE_=
INSNS_RETIRED },
> +               [INTEL_ARCH_REFERENCE_CYCLES]      =3D { X86_PMU_FEATURE_=
REFERENCE_CYCLES },
> +               [INTEL_ARCH_LLC_REFERENCES]        =3D { X86_PMU_FEATURE_=
LLC_REFERENCES },
> +               [INTEL_ARCH_LLC_MISSES]            =3D { X86_PMU_FEATURE_=
LLC_MISSES },
> +               [INTEL_ARCH_BRANCHES_RETIRED]      =3D { X86_PMU_FEATURE_=
BRANCH_INSNS_RETIRED },
> +               [INTEL_ARCH_BRANCHES_MISPREDICTED] =3D { X86_PMU_FEATURE_=
BRANCHES_MISPREDICTED },
> +       };
> +
> +       uint32_t nr_gp_counters =3D this_cpu_property(X86_PROPERTY_PMU_NR=
_GP_COUNTERS);
> +       uint32_t pmu_version =3D guest_get_pmu_version();
> +       /* PERF_GLOBAL_CTRL exists only for Architectural PMU Version 2+.=
 */
> +       bool guest_has_perf_global_ctrl =3D pmu_version >=3D 2;
> +       struct kvm_x86_pmu_feature gp_event;
> +       uint32_t base_pmc_msr;
> +       unsigned int i;
> +
> +       /* The host side shouldn't invoke this without a guest PMU. */
> +       GUEST_ASSERT(pmu_version);
> +
> +       if (this_cpu_has(X86_FEATURE_PDCM) &&
> +           rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
> +               base_pmc_msr =3D MSR_IA32_PMC0;
> +       else
> +               base_pmc_msr =3D MSR_IA32_PERFCTR0;
> +
> +       gp_event =3D intel_event_to_feature[idx].gp_event;
> +       GUEST_ASSERT_EQ(idx, gp_event.f.bit);
> +
> +       GUEST_ASSERT(nr_gp_counters);
> +
> +       for (i =3D 0; i < nr_gp_counters; i++) {
> +               uint64_t eventsel =3D ARCH_PERFMON_EVENTSEL_OS |
> +                                   ARCH_PERFMON_EVENTSEL_ENABLE |
> +                                   intel_pmu_arch_events[idx];
> +
> +               wrmsr(MSR_P6_EVNTSEL0 + i, 0);
> +               if (guest_has_perf_global_ctrl)
> +                       wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, BIT_ULL(i));
> +
> +               __guest_test_arch_event(idx, gp_event, i, base_pmc_msr + =
i,
> +                                       MSR_P6_EVNTSEL0 + i, eventsel);
> +       }
> +}
> +
> +static void guest_test_arch_events(void)
> +{
> +       uint8_t i;
> +
> +       for (i =3D 0; i < NR_INTEL_ARCH_EVENTS; i++)
> +               guest_test_arch_event(i);
> +
> +       GUEST_DONE();
> +}
> +
> +static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabili=
ties,
> +                            uint8_t length, uint32_t unavailable_mask)
> +{
> +       struct kvm_vcpu *vcpu;
> +       struct kvm_vm *vm;
> +
> +       /* Testing arch events requires a vPMU (there are no negative tes=
ts). */
> +       if (!pmu_version)
> +               return;
> +
> +       vm =3D pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
> +                                        pmu_version, perf_capabilities);
> +
> +       vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LEN=
GTH,
> +                               length);
> +       vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EVENTS_MASK,
> +                               unavailable_mask);
> +
> +       run_vcpu(vcpu);
> +
> +       kvm_vm_free(vm);
> +}
> +
> +static void test_intel_counters(void)
> +{
> +       uint8_t nr_arch_events =3D kvm_cpu_property(X86_PROPERTY_PMU_EBX_=
BIT_VECTOR_LENGTH);
> +       uint8_t pmu_version =3D kvm_cpu_property(X86_PROPERTY_PMU_VERSION=
);
> +       unsigned int i;
> +       uint8_t v, j;
> +       uint32_t k;
> +
> +       const uint64_t perf_caps[] =3D {
> +               0,
> +               PMU_CAP_FW_WRITES,
> +       };
> +
> +       /*
> +        * Test up to PMU v5, which is the current maximum version define=
d by
> +        * Intel, i.e. is the last version that is guaranteed to be backw=
ards
> +        * compatible with KVM's existing behavior.
> +        */
> +       uint8_t max_pmu_version =3D max_t(typeof(pmu_version), pmu_versio=
n, 5);
> +
> +       /*
> +        * Verify that KVM is sanitizing the architectural events, i.e. h=
iding
> +        * events that KVM doesn't support.  This will fail any time KVM =
adds
> +        * support for a new event, but it's worth paying that price to b=
e able
> +        * to detect KVM bugs.
> +        */
> +       TEST_ASSERT(nr_arch_events <=3D NR_INTEL_ARCH_EVENTS,
> +                   "KVM is either buggy, or has learned new tricks (leng=
th =3D %u, mask =3D %x)",
> +                   nr_arch_events, kvm_cpu_property(X86_PROPERTY_PMU_EVE=
NTS_MASK));

As stated earlier in this series, KVM doesn't have to do anything when
a new architectural event is defined, so this should just say
something like,  "New architectural event(s); please update this
test."

> +       /*
> +        * Force iterating over known arch events regardless of whether o=
r not
> +        * KVM/hardware supports a given event.
> +        */
> +       nr_arch_events =3D max_t(typeof(nr_arch_events), nr_arch_events, =
NR_INTEL_ARCH_EVENTS);
> +
> +       for (v =3D 0; v <=3D max_pmu_version; v++) {
> +               for (i =3D 0; i < ARRAY_SIZE(perf_caps); i++) {
> +                       if (!kvm_has_perf_caps && perf_caps[i])
> +                               continue;
> +
> +                       pr_info("Testing arch events, PMU version %u, per=
f_caps =3D %lx\n",
> +                               v, perf_caps[i]);
> +                       /*
> +                        * To keep the total runtime reasonable, test eve=
ry
> +                        * possible non-zero, non-reserved bitmap combina=
tion
> +                        * only with the native PMU version and the full =
bit
> +                        * vector length.
> +                        */
> +                       if (v =3D=3D pmu_version) {
> +                               for (k =3D 1; k < (BIT(nr_arch_events) - =
1); k++)
> +                                       test_arch_events(v, perf_caps[i],=
 nr_arch_events, k);
> +                       }
> +                       /*
> +                        * Test single bits for all PMU version and lengt=
hs up
> +                        * the number of events +1 (to verify KVM doesn't=
 do
> +                        * weird things if the guest length is greater th=
an the
> +                        * host length).  Explicitly test a mask of '0' a=
nd all
> +                        * ones i.e. all events being available and unava=
ilable.
> +                        */
> +                       for (j =3D 0; j <=3D nr_arch_events + 1; j++) {
> +                               test_arch_events(v, perf_caps[i], j, 0);
> +                               test_arch_events(v, perf_caps[i], j, -1u)=
;
> +
> +                               for (k =3D 0; k < nr_arch_events; k++)
> +                                       test_arch_events(v, perf_caps[i],=
 j, BIT(k));
> +                       }
> +               }
> +       }
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       TEST_REQUIRE(get_kvm_param_bool("enable_pmu"));
> +
> +       TEST_REQUIRE(host_cpu_is_intel);
> +       TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
> +       TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
> +
> +       kvm_pmu_version =3D kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> +       kvm_has_perf_caps =3D kvm_cpu_has(X86_FEATURE_PDCM);
> +
> +       test_intel_counters();
> +
> +       return 0;
> +}
> --
> 2.42.0.869.gea05f2083d-goog
>
