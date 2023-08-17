Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB678016B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbjHQXAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355959AbjHQXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:00:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55670136
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:00:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840ea40c59so3915687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692313215; x=1692918015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9XJmLiXE6JxQMM9mAkJhB/HTrS1vF1omICC5aYPZ7A=;
        b=hN265fzlFQKXjMiD7KOs4HWWzI73D0u+7NDNkrrG5LkUDsZacPQ1h6sh+10i4TEMce
         L68MC5X5SNeKgcsAPtUR+v+YWDZmLb8QQkWIThm05QqIVpJw1l5t+X9QygH3qHC4rIf5
         nXwRIA1eRDN+N0zbMmEaBInj+gSYxl8CYjVuaNFL+fN2GqDiCjfCq5aXBAWk9ee2HWQD
         KxZEUTK4RYpmpdyS+7fntOAe6MtLioSbm9ctqNK5JiLV4FeCYYFt7XOE4G6bKznwEsYy
         8e1VleLy1a2t5SRv0yqojEHPZwQDeVwOV4895x9PiVlrzv7PijCDcTT/D60dyEnwFSfL
         ZvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692313215; x=1692918015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9XJmLiXE6JxQMM9mAkJhB/HTrS1vF1omICC5aYPZ7A=;
        b=Q//J4Y8qILd9QAk9u2FSr+JP4FYE+cGzGQGUyKuGVdr8HHcwymmlBDjMh6PzvpatEK
         hZ+OXp6ZZjBOpVIIY3VIbq6zW307LRx2gn65Nc6Afyw5R/td8MzT5Rqk4YkRf5LDb0s2
         oX9jCZNDPivaF5Shj9He7K2RSt86mgBwV95tXGyWAdKuq0lS7QmE/gcVbFJKq7uS6eC7
         wAM6DjQrQJMRrOugLQpov2SWJVTF2HojLAmE2913KXQooHZMaHr7539BWi6jI9DVk3i0
         yNQieJltj+Hzln1seaH2/iBGUq94QLekcdY1p716reUbQY5ySTYAcWLvgcgT5Oai7Iuu
         s8hQ==
X-Gm-Message-State: AOJu0Ywwaseivuhbd/brIVR/13MOwm/lAlHAdctp5IQBpRZNL0iVERsG
        3FG4X5/Pk/P/wAqaQzRUq7SrKcin7wA=
X-Google-Smtp-Source: AGHT+IEEsGqNZuu+ljySXqZkdQSHq+hyfgN/4X/KEAIA34ql0t9z+EXa9/X5apHy3dMlHxdtdvf89vQgeZY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4316:0:b0:57a:e0b:f63 with SMTP id
 q22-20020a814316000000b0057a0e0b0f63mr10657ywa.7.1692313215618; Thu, 17 Aug
 2023 16:00:15 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:00:13 -0700
In-Reply-To: <20230814115108.45741-6-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230814115108.45741-1-cloudliang@tencent.com> <20230814115108.45741-6-cloudliang@tencent.com>
Message-ID: <ZN6mfSWLScLjdyCz@google.com>
Subject: Re: [PATCH v3 05/11] KVM: selftests: Test consistency of CPUID with
 num of gp counters
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> Add test to check if non-existent counters can be accessed in guest after
> determining the number of Intel generic performance counters by CPUID.
> When the num of counters is less than 3, KVM does not emulate #GP if
> a counter isn't present due to compatibility MSR_P6_PERFCTRx handling.
> Nor will the KVM emulate more counters than it can support.
> 
> Co-developed-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  .../kvm/x86_64/pmu_basic_functionality_test.c | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c b/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> index daa45aa285bb..b86033e51d5c 100644
> --- a/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/pmu_basic_functionality_test.c
> @@ -16,6 +16,11 @@
>  /* Guest payload for any performance counter counting */
>  #define NUM_BRANCHES			10
>  
> +static const uint64_t perf_caps[] = {
> +	0,
> +	PMU_CAP_FW_WRITES,
> +};
> +
>  static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
>  						  void *guest_code)
>  {
> @@ -164,6 +169,78 @@ static void intel_test_arch_events(void)
>  	}
>  }
>  
> +static void guest_wr_and_rd_msrs(uint32_t base, uint8_t begin, uint8_t offset)
> +{
> +	uint8_t wr_vector, rd_vector;
> +	uint64_t msr_val;
> +	unsigned int i;
> +
> +	for (i = begin; i < begin + offset; i++) {
> +		wr_vector = wrmsr_safe(base + i, 0xffff);
> +		rd_vector = rdmsr_safe(base + i, &msr_val);
> +		if (wr_vector == GP_VECTOR || rd_vector == GP_VECTOR)
> +			GUEST_SYNC(GP_VECTOR);

Rather than pass around the "expected" vector, and shuffle #GP vs. the msr_val
up (which can get false negatives if msr_val == 13), just read
MSR_IA32_PERF_CAPABILITIES from within the guest and GUEST_ASSERT accordingly.
