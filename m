Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2C67573FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGRGW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGRGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFADB5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689661303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvSmM7MQhdDXRVA2Uryq4YVNwYFzTKNqJe4q9sLr7I8=;
        b=RKsltFQEpKJNwNhCkujLuLUktKL20+w3x8FvMNRh9bFaduvjSKs16ZhSWj8UTcJ11nlD15
        CaUrzYXA9fJDm6Tslj/Z76qmKG1iVGE+EgXFLf0ktpWZH1QZEiaMgB4uAQQwLOPJwfGiaL
        de6GmvxbRm75PSgdWMFpTGo45KSZ2kQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-zsM4VpSvPQWJ8OCGCC8HTg-1; Tue, 18 Jul 2023 02:21:38 -0400
X-MC-Unique: zsM4VpSvPQWJ8OCGCC8HTg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-51b5133ad4dso1450543a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661297; x=1690266097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvSmM7MQhdDXRVA2Uryq4YVNwYFzTKNqJe4q9sLr7I8=;
        b=Wl8biCG/c4KhhqSAA1NxEx3kjkcQsj+cM2b2teQSL0+ls6slFZJ4E5Jt9W88N2aXIZ
         y2DPm7JyH6IzvMx+5nVQWtzGD4ribEL0+2qd4dCcntG06HcGpGmwRF+mjyWAe57t96p/
         KPE+lOkwdi/Pr/e0ALSkYkwe1iHyS5wiWc5Uq8tFe5ypyICdutNIGXmkB8soNRm18xH3
         fdAgXyrU8VzSTlosRStYHQ4vsflIBHj9zCywWV/09lQyVF327yxhRc3J1XQNH66aJ9Kv
         naMHGgV+AqxbuOxa3v5Gc3+MxIwQd3cQZqicYfKTLAEHP6yIf6nx+DvCp+Z0cy4BiO6p
         6+6Q==
X-Gm-Message-State: ABy/qLaRGRT97Ll86zRHx/irWtzF9XJiptVqQVjjCpdsWJYxgjov64HH
        VE/nTKDVb7huqb1IFzsYqwmCAvuGkrda3jj3eLbGQgGoADZlMsrI2/BILh/cq7lFs0J9zbXt9Es
        QbOwW12h+Xa718hROtCED5UyF
X-Received: by 2002:a17:902:da85:b0:1b8:9fc4:2733 with SMTP id j5-20020a170902da8500b001b89fc42733mr10753861plx.3.1689661297284;
        Mon, 17 Jul 2023 23:21:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwK4O80e6YQEGnzMYTYf6ot+mFwRDf85YBN8hCoLDeCfJGnn+lZlhDjDiUb0dFs/RD5ECIfQ==
X-Received: by 2002:a17:902:da85:b0:1b8:9fc4:2733 with SMTP id j5-20020a170902da8500b001b89fc42733mr10753835plx.3.1689661296887;
        Mon, 17 Jul 2023 23:21:36 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b392bf9192sm941082pll.145.2023.07.17.23.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:21:36 -0700 (PDT)
Message-ID: <8987d68b-d62a-7a9b-3aa3-cd5cc7ad551c@redhat.com>
Date:   Tue, 18 Jul 2023 14:21:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 05/11] arm64: tlb: Refactor the core flush algorithm of
 __flush_tlb_range
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
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230715005405.3689586-1-rananta@google.com>
 <20230715005405.3689586-6-rananta@google.com>
