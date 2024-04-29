Return-Path: <linux-kernel+bounces-162484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AC8B5BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FB2285B69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAD7F7C3;
	Mon, 29 Apr 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIhobozg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6B877F32
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402154; cv=none; b=sT7ERkOApJ06W53rfg10ufD4JISTPBcbBiFR6qgoitVgXRn3sviOrEPlZZGjP8uyGv6qOb45DLscGV+b9fxZQLqItiCVKLf2vjdTbywMggMXil2290pdKjtc9ScTnFVmnn54SJEPEN3ZAhp8/VTKUnmQdp1JJWg5wLLFrJ2AVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402154; c=relaxed/simple;
	bh=qbx3g2uO4NtPZWIwOS5yFnSJoc348ZYf9636NTByQkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz0dZ7CR1vKJtBlclGoaYoEhLMkFq+r3iYg8OjrLXeeVFxzztRxA5B6oh+mPn55XH36x+Lz6KlPELcQ0VFvMsfeQmxrNEAz7bTKzaWd9+6mVbOUedhRzQzn0SpwTXrWD9GfjYWugs7lmqA2QMUPr9Q4rggZzES7AVkX1urr1N6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIhobozg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714402151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln/XYC+oZQnfVYR5P0D9/Emt3rXI9LSotRmevRcvOCg=;
	b=AIhobozgpnYD5J6nhkbICNLIhFspbueP3HQDs4wrmje36Cq/CTtlOSETzV19q7HYdBduIJ
	3euxNbd4GJqWu9JNU5nyiiqeJOifA1pFa5zNEM04paLW8gTjmkxpAS6hlkCl2YQf5b1qVL
	YKLgwRjNqM3kytwU7WztoLRxBJ7XOpo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-ApoK8Za4PNOW6XDTd-_n_Q-1; Mon, 29 Apr 2024 10:49:09 -0400
X-MC-Unique: ApoK8Za4PNOW6XDTd-_n_Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ded4efd0a3so33874661fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402148; x=1715006948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ln/XYC+oZQnfVYR5P0D9/Emt3rXI9LSotRmevRcvOCg=;
        b=cnJJ19PB+sT+wjklVtYh7CCXh/8mOrskEpQfV3ZKLaaqg6tdiiupfYy3IJ3rRohZEu
         8ZOtCz0hj0hqGTH+fKcfw8c+woSCDXYJ3o/C5HCseu9XX1eaGKjfZBf8kGmQxKOBxqm1
         7w7cJVLRAGq20bQXwCtS2m7CfxG/2/N+IPns8Xj9A9OeP6Tlr7Xo/lVrZFkIRcTChw7i
         zSHHtB4IIRfz3x9vs9HvMwp97+LLH68agLvLAkGGA8I8JzYiywriVcE5l9jatQethDKX
         gIkeEIAFp+5mRrxhUfSdMpZmmjU0dXg+Aa1OC8i7nYFpu6G3pKAg6Q9dXfbXIYFO2c+3
         UV4g==
X-Forwarded-Encrypted: i=1; AJvYcCWNZjqxIM1D7aWRi/R6o6PQtaNjIQ1tgPKdM+9/VsfKvhHUObc9KSxkbPxkg0rI/H55/5cnH8OSaQIJu4NiWJmxmp0pxNGfoPV1x1zl
X-Gm-Message-State: AOJu0YxwxORAxVE2wRk3A+LDyafazDL7Sd7KFetk5sL04IWvwxNLyQ4D
	ZzSOpxopAuB0horg7+gziA/6afyuAI7ecuEkFlgUNDvQSDY06/uIMQPMYpHo87f5QCJpyeVmrBT
	pxQO4kdDEtk9nFUNB2Nwahsl/HQf1Q4+MwXdcjG7mwaEwM2njsmfxA2XJtvg1fg==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id n4-20020a2eb784000000b002d6f6987ecfmr6551742ljo.9.1714402148485;
        Mon, 29 Apr 2024 07:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmc8CiffHQ8rr9HITicLFmdCuNdR9QemMlGJgkMoITet/yNpu8SIZA6hGAQ/I4C1coGiBGvQ==
X-Received: by 2002:a2e:b784:0:b0:2d6:f698:7ecf with SMTP id n4-20020a2eb784000000b002d6f6987ecfmr6551721ljo.9.1714402148125;
        Mon, 29 Apr 2024 07:49:08 -0700 (PDT)
