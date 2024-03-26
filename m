Return-Path: <linux-kernel+bounces-119043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62588C310
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5001C2CEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4A71756;
	Tue, 26 Mar 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae3colTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0272A5CDE7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458724; cv=none; b=sj6ipwdxxx7rmVAS9Y5krZ/sPxj8g4ry6b/EJX7pvDykhCwNMLDlwENtCBltmDhoEa94fbnhNI02h4hCJsbu8p4gyJ/qREE93Gi6VpABH/VGegwIhGcUz6eBMmri0baUnRDviO3aFgBhqzHcecwp2lCJLMVSUS0J9ekt9LZHfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458724; c=relaxed/simple;
	bh=L1CC80wvbfPihajVobuY15lHbNslUhbwAc21XGQWkVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uLZrM9i8S4GMIZECRmMnxbSAck6We7takUCtebg5Y/tOB3lq3Lz/+mwGNMsj0lh1m1ygJfH3S6Kdszg6i8g06xcKIhc2V2SVBTxZ8kahirM0+n1mpzNTy6TLaMSe5IB/JVytOR3AkdL8BlMtX8Iit5E1mnZK+lWB/bNCu7VBzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ae3colTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711458721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SstXmpRLl6U15pJ2YX9fo4k0mTXmFDcpuWk8o+l4dcc=;
	b=ae3colTsL6fN3MRjfhqBrCkSPawrwq8hjPTBE3/rVbwgKmre60SCxShp/Pk/QS9lDJ2FaY
	WWS70kvu3PzmQiIxb5QoqFLUZlgm8EbClgesOgBWaDzhyudW2awqzXWUbt4ZkZI6B+aHS6
	Wfhr7GJS2rHUHzHOUTP0D/K6SnfQHFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-26MH97WWNqSe3E0PzZRRGg-1; Tue, 26 Mar 2024 09:12:00 -0400
X-MC-Unique: 26MH97WWNqSe3E0PzZRRGg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41482ca91b9so12269645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458719; x=1712063519;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SstXmpRLl6U15pJ2YX9fo4k0mTXmFDcpuWk8o+l4dcc=;
        b=NcNLfon44+Y87/IRs8XSXhBTfzY67RJpj2rpKxvRjc1p86CEh4jfcGpk7TWamdskau
         SYX5x9h4eOPBSvwjXbulRYpZ/DoIDNFtK1LsWEvnbckQDYqCWuYQmrLPEJGZio+AkBC3
         oiEmG9sEvD6uKjoQnAIsNfOiRmkeop2214WMf3rvHLXG9GQIZ8tizib/ih6WKK/DIWaZ
         D9Mk7XsELr4StggjbpiaGZw7yWaPmgT1m+dsitC2B2PlChHbeT6mNMo5hhlQxG03XrLP
         bVUOuzay9eQBJs/Y6gRAVOhlqEOo/XbjfbqnArK8wbaZ31V0TGL5O/fPWAL924AqDuoR
         0lrg==
X-Gm-Message-State: AOJu0YzodM1DQKAZQfH4aWLBdXzvhEgf51UaYBCjFF3ZenCr8t+PT4Qr
	M1YegGGA+iotmRC5xSI77GxIE91nuESpMdUYqGdZ3tjr7asqoDcuEnVQRviB0+WZEGagaKk/k9q
	AAPaMI1kSp3tm/Fvi39mf/+88JqvAkYNjncJomT7pKkGJYH7MkAUc3DZ+I3JW7w==
X-Received: by 2002:a05:600c:21c7:b0:413:f3f0:c591 with SMTP id x7-20020a05600c21c700b00413f3f0c591mr9111581wmj.41.1711458718698;
        Tue, 26 Mar 2024 06:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDxMAqmH2tBl1eEu7r4nPE/sVz/hybBa3idj9cGsWkq/6yQGLJIRQWGESLrY5OPr18pYLEg==
