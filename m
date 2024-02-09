Return-Path: <linux-kernel+bounces-60119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E856850017
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C63F1F27987
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F236B0A;
	Fri,  9 Feb 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR5qp22m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6332653
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518185; cv=none; b=jl3ySYieWXQ19+hCQY91J2NIO0z0OFu4LURP/Wh/coJnWD8W9VU86QubkoED4qJbanA7J7EI8sUdLuGd6hDjHDsOol5Q5jxJpAHnvMGykIVbHpzZJAwubjXP8ZqWUnbKOhi5O3TMhfsvOcwNQwewgGE+scszwtrzGcq6L1HqDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518185; c=relaxed/simple;
	bh=SfJHftGryZVlY1kWEXdfsgDfI4FHzlZzfxvhgdJqJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu5uBJWM/Ccy0FkmJDYS/C3h/kfgZfFuPhuawpvMNVRoyVa1Y+QC5OAqGf/ZBnXejWUdla1vENlhX6WRXf+52VL192Kex7k9MbPRd2zr1emZLpxx3T+2pUXJ41EugPGGSkdu7yHo1qdlJ9BTdAYNEEIOP+7LVTuDD+uK0c9ZgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iR5qp22m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707518182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZsuwvNcy7srG22SEiNvqp25+3IIw8oPhoxlAvIGHUo0=;
	b=iR5qp22mhmV9CuUKlWP/YO9bpl14GSBSxGdEekqU5an+qBVS/tr/GsIBE6tjW6kh9yFhwg
	12CIlloYcqdjp3Bd6Vbz9J/906zcuCJX8Y81w26RBVitLAleul90ik3u0z4WjhUg/YEMqS
	oICIPtPkUnMHOTWh+57nZeik5rFkg/g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-u585LpwCPzmkR6ILvXpZ1g-1; Fri, 09 Feb 2024 17:36:21 -0500
X-MC-Unique: u585LpwCPzmkR6ILvXpZ1g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b51ae1c9dso523923f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707518180; x=1708122980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsuwvNcy7srG22SEiNvqp25+3IIw8oPhoxlAvIGHUo0=;
        b=XSxwKwseXLRdCgrxhEH2OyZmwtr3GeI4Al5xQPB7xPvHkXQDKgQkBD2oRQrQIE7H2K
         K0+yueF8FWutpHNMA0hwvtRGAwQf1hConKbXYoft1IYoJAlGFvLxSysJF6SNxPWqufrv
         Z5HKmiXAbqnzX3ge6yL47mZ+5Bv4b4tRkMgM/ZVEFzV1z6cpNKz4D7sLs/N7FMt2N7oJ
         zR8klcfpkGRPgnaJqZCPUHDo/WB6+B+gmbx8Ruk88VpvdXXr4jRj+8qSA84vGL3GZRH+
         0hdGPszKJotia2UVZQshXwU7nsfpoAiX+aqIZk0xYLgfWGn3XlCG8Qo87Ruw/p0zSM4e
         Khtg==
X-Gm-Message-State: AOJu0YwCuHSqHOL0fJLoa51muq7w84FFoM1hFGB9sUBFftuwmsf0iTBY
	EVEZjMw1HeTsDeliQmIUPEge4Iu9Glb5ECdkfr8t8Zvt/8FE+q1k9HoYJVKhxvVWYOP5Q5h8+oY
	8EZT8z3nt3BnrU1px9z7sO1Tq7l/ao7d+ie1RiMzyGUJwtNeVyiYlQEMLTK8AaQ==
X-Received: by 2002:a5d:6292:0:b0:33b:63a5:feaf with SMTP id k18-20020a5d6292000000b0033b63a5feafmr257845wru.20.1707518180232;
        Fri, 09 Feb 2024 14:36:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy4CLCviUyK1OodnIQ1mSMGsomV26G3hTfhyNyhH+GDYkVLAS41fsfIsBxx2rncVdrBGU2iQ==
X-Received: by 2002:a5d:6292:0:b0:33b:63a5:feaf with SMTP id k18-20020a5d6292000000b0033b63a5feafmr257824wru.20.1707518179877;
        Fri, 09 Feb 2024 14:36:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+S/n/bVOO58PUK1OwN7/Y+dBJ5Acz/W4v5CpS3WjHnlBwf5/kpFz/wL+kjiKDWoYAbMbmz+gfFu3wnLXtBbxCWkITbHaCVUcGP7u+50RgLdzNW8tvTduDZYlK7MB1HQYRoJZinm8OkVnP8sJoPvVGz4wv+D0Eg2VgbZ7AXAwCuG3nMyDoSZuYSEQadSv9xdO/Fa6KTh1AkNjK94KUMkSDjzjPeBstwXOO6fe1+4//EXnxjeSQdYFt9cf1MrZj0tTGeQsXrFc8zY29xujzIzXIkv/sz7qQmw3J/oEyQULKRgSRj9dGr2hSQb6mMBn29bG9uZTzst7HlmvlOUeQMP3oO5aO9Qre9eufCQmP/scsKKHrMNn5C7brXfc/bnaV30nPWgCtCJj8DyNi6RVhcsICK0xzM3FLq+WtyxQXzxq3Q1mVv3ekPFV6vZDI9sRV0ZsOkcSnQr8Io1TS5UjvK5HhDSbVQSmc4Wh+hLJHHpfKcTOQ2+MxMY6N0Xxk9tPmR33BDXQythmIKROkQxoSG5pWrYSc6vt+la3dIZdPZKiOiKA8o1Qrw5HbI/KNeeMbhK0M6MWb8dov8n6VBAOblsB0fAZkWbv0dZBwcyGKAGdXYVftcthpd9cl8+TK+ztAgquDjBBYUdw9VWZ0hJbKnBMen/iCJVBWYDK18Kgh4t0wtTIgAL+hHoNIIwXxio66kkRQIbxB08XzsuYcI3oqq99Swsc1pwPtECz1LF3UJHq0YNgR131OhFS537vvvFq6oc08Ih4zOua0Y1XMcyyQAQPYLWoJSRDH6zWQYAyTkP5q6Is5nmPJhGU+1TZavOAw4aKVmIgceFdaNR9anFUa5bThPfvB3vEqMH60Pbru0a+AMRtmtj4XIDGO6hFgsPnuxl/y/ofxT5dIt4a28pdauobL4VRBGYmtKLzxoD6qzBcccu4oIX/98ViWmXZ9d0y+Cr0u5B
 2vz249Brar3w0=
Received: from ?IPV6:2003:cb:c718:6800:9d15:2b60:4f57:7998? (p200300cbc71868009d152b604f577998.dip0.t-ipconnect.de. [2003:cb:c718:6800:9d15:2b60:4f57:7998])
        by smtp.gmail.com with ESMTPSA id bv4-20020a0560001f0400b0033b670b0a6asm302786wrb.74.2024.02.09.14.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:36:19 -0800 (PST)
Message-ID: <6b0d2c43-90cd-4429-baa9-078dd37fe207@redhat.com>
Date: Fri, 9 Feb 2024 23:36:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] arm64/mm: Make set_ptes() robust when OAs cross
 48-bit boundary
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240129124649.189745-1-david@redhat.com>
 <20240129124649.189745-2-david@redhat.com> <ZcRwc2mEDHIXxgGa@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZcRwc2mEDHIXxgGa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.02.24 07:10, Mike Rapoport wrote:
> On Mon, Jan 29, 2024 at 01:46:35PM +0100, David Hildenbrand wrote:
>> From: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Since the high bits [51:48] of an OA are not stored contiguously in the
>> PTE, there is a theoretical bug in set_ptes(), which just adds PAGE_SIZE
>> to the pte to get the pte with the next pfn. This works until the pfn
>> crosses the 48-bit boundary, at which point we overflow into the upper
>> attributes.
>>
>> Of course one could argue (and Matthew Wilcox has :) that we will never
>> see a folio cross this boundary because we only allow naturally aligned
>> power-of-2 allocation, so this would require a half-petabyte folio. So
>> its only a theoretical bug. But its better that the code is robust
>> regardless.
>>
>> I've implemented pte_next_pfn() as part of the fix, which is an opt-in
>> core-mm interface. So that is now available to the core-mm, which will
>> be needed shortly to support forthcoming fork()-batching optimizations.
>>
>> Link: https://lkml.kernel.org/r/20240125173534.1659317-1-ryan.roberts@arm.com
>> Fixes: 4a169d61c2ed ("arm64: implement the new page table range API")
>> Closes: https://lore.kernel.org/linux-mm/fdaeb9a5-d890-499a-92c8-d171df43ad01@arm.com/
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

Thanks for the review Mike, appreciated!

-- 
Cheers,

David / dhildenb


