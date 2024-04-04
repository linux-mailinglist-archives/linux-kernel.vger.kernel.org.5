Return-Path: <linux-kernel+bounces-131313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F270589860F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D33228840A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7B839E0;
	Thu,  4 Apr 2024 11:30:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721880BF7;
	Thu,  4 Apr 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230246; cv=none; b=DHJmDwkGFl0uoVd2Z1y2kQPMqEZ64oYjWVtZ5gkgN4rTZtWGntAAy6toxc2kQXJlnMx5WVP/A6idh+gtHCuOv/c1629NzG2r9/+gKQroUOpqjwPwMqmNfohML+v5vYaqfgZQnUmmLQuc6LGMs06jEWbdagwYqnuQSzsRfyVv0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230246; c=relaxed/simple;
	bh=pLVCf5e5q5NTHQHwxvNXS0PZwUAJ8fkbWjKNs0T5vac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ki1CbEAA0bB3H3piRH0ItB0ac64f3u/JPDn449vJd6J8ELM0HC4jtO7jFQ8f64KUz+/Ovmoei/L3L9mwnykxySKNXxVucxggNIOiJtANx4kVt4gYTxCWD8Fl8zZmIIkRN8dgfBLyhkW8/35hOJy/Hv9IJRAAEXwt+z11IQ/mMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F60FEC;
	Thu,  4 Apr 2024 04:31:14 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0ACE3F7B4;
	Thu,  4 Apr 2024 04:30:42 -0700 (PDT)
Message-ID: <b7821258-d0aa-4c04-9911-f4e6be0d4371@arm.com>
Date: Thu, 4 Apr 2024 12:30:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] thermal: More separation between the core and
 drivers
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
References: <4558251.LvFx2qVVIh@kreacher>
 <CAJZ5v0iSyTP4SbGBYESNy9NynMCQn8dojCFoOtQU4Q305ZKGTQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iSyTP4SbGBYESNy9NynMCQn8dojCFoOtQU4Q305ZKGTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/2/24 20:42, Rafael J. Wysocki wrote:
> On Tue, Apr 2, 2024 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> Hi Everyone,
>>
>> This is an update of
>>
>> https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/
>>
>> and
>>
>> https://lore.kernel.org/linux-pm/2331888.ElGaqSPkdT@kreacher/
>>
>> which rebases the first patch on top of 6.9-rc2, adds 3 patches and adjusts
>> the third patch from v2.
>>
>> The original description of the first two patches still applies:
>>
>>> Patch [1/2] is based on the observation that the threshold field in struct
>>> thermal_trip really should be core-internal and to make that happen it
>>> introduces a wrapper structure around struct thermal_trip for internal
>>> use in the core.
>>>
>>> Patch [2/2] moves the definition of the new structure and the struct
>>> thermal_zone_device one to a local header file in the core to enforce
>>> more separation between the core and drivers.
>>>
>>> The patches are not expected to introduce any observable differences in
>>> behavior, so please let me know if you see any of that.
>>
>> Note that these patches were first sent before the merge window and have not
>> really changed since then (except for a minor rebase of the first patch in
>> this series).  Moreover, no comments regarding the merit of these patches
>> have been made shared, so if this continues, I will be considering them as
>> good to go by the end of this week.
>>
>> Patch [3/6] is a rewrite of comments regarding trip crossing and threshold
>> computations.
>>
>> Patch [4/6] updates the trip crossing detection code to consolidate the
>> threshold initialization with trip crossing on the way up.
>>
>> Patch [5/6] ([3/3] in v2) adds a mechanism to sort notifications and debug
>> calls taking place during one invocation of __thermal_zone_device_update() so
>> they always go in temperature order.
>>
>> Patch [6/6] relocates the critical and trip point handling to avoid a
>> redundant temperature check.
>>
>> The series applies on top of 6.9-rc2 and I'm planning to create a test
>> branch containing it.
> 
> As promised:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=thermal-core-testing

Thanks Rafael for the handy branch. I'll play with it today.

Regards,
Lukasz

