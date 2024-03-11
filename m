Return-Path: <linux-kernel+bounces-99277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123E8785D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAA22817D7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6B4D11D;
	Mon, 11 Mar 2024 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpDcimtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30C4AEDA;
	Mon, 11 Mar 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176139; cv=none; b=dR9k2KIYh4RMqe1rGq8EnF8GOdM2M9O3vtjrNgI3ByCcaEJB2gzOPfFZOsfmmeJ/PPRn7ja2izMUDyRf8hy6tpaFjNVZXHBxZ4gmS2COZGbdKW31E9JabpgwxB4tSJXVpzToq0uDcp2FKSxqiXP0+B8eRg6cYl3qSlVWQJr+r7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176139; c=relaxed/simple;
	bh=QBY8yBI+jD/WBDEFOQqo+a95NUPLPrB7wWpPMM8YHPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECF14MS5zdd8CFEaQyHfDIul9UtX1Y88BQqF1ajqKMjE0VDn5nLxQv3MkV4YD06IpKOvJ6OZNdyR1gOUoa51z+PldAFdD3jwVSzYL1EfTuAXWOvAXjK7Z1ChKNlRkfWhuKGG2pfc8al1TXkBKxOop7OlmJ9LwhUimVdvBjmhKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpDcimtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A1FC43399;
	Mon, 11 Mar 2024 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710176139;
	bh=QBY8yBI+jD/WBDEFOQqo+a95NUPLPrB7wWpPMM8YHPo=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=UpDcimtSdjhcOQaEPAOry33amGLofgoTr2C0SJMLlb90GodD85ERmPqrLLrC5iPUq
	 dDocLlEIs6kUYvM5rQHYTUiBSCEgA74KlnmwiUuwyH1tuvs4AqMvHKAkF7Nha2dUh2
	 5uIQds1PXNZ56Wl/ipAKlo7BOO0VZ6dpqi4MT2bRaB1tyQVEeIxzEKLB14i2efnQX4
	 pSmNSEPMLa+V9syD0YlXspKugy12H0zycg071J0do2pYckzmFqqmvU2Sf1SFfYCEdx
	 EYj/fmKwZn3XxEL7BrSailaNiWQQ+XU2NomF2O1ROTxy+3W9vbVSo63YAg0TCuBr4q
	 BxOVlHVo9oMDQ==
Date: Mon, 11 Mar 2024 10:55:37 -0600
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
Subject: Re: [PATCH v4 2/4] of: reserved_mem: Add code to dynamically
 allocate reserved_mem array
Message-ID: <20240311165537.GA1370807-robh@kernel.org>
References: <20240308191204.819487-1-quic_obabatun@quicinc.com>
 <20240308191204.819487-3-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308191204.819487-3-quic_obabatun@quicinc.com>

On Fri, Mar 08, 2024 at 11:12:02AM -0800, Oreoluwa Babatunde wrote:
> The reserved_mem array is statically allocated with a size of
> MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
> regions exceeds this size, there will not be enough space to store
> all the data.
> 
> Hence, extend the use of the static array by introducing a
> dynamically allocated array based on the number of reserved memory
> regions specified in the DT.
> 
> On architectures such as arm64, memblock allocated memory is not
> writable until after the page tables have been setup. Hence, the
> dynamic allocation of the reserved_mem array will need to be done only
> after the page tables have been setup.
> 
> As a result, a temporary static array is still needed in the initial
> stages to store the information of the dynamically-placed reserved memory
> regions because the start address is selected only at run-time and is not
> stored anywhere else.
> It is not possible to wait until the reserved_mem array is allocated
> because this is done after the page tables are setup and the reserved
> memory regions need to be initialized before then.
> 
> After the reserved_mem array is allocated, all entries from the static
> array is copied over to the new array, and the rest of the information
> for the statically-placed reserved memory regions are read in from the
> DT and stored in the new array as well.
> 
> Once the init process is completed, the temporary static array is
> released back to the system because it is no longer needed. This is
> achieved by marking it as __initdata.
> 
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  drivers/of/fdt.c             | 15 +++++++---
>  drivers/of/of_private.h      |  1 +
>  drivers/of/of_reserved_mem.c | 53 ++++++++++++++++++++++++++++++++++--
>  3 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index fe6c75c5a8c0..2468360d6053 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -614,13 +614,15 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
>  	}
>  }
>  
> +int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
> +

Put this in of_reserved_mem.c.

