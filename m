Return-Path: <linux-kernel+bounces-129720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD5896EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D67C286987
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1501C481AB;
	Wed,  3 Apr 2024 12:36:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6B23BE;
	Wed,  3 Apr 2024 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147793; cv=none; b=hx0JKUyXzMUdlbeyOnR+Rq59Vnt8mgq55v1aYB0uCg+T2lk/ABOtxx5K5oCi2yiESXdxlarc4tN7hENzs2KLeLu+Ij+0Zu1R0oxVepOVtuuzWHlwft0m4C0YOejJlW2TF2dDrzy7iVuCepB1qTpeWIbBtX0rcBw1C4nFaHlkY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147793; c=relaxed/simple;
	bh=1DIsaoDpER4p++k4Z7iVSmQ6SUDjiw+1VTM2vtYz1FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+UNHgPxVSTATaSbgucW/WX1ewTwb+k6DIH/CvTeVjURZc060RaqGIVdoMhnEvS9cM4qQMMBaWpo8TKx7Zo3HG8ZzEvULC5N5gLH9PXsi310pvqWjx+hfuPeRPYmLbtbZF12RXM1gxWmNVgFk/E4dHps1cbIWWmXaGQl1qg4sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E0A81007;
	Wed,  3 Apr 2024 05:37:01 -0700 (PDT)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6D6F3F64C;
	Wed,  3 Apr 2024 05:36:27 -0700 (PDT)
Message-ID: <8519bb4c-e8b4-436c-bd3b-4a08e328a6ec@arm.com>
Date: Wed, 3 Apr 2024 13:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Update Energy Model after chip binning adjusted
 voltages
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 rafael@kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402155822.505491-1-lukasz.luba@arm.com>
 <045fa6db-4f76-46aa-85ba-c9e698c7e390@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <045fa6db-4f76-46aa-85ba-c9e698c7e390@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dietmar,

On 4/3/24 13:07, Dietmar Eggemann wrote:
> On 02/04/2024 17:58, Lukasz Luba wrote:
>> Hi all,
>>
>> This is a follow-up patch aiming to add EM modification due to chip binning.
>> The first RFC and the discussion can be found here [1].
>>
>> It uses Exynos chip driver code as a 1st user. The EM framework has been
>> extended to handle this use case easily, when the voltage has been changed
>> after setup. On my Odroid-xu4 in some OPPs I can observe ~20% power difference.
>> According to that data in driver tables it could be up to ~29%.
>>
>> This chip binning is applicable to a lot of SoCs, so the EM framework should
>> make it easy to update. It uses the existing OPP and DT information to
>> re-calculate the new power values.
>>
>> It has dependency on Exynos SoC driver tree.
>>
>> Changes:
>> v4:
>> - added asterisk in the comment section (test robot)
>> - change the patch 2/4 header name and use 'Refactor'
>> v3:
>> - updated header description patch 2/4 (Dietmar)
>> - removed 2 sentences from comment and adjusted in patch 3/4 (Dietmar)
>> - patch 4/4 re-phrased code comment (Dietmar)
>> - collected tags (Krzysztof, Viresh)
>> v2:
>> - removed 'ret' from error message which wasn't initialized (Christian)
>> v1:
>> - exported the OPP calculation function from the OPP/OF so it can be
>>    used from EM fwk (Viresh)
>> - refactored EM updating function to re-use common code
>> - added new EM function which can be used by chip device drivers which
>>    modify the voltage in OPPs
>> RFC is at [1]
>>
>> Regards,
>> Lukasz Luba
>>
>> [1] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm.com/
>>
>> Lukasz Luba (4):
>>    OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
>>    PM: EM: Refactor em_adjust_new_capacity()
>>    PM: EM: Add em_dev_update_chip_binning()
>>    soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
>>
>>   drivers/opp/of.c                 |  17 +++--
>>   drivers/soc/samsung/exynos-asv.c |  11 +++-
>>   include/linux/energy_model.h     |   5 ++
>>   include/linux/pm_opp.h           |   8 +++
>>   kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
>>   5 files changed, 122 insertions(+), 25 deletions(-)
> 
> LGTM.
> 
> Just two very minor things which I mentioned in the individual patches.
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> 
> 

Thank you for the review. I will send the v5 with those.

Regards,
Lukasz

