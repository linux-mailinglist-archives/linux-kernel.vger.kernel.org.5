Return-Path: <linux-kernel+bounces-126868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017128941FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C7CB20F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BA0481DA;
	Mon,  1 Apr 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AWj2rcOE"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A76F481C4;
	Mon,  1 Apr 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990110; cv=none; b=AQJPYhN1SiDyjFCOpFy8vnDszErJX7twSPbnYHzcz8+dAoZqKz1XOE6QKu7FK48yKWks0eBDJ3DaOJukOF755SLKk/s8Crp6yFnpRPy9Ob7FZizodkNg3sZUFsKXVKbnrQpAoJpkpBS43UdB5TCQiUz9DVJDux6dUQFNHr928Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990110; c=relaxed/simple;
	bh=tSyJ6PVksMYjzgHVR92xAuaYRVSmOivuq0i3IT5HQq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJEb3ocbo9sjYR/1P5dhqVY+3fiUIXtVb7gzVwynS7rmtDT8nIbyRwmKzpto1S11cfcDe33YINP2FqhQg46hY/AF4saw3Fj2AivVrSB4lYOjpmgfC5fcVtb/gNr4GBwaLDB64zwzWM+2OgJiV2XAAFYku1+CUhXlZvLvVuHSRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AWj2rcOE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.200.249] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id E77A8208B324;
	Mon,  1 Apr 2024 09:48:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E77A8208B324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711990108;
	bh=YovwcKeCdEMSYZlB5xll68UE601VKTG20deM75BTTf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AWj2rcOEBYPyNvxZOnPIdLg3F6WiQPdvRTPMBTwm/CNbphGfjTRq3R7QASA2yofqu
	 yQytYirRgB0QV31thAA8xCUtizCxtnIMJs5N85CwgbSppndCADYdv507jXksQOpmIv
	 g0r/+S/zA3+PhLWd6SMrdxh/5sRxdkXAc7tEZ0jw=
Message-ID: <eecf5b00-0b61-46a8-82d9-a3c113f2d956@linux.microsoft.com>
Date: Mon, 1 Apr 2024 09:48:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: CPPC: Fix access width used for PCC
 registers
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
 Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240329220054.1205596-1-vanshikonda@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vanshi,

Thanks for testing and catching this. One comment below, but Jarred is OOF for a couple days so
we'll get back again after testing on our platform.

On 3/29/2024 3:00 PM, Vanshidhar Konda wrote:
> Commit 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for
> system memory accesses") modified cpc_read/cpc_write to use access_width to
> read CPC registers. For PCC registers the access width field in the ACPI
> register macro specifies the PCC subspace id. For non-zero PCC subspace id
> the access width is incorrectly treated as access width. This causes errors
> when reading from PCC registers in the CPPC driver.
> 
> For PCC registers base the size of read/write on the bit width field.
> The debug message in cpc_read/cpc_write is updated to print relevant
> information for the address space type used to read the register.
> 
> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
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
>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4bfbe55553f4..23d16a1ee878 100644
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
> @@ -1018,8 +1018,15 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
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
> @@ -1028,8 +1035,6 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  		return acpi_os_read_memory((acpi_physical_address)reg->address,
>  				val, reg->bit_width);
>  
> -	size = GET_BIT_WIDTH(reg);
> -
>  	switch (size) {
>  	case 8:
>  		*val = readb_relaxed(vaddr);
> @@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  		*val = readq_relaxed(vaddr);
>  		break;
>  	default:
> -		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			pr_debug("Error: Cannot read %u width from for system memory: 0x%llx\n",
> +				reg->bit_width, reg->address);
> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +			pr_debug("Error: Cannot read %u bit width to PCC for ss: %d\n",
>  			 reg->bit_width, pcc_ss_id);
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
> @@ -1076,8 +1087,15 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
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
> @@ -1086,8 +1104,6 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  		return acpi_os_write_memory((acpi_physical_address)reg->address,
>  				val, reg->bit_width);
>  
> -	size = GET_BIT_WIDTH(reg);
> -
>  	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		val = MASK_VAL(reg, val);
>  
> @@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  		writeq_relaxed(val, vaddr);
>  		break;
>  	default:
> -		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
> +		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +			pr_debug("Error: Cannot write %u width from for system memory: 0x%llx\n",
> +				reg->bit_width, reg->address);
                                ^^^^^^^^^^^^^^
Shouldn't this be size = GET_BIT_WIDTH(reg) instead of reg->bit_width? I think this is falling back to the
previous behavior where it assumes access_width was not provided by the platform firmware.

> +		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
>  			 reg->bit_width, pcc_ss_id);
> +		}
>  		ret_val = -EFAULT;
>  		break;
>  	}


Thanks,
Easwar

