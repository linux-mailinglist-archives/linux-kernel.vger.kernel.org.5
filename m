Return-Path: <linux-kernel+bounces-146478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF248A65C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E82282646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E74D139589;
	Tue, 16 Apr 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C18t+wM+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440351804A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255137; cv=none; b=tE4AOocsN7NMgiV2UwM2k4ipSxqji7cKFkUlp4lM2waaZhKkQQMGSTp0sGdQAkH7UgLufxGmYnEmxlLePi4ZFL+dD/oLEEt9g/cCMhLU33Tsqt/xnBFxwKxHhjVlO3JJkdM0kRF6eq96Wojnh0di2ernVwGchFIzdn1jjGvv0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255137; c=relaxed/simple;
	bh=fHkjjrb6556Qbg7jSY8ccyBOwtzPPkpH4fZrZJjy0BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kk9nClI+1pffn8jD35rDCVUHdA63ADAA/ZZ5S9NU3BvEGkA49pFKQYGILKS0iGNSTpMvsRwwDvinWishbLS4hSKnXsXdHUKBsbJ/MXEX3Ewk6T5Qz8e2g1F0PTQ5vVhphwN7nQjvAcKltoAxn6grqXfZ3tMigYAjPEBRbr0UAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C18t+wM+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SgKxL/eKQVkFjHBAzj9wSgJ9oBIJBsaU4xFrb+pvQag=;
	b=C18t+wM+uo19c+2M94BJyMGT97mRlyGUDePUnMKoA1P3jRlVYlojsnDmCoK+evVaTH/4DT
	VSTjghdzdO3Ndzd4XosfBrTGvHYAfLQhNJJIbYP2NNmGlxn21xzUESA+QxLfVyIFkdgv6z
	IezLEU9PYQfszlXjWfzd/K//AFF8eFU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-rUZPLbAsOW2MHCTpjYqZIA-1; Tue, 16 Apr 2024 04:12:10 -0400
X-MC-Unique: rUZPLbAsOW2MHCTpjYqZIA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c8e87a74so2959192f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255129; x=1713859929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgKxL/eKQVkFjHBAzj9wSgJ9oBIJBsaU4xFrb+pvQag=;
        b=KeVu8V7fkpuoxqW0NZuAsu/hYyLKo0qp2YIMIpjrbBo893D7aCFlv+2YPHQ0dtLm7G
         +fXnHQ/bnYYmhLu4KSxDI9zoNlz4h1CCB1/VdcoTS74C+zr9ul85sMLIHAOLkYHupfkw
         sU3KbMKYEEY2Eg2X0L5b7zC5SpIyoc7FAVuIH7L4PN7Rwe1J8BWs+idMxPRpX5GIb29j
         +qcJJBjNg6+VvzAZEm+Z0CHemiIaeli+Q2eFep2L8BfniKcisHbz8CgHeeum4DOnArwf
         RZfDcZZy3/27yAPvfRC1P+Twi8EUnkCs2QQZdaDYop6nRJonAtdstjIiezzxhP30AeDl
         Td0A==
X-Forwarded-Encrypted: i=1; AJvYcCXeHmq5v2ibI5QM46CP8tn5Ox9ODg1AeT687srhQmcgE5zwPDsQlhROO+go5hh/Xa/zrrZXrndRjTAk9LnSnsUYGPj2XdoCaksZt7+9
X-Gm-Message-State: AOJu0Yy7ctf6tAsMhelOIlM62jiZvyZ/LnoGmUMz4Ksqz7yE758eBEYD
	8LPumKX1GAHSgF68Nw1UpfFUYryzkSlhe5z3lvDOXY8dk4rZLCWyLqJr4B2Dhqg5ZWDOtRGxYPL
	JJc9t9Ku30KPSODgTYzXu7GXNiN78qJHr5Qu0WzlFnvKSVesQspjoFc32vVb09g==
X-Received: by 2002:a05:6000:1a8b:b0:347:9e5a:3078 with SMTP id f11-20020a0560001a8b00b003479e5a3078mr6691617wry.1.1713255128978;
        Tue, 16 Apr 2024 01:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfWb3ErXICRRs6W7xZvCijufYXAQB9pbHv6YSqyacU/5DxD1IjXktrzVtU2hor92ueur2CFA==
X-Received: by 2002:a05:6000:1a8b:b0:347:9e5a:3078 with SMTP id f11-20020a0560001a8b00b003479e5a3078mr6691585wry.1.1713255128559;
        Tue, 16 Apr 2024 01:12:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id f18-20020adfe912000000b00343d6c7240fsm14102947wrm.35.2024.04.16.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:12:08 -0700 (PDT)
Message-ID: <08445556-b2e9-4519-942c-deee38b8d5b0@redhat.com>
Date: Tue, 16 Apr 2024 10:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20240412114858.407208-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240412114858.407208-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 13:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Profiling a system blindly with mTHP has become challenging due to the
> lack of visibility into its operations.  Presenting the success rate of
> mTHP allocations appears to be pressing need.
> 
> Recently, I've been experiencing significant difficulty debugging
> performance improvements and regressions without these figures.  It's
> crucial for us to understand the true effectiveness of mTHP in real-world
> scenarios, especially in systems with fragmented memory.
> 
> This patch establishes the framework for per-order mTHP
> counters. It begins by introducing the anon_fault_alloc and
> anon_fault_fallback counters. Additionally, to maintain consistency
> with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> Incorporating additional counters should now be straightforward as well.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


