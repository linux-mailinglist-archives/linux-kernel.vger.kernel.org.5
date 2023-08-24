Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A05787154
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbjHXOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbjHXOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:16:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10961BC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:16:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so89769857b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692886592; x=1693491392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCFwT9OWzYXlGFta3yO5lUt3hihkNbvJ/M6rc9c5vGE=;
        b=4MPlHGhm6qg5UazRU+pahOmzxmZOxNqeRDI7zl9zX/dk6lrwow9bn0Thj0D6CmAMgQ
         h7HCScWwJTjm4lp7ujccq+spSBp+luHTFgOPvxkWmeJ+7trNAhEilDl4HuWV0H1zvTny
         2PCXA0xMMAx5b58Uh0K/Us4BjFFHHaGWRekVf5K6zkfhY9FmnpUc8Zx7JG71fg2wwzxi
         F0UjyFg4XN0AZxMHza1THhmevHqgdpPyJW0SbXhg1BftLgiDdC05pHlCspiVYCogELxG
         MfUoTPT7pie9VGIDIxmOK9tzughK+QHkekgzvr+FnqgUOOEIPWduGvmg+yt+IegJ1OB+
         70qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886592; x=1693491392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCFwT9OWzYXlGFta3yO5lUt3hihkNbvJ/M6rc9c5vGE=;
        b=Fuw5Pz8UbCqZ0ZLrL64uqYoC54MNzXXp+lL8HHvv9P3DFw91dHshH6RtGy9oSdxp3p
         CbIqwdIjmHOrnNiBtmkRImtDEyL2sCF3WbnZpEgZz8sp+mnoVGBgOrijUeyAXdzAagk+
         xjlENGjqkFUu4v2YuLaaE44LAq9Y1eZ4iuuQYe6LDDGpsnBVpR97VtPsc0uJIdTKSGY5
         imJgLyVIas3Hq5qXEbRtGdjGtsdUalEjUd59FLA0irtZhElVrO2k2eIRstbAYFJIZCWL
         hVK5sAuhZNlDYtDPXa15N7nbZsJpO9CLsnjOfHBiOfPc6M0OvHJsRd3+r59tVrRw2iRr
         393Q==
X-Gm-Message-State: AOJu0YwsrgL0hNaQZIspCPJKDCOPU1EPmV9muErS7clIZ7TFaeode9cP
        1cc2puSeO/Tt4D6AnG4sJfa8izOupwg=
X-Google-Smtp-Source: AGHT+IHUqpRcOR/BEffrCxxISCp3XJB7P6r8HmpEYXQeQNZ14wXTVXHvOXBtAeJDe8/rhMtOggfmw6q59bI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a989:0:b0:586:aca7:c1ee with SMTP id
 g131-20020a81a989000000b00586aca7c1eemr234911ywh.6.1692886592236; Thu, 24 Aug
 2023 07:16:32 -0700 (PDT)
Date:   Thu, 24 Aug 2023 07:16:30 -0700
In-Reply-To: <e91f562b-ecdf-6745-a9b1-52fe19126bad@gmail.com>
Mime-Version: 1.0
References: <20221213060912.654668-1-seanjc@google.com> <20221213060912.654668-8-seanjc@google.com>
 <e91f562b-ecdf-6745-a9b1-52fe19126bad@gmail.com>
Message-ID: <ZOdmPqq6uXMSWOnV@google.com>
Subject: Re: [PATCH 7/7] KVM: VMX: Handle NMI VM-Exits in noinstr region
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023, Like Xu wrote:
> On 13/12/2022 2:09 pm, Sean Christopherson wrote:
> > Move VMX's handling of NMI VM-Exits into vmx_vcpu_enter_exit() so that
> > the NMI is handled prior to leaving the safety of noinstr.  Handling the
> > NMI after leaving noinstr exposes the kernel to potential ordering
> > problems as an instrumentation-induced fault, e.g. #DB, #BP, #PF, etc.
> > will unblock NMIs when IRETing back to the faulting instruction.
> (3) In addition, trace_kvm_exit() should ideally appear before the host NMI
> trace logs, which makes it easier to understand.

Ideally, yes, but tracepoints are not remotely noinstr friendly.

