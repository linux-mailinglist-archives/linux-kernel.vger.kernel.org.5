Return-Path: <linux-kernel+bounces-118541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB088BC68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0BF1C308EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62CF136E0D;
	Tue, 26 Mar 2024 08:28:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FE1353E1;
	Tue, 26 Mar 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441724; cv=none; b=BPE42KZ3MIXZF1CVYGjsnNmtRskhwdge3fCpCx8LNDgRChXpMHFotGIWy3WAJrVbrMC7FoKgAej1IZ12nszX7PUFe9QqN5AK7EWguzqpEL3DkDft+etHCT3aLeQ410B6zIROvsVA9tAeFoGF1r08jHpBBpuYrHo0aTW00iEnyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441724; c=relaxed/simple;
	bh=DI13yHG2DTqEW7LMLFYsUMuHh6LIv0PK0NVoglFctCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT1jiVusyuAnl6ZVYBzIae/FRsyAeq6TaZ1+Vta7RWBCCFzef1QcgmQBRS69/C3ecdDRqLT4mq0BHiQbNjRrd6VrU74lWVJpc797EIzC4+4QgMRL12A9jzNvvDbZgA6iRIRxFg7rWg8JiLvjzQkuvZb8fIZPZkOBUhc3H8XWAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003DF2F4;
	Tue, 26 Mar 2024 01:29:09 -0700 (PDT)
Received: from [10.57.71.219] (unknown [10.57.71.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 432A43F7C5;
	Tue, 26 Mar 2024 01:28:33 -0700 (PDT)
Message-ID: <6801486a-46d9-4af9-a4fb-4d25f55a22bc@arm.com>
Date: Tue, 26 Mar 2024 08:28:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 4/4] soc: samsung: exynos-asv: Update Energy
 Model after adjusting voltage
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-5-lukasz.luba@arm.com>
 <637a6390-6e38-49a4-abf5-b0d2b2a31093@linaro.org>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <637a6390-6e38-49a4-abf5-b0d2b2a31093@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/25/24 19:17, Krzysztof Kozlowski wrote:
> On 22/03/2024 12:08, Lukasz Luba wrote:
>> When the voltage for OPPs is adjusted there is a need to also update
>> Energy Model framework. The EM data contains power values which depend
>> on voltage values. The EM structure is used for thermal (IPA governor)
>> and in scheduler task placement (EAS) so it should reflect the real HW
>> model as best as possible to operate properly.
>>
>> Based on data on Exynos5422 ASV tables the maximum power difference might
>> be ~29%. An Odroid-XU4 (with a random sample SoC in this chip lottery)
>> showed power difference for some OPPs ~20%. Therefore, it's worth to
>> update the EM.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/soc/samsung/exynos-asv.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> I assume there is dependency, even though cover letter did not mention
> it, so:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks Krzysztof for the review. Yes, it touches driver in your tree
indeed. Hopefully it can goes smoothly via Rafael's tree with your
tag.

Regards,
Lukasz

