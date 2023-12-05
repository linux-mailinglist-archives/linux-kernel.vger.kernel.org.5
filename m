Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F309804FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjLEKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjLEKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7795CA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701771133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tsUGpbvPWgiNfOOnIGKRFD0V7HrBn/6/gdKiWp5E06U=;
        b=h0pxOUf2mOOvqf4of6VhiNqrZrFkwdUe4L+SsNCjAv2ieDXZybwsNxxhoN6NZc6fizI4jQ
        w89HtGqdvwlEMJ3MrpAJgy2fIyqYicz0UMrzwyQ+OoQGbBjhtsCXpNSOkX8Q829j4pKOby
        csOd+czSi9vt7yKeTDyDZMNS4AzqkX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-iFTLNWp1MK2wogZVPHfZTQ-1; Tue, 05 Dec 2023 05:12:12 -0500
X-MC-Unique: iFTLNWp1MK2wogZVPHfZTQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3dbe99d9so42477575e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771131; x=1702375931;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsUGpbvPWgiNfOOnIGKRFD0V7HrBn/6/gdKiWp5E06U=;
        b=cO3JdNZ2yWrnExNWl/IcxvUPvHe+kgDYH+w8Ds6+DcmKFQgOWAFrQSFrX5PEDsS9x/
         c/iKHoKjVAxF3UBazkGl135l9aNQM8RVpZUY2ca/XLYiSiTfuMJQ7KR4rIBfqnLa9zNF
         02Ae4feEXCqyEZ8nzD/V6UUXpJBQjh+xAJka+AoTC18Q0PAYJVOgp+sqV9ywWK46k9Rb
         P9IGnFWrXr+sC/FbiS92IxxaFQCyPkhDN9ewiV4K4I79fDJ047XBS+472pi0Xv9eTKO/
         b8afIJL1aEl0c3sH04kevefpfnQVPxgwfi8OVGgmmW85jY0BBodtMnqLiGNppFwR52jK
         BhRg==
X-Gm-Message-State: AOJu0YzqLXc8kLne7L9oLb2/ekIiQkmMbiZB3TPmPILHbK4jS48DpNoU
        xUze+ok3biKuyvvjknITrS/sssc8GUc1W7/9zOmmlyQ2+A16qeSs5zUFek+NwrmS2/C8uObw3MZ
        DfiDW0DeknD5JSrIgkzgBIO2d
X-Received: by 2002:a05:600c:164a:b0:40b:5e59:b7bf with SMTP id o10-20020a05600c164a00b0040b5e59b7bfmr305144wmn.156.1701771131338;
        Tue, 05 Dec 2023 02:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU4YvVZ/13LRyQV/cxe/cTfToxoCTPqZkw2dxSajWfsz/99ZltqGRck+SSYurG6CQ4ZKy8kA==
X-Received: by 2002:a05:600c:164a:b0:40b:5e59:b7bf with SMTP id o10-20020a05600c164a00b0040b5e59b7bfmr305132wmn.156.1701771130880;
        Tue, 05 Dec 2023 02:12:10 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm18055059wmb.6.2023.12.05.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:12:10 -0800 (PST)
Message-ID: <8a2216b0c1a945e33a18a981cbce7737a07de52d.camel@redhat.com>
Subject: Re: [PATCH v7 26/26] KVM: nVMX: Enable CET support for nested guest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 05 Dec 2023 12:12:08 +0200
In-Reply-To: <e7d399a2-a4ff-4e27-af09-a8611985648a@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-27-weijiang.yang@intel.com>
         <2e280f545e8b15500fc4a2a77f6000a51f6f8bbd.camel@redhat.com>
         <e7d399a2-a4ff-4e27-af09-a8611985648a@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 16:50 +0800, Yang, Weijiang wrote:
