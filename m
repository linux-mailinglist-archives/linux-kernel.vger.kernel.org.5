Return-Path: <linux-kernel+bounces-30826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00E8324B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4D71F23644
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3136523A;
	Fri, 19 Jan 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d9eeOpMg"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA65320C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646428; cv=none; b=FcYTF5z3vchiIl8FnSmt1//ygBW0F4AEySjEBKONjjBWSnyxm8ldgFhVHBT08oDNgPPGPkciH0NOU1bcp8DsMRXbSrKcAQzNR12d0M2huHFq7Ao1o8zUKWU17KYpAIaBP1GX98gkFtq4sLHKdbnpv6iByyFpfz33XMGMJbynTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646428; c=relaxed/simple;
	bh=s1Okqq2s5nahiBqekYI3gXKKgLy1d5Iz+k1/Z24mknY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7eZiWyx0HN3Slshw5q1rWYnNGkNLzLL4phKEoqiCmDoC7nCuahG+Q1e9bkSlHidvPFjI0SoMYQuR/bj227K+rzrKQx8Xl4kW9hYoZxF7dEw6W/l6naLYSyaasRcsWNXn1b2jTim6hSpBKKoDjG57RPVBwqdu0f/OP7TjKiQrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d9eeOpMg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cf765355ecso342374a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705646425; x=1706251225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsRGfn3dXCrzIig+mRLsUuEWwIlUe0HWyCHQ5suF82E=;
        b=d9eeOpMglaUxKTbvNjNXZN3eLK1Lncu8xiQC3Jie68cVrwZJsR5zucQyuWkaSIBLpI
         tXSTjLdgLaw6FCgPmoI6AHxnOlRg+WuZ/mSu+hMy4dZKhp2Vaa7ZfWMZNpFwCtsGui3q
         dlyJ66OulOLICaz6aad9yrxw8bfByfDgCLyIe6yhAX1N3ex403b+q1qgi1yMipNV0Xt8
         jHc7zFo3iX8PgWzFCFCzno8qVMtfJtl+sK0IHIgAfgUmjxantlZS9x0f/yjFIg2GYMPv
         2sK0TREOMKyrBu2aGdawJ0sIbVG+IRcOASh+UFYOt6/jCoumIJt0xukDk/P04TOt5t7w
         fDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646425; x=1706251225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsRGfn3dXCrzIig+mRLsUuEWwIlUe0HWyCHQ5suF82E=;
        b=asRCWCadNFDQXnOVUp2cCjxWl9tK8/sVvc9d58drNEF+taEAEhjaeudBcYGNRNUoST
         MmxL0zpOlA86PsyNk5kp035eulJBX0tiRQWUHabLXgg1MItaj/HeVkRjNHBbFdvMlb0a
         fEXYY4feJ2U7wkQr1zACsDzWqngopK8uxEvdA3GIcIPelZyPgJcnGT4VQdjV4QVNUL8W
         MYX3nZVeCzcIF+D93lmr+MNjUMfA1QXF4IVnig0DW1IJpZu1SiDDl4VvC2lNLIKCAXTN
         XrFyjOd1FuKV6fYA+RiOJf9qn7C2yqL5sh6RcHXZqqIR1jK0oPOZzVUSsNw6T4AfZtAK
         JOzA==
X-Gm-Message-State: AOJu0YyxXzRGV32Iz9Km6bIm3PT+p42KoRdB5uGJZW6eVxHBmVK7fOOJ
	qnEHX6A58A/sP66diasvXIXmnyVyTNWVYBtkrl9+/XmuiqbD+Bfs4kh3OLfZuN0=
X-Google-Smtp-Source: AGHT+IGHi1Q1ScArZIRQlmeLwwUKpioUt/pK5MQ4UE8Xs2VfbdidjVj5IQUSPwkFbPvFN8aZQodjSw==
X-Received: by 2002:a05:6a20:734e:b0:19b:1d39:a567 with SMTP id v14-20020a056a20734e00b0019b1d39a567mr1930608pzc.47.1705646425661;
        Thu, 18 Jan 2024 22:40:25 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id pm7-20020a17090b3c4700b00290442c7357sm978067pjb.27.2024.01.18.22.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:40:25 -0800 (PST)
