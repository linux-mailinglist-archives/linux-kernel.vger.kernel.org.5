Return-Path: <linux-kernel+bounces-38251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A183BD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BC128184D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1B1BC43;
	Thu, 25 Jan 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gv2BWlCw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A01B950
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174540; cv=none; b=aI7jKeNM+I5uWTP7GTPIE8zr5NV3t7AXZWBO8nEg/aisqmwL5AB/+pz9Hr26ZJzPpbAlUAs5hqHogl4LsNxyD2RyOt5g8XUk/imc2JmlpWKPr8u9GSJQOQnHuKXnsJnQBZDA0XNQXCE8nHoUdEdiFf0uk9ycY8MJY7F8wOpYBzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174540; c=relaxed/simple;
	bh=P8jkz0p8wQSW1yJvPtT836sTVUOHTFaKdLXLUCPvC0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzozVbHEwlAHvbK2Mb4l1booxt7hYq2EFv6VK3VBVk4wBeVRV1ZwTgY/0EbDnYiY74eQ6ZpWaReiHiq7L8sXG9Ces9X2W2ob1wQLwJaWbsTCRA/J42A6+Wq+AVAEbhNIJ34iwJnC9wDt8W3LJ9KxA8GgZlZCrcBGrypUoiFh3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gv2BWlCw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d893950211so165475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706174538; x=1706779338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rq+n81SPFVBRVsOq1GkIa0O+TpyvfNFLv7fPMxY8cNU=;
        b=gv2BWlCwHWgY3Lisw3jKSU/HmdH+mRm6x2uJR2vEGWf8GPUoQSnG+tyKjYqrtNa1eY
         MBbtbO/k/i8BlfjGfjCl5KvySdG9ja13hdxrKK+ga9YY24pqdoZY3Hp4Zz/VVq4ghChh
         0tiLjfTugv/X3a1vvnR5Kc2lgD7WfpvP/XpmAo0Nwz19QP4dODZMV2+XYj21cAGAMLxh
         Dr7l5Od9jHPPTugYBTAiT4AUQryJyBwpl83vL6db6DobSkN1Qa0d/qmWTBlFRsnb7Buz
         Wx4S8VJf68CC0lrBAWJ3md2lf70glDbXyUyg7IrnTO62ThHH0sRtzE3QlnpSQH2D3Zaz
         18mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174538; x=1706779338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rq+n81SPFVBRVsOq1GkIa0O+TpyvfNFLv7fPMxY8cNU=;
        b=NeXASVa71JtZ4BRVPO5YHMOTSp3/WP4D3CqmfMMf84kMDCXnJ/nqnySz4bNxdgk3fB
         VqUkNVy8puMjJjXgpJMI/PCll9LEy7yHLPCoZ19NPBqKRw3XUjsjBL7+9hS76DcakVFO
         WR/eLR/U2g4gR4pxqyQsbDN2aRdvx7Bbp0uatqRQZ+NaUvwdSLBA1PHy+MOp8o3a+CUL
         jERQA7pMHQnvbFbjKWzz25GVMchrsxJbDbAas9x6ZsvDBtNbBB8wl37aGM6cQqRWyaMC
         kLES1W8erPzAEkpS5WwJEh18nvkFI37h+kDZ96zR5OipdfSSUPHidsLUxHdNhztuzOzl
         WJeg==
X-Gm-Message-State: AOJu0YzuriW6Gds2Y95orD9aDkp5340ECLdyhemHIHifQk6n+CJSpLqg
	51K9gSf6cRuvz/O0+gFBNB4BHFI2L4fDj+qOd6sOkQSNsO9Xod38/I0knbVMsHc=
X-Google-Smtp-Source: AGHT+IFQhOc40F1lW2QjAs6bYcA2acCY8Wc8ukNCbhIQYDrjBJLwkHKymF0NX/i1Wa4iZS8mLSBy9g==
X-Received: by 2002:a17:902:ea94:b0:1d7:91ae:6dde with SMTP id x20-20020a170902ea9400b001d791ae6ddemr580819plb.13.1706174537732;
        Thu, 25 Jan 2024 01:22:17 -0800 (PST)
Received: from [10.4.195.141] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b001d7859ea961sm2237083plp.272.2024.01.25.01.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:22:17 -0800 (PST)
Message-ID: <1a8a513f-fa84-41ca-b7f4-62726e78fd31@bytedance.com>
Date: Thu, 25 Jan 2024 17:22:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Content-Language: en-US
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
 <1496dce3-a4bb-4ccf-92d6-701a45b67da3@bytedance.com>
 <CAJD7tkbrQw7FWx-EDKKCtH_E03xEd5Y+8BqRjE8d29JSOCGybg@mail.gmail.com>
 <35c3b0e5-a5eb-44b2-aa7d-3167f4603c73@bytedance.com>
 <CAJD7tkak+ZA8t+AVbYNXYWnrmVBBs=NfMTBQBsnHJQni2=gG2Q@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkak+ZA8t+AVbYNXYWnrmVBBs=NfMTBQBsnHJQni2=gG2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/1/25 17:03, Yosry Ahmed wrote:
>>>>>> The second difference is the handling of lru entry, which is easy that we
>>>>>> just zswap_lru_del() in tree lock.
>>>>>
>>>>> Why do we need zswap_lru_del() at all? We should have already isolated
>>>>> the entry at that point IIUC.
>>>>
>>>> I was thinking how to handle the "zswap_lru_putback()" if not writeback,
>>>> in which case we can't use the entry actually since we haven't got reference
>>>> of it. So we can don't isolate at the entry, and only zswap_lru_del() when
>>>> we are going to writeback actually.
>>>
>>> Why not just call zswap_lru_putback() before we unlock the folio?
>>
>> When early return because __read_swap_cache_async() return NULL or !folio_was_allocated,
>> we don't have a locked folio yet. The entry maybe invalidated and freed concurrently.
> 
> Oh, that path, right.
> 
> If we don't isolate the entry straightaway, concurrent reclaimers will
> see the same entry, call __read_swap_cache_async(), find the folio
> already in the swapcache and stop shrinking. This is because usually
> this means we are racing with swapin and hitting the warmer part of
> the zswap LRU.
> 
> I am not sure if this would matter in practice, maybe Nhat knows
> better. Perhaps we can rotate the entry in the LRU before calling
> __read_swap_cache_async() to minimize the chances of such a race? Or
> we can serialize the calls to __read_swap_cache_async() but this may
> be an overkill.

Also, not sure, rotate the entry maybe good IMHO since we will zswap_lru_del()
once we checked the invalidate race.

