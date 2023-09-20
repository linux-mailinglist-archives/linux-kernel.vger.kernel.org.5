Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D119E7A8AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjITRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjITRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1215ACF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695232507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnqOeIozWLoSx9J0xtQeCKdqhemo3EjzKycC15MNaXI=;
        b=SzKDMcCNnBBP6byCzE2SirR83Sn6/tTo6qEk0byuZHezX5Sv9AN+4nKmL/sIZDvJlgdGJs
        H0R64p7wYptixyOx9rgL4GzGBr/H07NpCQevtkJkLNHgUrQLD3SSUjkRfFRpBFg0Yxwase
        dwKc2S6KA2/NgZZcnSbD5ZBbirOKUww=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-n8Hv9srlNnC_zxzHJ6YXdw-1; Wed, 20 Sep 2023 13:55:05 -0400
X-MC-Unique: n8Hv9srlNnC_zxzHJ6YXdw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-320004980a2so63234f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232504; x=1695837304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnqOeIozWLoSx9J0xtQeCKdqhemo3EjzKycC15MNaXI=;
        b=lirQsRZxFcAVbygvATNMl2CPuUSoWGV01cTNPiORrHdHVWU3joAXVFYlFIepBC30Ea
         J3MV08yZCPjq9xqkInj7Id5ZOGH5jujUfl13RVHcxrhjcW2OWLiR7b575vYO+20CWhdl
         P7VprGfGanlnb+Ph8ej1N6d1CXwqLPCZPE2y+eB4BGKcFrios8sSvPO0geHTX7ASQ7dQ
         p3qMpZTOyjG0B/VIhbK2iliq4s4oUzVD9t5fyLsn/g3jlm4jJ8HoQZ6lO6fIfFN3P78d
         abROylD9OmB83dWw4Wo/T7EJwJqp9mxMB7y2zjIk211ysiPu+C4PEPmO2+vHg7pKXWZU
         gIwA==
X-Gm-Message-State: AOJu0YwmhR9IlGQQdZTl8J5q3DYqcOt0cdyJWzVPHOu1QuQ/6xi6KVCk
        /dmYL42gn7XC6oj1SaW9x5QA80P/L/wN3ua3cUhVdUm5xjeHRBFggvEPmmnjP0Cke6QJO7RfxiA
        0F/J6oWypdUvNUEPV9ae2VwW+
X-Received: by 2002:adf:ee88:0:b0:313:ecd3:7167 with SMTP id b8-20020adfee88000000b00313ecd37167mr2737757wro.42.1695232504611;
        Wed, 20 Sep 2023 10:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0pIzmkmEwrfJkDIWYrHXNUyhISLDh7IqFEh0BjNiUe37zgzv0CZuijHzQCZR9e7yYqC6CoA==
X-Received: by 2002:adf:ee88:0:b0:313:ecd3:7167 with SMTP id b8-20020adfee88000000b00313ecd37167mr2737745wro.42.1695232504286;
        Wed, 20 Sep 2023 10:55:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id w11-20020a5d608b000000b0031ad5fb5a0fsm10876963wrt.58.2023.09.20.10.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:55:03 -0700 (PDT)
Message-ID: <26b92bbb-0519-8b94-07fc-75d900fde600@redhat.com>
Date:   Wed, 20 Sep 2023 19:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 34/38] KVM: VMX: Call fred_entry_from_kvm() for
 IRQ/NMI handling
Content-Language: en-US
To:     Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, seanjc@google.com, peterz@infradead.org,
        jgross@suse.com, ravi.v.shankar@intel.com, mhiramat@kernel.org,
        andrew.cooper3@citrix.com, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-35-xin3.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230914044805.301390-35-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 06:48, Xin Li wrote:
> When FRED is enabled, call fred_entry_from_kvm() to handle IRQ/NMI in
> IRQ/NMI induced VM exits.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>   arch/x86/kvm/vmx/vmx.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 72e3943f3693..db55b8418fa3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -38,6 +38,7 @@
>   #include <asm/desc.h>
>   #include <asm/fpu/api.h>
>   #include <asm/fpu/xstate.h>
> +#include <asm/fred.h>
>   #include <asm/idtentry.h>
>   #include <asm/io.h>
>   #include <asm/irq_remapping.h>
> @@ -6962,14 +6963,16 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
>   {
>   	u32 intr_info = vmx_get_intr_info(vcpu);
>   	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
> -	gate_desc *desc = (gate_desc *)host_idt_base + vector;
>   
>   	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
>   	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
>   		return;
>   
>   	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
> -	vmx_do_interrupt_irqoff(gate_offset(desc));
> +	if (cpu_feature_enabled(X86_FEATURE_FRED))
> +		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
> +	else
> +		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
>   	kvm_after_interrupt(vcpu);
>   
>   	vcpu->arch.at_instruction_boundary = true;
> @@ -7262,7 +7265,10 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>   	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
>   	    is_nmi(vmx_get_intr_info(vcpu))) {
>   		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
> -		vmx_do_nmi_irqoff();
> +		if (cpu_feature_enabled(X86_FEATURE_FRED))
> +			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
> +		else
> +			vmx_do_nmi_irqoff();
>   		kvm_after_interrupt(vcpu);
>   	}
>   

