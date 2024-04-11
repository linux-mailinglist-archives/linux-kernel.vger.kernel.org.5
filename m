Return-Path: <linux-kernel+bounces-141662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68298A2196
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781B62890BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B63D547;
	Thu, 11 Apr 2024 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aQpKo4mU"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5284225D7;
	Thu, 11 Apr 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873279; cv=none; b=uWtZBSl/bPmGmmTci/t7NluFL29V/GaJEJ7TDh1In/RAIta78wkGCOZ1t/mxNEXisG4DkZCbiADcjM0YkdBspYKLFJfwB/xHCNt6xkvE07yQYcE0mhzMskBVXVC2rG63zCGgwcw54v6MGOZc+sO/WVBDjBGnzXYzYBnyQhWeh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873279; c=relaxed/simple;
	bh=6GyJ1moyGyzPMs+T8Tio5Hd2q/mmqtXU1wGSLBkqoD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5f1fUt4B5T/8Y0Tu6QgDYe3TIBBC6vx+Yvu4sO1HZ/NXFoLrvGO98zatO5FZ1Tn8WFCm27ylawnZgI+exwdWXFtNUvfK1BJzNQj+ijZTKWuB5yhjxxxOo8NK5h1IZb8iZQNRu6GuH35//bJjYKdmGd0hB/5vD4M9RuyqHw7OhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aQpKo4mU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.225.52] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id ACEC220EC318;
	Thu, 11 Apr 2024 15:07:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACEC220EC318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712873277;
	bh=LMTBUyPQSa+ZQmS7leeSy5hd89KM45LnFsigAQb9pZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aQpKo4mUtAJLaqwMOzcNsTcHMV/7oQ1HmdSBKscTKordamzhjzwDOK+BwSGxAoDN9
	 X1y3AZ5lsPxVz3tutxuvyjKpQeW/OezME8JKU4qk5Gk2afzbK1TESNxj+i/2fv9coL
	 +zgfb8OjGPiqC8LgOHfZmkDeWpbKKqRIr991nNDc=
Message-ID: <5f3f0bbf-8d17-47b0-bbc2-1bdcc1e1a733@linux.microsoft.com>
Date: Thu, 11 Apr 2024 15:07:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: CPPC: Fix access width used for PCC registers
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 "5 . 15+" <stable@vger.kernel.org>
References: <20240411212306.1359466-1-vanshikonda@os.amperecomputing.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240411212306.1359466-1-vanshikonda@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/2024 2:23 PM, Vanshidhar Konda wrote:
> commit 2f4a4d63a193be6fd530d180bb13c3592052904c modified
> cpc_read/cpc_write to use access_width to read CPC registers. For PCC
> registers the access width field in the ACPI register macro specifies
> the PCC subspace id. For non-zero PCC subspace id the access width is
> incorrectly treated as access width. This causes errors when reading
> from PCC registers in the CPPC driver.
> 
> For PCC registers base the size of read/write on the bit width field.
> The debug message in cpc_read/cpc_write is updated to print relevant
> information for the address space type used to read the register.
> 
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
> Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
> Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
> ---
> 
> When testing v6.9-rc1 kernel on AmpereOne system dmesg showed that
> cpufreq policy had failed to initialize on some cores during boot because
> cpufreq->get() always returned 0. On this system CPPC registers are in PCC
> subspace index 2 that are 32 bits wide. With this patch the CPPC driver
> interpreted the access width field as 16 bits, causing the register read
> to roll over too quickly to provide valid values during frequency
> computation.
> 
> v2:
> - Use size variable in debug print message
> - Use size instead of reg->bit_width for acpi_os_read_memory and
>   acpi_os_write_memory
> 
>  drivers/acpi/cppc_acpi.c | 53 ++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 16 deletions(-)

Thanks for adding the CC: stable tag. Couple of nits, assuming those are fixed:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4bfbe55553f4..a037e9d15f48 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1002,14 +1002,14 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  	}
>  
>  	*val = 0;
> +	size = GET_BIT_WIDTH(reg);
>  
>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = GET_BIT_WIDTH(reg);
>  		u32 val_u32;
>  		acpi_status status;
>  
>  		status = acpi_os_read_port((acpi_io_address)reg->address,
> -					   &val_u32, width);
> +					   &val_u32, size);
>  		if (ACPI_FAILURE(status)) {
>  			pr_debug("Error: Failed to read SystemIO port %llx\n",
>  				 reg->address);
> @@ -1018,17 +1018,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  
>  		*val = val_u32;
>  		return 0;
> -	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> +	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
> +		/*
> +		 * For registers in PCC space, the register size is determined
> +		 * by the bit width field; the access size is used to indicate
> +		 * the PCC subspace id.
> +		 */
> +		size = reg->bit_width;
>  		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> +	}
>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		vaddr = reg_res->sys_mem_vaddr;
>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
>  		return cpc_read_ffh(cpu, reg, val);
>  	else
>  		return acpi_os_read_memory((acpi_physical_address)reg->address,
> -				val, reg->bit_width);
> -
> -	size = GET_BIT_WIDTH(reg);
> +				val, size);
>  
>  	switch (size) {
>  	case 8:
> @@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  		*val = readq_relaxed(vaddr);
>  		break;
>  	default:
> -		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
> -			 reg->bit_width, pcc_ss_id);
> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			pr_debug("Error: Cannot read %u width from for system memory: 0x%llx\n",
> +				size, reg->address);

Nit: from for? There might be a missing word there, or just an extra. Ditto for cpc_write() below.

> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +			pr_debug("Error: Cannot read %u bit width to PCC for ss: %d\n",
> +				size, pcc_ss_id);
> +		}
>  		return -EFAULT;
>  	}
>  
> @@ -1063,12 +1073,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>  	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>  
> +	size = GET_BIT_WIDTH(reg);
> +
>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = GET_BIT_WIDTH(reg);
>  		acpi_status status;
>  
>  		status = acpi_os_write_port((acpi_io_address)reg->address,
> -					    (u32)val, width);
> +					    (u32)val, size);
>  		if (ACPI_FAILURE(status)) {
>  			pr_debug("Error: Failed to write SystemIO port %llx\n",
>  				 reg->address);
> @@ -1076,17 +1087,22 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  		}
>  
>  		return 0;
> -	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
> +	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
> +		/*
> +		 * For registers in PCC space, the register size is determined
> +		 * by the bit width field; the access size is used to indicate
> +		 * the PCC subspace id.
> +		 */
> +		size = reg->bit_width;
>  		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
> +	}
>  	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		vaddr = reg_res->sys_mem_vaddr;
>  	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
>  		return cpc_write_ffh(cpu, reg, val);
>  	else
>  		return acpi_os_write_memory((acpi_physical_address)reg->address,
> -				val, reg->bit_width);
> -
> -	size = GET_BIT_WIDTH(reg);
> +				val, size);
>  
>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		val = MASK_VAL(reg, val);
> @@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  		writeq_relaxed(val, vaddr);
>  		break;
>  	default:
> -		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
> -			 reg->bit_width, pcc_ss_id);
> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			pr_debug("Error: Cannot write %u width from for system memory: 0x%llx\n",
> +				size, reg->address);
> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
> +				size, pcc_ss_id);
> +		}
>  		ret_val = -EFAULT;
>  		break;
>  	}


