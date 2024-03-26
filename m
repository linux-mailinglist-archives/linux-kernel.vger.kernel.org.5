Return-Path: <linux-kernel+bounces-118836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8A88BFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A6EB26275
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32FE125C9;
	Tue, 26 Mar 2024 10:51:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A35C99;
	Tue, 26 Mar 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450279; cv=none; b=u0InjfrMX1CUOdoVzHnyxKjsynupVZB+NzfYIe/w6zHWUgLIJWMDvReKoWvQGUHKP+M3DCfUK34BGPdvadTUzbsu6KXv1uuckzIBPetl4A1ptUgQ94iiZlLk3VfwRASUroJFDrbTJZ3lM23ChsA2UU15eCOc4ltt6zCShqbAFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450279; c=relaxed/simple;
	bh=OI7JQ835ZCR5Y7ozOfvQut7gIaPuGOPU6h6L2IuhnbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT3sbMmYXTJPHHp2xXI595sgEutFketBQT/GBaPLQY7vgi+pWbpVgFVaDEE/2McvblxDwxkoFusKTstksPJ74vXcYrE2iHNUD7jcAy1hbriO8HQU+hAsadJDduzvlYfA/W5qUoGORgoVCNjgxBgZP3xRkDrAFEBXbDMyxbQqowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55CA22F4;
	Tue, 26 Mar 2024 03:51:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C88923F64C;
	Tue, 26 Mar 2024 03:51:14 -0700 (PDT)
Message-ID: <ad20a727-bc3e-4408-8d87-fc6a16627bca@arm.com>
Date: Tue, 26 Mar 2024 11:51:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v2 2/4] PM: EM: Change the
 em_adjust_new_capacity() to re-use code
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-3-lukasz.luba@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240322110850.77086-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 12:08, Lukasz Luba wrote:

Maybe better : "PM: EM: Refactoring em_adjust_new_capacity()" ?

> There is going to be a new update function addressing chip binning.
> Therefore, some common code which can be refactored and called from
> upcoming changes and em_adjust_new_capacity(). In this way the code
> duplication can be avoided.

IMHO, that's hard to digest.

Extract em_table_dup() and em_recalc_and_update() from
em_adjust_new_capacity(). Both functions will be later reused by the
'update EM due to chip binning' functionality.

[...]

> +static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
> +				struct em_perf_table __rcu *em_table)
> +{
> +	int ret;
> +
> +	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
>  			       pd->flags);
> -	if (ret) {
> -		dev_warn(dev, "EM: compute costs failed\n");
> -		return;
> -	}
> +	if (ret)
> +		goto free_em_table;

There seems to be a subtle change in this patch. When em_compute_costs()
fails now em_table_free() is called. This wasn't the case before when
em_compute_costs() was directly called from em_adjust_new_capacity().

[...]

