Return-Path: <linux-kernel+bounces-28979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C878305DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DDF1C217D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E891EA71;
	Wed, 17 Jan 2024 12:45:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13BA1DFEB;
	Wed, 17 Jan 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495549; cv=none; b=A0TCyd1kTKVPgOaUXTt9mgTsmxUm8utHYRJ6wjCxTcXCYtOg4aQtPVGzWe5ymIS6E7NwSoTCzFdZu02MwgSVAgSACmmMhTxFqvg3ElSYvkfbJKc8bq8HJaZHyfSWSTrcd8fSmbaorvi+0kG229JjI0XNvIgo7ZjybjyIkfBsE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495549; c=relaxed/simple;
	bh=i56mGxu8KysF5NrY4lHSjPEXT22HJYWPn3Qmd4oiqLQ=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=J4uuXqtSsD+UMajhd15n/RKEidwSi0KxBzr8kGxWYONRL5x10pSEXdRJGSimvr/7rTpMG1hfrCVKfvhtau2E7fRPTlxOh1B/lZ3R4Ul7FLnnxejJke875pIoEPT8GH8u3iZ4/vDZMwI8+W8FYxoeWXwyomoniGBjEHSLVtJPO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A0C11FB;
	Wed, 17 Jan 2024 04:46:32 -0800 (PST)
Received: from [10.57.78.6] (unknown [10.57.78.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005B83F766;
	Wed, 17 Jan 2024 04:45:43 -0800 (PST)
Message-ID: <000f7a73-9bd0-4c78-ba24-ef2e150882e7@arm.com>
Date: Wed, 17 Jan 2024 12:45:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/23] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-5-lukasz.luba@arm.com>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240117095714.1524808-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 09:56, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modification. There
> are going to be 2 EM tables which store information. This patch aims
> to prepare the code to be generic and use one of the tables. The function
> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
> instead a pointer to 'struct em_perf_state' (which is one of the EM's
> tables).
> 
> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to be re-used. Return an index for the best performance
> state for a given EM table. The function arguments that are introduced
> should allow to work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   include/linux/energy_model.h | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index c19e7effe764..b01277b17946 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
>   
>   /**
>    * em_pd_get_efficient_state() - Get an efficient performance state from the EM
> - * @pd   : Performance domain for which we want an efficient frequency
> - * @freq : Frequency to map with the EM
> + * @table:		List of performance states, in ascending order
> + * @nr_perf_states:	Number of performance states
> + * @freq:		Frequency to map with the EM
> + * @pd_flags:		Performance Domain flags
>    *
>    * It is called from the scheduler code quite frequently and as a consequence
>    * doesn't implement any check.
>    *
> - * Return: An efficient performance state, high enough to meet @freq
> + * Return: An efficient performance state id, high enough to meet @freq
>    * requirement.
>    */
> -static inline
> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> -						unsigned long freq)
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> +			  unsigned long freq, unsigned long pd_flags)
>   {
>   	struct em_perf_state *ps;
>   	int i;
>   
> -	for (i = 0; i < pd->nr_perf_states; i++) {
> -		ps = &pd->table[i];
> +	for (i = 0; i < nr_perf_states; i++) {
> +		ps = &table[i];
>   		if (ps->frequency >= freq) {
> -			if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> +			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>   			    ps->flags & EM_PERF_STATE_INEFFICIENT)
>   				continue;
> -			break;
> +			return i;
>   		}
>   	}
>   
> -	return ps;
> +	return nr_perf_states - 1;
>   }
>   
>   /**
> @@ -226,7 +228,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   {
>   	unsigned long freq, ref_freq, scale_cpu;
>   	struct em_perf_state *ps;
> -	int cpu;
> +	int cpu, i;
>   
>   	if (!sum_util)
>   		return 0;
> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 * Find the lowest performance state of the Energy Model above the
>   	 * requested frequency.
>   	 */
> -	ps = em_pd_get_efficient_state(pd, freq);
> +	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
> +				      pd->flags);
> +	ps = &pd->table[i];
>   
>   	/*
>   	 * The capacity of a CPU in the domain at the performance state (ps)

Reviewed-by: Hongyan Xia <hongyan.xia@arm.com>

