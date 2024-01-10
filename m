Return-Path: <linux-kernel+bounces-22590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E371E82A01F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9204B1F21DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25414D586;
	Wed, 10 Jan 2024 18:10:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9734CDF8;
	Wed, 10 Jan 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EE252F4;
	Wed, 10 Jan 2024 10:10:59 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 659FF3F5A1;
	Wed, 10 Jan 2024 10:10:09 -0800 (PST)
Message-ID: <5ac0df44-82b6-463b-a805-65f93d181215@arm.com>
Date: Wed, 10 Jan 2024 19:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Rework system pressure interface to the scheduler
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
 <d37e3d06-d9fc-4fc3-ad92-e7031489660a@arm.com>
 <CAKfTPtAOSgnStDSao1QarHuUW9BTfk1o7r6NO4LhwEJMhq1drg@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAKfTPtAOSgnStDSao1QarHuUW9BTfk1o7r6NO4LhwEJMhq1drg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/01/2024 14:29, Vincent Guittot wrote:
> On Tue, 9 Jan 2024 at 12:34, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/01/2024 14:48, Vincent Guittot wrote:
>>> Following the consolidation and cleanup of CPU capacity in [1], this serie
>>> reworks how the scheduler gets the pressures on CPUs. We need to take into
>>> account all pressures applied by cpufreq on the compute capacity of a CPU
>>> for dozens of ms or more and not only cpufreq cooling device or HW
>>> mitigiations. we split the pressure applied on CPU's capacity in 2 parts:
>>> - one from cpufreq and freq_qos
>>> - one from HW high freq mitigiation.
>>>
>>> The next step will be to add a dedicated interface for long standing
>>> capping of the CPU capacity (i.e. for seconds or more) like the
>>> scaling_max_freq of cpufreq sysfs. The latter is already taken into
>>> account by this serie but as a temporary pressure which is not always the
>>> best choice when we know that it will happen for seconds or more.
>>
>> I guess this is related to the 'user space system pressure' (*) slide of
>> your OSPM '23 talk.
> 
> yes
> 
>>
>> Where do you draw the line when it comes to time between (*) and the
>> 'medium pace system pressure' (e.g. thermal and FREQ_QOS).
> 
> My goal is to consider the /sys/../scaling_max_freq as the 'user space
> system pressure'
> 
>>
>> IIRC, with (*) you want to rebuild the sched domains etc.
> 
> The easiest way would be to rebuild the sched_domain but the cost is
> not small so I would prefer to skip the rebuild and add a new signal
> that keep track on this capped capacity

Are you saying that you don't need to rebuild sched domains since
cpu_capacity information of the sched domain hierarchy is
independently updated via: 

update_sd_lb_stats() {

  update_group_capacity() {

    if (!child)
      update_cpu_capacity(sd, cpu) {

        capacity = scale_rt_capacity(cpu) {

          max = get_actual_cpu_capacity(cpu) <- (*)
        }

        sdg->sgc->capacity = capacity;
        sdg->sgc->min_capacity = capacity;
        sdg->sgc->max_capacity = capacity;
      }

  }

}
        
(*) influence of temporary and permanent (to be added) frequency
pressure on cpu_capacity (per-cpu and in sd data)


example: hackbench on h960 with IPA:
                                                                                  cap  min  max
..
hackbench-2284 [007] .Ns..  2170.796726: update_group_capacity: sdg !child cpu=7 1017 1017 1017
hackbench-2456 [007] ..s..  2170.920729: update_group_capacity: sdg !child cpu=7 1018 1018 1018
    <...>-2314 [007] ..s1.  2171.044724: update_group_capacity: sdg !child cpu=7 1011 1011 1011
hackbench-2541 [007] ..s..  2171.168734: update_group_capacity: sdg !child cpu=7  918  918  918
hackbench-2558 [007] .Ns..  2171.228716: update_group_capacity: sdg !child cpu=7  912  912  912
    <...>-2321 [007] ..s..  2171.352718: update_group_capacity: sdg !child cpu=7  812  812  812
hackbench-2553 [007] ..s..  2171.476721: update_group_capacity: sdg !child cpu=7  640  640  640
    <...>-2446 [007] ..s2.  2171.600743: update_group_capacity: sdg !child cpu=7  610  610  610
hackbench-2347 [007] ..s..  2171.724738: update_group_capacity: sdg !child cpu=7  406  406  406
hackbench-2331 [007] .Ns1.  2171.848768: update_group_capacity: sdg !child cpu=7  390  390  390
hackbench-2421 [007] ..s..  2171.972733: update_group_capacity: sdg !child cpu=7  388  388  388
..

