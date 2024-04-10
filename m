Return-Path: <linux-kernel+bounces-138957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E389FC92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F177E285CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0A179674;
	Wed, 10 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffLONZrm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0B417167D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765562; cv=none; b=ENdeOXR6+m+8zcIcn8yCYk4EodCeH8ncib4+fRckh6V1rXYANGzY86CDibb/pf3pjqkIz2jtgHN3xK8Zq/byxykxsa9EvxKHQK4i2+qBMEp3wIJaS01ZuJuJ/tjKCseeKIusvB13SX3C3gyzXZ/7gsrbZUdI1yypgth9NdCzwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765562; c=relaxed/simple;
	bh=794KF9w457dqd3eHPMTyEvUxPpMn9q7a+mLANod5Fls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEDK/34bSj/3s7vB/hjInfr8GdgPPqio9DqxgaYp4BFpFQGo4nwApue70+P9M+udjBqaCyapoKfQZ+kJM1DvRswtjBWpBjatVYnNJg/WNz092+xCUbCTFuP+GmOjhZLrRp62JR23iXAf3hNkjGSZCWIjRsOgrgptzgphdTp2JYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffLONZrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712765559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f7FP/l1Gy6GyZwXpdkI/8cvwIrZ9r1QtpZsT0aPCF0w=;
	b=ffLONZrmYF0eMSRLNFwkNrWDtWiiWgzHkZwBzgnP1BW32fK3cNU/X23cUxTOofaEhpwx8r
	6R3d8o2czsLiZvThRABnOK3D3MnfD/iWXsrwFvdqQJBM6E3P/71WsPQoOFPkwEBYEfinEv
	SHs+1j/lKtWuQQdNsT5QOfbclIHTs38=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-VmUHzf5yNliqDciHUXFokw-1; Wed, 10 Apr 2024 12:12:38 -0400
X-MC-Unique: VmUHzf5yNliqDciHUXFokw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416aea853e3so7894095e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765557; x=1713370357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7FP/l1Gy6GyZwXpdkI/8cvwIrZ9r1QtpZsT0aPCF0w=;
        b=e7ZQ1TpKJq4ggnARvQprGMO+tELMLX0PWr/kWA1p+c6lrFE2VckFHVF4CNcAHWrCFJ
         e7HjuFFZXXsgtseLH8TQqgmKjRb/vWgLiHRxQrhDGEgQLiQzRY+TStqfec/ELsrDJjR9
         raVlKc1GaB+aU8riy/ZBYHwXD3rZ5fcYvl4FeAs673CtQu5cOlE3njdJFIf32SM98NRe
         4wSywW9Et94U62SoUptGvBR4U1+4jueWJHzhmiSnkHyvjrqtctSS/2uCXk13CbTT0601
         00Mgdo/bQEr7Ew1f6kIkxb+ngZvrtxsNte9K4IBJc3JRCYg2IRJE48UdmFoCIHIPWJDw
         dQag==
X-Forwarded-Encrypted: i=1; AJvYcCUnYKttmbIsgpEdJZlkgzyQf0vWs8vAiIBOQF83U+hSJwY9qW9A2bpfDn3DSXcR6yXwRahJ8BB94ugvn0NZhZa6W6YEvOhuOcpKw7lw
X-Gm-Message-State: AOJu0Yy7HCqb6MKGk0tPEw+82xYej2N4x6w9gcLEGdb7f94QpLxG1ccH
	YUwwYYcHjgEXJ36M5LoWcFeayIvChvzrs6Kv47MY4UwpbQoeJcGGsi73aHiY6WW9khyo6azk4JI
	gujbWplHBi4ZgGkqA0ARMtVoa1U0VLhC2Ud+fdUgfY5WRzeUmq6mxaF4lMhctDg==
X-Received: by 2002:a05:600c:3b98:b0:416:2629:bbaf with SMTP id n24-20020a05600c3b9800b004162629bbafmr2517072wms.29.1712765556908;
        Wed, 10 Apr 2024 09:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuJ6so+k9TVfWmCgQpetPISc9WsH7SnUYO1ZVQEGdIuP8sQQ8FoiOwj93AFq860YsfreenKA==
X-Received: by 2002:a05:600c:3b98:b0:416:2629:bbaf with SMTP id n24-20020a05600c3b9800b004162629bbafmr2517045wms.29.1712765556521;
        Wed, 10 Apr 2024 09:12:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b004148d7b889asm2704218wmq.8.2024.04.10.09.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:12:36 -0700 (PDT)
Message-ID: <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com>
Date: Wed, 10 Apr 2024 18:12:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent
 hugepages
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hughd@google.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 iii@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 18:07, Sumanth Korikkar wrote:
> On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
>> On 10.04.24 17:26, Sumanth Korikkar wrote:
>>> On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
>>>> On 09.04.24 17:54, Sumanth Korikkar wrote:
>>>>> In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
>>>>> compiler might choose to make a regular function call (out-of-line) for
>>>>> shmem_is_huge() instead of inlining it. When transparent hugepages are
>>>>> disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
>>>>> error.
>>>>>
>>>>> mm/shmem.c: In function ‘shmem_getattr’:
>>>>> ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
>>>>>      383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>>>>>          |                           ^~~~~~~~~
>>>>> mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>>>>>     1148 |                 stat->blksize = HPAGE_PMD_SIZE;
>>>>>
>>>>> To prevent the possible error, always inline shmem_is_huge() when
>>>>> transparent hugepages are disabled.
>>>>>
>>>>
>>>> Do you know which commit introduced that?
>>> Hi David,
>>>
>>> Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
>>> -fPIC kernel compiler option, I could see this error on s390.
>>
>> Got it. I assume on Linus' tree, not mm/unstable?
> 
> It's not yet upstream.
>>
>>>
>>> However, default kernel compiler options doesnt end up with the above
>>> pattern right now.
>>
>> Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
>>
>> commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Wed Mar 27 11:23:22 2024 -0400
>>
>>      mm: make HPAGE_PXD_* macros even if !THP
>>
>> Which is still in mm-unstable and not upstream.
> 
> Not related to this commit. I tried on master branch.

Thanks! Can you try with Peters patch? (ccing Peter)

If I am not wrong, that should also resolve the issue you are seeing.

-- 
Cheers,

David / dhildenb


