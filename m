Return-Path: <linux-kernel+bounces-7295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72A81A507
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6491F28158
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3E46425;
	Wed, 20 Dec 2023 16:28:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1D4185B;
	Wed, 20 Dec 2023 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C23341FB;
	Wed, 20 Dec 2023 08:28:44 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06A4A3F64C;
	Wed, 20 Dec 2023 08:27:58 -0800 (PST)
Message-ID: <c5dfd399-2eb5-4f13-b4d4-02ed45bc3d9f@arm.com>
Date: Wed, 20 Dec 2023 16:29:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] thermal: gov_power_allocator: Refactor
 check_power_actors()
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231206113138.3576492-1-lukasz.luba@arm.com>
 <20231206113138.3576492-3-lukasz.luba@arm.com>
 <CAJZ5v0jSt87KXB0HPXhc+T05K0FgQNKzrNVj4NqYJ+a_WCJbWw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jSt87KXB0HPXhc+T05K0FgQNKzrNVj4NqYJ+a_WCJbWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 14:07, Rafael J. Wysocki wrote:
> On Wed, Dec 6, 2023 at 12:30 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Refactor check_power_actors() to make it possible for re-use in the
>> upcoming new callback.
> 
> I would say "In preparation for a subsequent change, rearrange
> check_power_actors()".

Agree, I'll use it.

>>
>> No intentional functional impact.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 785fff14223d..38e1e89ba10c 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -581,8 +581,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
>>    * power actor API. The warning should help to investigate the issue, which
>>    * could be e.g. lack of Energy Model for a given device.
>>    *
>> - * Return: 0 on success, -EINVAL if any cooling device does not implement
>> - * the power actor API.
>> + * Return number of cooling devices or -EINVAL if any cooling device does not
>> + * implement the power actor API. Return value 0 is also valid since cooling
>> + * devices might be attached later.
> 
> I would say "If all of the cooling devices currently attached to @tz
> implement the power actor API, return the number of them (which may be
> 0, because some cooling devices may be attached later).  Otherwise,
> return -EINVAL."
> 

Yes, I'll use that sentence as well.
Those will be in the next version (v3). Thanks!

