Return-Path: <linux-kernel+bounces-159042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97A8B288E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149161F23695
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30E3152186;
	Thu, 25 Apr 2024 18:55:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A21514DE;
	Thu, 25 Apr 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071337; cv=none; b=BQhDJE2OX0CqzJMpO9NSbqIFq7BwhPseb+2yrNa301knWLeVVqkKWktnQ+Yl+pzcrG0KECofgeDj5kh4EojdeBLuGWdtRdIK2FLMTy5DcRkVl+DXMcvYmo2DUrw8+nZe2iuEH0ujq14kaLEj1uaT6yXQHeuNO5xMfWntyDx2onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071337; c=relaxed/simple;
	bh=FxDmiqcpQtTAg8MwB+A5Ghr03gw4rpc4QbTB94+pWZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGmxAv75RUCW9CO9eobY7EVxbbMc3CGwjbGLTP2CJnjXTtYVQKmXw/XHZXEuNlB7vkMCFg1V6UXy2MYILHNK42//jgPFU4TlZ6zYRbBN+cFYF14WtnK29CSeMmXnl14QyqU0TE7y1FSMvjlNENdK4zGykrP/aPYdMQBa6bzM6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DEAF2F;
	Thu, 25 Apr 2024 11:56:03 -0700 (PDT)
Received: from [10.57.75.39] (unknown [10.57.75.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0CF03F793;
	Thu, 25 Apr 2024 11:55:33 -0700 (PDT)
Message-ID: <ce95f95d-c004-4814-bdb0-d230731084d3@arm.com>
Date: Thu, 25 Apr 2024 19:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to
 thermal_debug_cdev_add()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher>
 <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com>
 <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
 <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com>
 <4f21ee21-0178-4d50-a535-4d530baf82d1@arm.com>
 <CAJZ5v0je44QB=dBObgDd-1pJweXdj5ZC-7sEyrOjyJ+c=n9xPQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0je44QB=dBObgDd-1pJweXdj5ZC-7sEyrOjyJ+c=n9xPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/25/24 19:53, Rafael J. Wysocki wrote:
> On Thu, Apr 25, 2024 at 8:42 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 4/25/24 14:00, Rafael J. Wysocki wrote:
>>> On Thu, Apr 25, 2024 at 2:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On Thu, Apr 25, 2024 at 12:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> On 4/23/24 19:00, Rafael J. Wysocki wrote:
>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>
>>>>>> If cdev_dt_seq_show() runs before the first state transition of a cooling
>>>>>> device, it will not print any state residency information for it, even
>>>>>> though it might be reasonably expected to print residency information for
>>>>>> the initial state of the cooling device.
>>>>>>
>>>>>> For this reason, rearrange the code to get the initial state of a cooling
>>>>>> device at the registration time and pass it to thermal_debug_cdev_add(),
>>>>>> so that the latter can create a duration record for that state which will
>>>>>> allow cdev_dt_seq_show() to print its residency information.
>>>>>>
>>>>>> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
>>>>>> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
>>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>> ---
>>>>>>     drivers/thermal/thermal_core.c    |    9 +++++++--
>>>>>>     drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
>>>>>>     drivers/thermal/thermal_debugfs.h |    4 ++--
>>>>>>     3 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>
>>>>>
>>>>> I'm trying to test it on my board and do the review, but faced issue.
>>>>> For some reason I couldn't apply that patch on the latest bleeding-edge
>>>>> branch.
>>>>> Could you help me in this please? Is there something missing in the
>>>>> patch set (like one more fist patch)?
>>>>
>>>> I messed up the ordering of patches (patch [2/3] should be the last
>>>> one in the series) and on top of that, you'll need a small rebase on
>>>> that patch.
>>>>
>>>> Sorry about this, I'll send a v2.
>>>
>>> Actually, the ordering was OK, but the rebase of the second patch is
>>> still needed.  I'll send a v2.
>>
>> Thanks, I've seen it. That v2 applies smoothly and runs on the board.
>> I'll test it and review.
> 
> Thank you!
> 
> Please also see
> 
> https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/
> 
> which is actually more urgent because the fixes there address more
> serious issues (I would even consider them as 6.9-rc material).

Yes, I've read that patches' headers and glanced through the code.
I'll do the review & testing on them as well today.


