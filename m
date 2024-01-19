Return-Path: <linux-kernel+bounces-31296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE73832C07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB661F22D7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5454675;
	Fri, 19 Jan 2024 15:01:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B921373;
	Fri, 19 Jan 2024 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676470; cv=none; b=ZCNTToP48WdkpiHBFrUv0+Um/1QGdFOyK5OqeQSMgyCi5gMFYVHJJxA/0Hr5FsZFHELYJQFVnbbiY7D4frAupPVrFsGByyhACfjy5qIphTid0yTtagokjge2glhUfqp0DsnXgbf5LJTXp5qENAB5ug1Yy1Ttj6rujTm9NdzxtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676470; c=relaxed/simple;
	bh=5g/VRBSyUa+iW1jKewPy3IzLvCgCQnd3Skn6qtgX0n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7ZRTNncrUkIwTkUKZatz7FurvqTRpIiUA2eFjs8DMYAiWB19j+HnQApYXc10u/hQ5JZ1mLwMFYm2hfhz2/HsJblpW3DdvvqYiQL0GdCKipWoVzfRS5HtOKUco0DCNlobX+3Zhsfj7pEEimEF7WmSqI+4t1Nh1Ispp30dUcnAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7171ADA7;
	Fri, 19 Jan 2024 07:01:50 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0F83F5A1;
	Fri, 19 Jan 2024 07:01:01 -0800 (PST)
Message-ID: <2f9131e4-1fdb-f80a-3b52-b98360164b3b@arm.com>
Date: Fri, 19 Jan 2024 15:00:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
 Ian Rogers <irogers@google.com>, acme@redhat.com, john.g.garry@oracle.com,
 leo.yan@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
 namhyung@kernel.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com,
 will@kernel.org
References: <20240116170348.463479-1-mark.rutland@arm.com>
 <8734uwxrca.wl-maz@kernel.org>
From: James Clark <james.clark@arm.com>
In-Reply-To: <8734uwxrca.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/01/2024 09:05, Marc Zyngier wrote:
> Hi Mark,
> 
> On Tue, 16 Jan 2024 17:03:48 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Currently the perf tool doesn't deteect support for extneded event types
>> on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYPE
>> hardware events into per-PMU events. This is due to the detection of
>> extended event types not handling mandatory filters required by the
>> M1/M2 PMU driver.
> 
> Thanks for looking into this.
> 
> I've given your patch a go on my M1 box, and it indeed makes things
> substantially better:
> 
> $ sudo ./perf stat -e cycles ~/hackbench 100 process 1000
> Running with 100*40 (== 4000) tasks.
> Time: 3.419
> 
>  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> 
>    174,783,472,090      apple_firestorm_pmu/cycles/                                             (93.10%)
>     39,134,744,813      apple_icestorm_pmu/cycles/                                              (71.86%)
> 
>        3.568145595 seconds time elapsed
> 
>       12.203084000 seconds user
>       55.135271000 seconds sys
> 
> However, I'm seeing some slightly odd behaviours:
> 
> $ sudo ./perf stat -e cycles:k ~/hackbench 100 process 1000
> Running with 100*40 (== 4000) tasks.
> Time: 3.313
> 
>  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> 
>    <not supported>      apple_firestorm_pmu/cycles:k/                                         
>    <not supported>      apple_icestorm_pmu/cycles:k/                                          
> 
>        3.467568841 seconds time elapsed
> 
>       13.080111000 seconds user
>       53.162099000 seconds sys
> 
> I would have expected it to count, but it didn't. For that to work, I
> have to add the 'H' modifier:
> 
> $ sudo ./perf stat -e cycles:Hk ~/hackbench 100 process 1000
> Running with 100*40 (== 4000) tasks.
> Time: 3.335
> 
>  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> 
>    183,756,134,397      apple_firestorm_pmu/cycles:Hk/                                          (85.56%)
>     37,302,841,991      apple_icestorm_pmu/cycles:Hk/                                           (72.10%)
> 
>        3.490138958 seconds time elapsed
> 
>       13.376772000 seconds user
>       53.326289000 seconds sys
> 
> But my perf-foo is as basic as it gets, so it is likely that I'm
> missing something.
> 
> Thanks,
> 
> 	M.
> 

The default for exclude_guest=1 is always set unless you use "perf kvm
record". But unfortunately if you add _any_ modifier then all the
default values get overwritten, which is why adding k stops it from working.

It seems like a lot of the pain comes from the fact that the command
line modifiers are includes, and the kernel options are excludes.
Resulting in some complicated logic in get_event_modifier() to try to
work out what you wanted, which I suppose it got it wrong in this scenario.

Another thing is that evsel__detect_missing_features() only works to
remove arguments, where as for M1/M2 you want to _add_ exclude_guest
back in again. But maybe not if you started adding modifiers...

I don't really have an answer or a solution, but I was wondering if
there was a bug that could be fixed so I went to look.

My first thought was maybe we could ignore exclude_guest=0 on M1/M2
rather than returning an error. I don't think it would be too surprising
that guest samples are missing if they are never supported. Maybe the
exclude_guest argument is only useful if it actually has an effect,
rather than having an argument that always needs to be on anyway.

Or secondly maybe we could make get_event_modifier() interact with
evsel__detect_missing_features() but I can't imagine it being very
maintainable once we start adding a few interactions. And it's still
hard to predict what the user really wants given a single letter and
many exclude_* options.

James

