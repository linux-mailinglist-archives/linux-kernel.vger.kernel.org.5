Return-Path: <linux-kernel+bounces-22282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09666829BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF91283E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8A84A984;
	Wed, 10 Jan 2024 13:52:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EF47A67;
	Wed, 10 Jan 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FF282F4;
	Wed, 10 Jan 2024 05:53:06 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 850643F5A1;
	Wed, 10 Jan 2024 05:52:18 -0800 (PST)
Message-ID: <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>
Date: Wed, 10 Jan 2024 13:53:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
 <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/4/24 19:23, Qais Yousef wrote:
> On 01/02/24 11:47, Lukasz Luba wrote:
>>> Did you see a problem or just being extra cautious here?
>>
>> There is no problem, 'cost' is a private coefficient for EAS only.
> 
> Let me  ask differently, what goes wrong if you don't increase the resolution
> here? Why is it necessary?
> 


When you have 800mW at CPU capacity 1024, then the value is small (below
1 thousand).
Example:
power = 800000 uW
cost = 800000 / 1024 = 781

While I know from past that sometimes OPPs might have close voltage
values and a rounding could occur and make some OPPs inefficient
while they aren't.

This is what would happen when we have the 1x resolution:
/sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:551
/sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:644
/sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:744
/sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:851
/sys/kernel/debug/energy_model/cpu4/ps:408000/cost:493
/sys/kernel/debug/energy_model/cpu4/ps:600000/cost:493
/sys/kernel/debug/energy_model/cpu4/ps:816000/cost:493
The bottom 3 OPPs have the same 'cost' thus 2 OPPs are in-efficient,
which is not true (see below).

This is what would happen when we have the 10x resolution:
/sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:5513
/sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:6443
/sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:7447
/sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:8514
/sys/kernel/debug/energy_model/cpu4/ps:408000/cost:4934
/sys/kernel/debug/energy_model/cpu4/ps:600000/cost:4933
/sys/kernel/debug/energy_model/cpu4/ps:816000/cost:4934
Here the OPP with 600MHz is more efficient than 408MHz,
which is true. So only 408MHz will be marked as in-efficient OPP.


This is what would happen when we have the 100x resolution:
/sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:55137
/sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:64433
/sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:74473
/sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:85140
/sys/kernel/debug/energy_model/cpu4/ps:408000/cost:49346
/sys/kernel/debug/energy_model/cpu4/ps:600000/cost:49331
/sys/kernel/debug/energy_model/cpu4/ps:816000/cost:49346
The higher (100x) resolution does not bring that much in
practice.

If you have other questions, let's continue on v6 series.

