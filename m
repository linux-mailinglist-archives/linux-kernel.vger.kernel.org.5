Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092667DD52D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376444AbjJaRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376427AbjJaRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5202792
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8gN1E0qkL8gM8KwD/+d6NxFSXLY+pIiGeicsPrALt8=;
        b=J3oEgKj2BthzPTKbgfru6vCGZoaAH7IE6qj1JP3jnnha6R43qGOeid6j3lw0WIy7d6C9ZB
        00f/rvrhmnmJpaWwoLfgQ9tfDc4qWmc0wO9cIThMKxetD0XUHjOz1a/W7mSqZebf2TedCx
        ezrWowknbq9UVmfdJdS4L8BjkoM1cTo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-39EliakqPOmzsrubIa3lHw-1; Tue, 31 Oct 2023 13:47:05 -0400
X-MC-Unique: 39EliakqPOmzsrubIa3lHw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f790a39d2so1623076f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774424; x=1699379224;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8gN1E0qkL8gM8KwD/+d6NxFSXLY+pIiGeicsPrALt8=;
        b=XD2pwixDeZxuau9VCxCP3cR1fp2OyiHzP9jlAw1TuxunQw/qqkPGlJmp89nhkrfw4k
         ayC9TLpRoNNlwGcemTNhh+Wk0TewTUhC4Lr6++4eFRMAbmefLV5AFRjAEXAa5+5LkZww
         0yPCBOMtMkrTkd5QqUt9xnYJJXOaXIaVJ49NGbMCdpTQOAakET4yA9I3MFVwtoDmKsBh
         GJo6PMgmAiBYjMLERSRcIzo25sBscPvRaE0WojqpYy1ryJ+NW1l8vjdG7mOd6TMK4Omq
         JQfP9pThkfxs3JRz36X33Gz9eS2LTpRNbdC/3iHf6CaUHIPPw76cDbc/U6bLxSOCG6Xm
         oPcA==
X-Gm-Message-State: AOJu0YzIIvHHK/z2kIPmhqWTGZ+WNRD01JD8tVb9uvdEotBgaGDdb4m1
        YHnGi/3pr7mW5hIbW/wM/xTmV15gSxmf5yYuugwfvm0v+RoLYmNyZs89AQetE5rYAcSzwsDJ073
        dQdnUpqWbiI46sOBAxe4q2bTf
X-Received: by 2002:adf:f286:0:b0:31a:d450:c513 with SMTP id k6-20020adff286000000b0031ad450c513mr11142586wro.26.1698774423891;
        Tue, 31 Oct 2023 10:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP9BCCeLEq6xdvs0Wx3pQhh6AItnLCO3wuz6+zvdhlWsIln3ZP18nlHwSoZ2VX9KH84ZLWTQ==
X-Received: by 2002:adf:f286:0:b0:31a:d450:c513 with SMTP id k6-20020adff286000000b0031ad450c513mr11142577wro.26.1698774423599;
        Tue, 31 Oct 2023 10:47:03 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id w5-20020adfec45000000b0032d9523de65sm2008194wrn.48.2023.10.31.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:47:03 -0700 (PDT)
Message-ID: <92faa0085d1450537a111ed7d90faa8074201bed.camel@redhat.com>
Subject: Re: [PATCH v6 10/25] KVM: x86: Add kvm_msr_{read,write}() helpers
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Yang Weijiang <weijiang.yang@intel.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, peterz@infradead.org, chao.gao@intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
Date:   Tue, 31 Oct 2023 19:47:01 +0200
In-Reply-To: <20230914063325.85503-11-weijiang.yang@intel.com>
References: <20230914063325.85503-1-weijiang.yang@intel.com>
         <20230914063325.85503-11-weijiang.yang@intel.com>
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
> Wrap __kvm_{get,set}_msr() into two new helpers for KVM usage and use the
> helpers to replace existing usage of the raw functions.
> kvm_msr_{read,write}() are KVM-internal helpers, i.e. used when KVM needs
> to get/set a MSR value for emulating CPU behavior.

I am not sure if I like this patch or not. On one hand the code is cleaner this way,
but on the other hand now it is easier to call kvm_msr_write() on behalf of the guest.

For example we also have the 'kvm_set_msr()' which does actually set the msr on behalf of the guest.

How about we call the new function kvm_msr_set_host() and rename kvm_set_msr() to kvm_msr_set_guest(),
together with good comments explaning what they do?


Also functions like kvm_set_msr_ignored_check(), kvm_set_msr_with_filter() and such,
IMHO have names that are not very user friendly. 

A refactoring is very welcome in this area. At the very least they should gain 
thoughtful comments about what they do.


For reading msrs API, I can suggest similar names and comments:

/* 
 * Read a value of a MSR. 
 * Some MSRs exist in the KVM model even when the guest can't read them.
 */
int kvm_get_msr_value(struct kvm_vcpu *vcpu, u32 index, u64 *data);


/*  Read a value of a MSR on the behalf of the guest */

int kvm_get_guest_msr_value(struct kvm_vcpu *vcpu, u32 index, u64 *data);


Although I am not going to argue over this, there are multiple ways to improve this,
and also keeping things as is, or something similar to this patch is also fine with me.


Best regards,
	Maxim Levitsky

> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 +++-
>  arch/x86/kvm/cpuid.c            |  2 +-
>  arch/x86/kvm/x86.c              | 16 +++++++++++++---
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1a4def36d5bb..0fc5e6312e93 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1956,7 +1956,9 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
>  
>  void kvm_enable_efer_bits(u64);
>  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
> -int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data, bool host_initiated);
> +
> +int kvm_msr_read(struct kvm_vcpu *vcpu, u32 index, u64 *data);
> +int kvm_msr_write(struct kvm_vcpu *vcpu, u32 index, u64 data);
>  int kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data);
>  int kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data);
>  int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7c3e4a550ca7..1f206caec559 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1531,7 +1531,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>  		*edx = entry->edx;
>  		if (function == 7 && index == 0) {
>  			u64 data;
> -		        if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
> +		        if (!kvm_msr_read(vcpu, MSR_IA32_TSX_CTRL, &data) &&
>  			    (data & TSX_CTRL_CPUID_CLEAR))
>  				*ebx &= ~(F(RTM) | F(HLE));
>  		} else if (function == 0x80000007) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6c9c81e82e65..e0b55c043dab 100644
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
> @@ -12082,7 +12092,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  						  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL;
>  
>  		__kvm_set_xcr(vcpu, 0, XFEATURE_MASK_FP);
> -		__kvm_set_msr(vcpu, MSR_IA32_XSS, 0, true);
> +		kvm_msr_write(vcpu, MSR_IA32_XSS, 0);
>  	}
>  
>  	/* All GPRs except RDX (handled below) are zeroed on RESET/INIT. */






