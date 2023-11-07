Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF8A7E4828
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbjKGSWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbjKGSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973012B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699381283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+GcT82eNb/SFzSP35zWzQQO+F/hul/YMHV+lLW3et8=;
        b=Is1/D5kUnkhrpjV9fQlqSvuyScmKX9Y6VSnynRCNv983zdmaBeqYxz6hdxkp0iDKRVt7nz
        trfdiY7i2EYplQjutc04MVm1forjtD3nfGHx/llyCkbE0unu9z1xTeV/CAL2/or990W/zO
        UGF7wkNj4mX2DSVt6hik2eOXwvphCp4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-P3JX9Ab4O6-w8vCFDTykNA-1; Tue, 07 Nov 2023 13:21:21 -0500
X-MC-Unique: P3JX9Ab4O6-w8vCFDTykNA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4084d0b171eso43389545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381280; x=1699986080;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+GcT82eNb/SFzSP35zWzQQO+F/hul/YMHV+lLW3et8=;
        b=C7vNJ1CkcL+5ykkncq+vmOMcLmHuB81hxCgc/I4jMKIMcvrw/FeuaeHkdMnBE2OX+K
         /Riep+B4XMazj53ElGMw5qpVT/PayKrluxXfQVjrVi8AMeYQuwejkGl7iz2zf3TMeK43
         Z6SIVmflUe//wVWYU/hqryZOulmTeG00Jd8HjniqCMss19JnHeU3Xr6IKtbepj7HQLGd
         wdGmtnIYtnx8dvwdt1iUQUUWRtfjHEC9N9dYSoyRpOZrSAiQDuu+8IRUkU0XnqcBRhG0
         c6AmNJXWQJFvjgV3MqLJtokeXuse7DxSvrDPRX1kIWdC/HIcop5jtnYQQEs2btD+sEuL
         Fp7A==
X-Gm-Message-State: AOJu0YyAtXrVuj5hirLUe850Z9l+k8wpRv73RwwkjUndbGgvC/82bixY
        bWVl1ytuDKAYBhNAy1Cly2Qzz+MAobpXNGkaztIdmY7G/oHx4ua1zRH9B/nq1u/ex7mqFphOS8Y
        LUReM+0tLn3j2m9WH3QzC/voR
X-Received: by 2002:a05:600c:3d9a:b0:407:5de2:ea4d with SMTP id bi26-20020a05600c3d9a00b004075de2ea4dmr4385270wmb.13.1699381280077;
        Tue, 07 Nov 2023 10:21:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgebMStnVPX77gZSwX8QEuIQGBlqWLIcaSuttikvXYt02mLAiVSykG1hMPfysRMfSBsxMJnw==
X-Received: by 2002:a05:600c:3d9a:b0:407:5de2:ea4d with SMTP id bi26-20020a05600c3d9a00b004075de2ea4dmr4385247wmb.13.1699381279673;
        Tue, 07 Nov 2023 10:21:19 -0800 (PST)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id i12-20020a05600c354c00b004042dbb8925sm16551465wmq.38.2023.11.07.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:21:19 -0800 (PST)
Message-ID: <cefa30d9728704a0f5c50cb61412978d60cac3d6.camel@redhat.com>
Subject: Re: [PATCH 02/14] KVM: x86: hyper-v: Move Hyper-V partition assist
 page out of Hyper-V emulation context
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 20:21:17 +0200
In-Reply-To: <20231025152406.1879274-3-vkuznets@redhat.com>
References: <20231025152406.1879274-1-vkuznets@redhat.com>
         <20231025152406.1879274-3-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 17:23 +0200, Vitaly Kuznetsov wrote:
