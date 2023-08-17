Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE10780143
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355830AbjHQWrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355840AbjHQWqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:46:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50B26B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:46:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso393201276.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692312392; x=1692917192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=swYqgwduqO6eLHFD+VCN0AC3Mc2aAZcD3AIHqYw6yfU=;
        b=vlvOQGMb6CEYk13VnD1S32tL8aALqQXm5XWKUWZJxejaQQUOAT5Gl7RCrXWoD6X6cu
         yqvNEbnGsG2ZF0dnSibV8qNCqlIWvahLTDQyGAGvi9FR25zVPdQSLW/UFNPScYkp68q+
         s+wRhMKrVzogv+6Xin87ucXOwITPgHuQcIQ4r6aSHtcni/mAmLhkU6m/wmTWd5Hi5e+a
         ZBwvwbR+3F/oDDP5e7DXojEI94T3xXTqY5MSl2ERjefKPK4h+JaAxZdHzbwtBtClN4+J
         7rh9dXBrb/J/bixdH4l0c1pbPCOBWROSDb1wCJzHXBDTs0sf9P3xIPdKaCTnhsttrC1x
         ibgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312392; x=1692917192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swYqgwduqO6eLHFD+VCN0AC3Mc2aAZcD3AIHqYw6yfU=;
        b=deDlFO4Cyoq6jWiqPTySPVMbzRzWR3Ex6YcUdTBTGl5/kI5JWAq3WPJGmODjIPAM4u
         YsFeF/RzEYc60fE7L9ygBHevdbt/Va1b9wgQFWPxRKlIZDrmqGpuCJpK+mzQv4OBtYmD
         o5euqtEUivqB8MJp8C+j3O6pQ5038S4sMEw4j1xMTiRkaK2tQGW/+hx3XuFa4bZflBof
         kPCJp4WrrCLjn6V0caBcnQ7flwAvep8BN2rKAh0QxOihx9LzXBM5XYNYjqFyxMPlUHaL
         3ha/cUbKGzjXOJB5QIJGQd3Odvbe5C8/sEbG6zFUjFeigD0+59cpgsMKmKkpHWNrbQCD
         ChbQ==
X-Gm-Message-State: AOJu0YyZ8AakfN03ApGyYOannz9sqPibTM1zd4qfq/Zry504Lfj9qFNR
        EYYzk2ac6wClD8CrD+A0nS8j8vy2eJk=
X-Google-Smtp-Source: AGHT+IHmxgJVeHDIKPz0PlhluHRiv7ATQYGIGqOBicmcvJw6DK1eDJr9wi9jnMIAbyyzVlqg0FZJ1NSbxP4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10cd:b0:d15:d6da:7e97 with SMTP id
 w13-20020a05690210cd00b00d15d6da7e97mr15319ybu.3.1692312392446; Thu, 17 Aug
 2023 15:46:32 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:46:31 -0700
In-Reply-To: <20230814115108.45741-4-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230814115108.45741-1-cloudliang@tencent.com> <20230814115108.45741-4-cloudliang@tencent.com>
Message-ID: <ZN6jR6+jFBLLh3id@google.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, Jinrong Liang wrote:
> +static void test_arch_events_cpuid(struct kvm_vcpu *vcpu,
> +				   uint8_t arch_events_bitmap_size,
> +				   uint8_t arch_events_unavailable_mask,
> +				   uint8_t idx)
> +{
> +	uint64_t counter_val = 0;
> +	bool is_supported;
> +
> +	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
> +				arch_events_bitmap_size);
> +	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EVENTS_MASK,
> +				arch_events_unavailable_mask);
> +
> +	is_supported = arch_event_is_supported(vcpu, idx);
> +	vcpu_args_set(vcpu, 1, intel_arch_events[idx]);
> +
> +	while (run_vcpu(vcpu, &counter_val) != UCALL_DONE)
> +		TEST_ASSERT_EQ(is_supported, !!counter_val);
> +}
> +
> +static void intel_check_arch_event_is_unavl(uint8_t idx)
> +{
> +	uint8_t eax_evt_vec, ebx_unavl_mask, i, j;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	/*
> +	 * A brute force iteration of all combinations of values is likely to
> +	 * exhaust the limit of the single-threaded thread fd nums, so it's
> +	 * tested here by iterating through all valid values on a single bit.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(intel_arch_events); i++) {
> +		eax_evt_vec = BIT_ULL(i);
> +		for (j = 0; j < ARRAY_SIZE(intel_arch_events); j++) {
> +			ebx_unavl_mask = BIT_ULL(j);
> +			vm = pmu_vm_create_with_one_vcpu(&vcpu,
> +							 guest_measure_loop);
> +			test_arch_events_cpuid(vcpu, eax_evt_vec,
> +					       ebx_unavl_mask, idx);
> +
> +			kvm_vm_free(vm);

This is messy.  If you're going to use a helper, then use the helper.  If not,
then open code everything.  Half and half just makes everything unnecessarily
hard to follow.  E.g. if you reorganize things, and move even more checks into
the guest, I think you can end up with:


static void test_arch_events_cpuid(uint8_t i, uint8_t j, uint8_t idx)
{
	uint8_t eax_evt_vec = BIT_ULL(i);
	uint8_t ebx_unavl_mask = BIT_ULL(j);
	struct kvm_vcpu *vcpu;
	struct kvm_vm *vm;

	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_measure_loop);

	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
				arch_events_bitmap_size);
	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EVENTS_MASK,
				arch_events_unavailable_mask);

	vcpu_args_set(vcpu, 1, idx);

	run_vcpu(vcpu, &counter_val)

	kvm_vm_free(vm);
}

static void intel_check_arch_event_is_unavl(uint8_t idx)
{
	/*
	 * A brute force iteration of all combinations of values is likely to
	 * exhaust the limit of the single-threaded thread fd nums, so it's
	 * tested here by iterating through all valid values on a single bit.
	 */
	for (i = 0; i < ARRAY_SIZE(intel_arch_events); i++) {
		eax_evt_vec = BIT_ULL(i);
		for (j = 0; j < ARRAY_SIZE(intel_arch_events); j++)
			test_arch_events_cpuid(i, j, idx);
	}
}
