Return-Path: <linux-kernel+bounces-159025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1389F8B2845
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE08B2298B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E113F438;
	Thu, 25 Apr 2024 18:42:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7893A1BB;
	Thu, 25 Apr 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070542; cv=none; b=gvu+urXQ4TS3c2h//ldnmjuMsdLVNUAJbQTJBo6G9flo90nY3Cv/8hH6hvkCu4AmflirW7GJuVndYJ0BOH/n4XnyzylDuRTvVTbSgk90SD84aEmb3ZJszkfyFPhlV3M9HqY5tYuk8Of7eeq+n3RIsRw6BTPKVYd4mU9t4NqfPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070542; c=relaxed/simple;
	bh=vuWaZ//9gL0kA2Wo2XJ/umK6tfwaAhyZYGGSZGoij/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYYRRJz+wiksVAYUKqrtcb/cCciMRpCbGl8YkgwGIVxuqVB7r1en4xaanOSC+EsmsjXDHl1eqpcGYjpMxyN3m+jDKUgmCNr1eIKSLiZYOHRTXeY4qn6gQQbUIUeIgGrMAt7LwYettBYRPc/H0VDkPdNkKP/51Z7Pp+n57rpeqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B01102F;
	Thu, 25 Apr 2024 11:42:48 -0700 (PDT)
Received: from [10.57.75.39] (unknown [10.57.75.39])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CD553F793;
	Thu, 25 Apr 2024 11:42:19 -0700 (PDT)
Message-ID: <4f21ee21-0178-4d50-a535-4d530baf82d1@arm.com>
Date: Thu, 25 Apr 2024 19:42:17 +0100
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0ik_EqSXzTkowz=ha-U+JU+=KtqEMwD5+r329og2d4t=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/25/24 14:00, Rafael J. Wysocki wrote:
> On Thu, Apr 25, 2024 at 2:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> Hi Lukasz,
>>
>> On Thu, Apr 25, 2024 at 12:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> On 4/23/24 19:00, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> If cdev_dt_seq_show() runs before the first state transition of a cooling
>>>> device, it will not print any state residency information for it, even
>>>> though it might be reasonably expected to print residency information for
>>>> the initial state of the cooling device.
>>>>
>>>> For this reason, rearrange the code to get the initial state of a cooling
>>>> device at the registration time and pass it to thermal_debug_cdev_add(),
>>>> so that the latter can create a duration record for that state which will
>>>> allow cdev_dt_seq_show() to print its residency information.
>>>>
>>>> Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debugfs information")
>>>> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>    drivers/thermal/thermal_core.c    |    9 +++++++--
>>>>    drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
>>>>    drivers/thermal/thermal_debugfs.h |    4 ++--
>>>>    3 files changed, 19 insertions(+), 6 deletions(-)
>>>>
>>>
>>> I'm trying to test it on my board and do the review, but faced issue.
>>> For some reason I couldn't apply that patch on the latest bleeding-edge
>>> branch.
>>> Could you help me in this please? Is there something missing in the
>>> patch set (like one more fist patch)?
>>
>> I messed up the ordering of patches (patch [2/3] should be the last
>> one in the series) and on top of that, you'll need a small rebase on
>> that patch.
>>
>> Sorry about this, I'll send a v2.
> 
> Actually, the ordering was OK, but the rebase of the second patch is
> still needed.  I'll send a v2.

Thanks, I've seen it. That v2 applies smoothly and runs on the board.
I'll test it and review.

