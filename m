Return-Path: <linux-kernel+bounces-39450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27C83D151
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0916E1C23E56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C89464C;
	Fri, 26 Jan 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iUQvfhAF"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5817E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227821; cv=none; b=GcQWGytaN5uFEBxh3NgC9hUi8gb8vGkhIbYUoMMFKl+f4yH6VsltBYisF+yp/RhJzmyERUwWCtiQvdJUa1fmkHxAqEfkjmOSkVXuPrOeQap4zzm2o6u03OqUFHr4QOlz373Fl9Rch0FRUvXLU83H9aWWPbE6sELCRMXWnHKq+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227821; c=relaxed/simple;
	bh=58dYJ9luYw8N3kkNe4kgLMlt08I5YWQ8h7PBYaeblM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv2ub1ZX8BndyTzlQPMCAqSlpew/PFXei7ZX3B/sbr52TzLwc0cgDltQ3iLKJx+s/lARaQGZo3L4A/DN3u3xnv6umCHiumfEw97DjOqzcBdgizauRPkN6ddaC3Uh5VqLXPTOU18ClKPeeQBIAeafNWi+9aOtlCaCwPO9VMLiIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iUQvfhAF; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595aa5b1fe0so4452590eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706227818; x=1706832618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mepq/n4r76tjXgMd8bs61Q70KlbyLsCs5QleHM4o5pw=;
        b=iUQvfhAFTxHdp7nQRFXb2G+STpLn8YII6vLoWp3hZJBTRVlg8IKazbJCcdnznqHw0z
         DIrfwuyh+o4Ifx23vNYXwm4UORgI/+uwB+IaD6drK5Lk/Hs6JAcfOtORYnNUL1MNcI/c
         vZemvzWUp3+5AoJByrZCvKDS0WAOSersCWHgyAZo3YVg83C80TTbKjjmEibfSViw3AH5
         qSfxhD8gWRT2Bk3UfZcB7x223ZkR/+czktb3m37N7ajzRPm25UPGcdqgV+XOlX4BwiYi
         foajBWEkrK9ARVfcbBuCAYe2DFvLtXBYXae38IQG9cz2eWJHpFJL+oIdSzmmDvt2daTW
         r7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706227818; x=1706832618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mepq/n4r76tjXgMd8bs61Q70KlbyLsCs5QleHM4o5pw=;
        b=m73iJfQYc1sHnmUygQbfMY2ZY23iwNw4BWBGZEazWHuGjAEA6pWOTQQhOGprtU6Qfn
         UyAedhj3i7OW5iXWNtOVU1+cj7OSnX3Wg5RiKsk9hzudycU2hHU+/PYPnJ+s+5ds9/4I
         sogNHZEhsE3LTt/7qpzWjJBFDx6OduO+lSG+lEBLR27j/9nW91GsZssCDkP6t3Eu/T+q
         4jK7ki3NWEbKg86sRmJGpGOONoOBOUNdXBTCw/rdRrc3Qe2fKPltQ8D/oKHx+X6xAmgf
         BmHVeIzr0NriRrfqUuf3qKEDhIsOLsJNxuJUxAAjYsk0kaguSoLDa9Q8CK6Ob4Ene4Rb
         QU3g==
X-Gm-Message-State: AOJu0YzVqRn71vhc4gF0sMJH9utvS5Zjo2MzMW6b2/1TXKYQdtJB/2VF
	JQHmRl1uBOZMn7KSqEAMuBij8FRMmqfYk2em7J5kk588pcku6KhmdfqHdXR9cKs=
X-Google-Smtp-Source: AGHT+IEx73KHQAhkebWlIVIn3JcUudSFf9fDP998OFKdpnla84QeM2u2dcu55JYb8yCnAvAsuooCBg==
X-Received: by 2002:a05:6358:ee88:b0:175:4d29:ac23 with SMTP id il8-20020a056358ee8800b001754d29ac23mr701341rwb.26.1706227818446;
        Thu, 25 Jan 2024 16:10:18 -0800 (PST)
Received: from [10.254.148.65] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78ec7000000b006dde305b92csm93398pfr.118.2024.01.25.16.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 16:10:18 -0800 (PST)
Message-ID: <081a9c21-a1d1-4ca2-a58f-e6748ccb429c@bytedance.com>
Date: Fri, 26 Jan 2024 08:10:13 +0800
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
 <f7379622-4081-4424-9353-289257cf8555@bytedance.com>
 <CAJD7tkaMexNwGHq4G4FjNoWs9_wapY-kttm66Bb9xHF=OReYKg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkaMexNwGHq4G4FjNoWs9_wapY-kttm66Bb9xHF=OReYKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/26 08:05, Yosry Ahmed wrote:
> On Thu, Jan 25, 2024 at 4:03 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/1/25 15:53, Yosry Ahmed wrote:
>>>> Hello,
>>>>
>>>> I also thought about this problem for some time, maybe something like below
>>>> can be changed to fix it? It's likely I missed something, just some thoughts.
>>>>
>>>> IMHO, the problem is caused by the different way in which we use zswap entry
>>>> in the writeback, that should be much like zswap_load().
>>>>
>>>> The zswap_load() comes in with the folio locked in swap cache, so it has
>>>> stable zswap tree to search and lock... But in writeback case, we don't,
>>>> shrink_memcg_cb() comes in with only a zswap entry with lru list lock held,
>>>> then release lru lock to get tree lock, which maybe freed already.
>>>>
>>>> So we should change here, we read swpentry from entry with lru list lock held,
>>>> then release lru lock, to try to lock corresponding folio in swap cache,
>>>> if we success, the following things is much the same like zswap_load().
>>>> We can get tree lock, to recheck the invalidate race, if no race happened,
>>>> we can make sure the entry is still right and get refcount of it, then
>>>> release the tree lock.
>>>
>>> Hmm I think you may be onto something here. Moving the swap cache
>>> allocation ahead before referencing the tree should give us the same
>>> guarantees as zswap_load() indeed. We can also consolidate the
>>> invalidate race checks (right now we have one in shrink_memcg_cb() and
>>> another one inside zswap_writeback_entry()).
>>>
>>> We will have to be careful about the error handling path to make sure
>>> we delete the folio from the swap cache only after we know the tree
>>> won't be referenced anymore. Anyway, I think this can work.
>>>
>>> On a separate note, I think there is a bug in zswap_writeback_entry()
>>> when we delete a folio from the swap cache. I think we are missing a
>>> folio_unlock() there.
>>>
>>
>> Hi, want to know if you are preparing the fix patch, I would just wait to
>> review if you are. Or I can work on it if you are busy with other thing.
> 
> If you're talking about implementing your solution, I was assuming you
> were going to send a patch out (and hoping others would chime in in
> case I missed something).

Ok, I will prepare a patch to send out for further discussion.

> 
> I can take a stab at implementing it if you prefer that, just let me know.

