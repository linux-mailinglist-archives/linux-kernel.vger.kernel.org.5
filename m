Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E627F9BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjK0Iir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjK0ILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:11:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15E138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701072666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LRFAZ9apxG3OKuf3u6I165t31laXtJSoksx1EGskTkg=;
        b=f7plDmQu0HpSl+nec5RKOMwvxoL4FOBtCYgZH/XLf8c61oxcBp22TvaeKE0hAe+XnwUTuY
        hepkb34sv4x6Vn8LEL7plbpO81xZpLzNpZokwFl21eLwqQtnL0PoI/nC1ujLXHDi8hl1I2
        X50YD+3kaA6YRdlPT3wXzu7Q3MWwuI8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-4Y8KeXUuO9mfgOX9h6_5Sw-1; Mon, 27 Nov 2023 03:11:03 -0500
X-MC-Unique: 4Y8KeXUuO9mfgOX9h6_5Sw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77d85c600d6so267855985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072663; x=1701677463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRFAZ9apxG3OKuf3u6I165t31laXtJSoksx1EGskTkg=;
        b=Y0YcIWZ/8xXoEpS+70f5PfXNWdVYoHt3G57tCQD7C4z0MkjWHhRhF4z1YC2hNButXK
         P7tCWpQ8T8mf/Dk9nSjig+8I4ZePQbV85+DqQki9qwPnMoVzbEOaDPZIp5d86/F4FeIt
         mQHlRUUIJtZszaYqxanSFvYWTJRKlZDlGEFuflITCSiDYNBMJopTcfwmsIBpKF0IkDqD
         GNZ8bVs0OvXykcCoYDO2IrRC95jLVBY7C2rus4fxzp0S+yvfTLf6piSha/lb9y4HPAh8
         Htl1uSSQwsWvB+bf7buia1VdhMJjo3Nt4b2+1VPbbg7vT/WYQMPwZ8Dlj4WEfAlma7rm
         gFsA==
X-Gm-Message-State: AOJu0Yzh68U/OVdDdB8o7MwbhYLAMWQyt/q9WdooQl2C9P0UjikG7fH1
        KAO1mS1QLBuzhgna9Pu8M8q1UQOjPoYzrHhszuE0ssi+OBl8arcZN0hWi75EmLekPgdePjMiPnw
        jKXD/wBzLYXT1bMlcgMeqNpFY
X-Received: by 2002:ad4:4a6c:0:b0:67a:2b0b:d08d with SMTP id cn12-20020ad44a6c000000b0067a2b0bd08dmr5229820qvb.54.1701072663033;
        Mon, 27 Nov 2023 00:11:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAj4v9of3ED7pQIPANmOWyelRc3eQ4XWSia6yR3PaR297O8YTJ2EUwYRigrHUGPo5h9Cif8A==
X-Received: by 2002:ad4:4a6c:0:b0:67a:2b0b:d08d with SMTP id cn12-20020ad44a6c000000b0067a2b0bd08dmr5229804qvb.54.1701072662750;
        Mon, 27 Nov 2023 00:11:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id mg1-20020a056214560100b0067a3e703e3asm1039587qvb.37.2023.11.27.00.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:11:02 -0800 (PST)
Message-ID: <3c18a04a-2834-43ef-b857-e6ad8f0c5f41@redhat.com>
Date:   Mon, 27 Nov 2023 09:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To:     Shaoqin Huang <shahuang@redhat.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231123063750.2176250-1-shahuang@redhat.com>
 <20231123063750.2176250-4-shahuang@redhat.com>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20231123063750.2176250-4-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin,

