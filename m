Return-Path: <linux-kernel+bounces-99295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BA878623
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3233D1C21FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF0482CF;
	Mon, 11 Mar 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Loj0U2l0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36C4C61C;
	Mon, 11 Mar 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177220; cv=none; b=ma9J4CPu9XyttGSFctVUsQQoTmfp0VHZsHpBJXHnUW1iqffGpyOi/7965BezLQcR6X7dR8c+Po1pccFOGbM00mcZcv5S6C+zuaYaA2zLpJ8oNi5fn+p+jho1Jd/6ryZuy5lSTGV7rXZ3+vm2KqK1tOUSlY98KTusd877Px+od+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177220; c=relaxed/simple;
	bh=eviduWcAZzHBoe8f3MV1ClcI4356lgBVZePi0rDZuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNXwrQoMerm2pd+shYeXGpJvFk/7dfR8nxqMXQFSBUxYGjVZdgMmrVpTe8u4kz3vIeezLnm6jQyvUS3zucep7zK1ED+AYoLydAmbNmKj6LXP8/rWt8lf9SRN2pUf3znSK04K8PBg+WHlm9YkMJ6+QCHhLbt3dTpvvibhThSctkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Loj0U2l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4EBC433F1;
	Mon, 11 Mar 2024 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710177219;
	bh=eviduWcAZzHBoe8f3MV1ClcI4356lgBVZePi0rDZuqM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=Loj0U2l0Xpv3XNqVh+1EJIG6JBkYULCIX2XEnNf9s47AEDkC5jYD/rqS4WbCqi/KN
	 TknvGyQ8MiDtw2T67xhChYdNy3XhJDGKc1J140j7Y9GRTlO/MUBnf8FZstnMNxNLvM
	 qAilAq5OsrO3uPvdfcyCHlOISwLELLU379HsBBeC8k6YWu3K3TqyUhYbpq2rghgA5x
	 w00j39m4dVuuuDZajvw351r8/qw8HjrcPtdI6C9AwxcoyeDIiabqI7veU8q4TrapJQ
	 lKibjzYBJSJtmoUAWOKKmKevnjWbUIifX9vL/BQEUsmJ18+8jOIQ+gY8Uxj6MNV+J4
	 BRTQRPAliqUyA==
Date: Mon, 11 Mar 2024 11:13:37 -0600
From: Rob Herring <robh@kernel.org>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: [PATCH v4 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
Message-ID: <20240311171337.GB1370807-robh@kernel.org>
References: <20240308191204.819487-1-quic_obabatun@quicinc.com>
 <20240308191204.819487-2-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308191204.819487-2-quic_obabatun@quicinc.com>

On Fri, Mar 08, 2024 at 11:12:01AM -0800, Oreoluwa Babatunde wrote:
> The current implementation processes the reserved memory regions in two
> stages which are done with two separate functions within the
> early_init_fdt_scan_reserved_mem() function.
> 
> Within the two stages of processing, the reserved memory regions are
> broken up into two groups which are processed differently:
> i) Statically-placed reserved memory regions
> i.e. regions defined with a static start address and size using the
>      "reg" property in the DT.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions defined by specifying a range of addresses where they can
>      be placed in memory using the "alloc_ranges" and "size" properties
>      in the DT.
> 
> Stage 1: fdt_scan_reserved_mem()
> This stage of the reserved memory processing is used to scan through the
> reserved memory nodes defined in the devicetree and do the following on
> each of the nodes:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>    - Add the information for the reserved region to the reserved_mem array.
>      eg: fdt_reserved_mem_save_node(node, name, base, size);
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. it is defined using "alloc-ranges" and "size" properties:
>    - Add the information for the region to the reserved_mem array with
>      the starting address and size set to 0.
>      eg: fdt_reserved_mem_save_node(node, name, 0, 0);
> 
> Stage 2: fdt_init_reserved_mem()
> This stage of the reserved memory processing is used to iterate through
> the reserved_mem array which was populated in stage 1 and do the
> following on each of the entries:
> 
> 1) If the entry represents a statically-placed reserved memory region:
>    - Call the region specific init function.
> 2) If the entry represents a dynamically-placed reserved memory region:
>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>      for the region using memblock_phys_alloc_range(), and call
>      memblock_mark_nomap() on the allocated region if the region is
>      specified as a no-map region.
>    - Call the region specific init function.
> 
> On architectures such as arm64, the dynamic allocation of the
> reserved_mem array needs to be done after the page tables have been
> setup because memblock allocated memory is not writable until then. This
> means that the reserved_mem array will not be available to store any
> reserved memory information until after the page tables have been setup.
> 
> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> the statically-placed reserved memory regions and not need to save them
> to the reserved_mem array until later. This is because all the
> information we need is present in the devicetree.
> Dynamically-placed reserved memory regions on the other hand get assigned
> a start address only at runtime, and since memblock_reserve() and
> memblock_mark_nomap() need to be called before the memory mappings are
> created, the allocation needs to happen before the page tables are setup.
> 
> To make it easier to handle dynamically-placed reserved memory regions
> before the page tables are setup, this patch makes changes to the steps
> above to process the reserved memory regions in the following ways:
> 
> Step 1: fdt_scan_reserved_mem()
> This stage of the reserved memory processing is used to scan through the
> reserved memory nodes defined in the devicetree and do the following on
> each of the nodes:
> 
> 1) If the node represents a statically-placed reserved memory region,
>    i.e. it is defined using the "reg" property:
>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
> 
> 2) If the node represents a dynamically-placed reserved memory region,
>    i.e. it is defined using "alloc-ranges" and "size" properties:
>    - Call __reserved_mem_alloc_size() which will:
>      i) Allocate memory for the reserved memory region.
>      ii) Call memblock_mark_nomap() as needed.
>      Note: There is no need to explicitly call memblock_reserve() here
>      because it is already called by memblock when the memory for the
>      region is being allocated.
>      iii) Save the information for the region in the reserved_mem array.
> 
> Step 2: fdt_init_reserved_mem()
> This stage of the reserved memory processing is used to:
> 
> 1) Add the information for the statically-placed reserved memory into
>    the reserved_mem array.
> 
> 2) Iterate through all the entries in the array and call the region
>    specific init function for each of them.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/fdt.c                | 84 ++++++++++++++++++++++++++++++---
>  drivers/of/of_private.h         |  2 +-
>  drivers/of/of_reserved_mem.c    | 54 +++++++++------------
>  include/linux/of_fdt.h          |  1 +
>  include/linux/of_reserved_mem.h |  9 ++++
>  5 files changed, 111 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index bf502ba8da95..fe6c75c5a8c0 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -504,7 +504,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  	phys_addr_t base, size;
>  	int len;
>  	const __be32 *prop;
> -	int first = 1;
>  	bool nomap;
>  
>  	prop = of_get_flat_dt_prop(node, "reg", &len);
> @@ -532,10 +531,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>  			       uname, &base, (unsigned long)(size / SZ_1M));
>  
>  		len -= t_len;
> -		if (first) {
> -			fdt_reserved_mem_save_node(node, uname, base, size);
> -			first = 0;
> -		}
>  	}
>  	return 0;
>  }
> @@ -563,12 +558,70 @@ static int __init __reserved_mem_check_root(unsigned long node)
>  	return 0;
>  }
>  
> +/**
> + * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
> + * reserved memory regions.
> + *
> + * This function is used to scan through the DT and store the
> + * information for the reserved memory regions that are defined using
> + * the "reg" property. The region node number, name, base address, and
> + * size are all stored in the reserved_mem array by calling the
> + * fdt_reserved_mem_save_node() function.
> + */
> +void __init fdt_scan_reserved_mem_reg_nodes(void)
> +
> +{
> +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
> +	const void *fdt = initial_boot_params;
> +	phys_addr_t base, size;
> +	const __be32 *prop;
> +	int node, child;
> +	int len;
> +
> +	node = fdt_path_offset(fdt, "/reserved-memory");
> +	if (node < 0) {
> +		pr_err("Reserved memory: Did not find reserved-memory node\n");

No reserved regions is perfectly valid.

> +		return;
> +	}
> +
> +	if (__reserved_mem_check_root(node)) {
> +		pr_err("Reserved memory: unsupported node format, ignoring\n");
> +		return;
> +	}
> +
> +	fdt_for_each_subnode(child, fdt, node) {
> +		const char *uname;
> +
> +		prop = of_get_flat_dt_prop(child, "reg", &len);
> +		if (!prop)
> +			continue;
> +
> +		if (!of_fdt_device_is_available(fdt, child))
> +			continue;
> +
> +		uname = fdt_get_name(fdt, child, NULL);
> +		if (len && len % t_len != 0) {
> +			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
> +			       uname);
> +			continue;
> +		}
> +
> +		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +		size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +		if (size)
> +			fdt_reserved_mem_save_node(child, uname, base, size);
> +	}
> +}
> +
>  /*
>   * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
>   */
>  static int __init fdt_scan_reserved_mem(void)
>  {
>  	int node, child;
> +	int dynamic_nodes_cnt = 0;
> +	int dynamic_nodes[MAX_RESERVED_REGIONS];
>  	const void *fdt = initial_boot_params;
>  
>  	node = fdt_path_offset(fdt, "/reserved-memory");
> @@ -590,8 +643,25 @@ static int __init fdt_scan_reserved_mem(void)
>  		uname = fdt_get_name(fdt, child, NULL);
>  
>  		err = __reserved_mem_reserve_reg(child, uname);
> -		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
> -			fdt_reserved_mem_save_node(child, uname, 0, 0);
> +
> +		/*
> +		 * Delay allocation of the dynamically-placed regions
> +		 * until after all other statically-placed regions have
> +		 * been reserved or marked as nomap
> +		 */
> +		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
> +			dynamic_nodes[dynamic_nodes_cnt] = child;
> +			dynamic_nodes_cnt++;

Can't you just call __reserved_mem_alloc_size() here instead of looping 
twice?

> +		}
> +	}
> +
> +	for (int i = 0; i < dynamic_nodes_cnt; i++) {
> +		const char *uname;
> +
> +		child = dynamic_nodes[i];
> +		uname = fdt_get_name(fdt, child, NULL);
> +
> +		__reserved_mem_alloc_size(child, uname);
>  	}
>  	return 0;
>  }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f38397c7b582..542e37a37a24 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -36,6 +36,7 @@ struct alias_prop {
>  #endif
>  
>  #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
> +#define MAX_RESERVED_REGIONS    64
>  
>  extern struct mutex of_mutex;
>  extern raw_spinlock_t devtree_lock;
> @@ -175,7 +176,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>  }
>  #endif
>  
> -void fdt_init_reserved_mem(void);

