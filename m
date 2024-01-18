Return-Path: <linux-kernel+bounces-29767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA8831328
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6E5B23A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4FBA45;
	Thu, 18 Jan 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VcsJ07SD"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F5B66C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563356; cv=none; b=qjMKdj2axI1PdKvHkVjHyvpvVtIK0tbiV0e1nZCmh6H0t5Qfb6hiHK00vcWcDQZPpPrlZqoSJPdLx1qjdYdS6nLVzVwLzYIf8vY0B08YJtSdnfeP/7tAYKHPgh6doTnuewHo3IoMYJ6OPuX7ODjnGyubRc8k+KG13fX909i9thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563356; c=relaxed/simple;
	bh=upL7j+a1dYfb/UgswDchlcce1wP/pgio1+K3NC2IgA4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=RsWB2gLbCoLX7k4uPTccxPpbHhYfBewoYihjzL5sYp30VTJEorL7PAUDoU3OUGo9RYqluSPL+NuCfvKq1UEiq6OIi8AMsTqKy9ghO//zztzuPhi0UeIxagmdHmuvy18rurHv6Ow/rPqqFUn4arAtByO1oW5/+1w0kVJzx0veyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VcsJ07SD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70c3c2212so652885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705563354; x=1706168154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blJO9gE2XGx1TFkEN6VRT9JbKi24N1Ai12mUj8knsEI=;
        b=VcsJ07SD4rg7tiLK0Y9KA+sfgoYIAtO0j3tfS64KhZsaeGUOV1FaPZgF+N+IiBEl+9
         2X/asoqN7MikLfKv0lzuISrXpkKOHbgoXAIXo/MF8GOkGT1rXxUvxDcpmnPYx+XX/PmV
         SBtdUZoJ02rnA9rN17OhzMNyMqo2yrc2O7UbAqU+7KqW4hrmdonuNIS8fzmTJTswzWDE
         qUZiqX40xM6oB+VpUGddulmvoQF7goR55Z9lyn4YMPJxfomJYjMsorBIsAr/J3NbVEWt
         w51urK2+IeNXIA0byurqj+v5+eG00Td1vaLRD4Ig6qGTaJTa7C0dabEk/okhOWzmVlgt
         qgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705563354; x=1706168154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blJO9gE2XGx1TFkEN6VRT9JbKi24N1Ai12mUj8knsEI=;
        b=fyJXRjYuEIKnWH7dopxQnyrgGgejxBLbMoU/Y4Dq/sJ4z8SUJT9wEKYglJu0TaDd9U
         C8TDeEVBrUksVIhOZwpV6NbTsvnYG3UdzyaOW0t5zj6AAGohH0ZmscQtaZNu81hiCqN6
         UmIwpj75yNJ27d7ob9Q5W68JaVmXprdhDDUXGaY5VcIluSJMYea43AGdiqoTjD9tDfU4
         aYUBJoquCi8KHtSr5kQsBFMlHnj7QbtZBOUn3khUIPK5S9FikepEY83TZP96QzUX1MEh
         pSjjR3PFL71YcB+JGMJ5gjH0epKCiePThxpeQRD0mLQOjlyF5aRA6gORWF2Nf25aQDpN
         X8AA==
X-Gm-Message-State: AOJu0YxQiVi0T5KC2sJp2C+00H+joiO2fTzxGEcRYePbedOAY4Pb/d2C
	O5alX4t20GtYlcJICQifowgj32/T4yqhqRe4s5ZuY9GIZh+oVs3T7dFCNcbwpO8=
X-Google-Smtp-Source: AGHT+IHdS0Lwq6Q/NoPTphsJUIqM1+mK9iR8t9NerFXpVQ56PVLfgHwgQlxGnuYenDEwDKnLQWPFdw==
X-Received: by 2002:a17:903:41cf:b0:1d3:abaa:1399 with SMTP id u15-20020a17090341cf00b001d3abaa1399mr726648ple.51.1705563353749;
        Wed, 17 Jan 2024 23:35:53 -0800 (PST)
Received: from [10.255.202.70] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001d58ed4c591sm757249plx.105.2024.01.17.23.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 23:35:53 -0800 (PST)
Message-ID: <3a1b124d-4a97-4400-9714-0cceac53bd34@bytedance.com>
Date: Thu, 18 Jan 2024 15:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>
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
 <7f52ad78-e10b-438a-b380-49451bf6f64f@bytedance.com>
 <CAJD7tkaeBTforGTQ8ia_6-1fd5hf-zwkBcd_kW8Bk=zdO+Qnvw@mail.gmail.com>
 <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuNPPruLDOEqH-f-w1zw-TSuWkUZsQ43Qe_EtycapXgkbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/18 15:19, Chris Li wrote:
