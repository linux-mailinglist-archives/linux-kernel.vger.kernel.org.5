Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518777FB256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjK1HIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjK1HIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A11BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701155287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/uf+KIQMohmHryi8WcF8JWaeP3JqTeiI/tviURW9B+w=;
        b=AJWReCRAn/CPlAcbv3vzGHLhqSsHsCoTJIuxQlc0MHhsJrwOWp+scGWsVRYxAqiU5H6sEX
        7OFrQHSt/sAT8QVNausGP21idhoaBcpry9UUZ/Xi4H2qGyHR9TCPygqR8ipAjxGPl4bRuw
        LqUt3sPidE7ZuhLHWam49uyqpT51LrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-T3X9nVZjMPey44uORD9l0Q-1; Tue, 28 Nov 2023 02:08:06 -0500
X-MC-Unique: T3X9nVZjMPey44uORD9l0Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b42bd8de5so14805145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155285; x=1701760085;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uf+KIQMohmHryi8WcF8JWaeP3JqTeiI/tviURW9B+w=;
        b=sYVg755exNqi3CTCu85QJZF1IFso3d+IMKsS2Nh9w78bUjkvwfnwlKUpilx+MLbvFi
         6FwJCP9iBJrvYs+PN/j0UtGIPestaUGW02dUEHu2++Z05u//OD/VMJeJ6Kqv5EqeNoZs
         5iSGhY8NCkmHRVK7pjaJkP29CITiy2Qg931XMCPck9NZ+dngJ0ake2ouvjnibvdNHZ65
         gs5h+P9mEi1eZYOd9IADg9/+agKUAIqwUZ1QFvUn6a+pYLhezeIa7ZpB8iobANJpIgOV
         SIHkx54pD8woP4YtPgj4CM+sIFVbr8UV+HEqgwuSSLLOlLCfjdjv132joARdwmYcLN0f
         +C/Q==
X-Gm-Message-State: AOJu0YyWLX8YGT52/TG9HM5AOMnpD/LA8x58RaowmkFuzfRkpclRq1+X
        TOtWCnJDSztMJLAuSv20+7E/RcIg6ykiE67wEirbErhg4ZYBektMVbvWOhzzdKlXIm2xMfh96xJ
        cP33w6Ox3NaDElYrlo0lTT02l
X-Received: by 2002:a05:600c:3b04:b0:40b:27b4:b4eb with SMTP id m4-20020a05600c3b0400b0040b27b4b4ebmr14623267wms.4.1701155285238;
        Mon, 27 Nov 2023 23:08:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdTgN4bUXPWY0w6S1SgRuzTvhr9Yu+FQg1/w5ilASNGnnb07efbRWXhEtxSzfxO7OVVytjFw==
X-Received: by 2002:a05:600c:3b04:b0:40b:27b4:b4eb with SMTP id m4-20020a05600c3b0400b0040b27b4b4ebmr14623238wms.4.1701155284837;
        Mon, 27 Nov 2023 23:08:04 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b3829eb50sm14834788wmo.20.2023.11.27.23.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:08:04 -0800 (PST)