> On 12/1/2023 1:53 AM, Maxim Levitsky wrote:
> > On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> > > Set up CET MSRs, related VM_ENTRY/EXIT control bits and fixed CR4 setting
> > > to enable CET for nested VM.
> > > 
> > > Note, generally L1 VMM only touches CET VMCS fields when live migration or
> > > vmcs_{read,write}() to the fields happens, so the fields only need to be
> > > synced in these "rare" cases.
> > To be honest we can't assume anything about L1, but what we can assume
> > 
> > is that if vmcs12 field is not shadowed, then L1 vmwrite/vmread will
> > be always intercepted and during the interception the fields can be synced,
> > however I studied this area long ago and I might be mistaken.
> 
> The changelog wording failed to express what I meant to say:
> vmcs12 and vmcs02 should be synced to reflect the correct CET states L1 or L2 are expected
> to see. In LM case, the nested CET states should also be synced between L1 or L2 via the
> control structures.
> 
> Will reword them, thanks for pointing it out!
> > >   And here only considers the case that L1 VMM
> > > has set VM_ENTRY_LOAD_CET_STATE in its VMCS vm_entry_controls as it's the
> > > common usage.
> > > 
> > > Suggested-by: Chao Gao <chao.gao@intel.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/nested.c | 48 +++++++++++++++++++++++++++++++++++++--
> > >   arch/x86/kvm/vmx/vmcs12.c |  6 +++++
> > >   arch/x86/kvm/vmx/vmcs12.h | 14 +++++++++++-
> > >   arch/x86/kvm/vmx/vmx.c    |  2 ++
> > >   4 files changed, 67 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index d8c32682ca76..965173650542 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -660,6 +660,28 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
> > >   	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > >   					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
> > >   
> > > +	/* Pass CET MSRs to nested VM if L0 and L1 are set to pass-through. */
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_U_CET, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_S_CET, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_PL1_SSP, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_PL2_SSP, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> > > +
> > > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > > +					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> > > +
> > >   	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
> > >   
> > >   	vmx->nested.force_msr_bitmap_recalc = false;
> > > @@ -2469,6 +2491,18 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
> > >   		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
> > >   		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
> > >   			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> > > +
> > > +		if (vmx->nested.nested_run_pending &&
> > I don't think that nested.nested_run_pending check is needed.
> > prepare_vmcs02_rare is not going to be called unless the nested run is pending.
> 
> But there're other paths along to call prepare_vmcs02_rare(), e.g., vmx_set_nested_state()-> nested_vmx_enter_non_root_mode()-> prepare_vmcs02_rare(), especially when L1 instead of L2 was running. In this case, nested.nested_run_pending == false,
> we don't need to update vmcs02's fields at the point until L2 is being resumed.

- If we restore VM from migration stream when L2 is *not running*, then prepare_vmcs02_rare won't be called,
because nested_vmx_enter_non_root_mode will not be called, because in turn there is no nested vmcs to load.

- If we restore VM from migration stream when L2 is *about to run* (KVM emulated the VMRESUME/VMLAUNCH,
but we didn't do the actual hardware VMLAUNCH/VMRESUME on vmcs02, then the 'nested_run_pending' will be true, it will be restored
from the migration stream.

- If we migrate while nested guest was run once but didn't VMEXIT to L1 yet, then yes, nested.nested_run_pending will be false indeed,
but we still need to setup vmcs02, otherwise it will be left with default zero values.

Remember that prior to setting nested state the VM wasn't running even once usually, unlike when the guest enters nested state normally.



> 
> > > +		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> > > +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> > > +				vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> > > +				vmcs_writel(GUEST_INTR_SSP_TABLE,
> > > +					    vmcs12->guest_ssp_tbl);
> > > +			}
> > > +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> > > +			    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT))
> > > +				vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> > > +		}
> > >   	}
> > >   
> > >   	if (nested_cpu_has_xsaves(vmcs12))
> > > @@ -4300,6 +4334,15 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
> > >   	vmcs12->guest_pending_dbg_exceptions =
> > >   		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
> > >   
> > > +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> > > +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> > > +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> > > +	}
> > > +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> > > +	    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT)) {
> > > +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> > > +	}
> > The above code should be conditional on VM_ENTRY_LOAD_CET_STATE - if the guest (L2) state
> > was loaded, then it must be updated on exit - this is usually how VMX works.
> 
> I think this is not for L2 VM_ENTRY_LOAD_CET_STATE, it happens in prepare_vmcs02_rare(). IIUC, the guest registers will be saved into VMCS fields unconditionally when vm-exit happens,
> so these fields for L2 guest should be synced to L1 unconditionally.

"the guest registers will be saved into VMCS fields unconditionally"
This is not true, unless there is a bug. the vmcs12 VM_ENTRY_LOAD_CET_STATE should be passed through as is to vmcs02, so if the nested guest doesn't set this bit
the entry/exit using vmcs02 will not touch the CET state, which is unusual but allowed by the spec I think - a nested hypervisor can opt for example to save/load
this state manually or use msr load/store lists instead.

Regardless of this,
if the guest didn't set VM_ENTRY_LOAD_CET_STATE, then vmcs12 guest fields should neither be loaded on VM entry (copied to vmcs02) nor updated on VM exit,
(that is copied back to vmcs12) this is what is written in the VMX spec.


Best regards,
	Maxim Levitsky

> 
> > Also I don't see any mention of usage of VM_EXIT_LOAD_CET_STATE, which if set,
> > should reset the L1 CET state to values in 'host_s_cet/host_ssp/host_ssp_tbl'
> > (This is also a common theme in VMX - host state is reset to values that the hypervisor
> > sets in VMCS, and the hypervisor must care to update these fields itself).
> 
> Yes, the host CET states for L1 also should be synced, I'll add the missing part, thanks!



