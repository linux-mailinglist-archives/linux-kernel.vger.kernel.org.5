Return-Path: <linux-kernel+bounces-151665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237D8AB1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6121C219CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EB512FB08;
	Fri, 19 Apr 2024 15:28:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77F184E;
	Fri, 19 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540532; cv=none; b=oTdC26vYckLwB8irVTA0Tc+Tc8Z+YihI1iAqJKup78XNwQ0TdY39XU16gfZjKSTUkuBvNfA8RsyvQrngldRLSOI+eCXxm0fWmvvCn87HCg/7Cwe/Moflnq1ZHVxuU3M8lptxVBOWnr2gZ9eDmegpMAzH97xK7VGurSVmRHShzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540532; c=relaxed/simple;
	bh=bfF74m4I4t9XPTgeXN2m67auBjU4qnUvI02BEMhTbY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RtA20W5bwm24gxh526StNTeDN5ZgGNOJp8TWb+9m8VAJUt5PJGWFQwHij+Yq6aPcT26Shwbt4WLlITkgnYUnE6D8qIyG0knrxMAmBHVaijmq9R8k9SLJdGkOnqJpHIuLgBsZ1wBq90zrcbcN+6VtXeItt0QT+DIeQHATU/TIv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FEF2F;
	Fri, 19 Apr 2024 08:29:17 -0700 (PDT)
Received: from [192.168.20.58] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6820C3F64C;
	Fri, 19 Apr 2024 08:28:46 -0700 (PDT)
Message-ID: <d143cd11-26ea-42e3-8f32-700a34b3705e@arm.com>
Date: Fri, 19 Apr 2024 10:28:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] riscv: cacheinfo: initialize cacheinfo's level and
 type from ACPI PPTT
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com,
 jhugo@codeaurora.org, john.garry@huawei.com, Jonathan.Cameron@huawei.com,
 pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20240418034330.84721-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/17/24 22:43, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RSIC-V currently does not have a register group that
> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 30a6878287ad..e47a1e6bd3fe 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -6,6 +6,7 @@
>   #include <linux/cpu.h>
>   #include <linux/of.h>
>   #include <asm/cacheinfo.h>
> +#include <linux/acpi.h>
>   
>   static struct riscv_cacheinfo_ops *rv_cache_ops;
>   
> @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
>   	struct device_node *prev = NULL;
>   	int levels = 1, level = 1;
>   
> +	if (!acpi_disabled) {
> +		int ret, fw_levels, split_levels;
> +
> +		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> +		if (ret)
> +			return ret;
> +
> +		BUG_ON((split_levels > fw_levels) ||
> +		       (split_levels + fw_levels > this_cpu_ci->num_leaves));
> +
> +		for (; level <= this_cpu_ci->num_levels; level++) {
> +			if (level <= split_levels) {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +			} else {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> +			}
> +		}
> +		return 0;
> +	}
> +
>   	if (of_property_read_bool(np, "cache-size"))
>   		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>   	if (of_property_read_bool(np, "i-cache-size"))

Yes, looks good.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>



Thanks,

