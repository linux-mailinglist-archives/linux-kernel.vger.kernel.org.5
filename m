Return-Path: <linux-kernel+bounces-66734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94F8560D7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986832819EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3612FB08;
	Thu, 15 Feb 2024 11:04:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180712EBEF;
	Thu, 15 Feb 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995050; cv=none; b=WNZJ0YEIv3gfjfXHiSZpDMHnpNhks6SPPLZ0de6ZJ5bY6xbxFsXV7TFQN7zYH6/k0d0nbT33tTfWoFqUZInH9S4fQDRF9Eguwdy1ErYiIEEzW9CJn4ugcv/aAzrqe7Nmms9rV32Tp/I0+5Y3X/SQ7gq+1/Kc6toOuB2O293smEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995050; c=relaxed/simple;
	bh=MyzTrVGiM5zowB9EEdnskgg9bJSOjLv5uQVVIRr+/Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPRCPQ7nQVPUou0n966A3RYSeH2nQAUCXgkE5N3O16hCtTUFIPEB694Q6VAqLvSIIOtgp4gYozFDSku45bka3XPiIDC3YJOJ7v5f1axX7v0MD4Vk2qDtuY/zowZazizcwD8cRW/aN+bBh7gW4zqmcxMJOsw8GXETEXMrxhWo0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96E301FB;
	Thu, 15 Feb 2024 03:04:48 -0800 (PST)
Received: from [10.57.49.250] (unknown [10.57.49.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86443F7B4;
	Thu, 15 Feb 2024 03:04:05 -0800 (PST)
Message-ID: <68eb9e4e-de77-4854-8212-816c66d5f657@arm.com>
Date: Thu, 15 Feb 2024 11:04:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/11] coresight: etm4x: Fix unbalanced
 pm_runtime_enable()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240123054608.1790189-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 05:45, Anshuman Khandual wrote:
> There is an unbalanced pm_runtime_enable() in etm4_probe_platform_dev()
> when etm4_probe() fails. This problem can be observed via the coresight
> etm4 module's (load -> unload -> load) sequence when etm4_probe() fails
> in etm4_probe_platform_dev().
> 
> [   63.379943] coresight-etm4x 7040000.etm: Unbalanced pm_runtime_enable!
> [   63.393630] coresight-etm4x 7140000.etm: Unbalanced pm_runtime_enable!
> [   63.407455] coresight-etm4x 7240000.etm: Unbalanced pm_runtime_enable!
> [   63.420983] coresight-etm4x 7340000.etm: Unbalanced pm_runtime_enable!
> [   63.420999] coresight-etm4x 7440000.etm: Unbalanced pm_runtime_enable!
> [   63.441209] coresight-etm4x 7540000.etm: Unbalanced pm_runtime_enable!
> [   63.454689] coresight-etm4x 7640000.etm: Unbalanced pm_runtime_enable!
> [   63.474982] coresight-etm4x 7740000.etm: Unbalanced pm_runtime_enable!
> 
> This fixes the above problem - with an explicit pm_runtime_disable() call
> when etm4_probe() fails during etm4_probe_platform_dev().

Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices"

> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V4:
> 
> - New patch in the series
> 
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index ce1995a2827f..7c693b45ac05 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2217,6 +2217,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>   	ret = etm4_probe(&pdev->dev);
>   
>   	pm_runtime_put(&pdev->dev);
> +	if (ret)
> +		pm_runtime_disable(&pdev->dev);
> +
>   	return ret;
>   }
>   

Looks good to me. I have glanced through the other platform device 
driver code in coresight subsystem and they all seem to be safe, except
for Ultrasoc-smb, which doesn't do any power managment. It may be, 
because it is only supported on an ACPI system.

Suzuki


