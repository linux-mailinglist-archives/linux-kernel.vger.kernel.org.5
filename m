Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F77FF8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjK3RrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjK3RrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6E10FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701366429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Do1i0rNcXTm7UcBN64yemTg3geXjs/ArAehAZPE2x/s=;
        b=ZgYwqVngETg2yfjN7A3d781JeGEc7AO47SHQlRyFdWJa4BKeoKUlg3Mg81IxA2b9Q2zPpS
        GsJxWbhOU9BLBa8XYjZt8lzn9nd00CCoH1Xkh9VQFi0WJGKmnl2G/jIP7XIUZAwcyMiYLE
        HtCkFf3TVpOfDzG1zZaaYp0x3zQWCSw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-jyVSfklwOaySQ5ERC-8QvA-1; Thu, 30 Nov 2023 12:47:07 -0500
X-MC-Unique: jyVSfklwOaySQ5ERC-8QvA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c1b1a6c72so476534a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701366426; x=1701971226;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Do1i0rNcXTm7UcBN64yemTg3geXjs/ArAehAZPE2x/s=;
        b=URJAOcTkzy4WNkx2coCiS/pSuZD0X1K5H8nbyEU3aN1dXOU9SqcXcY6Vf0FqFsYVSJ
         poGIkoYBE/cK85mP3BSQbutLmAReYaFDhI2iJUuibij9f0smSpItime/sFvanGtWNLVd
         rPDvCmvb23dc5c7y35qLTSzn6ls40x0gaKTg7oTZHP/U0P3Ksa6zSyx10HygrMMmwqsY
         fPy7lv8kvtX4fzQ5kONGgRX3yZpOauyeI9HERPBXoU/WE18CzD6sIiYJolenr/vc8K4J
         w7EBSM+rk0aiWOxCzHaEnwnyUYRmXiZy6rqQltuXbcWVCgc5BnI0hedWvGzrZWdBC51q
         u/dA==
X-Gm-Message-State: AOJu0YyMeflMV+goolwDfJN33Q39GuDi6WDW1VLdK1RWtHZ/njMpWTvt
        coH5UPt8X6jKgcZ5v/MK3UvcUIuYQSpuXFh7/+alX1aIlP/5AE5KqwkXnp3EPqWtefyC+nfRX39
        iGsaBqi0dLXz3Ti3oXjeFsB0+ixudzAla
X-Received: by 2002:a5d:4c86:0:b0:333:18b9:27a6 with SMTP id z6-20020a5d4c86000000b0033318b927a6mr28684wrs.30.1701366200955;
        Thu, 30 Nov 2023 09:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIoOShcGXrmT4a2nVJJ5Y/xGQjRCjLVycLPsYi48o8AqnX+pdnieJV+iz12s++pWoByaIM3Q==
X-Received: by 2002:a2e:894e:0:b0:2c9:c5dc:9a26 with SMTP id b14-20020a2e894e000000b002c9c5dc9a26mr16252ljk.12.1701365800688;
        Thu, 30 Nov 2023 09:36:40 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id u23-20020a2eb817000000b002c02e57c72bsm191667ljo.140.2023.11.30.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:36:40 -0800 (PST)
