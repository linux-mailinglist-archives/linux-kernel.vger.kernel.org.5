Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9307FF962
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbjK3Saq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjK3Sah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4766170F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701369039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qytGX0MGJcOz7q/36mRvU0A100gsEwbWnP5WfFvyCcQ=;
        b=ReIdTavSeZV8PhLOrp5oOWoa0s1bH2jahkRof3SR2l+H9CYTJaCmfYt331DBds1T9DcAIE
        EzCqE4yRsF3qmktwTq/Y/CzDONY9LRz5r46Ph2f9QDZeWVdMx3kzwo8hUxOwRTLMTepVxJ
        b3l+sml43+/Wtw+0hflCesxv1Cxj+Fw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-WLr-ZhgTO5a2VwKKyzsgtA-1; Thu, 30 Nov 2023 13:30:37 -0500
X-MC-Unique: WLr-ZhgTO5a2VwKKyzsgtA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b357e2a01so8643915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369036; x=1701973836;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qytGX0MGJcOz7q/36mRvU0A100gsEwbWnP5WfFvyCcQ=;
        b=TxbGyrkcY+vUJrpl2YhxFfDsKOXI+zmAPhlI1pVKSTMlwkoPPOLkb+XtT7T3O8ICMs
         hxgoE6Ica2rXsNqJ/W9spbXF947umaKcOHb9nicY+ERVIsbzNBdqyhk2K51YFYfdZdRC
         ERMzbq/0IsF8t/1Uw0bm8YrQY0Tiybp1wEQUR13a7fxuSyKYp9oMa1xnEYM6YIwaNoK1
         ugoSuyuJ+fM8/MMH5WZD+AMEfcroh6prh5ZojCdzp4XbgN2kNLeuwVNKq4UzsnedYFEO
         92sq9a3Ik1bVZWZ17zmg/SOlgH2pGlI0RSPiCZ0NuChJqxjR4wgwqrMUPBYV32blpCfo
         m7Mg==
X-Gm-Message-State: AOJu0YzNzRMH9BoZZ8nvkqIellUpVlf1N/h3hVcmNZyEXQnZnnKiWQZz
        bk+q8zftYeqJ/+iAQ2xmbO0DKfqE4YVsCa0gSjj4VRz7IxzYgnbrbatf6g+nsRVfCzDRuyKl/5S
        Vtp/I+1AKbd/eeGPBn19mf00L9f+wHgoC
X-Received: by 2002:a05:600c:a04:b0:40b:4e4e:2b22 with SMTP id z4-20020a05600c0a0400b0040b4e4e2b22mr2029wmp.38.1701369034658;
        Thu, 30 Nov 2023 10:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPJcbCU4cufSDQv6f8QUMe1TA4X/6xNTeMQtfmLGplAXuJX2mk3hU8RkAtP5spjMsfxa0lKg==
X-Received: by 2002:a17:906:2086:b0:a11:d323:c1bc with SMTP id 6-20020a170906208600b00a11d323c1bcmr57445ejq.19.1701366166815;
        Thu, 30 Nov 2023 09:42:46 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id d27-20020ac25edb000000b0050933bb416csm214417lfq.74.2023.11.30.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:42:46 -0800 (PST)
Message-ID: <d2be8a787969b76f71194ce65bd6f35426b60dcc.camel@redhat.com>
Subject: Re: [PATCH v7 21/26] KVM: x86: Save and reload SSP to/from SMRAM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:42:44 +0200
In-Reply-To: <20231124055330.138870-22-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-22-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Save CET SSP to SMRAM on SMI and reload it on RSM. KVM emulates HW arch
> behavior when guest enters/leaves SMM mode,i.e., save registers to SMRAM
> at the entry of SMM and reload them at the exit to SMM. Per SDM, SSP is
> one of such registers on 64bit Arch, so add the support for SSP.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/smm.c | 8 ++++++++
>  arch/x86/kvm/smm.h | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 45c855389ea7..7aac9c54c353 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -275,6 +275,10 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
>  	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
>  
>  	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_read(vcpu, MSR_KVM_SSP, &smram->ssp),
> +			   vcpu->kvm);
>  }
>  #endif
>  
> @@ -564,6 +568,10 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
>  	ctxt->interruptibility = (u8)smstate->int_shadow;
>  
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_write(vcpu, MSR_KVM_SSP, smstate->ssp),
> +			   vcpu->kvm);
> +
>  	return X86EMUL_CONTINUE;
>  }
>  #endif
> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> index a1cf2ac5bd78..1e2a3e18207f 100644
> --- a/arch/x86/kvm/smm.h
> +++ b/arch/x86/kvm/smm.h
> @@ -116,8 +116,8 @@ struct kvm_smram_state_64 {
>  	u32 smbase;
>  	u32 reserved4[5];
>  
> -	/* ssp and svm_* fields below are not implemented by KVM */
>  	u64 ssp;
> +	/* svm_* fields below are not implemented by KVM */
>  	u64 svm_guest_pat;
>  	u64 svm_host_efer;
>  	u64 svm_host_cr4;


My review feedback from the previous patch series still applies, and I don't
know why it was not addressed/replied to:

I still think that it is worth it to have a check that CET is not enabled in
enter_smm_save_state_32 which is called for pure 32 bit guests (guests that don't
have X86_FEATURE_LM enabled)

Best regards,
	Maxim Levitsky


