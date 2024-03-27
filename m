Return-Path: <linux-kernel+bounces-121326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669588E602
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F551C2D74B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C623B15251D;
	Wed, 27 Mar 2024 12:56:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74468138481;
	Wed, 27 Mar 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544174; cv=none; b=huUIwCsCOBzzhkwW/oBHM0RdU75cbDlUj0rlPhhnkQcNLaX0DFrnbTElLr7xYr8Iyb+2jnMC+9njJk139v69eLkoA7trO6+l3rD7rrQz/65yDtQP+isfiqZ6ahlLkP4o1JkdFnnYBOq/CJ6fjqe/IHQd7/UygfH2CL0r2W7K3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544174; c=relaxed/simple;
	bh=WZJCVOkyTHYxcqXrLL5fJDRlkvGm4gLHduI+I7k25ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qi+LW77ETyP7KBKktOxXivuEz6PoV98WGd9i0uxVhkI3JM028WJOCtnHaBGzXTGr0sw7TJ4Jk6mzramR9k+6C6yHQoTnK8SwwKFDcGA8Px0q8HlH5sQAkLoY+k1+D8gbAjAXEvG6Ha9vwrJnKgU8sZVx9pW5M8DdNEA5/s163R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDD2C2F4;
	Wed, 27 Mar 2024 05:56:45 -0700 (PDT)
Received: from [192.168.178.110] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914273F7C5;
	Wed, 27 Mar 2024 05:56:09 -0700 (PDT)
Message-ID: <e02ca745-52df-4210-b175-f4ef278d81d8@arm.com>
Date: Wed, 27 Mar 2024 13:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 4/4] soc: samsung: exynos-asv: Update Energy
 Model after adjusting voltage
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-5-lukasz.luba@arm.com>
 <59d37960-cf19-4b10-802f-59d42496c133@arm.com>
 <d5d6ae17-3ba1-4cb8-909f-865e47bfa45b@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <d5d6ae17-3ba1-4cb8-909f-865e47bfa45b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2024 21:12, Lukasz Luba wrote:
> Hi Dietmar,
> 
> On 3/26/24 11:20, Dietmar Eggemann wrote:
>> On 22/03/2024 12:08, Lukasz Luba wrote:
>>
>> [...]
>>
>>> @@ -97,9 +98,17 @@ static int exynos_asv_update_opps(struct
>>> exynos_asv *asv)
>>>               last_opp_table = opp_table;
>>>                 ret = exynos_asv_update_cpu_opps(asv, cpu);
>>> -            if (ret < 0)
>>> +            if (!ret) {
>>> +                /*
>>> +                 * When the voltage for OPPs successfully
>>> +                 * changed, update the EM power values to
>>> +                 * reflect the reality and not use stale data
>>
>> At this point, can we really say that the voltage has changed?
>>
>>    exynos_asv_update_cpu_opps()
>>
>>      ...
>>      ret = dev_pm_opp_adjust_voltage()
>>      if (!ret)
>>        em_dev_update_chip_binning()
>>      ...
>>
>> dev_pm_opp_adjust_voltage() also returns 0 when the voltage value stays
>> the same?
>>
>> [...]
> 
> The comment for the dev_pm_opp_adjust_voltage() says that it
> returns 0 if no modification was done or modification was
> successful. So I cannot distinguish in that driver code, but
> also there is no additional need to do it IMO (even framework
> doesn't do this).

Precisely. That's why the added comment in exynos_asv_update_opps():
"When the voltage for OPPs successfully __changed__, ..." is somehow
misleading IMHO.


