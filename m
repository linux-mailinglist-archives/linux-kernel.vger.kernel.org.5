Return-Path: <linux-kernel+bounces-125876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB071892D51
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEDE2846D0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54884645B;
	Sat, 30 Mar 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDsB8mzR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030143ADA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831918; cv=none; b=NmDxFCeKxXLodM4aNCDvoKETeKYityysmOWZIJpSl9+OrS1Tzhz4qWkdxm30XbCrFMiLHI8dT33eOGXtxM62qFC/9D/6mAZ6M37H0T77u8bT35DHRFQvuOJutI/exPGcdVXtyieEHiezwtobuzRxliUZiPqXhJkagm4+avEyRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831918; c=relaxed/simple;
	bh=eo76hJ5KgggZKPYnrOo0bwJDa2FPFvtChdiC2X3NlIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFxoAWgnUCBSG6rOqCuPbsAtIGfzU9uxTIB4lfFVuPLgQqpFjBK7RrvClz7R6DPoVBA31HCDTMSa5f+USfYDgxeWdhWrOQrBIM623UQ1kahUKJiE2d/VazwfuIHP87/JOY/y/iTp0AwpCIY7zclUvKcM6Yaqo7yb+Fk5uHEer0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDsB8mzR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711831915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OZ3Ciau6EpVtoog0PBxIAt4mBisJnFBL8QU+3ujOsIY=;
	b=GDsB8mzRt7qplwK+Erlu4RM+kimSVlIpS3t4yaOmtdgU4TlUcUlBVqLtSKTXzyy8YzgiuI
	jHof/6AdAPyYzzjJ5ou5lfvYP6LmzPwVi0slsISSz4rqk0pFrzSuhSuUWdlXKPbaGAzine
	EWuuJfMOecAZiQLlhh/L5Jwfrz7F+Y8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-Fig882iAPuamCML7IhEmTQ-1; Sat, 30 Mar 2024 16:51:53 -0400
X-MC-Unique: Fig882iAPuamCML7IhEmTQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a46852c2239so192215466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831912; x=1712436712;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ3Ciau6EpVtoog0PBxIAt4mBisJnFBL8QU+3ujOsIY=;
        b=G5Icvh1iLDzthCyYDp1A6trgPWW42G+NJ5xu74Z0RlTgnbhHPHaCIlwl70aVuAE1tE
         xfWhoPoDN3M2aofCP7falZkXZfwc+KiKytNZhRL3xLtKdz8XdGvC7J6w12vAtMzUCwXU
         HDeVMY8gzVchxZm2YuXlpYuWnVUx5QNbGnWLspUWWjXTwZiJ1/OUkoZGMfHJGF9RnR/R
         IpMfN5vUkqnVv8QZL36c8dOzSrTFTKYHaUzrYKVmIgG1H4wHitXJWnf3FpJgzOzi/BxM
         ITHI0ZYWMAME/73JzVZrarg65+n4kDHea4ioUTVLNoagyf5NNxFxZOLYx25cJlu80FWw
         4h3g==
X-Forwarded-Encrypted: i=1; AJvYcCWrC7hQblBe0WlyK7Cxb5yukB/gJ4d3tPI6GnskCCmR0ROSWU3n/QmwrU0CgFmmuhaTUGbn5NxG/88IMheHEWYDe/43kJLbggsrxVGn
X-Gm-Message-State: AOJu0YyLXEWwq7dG8xZF8FO03N0yOJAP/lrNTqSIi+6grB9GAdzbwvPP
	oqS+o+IvR2aF+NoFFzF1tInuajW1fZbExo3+uUFOYW+LMbpTfr4ZUjZLZwgGSwCE7m3FskeD1kt
	ffP82JIcOHX/URyG5dxrsbgmytVckUPuY0LPm1Py3Nfbjn3napWKrI4C5/YMzaA==
X-Received: by 2002:a17:906:1253:b0:a4d:ff5f:98ad with SMTP id u19-20020a170906125300b00a4dff5f98admr3545159eja.37.1711831912735;
        Sat, 30 Mar 2024 13:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE01IT9TeNxfmx0zF5Xk6kwBCeppMFBPly3IZPz1shqv6ixk8RRaNFkk5C/OVE5TsIYrwjytA==
X-Received: by 2002:a17:906:1253:b0:a4d:ff5f:98ad with SMTP id u19-20020a170906125300b00a4dff5f98admr3545135eja.37.1711831912424;
        Sat, 30 Mar 2024 13:51:52 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.49.219])
        by smtp.googlemail.com with ESMTPSA id z3-20020a170906714300b00a4650ec48d0sm3489665ejj.140.2024.03.30.13.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 13:51:51 -0700 (PDT)
Message-ID: <30c5f2f3-ff1e-4b0d-bb1f-eba95f578376@redhat.com>
Date: Sat, 30 Mar 2024 21:51:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/29] KVM: x86: Export the kvm_zap_gfn_range() for
 the SNP use
To: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org
Cc: linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-crypto@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, jroedel@suse.de,
 thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, seanjc@google.com,
 vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
 dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
 peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
 rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de,
 vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
 tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alpergun@google.com, jarkko@kernel.org, ashish.kalra@amd.com,
 nikunj.dadhania@amd.com, pankaj.gupta@amd.com, liam.merwick@oracle.com,
 Brijesh Singh <brijesh.singh@amd.com>
References: <20240329225835.400662-1-michael.roth@amd.com>
 <20240329225835.400662-17-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240329225835.400662-17-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 23:58, Michael Roth wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> While resolving the RMP page fault, there may be cases where the page
> level between the RMP entry and TDP does not match and the 2M RMP entry
> must be split into 4K RMP entries. Or a 2M TDP page need to be broken
> into multiple of 4K pages.
> 
> To keep the RMP and TDP page level in sync, zap the gfn range after
> splitting the pages in the RMP entry. The zap should force the TDP to
> gets rebuilt with the new page level.

Just squash this in patch 17.

Paolo

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 +
>   arch/x86/kvm/mmu.h              | 2 --
>   arch/x86/kvm/mmu/mmu.c          | 1 +
>   3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a3f8eba8d8b6..49b294a8d917 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1950,6 +1950,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
>   				   const struct kvm_memory_slot *memslot);
>   void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
>   void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
> +void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
>   
>   int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
>   
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 2c54ba5b0a28..89da37be241a 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -253,8 +253,6 @@ static inline bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm)
>   	return __kvm_mmu_honors_guest_mtrrs(kvm_arch_has_noncoherent_dma(kvm));
>   }
>   
> -void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
> -
>   int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu);
>   
>   int kvm_mmu_post_init_vm(struct kvm *kvm);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0049d49aa913..c5af52e3f0c5 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6772,6 +6772,7 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
>   
>   	return need_tlb_flush;
>   }
> +EXPORT_SYMBOL_GPL(kvm_zap_gfn_range);
>   
>   static void kvm_rmap_zap_collapsible_sptes(struct kvm *kvm,
>   					   const struct kvm_memory_slot *slot)