Message-ID: <d7e0c051-e1c4-4658-af06-cbbb2e5e3bfb@bytedance.com>
Date: Fri, 19 Jan 2024 14:40:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chriscli@google.com>,
 Nhat Pham <nphamcs@gmail.com>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <20240118153425.GI939255@cmpxchg.org>
 <CAJD7tkY48=2-4_iG6c-FcbzT3EBriem2spOFTTpGMfqmOmsx2Q@mail.gmail.com>
 <20240118180655.GM939255@cmpxchg.org>
 <CAJD7tkaNA5r7it0NBf+uR5yytJccbV_dLQmPFN0NG5b=+EcOTg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkaNA5r7it0NBf+uR5yytJccbV_dLQmPFN0NG5b=+EcOTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/19 02:37, Yosry Ahmed wrote:
> On Thu, Jan 18, 2024 at 10:07 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>
>> On Thu, Jan 18, 2024 at 09:30:12AM -0800, Yosry Ahmed wrote:
>>> On Thu, Jan 18, 2024 at 7:34 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>
>>>> On Wed, Jan 17, 2024 at 10:37:22AM -0800, Yosry Ahmed wrote:
>>>>> On Wed, Jan 17, 2024 at 1:23 AM Chengming Zhou
>>>>> <zhouchengming@bytedance.com> wrote:
>>>>>>
>>>>>> When testing the zswap performance by using kernel build -j32 in a tmpfs
>>>>>> directory, I found the scalability of zswap rb-tree is not good, which
>>>>>> is protected by the only spinlock. That would cause heavy lock contention
>>>>>> if multiple tasks zswap_store/load concurrently.
>>>>>>
>>>>>> So a simple solution is to split the only one zswap rb-tree into multiple
>>>>>> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
>>>>>> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
>>>>>>
>>>>>> Although this method can't solve the spinlock contention completely, it
>>>>>> can mitigate much of that contention. Below is the results of kernel build
>>>>>> in tmpfs with zswap shrinker enabled:
>>>>>>
>>>>>>      linux-next  zswap-lock-optimize
>>>>>> real 1m9.181s    1m3.820s
>>>>>> user 17m44.036s  17m40.100s
>>>>>> sys  7m37.297s   4m54.622s
>>>>>>
>>>>>> So there are clearly improvements. And it's complementary with the ongoing
>>>>>> zswap xarray conversion by Chris. Anyway, I think we can also merge this
>>>>>> first, it's complementary IMHO. So I just refresh and resend this for
>>>>>> further discussion.
>>>>>
>>>>> The reason why I think we should wait for the xarray patch(es) is
>>>>> there is a chance we may see less improvements from splitting the tree
>>>>> if it was an xarray. If we merge this series first, there is no way to
>>>>> know.
>>>>
>>>> I mentioned this before, but I disagree quite strongly with this
>>>> general sentiment.
>>>>
>>>> Chengming's patches are simple, mature, and have convincing
>>>> numbers. IMO it's poor form to hold something like that for "let's see
>>>> how our other experiment works out". The only exception would be if we
>>>> all agree that the earlier change flies in the face of the overall
>>>> direction we want to pursue, which I don't think is the case here.
>>>
>>> My intention was not to delay merging these patches until the xarray
>>> patches are merged in. It was only to wait until the xarray patches
>>> are *posted*, so that we can redo the testing on top of them and
>>> verify that the gains are still there. That should have been around
>>> now, but the xarray patches were posted in a form that does not allow
>>> this testing (because we still have a lock on the read path), so I am
>>> less inclined.
>>>
>>> My rationale was that if the gains from splitting the tree become
>>> minimal after we switch to an xarray, we won't know. It's more
>>> difficult to remove optimizations than to add them, because we may
>>> cause a regression. I am kind of paranoid about having code sitting
>>> around that we don't have full information about how much it's needed.
>>
>> Yeah I understand that fear.
>>
>> I expect the splitting to help more than the move to xarray because
>> it's the writes that are hot. Luckily in this case it should be fairly
>> easy to differential-test after it's been merged by changing that tree
>> lookup macro/function locally to always return &trees[type][0], right?
> 
> Yeah that's exactly what I had in mind. Once we have a version of the
> xarray patch without the locking on the read side we can test with
> that. Chengming, does this sound reasonable to you?

It's ok, sounds reasonable to me. I agree with Johannes, we will need
both since xarray still have a spinlock in the writes, it's clearly
better to split it. As for testing, we can always return &trees[type][0].

Thanks!

