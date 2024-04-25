Return-Path: <linux-kernel+bounces-158261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96E68B1D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA4D1C20F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1484FAB;
	Thu, 25 Apr 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0yQDVjY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16584DE6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036612; cv=none; b=kYRFEQoUQSR/ZJeTqldipv6WFBP+dtAxrIZUuWyJkI8pwNVUMVu+dxy407M+lDBYOjjQ2f/dmJ1crXRehxEWpBt9QIDl1j4RHwAP8py69KbgScUyP//F0ahSMxM8CstMNOB3cW7kGhobZRPRyhf35bXEE3UcK+VIb1ojlwLZQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036612; c=relaxed/simple;
	bh=VoSU51VISO+hw99uq4P1Dk7m/L2h5BCQps7z+ffZUcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOocOHrWvkPE42KzlXgy/vaeICl/2i0wozmepKxWqg8wIcFtadULTSB2UIEvKC+1hcFKBWtIwZxvv/UgC5tsxkeM/IKJ5t5dPng5Vnu0bhBivilGFmUSc4MlQ+DJKRGvvinaA+LbmPlyynuACcjyCI3er4w/u42/A8YiUxxAbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0yQDVjY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714036609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xWaBdNkfRQDI3g5Ki0XK8PI99M75gj9zBLOBAiQCsuU=;
	b=O0yQDVjYCnt2Von7d9VuBIFESdrcNnEV+NXRjqNPAT8ox0X4nPPX/VX1NE3dM4llDHhGQv
	qHPf4bWcbm3QJv68cwEfCp6+0ag+VfWtZnVYK7eDohptEzEWImCzhaRaH+x78XODY0pLFh
	Qx5hMLBjuYfcFH8Bk3iv28kPAKqOiTc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-H7s9dPJNNzqWiq3NDtlMIg-1; Thu, 25 Apr 2024 05:16:47 -0400
X-MC-Unique: H7s9dPJNNzqWiq3NDtlMIg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d86adb107eso4316971fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036605; x=1714641405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xWaBdNkfRQDI3g5Ki0XK8PI99M75gj9zBLOBAiQCsuU=;
        b=lckM7JYc95Kgb5nNSD472rWrW6ReCXhtRXY/j2POKgddZnDYju4N0DDGGmirpKj/8Y
         pwuKAx96jCxRnhyxr7QchSvK0vgtj/ulWfdTW9X5qar0dZZiX0NYrzHqdptuZSu+6/A9
         DHPoIFVdTM0Xk/SqGLT/36uZDf8oXMtzujpTX5vMAiUwUNOocOr/yEQjbVlXddryLc1h
         7RS7Jb022jaDHZvRQNy2UC3oucarCyOhhfIRA6D2icz2JRUIVRdluOlFwS+HVoh+w1Ug
         hFowxmihd7brARArhv4sJnW91cKggQGB2JwLmG0MBK7s7fVaC1uLB08hbG0rvbGXp1B5
         OdJw==
X-Forwarded-Encrypted: i=1; AJvYcCXga8sRyjdkqFPJOg4QkExIkaG6iJJkL720e/hFadLjOg/8sp7bX/ndwZxMWc+SBt8/WFAfjkEL1aZhhDl9me/qUF9lmXZ3o/zRzit0
X-Gm-Message-State: AOJu0Yy4OgN8msRJSe1BmR0DEQF9uCgJZd2ZVqp8YKzAHI4fOkaw/rTj
	K/e6xfrBsFI9WaUi3rFdUFtNdb4mG3HfDkHYVX2a8JkpkqvEYhRG58T0BkCrEVBtdTQv+U6Azi1
	JLx+kr6bvuUIALC9fP8L7mBW/AtxS1uHUfHhsXMnN4c9a6OctE2m/ONwJNUSCGg==
