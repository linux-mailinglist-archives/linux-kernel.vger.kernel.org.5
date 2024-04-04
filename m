Return-Path: <linux-kernel+bounces-131264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C93898573
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160301F2277C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84768062A;
	Thu,  4 Apr 2024 10:53:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF3757F1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228025; cv=none; b=mg4zIl1BjBJPCAtuSeXkjhzDE+kJiSEfM/WgTDUq0vgnkkUnDlyDtMVh8si9JIuA2oYQKThlJntzrnYyJwyHM7rqu4yKV2vfUB3eABZkIkfqukE5TtGSGPK/iqzWwgHZ7wonta52gPIP39r1K/Cf5BQIWzMxH0giFn8Ob+OwYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228025; c=relaxed/simple;
	bh=ZfXwOSagjY7nn9wvzmDHWJ5KfR31qgkvmugf9YJwCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8v5mtdIAx21NsLxGgvyGQbo4U1xxsyO6xn7mbYYYvI9biph2gd0nZQGnDVadC/+33uLCm23EDGXEmSTqBLCkuepE87pbathF4OIWZp+5OvqKNgZShPzzKnlSw3g6XiMcuQlOmctwfqGKO9EQrqMEA+wMG4FLc5K4p2QFUpjfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03C81FEC;
	Thu,  4 Apr 2024 03:54:13 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348813F7B4;
	Thu,  4 Apr 2024 03:53:41 -0700 (PDT)
Message-ID: <e4f4ea31-954a-4726-b2e0-1a537fac4577@arm.com>
Date: Thu, 4 Apr 2024 11:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: tmc: Enable SG capability on ACPI based
 SoC-400 TMC ETR devices
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: sudeep.holla@arm.com, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240404072934.940760-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240404072934.940760-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/04/2024 08:29, Anshuman Khandual wrote:
> This detects and enables the scatter gather capability (SG) on ACPI based
> Soc-400 TMC ETR devices via a new property called 'arm-armhc97c-sg-enable'.
> The updated ACPI spec can be found below, which contains this new property.
> 
> https://developer.arm.com/documentation/den0067/latest/
> 
> This preserves current handling for the property 'arm,scatter-gather' both
> on ACPI and DT based platforms i.e the presence of the property is checked
> instead of the value.
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org 
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-core.c  | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 72005b0c633e..2b277499b59a 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -4,6 +4,7 @@
>   * Description: CoreSight Trace Memory Controller driver
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -360,7 +361,32 @@ static const struct attribute_group *coresight_etr_groups[] = {
>  
>  static inline bool tmc_etr_can_use_sg(struct device *dev)
>  {
> -	return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
> +	int ret;
> +	u8 val_u8;
> +
> +	/*
> +	 * Presence of the property 'arm,scatter-gather' is checked
> +	 * on the platform for the feature support, rather than its
> +	 * value.
> +	 */
> +	if (is_of_node(dev->fwnode)) {
> +		return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
> +	} else if (is_acpi_device_node(dev->fwnode)) {
> +		/*
> +		 * TMC_DEVID_NOSCAT test in tmc_etr_setup_caps(), has already ensured
> +		 * this property is only checked for Coresight SoC 400 TMC configured
> +		 * as ETR.
> +		 */
> +		ret = fwnode_property_read_u8(dev->fwnode, "arm-armhc97c-sg-enable", &val_u8);
> +		if (!ret)
> +			return !!val_u8;
> +
> +		if (fwnode_property_present(dev->fwnode, "arm,scatter-gather")) {
> +			pr_warn_once("Deprecated ACPI property - arm,scatter-gather\n");
> +			return true;
> +		}
> +	}
> +	return false;
>  }
>  
>  static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)


Reviewed-by: James Clark <james.clark@arm.com>

