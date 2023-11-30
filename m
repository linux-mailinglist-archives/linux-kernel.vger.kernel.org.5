Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F477FF92C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjK3SP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjK3SP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E4810E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701368160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jFx75F08lvUnGClRbcPA/+lk5WtIKWp7dBnqR8MnnQ=;
        b=Mi0upb529XmXIS58df9xdwFMPUzz9oFCDsAfrfHLsa3yTjFFox2NZePw14+UoTOvLkCXC3
        rOz2Fe+GYrHVgBBfA7C70JGmbOCiGM/wFWdZsCtZGg7JOVMGvdd/PiHI3/VFv0D0Htgmgn
        Hu9KhZ69EKzN4t5fT53QpkgFIf5RzNY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-Rw88x9jpOJeQzCvkLtPwUg-1; Thu, 30 Nov 2023 13:15:58 -0500
X-MC-Unique: Rw88x9jpOJeQzCvkLtPwUg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c9b585b0d3so15707621fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368157; x=1701972957;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jFx75F08lvUnGClRbcPA/+lk5WtIKWp7dBnqR8MnnQ=;
        b=vkuTVjFWxz4xO1Z+A2CbLFu/Q/IoYnXHUEq0PegXErgeVOeOJ7/k0AGLBdRksu+POA
         6Rwcy99a3Q461Ftvq5mHfpvMXH/jGgYBCZC8+ncNAxCU2r++zYN5OuaO1dMtoyeCB7ww
         1hBT/BBSIAKpnl6Y5sehjmErQEnO47obNM3ArZJNwrYAgZeEM+/obyVBNn2ekf7tmyq9
         5t+hHAPvpJ99yaqu1Y4eH4FST/kU/jVskyaQQQB6If0PtP1dYU70SMxwl8/YN6HE76hW
         /a4e4WLu4dIFK4phwkfGhAriU9/iewi5qnxxMVzHVvUI/BoENokSc4VAIdluMJuWZKRW
         E6bQ==
X-Gm-Message-State: AOJu0YwQBYNATRlzO/i3gqYAVkRvJp0Hl8PV1/8+GaUxSEprkc3wNbne
        lkSBhX8hI/WD+iY3YPo2ZcrkA12mInmfVDTfm7V7TK2dvlXg1G/oZNVoSetA3jtdmjMBo0vklJg
        IYgisjnr9KjE3HhPsfZ2NQAyBKzI7TIVm
X-Received: by 2002:a05:600c:1d24:b0:40b:4aed:ef31 with SMTP id l36-20020a05600c1d2400b0040b4aedef31mr7149wms.21.1701366870198;
        Thu, 30 Nov 2023 09:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIeoJSxrAFHS2BdxOmhAs4+IKcHnEZVUlP+iPVqe3O8hZGeJaWPBNF5flVfGqhI0Ukgwcunw==
X-Received: by 2002:a17:906:739c:b0:a10:7811:f421 with SMTP id f28-20020a170906739c00b00a107811f421mr5439ejl.5.1701366800047;
        Thu, 30 Nov 2023 09:53:20 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id g22-20020a2ea4b6000000b002c9ba689a94sm201953ljm.137.2023.11.30.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:53:19 -0800 (PST)
Message-ID: <2e280f545e8b15500fc4a2a77f6000a51f6f8bbd.camel@redhat.com>
Subject: Re: [PATCH v7 26/26] KVM: nVMX: Enable CET support for nested guest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:53:16 +0200
In-Reply-To: <20231124055330.138870-27-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-27-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Set up CET MSRs, related VM_ENTRY/EXIT control bits and fixed CR4 setting
> to enable CET for nested VM.
> 
> Note, generally L1 VMM only touches CET VMCS fields when live migration or
> vmcs_{read,write}() to the fields happens, so the fields only need to be
> synced in these "rare" cases.
To be honest we can't assume anything about L1, but what we can assume

is that if vmcs12 field is not shadowed, then L1 vmwrite/vmread will
be always intercepted and during the interception the fields can be synced,
however I studied this area long ago and I might be mistaken.


>  And here only considers the case that L1 VMM
> has set VM_ENTRY_LOAD_CET_STATE in its VMCS vm_entry_controls as it's the
> common usage.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 48 +++++++++++++++++++++++++++++++++++++--
>  arch/x86/kvm/vmx/vmcs12.c |  6 +++++
>  arch/x86/kvm/vmx/vmcs12.h | 14 +++++++++++-
>  arch/x86/kvm/vmx/vmx.c    |  2 ++
>  4 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index d8c32682ca76..965173650542 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -660,6 +660,28 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
>  
> +	/* Pass CET MSRs to nested VM if L0 and L1 are set to pass-through. */
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_U_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_S_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL1_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL2_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> +
>  	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
>  
>  	vmx->nested.force_msr_bitmap_recalc = false;
> @@ -2469,6 +2491,18 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>  		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
>  		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
>  			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> +
> +		if (vmx->nested.nested_run_pending &&

I don't think that nested.nested_run_pending check is needed. 
prepare_vmcs02_rare is not going to be called unless the nested run is pending.

> +		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> +				vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> +				vmcs_writel(GUEST_INTR_SSP_TABLE,
> +					    vmcs12->guest_ssp_tbl);
> +			}
> +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> +			    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT))
> +				vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> +		}
>  	}
>  
>  	if (nested_cpu_has_xsaves(vmcs12))
> @@ -4300,6 +4334,15 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
>  	vmcs12->guest_pending_dbg_exceptions =
>  		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
>  
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> +	}
> +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> +	    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT)) {
> +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> +	}