From:   Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230715005405.3689586-6-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/23 08:53, Raghavendra Rao Ananta wrote:
> Currently, the core TLB flush functionality of __flush_tlb_range()
> hardcodes vae1is (and variants) for the flush operation. In the
> upcoming patches, the KVM code reuses this core algorithm with
> ipas2e1is for range based TLB invalidations based on the IPA.
> Hence, extract the core flush functionality of __flush_tlb_range()
> into its own macro that accepts an 'op' argument to pass any
> TLBI operation, such that other callers (KVM) can benefit.
> 
> No functional changes intended.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   arch/arm64/include/asm/tlbflush.h | 109 +++++++++++++++---------------
>   1 file changed, 56 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 412a3b9a3c25..f7fafba25add 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -278,14 +278,62 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
>    */
>   #define MAX_TLBI_OPS	PTRS_PER_PTE
>   
> +/* When the CPU does not support TLB range operations, flush the TLB
> + * entries one by one at the granularity of 'stride'. If the TLB
> + * range ops are supported, then:
> + *
> + * 1. If 'pages' is odd, flush the first page through non-range
> + *    operations;
> + *
> + * 2. For remaining pages: the minimum range granularity is decided
> + *    by 'scale', so multiple range TLBI operations may be required.
> + *    Start from scale = 0, flush the corresponding number of pages
> + *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> + *    until no pages left.
> + *
> + * Note that certain ranges can be represented by either num = 31 and
> + * scale or num = 0 and scale + 1. The loop below favours the latter
> + * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> + */
> +#define __flush_tlb_range_op(op, start, pages, stride,			\
> +				asid, tlb_level, tlbi_user)		\
> +do {									\
> +	int num = 0;							\
> +	int scale = 0;							\
> +	unsigned long addr;						\
> +									\
> +	while (pages > 0) {						\
> +		if (!system_supports_tlb_range() ||			\
> +		    pages % 2 == 1) {					\
> +			addr = __TLBI_VADDR(start, asid);		\
> +			__tlbi_level(op, addr, tlb_level);		\
> +			if (tlbi_user)					\
> +				__tlbi_user_level(op, addr, tlb_level);	\
> +			start += stride;				\
> +			pages -= stride >> PAGE_SHIFT;			\
> +			continue;					\
> +		}							\
> +									\
> +		num = __TLBI_RANGE_NUM(pages, scale);			\
> +		if (num >= 0) {						\
> +			addr = __TLBI_VADDR_RANGE(start, asid, scale,	\
> +						  num, tlb_level);	\
> +			__tlbi(r##op, addr);				\
> +			if (tlbi_user)					\
> +				__tlbi_user(r##op, addr);		\
> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT; \
> +			pages -= __TLBI_RANGE_PAGES(num, scale);	\
> +		}							\
> +		scale++;						\
> +	}								\
> +} while (0)
> +
>   static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   				     unsigned long start, unsigned long end,
>   				     unsigned long stride, bool last_level,
>   				     int tlb_level)
>   {
> -	int num = 0;
> -	int scale = 0;
> -	unsigned long asid, addr, pages;
> +	unsigned long asid, pages;
>   
>   	start = round_down(start, stride);
>   	end = round_up(end, stride);
> @@ -307,56 +355,11 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   	dsb(ishst);
>   	asid = ASID(vma->vm_mm);
>   
> -	/*
> -	 * When the CPU does not support TLB range operations, flush the TLB
> -	 * entries one by one at the granularity of 'stride'. If the TLB
> -	 * range ops are supported, then:
> -	 *
> -	 * 1. If 'pages' is odd, flush the first page through non-range
> -	 *    operations;
> -	 *
> -	 * 2. For remaining pages: the minimum range granularity is decided
> -	 *    by 'scale', so multiple range TLBI operations may be required.
> -	 *    Start from scale = 0, flush the corresponding number of pages
> -	 *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> -	 *    until no pages left.
> -	 *
> -	 * Note that certain ranges can be represented by either num = 31 and
> -	 * scale or num = 0 and scale + 1. The loop below favours the latter
> -	 * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> -	 */
> -	while (pages > 0) {
> -		if (!system_supports_tlb_range() ||
> -		    pages % 2 == 1) {
> -			addr = __TLBI_VADDR(start, asid);
> -			if (last_level) {
> -				__tlbi_level(vale1is, addr, tlb_level);
> -				__tlbi_user_level(vale1is, addr, tlb_level);
> -			} else {
> -				__tlbi_level(vae1is, addr, tlb_level);
> -				__tlbi_user_level(vae1is, addr, tlb_level);
> -			}
> -			start += stride;
> -			pages -= stride >> PAGE_SHIFT;
> -			continue;
> -		}
> -
> -		num = __TLBI_RANGE_NUM(pages, scale);
> -		if (num >= 0) {
> -			addr = __TLBI_VADDR_RANGE(start, asid, scale,
> -						  num, tlb_level);
> -			if (last_level) {
> -				__tlbi(rvale1is, addr);
> -				__tlbi_user(rvale1is, addr);
> -			} else {
> -				__tlbi(rvae1is, addr);
> -				__tlbi_user(rvae1is, addr);
> -			}
> -			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> -			pages -= __TLBI_RANGE_PAGES(num, scale);
> -		}
> -		scale++;
> -	}
> +	if (last_level)
> +		__flush_tlb_range_op(vale1is, start, pages, stride, asid, tlb_level, true);
> +	else
> +		__flush_tlb_range_op(vae1is, start, pages, stride, asid, tlb_level, true);
> +
>   	dsb(ish);
>   }
>   

-- 
Shaoqin

