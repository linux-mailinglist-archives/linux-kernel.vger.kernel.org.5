Return-Path: <linux-kernel+bounces-14309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C970F821B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EB4282E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0AEAE3;
	Tue,  2 Jan 2024 11:45:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36FEAD6;
	Tue,  2 Jan 2024 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37011C15;
	Tue,  2 Jan 2024 03:46:33 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0083F7A6;
	Tue,  2 Jan 2024 03:45:44 -0800 (PST)
Message-ID: <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
Date: Tue, 2 Jan 2024 11:47:02 +0000
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
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/28/23 18:06, Qais Yousef wrote:
> On 11/29/23 11:08, Lukasz Luba wrote:
> 
>> @@ -220,8 +218,9 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>   				return -EINVAL;
>>   			}
>>   		} else {
>> -			power_res = table[i].power;
>> -			cost = div64_u64(fmax * power_res, table[i].frequency);
>> +			/* increase resolution of 'cost' precision */
>> +			power_res = table[i].power * 10;
> 
> Power is in uW, right? You're just taking advantage here that everything will
> use this new cost field so you can add as many 0s to improve resolution without
> impact elsewhere that care to compare using the same units?

This code doesn't overwrite the 'power' field value. The 'cost' value is
only used in EAS, so yes I just want to increase resolution there.

I think you mixed 'power' and 'cost' fields. We don't compare 'cost'
anywhere. We just use 'cost' in one place em_cpu_energy() and we
multiply it (not compare it).

> 
> Did you see a problem or just being extra cautious here?

There is no problem, 'cost' is a private coefficient for EAS only.

> 
>> +			cost = power_res / table[i].performance;
>>   		}
>>   
>>   		table[i].cost = cost;
>> -- 
>> 2.25.1
>>