The above code should be conditional on VM_ENTRY_LOAD_CET_STATE - if the guest (L2) state
was loaded, then it must be updated on exit - this is usually how VMX works.


Also I don't see any mention of usage of VM_EXIT_LOAD_CET_STATE, which if set,
should reset the L1 CET state to values in 'host_s_cet/host_ssp/host_ssp_tbl'
(This is also a common theme in VMX - host state is reset to values that the hypervisor
sets in VMCS, and the hypervisor must care to update these fields itself).


As a rule of thumb, if you add a field to vmcs12, you should use it somewhere,
and you should never use it unconditionally, as almost always its use
depends on entry or exit controls.

Same is true for entry/exit/execution controls - if you add one, you almost
always have to use it somewhere.


Best regards,
	Maxim Levitsky

> +
>  	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
>  }
>  
> @@ -6798,7 +6841,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
>  		VM_EXIT_HOST_ADDR_SPACE_SIZE |
>  #endif
>  		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> -		VM_EXIT_CLEAR_BNDCFGS;
> +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
>  	msrs->exit_ctls_high |=
>  		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
>  		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> @@ -6820,7 +6863,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
>  #ifdef CONFIG_X86_64
>  		VM_ENTRY_IA32E_MODE |
>  #endif
> -		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
> +		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> +		VM_ENTRY_LOAD_CET_STATE;
>  	msrs->entry_ctls_high |=
>  		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
>  		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> index 106a72c923ca..4233b5ca9461 100644
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
> @@ -139,6 +139,9 @@ const unsigned short vmcs12_field_offsets[] = {
>  	FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions),
>  	FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp),
>  	FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip),
> +	FIELD(GUEST_S_CET, guest_s_cet),
> +	FIELD(GUEST_SSP, guest_ssp),
> +	FIELD(GUEST_INTR_SSP_TABLE, guest_ssp_tbl),
>  	FIELD(HOST_CR0, host_cr0),
>  	FIELD(HOST_CR3, host_cr3),
>  	FIELD(HOST_CR4, host_cr4),
> @@ -151,5 +154,8 @@ const unsigned short vmcs12_field_offsets[] = {
>  	FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip),
>  	FIELD(HOST_RSP, host_rsp),
>  	FIELD(HOST_RIP, host_rip),
> +	FIELD(HOST_S_CET, host_s_cet),
> +	FIELD(HOST_SSP, host_ssp),
> +	FIELD(HOST_INTR_SSP_TABLE, host_ssp_tbl),
>  };
>  const unsigned int nr_vmcs12_fields = ARRAY_SIZE(vmcs12_field_offsets);
> diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
> index 01936013428b..3884489e7f7e 100644
> --- a/arch/x86/kvm/vmx/vmcs12.h
> +++ b/arch/x86/kvm/vmx/vmcs12.h
> @@ -117,7 +117,13 @@ struct __packed vmcs12 {
>  	natural_width host_ia32_sysenter_eip;
>  	natural_width host_rsp;
>  	natural_width host_rip;
> -	natural_width paddingl[8]; /* room for future expansion */
> +	natural_width host_s_cet;
> +	natural_width host_ssp;
> +	natural_width host_ssp_tbl;
> +	natural_width guest_s_cet;
> +	natural_width guest_ssp;
> +	natural_width guest_ssp_tbl;
> +	natural_width paddingl[2]; /* room for future expansion */
>  	u32 pin_based_vm_exec_control;
>  	u32 cpu_based_vm_exec_control;
>  	u32 exception_bitmap;
> @@ -292,6 +298,12 @@ static inline void vmx_check_vmcs12_offsets(void)
>  	CHECK_OFFSET(host_ia32_sysenter_eip, 656);
>  	CHECK_OFFSET(host_rsp, 664);
>  	CHECK_OFFSET(host_rip, 672);
> +	CHECK_OFFSET(host_s_cet, 680);
> +	CHECK_OFFSET(host_ssp, 688);
> +	CHECK_OFFSET(host_ssp_tbl, 696);
> +	CHECK_OFFSET(guest_s_cet, 704);
> +	CHECK_OFFSET(guest_ssp, 712);
> +	CHECK_OFFSET(guest_ssp_tbl, 720);
>  	CHECK_OFFSET(pin_based_vm_exec_control, 744);
>  	CHECK_OFFSET(cpu_based_vm_exec_control, 748);
>  	CHECK_OFFSET(exception_bitmap, 752);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a1aae8709939..947028ff2e25 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7734,6 +7734,8 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
>  	cr4_fixed1_update(X86_CR4_PKE,        ecx, feature_bit(PKU));
>  	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
>  	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
> +	cr4_fixed1_update(X86_CR4_CET,	      ecx, feature_bit(SHSTK));
> +	cr4_fixed1_update(X86_CR4_CET,	      edx, feature_bit(IBT));
>  
>  #undef cr4_fixed1_update
>  }


