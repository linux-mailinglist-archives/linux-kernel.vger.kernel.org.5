Return-Path: <linux-kernel+bounces-7291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540181A4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A431F27415
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1E4495C8;
	Wed, 20 Dec 2023 16:24:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9254655A;
	Wed, 20 Dec 2023 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A751FB;
	Wed, 20 Dec 2023 08:24:43 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBDC93F64C;
	Wed, 20 Dec 2023 08:23:57 -0800 (PST)
Message-ID: <9344980f-5be6-4973-95b5-0e31cffe30da@arm.com>
Date: Wed, 20 Dec 2023 16:25:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add callback for cooling list update to speed-up
 IPA
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com,
 linux-kernel@vger.kernel.org
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <b2f9db3f-96a4-4e1e-9be0-32f19948c489@arm.com>
 <CAJZ5v0jx=Nm0zrKeGuDkkiskCT_LOF77fVFWt-mATkf3X9qUDQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jx=Nm0zrKeGuDkkiskCT_LOF77fVFWt-mATkf3X9qUDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 13:37, Rafael J. Wysocki wrote:
> On Wed, Dec 20, 2023 at 1:53 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Daniel, Rafael,
>>
>> On 12/12/23 13:48, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> The patch set a new callback for thermal governors and implementation for
>>> Intelligent Power Allocator.
>>>
>>> The goal is to move some heavy operarions like the memory allocations and heavy
>>> computations (multiplications) out of throttle() callback hot path.
>>>
>>> The new callback is generic enough to handle other imporants update events.
>>> It re-uses existing thermal_notify_event definitions.
>>>
>>> In addition there are some small clean-ups for IPA code.
>>>
>>> changes:
>>> v2:
>>> - change callback name to update_tz() and add parameter (Rafael)
>>> - added new event to trigger this callback - instance 'weight' update
>>>
>>> Regards,
>>> Lukasz
>>>
>>> Lukasz Luba (8):
>>>     thermal: core: Add governor callback for thermal zone change
>>>     thermal: gov_power_allocator: Refactor check_power_actors()
>>>     thermal: gov_power_allocator: Move memory allocation out of throttle()
>>>     thermal: gov_power_allocator: Simplify checks for valid power actor
>>>     thermal: gov_power_allocator: Refactor checks in divvy_up_power()
>>>     thermal/sysfs: Update instance->weight under tz lock
>>>     thermal/sysfs: Update governors when the 'weight' has changed
>>>     thermal: gov_power_allocator: Support new update callback of weights
>>>
>>>    drivers/thermal/gov_power_allocator.c | 216 ++++++++++++++++++--------
>>>    drivers/thermal/thermal_core.c        |  13 ++
>>>    drivers/thermal/thermal_sysfs.c       |  15 ++
>>>    include/linux/thermal.h               |   6 +
>>>    4 files changed, 182 insertions(+), 68 deletions(-)
>>>
>>
>> I know it's a bit late in time period...
>> You probably missed that patch set in your mailbox.
>> This patch set can probably just wait to the next window, or
>> should I resend it later in 2024?
> 
> Not really, I was about to comment one the first patch.
> 
> I'll do that shortly.
> 

Thank you for the comments. I'll send a v3 with changes.

