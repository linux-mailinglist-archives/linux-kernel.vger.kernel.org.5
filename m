Return-Path: <linux-kernel+bounces-47792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301F8452F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9218D1F23038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366515AACE;
	Thu,  1 Feb 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYgnyk0W"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288A2E3FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776913; cv=none; b=Fs0LHZ706OSzPIOq7M611/kJOJ0GwiBv5WSxoQXaT2WHzmQmaqOkjlHdnuh1z+3eqwIhA/8MxQJjOSjgLyCjYBNIr6FRW0YZiR54hGa/mHy98se8kx6qaZB183UiyhQ76MJPqWKM7lCgyztCexnqpUi3Y9A01RjgJhkUcaFlM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776913; c=relaxed/simple;
	bh=Vzju7W+IjNdwglfc44+Hjdx7ZHSiHR/m/5nHV/EkTVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONMM4P+wkO/8Oj1DlCJTQ8PrzJ3y/qBcOwfROWstCfsyBlbrT6pns7Udwj9FHWb4MeNzQyqUH5ZC9sbVLi5zAfrZl5HCecJ8ZwrxlZTdlfvp1dcs2GtnpXFRG9+MQMzjGI+RohHVfMtJYH0tl4C2qWEwhV0fH4Jijw7m4X9c46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYgnyk0W; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be3753e002so349026b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706776911; x=1707381711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrlsSLxbWQrmBnhYxqoorX1XNnQRO/DomwYkHslWCyQ=;
        b=XYgnyk0WkNcoaI7BdottU84A1uKfn/CIypO0gbokagfb07WUuG3Yi3sdahcjaboV3Y
         7+FT3HFPCc9SOZv+xEnHAG5xMNWRegaT8lzoHz3d4Gcx3iXF724PbqRg8QXHhEGffiaW
         I5hjGGMRtm+RIogWCPzdhWzbykHDWm47T3CWOKAReuCcEhcEzwTmKKW6JpA2AVzptu9D
         cEGgdOGaiRBXGUke9/ke9UdjLc9KtA4ovvMLSF/kcl6uVbHFvCrKtvjaUkJApoIXBejD
         PljLxz2aHOSJBkh/7ldRGKkQ1cEk1zB9nMr91im0k4JRk9qsN0yx9AAD7RCaSlqnNyHa
         BtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776911; x=1707381711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrlsSLxbWQrmBnhYxqoorX1XNnQRO/DomwYkHslWCyQ=;
        b=Pzl9fWgRFHBHj7Wngm5plUYm/+5aCoQb6UKOqTNVE8mWrvhLQqpPUBuV+r7pIAHh4C
         /ejTFlT1PPDaFzO8v+SNT6sRV/0Ha+dhpehJ0NVHr2m9wprEpJobQBeeSmuRdfwskTv8
         ndmpNzKslRXdKAT7ByTUESIwLEqWnwoUKUouPys4CNiREAZ8Y2qNIXqS52JNKXJmFgLX
         xLxmOtthSw9gxtEP+muSUd6DPQYbZetqlWFQw+OgAQP65X+6dUhRaR+dww22uAUqRF3/
         sYmtMSduvi/O8N4bcnMA71Ct/I5wkCKNf25fa5hv6wuuAtXDcaf/sGyOGsaGD5FltDmo
         2nEg==
X-Gm-Message-State: AOJu0YwJ+Q9TENIQauLJ9zjgXe3YF9vorDPIxliRR9yISwAso7wKTmtO
	CGvIW2khwpzdFkN6BCenvay/zed8FPlowFqmTcU/hfFS4NsNoUnn
X-Google-Smtp-Source: AGHT+IHmFoocETjIyIfZd9UDIAb0iJgXkp7OFWDtYhUA+dPhQ5QsaT7UM4HX8crBls7v9p3xUB9U2w==
X-Received: by 2002:aca:1c14:0:b0:3bd:2fbd:23d5 with SMTP id c20-20020aca1c14000000b003bd2fbd23d5mr4046103oic.49.1706776911219;
        Thu, 01 Feb 2024 00:41:51 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id fn17-20020a056a002fd100b006dd84763ce3sm11254801pfb.169.2024.02.01.00.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:41:50 -0800 (PST)
Message-ID: <76e24d20-b966-4efb-a83c-583618a7d3c7@gmail.com>
Date: Thu, 1 Feb 2024 16:41:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] sched/fair: cleanup sched_use_asym_prio
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 sshegde@linux.ibm.com
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-3-alexs@kernel.org>
 <20240201011346.GE18560@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240201011346.GE18560@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 9:13 AM, Ricardo Neri wrote:
> On Tue, Jan 30, 2024 at 09:17:05PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> And simplify the one line code. No function change.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 8d70417f5125..ebd659af2d78 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9741,10 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
>>   */
>>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  {
>> -	if (!sched_smt_active())
>> -		return true;
>> -
>> -	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>> +	return (!sched_smt_active()) ||
>> +		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
> 
> I think that compressing the two conditions into one hurts readability.

Sure, will remove this change.

Thanks
Alex

> As implemented, it is clear that no further checks are required if there
> is no SMT.
> 
> Also, please see my comment in patch 6/6.
>  

