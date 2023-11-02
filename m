Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D37DF9AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjKBSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjKBSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB3D54
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lf4sz5zgZjW4weKtr+Yg6TBcTzSfkwSHJbmSokVskxk=;
        b=LrWyIXDrSrIcOgzWeHW7IqyaS+n2Zl2ZLDH5qzK1siW9/OUkvvzHMLK0yAOq5SfIjdtBPo
        jplbjqyLt1SOJyk4w6s3XIWf+/0SJDXoqSKa07BP0IlyXGDPEUJotm2rPYAx7PO0Z8Oacn
        YtpAlCC1TdE7DOWKyAdO8WBOs3tlJMM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-3cFiMcu0NtKRHyYHtdvWaw-1; Thu, 02 Nov 2023 14:11:02 -0400
X-MC-Unique: 3cFiMcu0NtKRHyYHtdvWaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4084e4ce543so7751655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948662; x=1699553462;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lf4sz5zgZjW4weKtr+Yg6TBcTzSfkwSHJbmSokVskxk=;
        b=FhUmcPR91+owTgocC9o4NmOjyTB2SuyGe3bbBr054dw98oHzLXJl3Tcwa2/rw7l5js
         E9aQOrSNl7rJX6KSMxNNET/mzvsSMJrqtk+8URd2oC707rJ9WE5AI6Snbcad1k6e7Fp5
         2RVYPtsAUJK7TVW0fZiBPkGeAmIhqzRxq+7nhUSHC6YPru0OMY2KHzTBNiog9ndSlyS3
         ezf/xfty0Ww9wYYcjLStewb5ZWSNlS61iC1zOd+pvkfDnfXyq+0GW4W6DAc2yu2FZ3Bt
         n+7MthouBX+TEoE9Y3lVdKissgITsOBy73hriNrvU07KLrv7tmc8WJ9Igjvr8bhb+zyO
         9vGA==
X-Gm-Message-State: AOJu0Yyrzcm2TqaehkphFsYqLBt1cPUuDr40mZAxK+wtjssUU/XzsZ64
        RtX8eRhdC5+4Wpn4V97zA4lZzkJScCWPAcA/O7hYMAYsyJLwsy4etcIjHcCxp3WzAGMxklGxqqh
        1RWhff7SHZxKFYrgh4sD9wWRs
X-Received: by 2002:a5d:68c1:0:b0:32d:a022:8559 with SMTP id p1-20020a5d68c1000000b0032da0228559mr15550166wrw.47.1698948661352;
        Thu, 02 Nov 2023 11:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSqw020mjK/6PHY7CTNXu4NxTqG4uDaXHOXROR0+xwiATkC32fBes5AQyH3J5aI9Lka800LA==
X-Received: by 2002:a5d:68c1:0:b0:32d:a022:8559 with SMTP id p1-20020a5d68c1000000b0032da0228559mr15550151wrw.47.1698948660999;
        Thu, 02 Nov 2023 11:11:00 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id k15-20020a056000004f00b00323287186aasm3028866wrx.32.2023.11.02.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:11:00 -0700 (PDT)
Message-ID: <5e413e05de559971cdc2d1a9281a8a271590f62b.camel@redhat.com>
Subject: Re: [PATCH 6/9] KVM: SVM: Add MSR_IA32_XSS to the GHCB for
 hypervisor kernel
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:10:58 +0200
In-Reply-To: <20231010200220.897953-7-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-7-john.allen@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 20:02 +0000, John Allen wrote:
> When a guest issues a cpuid instruction for Fn0000000D_x0B
> (CetUserOffset), KVM will intercept and need to access the guest
> MSR_IA32_XSS value. For SEV-ES, this is encrypted and needs to be
> included in the GHCB to be visible to the hypervisor.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/include/asm/svm.h |  1 +
>  arch/x86/kvm/svm/sev.c     | 12 ++++++++++--
>  arch/x86/kvm/svm/svm.c     |  1 +
>  arch/x86/kvm/svm/svm.h     |  3 ++-
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 568d97084e44..5afc9e03379d 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -678,5 +678,6 @@ DEFINE_GHCB_ACCESSORS(sw_exit_info_1)
>  DEFINE_GHCB_ACCESSORS(sw_exit_info_2)
>  DEFINE_GHCB_ACCESSORS(sw_scratch)
>  DEFINE_GHCB_ACCESSORS(xcr0)
> +DEFINE_GHCB_ACCESSORS(xss)

