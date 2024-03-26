Return-Path: <linux-kernel+bounces-119941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA288CF42
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38DEB2BE97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131C13F422;
	Tue, 26 Mar 2024 20:36:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0B013E04F;
	Tue, 26 Mar 2024 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485374; cv=none; b=f85bKCP1lRI6t9JX6wNWv1Cud80wMKJtiJnujFy46B0NPXRWc1wxw3B16TT/9Iwbjr55cjRfr0PhvSTCiJSYXXjd+fPIdTjk4Je2K3TZ67ElJ9t2q3//huX4FEmxF4jqKMSDjRw+atSsKY1Tjdj2iupsfWFncGl893081LXoN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485374; c=relaxed/simple;
	bh=vxP2g7nMxgBwL/7W9b8XPK++/O/kUS8yVNPzMMrQVvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU8mIyK6IM3kKys0vt+kWs9AzaKE4joHBOtoISf3Bf7Uc3bcEkceRV2TUDWtkHKG2tCZ32Bi2PXv1s+W0ppKfPCbjPxN4W+dR4E9bPBmOMldNTYm/4G5sp//Jbl+Z3chJHoiJ6pCryGOg2ZcwNV9xKcX0SLPZhvXzzdf8tlNxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E73B2F4;
	Tue, 26 Mar 2024 13:36:45 -0700 (PDT)
Received: from [10.57.71.219] (unknown [10.57.71.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1C93F64C;
	Tue, 26 Mar 2024 13:36:09 -0700 (PDT)
Message-ID: <96b5c2a1-b259-47ea-ba61-384526c5a3b4@arm.com>
Date: Tue, 26 Mar 2024 20:36:08 +0000
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
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, viresh.kumar@linaro.org, krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com, m.szyprowski@samsung.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-3-lukasz.luba@arm.com>
 <ad20a727-bc3e-4408-8d87-fc6a16627bca@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ad20a727-bc3e-4408-8d87-fc6a16627bca@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/26/24 10:51, Dietmar Eggemann wrote:
> On 22/03/2024 12:08, Lukasz Luba wrote:
> 
> Maybe better : "PM: EM: Refactoring em_adjust_new_capacity()" ?
> 
>> There is going to be a new update function addressing chip binning.
>> Therefore, some common code which can be refactored and called from
>> upcoming changes and em_adjust_new_capacity(). In this way the code
>> duplication can be avoided.
> 
> IMHO, that's hard to digest.
> 
> Extract em_table_dup() and em_recalc_and_update() from
> em_adjust_new_capacity(). Both functions will be later reused by the
> 'update EM due to chip binning' functionality.

That looks good, I'll update it.

> 
> [...]
> 
>> +static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
>> +				struct em_perf_table __rcu *em_table)
>> +{
>> +	int ret;
>> +
>> +	ret = em_compute_costs(dev, em_table->state, NULL, pd->nr_perf_states,
>>   			       pd->flags);
>> -	if (ret) {
>> -		dev_warn(dev, "EM: compute costs failed\n");
>> -		return;
>> -	}
>> +	if (ret)
>> +		goto free_em_table;
> 
> There seems to be a subtle change in this patch. When em_compute_costs()
> fails now em_table_free() is called. This wasn't the case before when
> em_compute_costs() was directly called from em_adjust_new_capacity().

Yes, I've refactored it to explicitly call to the same free_em_table
for both fails in the new code. It should have been done in old code.

> 
> [...]

