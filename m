Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094C7DDECC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKAJzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB5DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698832486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmky+d0S1/rhhTo9Yque25pyb/Pto+oWnWO53iebzz0=;
        b=fqEtZMG+601kYdcwRjKNLqnXP0fQp16rL6C0+RsCj8XyLNC5009/BFCsW1I6D/cfD5j1Cg
        g/U+XhaGK/IdU5Dx8UfhWPsG5+yVtfmemLZIyGxqMjCPwJQDaZG7YSvGynFVovUHHerfA+
        QSuoYgzm1suHIyWdXtMWfCfxmkZQLi8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-qA9v3x8UMiGp4--JNnhd2A-1; Wed, 01 Nov 2023 05:54:45 -0400
X-MC-Unique: qA9v3x8UMiGp4--JNnhd2A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7384d5a2so2446576f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698832484; x=1699437284;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmky+d0S1/rhhTo9Yque25pyb/Pto+oWnWO53iebzz0=;
        b=q+V9fKxb8hX0+EPU+bL8AhMhKto+qK0R6bKc95n4wrmK2Ieum3979lDRYkr5sXyqkV
         bUlcjOyW/SYi01Hk8BBZxbxGBQ3KbG6ehKnIy2JZv+ZbZoUI8k3SU8HKFEkmTDfKdWqU
         1NRlLylW4RBUg6aky/TvY4b7SKDESLkxpSmQrMcovNTIUXNupsx1MDBzL5nly2WZxcwW
         p8nYxBLauY+Hqs1Gct2N1vjoIJhPZGDqru4jN1kZQqcgYD5d4qU99wJHhLJG/i44RKZw
         NOWUNWTCFXjiVHrjTqaS+dvrhf9PRwaRJ4gBdK3+9HDz0U3om6QoE7QZhmWYSsxg3eub
         +oeg==
X-Gm-Message-State: AOJu0Yw668pY1XKRKKRt/ylI6Sc2kpJnj5EZwzEtzLlnmgl1ZhjvOfEU
        su8ZJEMHXtyzx8I42vhHWrnZBieiEMcbHGvTNBqO4qWnkA5+C8jFWpHjBmZDddKdmbGNcN1rUtC
        Yl6vpv5JzanN4rtqnULUn+8Nz
X-Received: by 2002:a5d:6c68:0:b0:32f:79e5:8119 with SMTP id r8-20020a5d6c68000000b0032f79e58119mr13085836wrz.1.1698832484305;
        Wed, 01 Nov 2023 02:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHidRT7yjwrbc9aMRfX7SAI1gpH9368tdbJJqdy+Je3huWDhjvSXSj0GTN2o0I01zEjQU3M6g==
X-Received: by 2002:a5d:6c68:0:b0:32f:79e5:8119 with SMTP id r8-20020a5d6c68000000b0032f79e58119mr13085817wrz.1.1698832483933;
        Wed, 01 Nov 2023 02:54:43 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b0032dbf99bf4fsm3684189wro.89.2023.11.01.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:54:43 -0700 (PDT)
Message-ID: <e29c2c8c18f989b83ea2d696ae93590fe5c0ff53.camel@redhat.com>
Subject: Re: [PATCH v6 25/25] KVM: nVMX: Enable CET support for nested guest
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Chao Gao <chao.gao@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        peterz@infradead.org, rick.p.edgecombe@intel.com,
        john.allen@amd.com
Date:   Wed, 01 Nov 2023 11:54:41 +0200
In-Reply-To: <ZUGzZiF0Jn8GVcr+@chao-email>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-26-weijiang.yang@intel.com>
         <ZUGzZiF0Jn8GVcr+@chao-email>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-01 at 10:09 +0800, Chao Gao wrote:
> On Thu, Sep 14, 2023 at 02:33:25AM -0400, Yang Weijiang wrote:
> > Set up CET MSRs, related VM_ENTRY/EXIT control bits and fixed CR4 setting
> > to enable CET for nested VM.
> > 
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> > arch/x86/kvm/vmx/nested.c | 27 +++++++++++++++++++++++++--
> > arch/x86/kvm/vmx/vmcs12.c |  6 ++++++
> > arch/x86/kvm/vmx/vmcs12.h | 14 +++++++++++++-
> > arch/x86/kvm/vmx/vmx.c    |  2 ++
> > 4 files changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 78a3be394d00..2c4ff13fddb0 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -660,6 +660,28 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
> > 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > 					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
> > 
> > +	/* Pass CET MSRs to nested VM if L0 and L1 are set to pass-through. */
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_U_CET, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_S_CET, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_PL1_SSP, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_PL2_SSP, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> > +
> > +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> > +					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
> > +
> > 	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
> > 
> > 	vmx->nested.force_msr_bitmap_recalc = false;
> > @@ -6794,7 +6816,7 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
> > 		VM_EXIT_HOST_ADDR_SPACE_SIZE |
> > #endif
> > 		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT |
> > -		VM_EXIT_CLEAR_BNDCFGS;
> > +		VM_EXIT_CLEAR_BNDCFGS | VM_EXIT_LOAD_CET_STATE;
> > 	msrs->exit_ctls_high |=
> > 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
> > 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> > @@ -6816,7 +6838,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
> > #ifdef CONFIG_X86_64
> > 		VM_ENTRY_IA32E_MODE |
> > #endif
> > -		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
> > +		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> > +		VM_ENTRY_LOAD_CET_STATE;
> > 	msrs->entry_ctls_high |=
> > 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
> > 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
> > diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> > index 106a72c923ca..4233b5ca9461 100644
> > --- a/arch/x86/kvm/vmx/vmcs12.c
> > +++ b/arch/x86/kvm/vmx/vmcs12.c
> > @@ -139,6 +139,9 @@ const unsigned short vmcs12_field_offsets[] = {
> > 	FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions),
> > 	FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp),
> > 	FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip),
> > +	FIELD(GUEST_S_CET, guest_s_cet),
> > +	FIELD(GUEST_SSP, guest_ssp),
> > +	FIELD(GUEST_INTR_SSP_TABLE, guest_ssp_tbl),
> 
> I think we need to sync guest states, e.g., guest_s_cet/guest_ssp/guest_ssp_tbl,
> between vmcs02 and vmcs12 on nested VM entry/exit, probably in
> sync_vmcs02_to_vmcs12() and prepare_vmcs12() or "_rare" variants of them.
> 

Aha, this is why I suspected that nested support is incomplete, 
100% agree.

In particular, looking at Intel's SDM I see that:

HOST_S_CET, HOST_SSP, HOST_INTR_SSP_TABLE needs to be copied from vmcb12 to vmcb02 but not vise versa
because the CPU doesn't touch them.

GUEST_S_CET, GUEST_SSP, GUEST_INTR_SSP_TABLE should be copied bi-directionally.

This of course depends on the corresponding vm entry and vm exit controls being set.
That means that it is legal in theory to do VM entry/exit with CET enabled but not use 
VM_ENTRY_LOAD_CET_STATE and/or VM_EXIT_LOAD_CET_STATE,
because for example nested hypervisor in theory can opt to save/load these itself.

I think that this is all, but I also can't be 100% sure. This thing has to be tested well before
we can be sure that it works.

Best regards,
	Maxim Levitsky

