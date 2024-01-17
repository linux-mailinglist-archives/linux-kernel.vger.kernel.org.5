Return-Path: <linux-kernel+bounces-28891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A952F830443
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8DC1C23CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB981DDDA;
	Wed, 17 Jan 2024 11:10:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4881DA4C;
	Wed, 17 Jan 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489847; cv=none; b=V2UuJWO00GG/nzvy39kRMC9PO0kVmc9UXVy/SbEM91BOXisMcw7uYYTUGEkrpQaprycQDwXeLNOZGEXSO3wPbv0Tj9SSpT4PKlgRB0cE0HGuysb4EYbpgAgOJ8j2oAdiHIwH50Jx1HHXLB/6aT9PbvWghS6YoowdeN0ooQ14bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489847; c=relaxed/simple;
	bh=+Vkg04EQ/NJX+jN5XyPGUbM9KQ4RfjqcbzoXRUpVcH4=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=day6cT/YOvmQiAPdiHhUnoqST3SRZLnAlYKIKbWsLxAxOW6CV+o4RmdZvQVAwqjgtEcCWfcMxL6+ZFdfzTA9OI0lG2O00EpdGnVwiIfibBJ064cuWpElCGr0dj9ENN3oWVfNpSFz4YVz2uquGuZCDheyM6QazQdTfu5s404UyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A6E311FB;
	Wed, 17 Jan 2024 03:11:30 -0800 (PST)
Received: from [10.57.78.6] (unknown [10.57.78.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D2C73F5A1;
	Wed, 17 Jan 2024 03:10:42 -0800 (PST)
Message-ID: <016627c7-653d-4e1b-8e73-f73e166a7187@arm.com>
Date: Wed, 17 Jan 2024 11:10:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/23] PM: EM: Extend em_cpufreq_update_efficiencies()
 argument list
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-3-lukasz.luba@arm.com>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240117095714.1524808-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:56, Lukasz Luba wrote:
> In order to prepare the code for the modifiable EM perf_state table,
> make em_cpufreq_update_efficiencies() take a pointer to the EM table
> as its second argument and modify it to use that new argument instead
> of the 'table' member of dev->em_pd.
> 
> No functional impact.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/power/energy_model.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 8b9dd4a39f63..42486674b834 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>   	return 0;
>   }
>   
> -static void em_cpufreq_update_efficiencies(struct device *dev)
> +static void
> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>   {
>   	struct em_perf_domain *pd = dev->em_pd;
> -	struct em_perf_state *table;
>   	struct cpufreq_policy *policy;
>   	int found = 0;
>   	int i;
> @@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>   		return;
>   	}

NIT: It's not shown here, but in the check above this line

	if (!_is_cpu_device(dev) || !pd)

The !pd check should be removed because em_cpufreq_update_efficiencies() 
is only called after doing

	dev->em_pd->flags |= flags;

So compiler will optimize the !pd out anyway. But this is not directly 
related to the PR, so just a NIT.

>   
> -	table = pd->table;
> -
>   	for (i = 0; i < pd->nr_perf_states; i++) {
>   		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>   			continue;
> @@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   
>   	dev->em_pd->flags |= flags;
>   
> -	em_cpufreq_update_efficiencies(dev);
> +	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>   
>   	em_debug_create_pd(dev);
>   	dev_info(dev, "EM: created perf domain\n");

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>

