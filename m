Return-Path: <linux-kernel+bounces-144786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2038A4AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E37DB26126
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909F3A1DB;
	Mon, 15 Apr 2024 08:44:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F764241E1;
	Mon, 15 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170692; cv=none; b=AHJU+ufjz2Uf3DVLSmI27T+rVL7AFWFclF1Y3+IG2VUz6cbGiOPyvig+gdwSLfiABas90AfCAju1Q9rpC8oI0rwufa4lmKwlrRUamm8RzqG1SZJ14gJA1XNtZLp6g7TIUR2LSMS7/aJll13IWY1tSrDfdD73rEj4vhRiccibWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170692; c=relaxed/simple;
	bh=UJhbebLNX13N8WSXMEJdlOjX3pgCmfuFic7Jiwgozf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iiblp9VXC+Mj1BnD/53ppv3TE3AEtctKfQgQxjoacJ2tSGYyPBmLJ0egyl5+kpGdtaEYU6c/NWbPsKnWz2aEFluDRXjagvIHP1q+aEKRVBjyNdIiw3bbrM0JBmkmudRAQc/uvx8M1nxgP628D322eKD9Ki1eW/kDnQTDZPKV2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100642F;
	Mon, 15 Apr 2024 01:45:19 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C523F64C;
	Mon, 15 Apr 2024 01:44:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:44:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v2 2/3] riscv: cacheinfo: initialize cacheinfo's level
 and type from ACPI PPTT
Message-ID: <Zhzo_gWFiURs_geD@bogus>
References: <20240414025826.64025-1-cuiyunhui@bytedance.com>
 <20240414025826.64025-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414025826.64025-2-cuiyunhui@bytedance.com>

On Sun, Apr 14, 2024 at 10:58:25AM +0800, Yunhui Cui wrote:
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
>  arch/riscv/kernel/cacheinfo.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 30a6878287ad..ece92aa404e3 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/of.h>
>  #include <asm/cacheinfo.h>
> +#include <linux/acpi.h>
>  
>  static struct riscv_cacheinfo_ops *rv_cache_ops;
>  
> @@ -78,6 +79,28 @@ int populate_cache_leaves(unsigned int cpu)
>  	struct device_node *prev = NULL;
>  	int levels = 1, level = 1;
>  
> +	if (!acpi_disabled) {
> +		int ret, idx, fw_levels, split_levels;
> +
> +		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> +		if (ret)
> +			return ret;
> +
> +		/* must be set, so we can drop num_leaves assignment below */

I intentionally added this above comment to check and drop the below statement
if it is already set. Please check if the value is already set when we call
into this function(which I think is the case).

> +		this_cpu_ci->num_leaves = fw_levels + split_levels;
> +
> +		for (idx = 0; level <= this_cpu_ci->num_levels &&
> +		     idx < this_cpu_ci->num_leaves; idx++, level++) {
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
>  	if (of_property_read_bool(np, "cache-size"))
>  		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>  	if (of_property_read_bool(np, "i-cache-size"))
> -- 
> 2.20.1
> 

-- 
Regards,
Sudeep

