Return-Path: <linux-kernel+bounces-43291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E4E8411D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F2BB258C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBC6F06B;
	Mon, 29 Jan 2024 18:13:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779AC3F9F3;
	Mon, 29 Jan 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552012; cv=none; b=Xqrkd2IwYlSG5pbhhVrOffDGB3VkHrPBKZmo/rKS/74zMBudPPDWOR9RK80TTmkh2MgLpQbJBBr6Qxa+deqVzbNiK+DejrWnsMyWpFtHJWIDM0Hyde+oqF03lz0NOI11WU3f14knIrUzfWAhsipuBVxYq7IcXbPwJMYKIqWY82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552012; c=relaxed/simple;
	bh=7DItazupWpEHejnyNhSi31OzIpu1z8o8okNzfMilxlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deqgFZwVV4HQf+L7HFBCjGL8runIyZlDMfZA/9BQ2UL5E923YWnP5zHwy3mujHcT2khXzK8nsELbd+fj+8DDFpB30avPLakB67zwcdAkvWIMpRzD+Pm4MEReGtFwtSBclHZtfSS8bekbVa6NizuSsQ/9KjvCjFPv40nVesHkAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2F0ADA7;
	Mon, 29 Jan 2024 10:14:12 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF1B3F738;
	Mon, 29 Jan 2024 10:13:26 -0800 (PST)
Message-ID: <3e1a2865-e40e-4a7e-9c75-5768d717a1a6@arm.com>
Date: Mon, 29 Jan 2024 19:13:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/23] PM: EM: Add em_perf_state_from_pd() to get
 performance states table
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-13-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240117095714.1524808-13-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 10:57, Lukasz Luba wrote:

[...]

> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 494df6942cf7..5ebe9dbec8e1 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -339,6 +339,23 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>  	return pd->nr_perf_states;
>  }
>  
> +/**
> + * em_perf_state_from_pd() - Get the performance states table of perf.
> + *				domain
> + * @pd		: performance domain for which this must be done
> + *
> + * To use this function the rcu_read_lock() should be hold. After the usage
> + * of the performance states table is finished, the rcu_read_unlock() should
> + * be called.
> + *
> + * Return: the pointer to performance states table of the performance domain
> + */
> +static inline
> +struct em_perf_state *em_perf_state_from_pd(struct em_perf_domain *pd)

This is IMHO hard to get since:

  struct em_perf_table {
    struct rcu_head rcu;
    struct kref kref;
    struct em_perf_state state[];
  };

So very often a 'struct em_perf_table' is named 'table' and 'struct
em_perf_table::state' as well. E.g. in em_adjust_new_capacity().

  struct em_perf_state *new_table;

  new_table = em_table->state;

In older EM code, we used 'struct em_perf_state *ps' to avoid this
confusion, I guess.

And what you get from the PD is actually a state vector so maybe:

struct em_perf_state *em_get_perf_states(struct em_perf_domain *pd)

The 'from_pd' seems obvious because of the parameter?

[...]

