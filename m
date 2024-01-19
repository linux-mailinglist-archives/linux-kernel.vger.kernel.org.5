Return-Path: <linux-kernel+bounces-31084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13983289C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37391C23373
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C024CB45;
	Fri, 19 Jan 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Mgnssl0N"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE744378
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662767; cv=none; b=SNphWwUq9iAtk1jcRWZjyiThgBUaNjgYyr5zarbKA3QxQncIv+5xlTMeMlMKO1nA7FiyFdQe7/JuR+hVEEn/EeJoInshFo4Tgv8Xqz/om8mYeeFK0OA6HbtF1hiboUdFwk2dMsluCeP/q4sB3ETkiWtIPDFgxDN+hUpneD2hhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662767; c=relaxed/simple;
	bh=4sOtEOTkX412c9w6V3UWMXAAUs5hOtzibNiA8dTejFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rU3RsAbYZzrRJwmfrwZzKsFVIiUbiJD6cFnCWKqNH4XA2ozFWiFt1drsMsKnVBfFUVy5aoN8ZHzCZmO0l9q+gQgcvr6UO3iwE6yPxvN8131B39XdbC4X9fCcz/RAfGSNbJqq5exSjv3E4tV+OXNO2zjRAYm7zVCA0lsh/QctRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Mgnssl0N; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595aa5b1fe0so406101eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705662764; x=1706267564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRrZVuJD4eHtLTHC2iNOBHqJ0J2Pnus5kzjkaHOH7qI=;
        b=Mgnssl0Nn3xDqpsdVaWSTA4LXFghPG7D2BtPxLUtpsBirS7c242maDDVK59IWi/lxd
         CRZwFCEBv8K3FUZs6I90uc3dOta4s6XiodjqpFG+opo6o4oTDlGr21rtQjdZAbgPP5ee
         aeorOXnorqvrA4JU3W1G5WKij8xj1Ke83I4ukjazxfHE248iOLed6aKCJN6bkP76ssyW
         Uemn+rKWcUF4bh1RtRha7sDEvGFwwvTUoqQPaeZmwvpU0aAqD2dmUqzpRmhJb+a8vDWT
         GcyqR1nLZg6tbxHXfeuYmq1NGoTmgHniH99rSn3fuMpWbLzpfTNZARQ4sAB7mXmy1XSp
         o45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662764; x=1706267564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRrZVuJD4eHtLTHC2iNOBHqJ0J2Pnus5kzjkaHOH7qI=;
        b=fmdxA9JVJbbk6UlkJtz//fevDD5azSsS6r0nhQefyP8CUrWL/MNZz+tSgc71eKNsuh
         zHnYYgKY5YJzmWFSvF9oU3p5mVf0QGiTY1f+bc+g17NewdmM+LtfE02vMThVSAsZPl6P
         2NjAuB7+2agARasIYVOI2zTdcfP7UCOQ19DlvLZ+ZVZTvzhjQ+vB583vYvxrp3m0pgCq
         8IvZCFa8HPrPufOkr5mVWVomUAs/OEusR8U3PKU0r66owHpierUtr5mhbuZsxdsUyVjL
         bk5uIlohU3XMbIF+UILJhM593/kxQKDrvmBNddji26PFNhhb7Vri8y1ICi4NUu78Z4uu
         6bTA==
X-Gm-Message-State: AOJu0Yx6R45MmpyEBg/4Sl8pkPKKQ4ekvyVluwPc4F0QNjprnQ03h62z
	B2QYx3dOpr5fiXe2fJcfFxDZJTy8mJa7Tgw6792N8ifRLWMnahaKTzke0zF2W7k=
X-Google-Smtp-Source: AGHT+IGXVK2rcveg704hNARA6FvxhB522Ogm0C75g5x3avcuMvfcvjATtou+TLlNgCaI1MTD96C8dg==
X-Received: by 2002:a05:6359:6d08:b0:175:d24d:ab7b with SMTP id te8-20020a0563596d0800b00175d24dab7bmr2067379rwb.3.1705662764307;
        Fri, 19 Jan 2024 03:12:44 -0800 (PST)
