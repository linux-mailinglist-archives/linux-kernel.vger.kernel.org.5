Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C6780154
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355908AbjHQWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355894AbjHQWyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:54:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773A272B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:54:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589f986ab8aso6799627b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692312876; x=1692917676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4txtqJwe1WQOHv8nqshyvk+ZTvqY8wzYqIYtDiuHVfo=;
        b=jBIgK+2mFZ2sBPCocee+9laFRLSEW5Ohq076ANIzKcQLyWLLohK35xcfSWTrsyv8Qm
         w2lywfrAwkPNCUqOtd+zHNBlEmeae06suPHIZaJjqiMKzHWqwEHnq11Sv6Ptq44Aip+M
         MKMtZ2S61Ob0IbPS/LwSli276RZhNqRZPjEz9bnky/dJnv6b8BO34oCNMOT5Yn5cDMMJ
         Tv9kMj1ffuxTtvhET/E0jaWN2GcPIQ3KPY9hCi22T7CZUOlaXe8a1M3LSy06M/po5k15
         ZZP08MWJu1tJPDmK/S1RYtwi9wwNjdLsKSI5sdp+Ip1Vllbu1ZsHntI2xpHpj5q21lWf
         +h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312876; x=1692917676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4txtqJwe1WQOHv8nqshyvk+ZTvqY8wzYqIYtDiuHVfo=;
        b=FB7t88VuPn7hDbKNpXIbl8dPb9yHG8S0xK7euXiacVDUyx8wm08wnhT6AEkolJj+bl
         HKRpzzJVpgG5q6OGUXNuM1O2mw9ZG7tmjdm1c3BeWq7VH5nH/E5r/d90VS4KdZUTo4hF
         hZTI+t/IEgGyLVY3NXr3h8CAwQqswlSq0Kj1fcUvUGh9ijuOx4ast0Qdo2melHVisV82
         JRLza/jnHh9JoDCVHT8CBg0GEcta0tLgnehVF3qo0o6slu25BEgTAxl0+V2zlDw2wSVI
         Rj5K7y+P04szyTRwCScbI4prsgqkaXb/2l/gg5SCK7IkPO9RSoqgr003p140AceW1MAx
         Cj3A==
X-Gm-Message-State: AOJu0YwXZTJah/Av2NNcEohmIFnDGgXRsQ3SpNz8+GGUKAd4Doiq2Uow
        +vLRk3vNm9Is+L8i1r/5Ef03RHFIFrI=
X-Google-Smtp-Source: AGHT+IFtN6uOppmazO5Px5jeqadOf9MSL2MCJloPCxqpAuwvcRKIWFrBBq9SZKHgZ8ttXFk5m1HJmynP4cc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad65:0:b0:58d:4ff2:58c with SMTP id
 l37-20020a81ad65000000b0058d4ff2058cmr82873ywk.1.1692312875814; Thu, 17 Aug
 2023 15:54:35 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:54:34 -0700
In-Reply-To: <20230814115108.45741-4-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230814115108.45741-1-cloudliang@tencent.com> <20230814115108.45741-4-cloudliang@tencent.com>
Message-ID: <ZN6lKvN2xvQOSnnz@google.com>
Subject: Re: [PATCH v3 03/11] KVM: selftests: Test Intel PMU architectural
 events on gp counters
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, Jinrong Liang wrote:
> Add test case for AMD Guest PerfMonV2. Also test Intel
> MSR_CORE_PERF_GLOBAL_STATUS and MSR_CORE_PERF_GLOBAL_OVF_CTRL.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_basic_functionality_test.c | 48 ++++++++++++++++++-
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c b/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> index cb2a7ad5c504..02bd1fe3900b 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> @@ -58,7 +58,9 @@ static uint64_t run_vcpu(struct kvm_vcpu *vcpu, uint64_t *ucall_arg)
>  
>  static void guest_measure_loop(uint64_t event_code)
>  {
> +	uint64_t global_ovf_ctrl_msr, global_status_msr, global_ctrl_msr;
>  	uint8_t nr_gp_counters, pmu_version = 1;
> +	uint8_t gp_counter_bit_width = 48;
>  	uint64_t event_sel_msr;
>  	uint32_t counter_msr;
>  	unsigned int i;
> @@ -68,6 +70,12 @@ static void guest_measure_loop(uint64_t event_code)
>  		pmu_version = this_cpu_property(X86_PROPERTY_PMU_VERSION);
>  		event_sel_msr = MSR_P6_EVNTSEL0;
>  
> +		if (pmu_version > 1) {
> +			global_ovf_ctrl_msr = MSR_CORE_PERF_GLOBAL_OVF_CTRL;
> +			global_status_msr = MSR_CORE_PERF_GLOBAL_STATUS;
> +			global_ctrl_msr = MSR_CORE_PERF_GLOBAL_CTRL;
> +		}
> +
>  		if (rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
>  			counter_msr = MSR_IA32_PMC0;
>  		else
> @@ -76,6 +84,17 @@ static void guest_measure_loop(uint64_t event_code)
>  		nr_gp_counters = AMD64_NR_COUNTERS;
>  		event_sel_msr = MSR_K7_EVNTSEL0;
>  		counter_msr = MSR_K7_PERFCTR0;
> +
> +		if (this_cpu_has(X86_FEATURE_AMD_PMU_EXT_CORE) &&
> +		    this_cpu_has(X86_FEATURE_AMD_PERFMON_V2)) {
> +			nr_gp_counters = this_cpu_property(X86_PROPERTY_AMD_PMU_NR_CORE_COUNTERS);
> +			global_ovf_ctrl_msr = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR;
> +			global_status_msr = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS;
> +			global_ctrl_msr = MSR_AMD64_PERF_CNTR_GLOBAL_CTL;
> +			event_sel_msr = MSR_F15H_PERF_CTL0;
> +			counter_msr = MSR_F15H_PERF_CTR0;
> +			pmu_version = 2;
> +		}

Please use an if-else when the two things are completely exclusive, i.e. don't
set "defaults" and then override them.

>  	}
>  
>  	for (i = 0; i < nr_gp_counters; i++) {
> @@ -84,14 +103,39 @@ static void guest_measure_loop(uint64_t event_code)
>  		      ARCH_PERFMON_EVENTSEL_ENABLE | event_code);
>  
>  		if (pmu_version > 1) {
> -			wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, BIT_ULL(i));
> +			wrmsr(global_ctrl_msr, BIT_ULL(i));
>  			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
> -			wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +			wrmsr(global_ctrl_msr, 0);
>  			GUEST_SYNC(_rdpmc(i));
>  		} else {
>  			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
>  			GUEST_SYNC(_rdpmc(i));
>  		}