Message-ID: <b23c9dbc953b6bae4d3bff4aa1dff4c349a49a04.camel@redhat.com>
Subject: Re: [PATCH v7 09/26] KVM: x86: Rename kvm_{g,s}et_msr() to menifest
 emulation operations
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:36:37 +0200
In-Reply-To: <20231124055330.138870-10-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-10-weijiang.yang@intel.com>
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
> Rename kvm_{g,s}et_msr() to kvm_emulate_msr_{read,write}() to make it
> more obvious that KVM uses these helpers to emulate guest behaviors,
> i.e., host_initiated == false in these helpers.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 ++--
>  arch/x86/kvm/smm.c              |  4 ++--
>  arch/x86/kvm/vmx/nested.c       | 13 +++++++------
>  arch/x86/kvm/x86.c              | 10 +++++-----
>  4 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d7036982332e..5cfa18aaf33f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1967,8 +1967,8 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
>  void kvm_enable_efer_bits(u64);
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
>  int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data, bool host_initiated);
> -int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> -int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data);
> +int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> +int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
>  int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
>  int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
>  int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index dc3d95fdca7d..45c855389ea7 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -535,7 +535,7 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  
>  	vcpu->arch.smbase =         smstate->smbase;
>  
> -	if (kvm_set_msr(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA))
> +	if (kvm_emulate_msr_write(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA))
>  		return X86EMUL_UNHANDLEABLE;
>  
>  	rsm_load_seg_64(vcpu, &smstate->tr, VCPU_SREG_TR);
> @@ -626,7 +626,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
>  
>  		/* And finally go back to 32-bit mode.  */
>  		efer = 0;
> -		kvm_set_msr(vcpu, MSR_EFER, efer);
> +		kvm_emulate_msr_write(vcpu, MSR_EFER, efer);
>  	}
>  #endif
>  
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c5ec0ef51ff7..2034337681f9 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -927,7 +927,7 @@ static u32 nested_vmx_load_msr(struct kvm_vcpu *vcpu, u64 gpa, u32 count)
>  				__func__, i, e.index, e.reserved);
>  			goto fail;
>  		}
> -		if (kvm_set_msr(vcpu, e.index, e.value)) {
> +		if (kvm_emulate_msr_write(vcpu, e.index, e.value)) {
>  			pr_debug_ratelimited(
>  				"%s cannot write MSR (%u, 0x%x, 0x%llx)\n",
>  				__func__, i, e.index, e.value);
> @@ -963,7 +963,7 @@ static bool nested_vmx_get_vmexit_msr_value(struct kvm_vcpu *vcpu,
>  		}
>  	}
>  
> -	if (kvm_get_msr(vcpu, msr_index, data)) {
> +	if (kvm_emulate_msr_read(vcpu, msr_index, data)) {
>  		pr_debug_ratelimited("%s cannot read MSR (0x%x)\n", __func__,
>  			msr_index);
>  		return false;
> @@ -2649,7 +2649,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>  
>  	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL) &&
>  	    kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)) &&
> -	    WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
> +	    WARN_ON_ONCE(kvm_emulate_msr_write(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
>  				     vmcs12->guest_ia32_perf_global_ctrl))) {
>  		*entry_failure_code = ENTRY_FAIL_DEFAULT;
>  		return -EINVAL;
> @@ -4524,8 +4524,9 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>  	}
>  	if ((vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL) &&
>  	    kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu)))
> -		WARN_ON_ONCE(kvm_set_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL,
> -					 vmcs12->host_ia32_perf_global_ctrl));
> +		WARN_ON_ONCE(kvm_emulate_msr_write(vcpu,
> +					MSR_CORE_PERF_GLOBAL_CTRL,
> +					vmcs12->host_ia32_perf_global_ctrl));
>  
>  	/* Set L1 segment info according to Intel SDM
>  	    27.5.2 Loading Host Segment and Descriptor-Table Registers */
> @@ -4700,7 +4701,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
>  				goto vmabort;
>  			}
>  
> -			if (kvm_set_msr(vcpu, h.index, h.value)) {
> +			if (kvm_emulate_msr_write(vcpu, h.index, h.value)) {
>  				pr_debug_ratelimited(
>  					"%s WRMSR failed (%u, 0x%x, 0x%llx)\n",
>  					__func__, j, h.index, h.value);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..b9c2c0cd4cf5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1973,17 +1973,17 @@ static int kvm_set_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 data)
>  	return kvm_set_msr_ignored_check(vcpu, index, data, false);
>  }
>  
> -int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data)
> +int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
>  {
>  	return kvm_get_msr_ignored_check(vcpu, index, data, false);
>  }
> -EXPORT_SYMBOL_GPL(kvm_get_msr);
> +EXPORT_SYMBOL_GPL(kvm_emulate_msr_read);
>  
> -int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data)
> +int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
>  {
>  	return kvm_set_msr_ignored_check(vcpu, index, data, false);
>  }
> -EXPORT_SYMBOL_GPL(kvm_set_msr);
> +EXPORT_SYMBOL_GPL(kvm_emulate_msr_write);
>  
>  static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
>  {
> @@ -8329,7 +8329,7 @@ static int emulator_set_msr_with_filter(struct x86_emulate_ctxt *ctxt,
>  static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
>  			    u32 msr_index, u64 *pdata)
>  {
> -	return kvm_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
> +	return kvm_emulate_msr_read(emul_to_vcpu(ctxt), msr_index, pdata);
>  }
>  
>  static int emulator_check_pmc(struct x86_emulate_ctxt *ctxt,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