> A proposal fix is to delay vmx_do_nmi_irqoff() a little bit, but not a revert move:
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e6849f780dba..1f29b7f22da7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7230,13 +7230,6 @@ static noinstr void vmx_vcpu_enter_exit(struct
> kvm_vcpu *vcpu,
>  	else
>  		vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
> 
> -	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
> -	    is_nmi(vmx_get_intr_info(vcpu))) {
> -		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -		vmx_do_nmi_irqoff();
> -		kvm_after_interrupt(vcpu);
> -	}
> -
>  	guest_state_exit_irqoff();
>  }
> 
> @@ -7389,6 +7382,13 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
> 
>  	trace_kvm_exit(vcpu, KVM_ISA_VMX);
> 
> +	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
> +	    is_nmi(vmx_get_intr_info(vcpu))) {
> +		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> +		vmx_do_nmi_irqoff();
> +		kvm_after_interrupt(vcpu);
> +	}

No, the whole point of doing NMI handling in vmx_vcpu_enter_exit() is so that NMIs
are serviced before instrumentation is enabled.

I think the below is sufficient (untested at this point).  Not quite minimal, e.g.
I'm pretty sure there's (currently) no need to snapshot IDT_VECTORING_INFO_FIELD
so early, but I can't think of any reason to wait.

--
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 24 Aug 2023 06:49:36 -0700
Subject: [PATCH] KVM: VMX: Refresh available regs and IDT vectoring info
 before NMI handling

Reset the mask of available "registers" and refresh the IDT vectoring
info snapshot in vmx_vcpu_enter_exit(), before KVM potentially handles a
an NMI VM-Exit.  One of the "registers" that KVM VMX lazily loads is the
vmcs.VM_EXIT_INTR_INFO field, which is holds the vector+type on "exception
or NMI" VM-Exits, i.e. is needed to identify NMIs.  Clearing the available
registers bitmask after handling NMIs results in KVM querying info from
the last VM-Exit that read vmcs.VM_EXIT_INTR_INFO, and leads to both
missed NMIs and spurious NMIs from the guest's perspective.

Opportunistically grab vmcs.IDT_VECTORING_INFO_FIELD early in the VM-Exit
path too, e.g. to guard against similar consumption of stale data.  The
field is read on every "normal" VM-Exit, and there's no point in delaying
the inevitable.

Reported-by: Like Xu <like.xu.linux@gmail.com>
Fixes: 11df586d774f ("KVM: VMX: Handle NMI VM-Exits in noinstr region")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e6849f780dba..d2b78ab7a9f2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7222,13 +7222,20 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 				   flags);
 
 	vcpu->arch.cr2 = native_read_cr2();
+	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
+
+	vmx->idt_vectoring_info = 0;
 
 	vmx_enable_fb_clear(vmx);
 
-	if (unlikely(vmx->fail))
+	if (unlikely(vmx->fail)) {
 		vmx->exit_reason.full = 0xdead;
-	else
-		vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
+		goto out;
+	}
+
+	vmx->exit_reason.full = vmcs_read32(VM_EXIT_REASON);
+	if (likely(!vmx->exit_reason.failed_vmentry))
+		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
 	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
 	    is_nmi(vmx_get_intr_info(vcpu))) {
@@ -7237,6 +7244,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 		kvm_after_interrupt(vcpu);
 	}
 
+out:
 	guest_state_exit_irqoff();
 }
 
@@ -7358,8 +7366,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	loadsegment(es, __USER_DS);
 #endif
 
-	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
-
 	pt_guest_exit(vmx);
 
 	kvm_load_host_xsave_state(vcpu);
@@ -7376,17 +7382,12 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->nested.nested_run_pending = 0;
 	}
 
-	vmx->idt_vectoring_info = 0;
-
 	if (unlikely(vmx->fail))
 		return EXIT_FASTPATH_NONE;
 
 	if (unlikely((u16)vmx->exit_reason.basic == EXIT_REASON_MCE_DURING_VMENTRY))
 		kvm_machine_check();
 
-	if (likely(!vmx->exit_reason.failed_vmentry))
-		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
-
 	trace_kvm_exit(vcpu, KVM_ISA_VMX);
 
 	if (unlikely(vmx->exit_reason.failed_vmentry))

base-commit: fff2e47e6c3b8050ca26656693caa857e3a8b740
-- 

