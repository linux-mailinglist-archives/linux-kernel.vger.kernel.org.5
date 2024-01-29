Return-Path: <linux-kernel+bounces-43298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A49E8411E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358F7288248
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2941E6F09E;
	Mon, 29 Jan 2024 18:15:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92873F9F3;
	Mon, 29 Jan 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552142; cv=none; b=PXNBT9PP16JmCmWNvR3vM5VnI5ZF41f6J2YoOCcgJ1CO8WgE+7xRucxE2+C515CWySWUhsimIuKK4zdz1NzwJt67UqWtDdoA3tXBnpGC0QOsFTjXViS0mhIuM0DR34samTHq9R/RsbBdVqmEOZZPxwKH0Aj0CmMVjMPGqhl3jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552142; c=relaxed/simple;
	bh=ewiyKl+qgVhKnM4cIz0AXQmrRLnvvgCR5PofG1HuxlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGSLbEqsYjOb9SwDHgXgwDttXMv8hDKAIqvorlpRZhB1RPfSWCM9loRj5B7O+fa1K7UolvWjzfsVfujO3tc77gryW5F/m7K4Yda3sErugo0AYip2UfANai3IPLpc6rL7c/GnAnV7u/EXmx1HOu8fX54qx/Dbxaucjim7YiH/E8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CA80DA7;
	Mon, 29 Jan 2024 10:16:24 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9363F738;
	Mon, 29 Jan 2024 10:15:37 -0800 (PST)
Message-ID: <1edf0dcc-ca15-49fa-9c42-95e837fc073b@arm.com>
Date: Mon, 29 Jan 2024 19:15:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 22/23] PM: EM: Add em_dev_compute_costs()
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-23-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240117095714.1524808-23-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 10:57, Lukasz Luba wrote:

[...]

> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index e91c8efb5361..104cc2e2aa84 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -276,6 +276,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>  	return 0;
>  }
>  
> +/**
> + * em_dev_compute_costs() - Calculate cost values for new runtime EM table
> + * @dev		: Device for which the EM table is to be updated
> + * @table	: The new EM table that is going to get the costs calculated
> + *
> + * Calculate the em_perf_state::cost values for new runtime EM table. The
> + * values are used for EAS during task placement. It also calculates and sets
> + * the efficiency flag for each performance state. When the function finish
> + * successfully the EM table is ready to be updated and used by EAS.
> + *
> + * Return 0 on success or a proper error in case of failure.
> + */
> +int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
> +			 int nr_states)
> +{
> +	return em_compute_costs(dev, table, NULL, nr_states, 0);
> +}
> +

Still no user of this function in this patch-set so it could be
introduced with the follow-up patch 'OPP: Add API to update EM after
adjustment of voltage for OPPs'. Especially now since Viresh and you
have agreed that this should be part of the EM code as well:

https://lkml.kernel.org/r/a42ae8dd-383c-43c0-88b4-101303d6f548@arm.com

