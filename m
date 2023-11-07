Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50A7E4833
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKGSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjKGSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F58125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699381422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1vp3UJWW6xNI7hxA0xI2ABX05SkVUa/IjbZ1CJ7y6hs=;
        b=ME1PwZYEfOTByvrQGMHewub8mJorcnt7sswC06uQ3UBJRX9hi21PlfoXvxum8h8iCCfFCY
        Sc3iYKHjA8/d7AKQ67lzbLArgjpLR2fUpsz+Kfy6t5YJkqYjbrhitjnSU/BkD7UPrPUofz
        86wv3L5Yh6QbhWgkT55jXGMCyyceM6Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-ESxPUuRcMEiF7C8f_MwFUA-1; Tue, 07 Nov 2023 13:23:36 -0500
X-MC-Unique: ESxPUuRcMEiF7C8f_MwFUA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507d2e150c2so6505407e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381414; x=1699986214;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vp3UJWW6xNI7hxA0xI2ABX05SkVUa/IjbZ1CJ7y6hs=;
        b=OyRK4CFdRKeQhk3N/9TaC/IbofX18+7yTf6IBTFF0LztBwsU7angj+h2t66AJ7sO4t
         QIeD19EU0vsRrp/1wAZ/amSUv536FMvAi/GVYvXAN8uOjyTO7cZ3CfeSpCon3y3C8Q3B
         rJHsOJk54XphWi6FB12bzN2z5FjWeKzQnaLZ/n2nmCBq7USCduXxQmkPnwoe+6Cl80nU
         11uo/Kte1I+Lp70q2pax6FHi8sYxr0OgRIHf7mBaUaOKErzRflmTcCQRFNcPhNrECocO
         dzyB0uIQtP7MI5/M2xbnpHxrjwh8c6SW5OCtMlsYH+r5nN56MpX43T04gy64qM12CAe7
         yDZQ==
X-Gm-Message-State: AOJu0Yxuap7GzzU8YShBsVKfwhYIM7tt70UIeoD9/UjY4qDOnnfT9NS0
        HwziGj+S3ov9M4BE6tiM5bNXu4VC0w7/Dha3a1EP0wlV3fVUf+NJOeQ+LdrCfb9i3jBk+LxFlGb
        jv5Lrd7vC51Q4ix3BOO1pPxLoO3h2xNSh
X-Received: by 2002:ac2:446e:0:b0:4fe:2f8a:457e with SMTP id y14-20020ac2446e000000b004fe2f8a457emr24771975lfl.43.1699381414703;
        Tue, 07 Nov 2023 10:23:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHfGpg0Oqo9JaFHN93kZteH1RvotcM0JNyFXc1rpSwlPcfpg8yP3XK27S2xPSaFc172VIgSg==
X-Received: by 2002:ac2:446e:0:b0:4fe:2f8a:457e with SMTP id y14-20020ac2446e000000b004fe2f8a457emr24771965lfl.43.1699381414310;
        Tue, 07 Nov 2023 10:23:34 -0800 (PST)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id k8-20020adfe8c8000000b0032d9caeab0fsm3020598wrn.77.2023.11.07.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:23:33 -0800 (PST)
Message-ID: <5aea3131a1166e30e12f9a5ef490327607219193.camel@redhat.com>
Subject: Re: [PATCH 08/14] KVM: selftests: Make all Hyper-V tests explicitly
 dependent on Hyper-V emulation support in KVM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 20:23:32 +0200
In-Reply-To: <20231025152406.1879274-9-vkuznets@redhat.com>
References: <20231025152406.1879274-1-vkuznets@redhat.com>
         <20231025152406.1879274-9-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 17:24 +0200, Vitaly Kuznetsov wrote:
> In preparation for conditional Hyper-V emulation enablement in KVM, make
> Hyper-V specific tests check skip gracefully instead of failing when the
> support is not there.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/x86_64/hyperv_clock.c            | 2 ++
>  tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c            | 5 +++--
>  .../selftests/kvm/x86_64/hyperv_extended_hypercalls.c        | 2 ++
>  tools/testing/selftests/kvm/x86_64/hyperv_features.c         | 2 ++
>  tools/testing/selftests/kvm/x86_64/hyperv_ipi.c              | 2 ++
>  tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c         | 1 +
>  tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c        | 2 ++
>  7 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> index f25749eaa6a8..f5e1e98f04f9 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> @@ -211,6 +211,8 @@ int main(void)
>  	vm_vaddr_t tsc_page_gva;
>  	int stage;
>  
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_TIME));
> +
Makes sense.
>  	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
>  
>  	vcpu_set_hv_cpuid(vcpu);
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> index 7bde0c4dfdbd..4c7257ecd2a6 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
> @@ -240,11 +240,12 @@ int main(int argc, char *argv[])
>  	struct ucall uc;
>  	int stage;
>  
> -	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> -
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
>  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
>  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_DIRECT_TLBFLUSH));

The test indeed uses the direct TLB flush.

It might be a good idea in the future to rename the test to hyperv_nested_vmx or something like
that because it tests more than just the evmcs.
It's not urgent though.

> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
>  
>  	hcall_page = vm_vaddr_alloc_pages(vm, 1);
>  	memset(addr_gva2hva(vm, hcall_page), 0x0,  getpagesize());
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> index e036db1f32b9..949e08e98f31 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_extended_hypercalls.c
> @@ -43,6 +43,8 @@ int main(void)
>  	uint64_t *outval;
>  	struct ucall uc;
>  
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
Yep, the test uses KVM_GET_SUPPORTED_HV_CPUID.
> +
>  	/* Verify if extended hypercalls are supported */
>  	if (!kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
>  			   HV_ENABLE_EXTENDED_HYPERCALLS)) {
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index 9f28aa276c4e..387c605a3077 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -690,6 +690,8 @@ static void guest_test_hcalls_access(void)
>  
>  int main(void)
>  {
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENFORCE_CPUID));
> +
Correct.
>  	pr_info("Testing access to Hyper-V specific MSRs\n");
>  	guest_test_msrs_access();
>  
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> index 6feb5ddb031d..65e5f4c05068 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
> @@ -248,6 +248,8 @@ int main(int argc, char *argv[])
>  	int stage = 1, r;
>  	struct ucall uc;
>  
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI));
Correct.
> +
>  	vm = vm_create_with_one_vcpu(&vcpu[0], sender_guest_code);
>  
>  	/* Hypercall input/output */
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> index 6c1278562090..c9b18707edc0 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
> @@ -158,6 +158,7 @@ int main(int argc, char *argv[])
>  	int stage;
>  
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_DIRECT_TLBFLUSH));

Maybe also rename the test in the future to hyperv_nested_svm or something like that,
for the same reason.

>  
>  	/* Create VM */
>  	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> index 4758b6ef5618..c4443f71f8dd 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c
> @@ -590,6 +590,8 @@ int main(int argc, char *argv[])
>  	struct ucall uc;
>  	int stage = 1, r, i;
>  
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_TLBFLUSH));
Also makes sense.

> +
>  	vm = vm_create_with_one_vcpu(&vcpu[0], sender_guest_code);
>  
>  	/* Test data page */


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



