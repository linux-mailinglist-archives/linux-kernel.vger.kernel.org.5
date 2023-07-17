Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BBD7561C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGQLle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGQLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99480BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689594047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQqyG6oxXaLj0FF/OLRS2ExsXKIdb3iPjfzq0DwkqKY=;
        b=OYsrpJ7ikAQxSHYkliPDU+oirWqyLXe6Y8LcSQDMkl/UoFQ29zSv31W2KwRt3c1ggrydxi
        x08/eDSrWcRFH14wuE4sHCJigXKx6g/yLCEiQgeRYGjbvPTs1xh7XPtKAPxoUJcdCwWeWp
        pJkC80BuMxhRAnwuFhrgbGfxsZb4yDo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-jzsriL6DNkyhJYk-D0tuDA-1; Mon, 17 Jul 2023 07:40:46 -0400
X-MC-Unique: jzsriL6DNkyhJYk-D0tuDA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767edbf73cbso88077985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689594046; x=1690198846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQqyG6oxXaLj0FF/OLRS2ExsXKIdb3iPjfzq0DwkqKY=;
        b=NyyQoqiU5bejVTpcIwdCT/pWGafCawEAYxQOXc7kp8m/Np7kaHDkJPzWokfH0cT79K
         i07H/5rsmiZIYUV0g5xbWpR4M+4UMP0o0RVN4Ogus8fzjxRioGuhGSJZdTzHI/upUQFB
         d8YP3mR7Mnh2J0EnLBh11BzWgLqS3aRwPaYD+y/iRsziSLUrBDgpzHtNrhCfm9hpTgMM
         I8my29igl+Y4uVUQgAa3CmfYh5MxO/vyWKCxJIEZcoRGpwY0uU3L6SEFQ0B9rXth8J+7
         Ze8aXindeEMCRZRN0Fok+9dAkpFm76jGLUOHeEs5wvaBwelX1DUdwRZUZ+nDOo41dWM0
         C44g==
X-Gm-Message-State: ABy/qLYYZ5BEhWEiZf09dQeRIcEpd1awXebpg3pFhEfF4S4JNWwQfHf/
        9kEpEO4Z6ssnCCDed4YTNUCFxBEN6rWVAJ6f6A1yafyreDdHdETbcNnYGOSPCtJ4DRWFBM1AY1A
        qoKtGgK7ZkJcgsyKG0UJYw0iK
X-Received: by 2002:a05:620a:24c8:b0:767:7a4c:1b9e with SMTP id m8-20020a05620a24c800b007677a4c1b9emr9266347qkn.7.1689594046112;
        Mon, 17 Jul 2023 04:40:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDK1i5Bb5hW3SqNn/8w11DLVrfU0l98wShs1NeCy8lsDEALEXS1SLko5LtJ6r2IMuB1Q1XLw==
X-Received: by 2002:a05:620a:24c8:b0:767:7a4c:1b9e with SMTP id m8-20020a05620a24c800b007677a4c1b9emr9266330qkn.7.1689594045810;
        Mon, 17 Jul 2023 04:40:45 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a108700b00767d05117fesm6051154qkk.36.2023.07.17.04.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 04:40:45 -0700 (PDT)
Message-ID: <199d18de-1214-7683-b87a-03cc7e49719a@redhat.com>
Date:   Mon, 17 Jul 2023 19:40:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 03/11] KVM: Allow range-based TLB invalidation from
 common code
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>
References: <20230715005405.3689586-1-rananta@google.com>
 <20230715005405.3689586-4-rananta@google.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230715005405.3689586-4-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/23 08:53, Raghavendra Rao Ananta wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Make kvm_flush_remote_tlbs_range() visible in common code and create a
> default implementation that just invalidates the whole TLB.
> 
> This paves the way for several future features/cleanups:
> 
>   - Introduction of range-based TLBI on ARM.
>   - Eliminating kvm_arch_flush_remote_tlbs_memslot()
>   - Moving the KVM/x86 TDP MMU to common code.
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  3 +++
>   arch/x86/kvm/mmu/mmu.c          |  9 ++++-----
>   arch/x86/kvm/mmu/mmu_internal.h |  3 ---
>   include/linux/kvm_host.h        |  9 +++++++++
>   virt/kvm/kvm_main.c             | 13 +++++++++++++
>   5 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a2d3cfc2eb75..08900afbf2ad 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1804,6 +1804,9 @@ static inline int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>   		return -ENOTSUPP;
>   }
>   
> +#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages);
> +
>   #define kvm_arch_pmi_in_guest(vcpu) \
>   	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
>   
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index ec169f5c7dce..aaa5e336703a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -278,16 +278,15 @@ static inline bool kvm_available_flush_remote_tlbs_range(void)
>   	return kvm_x86_ops.flush_remote_tlbs_range;
>   }
>   
> -void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn,
> -				 gfn_t nr_pages)
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u64 pages)
>   {
>   	int ret = -EOPNOTSUPP;
>   
>   	if (kvm_x86_ops.flush_remote_tlbs_range)
>   		ret = static_call(kvm_x86_flush_remote_tlbs_range)(kvm, start_gfn,
> -								   nr_pages);
> -	if (ret)
> -		kvm_flush_remote_tlbs(kvm);
> +									pages);
This will be good if parameter pages aligned with parameter kvm.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> +
> +	return ret;
>   }
>   
>   static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index);
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index d39af5639ce9..86cb83bb3480 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -170,9 +170,6 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
>   				    struct kvm_memory_slot *slot, u64 gfn,
>   				    int min_level);
>   
> -void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn,
> -				 gfn_t nr_pages);
> -
>   /* Flush the given page (huge or not) of guest memory. */
>   static inline void kvm_flush_remote_tlbs_gfn(struct kvm *kvm, gfn_t gfn, int level)
>   {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3f968b38ae9..a731967b24ff 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1359,6 +1359,7 @@ int kvm_vcpu_yield_to(struct kvm_vcpu *target);
>   void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool yield_to_kernel_mode);
>   
>   void kvm_flush_remote_tlbs(struct kvm *kvm);
> +void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 pages);
>   
>   #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
>   int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
> @@ -1486,6 +1487,14 @@ static inline int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
>   }
>   #endif
>   
> +#ifndef __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +static inline int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
> +						   gfn_t gfn, u64 pages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>   #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
>   void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
>   void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d6b050786155..804470fccac7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -366,6 +366,19 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   }
>   EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
>   
> +void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 pages)
> +{
> +	if (!kvm_arch_flush_remote_tlbs_range(kvm, gfn, pages))
> +		return;
> +
> +	/*
> +	 * Fall back to a flushing entire TLBs if the architecture range-based
> +	 * TLB invalidation is unsupported or can't be performed for whatever
> +	 * reason.
> +	 */
> +	kvm_flush_remote_tlbs(kvm);
> +}
> +
>   static void kvm_flush_shadow_all(struct kvm *kvm)
>   {
>   	kvm_arch_flush_shadow_all(kvm);

-- 
Shaoqin

