Return-Path: <linux-kernel+bounces-75906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584A85F07F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E2B284AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5321C14;
	Thu, 22 Feb 2024 04:46:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2610E6;
	Thu, 22 Feb 2024 04:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577168; cv=none; b=kGlJAGmP9jNaVyGNTo3AVcKWTREAVPwdmaRSwxRJ/ix6g+Zz4UUxCcOjk15LAlIhqZbh0sIl1Wk14D16l4H6lQfQjGiGarYET/UO0OPmGdqLpRSN19erx2PhCWDkrK3hx7+F69Xs4XR66Cfz0dCMT24R2mz5qn9eEW/WpUxPjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577168; c=relaxed/simple;
	bh=DOFuJP32JfVLnHOt7Gsj7z5JBoLZWG7S0ZlTo53ht8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQH9o6GrGQ1B8nb3y1tIjpFkfH0qiJXGR174dViQJPJhhj+oEZyhdm2nZ6FZtvzlYlWk8rL5YB0G4I9rj5PJ642t/VJgwbi0rXbM81OPSz0Lb1EmURKBjiiX4DujVxqPydGP2FtF31/1Ilj/pK6dQ0IujC0aAW2p87cV/fZ+pwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8ADF1007;
	Wed, 21 Feb 2024 20:46:37 -0800 (PST)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6FC73F766;
	Wed, 21 Feb 2024 20:45:54 -0800 (PST)
Message-ID: <8c4165e1-e875-4a61-8935-1ae1e2099477@arm.com>
Date: Thu, 22 Feb 2024 10:15:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/11] coresight: etm4x: Fix unbalanced
 pm_runtime_enable()
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Leo Yan <leo.yan@linaro.org>
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
 <20240123054608.1790189-2-anshuman.khandual@arm.com>
 <68eb9e4e-de77-4854-8212-816c66d5f657@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <68eb9e4e-de77-4854-8212-816c66d5f657@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/15/24 16:34, Suzuki K Poulose wrote:
> On 23/01/2024 05:45, Anshuman Khandual wrote:
>> There is an unbalanced pm_runtime_enable() in etm4_probe_platform_dev()
>> when etm4_probe() fails. This problem can be observed via the coresight
>> etm4 module's (load -> unload -> load) sequence when etm4_probe() fails
>> in etm4_probe_platform_dev().
>>
>> [   63.379943] coresight-etm4x 7040000.etm: Unbalanced pm_runtime_enable!
>> [   63.393630] coresight-etm4x 7140000.etm: Unbalanced pm_runtime_enable!
>> [   63.407455] coresight-etm4x 7240000.etm: Unbalanced pm_runtime_enable!
>> [   63.420983] coresight-etm4x 7340000.etm: Unbalanced pm_runtime_enable!
>> [   63.420999] coresight-etm4x 7440000.etm: Unbalanced pm_runtime_enable!
>> [   63.441209] coresight-etm4x 7540000.etm: Unbalanced pm_runtime_enable!
>> [   63.454689] coresight-etm4x 7640000.etm: Unbalanced pm_runtime_enable!
>> [   63.474982] coresight-etm4x 7740000.etm: Unbalanced pm_runtime_enable!
>>
>> This fixes the above problem - with an explicit pm_runtime_disable() call
>> when etm4_probe() fails during etm4_probe_platform_dev().
> 
> Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices"

Sure, will add this 'Fixes' tag here.

> 
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Hanjun Guo <guohanjun@huawei.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V4:
>>
>> - New patch in the series
>>
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index ce1995a2827f..7c693b45ac05 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -2217,6 +2217,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>>       ret = etm4_probe(&pdev->dev);
>>         pm_runtime_put(&pdev->dev);
>> +    if (ret)
>> +        pm_runtime_disable(&pdev->dev);
>> +
>>       return ret;
>>   }
>>   
> 
> Looks good to me. I have glanced through the other platform device driver code in coresight subsystem and they all seem to be safe, except
> for Ultrasoc-smb, which doesn't do any power managment. It may be, because it is only supported on an ACPI system.

Understood.

