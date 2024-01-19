Return-Path: <linux-kernel+bounces-30806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A3832489
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB1286E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E86FAF;
	Fri, 19 Jan 2024 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TY2Eiy1a"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28063C1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645147; cv=none; b=VlsV3OpAzuVpFJlwuiBra5fCnYzXDO7J/nbdv1RPhrX/a/i76dcHVCa5lo0VRBG3ZBgvmgEEuPW4vWgYsXiQRaMriYAP2QFSwLsghSOOsnKgR7sbrmljriXwXnr35V8d73x7qf2J8Y6TjtBPXor6GAYg56VrJtSRT/mNaL2Xn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645147; c=relaxed/simple;
	bh=pIqJimhETYkJAkUn02tCg7OmOl1nNYbBANy7keVpKBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4X4jNtGjxv/7y7cgLzxCOQuWXK04y6qnHHidqh77U4nvxYsmhod8jDigAXFR4WCW378lBQj59Uab+TXcFk6WNnnvZwriARLnoqotSK9PK7Yeoq2uJaPRMWQvvRZRvs3CAl57lbmCHjc6BlWRFNSPKL8NptZhLZPsH+HuiQdhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TY2Eiy1a; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28ffac1ce99so270848a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705645145; x=1706249945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyGEoJfWWhkrJMQj59+AKvuJydk3uKpdOg7oDnHTmgU=;
        b=TY2Eiy1aor+Z6CUoJvMSqhChkL3TM6wKl+Xc+TGQHLHdKKPSXQo2fiQj+W4NPqwEXx
         w2LwaWqeKAi2HwpYSu5WliuF7AIk+QlAe/OLKR5TIzVj/cOzXwMdI9qQeFRuPUlHIZNi
         Rnl0Acm7kUEuCVJV8rmT8dO+ctkS7sBvvUoQfPygeJE4Te4VfnHZ9zC/yXKxSF6TagjA
         hmvsXxV940fELOjGI/SVaJUrH3H2aAoF/LoCkS67+KgzBLBs0h9fJoV18buWwH399ajk
         1DN3Q3S8S9XGXh5Hc/DM4rSKwiAouklnD7CBlS2VHHD0ft7dMvhLeM8TMvogt36fTjcD
         i3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705645145; x=1706249945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyGEoJfWWhkrJMQj59+AKvuJydk3uKpdOg7oDnHTmgU=;
        b=Yb377uPPA2pI6v+jHK2Qg68S/tBbUFN9E1NusPg6jT6XAVYtMeoCAC0N//kkIw8Q47
         9bYw1bXrM1FpD/QPecNRjPInpGZQNSioEFoOD0CT5UF2KWqtZ4WDnE2+XkSvPnN1ACdE
         5ATyS4MUvBlg7k0JTVQKtzLaKn8waxia5bJiA+4cqolWz1wvGbG0qoh5RUTJ9hEv66l7
         F9tb1PmfA528nKVOT4/n+KtW7naZi+gt134OLnG1FZf0QUXYIXEB6NZdcGb6YY9wwoi1
         76fPKIiQrObQmr4bRDSa+d9YjHZMMR38crSEPIbIt3bwgA/16ALR5lYPiCpHQdP7z6Bn
         3XuQ==
X-Gm-Message-State: AOJu0YyPDZDmom7PTlh7PcYqJsHWxX4qadxjakaR3ziQKpSPS1at4AaP
	J9w9n8AaJskGe3UkUWfIeLsy6jM+wgWlcqUoqbD86XR0HBy2OMa7R8JQNsyyTTo=
X-Google-Smtp-Source: AGHT+IFfRluXn5JTOoxujE8j9Z5Gf3y2nTxyilmVQJUOiLRddb1YYFLzTBiz4+Ual1jHvdOxvyRkfg==
X-Received: by 2002:a17:90a:1bc8:b0:28e:850a:56d4 with SMTP id r8-20020a17090a1bc800b0028e850a56d4mr1740460pjr.49.1705645144885;
        Thu, 18 Jan 2024 22:19:04 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a5e4800b0028feea2cddfsm1133847pji.0.2024.01.18.22.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 22:19:04 -0800 (PST)
