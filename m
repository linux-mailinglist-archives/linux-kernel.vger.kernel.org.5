Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1834D7FFC57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbjK3URC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjK3UQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98B2D57
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701375363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnILF2v/UzJSC3TfPsanWxRS5vhVZJoM93lB9ErtfnU=;
        b=jNK6pWA7F8EghW3TwtxzabkUmQtdrcs/IVsQJkA4+BTyga51+Pe+Nfg2FBXrkBOppiHTnz
        8kBBeIme3L5bJKozfZmD5JNtyXt3n9DeidnBePnav8xqHoe6db7TU3iBWfkIBYc37RLM4Y
        8K4ZszjmhUYU/YmLjffRcn1Vms3zRyk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-l1djZCfdOH-trY0rHWz7AA-1; Thu, 30 Nov 2023 15:16:01 -0500
X-MC-Unique: l1djZCfdOH-trY0rHWz7AA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9d7f6b8a5so858731fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375360; x=1701980160;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnILF2v/UzJSC3TfPsanWxRS5vhVZJoM93lB9ErtfnU=;
        b=l0c/gg+chiwTmBE58mqJ0kPPMDqc+M98W3pPPekDSn9ivjdrI/meBmD4HfQ+21JSss
         eQUy6XBt7iau0shCtixvOrf8Gd8LedGEb0OBeACOpa25rSSnkyZYkVTJ+O9x+ZkLtTGY
         nfjzAUfL8JG+JS1FDDAxdJeQooYzCjrs4fs9gYb+4udQ5XXbugO1Jp0+9o1xmFeoDYzm
         2ghi1XXW69CPK2gvJ6/UrXkmGtkDpAObIwGR6xjs6pZgdJi81MSjcIvB/enf8CHzh1TQ
         3PAhgnL6vfDulPb5WlTotfcMC512T3a/a9SsObZM0nX6n3nD+ZmiXmb8X9wYHGZH8cOJ
         XK9Q==
X-Gm-Message-State: AOJu0YxHHxwrbOt2vtz+hmRgZU6w+vs53312SfEveQy6JU+ovEneZKgA
        /SqAoU8CuI4fLiuf8xMi/0Sd5zUDStKnGAPhkvJpgb8foYozA9yZz+6WDuBSD96AlmZeUOhbIxq
        P9/aFDSm0Bj2L5S/zDBhibHAmT0XLmlQd
X-Received: by 2002:a17:906:7fc1:b0:a19:a1ba:bac9 with SMTP id r1-20020a1709067fc100b00a19a1babac9mr9464ejs.111.1701367396678;
        Thu, 30 Nov 2023 10:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4k847W+sNMTAQ1rVITqOi2a2slCKD3b7VwuEiUy32DuKveRfuk3Ji+UhnvOR79GVGLtzAg==
X-Received: by 2002:a17:906:5306:b0:a19:34e1:990a with SMTP id h6-20020a170906530600b00a1934e1990amr123778ejo.22.1701365832293;
        Thu, 30 Nov 2023 09:37:12 -0800 (PST)
Received: from starship ([5.28.147.32])
        by smtp.gmail.com with ESMTPSA id e17-20020ac25471000000b00500b19152cbsm212362lfn.8.2023.11.30.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:37:11 -0800 (PST)
Message-ID: <b59246b1ab68941eb62984bc220f071a9e8e58f7.camel@redhat.com>
Subject: Re: [PATCH v7 11/26] KVM: x86: Add kvm_msr_{read,write}() helpers
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, dave.hansen@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Thu, 30 Nov 2023 19:37:09 +0200
In-Reply-To: <20231124055330.138870-12-weijiang.yang@intel.com>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
         <20231124055330.138870-12-weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-24 at 00:53 -0500, Yang Weijiang wrote:
> Wrap __kvm_{get,set}_msr() into two new helpers for KVM usage and use the
> helpers to replace existing usage of the raw functions.
> kvm_msr_{read,write}() are KVM-internal helpers, i.e. used when KVM needs
> to get/set a MSR value for emulating CPU behavior, i.e., host_initiated ==
> %true in the helpers.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/kvm/cpuid.c            |  2 +-
>  arch/x86/kvm/x86.c              | 16 +++++++++++++---
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5cfa18aaf33f..499bd42e3a32 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1966,9 +1966,10 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
>  
>  void kvm_enable_efer_bits(u64);
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> -int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data, bool host_initiated);
>  int kvm_emulate_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
>  int kvm_emulate_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
> +int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> +int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
>  int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
>  int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu);
>  int kvm_emulate_as_nop(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index d0315e469d92..0351e311168a 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1527,7 +1527,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>  		*edx = entry->edx;
>  		if (function == 7 && index == 0) {
>  			u64 data;
> -		        if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
> +		        if (!kvm_msr_read(vcpu, MSR_IA32_TSX_CTRL, &data) &&
>  			    (data & TSX_CTRL_CPUID_CLEAR))
>  				*ebx &= ~(F(RTM) | F(HLE));
>  		} else if (function == 0x80000007) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 16b4f2dd138a..360f4b8a4944 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1917,8 +1917,8 @@ static int kvm_set_msr_ignored_check(struct kvm_vcpu *vcpu,
>   * Returns 0 on success, non-0 otherwise.
>   * Assumes vcpu_load() was already called.
>   */
> -int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
> -		  bool host_initiated)
> +static int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
> +			 bool host_initiated)
>  {
>  	struct msr_data msr;
>  	int ret;
> @@ -1944,6 +1944,16 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>  	return ret;
>  }
>  
> +int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data)
> +{
> +	return __kvm_set_msr(vcpu, index, data, true);
> +}
> +
> +int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data)
> +{
> +	return __kvm_get_msr(vcpu, index, data, true);
> +}
> +
>  static int kvm_get_msr_ignored_check(struct kvm_vcpu *vcpu,
>  				     u32 index, u64 *data, bool host_initiated)
>  {
> @@ -12224,7 +12234,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  						  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL;
>  
>  		__kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
> -		__kvm_set_msr(vcpu, MSR_IA32_XSS, 0, true);
> +		kvm_msr_write(vcpu, MSR_IA32_XSS, 0);
>  	}
>  
>  	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

