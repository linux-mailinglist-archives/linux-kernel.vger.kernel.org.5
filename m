Return-Path: <linux-kernel+bounces-112033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02739887464
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815B71F22769
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67257FBC3;
	Fri, 22 Mar 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2s71z1L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5487F7E8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711142333; cv=none; b=Vde0o+c+/9Itm0InvdDF+z4M7UGWL8ewn+C9yvJI6jrhYWbwgKtmX2Aetq5PeKT39CfaQvRe034refX6M2crMh/lpMAxmKYfOkePP6eZhp7y3e7RAFHTSVFOZX2FMfZNSKzRjVSyEUALSc0/NzgkmTgTeF/2HN5QTR0K5HxGw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711142333; c=relaxed/simple;
	bh=r0vjMTkEVQepqDIPJERAvTidU+uwgO1d8AyWUu9t55o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXLaCeKHfu+SNBqYG6U6RqYrUIjHwyT8Drw3U/Xwv8S46zoLhNlMmifuuWUijFTmMiFgWnAIThNzQJN0CrsYbyXnJPcwG+2vA0x7mXAHS2tFvzZr2frvKuycvN9L9hp08fyrGoPJ8519hNxsS7iFZAJoYjZ2fyY6GIPPwD8xyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2s71z1L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711142331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2Rd3q7AAPEnNqvfSKCrvUs6o9q/lC1Y2spgfcB7+Rm8=;
	b=S2s71z1L28hWZdkC2Q6SdUy7dWRlLh7Qx79pZeEX96mzyd7pRm1lcbu69fZSmRje5kQPom
	lMu+aSwBAJXyhBZjZhSTmkFPBWQ04UqOn4Ae3a9Ghcp0jhU/sJ6L/wAHcQpgVddzgOkVfV
	Gva9y3mj+kor4JZfH4nk3UitMK4lZ+A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-pYDRjpnRNhetLm_QkJYvqA-1; Fri, 22 Mar 2024 17:18:49 -0400
X-MC-Unique: pYDRjpnRNhetLm_QkJYvqA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-414105984aeso13924125e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711142328; x=1711747128;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rd3q7AAPEnNqvfSKCrvUs6o9q/lC1Y2spgfcB7+Rm8=;
        b=Vy/JMj5QOj/7UErpnxMDARmIIAlKDJkzQ70HBoSOYsQDN79jgej6lgVjZ6kl/ni4bT
         q+ryy05B0hNkV4sevjaQB8J1W35vyVKYzqiNds0b+MOiLdc3cEMX2cotIC5XaJ+Rmeju
         bT+UAhG/XvosVjwx8VSc9S+uX0MPh9K5bPYVaJFlTyfgJ70ZY2ZM3u6ZXYvMiQFKBV0I
         KX58geHPhQDih3EYUuCRdo+y/cfRfq9OGmQXor7P3p0TafVQ3KmWQiQ4d8KrsyIjJBlM
         683bkVEL+p7hO99BpeFhfxdDhcLVb+G5QsKZ4A+ERvyMVwqYYtoE6vLJFaIJXwuJhufA
         aEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDYmebm95HSC4ewKj2/zp67poWxFL2Md4EFqiBoAaQzkNPvv6hgulHUZPkQNhz+mtYa8Sw7ey705Aq1oe3iTIQtpinsdzB0AeNEho3
X-Gm-Message-State: AOJu0YxZPWDBP00rzhYHmGgP6sDF0ObA7Q6X1hmm4ahbVje/bLF1OD3I
	eQAguITBRnXT7kG6Hm/TAGvMaOjXEuNOUmGVqN7l8YWVPQVpuQZzgQRUcTiio3DDHDis3Fr9MBO
	BHOBsvZO/hxqQSAlNUXxyDeMptXxfzc6rIDC9EM8/JhSDq4kleE4DktpSILSLxg==
X-Received: by 2002:a05:600c:3ba8:b0:413:ee35:55bc with SMTP id n40-20020a05600c3ba800b00413ee3555bcmr328250wms.37.1711142328438;
        Fri, 22 Mar 2024 14:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDIDCRlQPbvoR3GZpuszKOhZfB9gM5eJXA2dsoy0MjvQYtUXN4PkmWhlQyStxr3L7vtuUrBQ==
X-Received: by 2002:a05:600c:3ba8:b0:413:ee35:55bc with SMTP id n40-20020a05600c3ba800b00413ee3555bcmr328241wms.37.1711142328042;
        Fri, 22 Mar 2024 14:18:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71b:7e00:9339:4017:7111:82d0? (p200300cbc71b7e0093394017711182d0.dip0.t-ipconnect.de. [2003:cb:c71b:7e00:9339:4017:7111:82d0])
        by smtp.gmail.com with ESMTPSA id bh27-20020a05600c3d1b00b004141250b36fsm591517wmb.11.2024.03.22.14.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 14:18:47 -0700 (PDT)
Message-ID: <463612f2-5590-4fb3-8273-0d64c3fd3684@redhat.com>
Date: Fri, 22 Mar 2024 22:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, samsun1006219@gmail.com,
 syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
 Mike Rapoport <rppt@kernel.org>
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com>
 <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
 <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
 <620f68b0-4fe0-4e3e-856a-dedb4bcdf3a7@redhat.com>
 <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJfpegub5Ny9kyX+dDbRwx7kd6ZdxtOeQ9RTK8n=LGGSzA9iOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.03.24 22:13, Miklos Szeredi wrote:
> On Fri, 22 Mar 2024 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.03.24 20:46, Miklos Szeredi wrote:
>>> On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> But at least the vmsplice() just seems to work. Which is weird, because
>>>> GUP-fast should not apply (page not faulted in?)
>>>
>>> But it is faulted in, and that indeed seems to be the root cause.
>>
>> secretmem mmap() won't populate the page tables. So it's not faulted in yet.
>>
>> When we GUP via vmsplice, GUP-fast should not find it in the page tables
>> and fallback to slow GUP.
>>
>> There, we seem to pass check_vma_flags(), trigger faultin_page() to
>> fault it in, and then find it via follow_page_mask().
>>
>> ... and I wonder how we manage to skip check_vma_flags(), or otherwise
>> managed to GUP it.
>>
>> vmsplice() should, in theory, never succeed here.
>>
>> Weird :/
>>
>>> Improved repro:
>>>
>>> #define _GNU_SOURCE
>>>
>>> #include <fcntl.h>
>>> #include <unistd.h>
>>> #include <stdio.h>
>>> #include <errno.h>
>>> #include <sys/mman.h>
>>> #include <sys/syscall.h>
>>>
>>> int main(void)
>>> {
>>>           int fd1, fd2;
>>>           int pip[2];
>>>           struct iovec iov;
>>>           char *addr;
>>>           int ret;
>>>
>>>           fd1 = syscall(__NR_memfd_secret, 0);
>>>           addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
>>>           ftruncate(fd1, 7);
>>>           addr[0] = 1; /* fault in page */
> 
> Here the page is faulted in and GUP-fast will find it.  It's not in
> the kernel page table, but it is in the user page table, which is what
> matter for GUP.

Trust me, I know the GUP code very well :P

gup_pte_range -- GUP fast -- contains:

if (unlikely(folio_is_secretmem(folio))) {
	gup_put_folio(folio, 1, flags);
	goto pte_unmap;
}

So we "should" be rejecting any secretmem folios and fallback to GUP slow.


.. we don't check the same in gup_huge_pmd(), but we shouldn't ever see 
THP in secretmem code.

-- 
Cheers,

David / dhildenb


