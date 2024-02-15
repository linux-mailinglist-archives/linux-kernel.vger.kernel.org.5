Return-Path: <linux-kernel+bounces-66694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79623856131
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F350B227B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600713246D;
	Thu, 15 Feb 2024 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2Q7dZje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23461384BC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993660; cv=none; b=lGuijN30C4OBqk0u4XDSxFVYsywx7Tey79/e3lngQEk2a248znZ7Hn0YFavh/dkWW3mfjEVY8o7u6QL1kTn0H0/uHAZKKH3XuxAjtPpAB8tJ/OkzotejhibHTQXuTjfE14s9KQN74qgKZ/Bdusg+nAebzMtnQXaFKj5rbjS6yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993660; c=relaxed/simple;
	bh=SWZyr91RSjFEBPMJygb0PeNZiqlT5lF1JF07mMzSN50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPITPscaRl1cOoojnw3irEwHUyehqmhw/CmOhOfsx+C/pMSPSSJ54BaKo9X8X7bFJ1i+TqpmqwBQmeY7WaMIJtQh4cB0gUdMD/mj+w0Qy5mQvUNc3KJkFGZR4rDNCQtEBfUwcEMoORujvFGZWYo091NoOfqT+QJe0vVAB0eiPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2Q7dZje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707993657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dn6tveOs8PusEs8m4mD6zhNeKDU0VeTYuAwtKeY+rs0=;
	b=M2Q7dZjePAHFju4KIcgDQjHQHeQl5D/Q94GVRS9XgzzhORZDAJNxK43Fi4Wh9OTKY/VKVg
	E85RL7x/Ke4waaVRPUQBJYxRn/3jyTPj2kajIe/z69eBdtchxqfueDSkOK+Yez+cjrZ5rT
	1FB/1Xnpi+OnS2iNoMtBgGLImXUnMH0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Ax3P3Xf4N9CsYGbVeWatFQ-1; Thu, 15 Feb 2024 05:40:55 -0500
X-MC-Unique: Ax3P3Xf4N9CsYGbVeWatFQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68c51abe499so13044856d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993655; x=1708598455;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn6tveOs8PusEs8m4mD6zhNeKDU0VeTYuAwtKeY+rs0=;
        b=F5aAERkiu9YNtU72ymeAIBXtvIw0byPwh+qq4oEd4SZe5Lntolp0BbBVow/EValKTR
         twnsyljk6madm2KbfG2muFP/fl4MyGDiHOL9azKJwQTmJ2AD0M6ehwHZOV1W1XyQf/Uu
         /g8l5NzeE2eyJ5fhKyj00uKy5D/IHxpdrpl1jSavwGpyHNIMDCit7m1UqOsZYdiou8fq
         qvw4KnQJEmG6E7I6AsSIqBLhfWXYl4Ucu0BeK9Kt1NqjP2LMYkT7k/yRZvXdyK3Mx66c
         cCSbG5AFAer+E4d9CO3hfUh38SkCzjgu1ceTkb90l8+AVyMWObG8p6r9LfhZbYtGRy2D
         fSfA==
X-Forwarded-Encrypted: i=1; AJvYcCWfs0ezPnUXqea3gkKutuUR7Y5uwGva52/zveXoLlN/2aoUGFf42nuMjtEJ0fM9bizALkzvv2mvTYsrAg91uhj3SHicFvyNKFuuLz3m
X-Gm-Message-State: AOJu0YwxTWc4wsZ/QwnqLLwUrt3EoO4DDCAM3ny71b5Zw10ojPvGkIG/
	WchDfl2yi+mYds9Nf5E4LkW844lO/udRHAk45caa4KAwWE5fn47gD9U4vR4b8vpxVStJp/ofUN8
	t4iQFv0C307oRMkVkHN7e02fP/mGQhu3/M5gGYSWdE1pmBLQ9A0OSYPXReW0vmw==
X-Received: by 2002:a0c:f5d3:0:b0:68c:46e0:78d with SMTP id q19-20020a0cf5d3000000b0068c46e0078dmr1336996qvm.45.1707993655386;
        Thu, 15 Feb 2024 02:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMIzzBE86F6/yl4ubcuKOsVW2ImujOvA9fp0gqQGQAEFO2Q+VxkIQrF3T8orreKnGMsgBwPg==
X-Received: by 2002:a0c:f5d3:0:b0:68c:46e0:78d with SMTP id q19-20020a0cf5d3000000b0068c46e0078dmr1336986qvm.45.1707993655069;
        Thu, 15 Feb 2024 02:40:55 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id lu7-20020a0562145a0700b0068efbe2235asm535657qvb.54.2024.02.15.02.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:40:54 -0800 (PST)
Message-ID: <3dd9a4b1-d912-4a92-9450-97ca816a267b@redhat.com>
Date: Thu, 15 Feb 2024 11:40:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] mm: Introduce pte_advance_pfn() and use for
 pte_next_pfn()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240215103205.2607016-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.02.24 11:31, Ryan Roberts wrote:
> The goal is to be able to advance a PTE by an arbitrary number of PFNs.
> So introduce a new API that takes a nr param. Define the default
> implementation here and allow for architectures to override.
> pte_next_pfn() becomes a wrapper around pte_advance_pfn().
> 
> Follow up commits will convert each overriding architecture's
> pte_next_pfn() to pte_advance_pfn().
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/pgtable.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 231370e1b80f..b7ac8358f2aa 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -212,14 +212,17 @@ static inline int pmd_dirty(pmd_t pmd)
>   #define arch_flush_lazy_mmu_mode()	do {} while (0)
>   #endif
>   
> -
>   #ifndef pte_next_pfn
> -static inline pte_t pte_next_pfn(pte_t pte)
> +#ifndef pte_advance_pfn
> +static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
>   {
> -	return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +	return __pte(pte_val(pte) + (nr << PFN_PTE_SHIFT));
>   }
>   #endif
>   
> +#define pte_next_pfn(pte) pte_advance_pfn(pte, 1)
> +#endif
> +
>   #ifndef set_ptes
>   /**
>    * set_ptes - Map consecutive pages to a contiguous range of addresses.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