X-Received: by 2002:a2e:b710:0:b0:2de:8685:d07b with SMTP id j16-20020a2eb710000000b002de8685d07bmr2683189ljo.46.1714036605534;
        Thu, 25 Apr 2024 02:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPbzn+T1zFO7KFXRELqIOh7quur2fsWLpq0W2IDqAc4nHr9+GYz1TazRzI3oNCV5cqSxS+VQ==
X-Received: by 2002:a2e:b710:0:b0:2de:8685:d07b with SMTP id j16-20020a2eb710000000b002de8685d07bmr2683167ljo.46.1714036605060;
        Thu, 25 Apr 2024 02:16:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c502800b0041b4c293f75sm1386471wmr.13.2024.04.25.02.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:16:44 -0700 (PDT)
Message-ID: <b55558a5-a9d4-4aea-956a-1babad01b6cd@redhat.com>
Date: Thu, 25 Apr 2024 11:16:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64/mm: Move PTE_PROT_NONE and
 PMD_PRESENT_INVALID
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-2-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240424111017.3160195-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 13:10, Ryan Roberts wrote:
> Previously PTE_PROT_NONE was occupying bit 58, one of the bits reserved
> for SW use when the PTE is valid. This is a waste of those precious SW
> bits since PTE_PROT_NONE can only ever be set when valid is clear.
> Instead let's overlay it on what would be a HW bit if valid was set.
> 
> We need to be careful about which HW bit to choose since some of them
> must be preserved; when pte_present() is true (as it is for a
> PTE_PROT_NONE pte), it is legitimate for the core to call various
> accessors, e.g. pte_dirty(), pte_write() etc. There are also some
> accessors that are private to the arch which must continue to be
> honoured, e.g. pte_user(), pte_user_exec() etc.
> 
> So we choose to overlay PTE_UXN; This effectively means that whenever a
> pte has PTE_PROT_NONE set, it will always report pte_user_exec() ==
> false, which is obviously always correct.
> 
> As a result of this change, we must shuffle the layout of the
> arch-specific swap pte so that PTE_PROT_NONE is always zero and not
> overlapping with any other field. As a result of this, there is no way
> to keep the `type` field contiguous without conflicting with
> PMD_PRESENT_INVALID (bit 59), which must also be 0 for a swap pte. So
> let's move PMD_PRESENT_INVALID to bit 60.

A note that some archs split/re-combine type and/or offset, to make use 
of every bit possible :) But that's mostly relevant for 32bit.

(and as long as PFNs can still fit into the swp offset for migration 
entries etc.)

> 
> In the end, this frees up bit 58 for future use as a proper SW bit (e.g.
> soft-dirty or uffd-wp).

I was briefly confused about how you would use these bits as SW bits for 
swap PTEs (which you can't as they overlay the type). See below 
regarding bit 3.

I would have said here "proper SW bit for present PTEs".

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/arm64/include/asm/pgtable-prot.h |  4 ++--
>   arch/arm64/include/asm/pgtable.h      | 16 +++++++++-------
>   2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index dd9ee67d1d87..ef952d69fd04 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -18,14 +18,14 @@
>   #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>   #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>   #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> +#define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */
>   
>   /*
>    * This bit indicates that the entry is present i.e. pmd_page()
>    * still points to a valid huge page in memory even if the pmd
>    * has been invalidated.
>    */
> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> +#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 60) /* only when !PMD_SECT_VALID */
>   
>   #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>   #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index afdd56d26ad7..23aabff4fa6f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1248,20 +1248,22 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>    * Encode and decode a swap entry:
>    *	bits 0-1:	present (must be zero)
>    *	bits 2:		remember PG_anon_exclusive
> - *	bits 3-7:	swap type
> - *	bits 8-57:	swap offset
> - *	bit  58:	PTE_PROT_NONE (must be zero)

Reading this patch alone: what happened to bit 3? Please mention that 
that it will be used as a swap pte metadata bit (uffd-wp).

> + *	bits 4-53:	swap offset

So we'll still have 50bit for the offset, good. We could even use 61-63 
if ever required to store bigger PFNs.

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


