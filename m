Return-Path: <linux-kernel+bounces-129729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB363896F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C1128A74C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665D146A69;
	Wed,  3 Apr 2024 12:44:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D158112;
	Wed,  3 Apr 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148241; cv=none; b=NW2ECjasLt0dWk18qKKPPKBcQ2EdKACd66aBRMljpUcJhvZyhoWXGgQDdkXoPr6QnzQ0gHkwWp43NHOao8cY3I+WXhOEohDEnHJVrleXSt6HcvFa/60rCEkZcum/lJjtP7EF27eeUk/J09smtXX6oCxocGVtfVuaq31tbGZaz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148241; c=relaxed/simple;
	bh=iTl4hiDfmuAKuYy1bynC/DvOEHtq0a5faUhxWHTuGPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBB9L1lSc61ly4E4LRyHsmcuEq5gvvbFxQf+JUUtLybTibH97i3l18ov7x0PaJasXJd94EQSQpARznA8v3IPQQ6tjatZYK4WdTkCfiFYps0S0IaceMhy88bm3cfTJ8zKeiY8ME+QoS40rrM5GX6O9fY2vxsoUCg6r8yXv7KM/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F8DD1007;
	Wed,  3 Apr 2024 05:44:30 -0700 (PDT)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC9E23F64C;
	Wed,  3 Apr 2024 05:43:57 -0700 (PDT)
Message-ID: <d048f863-05d1-4aeb-8904-4c09ecbe55d9@arm.com>
Date: Wed, 3 Apr 2024 13:43:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] thermal: gov_power_allocator: Allow binding
 without cooling devices
Content-Language: en-US
To: Nikita Travkin <nikitos.tr@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-1-79bdd8439449@trvn.ru>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-1-79bdd8439449@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
> From: Nikita Travkin <nikita@trvn.ru>
> 
> IPA was recently refactored to split out memory allocation into a
> separate funciton. That funciton was made to return -EINVAL if there is
> zero power_actors and thus no memory to allocate. This causes IPA to
> fail probing when the thermal zone has no attached cooling devices.
> 
> Since cooling devices can attach after the thermal zone is created and
> the governer is attached to it, failing probe due to the lack of cooling
> devices is incorrect.
> 
> Change the allocate_actors_buffer() to return success when there is no
> cooling devices present.
> 
> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   drivers/thermal/gov_power_allocator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 1b17dc4c219c..ec637071ef1f 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -606,7 +606,7 @@ static int allocate_actors_buffer(struct power_allocator_params *params,
>   
>   	/* There might be no cooling devices yet. */
>   	if (!num_actors) {
> -		ret = -EINVAL;
> +		ret = 0;
>   		goto clean_state;
>   	}
>   
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

