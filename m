Return-Path: <linux-kernel+bounces-55383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198D84BBF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FEE1C24096
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2F0D52F;
	Tue,  6 Feb 2024 17:32:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E289D51A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240769; cv=none; b=UghucO7ukymGh8RelbkW4jSny3JL1zGIH+vFhPN4HsEqYPeVMLZrpwghf78+QE1T7dA+dDOlIWIhzEtULBmvCiNjLdGS/ePiLPXofo0Z28iofdRc4Plc8fjktZJ8ljF62Vaom34RYvSvI5Qkp7UhvCTiI+FeYCDCPPgALYv4jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240769; c=relaxed/simple;
	bh=u2gTzZKW8LIxTFCR1r28zEGo/Tnm4g5w9BYkncrJoFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdkxXMyq41vp3ISC1Hd+C8t6I6ePuo+0pwZOL6Ys8+THY8BGZug892SqYKlqu7vShDCP28WQ8IkSx8UjZsMhzSSZuAl1jAH/E2Wmr9H+d4NwTayQDF+nkTAdRhFPZ8WIQq4yoeI84B186JRF7SJ2EHpE1tNrzwfhvZrPgQ7nuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 519AE1FB;
	Tue,  6 Feb 2024 09:33:28 -0800 (PST)
Received: from [10.1.36.69] (e133649.arm.com [10.1.36.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F25D43F64C;
	Tue,  6 Feb 2024 09:32:43 -0800 (PST)
Message-ID: <1cc2b8c4-ea0e-4e98-a1a3-2916cccb1ab1@arm.com>
Date: Tue, 6 Feb 2024 17:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] uclamp sum aggregation
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <20240206152054.k3uskf3rhd4icmzt@airbuntu>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240206152054.k3uskf3rhd4icmzt@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:20, Qais Yousef wrote:
> On 02/01/24 13:11, Hongyan Xia wrote:
> 
>> [1]: https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.com/
> 
> Their solution is not acceptable for the same reason yours isn't. Saravana and
> David know this and we discussed at LPC. uclamp hints are limits and should not
> be summed.

Uclamp is a performance hint and nothing in its definition says it can't 
be summed. Clearly whether a uclamp approach should be taken should be 
determined by how well it works as a hint, not by how we calculate it. I 
would not say I want to reject max aggregation simply because it throws 
away all other uclamp values except the max. It's because I have real 
evaluation results showing sum aggregation works as a much better hint.

>> [2]: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510
> 
> I think I clarified several times so far that this is not related to uclamp.
> Could you please refrain from referring to it again in the future? This is
> misleading and neither helps your cause nor its cause. The fact that you're
> relating to it makes me very worried as both links demonstrate lack of
> understanding/confusion of what uclamp is supposed to be.

The intention of the code is irrelevant. What I'm talking about is what 
effect the code actually has. The fact that you keep thinking I don't 
understand what the code does even after me explaining "I know what the 
intention of the code is, I'm just talking about the actual effect of 
the code" is an even more worrying sign.

> Again, this solution is not acceptable and you're moving things in the wrong
> direction. We don't want to redesign what uclamp means, but fix some corner
> cases. And you're doing the former not the latter.

I'm saying max aggregation is not effective and proposing a more 
effective implementation. In fact, you have sent a series that removes 
max aggregation. Clearly that does not count as fixing corner cases but 
is actually a redesign, and I don't understand why you are allowed to do 
such things and I am not. Also, when something becomes harder and harder 
to fix, a redesign that solves all the problems is clearly justified.

What I can summarize from sum aggregation is:

Pros:
1. A more effective implementation, proven by evaluation numbers
2. Consuming the same or even less power in benchmarks
3. 350 lines of code in total, less than half of max aggregation
4. This series shows the entirety and effectiveness of sum aggregation, 
at this very moment, today. Max aggregation needs further filtering and 
load balancing patches which we have not seen yet.
5. Resolves the drawbacks from max aggregation (which you might say is 
the same as 4)
6. Significantly reduces uclamp overhead, no bucket operations

Cons:
1. should not be summed (although the scheduler used to sum up 
utilization and util_est sums up a processed PELT signal today)
2. Under-utilization case (which is a problem GROUP_THROTTLE also has, 
and can be worked around. Please, I know the intention of 
GROUP_THROTTLE, I'm just talking about its actual effects).

I don't see why the things I listed above is in the wrong direction.

