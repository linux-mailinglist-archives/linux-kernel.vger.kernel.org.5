Return-Path: <linux-kernel+bounces-55058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1FB84B6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28A5B22B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD6131752;
	Tue,  6 Feb 2024 13:55:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9DE13172C;
	Tue,  6 Feb 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227707; cv=none; b=dPVniAUjek+49KEfeJcWmZCu274Nixzh+pE2AbO7fs5bD6ebkmmzn6YmZBznqnQb7axLngJSuSuxvpUejPWUeBauA0Bhu60YnSnGbXTBwhjCRz7bOSFsLR+FO+q4sg+wSlaDSFHYDWbRp4sdtrak1l54xDOn2sTmdwCQkBhwbvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227707; c=relaxed/simple;
	bh=y7hFzdM5gfW98UTKnof7sSf3t1mVUOaS5iaSkMOD3gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr/+LOpZZUknxMz4AgNEBYC9KrJ0wG2fdEftOl7OmR/dxrOIpgD3ORFlxKMqqGCJuVUVs4/Le267UQ4x9peDLjfhVLQ7u7ASxiT1SUpcaY3nZKQ+avLmw7cVHwUKm0VnpX5TnFPHr25F12NwRwo9vDd/YU9Z2kWp7bU0CQbcuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610991FB;
	Tue,  6 Feb 2024 05:55:47 -0800 (PST)
Received: from [10.57.8.150] (unknown [10.57.8.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFDE3F5A1;
	Tue,  6 Feb 2024 05:55:02 -0800 (PST)
Message-ID: <b4be1ba2-b1a5-484e-93cb-d07d92eb813a@arm.com>
Date: Tue, 6 Feb 2024 13:55:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] PM: EM: Add em_perf_state_from_pd() to get
 performance states table
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-13-lukasz.luba@arm.com>
 <3e1a2865-e40e-4a7e-9c75-5768d717a1a6@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3e1a2865-e40e-4a7e-9c75-5768d717a1a6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/24 18:13, Dietmar Eggemann wrote:
> On 17/01/2024 10:57, Lukasz Luba wrote:
> 
> [...]
> 
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 494df6942cf7..5ebe9dbec8e1 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -339,6 +339,23 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>>   	return pd->nr_perf_states;
>>   }
>>   
>> +/**
>> + * em_perf_state_from_pd() - Get the performance states table of perf.
>> + *				domain
>> + * @pd		: performance domain for which this must be done
>> + *
>> + * To use this function the rcu_read_lock() should be hold. After the usage
>> + * of the performance states table is finished, the rcu_read_unlock() should
>> + * be called.
>> + *
>> + * Return: the pointer to performance states table of the performance domain
>> + */
>> +static inline
>> +struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)
> 
> This is IMHO hard to get since:
> 
>    struct em_perf_table {
>      struct rcu_head rcu;
>      struct kref kref;
>      struct em_perf_state state[];
>    };
> 
> So very often a 'struct em_perf_table' is named 'table' and 'struct
> em_perf_table::state' as well. E.g. in em_adjust_new_capacity().
> 
>    struct em_perf_state *new_table;
> 
>    new_table = em_table->state;
> 
> In older EM code, we used 'struct em_perf_state *ps' to avoid this
> confusion, I guess.
> 
> And what you get from the PD is actually a state vector so maybe:
> 
> struct em_perf_state *em_get_perf_states(struct em_perf_domain *pd)
> 
> The 'from_pd' seems obvious because of the parameter?

Rafael proposed that function name in his review comments, so I
followed. I might address your comment about the:
'struct em_perf_state *ps'
while I will do re-basing and sending v8.


