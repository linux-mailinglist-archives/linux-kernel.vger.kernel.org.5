Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495FF7DF9B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346500AbjKBSPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjKBSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D2421D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698948041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TXakoAWW1FFOLF5UXdw93JMmC9MoRdLwbBdEicJ9T4=;
        b=b8tSO4DOpiAtp+BQHa2HQxD3sMHcEzp6G0PW+aiS1SbaAzJfItKvbpeOIoCuJNhPl4COfc
        geMiouJULondgjvcTIcLgz+MwtJhcZVP5Ttf0yCYK3Jk9nSpUz2VfN6+qOvBm1fgp7mFvV
        Pc5c3G1UACa/UwZY9miOC3prNio+y+0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-v8GvlphcPDuUty5qc59mzw-1; Thu, 02 Nov 2023 14:00:39 -0400
X-MC-Unique: v8GvlphcPDuUty5qc59mzw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f8c4e9b88so835472f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698948039; x=1699552839;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TXakoAWW1FFOLF5UXdw93JMmC9MoRdLwbBdEicJ9T4=;
        b=AIwPxa41KG8YhS28YTuJbuY5H/PCFxRZKgHTA5pi35EntHysD4ay4OyYeXq80VZ83P
         O3JPxdlgrK6lRfTL20mn/ANX20jlkCG+VjTJ7XZ+0bQeSTADg5dPHzUu/APor11soELM
         ZNAglLbeWDtOuvdH22fQ7zWg67/Ij+X5j+sxyAfVNGxEPi38uBeCq5k63r86QdE9tFnp
         bcNH1WXQxcLWGwRYzfDOH5fQp/imM2XJd6m2hYCCR4VL6MWp8VFLpx33dm+GWxVbuEGG
         xhUS+w1kNcPKsVPaINXCeIGarIT/O9GYFLrSimd4y6my68lA6qrqGXq+DtTJtuTUnDdF
         f8pA==
X-Gm-Message-State: AOJu0Yyi/nMLmlpjd1sRnbVlorqOH/ymPPWyxvD8akFe4gP9pNPsJwII
        KiA3cs8909zdKY+wlGmCL7uwRKVMhyIt+h2foOJi0+gSgrMbgrDuT/ZrYUGUI4yBrftdl5HUxoQ
        2IoYfsEUpmx/16B7J+PIbrIZs
X-Received: by 2002:adf:d1ca:0:b0:32f:89fb:771b with SMTP id b10-20020adfd1ca000000b0032f89fb771bmr298488wrd.4.1698948038782;
        Thu, 02 Nov 2023 11:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+PseGXhaGK5KA47SlyvvRQ+IpK7jimMGqL/PtZUrchAkuXB/NyC2l+qCdJkE8Bvk3Naoiw==
X-Received: by 2002:adf:d1ca:0:b0:32f:89fb:771b with SMTP id b10-20020adfd1ca000000b0032f89fb771bmr298468wrd.4.1698948038507;
        Thu, 02 Nov 2023 11:00:38 -0700 (PDT)
Received: from starship ([89.237.99.95])
        by smtp.gmail.com with ESMTPSA id l10-20020a1c790a000000b004063977eccesm3573161wme.42.2023.11.02.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 11:00:38 -0700 (PDT)
Message-ID: <65781f864b94db127a7a17e52835326a8a6a9ea0.camel@redhat.com>
Subject: Re: [PATCH 1/9] KVM: x86: SVM: Emulate reads and writes to shadow
 stack MSRs
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     John Allen <john.allen@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        weijiang.yang@intel.com, rick.p.edgecombe@intel.com,
        seanjc@google.com, x86@kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de
Date:   Thu, 02 Nov 2023 20:00:36 +0200
In-Reply-To: <20231010200220.897953-2-john.allen@amd.com>
References: <20231010200220.897953-1-john.allen@amd.com>
         <20231010200220.897953-2-john.allen@amd.com>
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
> Set up interception of shadow stack MSRs. In the event that shadow stack
> is unsupported on the host or the MSRs are otherwise inaccessible, the
> interception code will return an error. In certain circumstances such as
> host initiated MSR reads or writes, the interception code will get or
> set the requested MSR value.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f283eb47f6ac..6a0d225311bc 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2859,6 +2859,15 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (guest_cpuid_is_intel(vcpu))
>  			msr_info->data |= (u64)svm->sysenter_esp_hi << 32;
>  		break;
> +	case MSR_IA32_S_CET:
> +		msr_info->data = svm->vmcb->save.s_cet;
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		msr_info->data = svm->vmcb->save.isst_addr;
> +		break;
> +	case MSR_KVM_SSP:
> +		msr_info->data = svm->vmcb->save.ssp;
> +		break;
>  	case MSR_TSC_AUX:
>  		msr_info->data = svm->tsc_aux;
>  		break;
> @@ -3085,6 +3094,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		svm->vmcb01.ptr->save.sysenter_esp = (u32)data;
>  		svm->sysenter_esp_hi = guest_cpuid_is_intel(vcpu) ? (data >> 32) : 0;
>  		break;
> +	case MSR_IA32_S_CET:
> +		svm->vmcb->save.s_cet = data;
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		svm->vmcb->save.isst_addr = data;
> +		break;
> +	case MSR_KVM_SSP:
> +		svm->vmcb->save.ssp = data;
> +		break;
>  	case MSR_TSC_AUX:
>  		/*
>  		 * TSC_AUX is usually changed only during boot and never read

Looks good, except that if my complaint about turning the fake 'MSR_KVM_SSP' into
a first class register with an ioctl to load/save it is accepted, then
there will be a new vendor callback to read/write it instead of doing it in svm_get_msr/svm_set_msr.


Besides this,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

