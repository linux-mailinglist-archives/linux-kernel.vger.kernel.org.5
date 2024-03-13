Return-Path: <linux-kernel+bounces-101088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF087A227
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CEE28252D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCA12E5E;
	Wed, 13 Mar 2024 03:57:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E711193;
	Wed, 13 Mar 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302269; cv=none; b=DH4QVK2mh+f60C+Z+L6b2a6JKByRNR2ZXhWV6JQqkWMstd+dm5NbZEa789pB2qyR2gCef3TRFPEDoscOX4Q0BrkOdp2kt9sdC4rMuuTRxMd1JHdSEmKptA4JlafzY+XN8S9E2AOpM0ZBE3yh0YwcI+ZpZLXhz8Epx2gJmJaOByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302269; c=relaxed/simple;
	bh=xn9BaF+vY4E9A1GdYxDTCZbaTQ/pZd2l44gxSKuHeGE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eAIbWN2VZ7HgmKvyZ+uoXO6uMtVTmeU+it+KgUo79ZWv023Er8bAukkOlwbosLYsPoVIbW1lqDhRXWfH4DYgIWNp8rXx6eZD3/ZgPIXlk1Vd5ej8GRV+V0mKij0PgYT5yc8SIqfrcCNcOUnTeJKyLN/mnQZAl7DcJbckt2tbXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TvcB70xxZz1xqfx;
	Wed, 13 Mar 2024 11:55:59 +0800 (CST)
Received: from canpemm500008.china.huawei.com (unknown [7.192.105.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 2010B1400FD;
	Wed, 13 Mar 2024 11:57:44 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 canpemm500008.china.huawei.com (7.192.105.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 11:57:43 +0800
Message-ID: <8bfcacb1-b97a-8c54-7e41-f66df8ac32fd@huawei.com>
Date: Wed, 13 Mar 2024 11:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From: Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH V3] cpufreq: Fix per-policy boost behavior on SoCs using
 cpufreq_boost_set_sw
To: Sibi Sankar <quic_sibis@quicinc.com>, <dietmar.eggemann@arm.com>,
	<rafael@kernel.org>, <viresh.kumar@linaro.org>, <xuwei5@hisilicon.com>,
	<zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pm@vger.kernel.org>, <d-gole@ti.com>
References: <20240312103723.3469762-1-quic_sibis@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240312103723.3469762-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500008.china.huawei.com (7.192.105.151)

Hi,

Oh, I just catch this issue too recently.

Also test this patch on my board and it's works fine to me.

Tested-by:Yipeng Zou <zouyipeng@huawei.com> <mailto:zouyipeng@huawei.com>

Reviewed-by: Yipeng Zou <zouyipeng@huawei.com> <mailto:zouyipeng@huawei.com>

在 2024/3/12 18:37, Sibi Sankar 写道:
> In the existing code, per-policy flags doesn't have any impact i.e.
> if cpufreq_driver boost is enabled and one or more of the per-policy
> boost is disabled, the cpufreq driver will behave as if boost is
> enabled. Fix this by incorporating per-policy boost flag in the policy->max
> calculus used in cpufreq_frequency_table_cpuinfo and setting the default
> per-policy boost to mirror the cpufreq_driver boost flag.
>
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Reported-by: Dietmar Eggemann<dietmar.eggemann@arm.com>
> Reviewed-by: Viresh Kumar<viresh.kumar@linaro.org>
> Reviewed-by: Dhruva Gole<d-gole@ti.com>
> Signed-off-by: Sibi Sankar<quic_sibis@quicinc.com>
> ---
>
> v3:
> * Pickup Rbs.
> * Simplify per-policy boost setting. [Viresh]
>
> v2:
> * Enable per-policy boost flag in the core instead. [Viresh]
> * Add more details regarding the bug. [Viresh]
> * Drop cover-letter and patch 2.
>
> Logs reported-by Dietmar Eggemann:
> https://lore.kernel.org/lkml/265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com/
>
>   drivers/cpufreq/cpufreq.c    | 18 ++++++++++++------
>   drivers/cpufreq/freq_table.c |  2 +-
>   2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index f6f8d7f450e7..66e10a19d76a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -653,14 +653,16 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
>   	if (policy->boost_enabled == enable)
>   		return count;
>   
> +	policy->boost_enabled = enable;
> +
>   	cpus_read_lock();
>   	ret = cpufreq_driver->set_boost(policy, enable);
>   	cpus_read_unlock();
>   
> -	if (ret)
> +	if (ret) {
> +		policy->boost_enabled = !policy->boost_enabled;
>   		return ret;
> -
> -	policy->boost_enabled = enable;
> +	}
>   
>   	return count;
>   }
> @@ -1428,6 +1430,9 @@ static int cpufreq_online(unsigned int cpu)
>   			goto out_free_policy;
>   		}
>   
> +		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +		policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);
> +
>   		/*
>   		 * The initialization has succeeded and the policy is online.
>   		 * If there is a problem with its frequency table, take it
> @@ -2769,11 +2774,12 @@ int cpufreq_boost_trigger_state(int state)
>   
>   	cpus_read_lock();
>   	for_each_active_policy(policy) {
> +		policy->boost_enabled = state;
>   		ret = cpufreq_driver->set_boost(policy, state);
> -		if (ret)
> +		if (ret) {
> +			policy->boost_enabled = !policy->boost_enabled;
>   			goto err_reset_state;
> -
> -		policy->boost_enabled = state;
> +		}
>   	}
>   	cpus_read_unlock();
>   
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index c4d4643b6ca6..c17dc51a5a02 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -40,7 +40,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>   	cpufreq_for_each_valid_entry(pos, table) {
>   		freq = pos->frequency;
>   
> -		if (!cpufreq_boost_enabled()
> +		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>   		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>   			continue;
>   

-- 
Regards,
Yipeng Zou


