Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D180A740
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574308AbjLHPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574288AbjLHPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45755F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702048925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMpEHEWeBJiRKiljI8AYQOYnbMlOiSxdN7AAtvVlKMY=;
        b=dLgYDBwPzLl3omQBZ2sf4Hxy79gHdLeDeC0uKF5qmqvdhlU6LNGHBOSiwPMVN3sZgcgd/2
        5G7ZAe/QfmHKSnI7DCB0KDYOdkEpRhKnUuTqPSOd4gX9QmVm3hFgwDdMleb78qx02arQOc
        i7UVXG+Pw8MwhP8NeSSDAS2Unt+D4O8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-wi5QtG2BO4mhKD_nZpUQhw-1; Fri, 08 Dec 2023 10:22:04 -0500
X-MC-Unique: wi5QtG2BO4mhKD_nZpUQhw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33343bb5dc2so1854122f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048923; x=1702653723;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMpEHEWeBJiRKiljI8AYQOYnbMlOiSxdN7AAtvVlKMY=;
        b=MHcSoGreGib3acUaATUzML/JOgMMEKrN6A4M8Ls7xfFyRl2wMXkm5qX5DKHe5ED4+9
         gBCodlzsWljdMacOVWxzy3r8yckq/ZrLFQlJXMXnB6/IxU0TyTVVgZHxp2paUUk5+vRy
         83fpB8gN8jOh0tMGqrPwiMqIekZMPexIdHskY3hjPu6iDSj1SFNUa3384cRsAKMnEWEk
         68G7DfsrR5VvQC9us+4EZznj///IttlJJuHyttAS4zXq/0Gnh9qO3ey+JClc1tZ0qhNL
         4L5RfgrwrSmCDkyItfdtYNiNAtT0hVFkW+BuF9MgPU2Z08foRLsdO8+UelnmDjq4ADxz
         x/ww==
X-Gm-Message-State: AOJu0Yx70qHFQ86Ly1F1ckdCSxpQeWsUhXd00N1EhH+c+sV9xIapvPjP
        /N5QX5Oyok3AvomP3XE/08bSv75Ml4q+zsL2R1Y9tdBXRvtLkUP2K4oA/CZqi9ADiMS2jnbYnAh
        cKoQK6knmQU59Gy0aqoLy1+oAppCcR+g4
X-Received: by 2002:a5d:6208:0:b0:333:2fd2:6f54 with SMTP id y8-20020a5d6208000000b003332fd26f54mr95994wru.94.1702048922817;
        Fri, 08 Dec 2023 07:22:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHUgZ+fa74kzYWlGL2pTMVmRHNm573py6sxEDn8HMP5DfZ5zq1imbHFg6TR0JWkTaVMxrtSA==
X-Received: by 2002:a5d:6208:0:b0:333:2fd2:6f54 with SMTP id y8-20020a5d6208000000b003332fd26f54mr95978wru.94.1702048922459;
        Fri, 08 Dec 2023 07:22:02 -0800 (PST)
Received: from starship ([89.237.98.20])
        by smtp.gmail.com with ESMTPSA id d23-20020adf9b97000000b003333beb564asm2281013wrc.5.2023.12.08.07.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:22:02 -0800 (PST)
Message-ID: <06298f6200aa0b6e9eaf1d908d8499bb50467fe0.camel@redhat.com>
Subject: Re: [PATCH v7 26/26] KVM: nVMX: Enable CET support for nested guest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Fri, 08 Dec 2023 17:22:00 +0200
In-Reply-To: <26313af3-3a75-4a3c-9935-526b07a6277d@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-27-weijiang.yang@intel.com>
         <2e280f545e8b15500fc4a2a77f6000a51f6f8bbd.camel@redhat.com>
         <e7d399a2-a4ff-4e27-af09-a8611985648a@intel.com>
         <8a2216b0c1a945e33a18a981cbce7737a07de52d.camel@redhat.com>
         <73119078-7483-42e0-bb1f-b696932b6cd2@intel.com>
         <53a25a11927f0c4b3f689d532af2a0ee67826fa8.camel@redhat.com>
         <26313af3-3a75-4a3c-9935-526b07a6277d@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 23:15 +0800, Yang, Weijiang wrote:
