Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790607DD517
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376413AbjJaRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376395AbjJaRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8285AE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9eJnmdZvlfUltYnnbp/aAXrD+JoS5JYlY6ATNZvCHFI=;
        b=g/bw9ZDPyIS0ezI4Wa8lxOfa4J3Dz+YAYHajGjsrsLuiB+3zsw9ZPzY2zNv/DAK8c50tJN
        w6ye7jM7ZhNESQB7wbB4vRKVudpDA8QzT7UFY8Z2DieYwLnl4P5F55CI4Zk5AlU+CgKMhK
        0gRGhUwhBZY2FpUUmk1gFPyYqsEmeVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-FNVSUj22M7K9zNw2I5zTFQ-1; Tue, 31 Oct 2023 13:46:17 -0400
X-MC-Unique: FNVSUj22M7K9zNw2I5zTFQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f798bc811so1896680f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774376; x=1699379176;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eJnmdZvlfUltYnnbp/aAXrD+JoS5JYlY6ATNZvCHFI=;
        b=Q8aHtRHI8yPF3OQqeKma9FFazMbTlpzZMNxsA/hN/Xkm9+F2v0ars6uYXiXLqOZ+4A
         4BjNEey3vBDkbqq9zKB7FJmV9pgi/PREGRa/DpOAjVSyXFJHrp22M8tdNfuJGHOVvx0U
         mK3iMvC/Rtvqhbunysn9hgDLlwz9y1htEwTkOLRdHCRsVV4F2NC+tXLLCqboI5DT1CGN
         OI7GeQb+RjrTnbBOHRjHdpob2bbiexll10RzG7y4/BH2YW4TfnVlinsYXtXupxa5VLNu
         x6ws83d6/vmM9fYjhOXDzCdVHaqCTc80KRVoxu11+dthM3Yel9hxRnKQLrYBgd4xpbqD
         vPRg==
X-Gm-Message-State: AOJu0YwUA5ALZ05vPby7NnIcWpuEGVMhJtnUAizjp1//0lWrKya9+o/g
        23B0M9lCX1bhA3iwmDPcxZ+iyUksGtj/Ye24cYS7bWkwvXwMVXwPyEDvla6FA+vUtgMltlfQt2s
        VGzxjISpQdVSeaMEmDrgkd4ft
X-Received: by 2002:adf:d1e8:0:b0:32f:7d50:267e with SMTP id g8-20020adfd1e8000000b0032f7d50267emr8510235wrd.9.1698774376199;
        Tue, 31 Oct 2023 10:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBGk+UqYXsznUvi87oO1eunbW/LBpS669Tvct1t1nFtH2y3AXqLHPjdDe5QKqs0vAbC6Y/TA==
X-Received: by 2002:adf:d1e8:0:b0:32f:7d50:267e with SMTP id g8-20020adfd1e8000000b0032f7d50267emr8510228wrd.9.1698774376009;
        Tue, 31 Oct 2023 10:46:16 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5412000000b0032da022855fsm1990174wrv.111.2023.10.31.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:46:15 -0700 (PDT)
Message-ID: <96c30a78fa95071e87045b7293c2cf796d4182a0.camel@redhat.com>
Subject: Re: [PATCH v6 09/25] KVM: x86: Rework cpuid_get_supported_xcr0() to
 operate on vCPU data
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:46:13 +0200
In-Reply-To: <20230914063325.85503-10-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-10-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Rework and rename cpuid_get_supported_xcr0() to explicitly operate on vCPU
> state, i.e. on a vCPU's CPUID state.  Prior to commit 275a87244ec8 ("KVM:
> x86: Don't adjust guest's CPUID.0x12.1 (allowed SGX enclave XFRM)"), KVM
> incorrectly fudged guest CPUID at runtime,
Can you explain how commit 275a87244ec8 relates to this patch?


>  which in turn necessitated
> massaging the incoming CPUID state for KVM_SET_CPUID{2} so as not to run
> afoul of kvm_cpuid_check_equal().

Can you link the commit that added this 'massaging' and explain on how this relates to this patch?

Can you explain what is the problem that this patch is trying to solve?


Is it really allowed in x86 spec to have different supported mask of XCR0 bits
on different CPUs (assuming all CPUs of the same type)?

If true, does KVM supports it?

Assuming that the answer to the above questions is no, won't this patch make it easier
to break this rule and thus make it easier to introduce a bug?

Best regards,
	Maxim Levitsky

> 
> Opportunistically move the helper below kvm_update_cpuid_runtime() to make
> it harder to repeat the mistake of querying supported XCR0 for runtime
> updates.

> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0544e30b4946..7c3e4a550ca7 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -247,21 +247,6 @@ void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
>  		vcpu->arch.pv_cpuid.features = best->eax;
>  }
>  
> -/*
> - * Calculate guest's supported XCR0 taking into account guest CPUID data and
> - * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
> - */
> -static u64 cpuid_get_supported_xcr0(struct kvm_cpuid_entry2 *entries, int nent)
> -{
> -	struct kvm_cpuid_entry2 *best;
> -
> -	best = cpuid_entry2_find(entries, nent, 0xd, 0);
> -	if (!best)
> -		return 0;
> -
> -	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
> -}
> -
>  static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *entries,
>  				       int nent)
>  {
> @@ -312,6 +297,21 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_update_cpuid_runtime);
>  
> +/*
> + * Calculate guest's supported XCR0 taking into account guest CPUID data and
> + * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
> + */
> +static u64 vcpu_get_supported_xcr0(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_cpuid_entry2 *best;
> +
> +	best = kvm_find_cpuid_entry_index(vcpu, 0xd, 0);
> +	if (!best)
> +		return 0;
> +
> +	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
> +}
> +
>  static bool kvm_cpuid_has_hyperv(struct kvm_cpuid_entry2 *entries, int nent)
>  {
>  	struct kvm_cpuid_entry2 *entry;
> @@ -357,8 +357,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		kvm_apic_set_version(vcpu);
>  	}
>  
> -	vcpu->arch.guest_supported_xcr0 =
> -		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
> +	vcpu->arch.guest_supported_xcr0 = vcpu_get_supported_xcr0(vcpu);
>  
>  	/*
>  	 * FP+SSE can always be saved/restored via KVM_{G,S}ET_XSAVE, even if





