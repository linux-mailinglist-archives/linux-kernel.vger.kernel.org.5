Return-Path: <linux-kernel+bounces-108997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F0881329
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF731F258D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2453544377;
	Wed, 20 Mar 2024 14:16:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CF4084D;
	Wed, 20 Mar 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944161; cv=none; b=Pt9d+Ti83Ml9INvSI2dqEJqbICqkkGMuR74s0zawwrp1EWAIMSoDoC0juJq9MoTLDGqo9dLSU4fo5eE1lBDK0rkN/4II8uR4iQNAPlJVR5f30fsJbdJBsEpkAW4ueIVFrr7VqXWKlV3w/LPV0G6bsPj2OOcKnigQdBrxuEWqoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944161; c=relaxed/simple;
	bh=HKOGAMGI+cY/yHxVFJZLXvcCMLXHhUpxEQn31cO7kJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCewAPVw6RxE2jBFOzQIR1SaamlKWfdMQu2A6ljFzpPFbqWbr28tW+2gFzWaZy4yn1Ts8VacN87cczlzngyRanKCIWA346GRkf7HpFcfcRqGlNDq4aYFF41p2g87gKn/EUUtcdH9PJr1kz+ImY5fI7Ou8CvvkTZLzhF+9MAir/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628171007;
	Wed, 20 Mar 2024 07:16:33 -0700 (PDT)
Received: from [10.57.71.40] (unknown [10.57.71.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4BB3F64C;
	Wed, 20 Mar 2024 07:15:56 -0700 (PDT)
Message-ID: <fb9b21f6-4c73-4a85-93cc-56e7c44359cb@arm.com>
Date: Wed, 20 Mar 2024 14:15:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: devfreq_cooling: Fix perf state when
 calculate dfc res_util
Content-Language: en-US
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: tao.huang@rock-chips.com, heiko@sntech.de, rui.zhang@intel.com,
 finley.xiao@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org
References: <20240320075704.1924897-1-ye.zhang@rock-chips.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240320075704.1924897-1-ye.zhang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ye,

On 3/20/24 07:57, Ye Zhang wrote:
> The EM power table is sorted ascending，can't index the table by cooling
> device state，so convert cooling state to performance state by
> dfc->max_state - dfc->capped_state.
> 
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> ---
>   drivers/thermal/devfreq_cooling.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 50dec24e967a..8fd7cf1932cd 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
>   
>   		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
>   		if (!res) {
> -			state = dfc->capped_state;
> +			state = dfc->max_state - dfc->capped_state;
>   
>   			/* Convert EM power into milli-Watts first */
>   			rcu_read_lock();

Thank you for the patch. Good catch! It's under the device driver
callback optional thing: get_real_power().

Please send the v2 with extended explanation about the section
of the code, which is triggered by the get_real_power() presence.
Also, please add the tags, so it can be collected by stable kernel.

Fixes: 615510fe13bd2434610 ("thermal: devfreq_cooling: remove old power 
model and use EM")
Cc: 5.11+ <stable@vger.kernel.org> # 5.11+

BTW, how did you trigger that issue? Do you have such a driver
which provides this get_real_power() callback?

Regards,
Lukasz