On 11/23/23 07:37, Shaoqin Huang wrote:
> Introduce pmu_event_filter_test for arm64 platforms. The test configures
> PMUv3 for a vCPU, and sets different pmu event filter for the vCPU, and
filters
> check if the guest can use those events which user allow and can't use
> those events which use deny.
> 
> This test refactor the create_vpmu_vm() and make it a wrapper for
> __create_vpmu_vm(), which can let we do some extra init before
which can let we do -> which allows some extra init code.
> KVM_ARM_VCPU_PMU_V3_INIT.
> 
> This test choose the branches_retired and the instructions_retired
> event, and let guest use the two events in pmu. And check if the result
Are you sure those events are supported?
> is expected.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/aarch64/pmu_event_filter_test.c       | 227 ++++++++++++++++++
>  .../selftests/kvm/include/aarch64/vpmu.h      |   4 +
>  .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  14 +-
>  4 files changed, 244 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index b60852c222ac..5f126e1a1dbf 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -155,6 +155,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/arch_timer
>  TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
>  TEST_GEN_PROGS_aarch64 += aarch64/hypercalls
>  TEST_GEN_PROGS_aarch64 += aarch64/page_fault_test
> +TEST_GEN_PROGS_aarch64 += aarch64/pmu_event_filter_test
>  TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>  TEST_GEN_PROGS_aarch64 += aarch64/set_id_regs
>  TEST_GEN_PROGS_aarch64 += aarch64/smccc_filter
> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> new file mode 100644
> index 000000000000..a876f5c2033b
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pmu_event_filter_test - Test user limit pmu event for guest.
> + *
> + * Copyright (c) 2023 Red Hat, Inc.
> + *
> + * This test checks if the guest only see the limited pmu event that userspace
sees
> + * sets, if the gust can use those events which user allow, and if the guest
s/gust/guest
> + * can't use those events which user deny.
> + * It also checks set invalid filter return the expected error.
it also checks that setting invalid filter ranges ...
> + * This test runs only when KVM_CAP_ARM_PMU_V3 is supported on the host.
> + */
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include <vgic.h>
> +#include <vpmu.h>
> +#include <test_util.h>
> +#include <perf/arm_pmuv3.h>
> +
> +struct {
> +	uint64_t branches_retired;
> +	uint64_t instructions_retired;
> +} pmc_results;
> +
> +static struct vpmu_vm *vpmu_vm;
> +
> +#define FILTER_NR 10
> +
> +struct test_desc {
> +	const char *name;
> +	void (*check_result)(void);
> +	struct kvm_pmu_event_filter filter[FILTER_NR];
> +};
> +
> +#define __DEFINE_FILTER(base, num, act)		\
> +	((struct kvm_pmu_event_filter) {	\
> +		.base_event	= base,		\
> +		.nevents	= num,		\
> +		.action		= act,		\
> +	})
> +
> +#define DEFINE_FILTER(base, act) __DEFINE_FILTER(base, 1, act)
> +
> +#define EMPTY_FILTER	{ 0 }
> +
> +#define SW_INCR		0x0
> +#define INST_RETIRED	0x8
> +#define BR_RETIERD	0x21
looks like a typo
> +
> +#define NUM_BRANCHES	10
> +
> +static void run_and_measure_loop(void)
> +{
> +	asm volatile(
> +		"	mov	x10, %[loop]\n"
> +		"1:	sub	x10, x10, #1\n"
> +		"	cmp	x10, #0x0\n"
> +		"	b.gt	1b\n"
> +		:
> +		: [loop] "r" (NUM_BRANCHES)
> +		: "x10", "cc");
> +}
> +
> +static void guest_code(void)
> +{
> +	uint64_t pmcr = read_sysreg(pmcr_el0);
> +
> +	pmu_disable_reset();
> +
> +	write_pmevtypern(0, BR_RETIERD);
> +	write_pmevtypern(1, INST_RETIRED);
> +	enable_counter(0);
> +	enable_counter(1);
> +	write_sysreg(pmcr | ARMV8_PMU_PMCR_E, pmcr_el0);
> +
> +	run_and_measure_loop();
> +
> +	write_sysreg(pmcr, pmcr_el0);
> +
> +	pmc_results.branches_retired = read_sysreg(pmevcntr0_el0);
> +	pmc_results.instructions_retired = read_sysreg(pmevcntr1_el0);
> +
> +	GUEST_DONE();
another direct way to see if the guest can use those filters is to read
the PMCEIDx that indicates whether an event is supported.

> +}
> +
> +static void pmu_event_filter_init(struct vpmu_vm *vm, void *arg)
> +{
> +	struct kvm_device_attr attr = {
> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
> +	};
> +	struct kvm_pmu_event_filter *filter = (struct kvm_pmu_event_filter *)arg;
> +
> +	while (filter && filter->nevents != 0) {
> +		attr.addr = (uint64_t)filter;
> +		vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +		filter++;
> +	}
> +}
> +
> +static void create_vpmu_vm_with_filter(void *guest_code,
> +				       struct kvm_pmu_event_filter *filter)
> +{
> +	vpmu_vm = __create_vpmu_vm(guest_code, pmu_event_filter_init, filter);
> +}
> +
> +static void run_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct ucall uc;
> +
> +	while (1) {
> +		vcpu_run(vcpu);
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_DONE:
> +			return;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	}
> +}
> +
> +static void check_pmc_counting(void)
> +{
> +	uint64_t br = pmc_results.branches_retired;
> +	uint64_t ir = pmc_results.instructions_retired;
> +
> +	TEST_ASSERT(br && br == NUM_BRANCHES, "Branch instructions retired = "
> +		    "%lu (expected %u)", br, NUM_BRANCHES);
> +	TEST_ASSERT(ir, "Instructions retired = %lu (expected > 0)", ir);
> +}
> +
> +static void check_pmc_not_counting(void)
> +{
> +	uint64_t br = pmc_results.branches_retired;
> +	uint64_t ir = pmc_results.instructions_retired;
> +
> +	TEST_ASSERT(!br, "Branch instructions retired = %lu (expected 0)", br);
> +	TEST_ASSERT(!ir, "Instructions retired = %lu (expected 0)", ir);
> +}
> +
> +static void run_vcpu_and_sync_pmc_results(void)
> +{
> +	memset(&pmc_results, 0, sizeof(pmc_results));
> +	sync_global_to_guest(vpmu_vm->vm, pmc_results);
> +
> +	run_vcpu(vpmu_vm->vcpu);
> +
> +	sync_global_from_guest(vpmu_vm->vm, pmc_results);
> +}
> +
> +static void run_test(struct test_desc *t)
> +{
> +	pr_debug("Test: %s\n", t->name);
> +
> +	create_vpmu_vm_with_filter(guest_code, t->filter);
> +
> +	run_vcpu_and_sync_pmc_results();
> +
> +	t->check_result();
> +
> +	destroy_vpmu_vm(vpmu_vm);
> +}
> +
> +static struct test_desc tests[] = {
> +	{"without_filter", check_pmc_counting, { EMPTY_FILTER }},
> +	{"member_allow_filter", check_pmc_counting,
> +	 {DEFINE_FILTER(SW_INCR, 0), DEFINE_FILTER(INST_RETIRED, 0),
> +	  DEFINE_FILTER(BR_RETIERD, 0), EMPTY_FILTER}},
> +	{"member_deny_filter", check_pmc_not_counting,
> +	 {DEFINE_FILTER(SW_INCR, 1), DEFINE_FILTER(INST_RETIRED, 1),
> +	  DEFINE_FILTER(BR_RETIERD, 1), EMPTY_FILTER}},
> +	{"not_member_deny_filter", check_pmc_counting,
> +	 {DEFINE_FILTER(SW_INCR, 1), EMPTY_FILTER}},
> +	{"not_member_allow_filter", check_pmc_not_counting,
> +	 {DEFINE_FILTER(SW_INCR, 0), EMPTY_FILTER}},
> +	{ 0 }
> +};
> +
> +static void for_each_test(void)
> +{
> +	struct test_desc *t;
> +
> +	for (t = &tests[0]; t->name; t++)
> +		run_test(t);
> +}
> +
> +static void set_invalid_filter(struct vpmu_vm *vm, void *arg)
> +{
> +	struct kvm_pmu_event_filter invalid;
> +	struct kvm_device_attr attr = {
> +		.group	= KVM_ARM_VCPU_PMU_V3_CTRL,
> +		.attr	= KVM_ARM_VCPU_PMU_V3_FILTER,
> +		.addr	= (uint64_t)&invalid,
> +	};
> +	int ret = 0;
> +
> +	/* The max event number is (1 << 16), set a range large than it. */
> +	invalid = __DEFINE_FILTER(BIT(15), BIT(15)+1, 0);
> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +
> +	ret = 0;
> +
> +	/* Set the Invalid action. */
> +	invalid = __DEFINE_FILTER(0, 1, 3);
> +	ret = __vcpu_ioctl(vm->vcpu, KVM_SET_DEVICE_ATTR, &attr);
> +	TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
> +		    "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
> +		    ret, errno);
> +}
> +
> +static void test_invalid_filter(void)
> +{
> +	vpmu_vm = __create_vpmu_vm(guest_code, set_invalid_filter, NULL);
> +	destroy_vpmu_vm(vpmu_vm);
> +}
> +
> +int main(void)
> +{
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
> +
> +	for_each_test();
> +
> +	test_invalid_filter();
I would introduce test_invalid_filter in a separate patch
> +}
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vpmu.h b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> index e0cc1ca1c4b7..db97bfb07996 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vpmu.h
> @@ -18,6 +18,10 @@ struct vpmu_vm {
>  	int gic_fd;
>  };
>  
> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
> +				 void *arg);
> +
>  struct vpmu_vm *create_vpmu_vm(void *guest_code);
>  
>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm);
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> index b3de8fdc555e..76ea03d607f1 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> @@ -7,8 +7,9 @@
>  #include <vpmu.h>
>  #include <perf/arm_pmuv3.h>
>  
> -/* Create a VM that has one vCPU with PMUv3 configured. */
> -struct vpmu_vm *create_vpmu_vm(void *guest_code)
> +struct vpmu_vm *__create_vpmu_vm(void *guest_code,
> +				 void (*init_pmu)(struct vpmu_vm *vm, void *arg),
> +				 void *arg)
>  {
>  	struct kvm_vcpu_init init;
>  	uint8_t pmuver;
> @@ -50,12 +51,21 @@ struct vpmu_vm *create_vpmu_vm(void *guest_code)
>  		    "Unexpected PMUVER (0x%x) on the vCPU with PMUv3", pmuver);
>  
>  	/* Initialize vPMU */
> +	if (init_pmu)
> +		init_pmu(vpmu_vm, arg);
> +
>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &irq_attr);
>  	vcpu_ioctl(vpmu_vm->vcpu, KVM_SET_DEVICE_ATTR, &init_attr);
>  
>  	return vpmu_vm;
>  }
>  
> +/* Create a VM that has one vCPU with PMUv3 configured. */
> +struct vpmu_vm *create_vpmu_vm(void *guest_code)
> +{
> +	return __create_vpmu_vm(guest_code, NULL, NULL);
> +}
> +
>  void destroy_vpmu_vm(struct vpmu_vm *vpmu_vm)
>  {
>  	close(vpmu_vm->gic_fd);
Thanks

Eric