> 
> > As a rule of thumb, if you add a field to vmcs12, you should use it somewhere,
> > and you should never use it unconditionally, as almost always its use
> > depends on entry or exit controls.
> > 
> > Same is true for entry/exit/execution controls - if you add one, you almost
> > always have to use it somewhere.
> 
> I'll double check if anything is lost in various cases, thanks!
> 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > > +
> > >   	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
> > >   }
> > >   
> > > @@ -6798,7 +6841,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
> > >   		VM_EXIT_HOST_ADDR_SPACE_SIZE |
> > >   #endif
> > >   		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> > > -		VM_EXIT_CLEAR_BNDCFGS;
> > > +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
> > >   	msrs->exit_ctls_high |=
> > >   		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
> > >   		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> > > @@ -6820,7 +6863,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
> > >   #ifdef CONFIG_X86_64
> > >   		VM_ENTRY_IA32E_MODE |
> > >   #endif
> > > -		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
> > > +		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> > > +		VM_ENTRY_LOAD_CET_STATE;
> > >   	msrs->entry_ctls_high |=
> > >   		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
> > >   		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
> > > diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> > > index 106a72c923ca..4233b5ca9461 100644
> > > --- a/arch/x86/kvm/vmx/vmcs12.c
> > > +++ b/arch/x86/kvm/vmx/vmcs12.c
> > > @@ -139,6 +139,9 @@ const unsigned short vmcs12_field_offsets[] = {
> > >   	FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions),
> > >   	FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp),
> > >   	FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip),
> > > +	FIELD(GUEST_S_CET, guest_s_cet),
> > > +	FIELD(GUEST_SSP, guest_ssp),
> > > +	FIELD(GUEST_INTR_SSP_TABLE, guest_ssp_tbl),
> > >   	FIELD(HOST_CR0, host_cr0),
> > >   	FIELD(HOST_CR3, host_cr3),
> > >   	FIELD(HOST_CR4, host_cr4),
> > > @@ -151,5 +154,8 @@ const unsigned short vmcs12_field_offsets[] = {
> > >   	FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip),
> > >   	FIELD(HOST_RSP, host_rsp),
> > >   	FIELD(HOST_RIP, host_rip),
> > > +	FIELD(HOST_S_CET, host_s_cet),
> > > +	FIELD(HOST_SSP, host_ssp),
> > > +	FIELD(HOST_INTR_SSP_TABLE, host_ssp_tbl),
> > >   };
> > >   const unsigned int nr_vmcs12_fields = ARRAY_SIZE(vmcs12_field_offsets);
> > > diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
> > > index 01936013428b..3884489e7f7e 100644
> > > --- a/arch/x86/kvm/vmx/vmcs12.h
> > > +++ b/arch/x86/kvm/vmx/vmcs12.h
> > > @@ -117,7 +117,13 @@ struct __packed vmcs12 {
> > >   	natural_width host_ia32_sysenter_eip;
> > >   	natural_width host_rsp;
> > >   	natural_width host_rip;
> > > -	natural_width paddingl[8]; /* room for future expansion */
> > > +	natural_width host_s_cet;
> > > +	natural_width host_ssp;
> > > +	natural_width host_ssp_tbl;
> > > +	natural_width guest_s_cet;
> > > +	natural_width guest_ssp;
> > > +	natural_width guest_ssp_tbl;
> > > +	natural_width paddingl[2]; /* room for future expansion */
> > >   	u32 pin_based_vm_exec_control;
> > >   	u32 cpu_based_vm_exec_control;
> > >   	u32 exception_bitmap;
> > > @@ -292,6 +298,12 @@ static inline void vmx_check_vmcs12_offsets(void)
> > >   	CHECK_OFFSET(host_ia32_sysenter_eip, 656);
> > >   	CHECK_OFFSET(host_rsp, 664);
> > >   	CHECK_OFFSET(host_rip, 672);
> > > +	CHECK_OFFSET(host_s_cet, 680);
> > > +	CHECK_OFFSET(host_ssp, 688);
> > > +	CHECK_OFFSET(host_ssp_tbl, 696);
> > > +	CHECK_OFFSET(guest_s_cet, 704);
> > > +	CHECK_OFFSET(guest_ssp, 712);
> > > +	CHECK_OFFSET(guest_ssp_tbl, 720);
> > >   	CHECK_OFFSET(pin_based_vm_exec_control, 744);
> > >   	CHECK_OFFSET(cpu_based_vm_exec_control, 748);
> > >   	CHECK_OFFSET(exception_bitmap, 752);
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index a1aae8709939..947028ff2e25 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -7734,6 +7734,8 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
> > >   	cr4_fixed1_update(X86_CR4_PKE,        ecx, feature_bit(PKU));
> > >   	cr4_fixed1_update(X86_CR4_UMIP,       ecx, feature_bit(UMIP));
> > >   	cr4_fixed1_update(X86_CR4_LA57,       ecx, feature_bit(LA57));
> > > +	cr4_fixed1_update(X86_CR4_CET,	      ecx, feature_bit(SHSTK));
> > > +	cr4_fixed1_update(X86_CR4_CET,	      edx, feature_bit(IBT));
> > >   
> > >   #undef cr4_fixed1_update
> > >   }




