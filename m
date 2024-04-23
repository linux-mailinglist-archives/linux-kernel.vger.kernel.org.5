Return-Path: <linux-kernel+bounces-154670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC68ADF92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10571C223F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA6B53372;
	Tue, 23 Apr 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPRIOi2o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD782B9CA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860311; cv=none; b=AljTAjE5A1K/vEqAP8kz+CPZL8PBAu4994WMJ26XRjHoPt/qTc6xcr2E/mcXAZDwDSc2zpK7c3ci5t35ae+9t7CZdYEViADU1a2xBtAsmFvSmVSB0WpRoTvFViQfunGWYMSyJnKJrwChPQB4i+RlJk1FCh7c6btHjORUuzFBPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860311; c=relaxed/simple;
	bh=E3KFivfU6QY0Qj032tBJ0pAIseVEZH+xWGXpdC3bd4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o50+KHuZmm9fI/ne8Jv5KE1SYt1Dpl8xCZQlJnygigZvrB2TMS16c+Io4xTogorpGaE0HRGOmXMPdY8pFpsBwGqzTp/C4vhM7Yae+CNeOWpRFvGil0GiCbsnLM1hNx6JYtzbOkT/4srK/8rOhPKGC90YpBR8XMKbQ54vigb0DQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPRIOi2o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713860308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nKmA8p7uCLiABT1KL01MYSvGIcma82TxCwj73BB+tcI=;
	b=YPRIOi2oFf8P3wCvSGPOYoZWB6yNqO4K2f6ygGeBeyYWnC1T08qzP1LaZ/pSqY55bSSHaU
	FBzR7h+sSvfQr0rvKNKED5o/S+B0FHCok5Cw1kfQeGAIqethNB2/8Ssdgtx3uvkP6bHHH1
	BoP3dqUmwmoUmaOLsn+AQGcWA+aIkww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-koF1WBfXNyWE-ILe7N0pTQ-1; Tue, 23 Apr 2024 04:18:27 -0400
X-MC-Unique: koF1WBfXNyWE-ILe7N0pTQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-416e58bdc0eso22207155e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860306; x=1714465106;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKmA8p7uCLiABT1KL01MYSvGIcma82TxCwj73BB+tcI=;
        b=JGOZ2/7rgqWZlks+InTiHWmDfVXNFWXmkH0Xg5pE0wRVfuIFcwkKVNyMoP+uORMyec
         FCJPXOcLGy2caMpY2qOYX1hmZ8S8aivedVOI7mZAkBH74TekKMMfC9iNCvfAp7IKBzh7
         MVAwWzfJ0svcuZHBjr60lInuy0gL3VcgWpKHb/dlmYsnBi+8DfYrXtuYZ/RmCsSi0NAg
         RlEiR2i1qUiSmSl5TpbEYA9YT92sK6gidjg5Zin+2soY3PjxGpqb4UAlQ4WcqdAMD0sS
         jLu8FBLOw14AZLrN8W/di7/+IRUU6AmUdo9PlvRiaPP+KjO3eLihCtQUlozCIQxUgwI4
         FU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX29Vd7JDT1RXi034Wha4rWxcRxAizbLfqIBR5NyRyYdp0bOqMDYKa+7LkKHOJF45YkPi8Oh0/TXdfEamRkyaXu0jzJykTfOaQN8ony
X-Gm-Message-State: AOJu0YzxzhcIB7YKaLHVyV3wqRFV7pKJDHo4yBiisvhiNc+fIITbf9FW
	YEe6ifr4jAOghGlXhVs4Yt89ul4bPBCl4CrrLeXdb/yiiTFiEi0PNoKXnhD3wDF7fRtXXvXPZRJ
	PWS4rsvoIIOnjNe2tIp5Btkje0TUFfFIVWTPT8M8gqw+Avy7/HhP+ZYVIZgK+WSrvefeWPQ==
X-Received: by 2002:a05:600c:4e14:b0:41a:aa6:b68c with SMTP id b20-20020a05600c4e1400b0041a0aa6b68cmr5671155wmq.6.1713860306039;
        Tue, 23 Apr 2024 01:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8/xqWXfMSCcvbh5TY348esVfwz5Q7WzNQS2PAI76Huxg7HLgMc10MMEgzR1epA3rJFeyuBA==
X-Received: by 2002:a05:600c:4e14:b0:41a:aa6:b68c with SMTP id b20-20020a05600c4e1400b0041a0aa6b68cmr5671131wmq.6.1713860305542;
        Tue, 23 Apr 2024 01:18:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c3b8600b0041892e839bcsm19431208wms.33.2024.04.23.01.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 01:18:25 -0700 (PDT)
Message-ID: <fd7fde90-21ea-4617-be17-ba387b44feaf@redhat.com>
Date: Tue, 23 Apr 2024 10:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: remove unnecessary page_table_lock
To: Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240422105212.1485788-1-yajun.deng@linux.dev>
 <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
 <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3c452d5db5b3d5879160ab62a9e0ac4481a6298a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 09:53, Yajun Deng wrote:
> April 22, 2024 at 7:24 PM, "David Hildenbrand" <david@redhat.com> wrote:
> 
> 
> 
>>
>> On 22.04.24 12:52, Yajun Deng wrote:
>>
>>>
>>> page_table_lock is a lock that for page table, we won't change page
>>>
>>>   table in __anon_vma_prepare(). As we can see, it works well in
>>>
>>>   anon_vma_clone(). They do the same operation.
>>>
>>
>> We are reusing mm->page_table_lock to serialize, not the *actual* low-level page table locks that really protect PTEs.
>>
>> With that locking gone, there would be nothing protection vma->anon_vma.
>>
>> Note that anon_vma_clone() is likely called with the mmap_lock held in write mode, which is not the case for __anon_vma_prepare() ...
> 
> Yes, anon_vma_clone() is called with the mmap_lock held. I added mmap_assert_write_locked(dst->vm_mm) to prove it.
> I added mmap_assert_write_locked(vma->vm_mm) in __anon_vma_prepare() at the same time, it shows __anon_vma_prepare()
> is also called with the mmap_lock held too.

Make sure you actually have lockdep built in and enabled.

__anon_vma_prepare() is for example called from do_anonymous_page() 
where we might only hold the mmap_lock in read mode (or not at all IIRC 
with VMA in read mode).

-- 
Cheers,

David / dhildenb