> On Wed, Jan 17, 2024 at 11:02 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Wed, Jan 17, 2024 at 10:57 PM Chengming Zhou
>> <zhouchengming@bytedance.com> wrote:
>>>
>>> Hi Yosry and Chris,
>>>
>>> On 2024/1/18 14:39, Yosry Ahmed wrote:
>>>> On Wed, Jan 17, 2024 at 10:01 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>>
>>>>> That's a long CC list for sure :)
>>>>>
>>>>> On Wed, Jan 17, 2024 at 7:06 PM Chris Li <chrisl@kernel.org> wrote:
>>>>>>
>>>>>> The RB tree shows some contribution to the swap fault
>>>>>> long tail latency due to two factors:
>>>>>> 1) RB tree requires re-balance from time to time.
>>>>>> 2) The zswap RB tree has a tree level spin lock protecting
>>>>>> the tree access.
>>>>>>
>>>>>> The swap cache is using xarray. The break down the swap
>>>>>> cache access does not have the similar long time as zswap
>>>>>> RB tree.
>>>>>
>>>>> I think the comparison to the swap cache may not be valid as the swap
>>>>> cache has many trees per swapfile, while zswap has a single tree.
>>>>>
>>>>>>
>>>>>> Moving the zswap entry to xarray enable read side
>>>>>> take read RCU lock only.
>>>>>
>>>>> Nice.
>>>>>
>>>>>>
>>>>>> The first patch adds the xarray alongside the RB tree.
>>>>>> There is some debug check asserting the xarray agrees with
>>>>>> the RB tree results.
>>>>>>
>>>>>> The second patch removes the zwap RB tree.
>>>>>
>>>>> The breakdown looks like something that would be a development step,
>>>>> but for patch submission I think it makes more sense to have a single
>>>>> patch replacing the rbtree with an xarray.
>>>>>
>>>>>>
>>>>>> I expect to merge the zswap rb tree spin lock with the xarray
>>>>>> lock in the follow up changes.
>>>>>
>>>>> Shouldn't this simply be changing uses of tree->lock to use
>>>>> xa_{lock/unlock}? We also need to make sure we don't try to lock the
>>>>> tree when operating on the xarray if the caller is already holding the
>>>>> lock, but this seems to be straightforward enough to be done as part
>>>>> of this patch or this series at least.
>>>>>
>>>>> Am I missing something?
>>>>
>>>> Also, I assume we will only see performance improvements after the
>>>> tree lock in its current form is removed so that we get loads
>>>> protected only by RCU. Can we get some performance numbers to see how
>>>> the latency improves with the xarray under contention (unless
>>>> Chengming is already planning on testing this for his multi-tree
>>>> patches).
>>>
>>> I just give it a try, the same test of kernel build in tmpfs with zswap
>>> shrinker enabled, all based on the latest mm/mm-stable branch.
>>>
>>>                     mm-stable           zswap-split-tree    zswap-xarray
>>> real                1m10.442s           1m4.157s            1m9.962s
>>> user                17m48.232s          17m41.477s          17m45.887s
>>> sys                 8m13.517s           5m2.226s            7m59.305s
>>>
>>> Looks like the contention of concurrency is still there, I haven't
>>> look into the code yet, will review it later.
> 
> Thanks for the quick test. Interesting to see the sys usage drop for
> the xarray case even with the spin lock.
> Not sure if the 13 second saving is statistically significant or not.
> 
> We might need to have both xarray and split trees for the zswap. It is
> likely removing the spin lock wouldn't be able to make up the 35%
> difference. That is just my guess. There is only one way to find out.

Yes, I totally agree with this! IMHO, concurrent zswap_store paths still
have to contend for the xarray spinlock even though we would have converted
the rb-tree to the xarray structure at last. So I think we should have both.

> 
> BTW, do you have a script I can run to replicate your results?

```
#!/bin/bash

testname="build-kernel-tmpfs"
cgroup="/sys/fs/cgroup/$testname"

tmpdir="/tmp/vm-scalability-tmp"
workdir="$tmpdir/$testname"

memory_max="$((2 * 1024 * 1024 * 1024))"

linux_src="/root/zcm/linux-6.6.tar.xz"
NR_TASK=32

swapon ~/zcm/swapfile
echo 60 > /proc/sys/vm/swappiness

echo zsmalloc > /sys/module/zswap/parameters/zpool
echo lz4 > /sys/module/zswap/parameters/compressor
echo 1 > /sys/module/zswap/parameters/shrinker_enabled
echo 1 > /sys/module/zswap/parameters/enabled

if ! [ -d $tmpdir ]; then
	mkdir -p $tmpdir
	mount -t tmpfs -o size=100% nodev $tmpdir
fi

mkdir -p $cgroup
echo $memory_max > $cgroup/memory.max
echo $$ > $cgroup/cgroup.procs

rm -rf $workdir
mkdir -p $workdir
cd $workdir

tar xvf $linux_src
cd linux-6.6
make -j$NR_TASK clean
make defconfig
time make -j$NR_TASK
```


