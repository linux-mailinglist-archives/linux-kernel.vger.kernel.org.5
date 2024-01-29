Return-Path: <linux-kernel+bounces-43294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B298411D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A3628898B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658686F092;
	Mon, 29 Jan 2024 18:14:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EAC3F9F3;
	Mon, 29 Jan 2024 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552063; cv=none; b=aUm/mJUvs4dkx2FvRrx5kN2tAudDVWdOgaJmX7XVR7J+Y4kv6RSMdk92EjH0eV/sTyxLpvFysKam5Hh3wLcEargkXlPcAqPMJTptQo+CreP0iH0VRcAkmENPMhw5R4rgY26Tj2foAKcesIRlqJYwzl+gO6l7IZBPinExC2nJg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552063; c=relaxed/simple;
	bh=FR/zq4TyESX0ax53xnG03ABJRIASj5fUXtXMj3RQZxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbE0jv1P4Wok2IV1N5AzdKIUzpxfoQqGetUwjcy4SHMcio0xtu0lbpn3ihUQnLJUW/+1eFHgQWxT+cMZfjNxLaC2KpR2QnP7KWBLhVonLxAxSOd8SUpdKU4DEbUtPTgc25koDy149V9Ivm//19MplnJXn0dNyOiweDmlZURYDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF3FDA7;
	Mon, 29 Jan 2024 10:15:04 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2EA63F738;
	Mon, 29 Jan 2024 10:14:17 -0800 (PST)
Message-ID: <0dce919b-279d-4a34-8641-09d0acec5cf1@arm.com>
Date: Mon, 29 Jan 2024 19:14:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/23] powercap/dtpm_cpu: Use new Energy Model
 interface to get table
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rafael@kernel.org
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 xuewen.yan94@gmail.com
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-17-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240117095714.1524808-17-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 10:57, Lukasz Luba wrote:

[...]

>  drivers/powercap/dtpm_cpu.c | 39 +++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 9193c3b8edeb..ee0d1aa3e023 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -42,6 +42,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>  {
>  	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
>  	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
> +	struct em_perf_state *table;
>  	struct cpumask cpus;
>  	unsigned long freq;
>  	u64 power;
> @@ -50,20 +51,22 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>  	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
>  	nr_cpus = cpumask_weight(&cpus);
>  
> +	rcu_read_lock();
> +	table = em_perf_state_from_pd(pd);

'table' vs. 'perf state(s)' ... another example (compare to comment in
12/23).

[...]

