Return-Path: <linux-kernel+bounces-8538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE181B91F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55290B282C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B9C79472;
	Thu, 21 Dec 2023 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WC1H7ubj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1978E95;
	Thu, 21 Dec 2023 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703166854;
	bh=sYVHTNGAkI5wRJlcobVBGFxVgolKAqf6ony8h16VMKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WC1H7ubjC+75Wb6nkLy6w701MsHM2+M6kXPgQlaSl/MkxgyIZ1XLyN/fF7zBAdEx6
	 GaAhiFxbNgYn6c9RsIkPanR6PKFo9hZnpByhjMRvb8rwDoN0Qd6dmSvPgZ/eD/yqO5
	 pGTl34PBqH54v9QJ4ldvIcvdLhj30A5waonZcmHofUq4P89RF9Gzy6e8kGEmB6dSo7
	 WcyS9kF61E8HTWXMU3p4Y4Q94isGjqFeDqm3AHRIfKZaj+C3xJztxeUiI1jsrglH/9
	 1f76XhrD/e4f1XVWX4RIkAWZm/yjq9vDlnV2HvUMXtxQ2U2ZD9evwLEqF3kRX1c4AN
	 622p6VorMynIA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BBB003781F92;
	Thu, 21 Dec 2023 13:54:13 +0000 (UTC)
Message-ID: <76e84d66-2ab3-4ec2-9e8c-644faf22e823@collabora.com>
Date: Thu, 21 Dec 2023 14:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/26] Add thermal zones names and new registration
 func
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0g4D66c4mkHmKko+wdLbyRxXnaW77gKiDR42rX2NbzPKw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAJZ5v0g4D66c4mkHmKko+wdLbyRxXnaW77gKiDR42rX2NbzPKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/12/23 14:38, Rafael J. Wysocki ha scritto:
> On Thu, Dec 21, 2023 at 1:48 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> ** This RFC was sent only to thermal API maintainers + reviewers on purpose **
>>
>> As per previous discussion with Daniel [1], I've prepared this series adding
>> a new struct thermal_zone_device_params, used in a new registration function
>> for thermal zones thermal_zone_device_register(), deprecating and, finally,
>> replacing functions thermal_tripless_zone_device_register() and
>> thermal_zone_device_register_with_trips().
>>
>> The new flow to register a thermal zone becomes the following:
>>   - Declare a struct thermal_zone_device_params (`tzp` in this example)
>>   - Fill in all the params (instead of passing all of them to a function)
>>   - Call thermal_zone_device_register(tzp)
>>
>> Moreover, I've also introduced the concept of `name` for a thermal zone,
>> and set, as suggested, a constraint for which:
>>   - Multiple thermal zones can have the same `type` (so, no change), and
>>   - A thermal zone's name must be *unique*.
>>
>> This should then help (in a later series?) to disambiguate thermal zone
>> name vs type, as most of (if not all) the users seem to actually be
>> misusing the TZ type referring to / using it as a TZ name.
>>
>> Please note that this series is currently a RFC because it's apparently
>> growing bigger than I wanted - and because I probably have to add some
>> more code on top. Before doing so, I'm trying to get feedback on what
>> I've done until now.
> 
> And it is very unlikely that I will be able to provide any useful
> feedback on this series before 6.8-rc1 is out.
> 
> Thanks!

Thanks for telling - but hey, obviously there's no rush, please take your time.

Cheers!
Angelo

