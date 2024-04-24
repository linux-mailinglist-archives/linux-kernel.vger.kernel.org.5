Return-Path: <linux-kernel+bounces-156826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55158B08CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95D61C222F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720715AAB1;
	Wed, 24 Apr 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dd8B8+3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C3158A0B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959861; cv=none; b=fu2fyB56W/XxH5HdtqpctcxFtX9mEzuHnkWpJHkFL24kh/NxBoCStW82zNXIwg6rHPYDcBLnjoQsC7SMNQ+QMO4oKsfs6xmkrumtGDCXUj5fPzTaB4BlhiNwJmw6hYTJWqtV056l51XdwOD5Y83Knr0Fgc5e3pNpjHXwACIiZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959861; c=relaxed/simple;
	bh=FXcbLFdw+XrDuJHSnNUSYiab+GPqRj8hnonc6pw41Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFaou1p8YUifBvy44w2Lf04bm1QSilyaTa9wiBv24DkqwIgrx8dU6ObLeVyBYtX2EO1Mpkd1ggVRZyVlqV9FxOiw9z9AiK18HH47q/dBhVvjmmnoUl3iN9p3QclFD3UrTLO4hZxuUt/R5lPADmxSqf7Vh62Ajrz7+UN3qtFReVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dd8B8+3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713959859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hIPRMYCbtc11jovhEqN9ZXUbzG9dYFyhpKhWu6jMXQ=;
	b=dd8B8+3v8FYJTOMwN5y4cgPCV0kHicB8DYUgDB2nv0gUurUJwCds8uSlXK/QV5b4jOVtMz
	NOurqSQS4vEH7NeJvjBCbMiGuhD6EsNxB0zdJjdklnwicDk1MtSktPiIJOGPCN1mT6+03j
	aA410eN9UPuD/ZBenx9VDuwxdFJJxv4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-0xVtTMa4PSWmtwdteOOH_Q-1; Wed, 24 Apr 2024 07:57:38 -0400
X-MC-Unique: 0xVtTMa4PSWmtwdteOOH_Q-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-434ed2e412fso29696151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959857; x=1714564657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hIPRMYCbtc11jovhEqN9ZXUbzG9dYFyhpKhWu6jMXQ=;
        b=eGNzYCiyBZCipgw/Hr6qVcn0T/nbncPUvxFIejkC1B6qj3uhcpUU7XHK1ITABexguv
         yZg/2jwy3Sq/La0KaVQSsbpOieMui+QHuMCQ9XHM3fAZJ6U1weQGIEr6/nFnlFLTSpHo
         OwrranG2VzmjeN2PGoEC8hEzpeho+8tXT2BeCEOS1QQjZ6Ff7AT/pdE+yjUeCVCnDigD
         JP/gGiO9dzT5eycyX6h/7rqNOrv3iPqoxtTrvcV8ZURQ4HW1RJ3FFEXlXDTa/9VtbVh2
         pLx6CHVCa4SGOPa619DSacWMOpXHajOEA1GebJw2PkxfHXyhwkGUE0WeRwwtVdF4PQX9
         Zumw==
X-Forwarded-Encrypted: i=1; AJvYcCXn5MfVEtdC6vnGoUo15gfDowMFFtFvjlecx4NcSI6TR6Dn8zn0K809UgDol3sMpdo1AblDPVWYC5ww0AguaVtaGJjcCE28e3woBfYW
X-Gm-Message-State: AOJu0YxXQ0DILghlir7+S7uYnW3a9sXXWlHHyV9xN9ir+/S8NvTvbBXF
	/iLLY1r7qWmQ60/shZBif9sXadl7isI3iO3eXTkdgKT0Uf2Jc9FgUDhDAzDTrDrlmjqQMFDPHe4
	K4tiySwnTMQtX/i9Mu6DKyMGurh3RXUuD4Zl42NLVBCYiLf8RnIYyJvoRBLpeKg==
X-Received: by 2002:ac8:6e88:0:b0:434:f74e:30ec with SMTP id c8-20020ac86e88000000b00434f74e30ecmr2335525qtv.5.1713959857364;
        Wed, 24 Apr 2024 04:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH67qXObSRwV9XSK7/IHdwF/55R6D0oF8GK75we9gygA2vGyGxSw/6wXenTHhcLxiIgQNd+zw==
X-Received: by 2002:ac8:6e88:0:b0:434:f74e:30ec with SMTP id c8-20020ac86e88000000b00434f74e30ecmr2335503qtv.5.1713959856722;
        Wed, 24 Apr 2024 04:57:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ic10-20020a05622a68ca00b00436510ddc5esm6014392qtb.34.2024.04.24.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:57:36 -0700 (PDT)
Date: Wed, 24 Apr 2024 07:57:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64/mm: Add uffd write-protect support
Message-ID: <Zijzrje2FDXsSojP@x1n>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424111017.3160195-3-ryan.roberts@arm.com>

Hi, Ryan,

On Wed, Apr 24, 2024 at 12:10:17PM +0100, Ryan Roberts wrote:
> Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.
> 
> The standard handlers are implemented for set/test/clear for both pte
> and pmd. Additionally we must also track the uffd-wp state as a pte swp
> bit, so use a free swap entry pte bit (3).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks all sane here from userfault perspective, just one comment below.

> ---
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/pgtable-prot.h |  8 ++++
>  arch/arm64/include/asm/pgtable.h      | 55 +++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84..763e221f2169 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -255,6 +255,7 @@ config ARM64
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
> +	select HAVE_ARCH_USERFAULTFD_WP if USERFAULTFD
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index ef952d69fd04..f1e1f6306e03 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -20,6 +20,14 @@
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>  #define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +#define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
> +#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
> +#else
> +#define PTE_UFFD_WP		(_AT(pteval_t, 0))
> +#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 0))
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  /*
>   * This bit indicates that the entry is present i.e. pmd_page()
>   * still points to a valid huge page in memory even if the pmd
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 23aabff4fa6f..3f4748741fdb 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -271,6 +271,34 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>  	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>  }
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline int pte_uffd_wp(pte_t pte)
> +{
> +	bool wp = !!(pte_val(pte) & PTE_UFFD_WP);
> +
> +#ifdef CONFIG_DEBUG_VM
> +	/*
> +	 * Having write bit for wr-protect-marked present ptes is fatal, because
> +	 * it means the uffd-wp bit will be ignored and write will just go
> +	 * through. See comment in x86 implementation.
> +	 */
> +	WARN_ON_ONCE(wp && pte_write(pte));
> +#endif

Feel free to drop this line, see:

https://lore.kernel.org/r/20240417212549.2766883-1-peterx@redhat.com

It's still in mm-unstable only.

AFAICT ARM64 also is supported by check_page_table, I also checked ARM's
ptep_modify_prot_commit() which uses set_pte_at(), so it should cover
everything in a superior way already.

With that dropped, feel free to add:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


