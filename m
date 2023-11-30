Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C987FF91D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjK3SLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F9D50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701367902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh2iQI1ztXeis76Y0kVKsrBeV19ZxrXIlDJBIndDl5E=;
        b=Vbz2UnjvsohITYWkQ02JSL4cCq81B29U7JvUgsVe7IIN8vOcjm+Q6Kzd56qtmxHpafHvcX
        kSGEdHgvtCpXJbxSAjLakA7nzo1apCYa3kPYCWF7NNP9/gI9dwlesYdId657J2Qj7AGn5g
        20L9iJpU+XUHyD1CnpvtyKyqT/yXS18=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-f8ZVelEuMyCGjdikwVwY_A-1; Thu, 30 Nov 2023 13:11:39 -0500
X-MC-Unique: f8ZVelEuMyCGjdikwVwY_A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54bd8ac8f1fso932758a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367897; x=1701972697;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qh2iQI1ztXeis76Y0kVKsrBeV19ZxrXIlDJBIndDl5E=;
        b=kJOkatPU/Dpb3X0BtTefzjx0PxKu7k6tDNFEWQoLgwNLOzS71kasn3H7l0Tf593Dsy
         bANReKboIbJTBbQuzlWZtW4h9d/tBwvtzhKwbLjX6xU9+cJkkKBFMIvE2Mp/7fRBqWiF
         B6gZ+M1ZqczD1fuUweKUMMtC8KnkZAWIU0k1pTcPJVVEf4kt53MNbKXoJGA63HwPwNWe
         Du6dg8QID6wlpp5Rwyo7QPGcWjr/79i4W9MavPQ28jLjtw8yJAAS3VbOujls2BPzZl7p
         +qbkREX7O/4zqLIGHrG1lMFUh/kbO9xZ0JcPsKaOLuSHH5m23qUgYK+Dv1IO11Z6lqRx
         Q/7A==
X-Gm-Message-State: AOJu0Yy/1RTocuT0yIB9KTiQ1AIpq4ugQUoZ/NNe/bjX5VLv9rcJR5a3
        qydswu3Q6i2M7/gIudr38jkZdiQCkMg0sQzD1uxQkKhWvbRPCXkjxp72ciukIUJYmQyyUtMcJ7f
        BV6bGHY0ycP4XxrOdTbILr9dw/0c+Aozr
X-Received: by 2002:ac2:5b5b:0:b0:50a:71e1:e1c9 with SMTP id i27-20020ac25b5b000000b0050a71e1e1c9mr23489lfp.42.1701366832566;
        Thu, 30 Nov 2023 09:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+6s4MYOhaFS5PKsAqpJ5K2jaDd7gb7TvhnIPf5H9XMi3/xfKGrICSbsosQ1R5HQsWb0dRIg==
X-Received: by 2002:a2e:9cd1:0:b0:2c9:caf3:e748 with SMTP id g17-20020a2e9cd1000000b002c9caf3e748mr51910ljj.5.1701365884905;
        Thu, 30 Nov 2023 09:38:04 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002c887ca5a70sm197252ljo.51.2023.11.30.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:38:04 -0800 (PST)
Message-ID: <ef8b40540c6cf1ed506928ec842e5602169ecdb6.camel@redhat.com>
Subject: Re: [PATCH v7 15/26] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:38:02 +0200
In-Reply-To: <20231124055330.138870-16-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-16-weijiang.yang@intel.com>
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
> From: Sean Christopherson <seanjc@google.com>
> 
> Load the guest's FPU state if userspace is accessing MSRs whose values
> are managed by XSAVES. Introduce two helpers, kvm_{get,set}_xstate_msr(),
> to facilitate access to such kind of MSRs.
> 
> If MSRs supported in kvm_caps.supported_xss are passed through to guest,
> the guest MSRs are swapped with host's before vCPU exits to userspace and
> after it reenters kernel before next VM-entry.
> 
> Because the modified code is also used for the KVM_GET_MSRS device ioctl(),
> explicitly check @vcpu is non-null before attempting to load guest state.
> The XSAVE-managed MSRs cannot be retrieved via the device ioctl() without
> loading guest FPU state (which doesn't exist).
> 
> Note that guest_cpuid_has() is not queried as host userspace is allowed to
> access MSRs that have not been exposed to the guest, e.g. it might do
> KVM_SET_MSRS prior to KVM_SET_CPUID2.
> 
> The two helpers are put here in order to manifest accessing xsave-managed MSRs
> requires special check and handling to guarantee the correctness of read/write
> to the MSRs.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/x86.c | 35 ++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.h | 24 ++++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 607082aca80d..fd48b825510c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -133,6 +133,9 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  
>  static DEFINE_MUTEX(vendor_module_lock);
> +static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
> +static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> +
>  struct kvm_x86_ops kvm_x86_ops __read_mostly;
>  
>  #define KVM_X86_OP(func)					     \
> @@ -4482,6 +4485,21 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_msr_common);
>  
> +/*
> + *  Returns true if the MSR in question is managed via XSTATE, i.e. is context
> + *  switched with the rest of guest FPU state.
> + */
> +static bool is_xstate_managed_msr(u32 index)
> +{
> +	switch (index) {
> +	case MSR_IA32_U_CET:
> +	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * Read or write a bunch of msrs. All parameters are kernel addresses.
>   *
> @@ -4492,11 +4510,26 @@ static int __msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs *msrs,
>  		    int (*do_msr)(struct kvm_vcpu *vcpu,
>  				  unsigned index, u64 *data))
>  {
> +	bool fpu_loaded = false;
>  	int i;
>  
> -	for (i = 0; i < msrs->nmsrs; ++i)
> +	for (i = 0; i < msrs->nmsrs; ++i) {
> +		/*
> +		 * If userspace is accessing one or more XSTATE-managed MSRs,
> +		 * temporarily load the guest's FPU state so that the guest's
> +		 * MSR value(s) is resident in hardware, i.e. so that KVM can
> +		 * get/set the MSR via RDMSR/WRMSR.
> +		 */
> +		if (vcpu && !fpu_loaded && kvm_caps.supported_xss &&
> +		    is_xstate_managed_msr(entries[i].index)) {
> +			kvm_load_guest_fpu(vcpu);
> +			fpu_loaded = true;
> +		}
>  		if (do_msr(vcpu, entries[i].index, &entries[i].data))
>  			break;
> +	}
> +	if (fpu_loaded)
> +		kvm_put_guest_fpu(vcpu);
>  
>  	return i;
>  }
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 5184fde1dc54..6e42ede335f5 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -541,4 +541,28 @@ int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
>  			 unsigned int port, void *data,  unsigned int count,
>  			 int in);
>  
> +/*
> + * Lock and/or reload guest FPU and access xstate MSRs. For accesses initiated
> + * by host, guest FPU is loaded in __msr_io(). For accesses initiated by guest,
> + * guest FPU should have been loaded already.
> + */
> +
> +static inline void kvm_get_xstate_msr(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr_info)
> +{
> +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> +	kvm_fpu_get();
> +	rdmsrl(msr_info->index, msr_info->data);
> +	kvm_fpu_put();
> +}
> +
> +static inline void kvm_set_xstate_msr(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr_info)
> +{
> +	KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);
> +	kvm_fpu_get();
> +	wrmsrl(msr_info->index, msr_info->data);
> +	kvm_fpu_put();
> +}
> +
>  #endif


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky



