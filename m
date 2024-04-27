Return-Path: <linux-kernel+bounces-160927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD298B449F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02DC1C22641
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615241A8F;
	Sat, 27 Apr 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCR/KkEW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9D40BFE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714200674; cv=none; b=pPRt+IpzLjWU63WShKdvaicoI5v7Sc2L1gH5VT+1FSwToFJfJh0kKAGY/Zjn5ZOyHkV8INH48PE2oxlRm/3+dijKSbYJB48sVnE6acsoV/Drqs0DdigR94C6j7pZMvPHoyuXfA5CKCrMJzV6gTr/wcSDnD1NZq1Z+7hq+1wppLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714200674; c=relaxed/simple;
	bh=+8fHiqSvp87bfsm5i3JFm6jKcrmiLQejBZ59Pb1qxSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0R6tUADAOX4XGL7679mFgFzyDxxq2MDZVfY3wUKZikp1x4c24RvpCG7M01382WQLU9QY+gmqCe7Bz3SlL7/lO9w6smDy2HOc0eLg/u3swKo8E+2kmrc1takh5ybEcQYiyMQWGewf1voMCEBi5bfBc6NrzI0NKT6BExZt8zJUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCR/KkEW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714200670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fxFpIXtgd+aMlKeworDRGgf8Q7//hXXW2VVMLwdZ4PI=;
	b=dCR/KkEWIjwA6l9S60XSMVvvAGcin93/gl7W9mYpU+vxfOyeSR5tGZ+B5/G1qVU788CpjK
	9sQxuYwZwnT9NJgnwK4Od7EY9kkapdEu+pbk5YfYtMvx0m2al3vM2/dlCvXqIdp/xItaUW
	5TS5b3eTwE3lXueEfTpWwHW+h3v/wSk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-lbKu0PBoNii9h2WgL-PsSA-1; Sat, 27 Apr 2024 02:51:09 -0400
X-MC-Unique: lbKu0PBoNii9h2WgL-PsSA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d88271f485so22012101fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714200667; x=1714805467;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fxFpIXtgd+aMlKeworDRGgf8Q7//hXXW2VVMLwdZ4PI=;
        b=C1tCr1HhsQiCbTprYs6PQv/dMCEHXvD7hF7exYWpiz0JcZQcRHVupm2gadoWXMB3LY
         xmg8f6vIL8E6uP9Z9cYTkBwjQ0Urmq5DaaFg8Oq2+W7dHo8c2K16bdqJYF3xz2+5yeU/
         qygIwIWSIgXrHhMM2fUTs3ZJ2MpavfPqNmg+/kseQmLNew/uIsNQZmdFjAC6HzppVlvo
         HBfbHI0Y2BK3BS+7D1y+gEb8RCw7yJ1tq3+cJb8QcFjKfqF1EUfKZXoI7V1a0CsGNBAr
         dYvuLpSClh6CTU3hehfR0hK4AEvRdPa1Xr+onW1M6dzv4JeqycT2D9q093RuQxD3KlrQ
         pbug==
X-Forwarded-Encrypted: i=1; AJvYcCWk/sJ9zbFJFxIT/gp3VuVOKmxdJnBZ39i5OWDs0YYmbpIMiWf4D9IyGJZWfCiCYxdWXv3jy/GDTR5EqqERRYo9tkHvDuUHFMUQTYAr
X-Gm-Message-State: AOJu0YyIacsW55AHPsoDyxJuMvUZawGSShdytzztePeoy6nHBFf1C6fY
	9RQuR7VVIJpcb0Dk3p0GvX3NkFsLB7jWbg4670L5KuRLzxSJ3ptt9hvhi8xBoQI95bffN/B2kur
	x8ifaz0ExvRqtvK0Am57KZRS3Tg0FUWFF8i2cVyRbx2FvGSwS0k/aimkXpKwM1A==
X-Received: by 2002:a05:6512:20ca:b0:51b:455a:d649 with SMTP id u10-20020a05651220ca00b0051b455ad649mr2406135lfr.38.1714200667624;
        Fri, 26 Apr 2024 23:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAbkbZZAZIc3bDrtyuekS6sPB56WCYlzgYS3lhqNPq9XWLnnUztq/nZ172sTRPqaNQi2k36g==
X-Received: by 2002:a05:6512:20ca:b0:51b:455a:d649 with SMTP id u10-20020a05651220ca00b0051b455ad649mr2406120lfr.38.1714200667175;
        Fri, 26 Apr 2024 23:51:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:9c00:2aaa:88a4:e41d:65ba? (p200300cbc7319c002aaa88a4e41d65ba.dip0.t-ipconnect.de. [2003:cb:c731:9c00:2aaa:88a4:e41d:65ba])
        by smtp.gmail.com with ESMTPSA id t26-20020ac24c1a000000b0051979e3a586sm3249926lfq.266.2024.04.26.23.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 23:51:06 -0700 (PDT)
Message-ID: <436316d3-7fee-4843-93f3-1c07860566c8@redhat.com>
Date: Sat, 27 Apr 2024 08:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Lance Yang <ioworker0@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20240426190253.541419-1-zi.yan@sent.com>
 <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
 <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
 <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
 <CAK1f24=PnZ-Q=TrG9+SKWhwNHF_=EbVBWVcexqsEU-dctrAOFA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24=PnZ-Q=TrG9+SKWhwNHF_=EbVBWVcexqsEU-dctrAOFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.04.24 06:06, Lance Yang wrote:
> On Sat, Apr 27, 2024 at 4:16 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.04.24 21:20, Zi Yan wrote:
>>> On 26 Apr 2024, at 15:08, David Hildenbrand wrote:
> [...]
>>>>> +   bool partially_mapped = false;
> [...]
>>>>> +
>>>>> +           partially_mapped = !!nr && !!atomic_read(mapped);
>>>>
>>>> Nit: The && should remove the need for both !!.
>>>
>>> My impression was that !! is needed to convert from int to bool and I do
>>> find "!!int && !!int" use in the kernel.
>>
>> I might be wrong about this, but if you wouldn't write
> 
> I think you're correct.
> 
>>
>>          if (!!nr && !!atomic_read(mapped))
>>
>> then
>>
>> bool partially_mapped = nr && atomic_read(mapped);
>>
>> is sufficient.
> 
> +1
> 
>>
>> && would make sure that the result is either 0 or 1, which
>> you can store safely in a bool, no matter which underlying type
>> is used to store that value.
>>
>> But I *think* nowdays, the compiler will always handle that
>> correctly, even without the "&&" (ever since C99 added _Bool).
>>
>> Likely, also
>>
>>          bool partially_mapped = nr & atomic_read(mapped);
>>
>> Would nowadays work, but looks stupid.
>>
>>
>> Related: https://lkml.org/lkml/2013/8/31/138
>>
>> ---
>> #include <stdio.h>
>> #include <stdbool.h>
>> #include <stdint.h>
>> #include <inttypes.h>
>>
>> volatile uint64_t a = 0x8000000000000000ull;
>>
>> void main (void) {
>>           printf("uint64_t a = a: 0x%" PRIx64 "\n", a);
>>
>>           int i1 = a;
>>           printf("int i1 = a: %d\n", i1);
>>
>>           int i2 = !!a;
>>           printf("int i2 = !!a: %d\n", i2);
>>
>>           bool b1 = a;
>>           printf("bool b1 = a: %d\n", b1);
>>
>>           bool b2 = !!a;
>>           printf("bool b2 = !!a: %d\n", b2);
>> }
>> ---
>> $ ./test
>> uint64_t a = a: 0x8000000000000000
>> int i1 = a: 0
>> int i2 = !!a: 1
>> bool b1 = a: 1
>> bool b2 = !!a: 1
>> ---
>>
>> Note that if bool would be defined as "int", you would need the !!, otherwise you
>> would lose information.
> 
> Agreed. We need to be careful in this case.
> 
>>
>> But even for b1, the gcc generates now:
>>
>>    40118c:       48 8b 05 7d 2e 00 00    mov    0x2e7d(%rip),%rax        # 404010 <a>
>>    401193:       48 85 c0                test   %rax,%rax
>>    401196:       0f 95 c0                setne  %al
>>
>>
>> My stdbool.h contains
>>
>> #define bool    _Bool
>>
>> And I think C99 added _Bool that makes that work.
>>
>> But I didn't read the standard, and it's time for the weekend :)
> 
> I just read the C99 and found some interesting information as follows:
> 
> 6.3.1.2 Boolean type
>      When any *scalar value* is converted to _Bool, the result is 0 if the
>      value compares equal to 0; otherwise, the result is 1.
> 
> 6.2.5 Types
>      21. Arithmetic types and pointer types are collectively called *scalar
>      types*. Array and structure types are collectively called aggregate types.
> 
> 6.5.13 Logical AND operator
>      Semantics
>      The && operator shall yield 1 if both of its operands compare unequal to
>      0; otherwise, it yields 0. The result has type int.
> 
> 6.5.10 Bitwise AND operator
>      Constraints
>      Each of the operands shall have integer type.
>      Semantics
>      The result of the binary & operator is the bitwise AND of the operands
>      (that is, each bit in the result is set if and only if each of the
> corresponding
>      bits in the converted operands is set).
> 
> && would ensure that the result is either 0 or 1, as David said, so no worries.
> 

My example was flawed: I wanted to express that "if any bit is set, the 
bool value will be 1. That works for "| vs ||" but not for "& vs &&", 
obviously :)

> We defined partially_mapped as a bool(_Bool). IIUC, "partially_mapped
> = int & int;"
> would work correctly as well. However, "partially_mapped = long &
> int;" might not.

Implicit type conversion would convert "long & int" to "long & long" 
first, which should work just fine. I think really most concerns 
regarding the bool type are due to < C99 not supporting _Bool.

Great weekend everybody!

-- 
Cheers,

David / dhildenb


