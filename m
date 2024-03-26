Return-Path: <linux-kernel+bounces-118542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69088BC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EE12E3ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AE136E20;
	Tue, 26 Mar 2024 08:29:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47B135401;
	Tue, 26 Mar 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441751; cv=none; b=spW/+3chbHB69IzLg5DN8wlATB2CijLKd4g1904Sjugy+1lrKTggK2Rav6ADOXMSnueqqhHZMSvHGwioUTpzeRZEtTwIWy1HKg8m15P3g+KS6tw+EzqskkgVMIEAYQqdIMFMwQRvUvYeywV/slBzNiKYu9zuwqqOl3oTvz8KSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441751; c=relaxed/simple;
	bh=WUhpHqX2IrIGD84daaOQvytai30nFNpig4YSNQtipjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbNIqjtjqIoUGEBeh2jZZHdMZZvjkP8iuKnXe+ZYRps+5V75f57NcssUp2bZDnktIn2y0KnEmHZ1ENgLtU1W/rf9UjLbRkc+UBP4+DNantPm/ftpfhEbb9GZ50LIzYbx5I5NmVtcIrQEEJmF6Yxe1rCCxh83SIZ50qI8/9u4VmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 744242F4;
	Tue, 26 Mar 2024 01:29:42 -0700 (PDT)
Received: from [10.57.71.219] (unknown [10.57.71.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEA993F7C5;
	Tue, 26 Mar 2024 01:29:06 -0700 (PDT)
Message-ID: <20074374-ae90-49c5-9e8d-67ce290b13ae@arm.com>
Date: Tue, 26 Mar 2024 08:29:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 1/4] OPP: OF: Export dev_opp_pm_calc_power()
 for usage from EM
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-2-lukasz.luba@arm.com>
 <20240326025147.qgfl5buiobfqfghj@vireshk-i7>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240326025147.qgfl5buiobfqfghj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/26/24 02:51, Viresh Kumar wrote:
> On 22-03-24, 11:08, Lukasz Luba wrote:
>> There are device drivers which can modify voltage values for OPPs. It
>> could be due to the chip binning and those drivers have specific chip
>> knowledge about it. This adjustment can happen after Energy Model is
>> registered, thus EM can have stale data about power.
>>
>> Export dev_opp_pm_calc_power() which can be used by Energy Model to
>> calculate new power with the new voltage for OPPs.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/opp/of.c       | 17 ++++++++++++-----
>>   include/linux/pm_opp.h |  8 ++++++++
>>   2 files changed, 20 insertions(+), 5 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks Viresh for the ACK!

Regards,
Lukasz

