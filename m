Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3197DD5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347002AbjJaR50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347024AbjJaR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AED8BD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUV3YLJj6cvVExiR+gKPjIlU6mA7gMrzwKTPnwkmmL8=;
        b=IZZrxDOR+zgmuf0v+S8EppewnmIEVAuD5nth+Kq6eyeMZU8w6eJk+YHnw1QzzIx14FFvji
        YoTyKR5n6zdUtrh4MVtetDVbB8IVWiRcm5gKKpzbEc2Mlx1GKeFECMCrWMWMRiH/xTYpRa
        NmqQqKfv8UJEgHj7I4G611DbckPhwh0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-HzRICnSLNi6YEFFHt5BRPA-1; Tue, 31 Oct 2023 13:56:32 -0400
X-MC-Unique: HzRICnSLNi6YEFFHt5BRPA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079c865541so6690661e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774990; x=1699379790;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUV3YLJj6cvVExiR+gKPjIlU6mA7gMrzwKTPnwkmmL8=;
        b=rsfz7cLa0E5+K8v6OuF165Vi8B39JKt6ZzVjN9BmwwmoCIGo3aHVz1SqCdTJgsqnIE
         TjH84fV9nY5dPSYG+hLN9wzj8ETyZa4p4LU+yeZ2zu9xk8H1FrJFuXe4/xl8bRww92IR
         GBwNoi8dpGTjpupcHxxSXBhH5DEJVRCk60eD9gThisS+Px01MBFEycaucttGMBQDs+FN
         o05JHRZdsG8CXQDSUip/zPSUbDedEkDZg5mAYBNMoIPH7J54ZbiF3NYCNY9cJ+ilCjjE
         +hup7MhMH5PNxMdVS89C6hPhsTNBD70HYsPLeASUmxKvGjgYXTTRB2DJ6udUNTV3ukhd
         gCOw==
X-Gm-Message-State: AOJu0YyputWAKJ/6rFl9Upr6cqgnLKMjTX5KHGGNcDE4QZ0HkepK0Q4z
        8/RHUv30w9jv6sefD+BhFBP2A8XOwAu+caLcEZY0yzvUpP0QkWgQvg7AS2uIgQ6CBNqWaFlVtWG
        BOZq4WGjXfKgbnIzXhXwzNQuQ
X-Received: by 2002:ac2:54bc:0:b0:4ff:9a75:211e with SMTP id w28-20020ac254bc000000b004ff9a75211emr9900316lfk.42.1698774990679;
        Tue, 31 Oct 2023 10:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcTCD7ofnCblZ9/RsH+J6rzU16VNSqEY4HZ0vcabY+ecCVQ0BnLqTY+P5pUP41U8vXUrG14A==
X-Received: by 2002:ac2:54bc:0:b0:4ff:9a75:211e with SMTP id w28-20020ac254bc000000b004ff9a75211emr9900304lfk.42.1698774990324;
        Tue, 31 Oct 2023 10:56:30 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c234300b0040586360a36sm2345230wmq.17.2023.10.31.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:56:29 -0700 (PDT)
Message-ID: <eb788cb4505784913fa5c583906a780a3c122d64.camel@redhat.com>
Subject: Re: [PATCH v6 22/25] KVM: VMX: Set host constant supervisor states
 to VMCS fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:56:27 +0200
In-Reply-To: <20230914063325.85503-23-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-23-weijiang.yang@intel.com>
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
> Save constant values to HOST_{S_CET,SSP,INTR_SSP_TABLE} field explicitly.
> Kernel IBT is supported and the setting in MSR_IA32_S_CET is static after
> post-boot(The exception is BIOS call case but vCPU thread never across it)
> and KVM doesn't need to refresh HOST_S_CET field before every VM-Enter/
> VM-Exit sequence.
> 
> Host supervisor shadow stack is not enabled now and SSP is not accessible
> to kernel mode, thus it's safe to set host IA32_INT_SSP_TAB/SSP VMCS field
> to 0s. When shadow stack is enabled for CPL3, SSP is reloaded from PL3_SSP
> before it exits to userspace. Check SDM Vol 2A/B Chapter 3/4 for SYSCALL/
> SYSRET/SYSENTER SYSEXIT/RDSSP/CALL etc.
> 
> Prevent KVM module loading if host supervisor shadow stack SHSTK_EN is set
> in MSR_IA32_S_CET as KVM cannot co-exit with it correctly.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/capabilities.h |  4 ++++
>  arch/x86/kvm/vmx/vmx.c          | 15 +++++++++++++++
>  arch/x86/kvm/x86.c              | 14 ++++++++++++++
>  arch/x86/kvm/x86.h              |  1 +
>  4 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 41a4533f9989..ee8938818c8a 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -106,6 +106,10 @@ static inline bool cpu_has_load_perf_global_ctrl(void)
>  	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>  }
>  
> +static inline bool cpu_has_load_cet_ctrl(void)
> +{
> +	return (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_CET_STATE);
> +}
>  static inline bool cpu_has_vmx_mpx(void)
>  {
>  	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_BNDCFGS;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 30373258573d..9ccc2c552f55 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4375,6 +4375,21 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
>  
>  	if (cpu_has_load_ia32_efer())
>  		vmcs_write64(HOST_IA32_EFER, host_efer);
> +
> +	/*
> +	 * Supervisor shadow stack is not enabled on host side, i.e.,
> +	 * host IA32_S_CET.SHSTK_EN bit is guaranteed to 0 now, per SDM
> +	 * description(RDSSP instruction), SSP is not readable in CPL0,
> +	 * so resetting the two registers to 0s at VM-Exit does no harm
> +	 * to kernel execution. When execution flow exits to userspace,
> +	 * SSP is reloaded from IA32_PL3_SSP. Check SDM Vol.2A/B Chapter
> +	 * 3 and 4 for details.

> +	 */
> +	if (cpu_has_load_cet_ctrl()) {
> +		vmcs_writel(HOST_S_CET, host_s_cet);
> +		vmcs_writel(HOST_SSP, 0);
> +		vmcs_writel(HOST_INTR_SSP_TABLE, 0);
> +	}
>  }
>  
>  void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c85ee42ab4f1..231d4a7b6f3d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -114,6 +114,8 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
>  #endif
>  
>  static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
> +u64 __read_mostly host_s_cet;
> +EXPORT_SYMBOL_GPL(host_s_cet);
>  
>  #define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
>  
> @@ -9618,6 +9620,18 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  		return -EIO;
>  	}
>  
> +	if (boot_cpu_has(X86_FEATURE_SHSTK)) {
> +		rdmsrl(MSR_IA32_S_CET, host_s_cet);
> +		/*
> +		 * Linux doesn't yet support supervisor shadow stacks (SSS), so
> +		 * KVM doesn't save/restore the associated MSRs, i.e. KVM may
> +		 * clobber the host values.  Yell and refuse to load if SSS is
> +		 * unexpectedly enabled, e.g. to avoid crashing the host.
> +		 */
> +		if (WARN_ON_ONCE(host_s_cet & CET_SHSTK_EN))
> +			return -EIO;
This is a good idea.

> +	}
> +
>  	x86_emulator_cache = kvm_alloc_emulator_cache();
>  	if (!x86_emulator_cache) {
>  		pr_err("failed to allocate cache for x86 emulator\n");
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 9a8e3a84eaf4..0d5f673338dd 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -324,6 +324,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu);
>  extern u64 host_xcr0;
>  extern u64 host_xss;
>  extern u64 host_arch_capabilities;
> +extern u64 host_s_cet;
>  
>  extern struct kvm_caps kvm_caps;
>  


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky





