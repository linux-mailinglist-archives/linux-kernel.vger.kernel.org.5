Return-Path: <linux-kernel+bounces-127635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD8894EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C6FB22E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8158213;
	Tue,  2 Apr 2024 09:31:31 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BF57876;
	Tue,  2 Apr 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050291; cv=none; b=CNqOhZDp8TQgZoTZic1dzVAV8tePR823OknOU21scQEwCXvO3Dgt93IlO00Uq4/tszmUSgVwKSdB67MDltrXnf/Bi1Kfqj6kLuYdqJIRdJlJ2wticAjo3UNGR6Rv7+mwy7zyzFG8NYfvT8BoRVf+TT7yqhhIuP0MIYrWmTYAT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050291; c=relaxed/simple;
	bh=XcO6QrDyIRMglgpT78IcWpD3VE1qSUiB47QoEKtwnFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIYQZT/s5fGWtRMRu2f/9yc7s1NRNYOMpwqE6c448r++j3dDMSIpRsLugYBa6eE4jZYsEF8ueP/Gba3Af1edfg3mNuKuj+rMyfNxak+cgcnF0cIABlJc44jItv+VWFr41qcuRitpdVPlGR1Mvvi5t25Jg8h6rhVZXyVAE0bfBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24A7FFF810;
	Tue,  2 Apr 2024 09:31:18 +0000 (UTC)
Message-ID: <93e24c6c-65e6-4e99-ac56-aa264dbbf525@ghiti.fr>
Date: Tue, 2 Apr 2024 11:31:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ACPI: RISCV: Add NUMA support based on SRAT and
 SLIT
Content-Language: en-US
To: Haibo Xu <haibo1.xu@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Zong Li <zong.li@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, James Morse <james.morse@arm.com>,
 linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, Marc Zyngier <maz@kernel.org>,
 acpica-devel@lists.linux.dev, Robert Moore <robert.moore@intel.com>,
 linux-acpi@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Greentime Hu <greentime.hu@sifive.com>, Len Brown <lenb@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
 Chen Jiahao <chenjiahao16@huawei.com>, Yuntao Wang <ytcoode@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTO+/vT1BIDlnZXI=?= <cleger@rivosinc.com>,
 xiaobo55x@gmail.com, Anup Patel <apatel@ventanamicro.com>,
 Tony Luck <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, ajones@ventanamicro.com
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <7ca110c59cbb2fb358304a9ba4f9c7cbeb191345.1709780590.git.haibo1.xu@intel.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <7ca110c59cbb2fb358304a9ba4f9c7cbeb191345.1709780590.git.haibo1.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Haibo,