This is extremely difficult to follow.  I think the same thing to do is to split
this up into helpers, e.g. send pmu_version > 1 into one path, and pmu_version <= 1
into an entirely different path.

E.g. something like this?

static void guest_measure_loop(uint64_t event_code)
{
	uint64_t global_ovf_ctrl_msr, global_status_msr, global_ctrl_msr;
	uint8_t nr_gp_counters, pmu_version;
	uint8_t gp_counter_bit_width;
	uint64_t event_sel_msr;
	uint32_t counter_msr;
	unsigned int i;

	if (host_cpu_is_intel)
		pmu_version = this_cpu_property(X86_PROPERTY_PMU_VERSION);
	else if (this_cpu_has(X86_FEATURE_PERFCTR_CORE) &&
		 this_cpu_has(X86_FEATURE_PERFMON_V2)) {
		pmu_version = 2;
	} else {
		pmu_version = 1;
	}

	if (pmu_version <= 1) {
		guest_measure_pmu_legacy(...);
		return;
	}

	if (host_cpu_is_intel) {
		nr_gp_counters = this_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
		global_ovf_ctrl_msr = MSR_CORE_PERF_GLOBAL_OVF_CTRL;
		global_status_msr = MSR_CORE_PERF_GLOBAL_STATUS;
		global_ctrl_msr = MSR_CORE_PERF_GLOBAL_CTRL;
		gp_counter_bit_width = this_cpu_property(X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH);

		if (rdmsr(MSR_IA32_PERF_CAPABILITIES) & PMU_CAP_FW_WRITES)
			counter_msr = MSR_IA32_PMC0;
		else
			counter_msr = MSR_IA32_PERFCTR0;
	} else {
		nr_gp_counters = this_cpu_property(X86_PROPERTY_AMD_PMU_NR_CORE_COUNTERS);
		global_ovf_ctrl_msr = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR;
		global_status_msr = MSR_AMD64_PERF_CNTR_GLOBAL_STATUS;
		global_ctrl_msr = MSR_AMD64_PERF_CNTR_GLOBAL_CTL;
		event_sel_msr = MSR_F15H_PERF_CTL0;
		counter_msr = MSR_F15H_PERF_CTR0;
		gp_counter_bit_width = 48;
	}

	for (i = 0; i < nr_gp_counters; i++) {
		wrmsr(counter_msr + i, 0);
		wrmsr(event_sel_msr + i, ARCH_PERFMON_EVENTSEL_OS |
		      ARCH_PERFMON_EVENTSEL_ENABLE | event_code);

		wrmsr(global_ctrl_msr, BIT_ULL(i));
		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
		wrmsr(global_ctrl_msr, 0);
		counter = _rdpmc(i);
		GUEST_ASSERT_EQ(this_pmu_has(...), !!counter);

		if ( _rdpmc(i)) {
			wrmsr(global_ctrl_msr, 0);
			wrmsr(counter_msr + i, 0);
			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
			GUEST_ASSERT(!_rdpmc(i));

			wrmsr(global_ctrl_msr, BIT_ULL(i));
			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
			GUEST_ASSERT(_rdpmc(i));

			wrmsr(global_ctrl_msr, 0);
			wrmsr(counter_msr + i, (1ULL << gp_counter_bit_width) - 2);
			wrmsr(global_ctrl_msr, BIT_ULL(i));
			__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
			GUEST_ASSERT(rdmsr(global_status_msr) & BIT_ULL(i));

			wrmsr(global_ctrl_msr, 0);
			wrmsr(global_ovf_ctrl_msr, BIT_ULL(i));
			GUEST_ASSERT(!(rdmsr(global_status_msr) & BIT_ULL(i)));
		}
	}

