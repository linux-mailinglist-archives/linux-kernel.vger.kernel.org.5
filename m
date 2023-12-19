Return-Path: <linux-kernel+bounces-4965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEA8818474
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BB284DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB813ADE;
	Tue, 19 Dec 2023 09:31:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AF14A8F;
	Tue, 19 Dec 2023 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CC9E1FB;
	Tue, 19 Dec 2023 01:32:38 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8CC3F738;
	Tue, 19 Dec 2023 01:31:51 -0800 (PST)
Message-ID: <cbb2ae63-eb51-451a-b202-2a1c447a93e9@arm.com>
Date: Tue, 19 Dec 2023 09:32:56 +0000
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
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_Zx5NtSpNXHsAqpZSq2yVHGAni5sN=ot5Lkc0jGZxoxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/19/23 06:22, Xuewen Yan wrote:
> Hi Lukasz,
> 
> On Wed, Nov 29, 2023 at 7:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]

>> +
>> +  -> drivers/soc/example/example_em_mod.c
>> +
>> +  01   static void foo_get_new_em(struct device *dev)
> 
> Because now some drivers use the dev_pm_opp_of_register_em() to
> register energy model,
> and maybe we can add a new function to update the energy model using
> "EM_SET_ACTIVE_POWER_CB(em_cb, cb)"
> instead of letting users set power again?
> 

There are different usage of this EM feature:
1. Adjust power values after boot is finish and e.g. ASV in Exynos
    has adjusted new voltage values in the OPP framework. It's
    due to chip binning. I have described that in conversation
    below patch 22/23. I'm going to send a patch for that
    platform and OPP fwk later as a follow up to this series.
2. Change the EM power values after long gaming, when the GPU
    heats up the SoC heavily and CPUs start increase the leakage
3. Change the EM for long running heavy apps, e.g. video conference app,
    which is using camera w/ image AI and filters (so some heavy stuff)
4. any other optimization that vendor/OEM like to have for

