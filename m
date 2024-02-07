Return-Path: <linux-kernel+bounces-55858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5884C28A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B51B1F24CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5E134A4;
	Wed,  7 Feb 2024 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFYAGbF6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4A12E5D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707273424; cv=none; b=fBkk0OYn87kLUDA0IqITNbD/nyC2CGJMrBPKnd/FSC1RtkBSP6m0ty4/CfYtzo/VWK4u5AG+Qv30nyrsruVUGXdANyaat++rn172i6W8aiN3f3e2tHG7L5l7r5FMvaMZ9xQo9sxlZWvLx0pAqV/NrOZgdOccxrJKeJfdbk/HBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707273424; c=relaxed/simple;
	bh=QgM72IJSvIw2qVNG7OMOiCxUjZUlh3tFA1AEimMdWTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnQy+n1iKxP5bfEmAtHFfMVvEHMkzPargglX+FPETtbI5AVk5/x8qCtIHg7zGTqAnt4R+DjjD0QPaEnp51uKs3mqESt8pTic5QENsDcuOrr2N9YtH+dWHmXLmgB5DOzTKCoBq1idWmDnoVJOxo9SqHATauV5FsdxteP9bVcHWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFYAGbF6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d93b525959so9986545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707273423; x=1707878223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxU+NnsZkMNHNKZu75+WwEdGUod2EuM4PuaEZJwXpMc=;
        b=QFYAGbF67ILC8X1sNoV4WNS676QEvEYV9DKTqBUoOq56A+kkyNXkkcOJRI6gEK1w5c
         9MJ50y0euNQLslunMIECrbUQdKk3sqiEjSSdp9ST5g23tlW7nbiCQPfc+FHkUdJec1uD
         0+N2XmGid+2Sew3td0yDDQYXMzlFhm7ZcyWuMxBs8Qg6iv6c+R1zvdZVls/qSjPF+oC5
         ZJ5L3Hf1AzrBfAWQL+1FI0Sg319hKNmKPYPSBeO7XLjmXVTCSeNhO3V+AgKY+WN1mRCM
         fs/YvdwH32QIaEmpvV3iYxPtcU++G3YS+ZKDkscjz+HuNrYObAV9TiyVpEsjdBt9xM63
         iFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707273423; x=1707878223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxU+NnsZkMNHNKZu75+WwEdGUod2EuM4PuaEZJwXpMc=;
        b=rf3TmtRr7ZMpknpjoFe2Htfz83YL+/Jr8zJwQPWusX1SLvWswg76njzGuYOv8TjxMC
         kWWbIawNlu2Ne4P44D58IUAg2vhAkr7JPmkLciKB59rWyVDgF5FUzXgmzbI+6d+dz2yE
         YFB6HUwiv4G0aOcrzq638LkGJ6lIilgot/kyYicoWGyZQfn1Ng212RDPgrZRxDGG5PUA
         hoCVQzLyeUadBr20gL/7vWM7o+QCI5n67JVvqa4kXqA6g8/wnvjPnZQXncHTQJseklNr
         bYIa42pd/KQt69iPWX3G3fvw/+3x1oYS8IJwoAr3BemBkguBXxu1laxBsdrM+iVDoKVB
         WM2w==
X-Forwarded-Encrypted: i=1; AJvYcCU2tP0FAMG6GQUEYgUGXtMyXa3EF8DeBb4xjPXDN9GIGJPvvXsblr1ExZ9045izQ41oQiM8TxS9YUwGb5EPAHiQ3uDztdNYnVeG38FE
X-Gm-Message-State: AOJu0Ywv3NrbpkVTg5ycNLgbKCdCPaZ1PBW9xFx+C7PryM+r9Ye3IdiH
	slMatatjHDdLlxx8AZ4tSdPGkd/bw7F3WUddT+4GMQXP9Pz/Bbxf
X-Google-Smtp-Source: AGHT+IHTJOpnpv8KrHcz4tSA/b6J15yljAiBs/IV6hT011Gqf4jvyX3IgcZm6xOpEZC3lzGm9apZlg==
X-Received: by 2002:a17:902:f68d:b0:1d9:ce46:6eb8 with SMTP id l13-20020a170902f68d00b001d9ce466eb8mr5854547plg.4.1707273422696;
        Tue, 06 Feb 2024 18:37:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfJ1yTpRE+lTI++b/2+pSZ1FR4EM7GXOOEhT0k7XZCla/fdE197Ny3PN9D+UYb3SG62xETO704MsKfAmSCB/h7RSOB5nYryJ1TaY3E5RbnYgYJnC8Jnb/GR7npGcitUVSePlj4kg4URTzJElhn94pP65FbSo13sg5kE/DX0lQG3oY/ivcoDrH8Fbog63RvuUU7y7g7/GA9oYECLzLOJshX2s1sBfPsnDER8Ve6ZYUCi7sdQZgFethV/3FVbnqe2o5H/o6zOYWs8cDAJBqLEpabpwzjRcyDvN+r/IngIIwiMiJMVe7HDxI2q6yUCQ3g2pFG4vsViL5uvobwm3uKHqA7o4R3+yI6su15duMYz8xVxr12zEPdP+IPpnCNe0bWOeKAV3FpiwGW
