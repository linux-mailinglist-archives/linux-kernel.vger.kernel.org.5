Return-Path: <linux-kernel+bounces-29748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051708312E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFDF1C21EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC89467;
	Thu, 18 Jan 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IgYNv4x7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF19444
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561065; cv=none; b=F8czGfG8HkfzupMr5qcPnonNtKq74YQ2sqWMpGD1g5m4gniYJrdrUZc3/AWF37ZosRKqyIYysbI3vSe76ZreVHYHGHo8ibqZqcNb8ozMRZsSTslOxPbW1oxngfw/bqLgkTLfRAd9dmA2SrHPEL/eH8ERE8f5HIyRSq3ybERBtBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561065; c=relaxed/simple;
	bh=kG+rN8aFxG0mxJryn3v+GMXskNk7MkMH9uZygutc9Ck=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=ugvdBN4UYsbVt6cGGlS6Z6KM9WCePDPVxxM981XkrgtfdpklCiKnmu7e4nRtlzI9h3maaTSfGhNJHwbcRcjls8b5/qhNgiJ7Sk0Gdzr9LjofmbJ/v5bz1zYsSn6EClxMb7ufl4M3rgjN4NFrTJOujEAA4GcJcW5GpA6qJeOsWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IgYNv4x7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28e7673233dso2251082a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705561063; x=1706165863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYP/cl0xfMYStGxHC3bDdvWKef1/hrUDd9p4oYOcRUk=;
        b=IgYNv4x7P/YYM19uGRJHDJnVtqnqpsaGCeLZCYz5bFB9CSJChl/7RKrmDL+7QQJIP7
         scNBddMmN7E/ORxCuhSx3kknU8sdn9DM8t+tki07lHsdXM3m0PtsyUDza1EfITxM/2NU
         uAubVzeXvIvjKo6xPjxPB30D4qYlp7EB4ctNVzWNY0JiGNud4PsU8hIPYYz8Y8tYdpGy
         +RSc7Ct9Ml32ZF6R6LdGyHGyfrlwcVIKS5vDBMWyvmUpgkiSc715RLyeL0I/IyAWzKRv
         hGy727+9lg3Nawka1sScuK1ilgRX2lk1CWYW3yAjZbEZzJ1Ej1KBTSSroRr6prFmYHiA
         609Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705561063; x=1706165863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYP/cl0xfMYStGxHC3bDdvWKef1/hrUDd9p4oYOcRUk=;
        b=Zq9SRR2RjUP3BRDxHg5YZ4CMiatKSS0na7L/c+rTobffJNOoZ/7gUEKsG3qnKyQgZN
         MItYYJOFFFjgMPVfn2AR98frPwm1YUJtbgetKS4Dji1FZh4sBObo35YtgNEuAZOX+3De
         4JU8ouPJspHArXESIiOVcsuS8mVA2tdVKYGwu6fR44Q9fp66VxU0izVMxPcNhPXYbc6d
         pkkHi8malUjxYjpSPQuobugeKp5S/w9qTlUo7pZFCCNmwDJ8XJZ9dRbH4gcjvkkOkG3N
         JnbTSs4Ux+UhT35GXeD9nXgdDpNo04V1cZyIcbzdz/1KH8vpbhfBWex1K4eB9mkWngMg
         x7dg==
X-Gm-Message-State: AOJu0YxSLHbWNsYCDx5GIwskqI+F8q9az8BemBhkqyi/wpI1g5gq0c/8
	uwlhQkYwphRciRTNmu3/AGCzvA+rdB/MpO8rZF2DAu/D1c6nW4dhZCLHrIOlbfA=
X-Google-Smtp-Source: AGHT+IHZwcZQCi35Kk0KToAdBGJaAQgNikg3mwCr02FZaFr2hTnS3/Ytsf2kl9KWMZ9qw9s3DeuemQ==
X-Received: by 2002:a17:90a:d3c2:b0:28d:876e:250b with SMTP id d2-20020a17090ad3c200b0028d876e250bmr355597pjw.43.1705561062866;
        Wed, 17 Jan 2024 22:57:42 -0800 (PST)
Received: from [10.255.202.70] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id pa5-20020a17090b264500b0028e193e1edcsm897627pjb.25.2024.01.17.22.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 22:57:42 -0800 (PST)
Message-ID: <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com>
Date: Thu, 18 Jan 2024 14:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
To: Yosry Ahmed <yosryahmed@google.com>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>,
 Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
 Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?=
 <surenb@google.com>, Brain Geffon <bgeffon@google.com>,
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>,
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Kairui Song <kasong@tencent.com>, Zhongkun He
 <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Barry Song <v-songbaohua@oppo.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Joel Fernandes <joel@joelfernandes.org>
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <CAJD7tkbQb5nAQdhHXELQsUWs8KhwnoOZ7C8Eu2o7tCYSKeY9Ug@mail.gmail.com>
 <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkb7GmMARE9ueyOCZz9wBbANhofUOHnen+b28sxE9tDy1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yosry and Chris,

On 2024/1/18 14:39, Yosry Ahmed wrote:
> On Wed, Jan 17, 2024 at 10:01 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> That's a long CC list for sure :)
>>
>> On Wed, Jan 17, 2024 at 7:06 PM Chris Li <chrisl@kernel.org> wrote:
>>>
>>> The RB tree shows some contribution to the swap fault
>>> long tail latency due to two factors:
>>> 1) RB tree requires re-balance from time to time.
>>> 2) The zswap RB tree has a tree level spin lock protecting
>>> the tree access.
>>>
>>> The swap cache is using xarray. The break down the swap
>>> cache access does not have the similar long time as zswap
>>> RB tree.
>>
>> I think the comparison to the swap cache may not be valid as the swap
>> cache has many trees per swapfile, while zswap has a single tree.
>>
>>>
>>> Moving the zswap entry to xarray enable read side
>>> take read RCU lock only.
>>
>> Nice.
>>
>>>
>>> The first patch adds the xarray alongside the RB tree.
>>> There is some debug check asserting the xarray agrees with
>>> the RB tree results.
>>>
>>> The second patch removes the zwap RB tree.
>>
>> The breakdown looks like something that would be a development step,
>> but for patch submission I think it makes more sense to have a single
>> patch replacing the rbtree with an xarray.
>>
>>>
>>> I expect to merge the zswap rb tree spin lock with the xarray
>>> lock in the follow up changes.
>>
>> Shouldn't this simply be changing uses of tree->lock to use
>> xa_{lock/unlock}? We also need to make sure we don't try to lock the
>> tree when operating on the xarray if the caller is already holding the
>> lock, but this seems to be straightforward enough to be done as part
>> of this patch or this series at least.
>>
>> Am I missing something?
> 
> Also, I assume we will only see performance improvements after the
> tree lock in its current form is removed so that we get loads
> protected only by RCU. Can we get some performance numbers to see how
> the latency improves with the xarray under contention (unless
> Chengming is already planning on testing this for his multi-tree
> patches).

I just give it a try, the same test of kernel build in tmpfs with zswap
shrinker enabled, all based on the latest mm/mm-stable branch.

                    mm-stable           zswap-split-tree    zswap-xarray        
real                1m10.442s           1m4.157s            1m9.962s            
user                17m48.232s          17m41.477s          17m45.887s          
sys                 8m13.517s           5m2.226s            7m59.305s           

Looks like the contention of concurrency is still there, I haven't
look into the code yet, will review it later.


