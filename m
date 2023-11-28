Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B157FB23E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjK1HBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1HBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8C1AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701154908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFm09BdRgr9hMTLD1yLTzer1bL4YuNmrnI5hvmqZVZ4=;
        b=TaYW9onre+X4u+pU5istavdZSFc0Lx+VQQgLB8ddfTuiXzJltFNIDsQw5Xc1DHvL/7Ph8T
        UFshCl2dWN/WUvSUCVCVz3R2CtiE8vlgm8Y9ZMBLX9tDdUd9izEgZfQ9wTfvEF5xA9B668
        Q9/smGaj3IDYACVqcXTtisgQlBc4+q8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-hteZO2bRPYGgsdfOreHL5w-1; Tue, 28 Nov 2023 02:01:46 -0500
X-MC-Unique: hteZO2bRPYGgsdfOreHL5w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b3487fa9eso35488065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701154905; x=1701759705;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFm09BdRgr9hMTLD1yLTzer1bL4YuNmrnI5hvmqZVZ4=;
        b=hkG5pMVPkfftR+TiO0toGpozn1NNqGQdSMywKdLB/ykpGXfCjrPtHk95/f71PIfGVN
         JKD/ORVMZTSvV5dnyGQatoJkTSZUABdw3mEt7KB5K10Kr23jPd/nwJuPzmFmXKlyM5lM
         qcQimZVw/PUuHpWGTXi0oZouynh2gFymswqhSmjAEQtCu9T9N4feMy54X5aWnPD/N1fC
         7lP3bC2j2sVL74wbMT7+2LpYUjXh6N0Cb9oQ3RA0RJ7ZrHdV19JJj7BBgXlShp+Wqn/i
         ZZq2xGMMBdxS94/JK5VIRJQWqK0taTUFB5idoVSZ21q7fat0iMbeVi2TUyBg5RPtmCPx
         9+lQ==
X-Gm-Message-State: AOJu0YzNH9Et3g010Gaggk1gSKHKEPiEVo7bJy91ItQToA99d5BElp7b
        89095PNq7/RNyhVuf7w9+cFyAO7Z44sEwFiGmvAVIInNzw5M153trBotUy1mRhkwFCwxnPMHAHf
        C/+VJtpjpX7oQGb2LYQzwnkHB
X-Received: by 2002:a5d:5551:0:b0:332:eaa7:56b1 with SMTP id g17-20020a5d5551000000b00332eaa756b1mr10473120wrw.37.1701154905454;
        Mon, 27 Nov 2023 23:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJh6KHVnFuAmI4DNL88OhLS0ibEFFHYEoJGgdx0+cxUbi599XVe0FHmIVi7s/oyOMg/Kx2rQ==
X-Received: by 2002:a5d:5551:0:b0:332:eaa7:56b1 with SMTP id g17-20020a5d5551000000b00332eaa756b1mr10473106wrw.37.1701154905161;
        Mon, 27 Nov 2023 23:01:45 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b00332fbc183ebsm6535150wrt.76.2023.11.27.23.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:01:44 -0800 (PST)
Message-ID: <04a6495330967c74cb6e6e122a634992bb3efa0e.camel@redhat.com>
Subject: Re: [RFC 04/33] KVM: x86: hyper-v: Move hypercall page handling
 into separate function
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
        jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org,
        linux-doc@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:01:42 +0200
In-Reply-To: <20231108111806.92604-5-nsaenz@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
         <20231108111806.92604-5-nsaenz@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 11:17 +0000, Nicolas Saenz Julienne wrote:
> The hypercall page patching is about to grow considerably, move it into
> its own function.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---
>  arch/x86/kvm/hyperv.c | 69 ++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index e1bc861ab3b0..78d053042667 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -256,6 +256,42 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
>  	kvm_make_request(KVM_REQ_HV_EXIT, vcpu);
>  }
>  
> +static int patch_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u8 instructions[9];
> +	int i = 0;
> +	u64 addr;
> +
> +	/*
> +	 * If Xen and Hyper-V hypercalls are both enabled, disambiguate
> +	 * the same way Xen itself does, by setting the bit 31 of EAX
> +	 * which is RsvdZ in the 32-bit Hyper-V hypercall ABI and just
> +	 * going to be clobbered on 64-bit.
> +	 */
> +	if (kvm_xen_hypercall_enabled(kvm)) {
> +		/* orl $0x80000000, %eax */
> +		instructions[i++] = 0x0d;
> +		instructions[i++] = 0x00;
> +		instructions[i++] = 0x00;
> +		instructions[i++] = 0x00;
> +		instructions[i++] = 0x80;
> +	}
> +
> +	/* vmcall/vmmcall */
> +	static_call(kvm_x86_patch_hypercall)(vcpu, instructions + i);
> +	i += 3;
> +
> +	/* ret */
> +	((unsigned char *)instructions)[i++] = 0xc3;
> +
> +	addr = data & HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK;
> +	if (kvm_vcpu_write_guest(vcpu, addr, instructions, i))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
>  			 u32 msr, u64 data, bool host)
>  {
> @@ -1338,11 +1374,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
>  		if (!hv->hv_guest_os_id)
>  			hv->hv_hypercall &= ~HV_X64_MSR_HYPERCALL_ENABLE;
>  		break;
> -	case HV_X64_MSR_HYPERCALL: {
> -		u8 instructions[9];
> -		int i = 0;
> -		u64 addr;
> -
> +	case HV_X64_MSR_HYPERCALL:
>  		/* if guest os id is not set hypercall should remain disabled */
>  		if (!hv->hv_guest_os_id)
>  			break;
> @@ -1351,34 +1383,11 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
>  			break;
>  		}
>  
> -		/*
> -		 * If Xen and Hyper-V hypercalls are both enabled, disambiguate
> -		 * the same way Xen itself does, by setting the bit 31 of EAX
> -		 * which is RsvdZ in the 32-bit Hyper-V hypercall ABI and just
> -		 * going to be clobbered on 64-bit.
> -		 */
> -		if (kvm_xen_hypercall_enabled(kvm)) {
> -			/* orl $0x80000000, %eax */
> -			instructions[i++] = 0x0d;
> -			instructions[i++] = 0x00;
> -			instructions[i++] = 0x00;
> -			instructions[i++] = 0x00;
> -			instructions[i++] = 0x80;
> -		}
> -
> -		/* vmcall/vmmcall */
> -		static_call(kvm_x86_patch_hypercall)(vcpu, instructions + i);
> -		i += 3;
> -
> -		/* ret */
> -		((unsigned char *)instructions)[i++] = 0xc3;
> -
> -		addr = data & HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK;
> -		if (kvm_vcpu_write_guest(vcpu, addr, instructions, i))
> +		if (patch_hypercall_page(vcpu, data))
>  			return 1;
> +
>  		hv->hv_hypercall = data;
>  		break;
> -	}
>  	case HV_X64_MSR_REFERENCE_TSC:
>  		hv->hv_tsc_page = data;
>  		if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE) {


This looks like another nice cleanup that can be accepted to the kvm,
before the main VTL patch series.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




