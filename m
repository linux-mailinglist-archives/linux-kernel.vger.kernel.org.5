Return-Path: <linux-kernel+bounces-148124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD778A7E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C1F1C21BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDBE7E0E4;
	Wed, 17 Apr 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fia8TK/J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FF7D3E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342000; cv=none; b=tpq5iC3M4EaY/TTKf0Mc0d59lKggGnuPDqP2i0QqsBKjg/MHHBgTMzO6nP4cLJF6q4UzlsE09MGpNvpK9Jveop6K+uMznMFyVHXYuzV65AK5Xa7yOVQW1NxYRGXUCDgZV92tX5aF3pKVO5HVLTyhCZyXbJkvLzmnXrQChYADAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342000; c=relaxed/simple;
	bh=XGV0GSHLdt1QDp6fWEmKQXR451KA/qwqEbjGBy31ZmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeAlNphmWCLyQuBNaQlMP7lt/pAguzQviweUqG7YRr4g2ZX1yOHdfXPHRNesjH1YpLmZc2SC/TyODqZG6ElvJbsXmsdi7R2S2n16iMSmiyaWTrDQ17lc/H3AKPxJ3qZA6DX3+6Xr92+5DbGeOR395DFCzbM41EOcNbtF4mHT52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fia8TK/J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713341997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=C3uroh1Ppgw+q/4v8TmwH5+NLrGopN54CehRkmgPTBQ=;
	b=fia8TK/JJ8rcmD0JEM87LomsT+LhajEsEeTWy0RZlS9uHuTDrzTMDNs7OH1i+gGfrDHLeQ
	FVZZR1F5FmrEIOHt/SotyIQxQd4WVOK6ME08RhmFwutqCpJMIH7qnf7m+u9G0h1TRgwPIt
	lhm6KZBGPhW6ncSrJnw/zjIowlttfZA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-dMygn31PPUC38x0R72B9xQ-1; Wed, 17 Apr 2024 04:19:55 -0400
X-MC-Unique: dMygn31PPUC38x0R72B9xQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3473168c856so2752543f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713341994; x=1713946794;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3uroh1Ppgw+q/4v8TmwH5+NLrGopN54CehRkmgPTBQ=;
        b=aJjn7HziswWN83rImi/M6axhadWpP9Vg6NKL7Qfp81e6rpGLP48NCxAZBpW20A8f3x
         zc4WEi7uS7wdnvcvq4uuhvY9JnWtnxFwYWnJH2r4YznnuWDWj++e/bzxjlykamJlIrFe
         x7GLZHSFdT1voVxVrbuyQqDcknF4v45H8xsAv4/DMhzWHtcQw3boSqvoFYHErXRRyoOA
         cVTN1ChpuFQNdxNJwx98QXuzbRcSkoKOgLKSXbq6lI5jDtKOJTTxfJvS8yLfpsiXFXQy
         ceutj+y7Afrj7D24uEjGMo661g/fFFJycTk3C96dji5MbAm/Ga/7my/nI7ZE7/0KqIks
         SS1w==
X-Forwarded-Encrypted: i=1; AJvYcCVghEb0ZrhSO8uGfassRMDrGrLS6zHsOSyju/cmPx+e389JMJfbvFLxbkiQvV4T0gW6rtyedHV/Xg9gd3wcXQS4m0Ybax2gDhgEvVZn
X-Gm-Message-State: AOJu0YwrRgVOV2gGivWohpNGNHiyu1CKIrWEYcJIOgtxCdvq52h75R31
	Z3p2G4zSTPXY3bor0bUbFNZSG2aGEAFOOfKh9YwtHq/+XbEcDX1gTyVHkCxNh6sqBNvgw9e9bqW
	vHhVyibLkKpn6ZypxOZtt4xENznGEVMMjPAO2AmwKGwU6n7XIQMAKKcUcn0IjUg==
X-Received: by 2002:a5d:6848:0:b0:343:eb7d:760e with SMTP id o8-20020a5d6848000000b00343eb7d760emr10390454wrw.17.1713341994724;
        Wed, 17 Apr 2024 01:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETf2ergMjQ6KA+vyhRqAinL3LXN7Tts1CSKmLhBURhZhgXjLA5AV5wdTPmRI+reR6RmpI9qw==
X-Received: by 2002:a5d:6848:0:b0:343:eb7d:760e with SMTP id o8-20020a5d6848000000b00343eb7d760emr10390433wrw.17.1713341994291;
        Wed, 17 Apr 2024 01:19:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2300:653:c844:4858:570f? (p200300cbc74523000653c8444858570f.dip0.t-ipconnect.de. [2003:cb:c745:2300:653:c844:4858:570f])
        by smtp.gmail.com with ESMTPSA id t11-20020adfe10b000000b00347edb20b6esm6495635wrz.106.2024.04.17.01.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:19:53 -0700 (PDT)
Message-ID: <76d22c08-82db-4ea8-a7cd-c77589e132e3@redhat.com>
Date: Wed, 17 Apr 2024 10:19:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
To: Lance Yang <ioworker0@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, fengwei.yin@intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com,
 xiehuan09@gmail.com, zokeefe@google.com
References: <CAK1f24mEoC_Pg7-49G=y7dMUaGhzW11_A5sK0EWVhH6K1kjMMA@mail.gmail.com>
 <20240417050426.66194-1-ioworker0@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240417050426.66194-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 07:04, Lance Yang wrote:
> Hey David, Ryan,
> 
> How about this change?
> 
> static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> 					  unsigned long addr, pte_t *ptep,
> 					  unsigned int nr, cydp_t flags)
> {
> 	if (flags == CYDP_CLEAR_YOUNG) {
> 		for (;;) {
> 			ptep_test_and_clear_young(vma, addr, ptep);
> 			if (--nr == 0)
> 				break;
> 			ptep++;
> 			addr += PAGE_SIZE;
> 		}
> 		return;
> 	}
> 
> 	pte_t pte;
> 
> 	for (;;) {
> 		pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
> 
> 		if (flags & CYDP_CLEAR_YOUNG)
> 			pte = pte_mkold(pte);
> 		if (flags & CYDP_CLEAR_DIRTY)
> 			pte = pte_mkclean(pte);
> 
> 		if (--nr == 0)
> 			break;
> 		ptep++;
> 		addr += PAGE_SIZE;
> 	}
> }

Likely it might be best to just KIS for now and leave it as is. The 
compiler should optimize out based on flags already, that's what I ignored.

-- 
Cheers,

David / dhildenb