On 07/03/2024 09:47, Haibo Xu wrote:
> Add acpi_numa.c file to enable parse NUMA information from
> ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> memory nodes to proximity domain mapping, while SLIT table
> provide the distance metrics between proximity domains.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>   arch/riscv/include/asm/acpi.h |  15 +++-
>   arch/riscv/kernel/Makefile    |   1 +
>   arch/riscv/kernel/acpi.c      |   5 --
>   arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
>   arch/riscv/kernel/setup.c     |   4 +-
>   arch/riscv/kernel/smpboot.c   |   2 -
>   include/linux/acpi.h          |   6 ++
>   7 files changed, 154 insertions(+), 10 deletions(-)
>   create mode 100644 arch/riscv/kernel/acpi_numa.c
>
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 7dad0cf9d701..e0a1f84404f3 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>   
>   void acpi_init_rintc_map(void);
>   struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> -u32 get_acpi_id_for_cpu(int cpu);
> +static inline u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return acpi_cpu_get_madt_rintc(cpu)->uid;
> +}
> +
>   int acpi_get_riscv_isa(struct acpi_table_header *table,
>   		       unsigned int cpu, const char **isa);
>   
> -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
>   void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
>   			     u32 *cboz_size, u32 *cbop_size);
>   #else
> @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
>   
>   #endif /* CONFIG_ACPI */
>   
> +#ifdef CONFIG_ACPI_NUMA
> +int acpi_numa_get_nid(unsigned int cpu);
> +void acpi_map_cpus_to_nodes(void);
> +#else
> +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> +static inline void acpi_map_cpus_to_nodes(void) { }
> +#endif /* CONFIG_ACPI_NUMA */
> +
>   #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..5d3e9cf89b76 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -105,3 +105,4 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
>   
>   obj-$(CONFIG_64BIT)		+= pi/
>   obj-$(CONFIG_ACPI)		+= acpi.o
> +obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index e619edc8b0cc..040bdbfea2b4 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
>   	return &cpu_madt_rintc[cpu];
>   }
>   
> -u32 get_acpi_id_for_cpu(int cpu)
> -{
> -	return acpi_cpu_get_madt_rintc(cpu)->uid;
> -}
> -
>   /*
>    * __acpi_map_table() will be called before paging_init(), so early_ioremap()
>    * or early_memremap() should be called here to for ACPI table mapping.
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> new file mode 100644
> index 000000000000..0231482d6946
> --- /dev/null
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI 6.6 based NUMA setup for RISCV
> + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> + *
> + * Copyright 2004 Andi Kleen, SuSE Labs.
> + * Copyright (C) 2013-2016, Linaro Ltd.
> + *		Author: Hanjun Guo <hanjun.guo@linaro.org>
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
> + *
> + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> + * Assumes all memory regions belonging to a single proximity domain
> + * are in one chunk. Holes between them will be included in the node.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitmap.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/module.h>
> +#include <linux/topology.h>
> +
> +#include <asm/numa.h>
> +
> +static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +
> +int __init acpi_numa_get_nid(unsigned int cpu)
> +{
> +	return acpi_early_node_map[cpu];
> +}
> +
> +static inline int get_cpu_for_acpi_id(u32 uid)
> +{
> +	int cpu;
> +
> +	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> +		if (uid == get_acpi_id_for_cpu(cpu))
> +			return cpu;
> +
> +	return -EINVAL;
> +}
> +
> +static int __init acpi_parse_rintc_pxm(union acpi_subtable_headers *header,
> +				       const unsigned long end)
> +{
> +	struct acpi_srat_rintc_affinity *pa;
> +	int cpu, pxm, node;
> +
> +	if (srat_disabled())
> +		return -EINVAL;
> +
> +	pa = (struct acpi_srat_rintc_affinity *)header;
> +	if (!pa)
> +		return -EINVAL;
> +
> +	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> +		return 0;
> +
> +	pxm = pa->proximity_domain;
> +	node = pxm_to_node(pxm);
> +
> +	/*
> +	 * If we can't map the UID to a logical cpu this
> +	 * means that the UID is not part of possible cpus
> +	 * so we do not need a NUMA mapping for it, skip
> +	 * the SRAT entry and keep parsing.
> +	 */
> +	cpu = get_cpu_for_acpi_id(pa->acpi_processor_uid);
> +	if (cpu < 0)
> +		return 0;
> +
> +	acpi_early_node_map[cpu] = node;
> +	pr_info("SRAT: PXM %d -> HARTID 0x%lx -> Node %d\n", pxm,
> +		cpuid_to_hartid_map(cpu), node);
> +
> +	return 0;
> +}
> +
> +void __init acpi_map_cpus_to_nodes(void)
> +{
> +	int i;
> +
> +	/*
> +	 * In ACPI, SMP and CPU NUMA information is provided in separate
> +	 * static tables, namely the MADT and the SRAT.
> +	 *
> +	 * Thus, it is simpler to first create the cpu logical map through
> +	 * an MADT walk and then map the logical cpus to their node ids
> +	 * as separate steps.
> +	 */
> +	acpi_table_parse_entries(ACPI_SIG_SRAT, sizeof(struct acpi_table_srat),
> +				 ACPI_SRAT_TYPE_RINTC_AFFINITY, acpi_parse_rintc_pxm, 0);
> +
> +	for (i = 0; i < nr_cpu_ids; i++)
> +		early_map_cpu_to_node(i, acpi_numa_get_nid(i));
> +}
> +
> +/* Callback for Proximity Domain -> logical node ID mapping */
> +void __init acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa)
> +{
> +	int pxm, node;
> +
> +	if (srat_disabled())
> +		return;
> +
> +	if (pa->header.length < sizeof(struct acpi_srat_rintc_affinity)) {
> +		pr_err("SRAT: Invalid SRAT header length: %d\n", pa->header.length);
> +		bad_srat();
> +		return;
> +	}
> +
> +	if (!(pa->flags & ACPI_SRAT_RINTC_ENABLED))
> +		return;
> +
> +	pxm = pa->proximity_domain;
> +	node = acpi_map_pxm_to_node(pxm);
> +
> +	if (node == NUMA_NO_NODE) {
> +		pr_err("SRAT: Too many proximity domains %d\n", pxm);
> +		bad_srat();
> +		return;
> +	}
> +
> +	node_set(node, numa_nodes_parsed);
> +}


What is riscv specific in the parsing of those tables? Can't we try to 
merge this into generic ACPI code? I know that's a burden to try and 
factorize code with other architectures instead of reusing it, but it 
showed numerous times that duplicating was even worse (I have the NAPOT 
code in mind).

Thanks,

Alex


> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4f73c0ae44b2..a2cde65b69e9 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -281,8 +281,10 @@ void __init setup_arch(char **cmdline_p)
>   	setup_smp();
>   #endif
>   
> -	if (!acpi_disabled)
> +	if (!acpi_disabled) {
>   		acpi_init_rintc_map();
> +		acpi_map_cpus_to_nodes();
> +	}
>   
>   	riscv_init_cbo_blocksizes();
>   	riscv_fill_hwcap();
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index cfbe4b840d42..81a2aa77680c 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -100,7 +100,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
>   	if (hart == cpuid_to_hartid_map(0)) {
>   		BUG_ON(found_boot_cpu);
>   		found_boot_cpu = true;
> -		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
>   		return 0;
>   	}
>   
> @@ -110,7 +109,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
>   	}
>   
>   	cpuid_to_hartid_map(cpu_count) = hart;
> -	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
>   	cpu_count++;
>   
>   	return 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..f74c62956e07 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -269,6 +269,12 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>   
>   int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>   
> +#ifdef CONFIG_RISCV
> +void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa);
> +#else
> +static inline void acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> +#endif
> +
>   #ifndef PHYS_CPUID_INVALID
>   typedef u32 phys_cpuid_t;
>   #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)

