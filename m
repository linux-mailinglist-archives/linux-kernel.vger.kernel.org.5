Return-Path: <linux-kernel+bounces-155680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A2A8AF58D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0334B28904B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A913DDCC;
	Tue, 23 Apr 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtX2wxXh"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2213DDA5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893725; cv=none; b=RnfE5TRr3QbRoTVD56pGHksnyFUrGvn0VQu64xyKAQQZiy7uqd1jND7MejmJx6nMyKqUCQxBqAEAOnI9lZH5dmm2O2W0wIG8R0UnCdLvxkl2tgqz7h3nwlWBfz+GKBi1kRW953i8nJLvBfkXrlhAVIvpuzfbiJt1smzdJgA9TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893725; c=relaxed/simple;
	bh=+upOyNx6GWgrNYQNFXIixuFdwRxie0s9oM3h10oBK7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChItgLe1SASCNLJP4Wzzh3dJ5bPCU6HuxALvDW29KCB/INZ1Efy+e6a1Jg0IyP+ayWoeYNzYtTC8Gk1UQwf+8ZdCl2KfsZe62uXt3AfU0zKtiZ2vsJNpNntFKVAeE7QSVSZmU27iqX1cawJBQtQnEmODPHyj8lultOVM08Gb9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtX2wxXh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso18357955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713893722; x=1714498522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOGIVpnxi6VE6tRYtin1B2x9HFniqBtLvm2+wpGsHgQ=;
        b=YtX2wxXhF2s9w++gra1rIDMuLAFSBz8XAXkQj6BnxHcp33SK/XJykiP4t+U8rMU2c6
         DHN+ecgLAQfN74FHp9av98dEUhkjHbkReagUTJxg/UDqL1CY7HJ7FJXu7SvqvxV5cNWb
         rXaYiOCRz5Mx6Xl8g7xsS5FRz10Ig9fpJtTHbYKI6O3sooz10K8pANSS8XXDCY9YxNfr
         gOV1dLqcXt3QCCq14Omg3Zqx3jrYOEUCw0bftIPdbrY7FhGfTYG4UGIDENw7PvuDVCvc
         C+L7MV0PC7gCJ06GuS1lTqiDgc8Rc8Ciy/x6PRGK1mwWXpjFd+RMd2AEle3HVgOzl171
         mMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713893722; x=1714498522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOGIVpnxi6VE6tRYtin1B2x9HFniqBtLvm2+wpGsHgQ=;
        b=d3jNNzLxOqNdYawOWuVIgzDwJijUpe+uZQkfz59oNVQ2warQg61+/MdrNi5JDnz/pY
         o4ERUglGUVkEiMkAV2R8oaNJFC+HJJody2N3b3jXMSuZS/hWpsib3mRkH+uRgPePy4lf
         b959hvtJt6fLMHFQIiiexErjrjgqi6pEThwy/v4XFfiYMi1aVM8bXivh2mx9f+KMDmvx
         n3gtP7VdtxQ6uc3svrlPudOGm4BtsKv6LqcRUztpKL/vZRo73R7o6aKHJWFZDbrijrlN
         VzremzPdM9SPLfPytvn3K2Y5M/DupBGcPJrt+nkDttS6TxM9EMTm6NmfmU/2EpwtJwX3
         j1sA==
X-Gm-Message-State: AOJu0YxDPQJiiAhFI2L5KTYl5X4EiqL0wXOvMbGMkVf1ZPENCq+vMxsb
	l9XxjjxoBEaV8vrs4VY+QamfCRL/JjX5BmSeLBxK8BRSDvsGrePv24N3KjmjWH+5AhG7vUKMJF7
	M
X-Google-Smtp-Source: AGHT+IHHeZQlgL5dmAsLjSnkk1w8WyHgF/HPWUHH5O5RpYR12Iefh70oyVpmUUWo0vFfJnEqSGHPFw==
X-Received: by 2002:a05:600c:4fc4:b0:419:fd49:5d46 with SMTP id o4-20020a05600c4fc400b00419fd495d46mr8505332wmq.38.1713893721911;
        Tue, 23 Apr 2024 10:35:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm24939787wmq.6.2024.04.23.10.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:35:20 -0700 (PDT)
Message-ID: <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org>
Date: Tue, 23 Apr 2024 19:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1913649.CQOukoFCf9@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the passive field in struct thermal_zone_device is not
> used by the Power Allocator governor itself and so the ordering of
> its updates with respect to allow_maximum_power() or allocate_power()
> does not matter.
> 
> Accordingly, make power_allocator_manage() update that field right
> before returning, which allows the current value of it to be passed
> directly to allow_maximum_power() without using the additional update
> variable that can be dropped.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

The step_wise and the power allocator are changing the tz->passive 
values, so telling the core to start and stop the passive mitigation timer.

It looks strange that a plugin controls the core internal and not the 
opposite.

I'm wondering if it would not make sense to have the following ops:

	.start
	.stop

start is called when the first trip point is crossed the way up
stop is called when the first trip point is crossed the way down

  - The core is responsible to start and stop the passive mitigation timer.

  - the governors do no longer us tz->passive

The reset of the governor can happen at start or stop, as well as the 
device cooling states.


>   drivers/thermal/gov_power_allocator.c |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -747,21 +747,18 @@ static void power_allocator_manage(struc
>   {
>   	struct power_allocator_params *params = tz->governor_data;
>   	const struct thermal_trip *trip = params->trip_switch_on;
> -	bool update;
>   
>   	lockdep_assert_held(&tz->lock);
>   
>   	if (trip && tz->temperature < trip->temperature) {
> -		update = tz->passive;
> -		tz->passive = 0;
>   		reset_pid_controller(params);
> -		allow_maximum_power(tz, update);
> +		allow_maximum_power(tz, tz->passive);
> +		tz->passive = 0;
>   		return;
>   	}
>   
> -	tz->passive = 1;
> -
>   	allocate_power(tz, params->trip_max->temperature);
> +	tz->passive = 1;
>   }
>   
>   static struct thermal_governor thermal_gov_power_allocator = {
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