> Hyper-V partition assist page is used when KVM runs on top of Hyper-V and
> is not used for Windows/Hyper-V guests on KVM, this means that 'hv_pa_pg'
> placement in 'struct kvm_hv' is unfortunate. As a preparation to making
> Hyper-V emulation optional, move 'hv_pa_pg' to 'struct kvm_arch' and put it
> under CONFIG_HYPERV.
> 
> While on it, introduce hv_get_partition_assist_page() helper to allocate
> partition assist page. Move the comment explaining why we use a single page
> for all vCPUs from VMX and expand it a bit.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/kvm_onhyperv.h     | 20 ++++++++++++++++++++
>  arch/x86/kvm/svm/svm_onhyperv.c | 10 +++-------
>  arch/x86/kvm/vmx/vmx.c          | 14 +++-----------
>  arch/x86/kvm/x86.c              |  4 +++-
>  5 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d107516b4591..7fb2810f4573 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1125,7 +1125,6 @@ struct kvm_hv {
>  	 */
>  	unsigned int synic_auto_eoi_used;
>  
> -	struct hv_partition_assist_pg *hv_pa_pg;
>  	struct kvm_hv_syndbg hv_syndbg;
>  };
>  
> @@ -1447,6 +1446,7 @@ struct kvm_arch {
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t	hv_root_tdp;
>  	spinlock_t hv_root_tdp_lock;
> +	struct hv_partition_assist_pg *hv_pa_pg;
>  #endif
>  	/*
>  	 * VM-scope maximum vCPU ID. Used to determine the size of structures
> diff --git a/arch/x86/kvm/kvm_onhyperv.h b/arch/x86/kvm/kvm_onhyperv.h
> index f9ca3e7432b2..eefab3dc8498 100644
> --- a/arch/x86/kvm/kvm_onhyperv.h
> +++ b/arch/x86/kvm/kvm_onhyperv.h
> @@ -10,6 +10,26 @@
>  int hv_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, gfn_t nr_pages);
>  int hv_flush_remote_tlbs(struct kvm *kvm);
>  void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp);
> +static inline hpa_t hv_get_partition_assist_page(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Partition assist page is something which Hyper-V running in L0
> +	 * requires from KVM running in L1 before direct TLB flush for L2
> +	 * guests can be enabled. KVM doesn't currently use the page but to
> +	 * comply with TLFS it still needs to be allocated. For now, this
> +	 * is a single page shared among all vCPUs.
Perfect!

> +	 */
> +	struct hv_partition_assist_pg **p_hv_pa_pg =
> +		&vcpu->kvm->arch.hv_pa_pg;
> +
> +	if (!*p_hv_pa_pg)
> +		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
> +
> +	if (!*p_hv_pa_pg)
> +		return INVALID_PAGE;
> +
> +	return __pa(*p_hv_pa_pg);
> +}
>  #else /* !CONFIG_HYPERV */
>  static inline int hv_flush_remote_tlbs(struct kvm *kvm)
>  {
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.c b/arch/x86/kvm/svm/svm_onhyperv.c
> index 7af8422d3382..3971b3ea5d04 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.c
> +++ b/arch/x86/kvm/svm/svm_onhyperv.c
> @@ -18,18 +18,14 @@
>  int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	struct hv_vmcb_enlightenments *hve;
> -	struct hv_partition_assist_pg **p_hv_pa_pg =
> -			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
> +	hpa_t partition_assist_page = hv_get_partition_assist_page(vcpu);
>  
> -	if (!*p_hv_pa_pg)
> -		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL);
> -
> -	if (!*p_hv_pa_pg)
> +	if (partition_assist_page == INVALID_PAGE)
>  		return -ENOMEM;
>  
>  	hve = &to_svm(vcpu)->vmcb->control.hv_enlightenments;
>  
> -	hve->partition_assist_page = __pa(*p_hv_pa_pg);
> +	hve->partition_assist_page = partition_assist_page;
>  	hve->hv_vm_id = (unsigned long)vcpu->kvm;
>  	if (!hve->hv_enlightenments_control.nested_flush_hypercall) {
>  		hve->hv_enlightenments_control.nested_flush_hypercall = 1;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index be20a60047b1..cb4591405f14 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -523,22 +523,14 @@ module_param(enlightened_vmcs, bool, 0444);
>  static int hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	struct hv_enlightened_vmcs *evmcs;
> -	struct hv_partition_assist_pg **p_hv_pa_pg =
> -			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
> -	/*
> -	 * Synthetic VM-Exit is not enabled in current code and so All
> -	 * evmcs in singe VM shares same assist page.
> -	 */
> -	if (!*p_hv_pa_pg)
> -		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
> +	hpa_t partition_assist_page = hv_get_partition_assist_page(vcpu);
>  
> -	if (!*p_hv_pa_pg)
> +	if (partition_assist_page == INVALID_PAGE)
>  		return -ENOMEM;
>  
>  	evmcs = (struct hv_enlightened_vmcs *)to_vmx(vcpu)->loaded_vmcs->vmcs;
>  
> -	evmcs->partition_assist_page =
> -		__pa(*p_hv_pa_pg);
> +	evmcs->partition_assist_page = partition_assist_page;
>  	evmcs->hv_vm_id = (unsigned long)vcpu->kvm;
>  	evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d632931fa545..cc2524598368 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12425,7 +12425,9 @@ void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
>  
>  void kvm_arch_free_vm(struct kvm *kvm)
>  {
> -	kfree(to_kvm_hv(kvm)->hv_pa_pg);
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	kfree(kvm->arch.hv_pa_pg);
> +#endif
>  	__kvm_arch_free_vm(kvm);
>  }
>  


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