I don't see why this is moved.


>  void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>  			       phys_addr_t base, phys_addr_t size);
>  
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcbddb..d62f1956024c 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -26,7 +26,6 @@
>  
>  #include "of_private.h"
>  
> -#define MAX_RESERVED_REGIONS	64
>  static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
>  static int reserved_mem_count;
>  
> @@ -132,8 +131,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
>   * __reserved_mem_alloc_size() - allocate reserved memory described by
>   *	'size', 'alignment'  and 'alloc-ranges' properties.
>   */
> -static int __init __reserved_mem_alloc_size(unsigned long node,
> -	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
> +int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
>  {
>  	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>  	phys_addr_t start = 0, end = 0;
> @@ -212,10 +210,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>  		       uname, (unsigned long)(size / SZ_1M));
>  		return -ENOMEM;
>  	}
> -
> -	*res_base = base;
> -	*res_size = size;
> -
> +	fdt_reserved_mem_save_node(node, uname, base, size);
>  	return 0;
>  }
>  
> @@ -310,6 +305,8 @@ void __init fdt_init_reserved_mem(void)
>  {
>  	int i;
>  
> +	fdt_scan_reserved_mem_reg_nodes();
> +
>  	/* check for overlapping reserved regions */
>  	__rmem_check_for_overlap();
>  
> @@ -328,30 +325,25 @@ void __init fdt_init_reserved_mem(void)
>  		if (prop)
>  			rmem->phandle = of_read_number(prop, len/4);
>  
> -		if (rmem->size == 0)
> -			err = __reserved_mem_alloc_size(node, rmem->name,
> -						 &rmem->base, &rmem->size);
> -		if (err == 0) {
> -			err = __reserved_mem_init_node(rmem);
> -			if (err != 0 && err != -ENOENT) {
> -				pr_info("node %s compatible matching fail\n",
> -					rmem->name);
> -				if (nomap)
> -					memblock_clear_nomap(rmem->base, rmem->size);
> -				else
> -					memblock_phys_free(rmem->base,
> -							   rmem->size);
> -			} else {
> -				phys_addr_t end = rmem->base + rmem->size - 1;
> -				bool reusable =
> -					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
> -
> -				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> -					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> -					nomap ? "nomap" : "map",
> -					reusable ? "reusable" : "non-reusable",
> -					rmem->name ? rmem->name : "unknown");
> -			}
> +		err = __reserved_mem_init_node(rmem);
> +		if (err != 0 && err != -ENOENT) {
> +			pr_info("node %s compatible matching fail\n",
> +				rmem->name);

Can be 1 line now.

> +			if (nomap)
> +				memblock_clear_nomap(rmem->base, rmem->size);
> +			else
> +				memblock_phys_free(rmem->base,
> +						   rmem->size);

Can be 1 line now.

> +		} else {
> +			phys_addr_t end = rmem->base + rmem->size - 1;
> +			bool reusable =
> +				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
> +
> +			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
> +				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
> +				nomap ? "nomap" : "map",
> +				reusable ? "reusable" : "non-reusable",
> +				rmem->name ? rmem->name : "unknown");
>  		}
>  	}
>  }
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index d69ad5bb1eb1..7b2a5d93d719 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -73,6 +73,7 @@ extern int early_init_dt_scan_root(void);
>  extern bool early_init_dt_scan(void *params);
>  extern bool early_init_dt_verify(void *params);
>  extern void early_init_dt_scan_nodes(void);
> +extern void fdt_scan_reserved_mem_reg_nodes(void);

This is internal to drivers/of/, so it goes in of_private.h

>  
>  extern const char *of_flat_dt_get_machine_name(void);
>  extern const void *of_flat_dt_match_machine(const void *default_match,
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index 4de2a24cadc9..2a3178920bae 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -32,12 +32,14 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
>  #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
>  	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
>  
> +void fdt_init_reserved_mem(void);
>  int of_reserved_mem_device_init_by_idx(struct device *dev,
>  				       struct device_node *np, int idx);
>  int of_reserved_mem_device_init_by_name(struct device *dev,
>  					struct device_node *np,
>  					const char *name);
>  void of_reserved_mem_device_release(struct device *dev);
> +int __reserved_mem_alloc_size(unsigned long node, const char *uname);

This is internal to drivers/of/, so it goes in of_private.h

But really, I think fdt_scan_reserved_mem() should move to 
of_reserved_mem.c first. Then everything you add to fdt.c goes there 
too.

Rob