>  /*
>   * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
>   */
>  static int __init fdt_scan_reserved_mem(void)
>  {
>  	int node, child;
> -	int dynamic_nodes_cnt = 0;
> +	int dynamic_nodes_cnt = 0, count = 0;
>  	int dynamic_nodes[MAX_RESERVED_REGIONS];
>  	const void *fdt = initial_boot_params;
>  
> @@ -643,6 +645,8 @@ static int __init fdt_scan_reserved_mem(void)
>  		uname = fdt_get_name(fdt, child, NULL);
>  
>  		err = __reserved_mem_reserve_reg(child, uname);
> +		if (!err)
> +			count++;
>  
>  		/*
>  		 * Delay allocation of the dynamically-placed regions
> @@ -657,12 +661,16 @@ static int __init fdt_scan_reserved_mem(void)
>  
>  	for (int i = 0; i < dynamic_nodes_cnt; i++) {
>  		const char *uname;
> +		int err;
>  
>  		child = dynamic_nodes[i];
>  		uname = fdt_get_name(fdt, child, NULL);
>  
> -		__reserved_mem_alloc_size(child, uname);
> +		err = __reserved_mem_alloc_size(child, uname);
> +		if (!err)
> +			count++;
>  	}
> +	total_reserved_mem_cnt = count;
>  	return 0;
>  }
>  

> @@ -715,8 +723,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  			break;
>  		memblock_reserve(base, size);
>  	}
> -
> -	fdt_init_reserved_mem();
>  }
>  
>  /**
> @@ -1405,6 +1411,7 @@ void __init unflatten_device_tree(void)
>  	of_alias_scan(early_init_dt_alloc_memory_arch);
>  
>  	unittest_unflatten_overlay_base();
> +	fdt_init_reserved_mem();

This change belongs in patch 1.

>  }
>  
>  /**
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 542e37a37a24..447b63413b39 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -42,6 +42,7 @@ extern struct mutex of_mutex;
>  extern raw_spinlock_t devtree_lock;
>  extern struct list_head aliases_lookup;
>  extern struct kset *of_kset;
> +extern int total_reserved_mem_cnt;
>  
>  #if defined(CONFIG_OF_DYNAMIC)
>  extern int of_property_notify(int action, struct device_node *np,
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index d62f1956024c..3c4373b021be 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -26,7 +26,8 @@
>  
>  #include "of_private.h"
>  
> -static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
> +static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
> +static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
>  static int reserved_mem_count;
>  
>  static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> @@ -54,6 +55,48 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  	return err;
>  }
>  
> +/**
> + * alloc_reserved_mem_array() - allocate memory for the reserved_mem
> + * array using memblock
> + *
> + * This function is used to allocate memory for the reserved_mem array
> + * according to the total number of reserved memory regions defined in
> + * the DT.
> + * After the new array is allocated, the information stored in the
> + * initial static array is copied over to this new array and the
> + * new array is used from this point on.
> + */
> +static int __init alloc_reserved_mem_array(void)
> +{
> +	struct reserved_mem *new_array;
> +	size_t alloc_size, copy_size, memset_size;
> +
> +	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
> +	if (alloc_size == SIZE_MAX)
> +		return -1;

Use EOVERFLOW

> +
> +	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
> +	if (!new_array)
> +		return -ENOMEM;
> +
> +	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
> +	if (copy_size == SIZE_MAX)
> +		goto overlow_err;

This is the only path for goto, so move the cleanup here.

> +
> +	memset_size = alloc_size - copy_size;
> +
> +	memcpy(new_array, reserved_mem, copy_size);
> +	memset(new_array + reserved_mem_count, 0, memset_size);
> +
> +	reserved_mem = new_array;
> +	return 0;
> +
> +overlow_err:
> +	memblock_free(new_array, alloc_size);
> +	total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
> +	return -1;

Use EOVERFLOW

> +}
> +
>  /*
>   * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
>   */
> @@ -62,7 +105,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>  {
>  	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
>  
> -	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
> +	if (reserved_mem_count == total_reserved_mem_cnt) {
>  		pr_err("not enough space for all defined regions.\n");
>  		return;
>  	}
> @@ -303,7 +346,11 @@ static void __init __rmem_check_for_overlap(void)
>   */
>  void __init fdt_init_reserved_mem(void)
>  {
> -	int i;
> +	int i, ret;
> +
> +	ret = alloc_reserved_mem_array();
> +	if (ret)
> +		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);

As printing a message is the only error handling, better to just print 
something in alloc_reserved_mem_array() and return void.

>  
>  	fdt_scan_reserved_mem_reg_nodes();
>  
> -- 
> 2.34.1
> 

