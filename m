Return-Path: <linux-kernel+bounces-86375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE286C494
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E2AB24497
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12258128;
	Thu, 29 Feb 2024 09:11:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406C5788E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197883; cv=none; b=Vax/njFghYfohXxPd4ZxZcybfxmzlrMPDVNJO4J5L+4hWAu5bkc0ysZwI/bZ/l8LkFe8aAEeWw3YVG2BH48DamCkMGMEIrW9Jb/NuOSmrgUE4aM1taq3GCkGnj1bIRW5KIgzYzgAE7AcI89/obdl+3o0p8RqFK7fWhCMJUlrh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197883; c=relaxed/simple;
	bh=wzuplOLv4wlaYt2/x9o+UtsMuM1pQzwC9hVrwl7L6Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLn4FfD6XPtia0Xhvb1bYXNUnHDfGEiAbFIVDVmUwInEud0f1AxAkOK/5DgGUzziIJlkFq/4Kcaxxc5dcLOPc8h8sw49kiJ+XDkwCc5iikXmy/8JeNe6rV/uJsH+b2v/7Ipip4O0x987gubjnLUCNqqmSaNEGVpXISI3rJb/GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 751671FB;
	Thu, 29 Feb 2024 01:11:59 -0800 (PST)
Received: from [10.34.100.133] (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC563F6C4;
	Thu, 29 Feb 2024 01:11:18 -0800 (PST)
Message-ID: <26af2033-c5e0-43a1-8953-35435ffbbdd0@arm.com>
Date: Thu, 29 Feb 2024 10:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/fair: Add EAS checks before updating
 overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: yu.c.chen@intel.com, dietmar.eggemann@arm.com,
 linux-kernel@vger.kernel.org, nysal@linux.ibm.com, aboorvad@linux.ibm.com,
 srikar@linux.vnet.ibm.com, vschneid@redhat.com, morten.rasmussen@arm.com,
 qyousef@layalina.io, mingo@kernel.org, peterz@infradead.org,
 vincent.guittot@linaro.org
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240228071621.602596-2-sshegde@linux.ibm.com>
 <86f000a3-3068-4c57-858d-c00e3eb6e974@arm.com>
 <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <72c2d279-90ae-4612-9b96-e579333b8088@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Shrikanth,

On 2/28/24 18:24, Shrikanth Hegde wrote:
> 
> 
> On 2/28/24 9:28 PM, Pierre Gondois wrote:
> 
> Hi Pierre, Thanks for taking a look.
> 
>> It is nice to avoid calling effective_cpu_util() through the following
>> when EAS is not enabled:
>> I think we are avoiding calling cpu_overutilized except in update_sg_lb_stats.
> I didnt want to put a EAS check in cpu_overutilized as it could be useful
> function in non-EAS cases in future. calling cpu_overutilized alone doesnt
> do any access to root_domain's overutilized field. So we are okay w.r.t to
> cache issues.
> But we will do some extra computation currently and then not use it if it
> Non-EAS case in update_sg_lb_stats
> 
> Would something like this makes sense?
> @@ -9925,7 +9925,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                  if (nr_running > 1)
>                          *sg_status |= SG_OVERLOAD;
>   
> -               if (cpu_overutilized(i))
> +               if (sched_energy_enabled() && cpu_overutilized(i))
>                          *sg_status |= SG_OVERUTILIZED;
>   

Yes right. I think that what Dietmar suggested is also a good idea
which could be used instead.

> 
> 
> 
> I didnt find how would util_fits_cpu ends up calling effective_cpu_util.
> Could you please elaborate?

Sorry I meant this path:
cpu_overutilized()
\-cpu_util_cfs()
   \-cpu_util()

effective_cpu_util() is effectively not involved.

> 
>> cpu_overutilized()
>> \-util_fits_cpu()
>>    \- ...
>>      \-effective_cpu_util()
>>

[snip]

Regards,
Pierre

