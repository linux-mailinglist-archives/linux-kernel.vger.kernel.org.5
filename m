Return-Path: <linux-kernel+bounces-129701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A62896EAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D7C1C23287
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFA145FEC;
	Wed,  3 Apr 2024 12:07:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98E143869;
	Wed,  3 Apr 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712146066; cv=none; b=snQKcj1U8vsZXnW7GmtjPp9CXpq/kiBjWtSFd5AvLIN8feNR4DwyzWlHN1sdLp8gAzYVclSGsWlklTHm7zxLnwsura/C5N9OD+0rPZRkfewKX59fV5zamNa7zzFV1MATNLUd2U42aFiyK22BHPnF4NaclgsOxEO2typ905rPy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712146066; c=relaxed/simple;
	bh=baSyI2npvgfiHgQkn4LT4cuEiLvo3xIr5VzFHc6fB4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgmxTTKu8ztdzpFGyRkIzjvujEXps3TGfOWEB84x5w3vCYD9Vq/jf/Tp9IjkwPyUkn5P8Wx7Ow2zoSWpzQnTP7qPJ886andPa2UBua360oDg6X50slpq8PIaBfTgidhRtqJclTnGlkHrlYkeRy9AhaICM2dQKuTemg0hExE1rLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2EE1007;
	Wed,  3 Apr 2024 05:08:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0945E3F64C;
	Wed,  3 Apr 2024 05:07:39 -0700 (PDT)
Message-ID: <045fa6db-4f76-46aa-85ba-c9e698c7e390@arm.com>
Date: Wed, 3 Apr 2024 14:07:30 +0200
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
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240402155822.505491-1-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240402155822.505491-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 17:58, Lukasz Luba wrote:
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
> It has dependency on Exynos SoC driver tree.
> 
> Changes:
> v4:
> - added asterisk in the comment section (test robot)
> - change the patch 2/4 header name and use 'Refactor'
> v3:
> - updated header description patch 2/4 (Dietmar)
> - removed 2 sentences from comment and adjusted in patch 3/4 (Dietmar)
> - patch 4/4 re-phrased code comment (Dietmar)
> - collected tags (Krzysztof, Viresh)
> v2:
> - removed 'ret' from error message which wasn't initialized (Christian)
> v1:
> - exported the OPP calculation function from the OPP/OF so it can be
>   used from EM fwk (Viresh)
> - refactored EM updating function to re-use common code
> - added new EM function which can be used by chip device drivers which
>   modify the voltage in OPPs
> RFC is at [1]
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/lkml/20231220110339.1065505-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (4):
>   OPP: OF: Export dev_opp_pm_calc_power() for usage from EM
>   PM: EM: Refactor em_adjust_new_capacity()
>   PM: EM: Add em_dev_update_chip_binning()
>   soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
> 
>  drivers/opp/of.c                 |  17 +++--
>  drivers/soc/samsung/exynos-asv.c |  11 +++-
>  include/linux/energy_model.h     |   5 ++
>  include/linux/pm_opp.h           |   8 +++
>  kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
>  5 files changed, 122 insertions(+), 25 deletions(-)

LGTM.

Just two very minor things which I mentioned in the individual patches.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>




