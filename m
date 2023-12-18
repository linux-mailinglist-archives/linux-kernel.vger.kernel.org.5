Return-Path: <linux-kernel+bounces-3514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E4816D35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF14284328
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4A1B26C;
	Mon, 18 Dec 2023 11:55:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72162136B;
	Mon, 18 Dec 2023 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE2E1FB;
	Mon, 18 Dec 2023 03:56:30 -0800 (PST)
Received: from [10.57.86.170] (unknown [10.57.86.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0FF3F64C;
	Mon, 18 Dec 2023 03:55:43 -0800 (PST)
Message-ID: <44cb77d0-1d9a-47af-b699-e3019b520574@arm.com>
Date: Mon, 18 Dec 2023 11:56:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/23] PM: EM: Add em_dev_compute_costs() as API for
 device drivers
To: Qais Yousef <qyousef@layalina.io>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-23-lukasz.luba@arm.com>
 <8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com>
 <20231217180316.rblvtqaxjvu5xedf@airbuntu>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217180316.rblvtqaxjvu5xedf@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dietmar and Qais,

On 12/17/23 18:03, Qais Yousef wrote:
> On 12/12/23 19:50, Dietmar Eggemann wrote:
>> On 29/11/2023 12:08, Lukasz Luba wrote:
>>> The device drivers can modify EM at runtime by providing a new EM table.
>>> The EM is used by the EAS and the em_perf_state::cost stores
>>> pre-calculated value to avoid overhead. This patch provides the API for
>>> device drivers to calculate the cost values properly (and not duplicate
>>> the same code).
>>
>> New interface w/o any users? Can we not remove this from this patch-set
>> and introduce it with the first user(s)?

I didn't wanted to introduce the user of this in the same patch set.
I will send a follow up patch for Exynos SoC. More about this below.

> 
> It's a chicken and egg problem. No interface, will not enable the new users to
> appear too. So assuming the interface makes sense, I vote to keep it.

There are already in mainline platforms which will benefit from this
feature and would use this API. The platform which support chip
binning and adjust the voltage based on that information. It can be a
driver which can even be built as a module. One example is Exynos5 ASV
(Adaptive Supply Voltage) part of the Exynos chipid driver [1].
Here is the dmesg log with some additional debug from this driver.
As you can see the EM finished the registration and also update (the
new feature from this patch set), but it worked on old Voltages from
OPPs. (Also, this driver can be built as a module).

-------------------------------------------------
[    4.651049] cpu cpu4: EM: created perf domain
[    4.654073] cpu cpu0: EM: OPP:1200000 is inefficient
[    4.654108] cpu cpu0: EM: OPP:1100000 is inefficient
[    4.654140] cpu cpu0: EM: OPP:900000 is inefficient
[    4.654173] cpu cpu0: EM: OPP:800000 is inefficient
[    4.654204] cpu cpu0: EM: OPP:600000 is inefficient
[    4.654235] cpu cpu0: EM: OPP:500000 is inefficient
[    4.654266] cpu cpu0: EM: OPP:400000 is inefficient
[    4.654297] cpu cpu0: EM: OPP:200000 is inefficient
[    4.654342] cpu cpu0: EM: updated
....
[    4.750026] exynos-chipid 10000000.chipid: cpu0 opp0, freq: 1500 missing
[    4.755329] exynos-chipid 10000000.chipid: Checking asv_volt=1175000 
opp_volt=1275000
[    4.763213] exynos-chipid 10000000.chipid: Checking asv_volt=1125000 
opp_volt=1250000
[    4.770982] exynos-chipid 10000000.chipid: Checking asv_volt=1075000 
opp_volt=1250000
[    4.778820] exynos-chipid 10000000.chipid: Checking asv_volt=1037500 
opp_volt=1250000
[    4.786515] exynos-chipid 10000000.chipid: Checking asv_volt=1000000 
opp_volt=1100000
[    4.794356] exynos-chipid 10000000.chipid: Checking asv_volt=962500 
opp_volt=1100000
[    4.802018] exynos-chipid 10000000.chipid: Checking asv_volt=925000 
opp_volt=1100000
[    4.816323] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.824109] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.839933] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.854762] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.866191] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    4.878812] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    4.886052] exynos-chipid 10000000.chipid: cpu4 opp0, freq: 2100 missing
[    4.892800] exynos-chipid 10000000.chipid: Checking asv_volt=1225000 
opp_volt=1312500
[    4.900542] exynos-chipid 10000000.chipid: Checking asv_volt=1162500 
opp_volt=1262500
[    4.908342] exynos-chipid 10000000.chipid: Checking asv_volt=1112500 
opp_volt=1237500
[    4.916066] exynos-chipid 10000000.chipid: Checking asv_volt=1075000 
opp_volt=1250000
[    4.923926] exynos-chipid 10000000.chipid: Checking asv_volt=1037500 
opp_volt=1250000
[    4.931707] exynos-chipid 10000000.chipid: Checking asv_volt=1000000 
opp_volt=1100000
[    4.939582] exynos-chipid 10000000.chipid: Checking asv_volt=975000 
opp_volt=1100000
[    4.947225] exynos-chipid 10000000.chipid: Checking asv_volt=950000 
opp_volt=1100000
[    4.954885] exynos-chipid 10000000.chipid: Checking asv_volt=925000 
opp_volt=1000000
[    4.962601] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.974047] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.974071] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=1000000
[    4.993670] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.001163] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.008818] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.016318] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.023955] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.039723] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.054445] exynos-chipid 10000000.chipid: Checking asv_volt=900000 
opp_volt=900000
[    5.066709] exynos-chipid 10000000.chipid: Exynos: CPU[EXYNOS5800] 
PRO_ID[0xe5422000] REV[0x1] Detected

-------------------------------------------------

The new EM which would be updated from that driver, would have lower
voltages as well as different 'inefficient OPPs'. The maximum voltage
difference based on the tables is 13.54% which means for the dynamic
power:
1362500 = 1.135416667 * 1200000
P_dyn = C* f * (V*1.1354 * V*1.1354) = C*f*V^2 * 1.289

That's ~29% different dynamic power (for one core).

This Voltage adjustment is due to chip lottery. Different SoC vendors
use different name for this fact.
I only have this Exynos platform, but when this API
and v5 features get in, the vendors can modify their drivers and test.

This should help both: EAS and IPA/DTPM.

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/soc/samsung/exynos5422-asv.c

