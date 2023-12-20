Return-Path: <linux-kernel+bounces-6520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE98199E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA02282DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C7168D9;
	Wed, 20 Dec 2023 07:56:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D11C680;
	Wed, 20 Dec 2023 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CDF1FB;
	Tue, 19 Dec 2023 23:56:59 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D23B13F64C;
	Tue, 19 Dec 2023 23:56:12 -0800 (PST)
Message-ID: <930c762f-518a-420e-8da5-54c5ab1bf578@arm.com>
Date: Wed, 20 Dec 2023 07:57:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] Documentation: EM: Update with runtime
 modification design
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-24-lukasz.luba@arm.com>
 <CAB8ipk_Zx5NtSpNXHsAqpZSq2yVHGAni5sN=ot5Lkc0jGZxoxA@mail.gmail.com>
 <cbb2ae63-eb51-451a-b202-2a1c447a93e9@arm.com>
 <CAB8ipk8jsgUufoMB+z8=YQyOXyia91L-QGCTNuFeKngVBx5ZWA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk8jsgUufoMB+z8=YQyOXyia91L-QGCTNuFeKngVBx5ZWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 02:08, Xuewen Yan wrote:
> On Tue, Dec 19, 2023 at 5:31 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/19/23 06:22, Xuewen Yan wrote:
>>> Hi Lukasz,
>>>
>>> On Wed, Nov 29, 2023 at 7:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> [snip]
>>
>>>> +
>>>> +  -> drivers/soc/example/example_em_mod.c
>>>> +
>>>> +  01   static void foo_get_new_em(struct device *dev)
>>>
>>> Because now some drivers use the dev_pm_opp_of_register_em() to
>>> register energy model,
>>> and maybe we can add a new function to update the energy model using
>>> "EM_SET_ACTIVE_POWER_CB(em_cb, cb)"
>>> instead of letting users set power again?
>>>
>>
>> There are different usage of this EM feature:
>> 1. Adjust power values after boot is finish and e.g. ASV in Exynos
>>      has adjusted new voltage values in the OPP framework. It's
>>      due to chip binning. I have described that in conversation
>>      below patch 22/23. I'm going to send a patch for that
>>      platform and OPP fwk later as a follow up to this series.
> 
> I understand what you mean, what I mean is that if we can provide an
> interface for changing EM of opp fwk, it will be more friendly for
> those users who use opp, because then they don't have to calculate the
> new EM by themselves, but only need After updating the voltage of opp,
> just call this interface directly.

It is the plan. Don't worry. I didn't wanted to push this in one
big patch set. Exynos driver + the OPP change would do exactly this.
The EM functions from drivers/opp/of.c will be re-used for this.

It is too big to be made in one step. There is pattern in those more
complex changes, like in Arm SCMI fwk to make the improvements
gradually. This folds into the same bucket.

Although, you are another person asking for similar thing, so I
will send a follow-up change using this new EM API - instead
of waiting to finish this review.

Thanks,
Lukasz

