Return-Path: <linux-kernel+bounces-129749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49286896F75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0562E28ABC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8C148853;
	Wed,  3 Apr 2024 12:52:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510471487EB;
	Wed,  3 Apr 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148747; cv=none; b=fk7nX5I/CFF1Ck7taX/JPaLHKTU8KisatOAsqNzbws7bxCM5z0q5SjstEsU57tkELiYPukAn5p/Mqx1QBcb9TjY8QK+NroMvaLKaVE693IjfzEyHyKOxtoPITUefmlcMx5rIJpbVMVni9UzxVhFfbAv0Q/bHHV3JRONv+5LqxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148747; c=relaxed/simple;
	bh=vf5d7MSWti+Q4CFio8rLViQMsiHN4xSksYnuqd/mjZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQMP1Gt/AcdqF0/ume8md3wJXBZIsAyjQddfixoGERR4PuTJMfRcVfHJGCJDbhp0sfbMzuR54ZIVWqjL1+XzOIoMVycHVWCNtunlN/nWmELCEMVUxW2OXntRqk2b2zgM/nkrbwpxuFXliBwGEJ3u99Y0P2sPQ6yFrHAkgCxIlSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4AD81007;
	Wed,  3 Apr 2024 05:52:55 -0700 (PDT)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 955B63F7B4;
	Wed,  3 Apr 2024 05:52:23 -0700 (PDT)
Message-ID: <187a3acb-d4a8-41e6-822c-f901a693aae1@arm.com>
Date: Wed, 3 Apr 2024 13:52:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] thermal: gov_power_allocator: Suppress
 sustainable_power warning without trip_points
Content-Language: en-US
To: Nikita Travkin <nikitos.tr@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-3-79bdd8439449@trvn.ru>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-3-79bdd8439449@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
> From: Nikita Travkin <nikita@trvn.ru>
> 
> IPA warns if the thermal zone it was attached to doesn't define
> sustainable_power value. In some cases though IPA may be bound to an
> "empty" TZ, in which case the lack of sustainable_power doesn't matter.
> 
> Suppress the warning in case when IPA is bound to an empty TZ to make it
> easier to see the warnings that actually matter.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> 
> I've decided to add this along to supress those warnings for some TZ on
> sc7180. Feel free to drop this patch if you think the warning should
> always appear.

That warning should stay, since in the development or integration phase
quite a lot of stuff is missing. This will warn that there is an issue.
The case with 'empty' TZ is an exception only to 'work' with IPA.

Thanks for the patches!

Regards,
Lukasz


> ---
>   drivers/thermal/gov_power_allocator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index e25e48d76aa7..05a40f6b5928 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -704,7 +704,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   		params->allocated_tzp = true;
>   	}
>   
> -	if (!tz->tzp->sustainable_power)
> +	if (!tz->tzp->sustainable_power && params->trip_max)
>   		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
>   	else
>   		params->sustainable_power = tz->tzp->sustainable_power;
> 

