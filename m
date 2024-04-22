Return-Path: <linux-kernel+bounces-153064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26438AC885
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C70280F98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284A4535C9;
	Mon, 22 Apr 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWitopso"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3832C60
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777000; cv=none; b=Gw5StI/ynnni5Mw9agO25zR3dz0/osdT6TMzKb3rlElaAhnL2643OLD5bBaaKNdzX7nFsPVqVJuUEQi6CCTtm02R4uyQNblHCYgHh72n6IkvMh3r0bXLsKLjYpdThq/VTt63PgoRkHIcdbqYEHBVoaXFORC9mEnrsll1yNIMD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777000; c=relaxed/simple;
	bh=z2nE+vxm4z+0y30mt+F2gBSosy9BgCjH8KeavwHv+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNV/suuvo4dpm7SiKsMkPlFvHJCJkh4mNdC+I2kdNHVFvWNcxTX4jFMTx11o+/PUrTfMaARJMe+CfnORZ1v0DP7O6GJPXGfsaGKmy9jGBcb64GDj+cJ4vNNRvAX3fcQ29Wwoy25ILkYolKfmF7ZtGSkEn9XWC154/QK0/KoTB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWitopso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713776997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jPrpW76zmoMcet4ts7Mcq0G5yVz2e8Ls/phfxBbKBQU=;
	b=ZWitopsoR4RQrbuqqCCDk9wDkjpavlgxanCjVwuRxJTwrOnBf7wyjag0kqJjjTFRswoQWk
	yV5YnAGFcwMNIbjH5fniP88KAizpWtk5FyevNFSGLPYM+3sUnQDxGbbpwfxCA+lhOOql/K
	Fhf7zFtumxIuTtwPd4WRjIB6450cQwo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VN0izfZtOtimbSh67eVDIw-1; Mon, 22 Apr 2024 05:09:56 -0400
X-MC-Unique: VN0izfZtOtimbSh67eVDIw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d87f5937fcso35500011fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776995; x=1714381795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPrpW76zmoMcet4ts7Mcq0G5yVz2e8Ls/phfxBbKBQU=;
        b=NpZdRekCzgYbQK4asnwtaQT9rwmynbnHIr5PMAtavhXsKwoyR3YliBTNJSDBHVYYmn
         FmKO16q+tZQMRiP0yZwQA93jti5rGQjmw4uhhB36EFuU2cFCV4CB3xiMuyYyAuvJGCOU
         sH9p+Xdq+YSRgTMaZJAD6yvYaABmUB28iV+lO6uSswvL0CM5vckYgTJpPA2XW7wSJ+A+
         9wMOpKIlun13aLrKUu67497MDa+PwPzqO5PO7YE0fdNKyJvBJZvmhmCch7A6XiBXj+r5
         /AZajPyjCzZKRf7NEudawKbp7co0y5YJ804Uf/bMGvn/SARRxFtZH3o5hRtEAj7Nlg6O
         S/Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWafltFgkuz3154/bG4MQTK8dMUgDO+VUvGfCsPe//a4qKW8fBPlEIb4OZzFKUipcRqbzFea+BACyaLBCmx2Av4crpTdT7M01B3O6At
X-Gm-Message-State: AOJu0YzIvsrcVsZCUIjAHun0weWMtEjNUWqt7GbGZpdgyleP2poTiHJi
	v9dFCc19xzk+Kxl5G+nSHAEHouFhMvdNuVsx1P8M64s8I0XvyqM8kJRJIsmTULCUhfUj0CArPNa
	T5nBARNSv5xSTx8oYSS5PyVinNR1Dry/Kj6hJGO+vYWTiii9hiPl1YgSkijmfAA==
X-Received: by 2002:a05:651c:1a06:b0:2d8:8b44:8ce with SMTP id by6-20020a05651c1a0600b002d88b4408cemr7539294ljb.46.1713776994762;
        Mon, 22 Apr 2024 02:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYGdb2JfDgXUyhaukwTa/RvYLRmjHY6G3d0aA9ciHGkOqy9/rMM0nIB5E8N2UXm6TDzYEVZg==
X-Received: by 2002:a05:651c:1a06:b0:2d8:8b44:8ce with SMTP id by6-20020a05651c1a0600b002d88b4408cemr7539277ljb.46.1713776994322;
        Mon, 22 Apr 2024 02:09:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b00418db9e4228sm16013913wmg.29.2024.04.22.02.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:09:53 -0700 (PDT)
Message-ID: <17615a07-f9fb-49bd-ad56-df6691c3d362@redhat.com>
Date: Mon, 22 Apr 2024 11:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
 <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
 <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.04.24 10:04, zhenwei pi wrote:
> 
> 
> On 4/22/24 15:47, David Hildenbrand wrote:
>> On 22.04.24 09:42, zhenwei pi wrote:
>>> All the VM events related statistics have dependence on
>>> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
>>> VM events in future, we would have codes like:
>>>    #ifdef CONFIG_VM_EVENT_COUNTERS
>>>         unsigned long foo;
>>>    #endif
>>>         ...
>>>    #ifdef CONFIG_VM_EVENT_COUNTERS
>>>         foo = events[XXX] + events[YYY];
>>>         update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>>>    #endif
>>>
>>> Separate vm events into a single function, also remove
>>
>> Why not simply use __maybe_unused for that variable?
>>
> 
> 1>
> static unsigned int update_balloon_stats()
> {
>       unsigned __maybe_unused long foo;
> 
>       ...
> #ifdef CONFIG_VM_EVENT_COUNTERS
>       foo = events[XXX] + events[YYY];
>       update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
> #endif
> }
> 
> 2>
> static inline unsigned int update_balloon_vm_stats()
> {
> #ifdef CONFIG_VM_EVENT_COUNTERS
>       unsigned long foo;
> 
>       foo = events[XXX] + events[YYY];
>       update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
> #endif
> }
> 
>   From the point of my view, I don't need to compile code in my brain
> when reading codes for case 2. :)

But for #1? :)

I mean, you didn't compile the code in your brain when you sent out v1 :P

But I agree that moving that to a separate function ins cleaner, staring 
at resulting update_balloon_stats().

Let me comment on some nits as a fresh reply.

-- 
Cheers,

David / dhildenb


