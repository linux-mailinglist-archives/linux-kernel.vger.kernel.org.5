Return-Path: <linux-kernel+bounces-39445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8402283D141
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 090EDB26EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5441579DF;
	Fri, 26 Jan 2024 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z1evMuvS"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457A4C64
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227414; cv=none; b=bD1bp7BvkL+NUIvkyGyRrg7GHNzDulXGf3zXWJk0Fhcv6SoujcpN4C6Uc802T7T4akNhn5uzE0koH2Z0ylVpm/SzUDBFeACs3gKFojmUzrQrRyCgRHLjCCfgXte/Usvimde5EkiDBoVetq6KmQSQKwgVCjXln7JAILHhpWa4X58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227414; c=relaxed/simple;
	bh=+oZl9nCa0jrGbHT7ZgwkLevkP4KheotitPK5tEfxoHw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R3NuRxQj+uGIqgqqsZE8MMNEO8Kx/Qhy4x6WSVwk5H2Nk8LZYX1yWH2+xGfC9xds1Sb6vPxQi+3w4rTP3DE2CuazSA28UfeoulsPyVrSL+CuJuLb7n55BeQUVnmcMIh1ZAzsCrJzhAoDveICDU75Vmmqv9lVh00QvXWcr2u8xHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z1evMuvS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso86681b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706227411; x=1706832211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PxmwQQx+QSHW/+WXDZ4htMlCoOhe+bQjds0JhAYjP1M=;
        b=Z1evMuvSvMaJ+ZYO1tVVIGWmttCVbWVJ3PJR3PI1oYGTgUFi6ip+v9mannhwI9I4oO
         ZzoULa22fJBEcQXqbx+YuNtwfTF+FUStv6+6cqole6MMQdQpXIDBLRgLZfu9i1Ik8S/1
         YjkIclp4N4YARz6TY9HiBh/xNbiGyDABiaLmui50UVupRmz54si4nnytdeFsR73n9vDw
         uG9S5gewjpPDS62yXy3wlbyHquH8ZYF7ZBTZm03eXzE4y2quNSb6qIgt236QK+MYj7LT
         igFZqjNeD1k2G0cFlDhEPPdlq9Vgyn7tHDsTpzbkKa02HFgCDiP8SqPR7vZTNbHTYebv
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227411; x=1706832211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxmwQQx+QSHW/+WXDZ4htMlCoOhe+bQjds0JhAYjP1M=;
        b=XiZpARJEEp3n33UU4j4XkjGZO2dibnezr0HlATTtbwwbmO6bCYOZ4UybwJHDyM3qo/
         3zMP+/11UTWWjDIHhUjxn3kaZoD5lJzy3vJHU1EPaaND9NlsEKUdZ+oKkJlnAtA6LaLn
         XLYo4yoYmDHlpzGBNaGFYeUtO3olSESUYnmSSMol43qt6eEhFqdWstlDMVdv5dh6m0SA
         VL6xw9osI/oJ6baLOSAEFoAIscHrTTecJJYrgFLK2i/QsmcEJdEdSlN1/w7rA8Xfq6A7
         +JqK2zISqI0p17/GcHJLb8jGQYAsqjWdKcxIY0+fxPDX+fWLgT0ffMRE6VWKqCLas/WM
         ruDg==
X-Gm-Message-State: AOJu0Yz0YL2CnIF42unAw8Nk23xZCq4CX86ymcHH1145RumdYkKmzAhX
	ai2lOy4wQZHWyDFyRNo7LZI/8w74g4c5ycPu5oqFnKyng90vijAkhlx9Qk/DwVs=
X-Google-Smtp-Source: AGHT+IELPi9yoDY5vXHCroW1QKN22Vi48Q85+0EihCgqJf3uHuOK1O87+sqfDyiMSDg1lxI/WxD6WA==
X-Received: by 2002:a05:6a20:8917:b0:199:d6b5:247c with SMTP id i23-20020a056a20891700b00199d6b5247cmr440084pzg.87.1706227411593;
        Thu, 25 Jan 2024 16:03:31 -0800 (PST)
Received: from [10.254.148.65] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id ld18-20020a056a004f9200b006db9604bf8csm86665pfb.131.2024.01.25.16.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:03:31 -0800 (PST)
Message-ID: <f7379622-4081-4424-9353-289257cf8555@bytedance.com>
Date: Fri, 26 Jan 2024 08:03:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, Huang Ying <ying.huang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
 <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org>
 <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org>
 <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <f3fa799f-1815-4cfe-abc8-3ba929fcd1ba@bytedance.com>
 <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJD7tka6UuEuuP=df-1V3vwsi0T0QhLORTRDs6qDvA81iY6SGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/25 15:53, Yosry Ahmed wrote:
>> Hello,
>>
>> I also thought about this problem for some time, maybe something like below
>> can be changed to fix it? It's likely I missed something, just some thoughts.
>>
>> IMHO, the problem is caused by the different way in which we use zswap entry
>> in the writeback, that should be much like zswap_load().
>>
>> The zswap_load() comes in with the folio locked in swap cache, so it has
>> stable zswap tree to search and lock... But in writeback case, we don't,
>> shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
>> then release lru lock to get tree lock, which maybe freed already.
>>
>> So we should change here, we read swpentry from entry with lru list lock held,
>> then release lru lock, to try to lock corresponding folio in swap cache,
>> if we success, the following things is much the same like zswap_load().
>> We can get tree lock, to recheck the invalidate race, if no race happened,
>> we can make sure the entry is still right and get refcount of it, then
>> release the tree lock.
> 
> Hmm I think you may be onto something here. Moving the swap cache
> allocation ahead before referencing the tree should give us the same
> guarantees as zswap_load() indeed. We can also consolidate the
> invalidate race checks (right now we have one in shrink_memcg_cb() and
> another one inside zswap_writeback_entry()).
> 
> We will have to be careful about the error handling path to make sure
> we delete the folio from the swap cache only after we know the tree
> won't be referenced anymore. Anyway, I think this can work.
> 
> On a separate note, I think there is a bug in zswap_writeback_entry()
> when we delete a folio from the swap cache. I think we are missing a
> folio_unlock() there.
> 

Hi, want to know if you are preparing the fix patch, I would just wait to
review if you are. Or I can work on it if you are busy with other thing.

Thanks!

