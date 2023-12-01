Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524A6801824
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441926AbjLAXwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjLAXw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:52:26 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77CAA1BF7;
        Fri,  1 Dec 2023 15:52:04 -0800 (PST)
Received: from [10.192.9.210] (unknown [167.220.81.210])
        by linux.microsoft.com (Postfix) with ESMTPSA id C94D120B74C0;
        Fri,  1 Dec 2023 15:52:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C94D120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701474723;
        bh=gZ3VA+8/Gj+Yz4nrqJ+cY+xf1+TC5VM+Uo2ZYHxFToU=;
        h=Date:Subject:Cc:References:From:To:In-Reply-To:From;
        b=Bf6BJnovE2cEt/xyyF84WCafWsc5wLsEpRE2KlrPZAWwDKt9dXfthjerRmCsa8EBn
         jGxAC6aGYbtIfaQa9VkqVEX2az40VMRG+Zkgwg+GxloNbUoXCzF7f6iCO8psNrGgfY
         DaD/i/X1mfTc1E/hFGKJAq4WK5umZh5snSNphOK4=
Message-ID: <db97466d-059f-489a-ac21-24edf39f43cd@linux.microsoft.com>
Date:   Fri, 1 Dec 2023 15:52:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi: Use access_width over register_width for system
 memory accesses
Content-Language: en-US
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <42a5c36d-8b65-418f-9826-2808ab49d67a@linux.microsoft.com>
 <20231026211513.474-1-jarredwhite@linux.microsoft.com>
From:   Jarred White <jarredwhite@linux.microsoft.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20231026211513.474-1-jarredwhite@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/26/2023 2:15 PM, Jarred White wrote:
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
> depend on it being always on a clean 8b boundary. Instead, use access_width
> to determine the size and use the offset and width to shift and mask the
> bits we want to read/write out. Make sure to add a check for system memory
> since pcc redefines the access_width to subspace id.
> 
> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> ---
> changelog:
> v1-->v2:
> 	1. Fixed coding style errors
>          2. Backwards compatibility with ioremapping of address still an
>             open question. Suggestions are welcomed.
> 
>   drivers/acpi/cppc_acpi.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..fb37e1727bf8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>   
> +/* Use access_width to determine the total number of bits */
> +#define ACCESS_WIDTH_TO_BITS(reg) 8 << ((reg)->access_width - 1)
> +
> +/* Shift and apply the mask for CPC reads/writes */
> +#define MASK_VAL(val) (((val) >> reg->bit_offset) & 			\
> +					GENMASK((reg->bit_width), 0))
> +
>   static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   		struct kobj_attribute *attr, char *buf)
>   {
> @@ -777,6 +784,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>   				if (gas_t->address) {
>   					void __iomem *addr;
> +					size_t access_width;
>   
>   					if (!osc_cpc_flexible_adr_space_confirmed) {
>   						pr_debug("Flexible address space capability not supported\n");
> @@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   							goto out_free;
>   					}
>   
> -					addr = ioremap(gas_t->address, gas_t->bit_width/8);
> +					access_width = ACCESS_WIDTH_TO_BITS(gas_t) / 8;
> +					addr = ioremap(gas_t->address, access_width);
>   					if (!addr)
>   						goto out_free;
>   					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
> @@ -980,6 +989,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   {
>   	void __iomem *vaddr = NULL;
> +	int size;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>   
> @@ -991,7 +1001,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   	*val = 0;
>   
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = 8 << (reg->access_width - 1);
> +		u32 width = ACCESS_WIDTH_TO_BITS(reg);
>   		u32 val_u32;
>   		acpi_status status;
>   
> @@ -1015,7 +1025,12 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   		return acpi_os_read_memory((acpi_physical_address)reg->address,
>   				val, reg->bit_width);
>   
> -	switch (reg->bit_width) {
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		size = ACCESS_WIDTH_TO_BITS(reg);
> +	else
> +		size = reg->bit_width;
> +
> +	switch (size) {
>   	case 8:
>   		*val = readb_relaxed(vaddr);
>   		break;
> @@ -1034,18 +1049,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   		return -EFAULT;
>   	}
>   
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		*val = MASK_VAL(*val);
> +
>   	return 0;
>   }
>   
>   static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   {
>   	int ret_val = 0;
> +	int size;
>   	void __iomem *vaddr = NULL;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>   
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = 8 << (reg->access_width - 1);
> +		u32 width = ACCESS_WIDTH_TO_BITS(reg);
>   		acpi_status status;
>   
>   		status = acpi_os_write_port((acpi_io_address)reg->address,
> @@ -1067,7 +1086,14 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   		return acpi_os_write_memory((acpi_physical_address)reg->address,
>   				val, reg->bit_width);
>   
> -	switch (reg->bit_width) {
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		size = ACCESS_WIDTH_TO_BITS(reg);
> +		val = MASK_VAL(val);
> +	} else {
> +		size = reg->bit_width;
> +	}
> +
> +	switch (size) {
>   	case 8:
>   		writeb_relaxed(val, vaddr);
>   		break;

I just wanted to follow-up on the V2 patch and discuss the open we have 
regarding the backwards compatibility with ioremapping of the address.


Thanks,
Jarred

