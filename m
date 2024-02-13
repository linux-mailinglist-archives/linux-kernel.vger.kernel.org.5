Return-Path: <linux-kernel+bounces-64447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3315E853E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A8F1C232F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCC64A98;
	Tue, 13 Feb 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiR1SseL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311563120
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862457; cv=none; b=g0+WqoRO1orK3h/39SiFf3YhegCgr+IwpFgmD7Td295yXW89ZE+J14EtN29ClHuyqIpPHy9864R0pGvUUmJTPeqAAqKvOt6OdJvDeG/ke/6hku9wMrFEg5K2um6KRympA1biYMJtxH326YOdKkDhQTZP1ScWxfaKo0LmVjoNYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862457; c=relaxed/simple;
	bh=LF1SbVel55UlBy2cCY59l4DXqJLB0mGwNGAfhvwgG/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isR5KuZny6y6V+XqdtRJfUY1LQPOGhPmgW3hidrk2drCJO74KjuSfAZ6kvZdp78e0SEWO8mZFC6DJf/VKVr2heHnfw9d8LA1aVQP5c2h3yQA4MGI+N3ompstMYfbRYpCVnaTEEf2nbkBbobzhV7sAgkIEk18CyF7DGqTygeIFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiR1SseL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707862454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VlR4oL4JYqbRBSZyJNMBAjatqbYDx/+zQJL/01o4kgo=;
	b=fiR1SseLwI9wdj7/e7xjQ7ew8sa5HKfRd2bmeXiwgdOUTCJJNSvOGHzd/r1LjaQFQbxnvv
	b61oYMhASiP1Fpt541zq1UniiJb7oTHm89jKxSNr2Kk6xPP/xXRHkx7eg1ZD8ONzPeA7ra
	Dyj0uGxVHJlTXKevRF5tRytNWFWnmbI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-_VpTAKhZOw2ihRX3rPc0oQ-1; Tue, 13 Feb 2024 17:14:11 -0500
X-MC-Unique: _VpTAKhZOw2ihRX3rPc0oQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-337a9795c5cso890160f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862450; x=1708467250;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlR4oL4JYqbRBSZyJNMBAjatqbYDx/+zQJL/01o4kgo=;
        b=kmrZguoFCJI4Qtd7uWi8DznQsfyuodZZx0bOsr6dPH8r1iLW7jqHENnyqZAEzkRJFb
         CTYxaKPcptZMWxb1XLYIpdeRfIRwyfeVpBApyO3QjwbNAhtz9r4WvCIjZuKODDxxUboL
         4O0+qlgS5/X21/Rau1SL1V0cpqUgndMg0mIkG8Q4lG8VAGKlBhEqWurLmG1/rJqWdJoE
         zlxvXyr1kJYkXRdpvh9e2tRZOtv7T0HscQfJ9x8AVP5pTRx0HkE4mhByKd4pijfNtzhN
         dPJUzBoFdp3d6F8t3d8xyAYRo/jN55eG/aduQDIpjOIbDpRqFkiRsM/2GiB4xm76VvqU
         GmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVTrcgGLGeSRPMMO73qekMpPBkxQSh93XMWo/bKG4pMHd+YUeYNG7uj4MEf9lTxZYM8v1ncm7pelw7Mwzcv2o0enaPaogacsri0Sho8
X-Gm-Message-State: AOJu0Yx0MLyH01G1jgNgQ7CXQ9I1Bdqtt9HZNFkF8Wcg1xSaM6A9OEzq
	u53mSIZfz47tjA0NgcOiONN0mY8JSmscbG8qxd8Kw0ERJb4xgWbhPvmpJ074mQ/zDQDZoumSAfZ
	rUfutLsFGzepnDP7U3fRNwzJAemnZRNQaDhsHvAvPlvXawBbi+1S3dHAB7H7Chw==
X-Received: by 2002:a5d:60c7:0:b0:33c:e2d7:79d1 with SMTP id x7-20020a5d60c7000000b0033ce2d779d1mr353607wrt.69.1707862450639;
        Tue, 13 Feb 2024 14:14:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErAoSjKfrma+gHwUWBHmpYT2aLgb15aWidjKLV37wWIJEkEY384dO2RLMkvCpcKFdwkrlBHw==
X-Received: by 2002:a5d:60c7:0:b0:33c:e2d7:79d1 with SMTP id x7-20020a5d60c7000000b0033ce2d779d1mr353588wrt.69.1707862450280;
        Tue, 13 Feb 2024 14:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtuP+IbgLY/GmMYBOvY3F6tEijrtrqWhYEclFgAYpN3kpUFXSyfEfaVTnTWdTy6QVhbf4XwKvmyx/cBkhVnBNnIWEGW4YaIO+Q8PKBiDREAqsVRi8mP1knFUoRvZXQ4L/cculgweo9NvGGEXcZGJ7Mge8lT2S3Y7VHpkK5hkDXAzS6Afy3IJ2qdokgL/fepZJFu/ecB8vTzGLJaGuwD0iyOMvCA0R4xZ0lPk4ZZMFm+uqjIJ1Uz7Jyrxcfn2M9bMJKHO5T+IUQmaGLcOhnBrYpcV8QCVxw7A0DdvGDEjIWNN/v4rA3DG09WDbyIIF+DvPWKUWhEdXaUg9xGcmtysgno4ihHC06Igj674u2Mp4Vo0KqxIjrSQaVmV24VM8NEuxa1Q/cAcS4OblvDUHI37ZzO+lKNIuOGVW/xdAwE2pX2zURPIm4LJb2taxcyheiFosNKNbu01lFrjY7jpTigCEP8y4QFHd064ar9gPe8/y/HdFTV+ZfT77Oai/pgesp8hbLEhrB8SHorfodTKvPstfLqmwMBToHK6vMUXNVWHYyQ5SeABGQrBj+Ay8=
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0033ce1ef4e7asm1601631wri.13.2024.02.13.14.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 14:14:09 -0800 (PST)
Message-ID: <bac6136e-7990-45b8-9bcd-94181b63f18e@redhat.com>
Date: Tue, 13 Feb 2024 23:14:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <Zcvns2HCB61cwvgE@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zcvns2HCB61cwvgE@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 23:05, Luis Chamberlain wrote:
> On Tue, Feb 13, 2024 at 04:55:18PM -0500, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>> Order-1 folio is not supported because _deferred_list, which is used by
>> partially mapped folios, is stored in subpage 2 and an order-1 folio only
>> has subpage 0 and 1.
> 
> The LBS patches has the patch from Matthew which enables and allowed us
> to successfully test order 1. So this restriction could be dropped if
> that gets merged.

For anon folios it will still be in place, so the restriction will only 
be dropped for !anon.

-- 
Cheers,

David / dhildenb


