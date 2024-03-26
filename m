Return-Path: <linux-kernel+bounces-118755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0C88BEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B89B2605F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715E71B40;
	Tue, 26 Mar 2024 10:09:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B7B5C911;
	Tue, 26 Mar 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447752; cv=none; b=ghHrl6udP13ri9aRvEixaMbj3m6TYEoxM6ZP4+6TCLJFTvpPKNMJOEDLTNCgEc8FLGGjX4qUp64tEMCa6vbMAYiAUpTJ7J3cCQTG8x9+S17WY9jRJv5oZwpviJjJRkS4op8A8Nj3Xi2aR8esTpadIMqJCntarGOqtRDw3chObEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447752; c=relaxed/simple;
	bh=0qqyjsoUJJgOhHL/bgPaKR1WiY++FeUVJ10GLBY70VU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dx2B60yOjviZtGgALVud1lI348Jn14SrEIZ7XMauujzAK5wHN4JnpMT9AFLo7qiPjMUZ36uu+KPrvHQpJmd1KTkJelTpdH+e3uCLVMSlgwTCJHY/OkxfoaTv2btYqj/LnuOy3bZFEo4wQqY+90Rs+UzEmFf54NNOAfKJPwmupRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A093339;
	Tue, 26 Mar 2024 03:09:43 -0700 (PDT)
Received: from [10.57.15.246] (unknown [10.57.15.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807503F64C;
	Tue, 26 Mar 2024 03:09:07 -0700 (PDT)
Message-ID: <eb9f48f6-cca8-405b-82a2-352893a79f14@arm.com>
Date: Tue, 26 Mar 2024 11:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RESEND][PATCH v2 3/4] PM: EM: Add em_dev_update_chip_binning()
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-4-lukasz.luba@arm.com>
Content-Language: en-US
In-Reply-To: <20240322110850.77086-4-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 12:08, Lukasz Luba wrote:

> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 6960dd7393b2d..f7f7ae34ec552 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -808,3 +808,54 @@ static void em_update_workfn(struct work_struct *work)
>  {
>  	em_check_capacity_update();
>  }
> +
> +/**
> + * em_dev_update_chip_binning() - Update Energy Model with new values after

s/with new values// ... IMHO this should be obvious ?

> + *			the new voltage information is present in the OPPs.
> + * @dev		: Device for which the Energy Model has to be updated.
> + *
> + * This function allows to update easily the EM with new values available in
> + * the OPP framework and DT. It can be used after the chip has been properly
> + * verified by device drivers and the voltages adjusted for the 'chip binning'.
> + * It uses the "dynamic-power-coefficient" DT property to calculate the power
> + * values for EM. For power calculation it uses the new adjusted voltage
> + * values known for OPPs, which might be changed after boot.

The last two sentences describe what dev_pm_opp_calc_power() is doing.
Maybe this can be made clearer here?

> + */
> +int em_dev_update_chip_binning(struct device *dev)

This is the old dev_pm_opp_of_update_em() right?

> +{
> +	struct em_perf_table __rcu *em_table;
> +	struct em_perf_domain *pd;
> +	int i, ret;
> +
> +	if (IS_ERR_OR_NULL(dev))
> +		return -EINVAL;

When do you use if '(IS_ERR_OR_NULL(dev))' and when 'if(!dev)' for EM
interface functions?

> +	pd = em_pd_get(dev);
> +	if (!pd) {
> +		dev_warn(dev, "Couldn't find Energy Model\n");
> +		return -EINVAL;
> +	}
> +
> +	em_table = em_table_dup(pd);
> +	if (!em_table) {
> +		dev_warn(dev, "EM: allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Update power values which might change due to new voltage in OPPs */
> +	for (i = 0; i < pd->nr_perf_states; i++) {
> +		unsigned long freq = em_table->state[i].frequency;
> +		unsigned long power;
> +
> +		ret = dev_pm_opp_calc_power(dev, &power, &freq);
> +		if (ret) {
> +			em_table_free(em_table);
> +			return ret;
> +		}
> +
> +		em_table->state[i].power = power;
> +	}
> +
> +	return em_recalc_and_update(dev, pd, em_table);
> +}
> +EXPORT_SYMBOL_GPL(em_dev_update_chip_binning);

In the previous version of 'chip-binning' you were using the new EM
interface em_dev_compute_costs() (1) which is now replaced by
em_recalc_and_update() -> em_compute_costs().

https://lkml.kernel.org/r/20231220110339.1065505-2-lukasz.luba@arm.com

Which leaves (1) still unused.

That was why my concern back then that we shouldn't introduce EM
interfaces without a user:

https://lkml.kernel.org/r/8fc499cf-fca1-4465-bff7-a93dfd36f3c8@arm.com

What happens now with em_dev_compute_costs()?





