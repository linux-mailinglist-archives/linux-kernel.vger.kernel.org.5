Return-Path: <linux-kernel+bounces-163851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1738B749E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85B41C22450
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9D12D761;
	Tue, 30 Apr 2024 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX09KW4/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12112C47A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477080; cv=none; b=CLvkaCLkQOSS1JlqHoqMa/5u9nkhs87GgSX9rzhRIGH6gaZV8bgGSPfdBxSofUY/e7jEPh9Gy8qgG/De7tedjCRjEJsB++O2Kn09JOVEewdGMY4k6h2zGmsSt598M9Vh3O9oZMF4flCAGqkuF0r94lYgcM4heTzhYzNS1w/7vU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477080; c=relaxed/simple;
	bh=4gpEbG/4BWXqKWr/5VqbybEdY4EHhTTloRCq1lV4Ylg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk1g5uc7yebwRC1pc8Aq1TfpKwKQgTPtlIebf8xq0LBl+4+p7VbS9GQXOmA4jPTaifT18+UDg3BX4XZ2uy9or3flHk3IlTO2vuiYUZYtAW9MK4umePuAR5wIao0eQsOPrrRJt7hFMX4acV2IzLMG6FfjU2HLQ5K+oDj15+SE75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX09KW4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714477077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eiAW+x1zKVTvGTvtjODDDjCAqDM2UP0sxyHU46nIuLU=;
	b=aX09KW4/VBUT81IL0job8OAy98hlg0bMytHkdppPTLRBYt79Yn/w6Rh5IEFAv1ayEqbigb
	rRQEFNFdR5P4gQRAqudzxFMDYYYupGOwtscG/2UZ7SYiKE+q1rdKfLS2nz7SYDEuBAWSTg
	arBROw/Fm0BnqbksrgP7+6dn8RMAXZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-CSYCeH6KNHaA_j7W3RG3Yw-1; Tue, 30 Apr 2024 07:37:56 -0400
X-MC-Unique: CSYCeH6KNHaA_j7W3RG3Yw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4169d69ce6bso23952215e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714477075; x=1715081875;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eiAW+x1zKVTvGTvtjODDDjCAqDM2UP0sxyHU46nIuLU=;
        b=Her2W6e97eYskGxxqKEmQxxEAw0H78YMVVFlUhf50ZeKJY0rgIwWQU+tVIT9oo+JLA
         gHDcjLN0yHPSXXgqwJZ+qIQKv+UluzARNCY/RD9SzN5wDUrvT/JQNzNSuaEiVryVe823
         bPJC2eTp3PayuH+8uXe3sxuJ9bL4NqwdL6cjcFGGb17J/RL7a+LN4u25a7HNDPbdPJFg
         UrYpFiX0V/ptgRyPOof7ESh8PWf7lJdcElNsWYnwFWZU1dvvloo54p/34jqWs1rNPdi5
         GEw2WengyZsoyK/HM/ZYy4gmNG3LGE78v68ZuJqnyd0yMfqbl4U1tqsAnj2zHSmGy46S
         ECGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/KpEQkl0ALKsJW8Apl11iek04wrUwvmgmrk3wqCLb1+t96FKlky4R3Vo267IcjMJGwCSm3ELR+4zGSxgnvjzlgW0hsTI6U9V6Dqv4
X-Gm-Message-State: AOJu0YyFmvUvIhJMx3WlV8CvpKddkVKCmzp90i1jeICbl+6Np/7/HpP9
	WIh8BFYLBFmCg6bZUqXR7ZMrESKG+3RVLmo735gowrdNrILTYna56kbyXxQOJFeNIilblUWVLA5
	L10ZGYI3fG0CserQLOHxdDnuahOxCIUhxjhP5AIpyWrd8bEnkSQjP3j167oXoIw==
X-Received: by 2002:a05:600c:3d9b:b0:41b:fe6e:8a0e with SMTP id bi27-20020a05600c3d9b00b0041bfe6e8a0emr1846691wmb.13.1714477075175;
        Tue, 30 Apr 2024 04:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBjcJ8fnQHVbF6+IV00h/FYxVbVzAtbd0LRfOXotvYUiJsQ0oEvNuNuWmo+BbJ8Y7d1ZbNhg==
X-Received: by 2002:a05:600c:3d9b:b0:41b:fe6e:8a0e with SMTP id bi27-20020a05600c3d9b00b0041bfe6e8a0emr1846679wmb.13.1714477074783;
        Tue, 30 Apr 2024 04:37:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b0041adf358058sm25048834wmb.27.2024.04.30.04.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:37:54 -0700 (PDT)
Message-ID: <29fd6909-73d2-4b7e-99ef-0101cde1ba8a@redhat.com>
Date: Tue, 30 Apr 2024 13:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com> <Zi_IzrfIcqWxt7cE@arm.com>
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com> <ZjDR0EIjLr9F2dWn@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZjDR0EIjLr9F2dWn@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.24 13:11, Catalin Marinas wrote:
> On Mon, Apr 29, 2024 at 06:15:45PM +0100, Ryan Roberts wrote:
>> On 29/04/2024 17:20, Catalin Marinas wrote:
>>> On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
>>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>>>> index dd9ee67d1d87..de62e6881154 100644
>>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>>> @@ -18,14 +18,7 @@
>>>>   #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>>>   #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>>>   #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>>> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>>> -
>>>> -/*
>>>> - * This bit indicates that the entry is present i.e. pmd_page()
>>>> - * still points to a valid huge page in memory even if the pmd
>>>> - * has been invalidated.
>>>> - */
>>>> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>>>> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
>>>
>>> Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
>>> it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
>>> looks like a negation only.
>>
>> Meh, for me the pte can only be valid or invalid if it is present. So it's
>> implicit. And if you have PTE_PRESENT_INVALID you should also have
>> PTE_PRESENT_VALID.
>>
>> We also have pte_mkinvalid(), which is core-mm-defined. In your scheme, surely
>> it should be pte_mkpresent_invalid()?
>>
>> But you're the boss, I'll change this to PTE_PRESENT_INVALID. :-(
> 
> TBH, I don't have a strong opinion but best to avoid the bikeshedding.
> I'll leave the decision to you ;). It would match the pmd_mkinvalid()
> core code. But if you drop 'present' make sure you add a comment above
> that it's meant for present ptes.

FWIW, I was confused by

present = valid | invalid

Something like

present = present_valid | present_invalid

would be more obvious at least to me ;)

-- 
Cheers,

David / dhildenb