Received: from [10.254.224.1] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090276c400b001d5af7fbda0sm2809761plt.122.2024.01.19.03.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 03:12:43 -0800 (PST)
Message-ID: <ad007bf8-ab06-4414-8675-e689c5c84fc9@bytedance.com>
Date: Fri, 19 Jan 2024 19:12:34 +0800
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
 <9b2f8385-735b-4341-b521-a42c9a9cb04c@bytedance.com>
 <CAF8kJuNvxZgMvW+7gN1anpASKXdaPfYi=0pSfmJftHkzXnV-ag@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAF8kJuNvxZgMvW+7gN1anpASKXdaPfYi=0pSfmJftHkzXnV-ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/19 18:26, Chris Li wrote:
> On Thu, Jan 18, 2024 at 10:19 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2024/1/19 12:59, Chris Li wrote:
>>> On Wed, Jan 17, 2024 at 11:35 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>
>>>>>>>                     mm-stable           zswap-split-tree    zswap-xarray
>>>>>>> real                1m10.442s           1m4.157s            1m9.962s
>>>>>>> user                17m48.232s          17m41.477s          17m45.887s
>>>>>>> sys                 8m13.517s           5m2.226s            7m59.305s
>>>>>>>
>>>>>>> Looks like the contention of concurrency is still there, I haven't
>>>>>>> look into the code yet, will review it later.
>>>>>
>>>>> Thanks for the quick test. Interesting to see the sys usage drop for
>>>>> the xarray case even with the spin lock.
>>>>> Not sure if the 13 second saving is statistically significant or not.
>>>>>
>>>>> We might need to have both xarray and split trees for the zswap. It is
>>>>> likely removing the spin lock wouldn't be able to make up the 35%
>>>>> difference. That is just my guess. There is only one way to find out.
>>>>
>>>> Yes, I totally agree with this! IMHO, concurrent zswap_store paths still
>>>> have to contend for the xarray spinlock even though we would have converted
>>>> the rb-tree to the xarray structure at last. So I think we should have both.
>>>>
>>>>>
>>>>> BTW, do you have a script I can run to replicate your results?
>>>
>>> Hi Chengming,
>>>
>>> Thanks for your script.
>>>
>>>>
>>>> ```
>>>> #!/bin/bash
>>>>
>>>> testname="build-kernel-tmpfs"
>>>> cgroup="/sys/fs/cgroup/$testname"
>>>>
>>>> tmpdir="/tmp/vm-scalability-tmp"
>>>> workdir="$tmpdir/$testname"
>>>>
>>>> memory_max="$((2 * 1024 * 1024 * 1024))"
>>>>
>>>> linux_src="/root/zcm/linux-6.6.tar.xz"
>>>> NR_TASK=32
>>>>
>>>> swapon ~/zcm/swapfile
>>>
>>> How big is your swapfile here?
>>
>> The swapfile is big enough here, I use a 50GB swapfile.
> 
> Thanks,
> 
>>
>>>
>>> It seems you have only one swapfile there. That can explain the contention.
>>> Have you tried multiple swapfiles for the same test?
>>> That should reduce the contention without using your patch.
>> Do you mean to have many 64MB swapfiles to swapon at the same time?
> 
> 64MB is too small. There are limits to MAX_SWAPFILES. It is less than
> (32 - n) swap files.
> If you want to use 50G swap space, you can have MAX_SWAPFILES, each
> swapfile 50GB / MAX_SWAPFILES.

Right.

> 
>> Maybe it's feasible to test,
> 
> Of course it is testable, I am curious to see the test results.
> 
>> I'm not sure how swapout will choose.
> 
> It will rotate through the same priority swap files first.
> swapfile.c: get_swap_pages().
> 
>> But in our usecase, we normally have only one swapfile.
> 
> Is there a good reason why you can't use more than one swapfile?

I think no, but it seems an unneeded change/burden to our admin.
So I just tested and optimized for the normal case.

> One swapfile will not take the full advantage of the existing code.
> Even if you split the zswap trees within a swapfile. With only one
> swapfile, you will still be having lock contention on "(struct
> swap_info_struct).lock".
> It is one lock per swapfile.
> Using more than one swap file should get you better results.

IIUC, we already have the per-cpu swap entry cache to not contend for
this lock? And I don't see much hot of this lock in the testing.

Thanks.

