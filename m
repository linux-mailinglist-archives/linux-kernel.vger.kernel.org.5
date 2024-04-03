Return-Path: <linux-kernel+bounces-130025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DD897357
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0782284DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2C14A4F9;
	Wed,  3 Apr 2024 15:03:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D811149C77;
	Wed,  3 Apr 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156597; cv=none; b=bzKY6X+FTt7LD6mNSIGyoWYazNdkz6I5N2dR9uwoqaQWcCVEmpuS7Zlmt0jwIe2GDpvqWUInlYVa1i76iT9bQwbgPiNsvYz+YkLifr+joHt6fvfdkESAQDvC6KSO3vfUjHH6x4yRslKeILd/M5jI0KtwCcIl8gbHjvokNUg/d6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156597; c=relaxed/simple;
	bh=Frz84vO4VsjdnU9kefMIEq/lRqmniHBcyzlIQjKHI/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbJsnjZuHC3zLEQBgslLPC5O6po6Al1ByLTGikluGW98VkUPXYW/xCKv5RuvOwNM0iXc8zQbnHglKH8NDegJCy79fH/2gHjSIB5GJTWjquE9rog8q2zXQsATwT+1yTu0KgFM/6qJQUy3vi8eVxL9Aw4+iFx5UfoxW4FBpLuTjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC4BD1007;
	Wed,  3 Apr 2024 08:03:46 -0700 (PDT)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77B453F7B4;
	Wed,  3 Apr 2024 08:03:14 -0700 (PDT)
Message-ID: <89f37c4a-a1fd-4806-9d05-0dc347252b4d@arm.com>
Date: Wed, 3 Apr 2024 16:03:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] thermal: gov_power_allocator: Allow binding
 without cooling devices
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, Nikita Travkin <nikitos.tr@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-1-79bdd8439449@trvn.ru>
 <d048f863-05d1-4aeb-8904-4c09ecbe55d9@arm.com>
 <CAJZ5v0gU+a60EvKKnGsgS32YoaQE8RffwPSrbbV2APSFKgn+UA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gU+a60EvKKnGsgS32YoaQE8RffwPSrbbV2APSFKgn+UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/24 15:41, Rafael J. Wysocki wrote:
> On Wed, Apr 3, 2024 at 2:44 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
>>> From: Nikita Travkin <nikita@trvn.ru>
>>>
>>> IPA was recently refactored to split out memory allocation into a
>>> separate funciton. That funciton was made to return -EINVAL if there is
>>> zero power_actors and thus no memory to allocate. This causes IPA to
>>> fail probing when the thermal zone has no attached cooling devices.
>>>
>>> Since cooling devices can attach after the thermal zone is created and
>>> the governer is attached to it, failing probe due to the lack of cooling
>>> devices is incorrect.
>>>
>>> Change the allocate_actors_buffer() to return success when there is no
>>> cooling devices present.
>>>
>>> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>>>    drivers/thermal/gov_power_allocator.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>>> index 1b17dc4c219c..ec637071ef1f 100644
>>> --- a/drivers/thermal/gov_power_allocator.c
>>> +++ b/drivers/thermal/gov_power_allocator.c
>>> @@ -606,7 +606,7 @@ static int allocate_actors_buffer(struct power_allocator_params *params,
>>>
>>>        /* There might be no cooling devices yet. */
>>>        if (!num_actors) {
>>> -             ret = -EINVAL;
>>> +             ret = 0;
>>>                goto clean_state;
>>>        }
>>>
>>>
>>
>> LGTM
>>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Applied as 6.9-rc material along with the [2/3], thanks!
> 

Thank you Rafael!

