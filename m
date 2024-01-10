Return-Path: <linux-kernel+bounces-22280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF4829BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF56284DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C764A9A6;
	Wed, 10 Jan 2024 13:51:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74B4A9B2;
	Wed, 10 Jan 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F4F2F4;
	Wed, 10 Jan 2024 05:51:56 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E373F5A1;
	Wed, 10 Jan 2024 05:51:06 -0800 (PST)
Message-ID: <92d1b906-6d76-4e96-a688-3a06a0a88508@arm.com>
Date: Wed, 10 Jan 2024 14:51:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] sched: Take cpufreq feedback into account
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
 agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
 rui.zhang@intel.com, mhiramat@kernel.org, daniel.lezcano@linaro.org,
 amit.kachhap@gmail.com, corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 qyousef@layalina.io
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-3-vincent.guittot@linaro.org>
 <fb25afab-9586-455a-b8c1-47949035c95a@arm.com>
 <CAKfTPtDEKzup63H0iwHkTQCZOdQLUurACCYfEB-MpW+v7JEfag@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtDEKzup63H0iwHkTQCZOdQLUurACCYfEB-MpW+v7JEfag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 15:30, Vincent Guittot wrote:
> On Tue, 9 Jan 2024 at 12:22, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/01/2024 14:48, Vincent Guittot wrote:
>>> Aggregate the different pressures applied on the capacity of CPUs and
>>> create a new function that returns the actual capacity of the CPU:
>>>   get_actual_cpu_capacity()
>>
>>    function name                scaling
>>
>> (1) arch_scale_cpu_capacity() - uarch
>>
>> (2) get_actual_cpu_capacity() - hw + cpufreq/thermal of (1)
>>
>> (3) capacity_of()             - rt (rt/dl/irq) of (2) (used by fair)
>>
>> Although (1) - (3) are very close to each other from the functional
> 
> I don't get your point as name of (1) and (3) have not been changed by the patch

That's true. But with capacity_orig_of() for (1), we had some coherence
in the naming scheme of those cpu_capacity related functions (1) - (3).
which helps when trying to understand the code.

I can see that actual_capacity_of() (2) sounds awful though.

>> standpoint, their names are not very coherent.
>>
>> I assume this makes it hard to understand all of this when reading the
>> code w/o knowing these patches before.
>>
>> Why is (2) tagged with 'actual'?
> 
> This is the actual max compute capacity of the cpu at now  i.e.
> possibly reduced because of temporary frequency capping

Will the actual max compute capacity also depend on 'user space system
pressure' later, i.e. on 'permanent' frequency capping?

> So (2) equals (1) minus temporary performance capping and (3)
> additionally subtracts the time used by other class to (2)

OK.

A coherent set of those tags even reflected in those getters would help
but can be done later too.

