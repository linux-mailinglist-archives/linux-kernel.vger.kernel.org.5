Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF27DD59A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376569AbjJaRzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjJaRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D74102
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HoYxQsWM95/556mkX4Vbf+MlD34BoItbzU2fJF3frwU=;
        b=NB2hD3aJtQZUxDl9tt5Q9Ubq00iXquHQYD8GB8anMbk2KG/7OUfZXcn4RYDi2Z8q3cyDy9
        xVm8phBvWjs0wbsjuP/293cfJLmxgt/Uc67Amsn/EW1m/wIi9TJo7vcqALchQVBCYvjKuD
        ddpFVmXR5UiR3pk6raASJNgzAu+AYog=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-_UlTIb1lPZa2vIBe1eozHw-1; Tue, 31 Oct 2023 13:54:18 -0400
X-MC-Unique: _UlTIb1lPZa2vIBe1eozHw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408f9e9e9b0so44008525e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774857; x=1699379657;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoYxQsWM95/556mkX4Vbf+MlD34BoItbzU2fJF3frwU=;
        b=afwzhp1AehI3fNjwOlvCKz7zevGr+oy6mW6l2PLKBnAKVOEDG/tvZ1gvKuIW6FQ2lg
         +eUF211RWnz4zr9cXJ6btdlgjX5+B2ELLPuJpORgUYCT5IaWO5emUdBvL515s7/w0ZuW
         eiKw2EYAdIT7oBHtngFqVBmbhzwsrX2TLgm8Akw1Pv4y8IJAY27fNNEKxaoO1UFwU0ex
         7eHpy+iXSL4T80nb27aZTVEHkuy9sGEiS9q13f/Ztus8pZr3gi2CtYqrWa8dvya43ENl
         lNORlJSUbwynCifJKcBFl2vTB+yW3eWozCVt9iHN+AntEBvUbmKC2Jt9cDHh18eUyvnf
         nC2w==
X-Gm-Message-State: AOJu0YwDCCRTGlPrZX+wJsxDUo/kHv4trTciA/33B4zmn2Ub+ar/qYxb
        rSbVsBkwbCms6d9Nq5nB3ZU2gtIPDLBo1NqKa0zBGA91dLflsvD6T2LzGifsVZdGA6URCQmsmBr
        r1Zoj6ncCavCXDWTUs21w2Hgg
X-Received: by 2002:a05:600c:1991:b0:405:7400:1e3d with SMTP id t17-20020a05600c199100b0040574001e3dmr10727051wmq.32.1698774856949;
        Tue, 31 Oct 2023 10:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpmxtFKyrQGGtwocdWDBt4yMlZH69my0R5jpaCJjj/hvgJHUZ5cgByh0t/kUqJK8bTs+NG9Q==
X-Received: by 2002:a05:600c:1991:b0:405:7400:1e3d with SMTP id t17-20020a05600c199100b0040574001e3dmr10727029wmq.32.1698774856589;
        Tue, 31 Oct 2023 10:54:16 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id o8-20020adfe808000000b0031980294e9fsm2004208wrm.116.2023.10.31.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:54:16 -0700 (PDT)
Message-ID: <ea3609bf7c7759b682007042b98191d91d10a751.camel@redhat.com>
Subject: Re: [PATCH v6 18/25] KVM: x86: Use KVM-governed feature framework
 to track "SHSTK/IBT enabled"
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:54:14 +0200
In-Reply-To: <20230914063325.85503-19-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-19-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Use the governed feature framework to track whether X86_FEATURE_SHSTK
> and X86_FEATURE_IBT features can be used by userspace and guest, i.e.,
> the features can be used iff both KVM and guest CPUID can support them.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/governed_features.h | 2 ++
>  arch/x86/kvm/vmx/vmx.c           | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
> index 423a73395c10..db7e21c5ecc2 100644
> --- a/arch/x86/kvm/governed_features.h
> +++ b/arch/x86/kvm/governed_features.h
> @@ -16,6 +16,8 @@ KVM_GOVERNED_X86_FEATURE(PAUSEFILTER)
>  KVM_GOVERNED_X86_FEATURE(PFTHRESHOLD)
>  KVM_GOVERNED_X86_FEATURE(VGIF)
>  KVM_GOVERNED_X86_FEATURE(VNMI)
> +KVM_GOVERNED_X86_FEATURE(SHSTK)
> +KVM_GOVERNED_X86_FEATURE(IBT)
>  
>  #undef KVM_GOVERNED_X86_FEATURE
>  #undef KVM_GOVERNED_FEATURE
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9409753f45b0..fd5893b3a2c8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7765,6 +7765,8 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
>  
>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VMX);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_SHSTK);
> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IBT);
>  
>  	vmx_setup_uret_msrs(vmx);
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


PS: IMHO The whole 'governed feature framework' is very confusing and somewhat poorly documented.

Currently the only partial explanation of it, is at 'governed_features', which doesn't
explain how to use it.

For the reference this is how KVM expects governed features to be used in the common case
(there are some exceptions to this but they are rare)

1. If a feature is not enabled in host CPUID or KVM doesn't support it, 
   KVM is expected to not enable it in KVM cpu caps.

2. Userspace uploads guest CPUID.

3. After the guest CPUID upload, the vendor code calls kvm_governed_feature_check_and_set() which sets
	governed features = True iff feature is supported in both kvm cpu caps and in guest CPUID.

4. kvm/vendor code uses 'guest_can_use()' to query the value of the governed feature instead of reading
guest CPUID.

It might make sense to document the above somewhere at least.

Now about another thing I am thinking:

I do know that the mess of boolean flags that svm had is worse than these governed features and functionality wise these are equivalent.

However thinking again about the whole thing: 

IMHO the 'governed features' is another quite confusing term that a KVM developer will need to learn and keep in memory.

Because of that, can't we just use guest CPUID as a single source of truth and drop all the governed features code?

In most cases, when the governed feature value will differ from the guest CPUID is when a feature is enabled in the guest CPUID,
but not enabled in the KVM caps.

I do see two exceptions to this: XSAVES on AMD and X86_FEATURE_GBPAGES, in which the opposite happens,
governed feature is enabled, even when the feature is hidden from the guest CPUID, but it might be
better from
readability wise point, to deal with these cases manually and we unlikely to have many new such cases in the future.

So for the common case of CPUID mismatch, when the governed feature is disabled but guest CPUID is enabled,
does it make sense to allow this? 

Such a feature which is advertised as supported but not really working is a recipe of hard to find guest bugs IMHO.

IMHO it would be much better to just check this condition and do kvm_vm_bugged() or something in case when a feature
is enabled in the guest CPUID but KVM can't support it, and then just use guest CPUID in 'guest_can_use()'.

Best regards,
	Maxim Levitsky






