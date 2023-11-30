Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676027FE602
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjK3BbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:31:05 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C1510C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:31:11 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2859ab31b31so495898a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701307871; x=1701912671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gg2L5gsFD+9s4hl0pMtih+KIpxYTNwuOj5uhIeuR3S4=;
        b=Iago0Nwuy1Oi2ymS5V4ElfPdJgaeDgb7+Qc8dywtnj1izLtsOLE8Jgsh9uAxnPVwK7
         tWJlDTmBiFrapzhy88JhVdf1JwOji5AqLDxShOPHXIKv9QQlKYH+ZLdqB3N8vgdk5nQ1
         jRhphMoMCtmTuXzV67dofIHHwQ0HJGc3+JVbLcuJ+5XF/Rvd1oepn8Qg9DA8YjfFlrG1
         7eR3PinPzVh5JHbtJbQ90xBYCCLbTSeO6TZP3T/cZNoQ68/yVu8Vbpn4GoAWZ/5Oqz7F
         5XhdrYKH3NTdhbLGXxxfXRCPzfElleou48jA7g50M23igrf24W8FWemJYYZoVZd3H+y7
         WITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701307871; x=1701912671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg2L5gsFD+9s4hl0pMtih+KIpxYTNwuOj5uhIeuR3S4=;
        b=j9kqI4naTromtjb1gTo01T1q6aaJdKW4t8zNO829lREwg9jLxMDyBUWucrWV6ytmrh
         AiyvUoSBISI8IbP8KRElvQMUVQUGl1zG8R7M5B45EDAeW9lYHTQI97D25IyaHNFMsCV5
         7eLoiQzEX+9j3lqsefGMIshBzjFLlR5BsGCTPUO5l3iBPFhHmxaXb5qK8ZjqiWuJmddm
         N5YKL7UfhBQizaMYan3nUGN3jh6stZ+Ayop18c40e1HXZqN2vBqTWnRMTuSjPHxsFKoC
         CVhko3HlF8gARaVtYoGh6IVSVhjG1wN3E7D8XRGX95bxmIa54HZ6xotPwU/7uNd/W72U
         kMSQ==
X-Gm-Message-State: AOJu0YwG4EYc+KCXZHVg1h6C8mDrmyvXPfUIbvTcnuwNa4sggmuE/qh7
        VgGZNC3LhSpOtNw/5zg6P7f5gETOxcY=
X-Google-Smtp-Source: AGHT+IEf54xAukPivH5tpowu00jPP0sWnfu+6RzFTXBIHH8UCfgEVawhe+PWswUWILRcgmfQ8Blksp9Mn7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a40a:b0:26d:2b05:4926 with SMTP id
 y10-20020a17090aa40a00b0026d2b054926mr4165886pjp.1.1701307871009; Wed, 29 Nov
 2023 17:31:11 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:31:09 -0800
In-Reply-To: <20231025152406.1879274-11-vkuznets@redhat.com>
Mime-Version: 1.0
References: <20231025152406.1879274-1-vkuznets@redhat.com> <20231025152406.1879274-11-vkuznets@redhat.com>
Message-ID: <ZWfl3ahamXPPoIGB@google.com>
Subject: Re: [PATCH 10/14] KVM: x86: Make Hyper-V emulation optional
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023, Vitaly Kuznetsov wrote:
> Hyper-V emulation in KVM is a fairly big chunk and in some cases it may be
> desirable to not compile it in to reduce module sizes as well as the attack
> surface. Introduce CONFIG_KVM_HYPERV option to make it possible.
> 
> Note, there's room for further nVMX/nSVM code optimizations when
> !CONFIG_KVM_HYPERV, this will be done in follow-up patches.
> 
> Reorganize Makefile a bit so all CONFIG_HYPERV and CONFIG_KVM_HYPERV files
> are grouped together.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

...

> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index 8ea872401cd6..b97b875ad75f 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -11,32 +11,33 @@ include $(srctree)/virt/kvm/Makefile.kvm
>  
>  kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
>  			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
> -			   hyperv.o debugfs.o mmu/mmu.o mmu/page_track.o \
> +			   debugfs.o mmu/mmu.o mmu/page_track.o \
>  			   mmu/spte.o
>  
> -ifdef CONFIG_HYPERV
> -kvm-y			+= kvm_onhyperv.o
> -endif
> -
>  kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
> +kvm-$(CONFIG_KVM_HYPERV) += hyperv.o
>  kvm-$(CONFIG_KVM_XEN)	+= xen.o
>  kvm-$(CONFIG_KVM_SMM)	+= smm.o
>  
>  kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
> -			   vmx/hyperv.o vmx/hyperv_evmcs.o vmx/nested.o vmx/posted_intr.o
> -kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
> +			   vmx/nested.o vmx/posted_intr.o
>  
> -ifdef CONFIG_HYPERV
> -kvm-intel-y		+= vmx/vmx_onhyperv.o
> -endif
> +kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
>  
>  kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
> -			   svm/sev.o svm/hyperv.o
> +			   svm/sev.o
>  
>  ifdef CONFIG_HYPERV
> +kvm-y			+= kvm_onhyperv.o
> +kvm-intel-y		+= vmx/vmx_onhyperv.o vmx/hyperv_evmcs.o
>  kvm-amd-y		+= svm/svm_onhyperv.o
>  endif
>  
> +ifdef CONFIG_KVM_HYPERV
> +kvm-intel-y		+= vmx/hyperv.o vmx/hyperv_evmcs.o
> +kvm-amd-y		+= svm/hyperv.o
> +endif

My strong preference is to avoid the unnecessary ifdef and instead do:

kvm-intel-y             += vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
                           vmx/nested.o vmx/posted_intr.o

kvm-intel-$(CONFIG_X86_SGX_KVM) += vmx/sgx.o
kvm-intel-$(CONFIG_KVM_HYPERV)  += vmx/hyperv.o vmx/hyperv_evmcs.o

kvm-amd-y               += svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o \
                           svm/sev.o
kvm-amd-$(CONFIG_KVM_HYPERV)    += svm/hyperv.o


CONFIG_HYPERV needs an ifdef because it can be 'y' or 'm', but otherwise ifdefs
just tend to be noisier.

>  static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>  {
> @@ -3552,11 +3563,13 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
>  
> +#ifdef CONFIG_KVM_HYPERV
>  	evmptrld_status = nested_vmx_handle_enlightened_vmptrld(vcpu, launch);
>  	if (evmptrld_status == EVMPTRLD_ERROR) {
>  		kvm_queue_exception(vcpu, UD_VECTOR);
>  		return 1;
>  	}
> +#endif
>  
>  	kvm_pmu_trigger_event(vcpu, PERF_COUNT_HW_BRANCH_INSTRUCTIONS);

This fails to build with CONFIG_KVM_HYPERV=n && CONFIG_KVM_WERROR=y:

arch/x86/kvm/vmx/nested.c:3577:9: error: variable 'evmptrld_status' is uninitialized when used here [-Werror,-Wuninitialized]
        if (CC(evmptrld_status == EVMPTRLD_VMFAIL))
               ^~~~~~~~~~~~~~~

Sadly, simply wrapping with an #ifdef also fails because then evmptrld_status
becomes unused.  I'd really prefer to avoid having to tag it __maybe_unused, and
adding more #ifdef would also be ugly.  Any ideas?
