Return-Path: <linux-kernel+bounces-67425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A5856B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC11C225A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF513699E;
	Thu, 15 Feb 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uD5iNDHI"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1597134728
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018924; cv=none; b=pquCMvaTpyhjOgPUHeYFchWIf9j3tlGplCs84JVO5hJrVmrt+sx+12B/f0sUV6XmQ0+yL0PdJ+Zw7/COmF7ADGk7s3MAKfjfLgRMcO31a6CSI7haZO+TZeG79faAGcHpoj5mQiDIoNleShdNMWHq06HOtcT9NXXO3PVD8bsDF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018924; c=relaxed/simple;
	bh=38R0rU2CgWAAya1k2BUAW737HtFNx7aJpgcyGR5rRzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz2jiMGsnheYZVALLB/OVe3QklOsKtEMqESPE190b7lcME5+momdsOFdSYIA4X3XiE+P5ZkLV1xwaVTzG1uMIt1AgyWrHR3AjJ1/RGzbAj24XoOgicpiDLzSlyy28drfd3dMRFKaSouoQj1XnNKijVzX5lfC7g7lnKpI6wpRE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=uD5iNDHI; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-20503dc09adso707753fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708018922; x=1708623722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5L4fpc4m7kJwWR2VxmFIgzvqS8bV7y18bvgmBXCUx/c=;
        b=uD5iNDHI72JffTyGWhPSuqJATs3p/zL/xWwXnOLKCUagAsqf1sgL3wI7W7QoP993SK
         xNgUnA9MmmERbtNUi/mCFsdd/2OOOvZql+utj+tGl+B3FuMaHT9rtbo4rT1B7DlnB4bn
         EnAR2gyIBcgiB9PUGfSTjp004w8p6HiFcG6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018922; x=1708623722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L4fpc4m7kJwWR2VxmFIgzvqS8bV7y18bvgmBXCUx/c=;
        b=lMdvugVEx3BOmG3lYYqca1PwfR7U+tRj+fUKSCGusZHPS2FT/Al1WEpiDnxeRPhwt6
         BSzFy+7ka2S/MpXaweedtcK21kgV9+4HSYf3ow1QHcc/1Q2zP+y2bFkOBM9tWvFL/0Cr
         3X5iWB6c28YcHGyluCZKR/QHC8cH444pTSb7nm6IktMBQKJLrrXcq7CPHP+XrXLhEfHx
         6v6favM00nFECiinkmYGOP2U9yuloMf8593I+5pn1PcIzI0dGjmC7F5oxFDkfi2dmW26
         2SSIRBSS3sRoQcam0Kry0UygTppC2T4lHsHU1nmy/ALWrhsMjo1ksSFS4THRiS7uqKDD
         MiVg==
X-Forwarded-Encrypted: i=1; AJvYcCX1To46rRrZOyxdMwecK7gL61rmergloKPgHGlwDKJjMovOzJlAR0tcPiTUQ6KruHa1DodfowZi1Jo2pcx64DTA0zL9+7Be14rE/70/
X-Gm-Message-State: AOJu0YzWRc6BP899i6PIKI0BTtHfgqOkkkZ63YNwA+cSaZSOGCoW6mlK
	VodCAXYiB9KPxToTaC9f1zp/b7ODypNde1t44oXJ4Non7LAAcID1Py8OSBnhTWM=
X-Google-Smtp-Source: AGHT+IHRFVoDzisEa4qjjv5SxZFJHqouCbXo1EytmsScKA5ZvHfwxgXSf+HUj+WcNQuclfgo9BG9tg==
X-Received: by 2002:a05:6871:5213:b0:218:51a7:66bc with SMTP id ht19-20020a056871521300b0021851a766bcmr2442762oac.19.1708018921885;
        Thu, 15 Feb 2024 09:42:01 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id br37-20020a05620a462500b00787346f1edasm780529qkb.54.2024.02.15.09.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:42:01 -0800 (PST)
Message-ID: <b3e053bf-c9f5-492d-baff-8f251fb00279@joelfernandes.org>
Date: Thu, 15 Feb 2024 12:41:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] sched/fair: Fair server interface
Content-Language: en-US
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, youssefesmat@google.com
References: <cover.1699095159.git.bristot@kernel.org>
 <26adad2378c8b15533e4f6216c2863341e587f57.1699095159.git.bristot@kernel.org>
 <8cbf4bcd-431b-466f-b62d-ee03932e97f5@joelfernandes.org>
 <091ca2ea-202d-4685-92ea-529186a94f0a@kernel.org>
 <a4af4bac-92bd-44e9-93d2-dc22dc9a81ad@joelfernandes.org>
 <07b1844a-a9d4-47fb-aea0-c0722b2a8001@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <07b1844a-a9d4-47fb-aea0-c0722b2a8001@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/15/2024 12:27 PM, Daniel Bristot de Oliveira wrote:
> On 2/15/24 14:57, Joel Fernandes wrote:
>> Hello, Daniel,
>>
>> On 2/14/2024 9:23 AM, Daniel Bristot de Oliveira wrote:
>>> On 2/13/24 03:13, Joel Fernandes wrote:
>>>>
>>>>
>>>> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>>>>> Add an interface for fair server setup on debugfs.
>>>>>
>>>>> Each rq have three files under /sys/kernel/debug/sched/rq/CPU{ID}:
>>>>>
>>>>>  - fair_server_runtime: set runtime in ns
>>>>>  - fair_server_period: set period in ns
>>>>>  - fair_server_defer: on/off for the defer mechanism
>>>>
>>>> Btw Daniel, there is an interesting side-effect of this interface having runtime
>>>> and period in 2 separate files :)
>>>>
>>>> Say I want to set a CPU to 5ms / 10ms.
>>>>
>>>> I cannot set either period or runtime to 5ms or 10ms directly.
>>>>
>>>> I have to first set period to 100ms, then set runtime to 50ms, then set period
>>>> to 50ms, then set runtime to 5ms, then finally set period to 10ms.
>>>
>>> Hummm yeah I could reproduce that, it seems that it is not even a problem of having
>>> two files, but a bug in the logic, I will have a look.
>>
>> Thanks for taking a look. My colleague Suleiman hit the issue too. He's able to
>> not set 45ms/50ms for instance.
> 
> I isolated the problem. It is not an interface problem.
> 
> Long story short, the servers are initialized at the defrootdomain, but
> the dl_bw info is not being carried over to the new domain because the
> servers are not a task.

Nice work on nailing the issue.

> I am discussing this with Valentin (topology) & Juri. We will try to find a
> solution, or at least an presentable XXX: solution... in the next days.
> 
> You can work around it by disabling the admission control via:
> 
> # sysctl kernel.sched_rt_runtime_us=-1
> 
> the the values will be accepted. For the best of my knowledge, you guys are
> only using SCHED_RR/FIFO so the admission control for DL is not an issue.

That's right, we only use deadline for the server. However, on some devices,
schedutil is used and AFAIR its kthread uses SCHED_DEADLINE. I don't anticipate
problems related to admission control and that kthread, so I think your proposed
workaround sounds good to me.

thanks,

 - Joel



