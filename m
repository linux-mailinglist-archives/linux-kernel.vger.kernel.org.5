Return-Path: <linux-kernel+bounces-14198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A73821900
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCEA1F2107E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2279E5;
	Tue,  2 Jan 2024 09:40:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215F6AD7;
	Tue,  2 Jan 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A55C15;
	Tue,  2 Jan 2024 01:41:33 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495B93F7A6;
	Tue,  2 Jan 2024 01:40:43 -0800 (PST)
Message-ID: <2c091ba8-4d5c-46d4-bf27-453ef96b1aa2@arm.com>
Date: Tue, 2 Jan 2024 09:42:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/23] PM: EM: Find first CPU active while updating OPP
 efficiency
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-4-lukasz.luba@arm.com>
 <20231217175829.a6hqz7mqlvrujsvs@airbuntu>
 <b31672e4-ab41-4724-86ef-038606318663@arm.com>
 <20231228171315.bmjdo5eztyix5o3r@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231228171315.bmjdo5eztyix5o3r@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/23 17:13, Qais Yousef wrote:
> On 12/19/23 10:53, Lukasz Luba wrote:
>>
>>
>> On 12/17/23 17:58, Qais Yousef wrote:
>>> On 11/29/23 11:08, Lukasz Luba wrote:
>>>> The Energy Model might be updated at runtime and the energy efficiency
>>>> for each OPP may change. Thus, there is a need to update also the
>>>> cpufreq framework and make it aligned to the new values. In order to
>>>> do that, use a first active CPU from the Performance Domain. This is
>>>> needed since the first CPU in the cpumask might be offline when we
>>>> run this code path.
>>>
>>> I didn't understand the problem here. It seems you're fixing a race, but the
>>> description is not clear to me what the race is.
>>
>> I have explained that in v1, v4 comments for this patch.
>> When the EM is registered the fist CPU is always online. No problem
>> for the old code, but for new code with runtime modification at
>> later time, potentially from different subsystems - it it (e.g. thermal,
>> drivers, etc). The fist CPU might be offline, but still such EM
>> update for this domain shouldn'y fail. Although, when the CPU is offline
>> we cannot get the valid policy...
>>
>> We can get it for next cpu in the cpumask, that's what the code is
>> doing.
> 
> Okay, I can see now that cpufreq_cpu_get_raw() ignores offline CPUs
> intentionally.
> 
> A new variant seems better to me. But the experts know better. So LGTM.

Thanks. Yes, I will gently ask Viresh to have a look at those places
cpufreq related places.