I don't see anywhere in the patch adding xss to ghcb_save_area.
What kernel version/commit these patches are based on?

>  
>  #endif
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index bb4b18baa6f7..94ab7203525f 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2445,8 +2445,13 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
>  
>  	svm->vmcb->save.cpl = kvm_ghcb_get_cpl_if_valid(svm, ghcb);
>  
> -	if (kvm_ghcb_xcr0_is_valid(svm)) {
> -		vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
> +	if (kvm_ghcb_xcr0_is_valid(svm) || kvm_ghcb_xss_is_valid(svm)) {
> +		if (kvm_ghcb_xcr0_is_valid(svm))
> +			vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
> +
> +		if (kvm_ghcb_xss_is_valid(svm))
> +			vcpu->arch.ia32_xss = ghcb_get_xss(ghcb);
> +
>  		kvm_update_cpuid_runtime(vcpu);
>  	}
>  
> @@ -3032,6 +3037,9 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm)
>  		if (guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDTSCP))
>  			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
>  	}
> +
> +	if (kvm_caps.supported_xss)
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_XSS, 1, 1);

This is not just a virtualization hole. This allows the guest to set MSR_IA32_XSS
to whatever value it wants, and thus it might allow XSAVES to access some host msrs
that guest must not be able to access.

AMD might not yet have such msrs, but on Intel side I do see various components
like 'HDC State', 'HWP state' and such.

I understand that this is needed so that #VC handler could read this msr, and trying
to read it will cause another #VC which is probably not allowed (I don't know this detail of SEV-ES)

I guess #VC handler should instead use a kernel cached value of this msr instead, or at least
KVM should only allow reads and not writes to it.

In addition to that, if we decide to open the read access to the IA32_XSS from the guest,
this IMHO should be done in a separate patch.

Best regards,
	Maxim Levitsky


>  }
>  
>  void sev_init_vmcb(struct vcpu_svm *svm)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 984e89d7a734..ee7c7d0a09ab 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -146,6 +146,7 @@ static const struct svm_direct_access_msrs {
>  	{ .index = MSR_IA32_PL1_SSP,                    .always = false },
>  	{ .index = MSR_IA32_PL2_SSP,                    .always = false },
>  	{ .index = MSR_IA32_PL3_SSP,                    .always = false },
> +	{ .index = MSR_IA32_XSS,                        .always = false },
>  	{ .index = MSR_INVALID,				.always = false },
>  };
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index bdc39003b955..2011456d2e9f 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -30,7 +30,7 @@
>  #define	IOPM_SIZE PAGE_SIZE * 3
>  #define	MSRPM_SIZE PAGE_SIZE * 2
>  
> -#define MAX_DIRECT_ACCESS_MSRS	53
> +#define MAX_DIRECT_ACCESS_MSRS	54
>  #define MSRPM_OFFSETS	32
>  extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
>  extern bool npt_enabled;
> @@ -720,5 +720,6 @@ DEFINE_KVM_GHCB_ACCESSORS(sw_exit_info_1)
>  DEFINE_KVM_GHCB_ACCESSORS(sw_exit_info_2)
>  DEFINE_KVM_GHCB_ACCESSORS(sw_scratch)
>  DEFINE_KVM_GHCB_ACCESSORS(xcr0)
> +DEFINE_KVM_GHCB_ACCESSORS(xss)
>  
>  #endif




