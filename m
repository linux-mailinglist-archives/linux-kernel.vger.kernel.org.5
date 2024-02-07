Return-Path: <linux-kernel+bounces-56419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772A84C9ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AE91F2605D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D11BF37;
	Wed,  7 Feb 2024 11:49:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141591D526;
	Wed,  7 Feb 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306546; cv=none; b=exOL+4BuZrSW71SHZPQ+uypMq+LXASQTob65u7aocGN8+WvVDxZQ3Yb+AXAd8z6JzBAvwkR5xbcN0XWgwy9KPf0aAsUrZl8j8R4mipPcroNfOQEjQSherSf9CiV3U2rgAmIBTZdWURpbUpqll9KVQIyPuLISrejNEPvHmeqIBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306546; c=relaxed/simple;
	bh=eyg3T6wfzHyvBXHkXuiAYYUcSdjod3g2AcizLNz1yfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv3qtYoTwoPZB8UfVKSc2Fwec0o/BiFgpja+ORlz3MUo/uqikspk9aJeYiTMS9LgEojqqu5FdAAb0WqAjtPFpLhFnGlQLAq+fhDXV2HY8nAnTLiASA7uHCpTYmV6iCzo4BpXB7qlaPvbTS2oqjAgFzXKZQFzRfqAHe2MNM+PbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAB21FB;
	Wed,  7 Feb 2024 03:49:44 -0800 (PST)
Received: from [10.57.9.121] (unknown [10.57.9.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACDE43F5A1;
	Wed,  7 Feb 2024 03:48:59 -0800 (PST)
Message-ID: <8704d3d2-08ab-4316-8d4b-f9b8f1878a19@arm.com>
Date: Wed, 7 Feb 2024 11:49:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/23] Introduce runtime modifiable Energy Model
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dietmar.eggemann@arm.com, linux-pm@vger.kernel.org, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 linux-kernel@vger.kernel.org, wvw@google.com, xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <5a38043f-6de3-4038-b1d9-314090e7b44e@arm.com>
 <CAJZ5v0i-U+Sqbb4z1oBcafWyDfQB=zO3+kKwa2ckdMh6mjsMkw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0i-U+Sqbb4z1oBcafWyDfQB=zO3+kKwa2ckdMh6mjsMkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/24 10:31, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Wed, Feb 7, 2024 at 10:15 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 1/17/24 09:56, Lukasz Luba wrote:
>>> Hi all,
>>>
>>> This patch set adds a new feature which allows to modify Energy Model (EM)
>>> power values at runtime. It will allow to better reflect power model of
>>> a recent SoCs and silicon. Different characteristics of the power usage
>>> can be leveraged and thus better decisions made during task placement in EAS.
>>>
>>
>> [snip]
>>
>>>
>>>
>>> Lukasz Luba (23):
>>>     PM: EM: Add missing newline for the message log
>>>     PM: EM: Extend em_cpufreq_update_efficiencies() argument list
>>>     PM: EM: Find first CPU active while updating OPP efficiency
>>>     PM: EM: Refactor em_pd_get_efficient_state() to be more flexible
>>>     PM: EM: Introduce em_compute_costs()
>>>     PM: EM: Check if the get_cost() callback is present in
>>>       em_compute_costs()
>>>     PM: EM: Split the allocation and initialization of the EM table
>>>     PM: EM: Introduce runtime modifiable table
>>>     PM: EM: Use runtime modified EM for CPUs energy estimation in EAS
>>>     PM: EM: Add functions for memory allocations for new EM tables
>>>     PM: EM: Introduce em_dev_update_perf_domain() for EM updates
>>>     PM: EM: Add em_perf_state_from_pd() to get performance states table
>>>     PM: EM: Add performance field to struct em_perf_state and optimize
>>>     PM: EM: Support late CPUs booting and capacity adjustment
>>>     PM: EM: Optimize em_cpu_energy() and remove division
>>>     powercap/dtpm_cpu: Use new Energy Model interface to get table
>>>     powercap/dtpm_devfreq: Use new Energy Model interface to get table
>>>     drivers/thermal/cpufreq_cooling: Use new Energy Model interface
>>>     drivers/thermal/devfreq_cooling: Use new Energy Model interface
>>>     PM: EM: Change debugfs configuration to use runtime EM table data
>>>     PM: EM: Remove old table
>>>     PM: EM: Add em_dev_compute_costs()
>>>     Documentation: EM: Update with runtime modification design
>>>
>>>    Documentation/power/energy-model.rst | 183 ++++++++++-
>>>    drivers/powercap/dtpm_cpu.c          |  39 ++-
>>>    drivers/powercap/dtpm_devfreq.c      |  34 +-
>>>    drivers/thermal/cpufreq_cooling.c    |  45 ++-
>>>    drivers/thermal/devfreq_cooling.c    |  49 ++-
>>>    include/linux/energy_model.h         | 165 ++++++----
>>>    kernel/power/energy_model.c          | 472 +++++++++++++++++++++++----
>>>    7 files changed, 819 insertions(+), 168 deletions(-)
>>>
>>
>> The patch set went through decent review. If you don't have any issues,
>> I will collect the tags and send the v8 which will be re-based on some
>> recent linux next (or please tell me your preferred branch).
> 
> Blease base it on 6.8-rc3.

OK, thanks