Message-ID: <9b2f8385-735b-4341-b521-a42c9a9cb04c@bytedance.com>
Date: Fri, 19 Jan 2024 14:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
Content-Language: en-US
To: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
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
 <3a1b124d-4a97-4400-9714-0cceac53bd34@bytedance.com>
 <CAF8kJuN_3eaJjwLx_hpwN_ahfHa3qT1kN+NQdYd7vokZj458mA@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuN_3eaJjwLx_hpwN_ahfHa3qT1kN+NQdYd7vokZj458mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/19 12:59, Chris Li wrote:
> On Wed, Jan 17, 2024 at 11:35 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> 
>>>>>                     mm-stable           zswap-split-tree    zswap-xarray
>>>>> real                1m10.442s           1m4.157s            1m9.962s
>>>>> user                17m48.232s          17m41.477s          17m45.887s
>>>>> sys                 8m13.517s           5m2.226s            7m59.305s
>>>>>
>>>>> Looks like the contention of concurrency is still there, I haven't
>>>>> look into the code yet, will review it later.
>>>
>>> Thanks for the quick test. Interesting to see the sys usage drop for
>>> the xarray case even with the spin lock.
>>> Not sure if the 13 second saving is statistically significant or not.
>>>
>>> We might need to have both xarray and split trees for the zswap. It is
>>> likely removing the spin lock wouldn't be able to make up the 35%
>>> difference. That is just my guess. There is only one way to find out.
>>
>> Yes, I totally agree with this! IMHO, concurrent zswap_store paths still
>> have to contend for the xarray spinlock even though we would have converted
>> the rb-tree to the xarray structure at last. So I think we should have both.
>>
>>>
>>> BTW, do you have a script I can run to replicate your results?
> 
> Hi Chengming,
> 
> Thanks for your script.
> 
>>
>> ```
>> #!/bin/bash
>>
>> testname="build-kernel-tmpfs"
>> cgroup="/sys/fs/cgroup/$testname"
>>
>> tmpdir="/tmp/vm-scalability-tmp"
>> workdir="$tmpdir/$testname"
>>
>> memory_max="$((2 * 1024 * 1024 * 1024))"
>>
>> linux_src="/root/zcm/linux-6.6.tar.xz"
>> NR_TASK=32
>>
>> swapon ~/zcm/swapfile
> 
> How big is your swapfile here?

The swapfile is big enough here, I use a 50GB swapfile.

> 
> It seems you have only one swapfile there. That can explain the contention.
> Have you tried multiple swapfiles for the same test?
> That should reduce the contention without using your patch.
Do you mean to have many 64MB swapfiles to swapon at the same time?
Maybe it's feasible to test, I'm not sure how swapout will choose.
But in our usecase, we normally have only one swapfile.

Thanks.

> 
> Chris
> 
>> echo 60 > /proc/sys/vm/swappiness
>>
>> echo zsmalloc > /sys/module/zswap/parameters/zpool
>> echo lz4 > /sys/module/zswap/parameters/compressor
>> echo 1 > /sys/module/zswap/parameters/shrinker_enabled
>> echo 1 > /sys/module/zswap/parameters/enabled
>>
>> if ! [ -d $tmpdir ]; then
>>         mkdir -p $tmpdir
>>         mount -t tmpfs -o size=100% nodev $tmpdir
>> fi
>>
>> mkdir -p $cgroup
>> echo $memory_max > $cgroup/memory.max
>> echo $$ > $cgroup/cgroup.procs
>>
>> rm -rf $workdir
>> mkdir -p $workdir
>> cd $workdir
>>
>> tar xvf $linux_src
>> cd linux-6.6
>> make -j$NR_TASK clean
>> make defconfig
>> time make -j$NR_TASK
>> ```
>>
>>

