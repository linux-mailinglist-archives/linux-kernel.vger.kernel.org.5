Return-Path: <linux-kernel+bounces-153285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EC98ACBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F07C287B82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40791465B0;
	Mon, 22 Apr 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpBEHhBZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC614601F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785087; cv=none; b=YaQGIHrZSW/zrlfuvCQYBcoADhWfBa/oL9zx/+Q3dl75r3S+rdoMzCufdlGpEr0s+ui5p87pOlJNj2lgExz9GQhT3RRrtVu5/P0KAY8yHpZymCSWQylrfTJgmuo0mhXhB5LywMfDwzYN3prKfwaaK5syLVreRsIY8QBYank7sWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785087; c=relaxed/simple;
	bh=lesur2DtlpG36U+RDatGEe3Kz31u61I145L9zgoURGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hF3LvKzWuvnzkGPq5YDdz9QYDdBS2QTTudeCZdZXH7w4UYILA7X3FhtEPznbpz8xLQSvVArsAzYmcf+OY1IX2KfomYB74HoyojgqquzGYSziSMswjhhMkYVAPubiJfupKjRU4cLQf+VSBeE8RkP0TNvWcFr54xxu1faZ+fdAd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpBEHhBZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713785084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZoxPNt1dowIJ1Aw5Ufzxc0rTMxsMvYDFAtprWf/W5gA=;
	b=KpBEHhBZoba9zDsArq/DUCjwygXZFo3rISY33KiAszR1opjExxFOKtkDzHADHc6XbPrhQv
	3542kIvopNeWFhEaw5yPuIckoEWhR/33YIWU1dNWhSOB+tQQqLIpzjtgFtV8GUi19aA/Fn
	9CH50KY1Q0TlLQx8cF9qJb311nkboNI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-yuL1Z-60OZiwdIqje4MB0Q-1; Mon, 22 Apr 2024 07:24:43 -0400
X-MC-Unique: yuL1Z-60OZiwdIqje4MB0Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-419f572bdbdso5300535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785082; x=1714389882;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoxPNt1dowIJ1Aw5Ufzxc0rTMxsMvYDFAtprWf/W5gA=;
        b=RDYJ6Prc05vyrfz9+uzyhaKFTpSFJAmnYSHcozyAtmOVRVAwxn9ZVw8y4aASRksUe6
         byqT9KXFqZc47LW3WBPzleFzWMfXzmI4c6bSS6yl3ByDuZoBZA9d0YI6Ka+WMNylaW4z
         E1W7QYh0gUWFFiSNeYdjjtSPLmOGVS4l2t2Ias3t1eN8Jr/Vs2ae8T4M7fl1GQaT8W43
         CqwUfLJ2pPEiSR9IZMWhjG9nZ1fILRikBhUACBhqdTrFBkw+vAZhN/lTaXLzbU6wicgN
         Kubaa6VljgIeGtN/npiy6EUbAxvOpBoxkVw9wSFLIr4hjU/j6tOSqIrZooJm8rfs9Q3T
         /T3g==
X-Forwarded-Encrypted: i=1; AJvYcCUi3/Llrum+3+ghw8K3i0uVMBTk0txKimgp2UTggwqpvlT9jiHf3AIaMwYCb/eOd3Ienx2q2uKFyOXkoYeXYnO2e2a58p+NAafGeCwc
X-Gm-Message-State: AOJu0Yyrqd9j2xbK1dqV2MSzhrSq5SaeSV30/jd9833YvHgCHKpDwhZ/
	EjJwgzn+m578+gDMd8eni9fZgB59S0CIoiGPznP2zsWo7X441YzJYEW0JF9GsH1tEH1dVTFWbZR
	qoEwtvGYT/+U4rdTjD+ZjJhayY1rUtXmiqfFQwHBuKr1s8gxR8mL1oHawwavE7w==
X-Received: by 2002:a05:600c:4447:b0:41a:385:508d with SMTP id v7-20020a05600c444700b0041a0385508dmr5432669wmn.9.1713785081927;
        Mon, 22 Apr 2024 04:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh9EIiwBXQJpTfuuzTfXU4dKFUKefFnFnDT/8//OspOgbFrMryDb12cQN3J2V5j0SNci/kLg==
X-Received: by 2002:a05:600c:4447:b0:41a:385:508d with SMTP id v7-20020a05600c444700b0041a0385508dmr5432655wmn.9.1713785081555;
        Mon, 22 Apr 2024 04:24:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm11733502wrw.26.2024.04.22.04.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:24:41 -0700 (PDT)
Message-ID: <b848c431-deca-42e4-925c-673b3fa1f251@redhat.com>
Date: Mon, 22 Apr 2024 13:24:40 +0200
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240422105212.1485788-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 12:52, Yajun Deng wrote:
> page_table_lock is a lock that for page table, we won't change page
> table in __anon_vma_prepare(). As we can see, it works well in
> anon_vma_clone(). They do the same operation.

We are reusing mm->page_table_lock to serialize, not the *actual* 
low-level page table locks that really protect PTEs.

With that locking gone, there would be nothing protection vma->anon_vma.

Note that anon_vma_clone() is likely called with the mmap_lock held in 
write mode, which is not the case for __anon_vma_prepare() ...

I think this change is wrong.


-- 
Cheers,

David / dhildenb