> On 12/7/2023 1:24 AM, Maxim Levitsky wrote:
> > On Wed, 2023-12-06 at 17:22 +0800, Yang, Weijiang wrote:
> > > On 12/5/2023 6:12 PM, Maxim Levitsky wrote:
> > > > On Mon, 2023-12-04 at 16:50 +0800, Yang, Weijiang wrote:
> > > [...]
> > > 
> > > > > > >     	vmx->nested.force_msr_bitmap_recalc = false;
> > > > > > > @@ -2469,6 +2491,18 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
> > > > > > >     		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
> > > > > > >     		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
> > > > > > >     			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> > > > > > > +
> > > > > > > +		if (vmx->nested.nested_run_pending &&
> > > > > > I don't think that nested.nested_run_pending check is needed.
> > > > > > prepare_vmcs02_rare is not going to be called unless the nested run is pending.
> > > > > But there're other paths along to call prepare_vmcs02_rare(), e.g., vmx_set_nested_state()-> nested_vmx_enter_non_root_mode()-> prepare_vmcs02_rare(), especially when L1 instead of L2 was running. In this case, nested.nested_run_pending == false,
> > > > > we don't need to update vmcs02's fields at the point until L2 is being resumed.
> > > > - If we restore VM from migration stream when L2 is *not running*, then prepare_vmcs02_rare won't be called,
> > > > because nested_vmx_enter_non_root_mode will not be called, because in turn there is no nested vmcs to load.
> > > > 
> > > > - If we restore VM from migration stream when L2 is *about to run* (KVM emulated the VMRESUME/VMLAUNCH,
> > > > but we didn't do the actual hardware VMLAUNCH/VMRESUME on vmcs02, then the 'nested_run_pending' will be true, it will be restored
> > > > from the migration stream.
> > > > 
> > > > - If we migrate while nested guest was run once but didn't VMEXIT to L1 yet, then yes, nested.nested_run_pending will be false indeed,
> > > > but we still need to setup vmcs02, otherwise it will be left with default zero values.
> > > Thanks a lot for recapping these cases! I overlooked some nested flags before. It makes sense to remove nested.nested_run_pending.
> > > > Remember that prior to setting nested state the VM wasn't running even once usually, unlike when the guest enters nested state normally.
> > > > 
> > > > > > > +		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
> > > > > > > +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> > > > > > > +				vmcs_writel(GUEST_SSP, vmcs12->guest_ssp);
> > > > > > > +				vmcs_writel(GUEST_INTR_SSP_TABLE,
> > > > > > > +					    vmcs12->guest_ssp_tbl);
> > > > > > > +			}
> > > > > > > +			if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> > > > > > > +			    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT))
> > > > > > > +				vmcs_writel(GUEST_S_CET, vmcs12->guest_s_cet);
> > > > > > > +		}
> > > > > > >     	}
> > > > > > >     
> > > > > > >     	if (nested_cpu_has_xsaves(vmcs12))
> > > > > > > @@ -4300,6 +4334,15 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
> > > > > > >     	vmcs12->guest_pending_dbg_exceptions =
> > > > > > >     		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
> > > > > > >     
> > > > > > > +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK)) {
> > > > > > > +		vmcs12->guest_ssp = vmcs_readl(GUEST_SSP);
> > > > > > > +		vmcs12->guest_ssp_tbl = vmcs_readl(GUEST_INTR_SSP_TABLE);
> > > > > > > +	}
> > > > > > > +	if (guest_can_use(&vmx->vcpu, X86_FEATURE_SHSTK) ||
> > > > > > > +	    guest_can_use(&vmx->vcpu, X86_FEATURE_IBT)) {
> > > > > > > +		vmcs12->guest_s_cet = vmcs_readl(GUEST_S_CET);
> > > > > > > +	}
> > > > > > The above code should be conditional on VM_ENTRY_LOAD_CET_STATE - if the guest (L2) state
> > > > > > was loaded, then it must be updated on exit - this is usually how VMX works.
> > > > > I think this is not for L2 VM_ENTRY_LOAD_CET_STATE, it happens in prepare_vmcs02_rare(). IIUC, the guest registers will be saved into VMCS fields unconditionally when vm-exit happens,
> > > > > so these fields for L2 guest should be synced to L1 unconditionally.
> > > > "the guest registers will be saved into VMCS fields unconditionally"
> > > > This is not true, unless there is a bug.
> > > I checked the latest SDM, there's no such kind of wording regarding CET entry/exit control bits. The wording comes from
> > > the individual CET spec.:
> > > "10.6 VM Exit
> > > On processors that support CET, the VM exit saves the state of IA32_S_CET, SSP and IA32_INTERRUPT_SSP_TABLE_ADDR MSR to the VMCS guest-state area unconditionally."
> > > But since it doesn't appear in SDM, I shouldn't take it for granted.
> > SDM spec from September 2023:
> > 
> > 28.3.1 Saving Control Registers, Debug Registers, and MSRs
> > 
> > "If the processor supports the 1-setting of the “load CET” VM-entry control, the contents of the IA32_S_CET and
> > IA32_INTERRUPT_SSP_TABLE_ADDR MSRs are saved into the corresponding fields. On processors that do not
> > support Intel 64 architecture, bits 63:32 of these MSRs are not saved."
> > 
> > Honestly it's not 100% clear if the “load CET” should be set to 1 to trigger the restore, or that this control just needs to be
> > supported on the CPU.
> > It does feel like you are right here, that CPU always saves the guest state, but allows to not load it on VM entry via
> > “load CET” VM entry control.
> > 
> > IMHO its best to check what the bare metal does by rigging a test by patching the host kernel to not set the 'load CET' control,
> > and see if the CPU still updates the guest CET fields on the VM exit.
> 
> OK, I'll do some tests to see what's happening, thanks!
> > > > the vmcs12 VM_ENTRY_LOAD_CET_STATE should be passed through as is to vmcs02, so if the nested guest doesn't set this bit
> > > > the entry/exit using vmcs02 will not touch the CET state, which is unusual but allowed by the spec I think - a nested hypervisor can opt for example to save/load
> > > > this state manually or use msr load/store lists instead.
> > > Right although the use case should be rare, will modify the code to check VM_ENTRY_LOAD_CET_STATE. Thanks!
> > > > Regardless of this,
> > > > if the guest didn't set VM_ENTRY_LOAD_CET_STATE, then vmcs12 guest fields should neither be loaded on VM entry (copied to vmcs02) nor updated on VM exit,
> > > > (that is copied back to vmcs12) this is what is written in the VMX spec.
> > > What's the VMX spec. your're referring to here?
> > SDM.
> > 
> > In fact, now that I am thinking about this again, it should be OK to unconditionally copy the CET fields from vmcs12 to vmcs02, because as long as the
> > VM_ENTRY_LOAD_CET_STATE is not set, the CPU should care about their values in the vmcs02.
I noticed a typo. I meant that the CPU should't  care about their values in the vmcs02.

> > 
> > And about the other way around, assuming that I made a mistake as I said above, then the other way around is indeed unconditional.
> > 
> > 
> > Sorry for a bit of a confusion.
> 
> NP, I also double check it with HW Arch and get it back.
> Thanks for raising these questions!

Thanks to you too!


Best regards,
	Maxim Levitsky

> 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 


