Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A67C7701
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442189AbjJLTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjJLTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EBC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697139347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyDxJ2weX9wj5+HhkjpcK5+r0i9/2RaFRhYUoRUMap4=;
        b=cEbsjwTteW1lLKRyQ7yIfXEMCRxCW3suKOo1UJP5E1KmFeM3MK61evWAcMuAiP9rjTFU/X
        2Tu9VlTf7vwxzgYAdB5HFnWFjRSQEpADARbA1D+GLCKq7PBtTESqsmODf1y1QTFxnUU1KH
        +0KpBuhyW/9j+00/J/kZIz1CV9mdyfw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-hyifrvRHMs6_pc1iXPaTqw-1; Thu, 12 Oct 2023 15:35:45 -0400
X-MC-Unique: hyifrvRHMs6_pc1iXPaTqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4068bf75d0dso9915215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139344; x=1697744144;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyDxJ2weX9wj5+HhkjpcK5+r0i9/2RaFRhYUoRUMap4=;
        b=Mau+h8yDfIfxEMxrJkmSBw2Gft8J4RF75+bX9O5Rs41oi4apnHkwlcwij0KXWL/hru
         7r0kogYES+lXIRmskqyO6X0XSNWZK2svvgtNCjZCfaPDdnoCm/rpDSqBtno55d3ZcEnj
         CDubsHvXCqyH8lf3GKYpIm3O9AHRIUuf9J3N7uZ5/KxoPMPg/8iOUCbtqkTvLyur9Nd3
         JUGhiH5w4zLZjhsHUIkA8xI3q62mKTrKsrWUu9IwxaETvWnLGBl9fM1HNhRbZ2grnTgt
         f0EGnpPkTK92FLqBAekoscy2aKFE62T74YehXCBjDhWy95aIaAoJ/cvHB7Iz0JkfjzDl
         hHkQ==
X-Gm-Message-State: AOJu0YyFT5WVi4aXnRgJ2rOUObye91VYseXaIRorHF3zz2bCqrRNUzHb
        fFAhuknifOcb5otQLqZlSGR5C0BMt6xbYE413MuVZmPWtWNEt/A/tPFPrYhjcvRt3Pd+5iBGyoj
        XwzvbV0U4b3kBLtMC343G/Lid
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id k25-20020a05600c0b5900b00401b1c697dcmr22104596wmr.23.1697139343783;
        Thu, 12 Oct 2023 12:35:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNt4w4xIhi/1U+yGEiRDwZkG4z53aL4SYhjYPOONQk5qQtc7YHQr//1tdIDulpRLWyLIuIXQ==
X-Received: by 2002:a05:600c:b59:b0:401:b1c6:97dc with SMTP id k25-20020a05600c0b5900b00401b1c697dcmr22104589wmr.23.1697139343406;
        Thu, 12 Oct 2023 12:35:43 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b004063ea92492sm617994wmc.22.2023.10.12.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:35:43 -0700 (PDT)
Message-ID: <4c2b8ddc3b87818f0d752a91963e3895781902d8.camel@redhat.com>
Subject: Re: [PATCH RFC 02/11] KVM: x86: hyper-v: Move Hyper-V partition
 assist page out of Hyper-V emulation context
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 12 Oct 2023 22:35:41 +0300
In-Reply-To: <20231010160300.1136799-3-vkuznets@redhat.com>
References: <20231010160300.1136799-1-vkuznets@redhat.com>
         <20231010160300.1136799-3-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

У вт, 2023-10-10 у 18:02 +0200, Vitaly Kuznetsov пише:
> Hyper-V partition assist page is used when KVM runs on top of Hyper-V and
> is not used for Windows/Hyper-V guests on KVM, this means that 'hv_pa_pg'
> placement in 'struct kvm_hv' is unfortunate. As a preparation to making
> Hyper-V emulation optional, move 'hv_pa_pg' to 'struct kvm_arch' and put it
> under CONFIG_HYPERV.

It took me a while to realize that this parition assist page is indeed something that L0,
running above KVM consumes.
(what a confusing name Microsoft picked...)

As far as I know currently the partition assist page has only 
one shared memory variable which allows L1 to be notified of direct TLB flushes that L0 does for L2, 
but since KVM doesn't need it, it
never touches this variable/page,
but specs still demand that L1 does allocate that page.


If you agree, it would be great to add a large comment to the code,
explaining the above, and fact that the partition assist page 
is something L1 exposes to L0.

I don't know though where to put the comment 
because hv_enable_l2_tlb_flush is duplicated between SVM and VMX.

It might be a good idea to have a helper function to allocate the partition assist page,
which will both reduce the code duplication slightly and allow us to put this comment there.


Best regards,
	Maxim Levitsky

> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/svm/svm_onhyperv.c | 2 +-
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  arch/x86/kvm/x86.c              | 4 +++-
>  4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e5d4b8a44630..711dc880a9f0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1115,7 +1115,6 @@ struct kvm_hv {
>  	 */
>  	unsigned int synic_auto_eoi_used;
>  
> -	struct hv_partition_assist_pg *hv_pa_pg;
>  	struct kvm_hv_syndbg hv_syndbg;
>  };
>  
> @@ -1436,6 +1435,7 @@ struct kvm_arch {
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	hpa_t	hv_root_tdp;
>  	spinlock_t hv_root_tdp_lock;
> +	struct hv_partition_assist_pg *hv_pa_pg;
>  #endif
>  	/*
>  	 * VM-scope maximum vCPU ID. Used to determine the size of structures
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.c b/arch/x86/kvm/svm/svm_onhyperv.c
> index 7af8422d3382..d19666f9b9ac 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.c
> +++ b/arch/x86/kvm/svm/svm_onhyperv.c
> @@ -19,7 +19,7 @@ int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	struct hv_vmcb_enlightenments *hve;
>  	struct hv_partition_assist_pg **p_hv_pa_pg =
> -			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
> +		&vcpu->kvm->arch.hv_pa_pg;
>  
>  	if (!*p_hv_pa_pg)
>  		*p_hv_pa_pg = kzalloc(PAGE_SIZE, GFP_KERNEL);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 72e3943f3693..b7dc7acf14be 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -524,7 +524,7 @@ static int hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	struct hv_enlightened_vmcs *evmcs;
>  	struct hv_partition_assist_pg **p_hv_pa_pg =
> -			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
> +		&vcpu->kvm->arch.hv_pa_pg;
>  	/*
>  	 * Synthetic VM-Exit is not enabled in current code and so All
>  	 * evmcs in singe VM shares same assist page.
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9f18b06bbda6..e273ce8e0b3f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12291,7 +12291,9 @@ void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
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




