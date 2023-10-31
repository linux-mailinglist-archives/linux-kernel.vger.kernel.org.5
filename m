Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26707DD5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376602AbjJaR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376591AbjJaR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3DC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzTCGiE36+QIYH5NJV9gBg/lfoaBooocnmbn0Tc7c6I=;
        b=hdbiYU/qErbS8QsFaJI6AImXlKKmpCh0hk955CYp0SIn6EwDwlZVTAPM0mmv+YYRQVCGuM
        1GdZfkRtWINCbjONS4Ptsh8t+hHz6D2WTLzs5t737/x6MiROdBy6sHFUJPVPYC1BppMG1R
        Yl73yNanGZSO5zfAE/MWLF2E7Z3n4hA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-ev6LIDHHNa-gNA4f8bUpXw-1; Tue, 31 Oct 2023 13:55:59 -0400
X-MC-Unique: ev6LIDHHNa-gNA4f8bUpXw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4094158c899so17559875e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774958; x=1699379758;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzTCGiE36+QIYH5NJV9gBg/lfoaBooocnmbn0Tc7c6I=;
        b=LUq7NEA2UCaKN/ZY4q8yXT+YXhj6qXNlDaUrzQbKn9cHjBvtWmFrtxEoyjTvkKrlxK
         emUlMTx7IOJGM2LPeF7mr9wd5RaBEoGSRC8MBjx8teEkKzeYaLCQCrM6QwkhAcryuaAV
         5XJYxXmBfYfNlQ0MSO6jPUTP8dW2SgsdQGAmIMDfDCxwYqxqyDjORRkeyKtOuBZaKag9
         5GV42yauxfEaTBvDzcIEMkzFRvmMMbdOQ5pGJsPGDSrWGX7GS7czFH5Y8xqAtCEzNDC1
         yC2/2/wZ21TCllm69x1PeXO8i9rL85jYjko/oN6K5/nsT6IzznzgdkrWXMJbLNcAippJ
         yRSw==
X-Gm-Message-State: AOJu0YwQ/2ELx9zsDhGjdoHGSylA6K0ofazxzhWPVMDzn3S5yF/s1vnj
        pRQxd3QkO/0zdY4PQUz3UgVXUdaNaJx6umaI1ovaNHWRb3p7f3kPhwclQmawdJgdIU2Vol5hEv+
        d/y47yEW+Hk5khxtsVrF/bvkg
X-Received: by 2002:a05:600c:470e:b0:409:19a0:d247 with SMTP id v14-20020a05600c470e00b0040919a0d247mr11666992wmo.18.1698774958359;
        Tue, 31 Oct 2023 10:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp1WzDeNxaBgIlpKTkzCkcRCuqvCI19VrLT39GGHUC2rUCfZW1Mm76+OIEXt8GPx4rbH/UDw==
X-Received: by 2002:a05:600c:470e:b0:409:19a0:d247 with SMTP id v14-20020a05600c470e00b0040919a0d247mr11666966wmo.18.1698774957905;
        Tue, 31 Oct 2023 10:55:57 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c30d300b003fefaf299b6sm2269842wmn.38.2023.10.31.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:55:57 -0700 (PDT)
Message-ID: <f654c9339f1c7d63093107410d2f81f5e4340d18.camel@redhat.com>
Subject: Re: [PATCH v6 20/25] KVM: x86: Save and reload SSP to/from SMRAM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:55:55 +0200
In-Reply-To: <20230914063325.85503-21-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-21-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-14 at 02:33 -0400, Yang Weijiang wrote:
> Save CET SSP to SMRAM on SMI and reload it on RSM. KVM emulates HW arch
> behavior when guest enters/leaves SMM mode,i.e., save registers to SMRAM
> at the entry of SMM and reload them at the exit to SMM. Per SDM, SSP is
> one of such registers on 64bit Arch, so add the support for SSP.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/kvm/smm.c | 8 ++++++++
>  arch/x86/kvm/smm.h | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index b42111a24cc2..235fca95f103 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -275,6 +275,10 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
>  	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
>  
>  	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
> +
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_read(vcpu, MSR_KVM_SSP, &smram->ssp),
> +			   vcpu->kvm);
>  }
>  #endif
>  
> @@ -565,6 +569,10 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
>  	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
>  	ctxt->interruptibility = (u8)smstate->int_shadow;
>  
> +	if (guest_can_use(vcpu, X86_FEATURE_SHSTK))
> +		KVM_BUG_ON(kvm_msr_write(vcpu, MSR_KVM_SSP, smstate->ssp),
> +			   vcpu->kvm);
> +
>  	return X86EMUL_CONTINUE;
>  }
>  #endif
> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> index a1cf2ac5bd78..1e2a3e18207f 100644
> --- a/arch/x86/kvm/smm.h
> +++ b/arch/x86/kvm/smm.h
> @@ -116,8 +116,8 @@ struct kvm_smram_state_64 {
>  	u32 smbase;
>  	u32 reserved4[5];
>  
> -	/* ssp and svm_* fields below are not implemented by KVM */
>  	u64 ssp;
> +	/* svm_* fields below are not implemented by KVM */
>  	u64 svm_guest_pat;
>  	u64 svm_host_efer;
>  	u64 svm_host_cr4;


Just one note: Due to historical reasons, KVM supports 2 formats of the SMM save area: 32 and 64 bit.
32 bit format more or less resembles the format that true 32 bit Intel and AMD CPUs used, 
while 64 bit format more or less resembles the format that 64 bit AMD cpus use (Intel uses a very different SMRAM layout)

32 bit format is used when X86_FEATURE_LM is not exposed to the guest CPUID which is very rare (only 32 bit qemu doesn't set it),
and it lacks several fields because it is no longer maintained.

Still, for the sake of completeness, it might make sense to fail enter_smm_save_state_32 (need to add return value and, do 'goto error' in
the main 'enter_smm' in this case, if CET is enabled.

I did a similar thing in SVM code 'svm_enter_smm' when it detects the lack of the X86_FEATURE_LM.

Best regards,
	Maxim Levitsky




