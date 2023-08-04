Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D1770822
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHDSpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDSpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:45:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A546BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:45:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bbf8cb6143so20848335ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691174714; x=1691779514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq38oqTQyOZq0/Vk1xBRd6bkqdP7LlptcLF48lzFMMM=;
        b=uaz76R29r4VpBmVg3aJzawsLUkGHqc4C3TCqJ6k/o68dST2qHMUHpb99N+IjLxvcv+
         GDZ3BiBb1+mijaHet9TwuBqQyERGbHQnPmhcR+wHVTtzUOg+1AAogult+w6sNz350gjq
         t6+rhhML1vw9PqlS/ZOod/sNXp+c6SWqLN7/k/L9pNKEqI5HI+iaUPA3tM1+WmD/VuKX
         Ppckh2klOzy44KaLRr9iNPK3RxaEyot4/LlYTjr8ZPdZgtBu0j/mjfKQ9vFQAHjoGthT
         wzwBG1fplQ6u1bgZk3xDLiguAmpY5MPMaz2NrlGQTnwPbFs8VrBHdqPsAmmsj9FSISih
         0Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691174714; x=1691779514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq38oqTQyOZq0/Vk1xBRd6bkqdP7LlptcLF48lzFMMM=;
        b=BnWWxIweMixwJH6iv6uaOSVlpFMYsmi0O9IRY58sDhOTfWKhZ+Jb4mavTW04pLp64h
         nE2Zq6aiAzgcNJXNtpZtm+jGyZcILrMuv553IV7CbeNDLyNjlBQbUaQCur5Nf7sr/KPv
         6J8I7D+ul/mzXZmzRH45MH/8GtRTIFgq6wDgun4tZKFdjO/3v8KdEs/brvnkOOsHPDzU
         xgI5A9HecJNj/9/iQ68PrwAsSoKx78qDKx8vnTUFRTcY+GQfKEDZI9CMjbaAe2QCamb4
         h8gtlt7d1vwfCcwjL79UNjZkMg5N4zOT0BaT4odrIAGZg9YasSEaFYeq9p7jzQQW5A7S
         FBow==
X-Gm-Message-State: AOJu0YwupwQXpQQaloGsqzY/mn0TUkz/osvsqe2wZYYGp+HuD6qcjdxD
        hQ38CdkGTA44AcB6XBDT4kbA+15Nhhg=
X-Google-Smtp-Source: AGHT+IHmZTBOOZV7kplcrMywzPgMbaGdPXBMBNZG4BGmhb6YnfrDeTsQzo/oMjwuZcCONi/pAVK9Dmg5wrU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f54a:b0:1bc:210d:636e with SMTP id
 h10-20020a170902f54a00b001bc210d636emr8882plf.12.1691174714015; Fri, 04 Aug
 2023 11:45:14 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:45:12 -0700
In-Reply-To: <20230803042732.88515-6-weijiang.yang@intel.com>
Mime-Version: 1.0
References: <20230803042732.88515-1-weijiang.yang@intel.com> <20230803042732.88515-6-weijiang.yang@intel.com>
Message-ID: <ZM1HODB6No0XArEq@google.com>
Subject: Re: [PATCH v5 05/19] KVM:x86: Initialize kvm_caps.supported_xss
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     pbonzini@redhat.com, peterz@infradead.org, john.allen@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, chao.gao@intel.com,
        binbin.wu@linux.intel.com
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

On Thu, Aug 03, 2023, Yang Weijiang wrote:
> Set kvm_caps.supported_xss to host_xss && KVM XSS mask.
> host_xss contains the host supported xstate feature bits for thread
> context switch, KVM_SUPPORTED_XSS includes all KVM enabled XSS feature
> bits, the operation result represents all KVM supported feature bits.
> Since the result is subset of host_xss, the related XSAVE-managed MSRs
> are automatically swapped for guest and host when vCPU exits to
> userspace.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 -
>  arch/x86/kvm/x86.c     | 6 +++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0ecf4be2c6af..c8d9870cfecb 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7849,7 +7849,6 @@ static __init void vmx_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_UMIP);
>  
>  	/* CPUID 0xD.1 */
> -	kvm_caps.supported_xss = 0;

Dropping this code in *this* patch is wrong, this belong in whatever patch(es) adds
IBT and SHSTK support in VMX.

And that does matter because it means this common patch can be carried wih SVM
support without breaking VMX.

>  	if (!cpu_has_vmx_xsaves())
>  		kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5d6d6fa33e5b..e9f3627d5fdd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -225,6 +225,8 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
>  
> +#define KVM_SUPPORTED_XSS     0
> +
>  u64 __read_mostly host_efer;
>  EXPORT_SYMBOL_GPL(host_efer);
>  
> @@ -9498,8 +9500,10 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  
>  	rdmsrl_safe(MSR_EFER, &host_efer);
>  
> -	if (boot_cpu_has(X86_FEATURE_XSAVES))
> +	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
>  		rdmsrl(MSR_IA32_XSS, host_xss);
> +		kvm_caps.supported_xss = host_xss & KVM_SUPPORTED_XSS;
> +	}

Can you opportunistically (in this patch) hoist this above EFER so that XCR0 and
XSS are colocated?  I.e. end up with this:

	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
		kvm_caps.supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
	}
	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
		rdmsrl(MSR_IA32_XSS, host_xss);
		kvm_caps.supported_xss = host_xss & KVM_SUPPORTED_XSS;
	}

	rdmsrl_safe(MSR_EFER, &host_efer);

