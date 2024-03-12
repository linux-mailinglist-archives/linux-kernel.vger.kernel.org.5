Return-Path: <linux-kernel+bounces-100516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B98798FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554221F22533
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CFF7B3C7;
	Tue, 12 Mar 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoQDZjCs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586F15BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261166; cv=none; b=DcnRJ1C0rinoSV79n3ccKTcxhMY2WfejuXQqQ953/c5THHPOvt2V49f6qgCh3IJ+0e9glIzCOCSjF67Kj9fdZasPljRLoZ+07+hE5OdBHt8lLWaRorOw5NqugQwUbOCNIohiaw1eTSb1aZ0LlcNbpDJ4xauq2IETjt7f/08KMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261166; c=relaxed/simple;
	bh=pT4A8KRyax+MWUBN8kgJa0GYq9MIM0vWryL3/9AfPqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZ3+78PnG5lB0RKa9bz++DW1IaQHbQnKhHysG8mPpasy8Yv9SribKksX8n4xsBNDj4Kpmhq9cmFHMJhAS+up6JMO2EhiI+f1sSYgJQYK1fQINWFXdzPWUjEIf10QphXHDrsxxIFeYe7GrG07TtkusaMnDLlYRtFWG9MHlhOOio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HoQDZjCs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710261163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHB/JkWPpDsOAGqyljIkMfM+BbHEVGA0EFqjKMzC9K8=;
	b=HoQDZjCso+UZGYg6klyZyDDxGF1DgK2L3cbjjdJuvrmkLfQEWe+AEXdYWE47N3Dqz7B8z/
	HjgwnQqsbI5qL0bDuaQvNAr0wgJ2h9NE9ne4F1+3QUXW0BFCO1/B9xvMu7joQjrbR1zPHH
	s7dE+ZNkdPpT/7c7Usko1bw/BH5awGk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-yYxwfKhCPvCIbRPDl21nOQ-1; Tue, 12 Mar 2024 12:32:41 -0400
X-MC-Unique: yYxwfKhCPvCIbRPDl21nOQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-513c1e823ffso864717e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710261160; x=1710865960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHB/JkWPpDsOAGqyljIkMfM+BbHEVGA0EFqjKMzC9K8=;
        b=iPpatr4oIwaZYES+7UlhEuU4beCdbF5WLxMtnXaIoJ9NgKNE34sR9FR2OtiDvArgBN
         BDfoPiqgmHYPA9dGv8GOxQbtLhHZSgxS7CPYjWZokOuCGfgDNJTFQq3u5GX0Zs+uQFz9
         dG+nyTsGcDwMHQKuXa1PCkX6BasUMY79vjfmBNDGYEcmKVs55EAyWAxPRh/uFgzMWpKi
         DZobzWwdxz5QuO6bcG/cPGIiFcyfdGb70vEuYHISnG8M8Bim3lqfpd406lA8+nq1mQEC
         2mQQWF7KXrth9GXwQbu+9npJMGh6jsX1hOBBMrSc3EP7NHXOmu1tOsk5VPE/0476Hy84
         GS1w==
X-Forwarded-Encrypted: i=1; AJvYcCU5OxZLcD8577Sfrym+iFdt2H7xPJkERFL2+vZueqeS/SHAEI6J4ET+TL/OEs639PR8C4mC17Sn9P5FFoeKBDYtdJEc/JvaYZdbHAVs
X-Gm-Message-State: AOJu0YwgtOAdG2G8cHjCjsBMJDmpvrwzwOSLNCNPdI7o5e7YTzwwuMDL
	nOxgGatGmDfLcVww4il29CRgUM798hZ56jTansoR2ejG8YNidte+8IDWqajEX7wCf3E+64u+/+z
	KEmDEzdMriXvWssSorHWS29Whby53PXFJ01sVTlTeDPDQXde2YxvnehBzyXWRcQ==
X-Received: by 2002:a05:6512:390d:b0:513:816e:5cae with SMTP id a13-20020a056512390d00b00513816e5caemr6384037lfu.3.1710261159662;
        Tue, 12 Mar 2024 09:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVKSCgAfql24zMJHTK9sQSKaTyxcfPpub4C1WDI9LRVRCPu3kaWisGFR4NtKEWCfRVWkjvsQ==
X-Received: by 2002:a05:6512:390d:b0:513:816e:5cae with SMTP id a13-20020a056512390d00b00513816e5caemr6384017lfu.3.1710261158568;
        Tue, 12 Mar 2024 09:32:38 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23be3.dip0.t-ipconnect.de. [79.242.59.227])
        by smtp.gmail.com with ESMTPSA id bs15-20020a056000070f00b0033e9f6997c7sm3448929wrb.66.2024.03.12.09.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:32:38 -0700 (PDT)
Message-ID: <37ed1ddd-f1d0-4582-b6c5-2f4091dc8335@redhat.com>
Date: Tue, 12 Mar 2024 17:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, sfr@canb.auug.org.au
References: <20240312094133.2084996-1-max.kellermann@ionos.com>
 <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com>
 <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.03.24 17:27, Max Kellermann wrote:
> On Tue, Mar 12, 2024 at 5:10 PM David Hildenbrand <david@redhat.com> wrote:
>>>    include/linux/mm.h                            | 583 +-----------------
>>>    include/linux/mm/devmap_managed.h             |  37 ++
>>>    include/linux/mm/folio_next.h                 |  27 +
>>
>> Isn't that a bit excessive? Do we really need that many folio headers?
> 
> It would technically be possible to have fewer headers by merging
> several of those headers back into one, but then the dependencies will
> be heavier, and eventually we'd be back at the large "mm.h" mess that
> I would like to get rid of.

Just curious: why? Usually build time, do you have some numbers?

> My patch set constitutes the balance of "not too many headers" vs
> "small set of unnecessary dependencies for each including source file"
> according to my taste.

I'm not against splitting out stuff. But one function per header is a 
bit excessive IMHO. Ideally, we'd have some MM guideline that we'll be 
able to follow in the future. So we don't need "personal taste".

For example, if I were to write a folio_prev(), should I put it in 
include/linux/mm/folio_prev.h ? Likely we'd put it into folio_next.h, 
but then the name doesn't make any sense.

The point I am trying to make: if there was a single folio_ops.h, it 
would be clearer where it would go.

Just my 2 cents, seeing one-function-per-file headers.

-- 
Cheers,

David / dhildenb


