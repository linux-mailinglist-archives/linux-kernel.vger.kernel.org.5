Return-Path: <linux-kernel+bounces-27205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16382EC29
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A45D1F23347
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BB134BE;
	Tue, 16 Jan 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="toruq78z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009D1759B;
	Tue, 16 Jan 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705398631;
	bh=UhAc640PaJinIZCgzAtBALA3kzwWcWZJV4KxCNouBhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=toruq78zOjfa52lWdFcpKqifq7gMh27B2Yu1NqAIk+nd8FwGejgfp4OjHDqCQCL8s
	 dmWZdUZtc49lF1mPSDbqTNlWLMTzjeW5AaLTIPZW8XSmcio+zcn3fJkFJuXDDaY5DV
	 AY11YMmYo2ncG1U5sSU+uSrgAsaAfKsRWG54TSDmUW+mxF3MxSW+W5m/xhWCS7s0Yg
	 TNSFyH/31W6nmJQGtTx9X0Fgompf+n3uMLGFiTdQTOcNJ2VMoQ6LPtGhLb7NhJcG1S
	 /9NKMw1carOKq3rHn719e1YB+/5mN4PMhDzjfDs/zw+Gk1bxSdkD8rHpDQkNFeFoQ2
	 KfdYYwt33MvDw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA3393782066;
	Tue, 16 Jan 2024 09:50:30 +0000 (UTC)
Message-ID: <3b3fdb3b-a22e-499d-89a6-ee06e5f91ee1@collabora.com>
Date: Tue, 16 Jan 2024 10:50:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/26] thermal/of: Migrate to
 thermal_zone_device_register()
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
 <20231221124825.149141-3-angelogioacchino.delregno@collabora.com>
 <415ca710-1b28-47e5-bffa-3f9f76c59041@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <415ca710-1b28-47e5-bffa-3f9f76c59041@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/01/24 18:17, Daniel Lezcano ha scritto:
> On 21/12/2023 13:48, AngeloGioacchino Del Regno wrote:
>> The thermal API has a new thermal_zone_device_register() function which
>> is deprecating the older thermal_zone_device_register_with_trips() and
>> thermal_tripless_zone_device_register().
>>
>> Migrate to the new thermal zone device registration function.
> 
> Sounds good to me.
> 
> May be add "No functional change intended" ?
> 

Yeah, makes sense - will add "This patch brings no functional changes".

Cheers!

>> Signed-off-by: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@collabora.com > ---
>>   drivers/thermal/thermal_of.c | 37 ++++++++++++++++--------------------
>>   1 file changed, 16 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 1e0655b63259..62a903ad649f 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -471,16 +471,12 @@ static struct thermal_zone_device 
>> *thermal_of_zone_register(struct device_node *
>>                                   const struct thermal_zone_device_ops *ops)
>>   {
>>       struct thermal_zone_device *tz;
>> -    struct thermal_trip *trips;
>> -    struct thermal_zone_params tzp = {};
>> -    struct thermal_zone_device_ops *of_ops;
>> +    struct thermal_zone_device_params tzdp;
>>       struct device_node *np;
>> -    int delay, pdelay;
>> -    int ntrips, mask;
>>       int ret;
>> -    of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
>> -    if (!of_ops)
>> +    tzdp.ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
>> +    if (!tzdp.ops)
>>           return ERR_PTR(-ENOMEM);
>>       np = of_thermal_zone_find(sensor, id);
>> @@ -490,30 +486,29 @@ static struct thermal_zone_device 
>> *thermal_of_zone_register(struct device_node *
>>           ret = PTR_ERR(np);
>>           goto out_kfree_of_ops;
>>       }
>> +    tzdp.type = np->name;
>> -    trips = thermal_of_trips_init(np, &ntrips);
>> -    if (IS_ERR(trips)) {
>> +    tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
>> +    if (IS_ERR(tzdp.trips)) {
>>           pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
>> -        ret = PTR_ERR(trips);
>> +        ret = PTR_ERR(tzdp.trips);
>>           goto out_kfree_of_ops;
>>       }
>> -    ret = thermal_of_monitor_init(np, &delay, &pdelay);
>> +    ret = thermal_of_monitor_init(np, &tzdp.polling_delay, &tzdp.passive_delay);
>>       if (ret) {
>>           pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
>>           goto out_kfree_trips;
>>       }
>> -    thermal_of_parameters_init(np, &tzp);
>> +    thermal_of_parameters_init(np, &tzdp.tzp);
>> -    of_ops->bind = thermal_of_bind;
>> -    of_ops->unbind = thermal_of_unbind;
>> +    tzdp.ops->bind = thermal_of_bind;
>> +    tzdp.ops->unbind = thermal_of_unbind;
>> +    tzdp.mask = GENMASK_ULL((tzdp.num_trips) - 1, 0);
>> +    tzdp.devdata = data;
>> -    mask = GENMASK_ULL((ntrips) - 1, 0);
>> -
>> -    tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
>> -                             mask, data, of_ops, &tzp,
>> -                             pdelay, delay);
>> +    tz = thermal_zone_device_register(&tzdp);
>>       if (IS_ERR(tz)) {
>>           ret = PTR_ERR(tz);
>>           pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
>> @@ -531,9 +526,9 @@ static struct thermal_zone_device 
>> *thermal_of_zone_register(struct device_node *
>>       return tz;
>>   out_kfree_trips:
>> -    kfree(trips);
>> +    kfree(tzdp.trips);
>>   out_kfree_of_ops:
>> -    kfree(of_ops);
>> +    kfree(tzdp.ops);
>>       return ERR_PTR(ret);
>>   }
> 




