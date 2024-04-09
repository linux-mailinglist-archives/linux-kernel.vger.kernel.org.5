Return-Path: <linux-kernel+bounces-136336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17089D2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6831F22A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390377BB15;
	Tue,  9 Apr 2024 07:07:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6148763FC;
	Tue,  9 Apr 2024 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646450; cv=none; b=dvDIz1GXv/HsLgojFIQrsZpZ+UivQNFoFacfHpeL16qYGb8DpITGL94EN5JnqLIuH1K94lZje35rVYsIUj29RS0iCFqwIxmuLaRizPHb+QmYwCxnKF6lQBaPeb+nS7S3PuMSfnveiwEAwFIFIlS9sNMqXGh8Gf7915UmBRcaqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646450; c=relaxed/simple;
	bh=ILlLN110MwkRvm0kV386nPbIZbSkkSytLLDGU68h6CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLmbOl0tKn7okm446Xu27DbOggDrbsRpK9FFw92MKdr/MQvYQ8GGnU9vA07sH5ir+EGO9AR2y2l6lPLk3tpvg5dRutvJq2OLtdZD2+YclIhrXfQhdC8/i1MaUDioFWz9jGlB1tGhvoFBpowVvDmJ42KUa2zcr9nhewXkhiageIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1E2FDA7;
	Tue,  9 Apr 2024 00:07:52 -0700 (PDT)
Received: from [10.57.75.42] (unknown [10.57.75.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0AAB3F766;
	Tue,  9 Apr 2024 00:07:19 -0700 (PDT)
Message-ID: <7259d711-d542-4057-af12-178c7f2b292b@arm.com>
Date: Tue, 9 Apr 2024 08:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Update Energy Model after chip binning adjusted
 voltages
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240403154907.1420245-1-lukasz.luba@arm.com>
 <CAJZ5v0jP8j3kcUFHx45_qpeOTa9THtP3qztC0oxuiohcYs5PPQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jP8j3kcUFHx45_qpeOTa9THtP3qztC0oxuiohcYs5PPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/24 15:06, Rafael J. Wysocki wrote:
> On Wed, Apr 3, 2024 at 5:49 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
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
>> v5:
>> - adjusted aligning of the function arguments in patch 1/4 (Dietmar)
>> - adjusted the in-code comment patch 4/4 (Dietmar)
>> - added Reviewed-by to all patches (Dietmar)
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
>>   drivers/soc/samsung/exynos-asv.c |  10 ++-
>>   include/linux/energy_model.h     |   5 ++
>>   include/linux/pm_opp.h           |   8 +++
>>   kernel/power/energy_model.c      | 106 +++++++++++++++++++++++++------
>>   5 files changed, 121 insertions(+), 25 deletions(-)
>>
>> --
> 
> All patches in the series applied as 6.10 material, thanks!

Thank you Rafael!

Regards,
Lukasz

