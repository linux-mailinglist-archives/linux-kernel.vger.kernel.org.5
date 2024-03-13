Return-Path: <linux-kernel+bounces-101288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7E87A51F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD99D1C20F11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86141210E9;
	Wed, 13 Mar 2024 09:42:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8024A1F;
	Wed, 13 Mar 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322921; cv=none; b=kmPTwIFP2KW6+Q8gS+5JqphSjrrHMYjgOcouQ05XOQNLaslW4gZZgU6zTNEq5ZSZQwRuIsZ3XNXpZ3cwIweorGj4MyOQTk55HqEEKoViAAN2VEjQcEEj97F/HUyxyV6t2TOCzVRoTOS+pMZzFYFoccJi171Eg2UZwhhaIp5iFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322921; c=relaxed/simple;
	bh=0E+wY8cAtE6Az+PbtjplxiRyoa7X5nFl9m7Ia+hmBjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTIa+e4wogDsl9g3Cj2I6lBMAFBdusPFtBOJE0hqNty2SYe8wW1ttPh6TDITjkq2VbsN46qR+tw8QBUbIxrdQLSAvFT4WdZ7h1Ik45yEsVnKBWfH0Q4GnauNKV6XgWk4lkU9BFdMeTYen+N6FzS5wnSG7FwQxxlbFXnMKJxyOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E0A1007;
	Wed, 13 Mar 2024 02:42:35 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35BA63F73F;
	Wed, 13 Mar 2024 02:41:56 -0700 (PDT)
Message-ID: <0c503c64-133a-705f-9dc4-47c623dacd2c@arm.com>
Date: Wed, 13 Mar 2024 09:41:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf docs: arm_spe: Clarify more SPE requirements
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-kernel@vger.kernel.org
References: <20240312132508.423320-1-james.clark@arm.com>
 <CAP-5=fWGrkjx1vz+2aQU0A+_B3d=nCtK9WBGiSPbDbUaTXR4pQ@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fWGrkjx1vz+2aQU0A+_B3d=nCtK9WBGiSPbDbUaTXR4pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/03/2024 19:56, Ian Rogers wrote:
> On Tue, Mar 12, 2024 at 6:25 AM James Clark <james.clark@arm.com> wrote:
>>
>> The question of exactly when KPTI needs to be disabled comes up a lot
>> because it doesn't always need to be done. Add the relevant kernel
>> function and some examples that describe the behavior.
>>
>> Also describe the interrupt requirement and that no error message will
>> be printed if this isn't met.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Thanks for the review

>> ---
>>  tools/perf/Documentation/perf-arm-spe.txt | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
>> index bf03222e9a68..0a3eda482307 100644
>> --- a/tools/perf/Documentation/perf-arm-spe.txt
>> +++ b/tools/perf/Documentation/perf-arm-spe.txt
>> @@ -116,6 +116,15 @@ Depending on CPU model, the kernel may need to be booted with page table isolati
>>  (kpti=off). If KPTI needs to be disabled, this will fail with a console message "profiling buffer
>>  inaccessible. Try passing 'kpti=off' on the kernel command line".
>>
>> +For the full criteria that determine whether KPTI needs to be forced off or not, see function
>> +unmap_kernel_at_el0() in the kernel sources. Common cases where it's not required
>> +are on the CPUs in kpti_safe_list, or on Arm v8.5+ where FEAT_E0PD is mandatory.
>> +
>> +The SPE interrupt must also be described by the firmware. If the module is loaded and KPTI is
>> +disabled (or isn't required to be disabled) but the SPE PMU still doesn't show in
>> +/sys/bus/event_source/devices/, then it's possible that the SPE interrupt isn't described by
>> +ACPI or DT. In this case no warning will be printed by the driver.
>> +
>>  Capturing SPE with perf command-line tools
>>  ------------------------------------------
>>
>> @@ -199,7 +208,8 @@ Common errors
>>
>>   - "Cannot find PMU `arm_spe'. Missing kernel support?"
>>
>> -   Module not built or loaded, KPTI not disabled (see above), or running on a VM
>> +   Module not built or loaded, KPTI not disabled, interrupt not described by firmware,
>> +   or running on a VM. See 'Kernel Requirements' above.
>>
>>   - "Arm SPE CONTEXT packets not found in the traces."
>>
>> --
>> 2.34.1
>>
> 