Received: from [192.168.1.27] (adsl-dyn164.78-99-35.t-com.sk. [78.99.35.164])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm29841286wrn.70.2024.04.29.07.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:49:07 -0700 (PDT)
Message-ID: <ce24cf21-422f-45fe-838e-1e36858b93be@redhat.com>
Date: Mon, 29 Apr 2024 16:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Be more tolerant of metricgroup failures
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240403164818.3431325-1-irogers@google.com>
 <CAGa8GX5MhP3FUhafN5QivHaE3Fg+p5MgvTq3SW6MQy4NeZ1sYQ@mail.gmail.com>
 <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <CAP-5=fU_EvN-bSjwbWMP8R+WyG-jeAQ1p4ziyejy2FCH0kgYig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/22/24 17:42, Ian Rogers wrote:
> On Mon, Apr 22, 2024 at 4:51 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
>>
>> Hi Ian,
>>
>> On Wed, Apr 3, 2024 at 6:48 PM Ian Rogers <irogers@google.com> wrote:
>>>
>>> Previously "set -e" meant any non-zero exit code from perf stat would
>>> cause a test failure. As a non-zero exit happens when there aren't
>>> sufficient permissions, check for this case and make the exit code
>>> 2/skip for it.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  .../perf/tests/shell/stat_all_metricgroups.sh | 28 +++++++++++++++----
>>>  1 file changed, 22 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> index 55ef9c9ded2d..d6db192b9f18 100755
>>> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
>>> @@ -1,9 +1,7 @@
>>> -#!/bin/sh
>>> +#!/bin/bash
>>>  # perf all metricgroups test
>>>  # SPDX-License-Identifier: GPL-2.0
>>>
>>> -set -e
>>> -
>>>  ParanoidAndNotRoot()
>>>  {
>>>    [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
>>> @@ -14,11 +12,29 @@ if ParanoidAndNotRoot 0
>>>  then
>>>    system_wide_flag=""
>>>  fi
>>> -
>>> +err=0
>>>  for m in $(perf list --raw-dump metricgroups)
>>>  do
>>>    echo "Testing $m"
>>> -  perf stat -M "$m" $system_wide_flag sleep 0.01
>>> +  result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
>>> +  result_err=$?
>>> +  if [[ $result_err -gt 0 ]]
>>> +  then
>>> +    if [[ "$result" =~ \
>>> +          "Access to performance monitoring and observability operations is limited" ]]
>>> +    then
>>> +      echo "Permission failure"
>>> +      echo $result
>>> +      if [[ $err -eq 0 ]]
>>> +      then
>>> +        err=2 # Skip
>>> +      fi
>>> +    else
>>> +      echo "Metric group $m failed"
>>> +      echo $result
>>> +      err=1 # Fail
>>> +    fi
>>> +  fi
>>>  done
>>>
>>> -exit 0
>>> +exit $err
>>> --
>>> 2.44.0.478.gd926399ef9-goog
>>>
>>>
>>
>> The patch looks good and thanks for taking care of it.
>>
>> Just wanted to check what is the desired outcome for metric groups
>> with events that are invalid in per-thread mode causing the test to fail.
>>
>> ```
>> $ ./stat_all_metricgroups.sh
>> Testing smi
>> Metric group smi failed
>> Error: Invalid event (msr/smi/u) in per-thread mode, enable system wide with '-a'.
>> ```
>>
>> Wouldn't it be better if in these cases the test would result in skip instead of fail?
> 
> Hi Veronika,
> 
> I agree that fail isn't best here. I'm wondering:
> 
>  - why doesn't msr/smi/ support per-thread mode? Can't we save/restore
> the count on a context switch? The implementation is here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n234
> There's clearly something going on as pperf appears to have other restrictions:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/msr.c?h=perf-tools-next#n115
> I'm wondering if aggregation is working right if these counters are
> more than per hyperthread (I'm guessing why the restrictions exist).
> 

Hi Ian,

I am not really sure why the msr/smi/ does not support per-thread mode but
I encountered multiple instances of events that aren't supported in per-thread
mode during testing. Generally, we cannot be sure that there won't be such event,
whether the msr/smi event should be able to handle per-thread mode is another
question.

Thanks for checking it out and would be great if you could add it to v2.

Thanks,
Veronika 

>  - the tool error message is doing pretty good. In the test I guess we
> can spot the per-thread error and turn the fail to a skip. It's a
> shame to bucket things as skip, but it seems easier than listing
> metrics in the test or spotting particular events.
> 
> I can do a v2 to add this.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Veronika
>>
> 