X-Received: by 2002:a05:600c:21c7:b0:413:f3f0:c591 with SMTP id x7-20020a05600c21c700b00413f3f0c591mr9111558wmj.41.1711458718252;
        Tue, 26 Mar 2024 06:11:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d62c3000000b0033ec94c6277sm12096327wrv.115.2024.03.26.06.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:11:57 -0700 (PDT)
Message-ID: <15117d1a-a03b-4ad5-9900-4c968212137f@redhat.com>
Date: Tue, 26 Mar 2024 14:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] selftests/memfd_secret: add vmsplice() test
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
References: <20240325134114.257544-1-david@redhat.com>
 <20240325134114.257544-3-david@redhat.com> <ZgJol_hwpoTwaibB@kernel.org>
 <baafcfbb-f767-41fb-b2de-1367991d073a@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <baafcfbb-f767-41fb-b2de-1367991d073a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 13:32, David Hildenbrand wrote:
> On 26.03.24 07:17, Mike Rapoport wrote:
>> Hi David,
>>
>> On Mon, Mar 25, 2024 at 02:41:13PM +0100, David Hildenbrand wrote:
>>> Let's add a simple reproducer for a scneario where GUP-fast could succeed
>>> on secretmem folios, making vmsplice() succeed instead of failing. The
>>> reproducer is based on a reproducer [1] by Miklos Szeredi.
>>>
>>> Perform the ftruncate() only once, and check the return value.
>>>
>>> For some reason, vmsplice() reliably fails (making the test succeed) when
>>> we move the test_vmsplice() call after test_process_vm_read() /
>>> test_ptrace().
>>
>> That's because ftruncate() call was in test_remote_access() and you need it
>> to mmap secretmem.
> 
> I don't think that's the reason. I reshuffled the code a couple of times
> without luck.
> 
> And in fact, even executing the vmsplice() test twice results in the
> second iteration succeeding on an old kernel (6.7.4-200.fc39.x86_64).
> 
> ok 1 mlock limit is respected
> ok 2 file IO is blocked as expected
> not ok 3 vmsplice is blocked as expected
> ok 4 vmsplice is blocked as expected
> ok 5 process_vm_read is blocked as expected
> ok 6 ptrace is blocked as expected
> 
> Note that the mmap()+memset() succeeded. So the secretmem pages should be in the page table.
> 
> 
> Even weirder, if I simply mmap()+memset()+munmap() secretmem *once*, the test passes
> 
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> index 0acbdcf8230e..7a973ec6ac8f 100644
> --- a/tools/testing/selftests/mm/memfd_secret.c
> +++ b/tools/testing/selftests/mm/memfd_secret.c
> @@ -96,6 +96,14 @@ static void test_vmsplice(int fd)
>                   return;
>           }
>    
> +       mem = mmap(NULL, page_size, prot, mode, fd, 0);
> +       if (mem == MAP_FAILED) {
> +               fail("Unable to mmap secret memory\n");
> +               goto close_pipe;
> +       }
> +       memset(mem, PATTERN, page_size);
> +       munmap(mem, page_size);
> +
>           mem = mmap(NULL, page_size, prot, mode, fd, 0);
>           if (mem == MAP_FAILED) {
>                   fail("Unable to mmap secret memory\n");
> 
> ok 1 mlock limit is respected
> ok 2 file IO is blocked as expected
> ok 3 vmsplice is blocked as expected
> ok 4 process_vm_read is blocked as expected
> ok 5 ptrace is blocked as expected
> 
> 
> ... could it be that munmap()+mmap() will end up turning these pages into LRU pages?

Okay, now I am completely confused.

secretmem_fault() calls filemap_add_folio(), which should turn this into 
an LRU page.

So secretmem pages should always be LRU pages. .. unless we're batching 
in the LRU cache and haven't done the lru_add_drain() ...

And likely, the munmap() will drain the lru cache and turn the page into 
an LRU page.

Okay, I'll go make sure if that's the case. If so, relying on the page 
being LRU vs. not LRU in GUP-fast is unreliable and shall be dropped.

-- 
Cheers,

David / dhildenb