Message-ID: <f4495d1f697cf9a7ddfb786eaeeac90f554fc6db.camel@redhat.com>
Subject: Re: [RFC 05/33] KVM: x86: hyper-v: Introduce VTL call/return
 prologues in hypercall page
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:08:02 +0200
In-Reply-To: <20231108111806.92604-6-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-6-nsaenz@amazon.com>
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

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> VTL call/return hypercalls have their own entry points in the hypercall
> page because they don't follow normal hyper-v hypercall conventions.
> Move the VTL call/return control input into ECX/RAX and set the
> hypercall code into EAX/RCX before calling the hypercall instruction in
> order to be able to use the Hyper-V hypercall entry function.
> 
> Guests can read an emulated code page offsets register to know the
> offsets into the hypercall page for the VTL call/return entries.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> 
> ---
> 
> My tree has the additional patch, we're still trying to understand under
> what conditions Windows expects the offset to be fixed.
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 54f7f36a89bf..9f2ea8c34447 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -294,6 +294,7 @@ static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> 
>         /* VTL call/return entries */
>         if (!kvm_xen_hypercall_enabled(kvm) && kvm_hv_vsm_enabled(kvm)) {
> +               i = 22;
>  #ifdef CONFIG_X86_64
>                 if (is_64_bit_mode(vcpu)) {
>                         /*
> ---
>  arch/x86/include/asm/kvm_host.h   |  2 +
>  arch/x86/kvm/hyperv.c             | 78 ++++++++++++++++++++++++++++++-
>  include/asm-generic/hyperv-tlfs.h | 11 +++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a2f224f95404..00cd21b09f8c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1105,6 +1105,8 @@ struct kvm_hv {
>  	u64 hv_tsc_emulation_status;
>  	u64 hv_invtsc_control;
>  
> +	union hv_register_vsm_code_page_offsets vsm_code_page_offsets;
> +
>  	/* How many vCPUs have VP index != vCPU index */
>  	atomic_t num_mismatched_vp_indexes;
>  
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 78d053042667..d4b1b53ea63d 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -259,7 +259,8 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
>  static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	struct kvm *kvm = vcpu->kvm;
> -	u8 instructions[9];
> +	struct kvm_hv *hv = to_kvm_hv(kvm);
> +	u8 instructions[0x30];
>  	int i = 0;
>  	u64 addr;
>  
> @@ -285,6 +286,81 @@ static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
>  	/* ret */
>  	((unsigned char *)instructions)[i++] = 0xc3;
>  
> +	/* VTL call/return entries */
> +	if (!kvm_xen_hypercall_enabled(kvm) && kvm_hv_vsm_enabled(kvm)) {
> +#ifdef CONFIG_X86_64
> +		if (is_64_bit_mode(vcpu)) {
> +			/*
> +			 * VTL call 64-bit entry prologue:
> +			 * 	mov %rcx, %rax
> +			 * 	mov $0x11, %ecx
> +			 * 	jmp 0:

This isn't really 'jmp 0' as I first wondered but actually backward jump 32 bytes back (if I did the calculation correctly).
This is very dangerous because code that was before can change and in fact I don't think that this
offset is even correct now, and on top of that it depends on support for xen hypercalls as well.

This can be fixed by calculating the offset in runtime, however I am thinking:


Since userspace will have to be aware of the offsets in this page, and since
pretty much everything else is done in userspace, it might make sense to create
the hypercall page in the userspace.

In fact, the fact that KVM currently overwrites the guest page, is a violation of
the HV spec.

It's more correct regardless of VTL to do userspace vm exit and let the userspace put a memslot ("overlay")
over the address, and put whatever userspace wants there, including the above code.

Then we won't need the new ioctl as well.

To support this I think that we can add a userspace msr filter on the HV_X64_MSR_HYPERCALL,
although I am not 100% sure if a userspace msr filter overrides the in-kernel msr handling.

Best regards,
	Maxim Levitsky


> +			 */
> +			hv->vsm_code_page_offsets.vtl_call_offset = i;
> +			instructions[i++] = 0x48;
> +			instructions[i++] = 0x89;
> +			instructions[i++] = 0xc8;
> +			instructions[i++] = 0xb9;
> +			instructions[i++] = 0x11;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0xeb;
> +			instructions[i++] = 0xe0;
> +			/*
> +			 * VTL return 64-bit entry prologue:
> +			 * 	mov %rcx, %rax
> +			 * 	mov $0x12, %ecx
> +			 * 	jmp 0:
> +			 */
> +			hv->vsm_code_page_offsets.vtl_return_offset = i;
> +			instructions[i++] = 0x48;
> +			instructions[i++] = 0x89;
> +			instructions[i++] = 0xc8;
> +			instructions[i++] = 0xb9;
> +			instructions[i++] = 0x12;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0xeb;
> +			instructions[i++] = 0xd6;
> +		} else
> +#endif
> +		{
> +			/*
> +			 * VTL call 32-bit entry prologue:
> +			 * 	mov %eax, %ecx
> +			 * 	mov $0x11, %eax
> +			 * 	jmp 0:
> +			 */
> +			hv->vsm_code_page_offsets.vtl_call_offset = i;
> +			instructions[i++] = 0x89;
> +			instructions[i++] = 0xc1;
> +			instructions[i++] = 0xb8;
> +			instructions[i++] = 0x11;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0xeb;
> +			instructions[i++] = 0xf3;
> +			/*
> +			 * VTL return 32-bit entry prologue:
> +			 * 	mov %eax, %ecx
> +			 * 	mov $0x12, %eax
> +			 * 	jmp 0:
> +			 */
> +			hv->vsm_code_page_offsets.vtl_return_offset = i;
> +			instructions[i++] = 0x89;
> +			instructions[i++] = 0xc1;
> +			instructions[i++] = 0xb8;
> +			instructions[i++] = 0x12;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0x00;
> +			instructions[i++] = 0xeb;
> +			instructions[i++] = 0xea;
> +		}
> +	}
>  	addr = data & HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK;
>  	if (kvm_vcpu_write_guest(vcpu, addr, instructions, i))
>  		return 1;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index fdac4a1714ec..0e7643c1ef01 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -823,4 +823,15 @@ struct hv_mmio_write_input {
>  	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
>  } __packed;
>  
> +/*
> + * VTL call/return hypercall page offsets register
> + */
> +union hv_register_vsm_code_page_offsets {
> +	u64 as_u64;
> +	struct {
> +		u64 vtl_call_offset:12;
> +		u64 vtl_return_offset:12;
> +		u64 reserved:40;
> +	} __packed;
> +};
>  #endif





