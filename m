Return-Path: <linux-kernel+bounces-153293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE08ACC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D768E1F22C59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F86146A6A;
	Mon, 22 Apr 2024 11:37:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47D1465A2;
	Mon, 22 Apr 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785832; cv=none; b=lORtStMAnGJ7eOBC0SDj51pD+Z5HdOPkKbuDRElNTRG5cUnVnrSg1Wsf8iF2uiyHsWBmdvbbOqai601/bYf0y0XAEWqAkpkEp79tKRLUB4xX/E0kW8RrumFV9NPFIlgiMlt8RlLi9eT9avQKvUDiw5icKe31eo4KdSdXrehh/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785832; c=relaxed/simple;
	bh=giz8ndf4KlmCclo1HmturdVYzZOBqqSQfzj8LZLKAiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOEOvIVHQDGzybp8zdf6vhHnbDFaDzSJ+AYphN1jc0y5hef7JMFjQs9pcTgdTLcQPHLKI4+3quRsyBsmT1ddTlLUKRzGcdkImn0kuuHndLDtj+Iq9hX8CIuiDMTwA5442OXNrTLwtQvv7Hqzz9i9dczR6EaxsF785NbCLPY5ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD02339;
	Mon, 22 Apr 2024 04:37:38 -0700 (PDT)
Received: from [10.57.75.149] (unknown [10.57.75.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D6C3F7BD;
	Mon, 22 Apr 2024 04:37:09 -0700 (PDT)
Message-ID: <3a8f1978-c5df-40d6-91ca-276431bb01e1@arm.com>
Date: Mon, 22 Apr 2024 12:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] thermal/debugfs: Fix and clean up trip point
 statistics updates
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <4918025.31r3eYUQgx@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4918025.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/17/24 14:07, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> The first patch in this series addresses the problem of updating trip
> point statistics prematurely for trip points that have just been
> crossed on the way down (please see the patch changelog for details).
> 
> The way it does that renders the following cleanup patch inapplicable:
> 
> https://lore.kernel.org/linux-pm/2321994.ElGaqSPkdT@kreacher/
> 
> The remaining two patches in the series are cleanups on top of the
> first one.
> 
> This series is based on an older patch series posted last week:
> 
> https://lore.kernel.org/linux-pm/13515747.uLZWGnKmhe@kreacher/
> 
> but it can be trivially rebased on top of the current linux-next.
> 
> Thanks!
> 
> 
> 

I've checked this patch patch set on top of your bleeding-edge
which has thermal re-work as well. The patch set looks good
and works properly.

Although, I have found some issue in this debug info files and
I'm not sure if this is expected or not. If not I can address this
and send some small fix for it.

When I read the cooling device residency statistics, I don't
get updates for the first time the state is used. It can only
be counted when that state was known and finished it's usage.

IMO it is not the right behavior, isn't it?

Experiment:
My trip points are 70degC and 75degC and I'm setting emulated
temperature to cross them and get cooling states 1 then 0.
As you can see the statistics counter only starts showing value after
after trip crossing down.
------------------------------------8<-----------------------------------

root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
root@arm:~#
root@arm:~#
root@arm:~# echo 71000 > /sys/class/thermal/thermal_zone0/emul_temp 

root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
root@arm:~# echo 76000 > /sys/class/thermal/thermal_zone0/emul_temp 

root@arm:~#
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       518197
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       518197
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       518197
root@arm:~# echo 71000 > /sys/class/thermal/thermal_zone0/emul_temp 

root@arm:~#
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       520066
1       17567
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       522653
1       17567
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       526151
1       17567
root@arm:~# echo 66000 > /sys/class/thermal/thermal_zone0/emul_temp 

root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       537366
1       17567
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       544936
1       17567
root@arm:~# cat 
/sys/kernel/debug/thermal/cooling_devices/0/time_in_state_ms
State   Residency
0       556694
1       17567
root@arm:~#

------------------------------->8----------------------------------------

Please let me know what do you think about that behavior.

Regards,
Lukasz

