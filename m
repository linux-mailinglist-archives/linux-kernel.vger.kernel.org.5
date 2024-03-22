Return-Path: <linux-kernel+bounces-111348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24A886B00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0761C20FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EC3E49D;
	Fri, 22 Mar 2024 11:07:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB22C18D;
	Fri, 22 Mar 2024 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105622; cv=none; b=bQNhfnFDE62WJyb0WISUtlqugfLMcV/pik4rxHrU8QULUgwcuIw0Pn4SzkHS9FdIXGE7u+DZZuUdXxJp1elUpFY2KmwmTmvULpIvmBHwUsefc6UZOmW296WQINB6Q8niiSv17vg8gQ79/IWF9QNYDLIMDt4w32InBFiZFFjMbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105622; c=relaxed/simple;
	bh=EYYHZIaBz/ypfFhjlvxZu3aL3IPa6xvR2uwygCIyUJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF2c6tZd9VxWoCuV664FmUdKXXSUFTfstYIKY82bzWV5WSFZOIutrE5bLL3mSAUTgBh4a23araVyugWFc9JY+3rNQllby1uPt19skb+JTe+z9DnuoQfmmCXN0fCkU1A0z87f+cLuOY0wPWeYTh9HY13qETPQmxsxgXU9hPAXGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D40631007;
	Fri, 22 Mar 2024 04:07:33 -0700 (PDT)
Received: from [10.57.71.57] (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2283F64C;
	Fri, 22 Mar 2024 04:06:57 -0700 (PDT)
Message-ID: <43b3feb2-8eb7-4f6d-a41b-d2d3c8893ec4@arm.com>
Date: Fri, 22 Mar 2024 11:06:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Update Energy Model after chip binning adjusted
 voltages
Content-Language: en-US
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240322103221.47594-1-lukasz.luba@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240322103221.47594-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/22/24 10:32, Lukasz Luba wrote:
> Hi all,
> 
> This is a follow-up patch aiming to add EM modification due to chip binning.
> The first RFC and the discussion can be found here [1].
> 
> It uses Exynos chip driver code as a 1st user. The EM framework has been
> extended to handle this use case easily, when the voltage has been changed
> after setup. On my Odroid-xu4 in some OPPs I can observe ~20% power difference.
> According to that data in driver tables it could be up to ~29%.
> 
> This chip binning is applicable to a lot of SoCs, so the EM framework should
> make it easy to update. It uses the existing OPP and DT information to
> re-calculate the new power values.
> 
> 
> Changes:
> v2:
> - removed 'ret' from error message which wasn't initialized (Christian)
> v1:
> - exported the OPP calculation function from the OPP/OF so it can be
>    used from EM fwk (Viresh)
> - refactored EM updating function to re-use common code
> - added new EM function which can be used by chip device drivers which
>    modify the voltage in OPPs
> RFC is at [1]
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (4):
>    OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
>    PM: EM: Change the em_adjust_new_capacity() to re-use code
>    PM: EM: Add em_dev_update_chip_binning()
>    soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
> 
>   drivers/opp/of.c                 |  17 +++--
>   drivers/soc/samsung/exynos-asv.c |  11 +++-
>   include/linux/energy_model.h     |   5 ++
>   include/linux/pm_opp.h           |   8 +++
>   kernel/power/energy_model.c      | 109 +++++++++++++++++++++++++------
>   5 files changed, 125 insertions(+), 25 deletions(-)
> 

Please ignore this version. It still has that 'ret'. I've fixed in
different repo, but sent patches from different terminal.

I'll resend it in a second...

Regards,
Lukasz