Received: from [192.168.255.10] ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001d956e84582sm237320pld.91.2024.02.06.18.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 18:37:02 -0800 (PST)
Message-ID: <ec3e1d37-1b96-4a28-a5d8-cc92f3103085@gmail.com>
Date: Wed, 7 Feb 2024 10:36:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] sched/fair: add SD_CLUSTER in comments
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>, alexs@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
References: <20240201115447.522627-1-alexs@kernel.org>
 <xhsmhzfwjgcvf.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20240206024633.GD17602@ranerica-svr.sc.intel.com>
 <b19487fe-cc9b-412d-8b70-c0be6ad224ae@gmail.com>
 <20240206212418.GA19695@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240206212418.GA19695@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 5:24 AM, Ricardo Neri wrote:
> On Tue, Feb 06, 2024 at 04:56:02PM +0800, kuiliang Shi wrote:
>>
>>
>> On 2/6/24 10:46 AM, Ricardo Neri wrote:
>>> On Fri, Feb 02, 2024 at 03:27:32PM +0100, Valentin Schneider wrote:
>>>>
>>>> Subject nit: the prefix should be sched/topology
>>>>
>>>> On 01/02/24 19:54, alexs@kernel.org wrote:
>>>>> From: Alex Shi <alexs@kernel.org>
>>>>>
>>>>> The description of SD_CLUSTER is missing. Add it.
>>>>>
>>>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>>>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>>>> To: Valentin Schneider <vschneid@redhat.com>
>>>>> To: Vincent Guittot <vincent.guittot@linaro.org>
>>>>> To: Juri Lelli <juri.lelli@redhat.com>
>>>>> To: Peter Zijlstra <peterz@infradead.org>
>>>>> To: Ingo Molnar <mingo@redhat.com>
>>>>> ---
>>>>>  kernel/sched/topology.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>> index 10d1391e7416..8b45f16a1890 100644
>>>>> --- a/kernel/sched/topology.c
>>>>> +++ b/kernel/sched/topology.c
>>>>> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>>>>>   * function:
>>>>>   *
>>>>>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>>>>> + *   SD_CLUSTER             - describes CPU Cluster topologies
>>>>
>>>> So I know this is the naming we've gone for the "Cluster" naming, but this
>>>> comment isn't really explaining anything.
>>>>
>>>> include/linux/sched/sd_flags.h has a bit more info already:
>>>>  * Domain members share CPU cluster (LLC tags or L2 cache)
>>>
>>> I also thought of this, but I didn't want to suggest to repeat in topolog.c
>>> what is described in sd_flags.h.
>>>
>>> Maybe it is better to remove the descriptions of all flags here and instead
>>> direct the reader to sd_flags.h?
>>
>> yes, good idea for getting their meaning directly from the header file. 
>> So is it fine for next sending?
> 
> Some tweaks below.
> 
>>
>>     sched/fair: remove duplicate comments for SD_ flags
> 
>       sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS
>>     
>>     Originally, it missed SD_CLUSTER flag description, but comparing to copy
>>     the flags meaning from sd_flags.h, reader is better to get info from
>>     there.
> 
>       These flags are already documented in include/linux/sched/sd_flags.h.
> 
>       Keep the comment on SD_ASYM_PACKING as it is a special case.
>>     
>>     Keep SD_ASYM_PACKING unchange for a point from another way.
>>     
>>     Signed-off-by: Alex Shi <alexs@kernel.org>
>>     To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>     To: Valentin Schneider <vschneid@redhat.com>
>>     To: Vincent Guittot <vincent.guittot@linaro.org>
>>     To: Juri Lelli <juri.lelli@redhat.com>
>>     To: Peter Zijlstra <peterz@infradead.org>
>>     To: Ingo Molnar <mingo@redhat.com>
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 10d1391e7416..96a24bf954ad 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1551,11 +1551,7 @@ static struct cpumask            ***sched_domains_numa_masks;
>>   *
>>   * These flags are purely descriptive of the topology and do not prescribe
>>   * behaviour. Behaviour is artificial and mapped in the below sd_init()
>> - * function:
>> - *
>> - *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
>> - *   SD_SHARE_PKG_RESOURCES - describes shared caches
>> - *   SD_NUMA                - describes NUMA topologies
> 
> Maybe only remove the descriptions but keep the enumeration?
> 
>> + * function, for details in include/linux/sched/sd_flags.h:
> 
>       function. For details, see include/linux/sched/sd_flags.h.
> 

Thanks for comments. will update in next version.
> 

