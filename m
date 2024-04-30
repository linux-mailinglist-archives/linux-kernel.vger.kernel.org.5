Return-Path: <linux-kernel+bounces-164196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E298B7A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECBD283D86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C52770EF;
	Tue, 30 Apr 2024 14:49:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D3BE49;
	Tue, 30 Apr 2024 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488545; cv=none; b=rYk6OpSnfzu5/pSUvCrIKEuXlPRdNdus7TzhBDndEjbyU9x4OvLn6XnC14CGs3LLrJ+LmbfkDr3H0vDFISVTbhaZG0FqRWS3oJddwC0GSJcPZGEZDq3fVKMxWtBoTDdEn1GLVKNrhomh+kRBuvckiuLOG7hfdE5qmGsJIMIUbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488545; c=relaxed/simple;
	bh=+jFovgvPAxrrotZHP/C8AyzL+KLYVgvSE15JleJwxyg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+CG555pu9TqJQzhyO2o/Nbsjax2O4icC6w6T/MBlH+iUpdpuspi/djCmy3/F00cXOW/Qb6PyHUCnPne6uD43xS7s1e7lyAMGmP44JkTXORWCT03HWrciibxFRYz29WZstvTK8KxUXeaj4wFfDv4sFcIzwEaYQwOwVNfCj03pFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTNLJ6Xj6z6J7Pl;
	Tue, 30 Apr 2024 22:46:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DD2140A08;
	Tue, 30 Apr 2024 22:48:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 15:48:57 +0100
Date: Tue, 30 Apr 2024 15:48:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>, "Dan Williams"
	<dan.j.williams@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <20240430154856.00006d15@Huawei.com>
In-Reply-To: <20240430092200.2335887-2-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
	<20240430092200.2335887-2-rrichter@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 11:21:54 +0200
Robert Richter <rrichter@amd.com> wrote:

> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> SRAT lookup fails then because an existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> Fix this by making numa_fill_memblks() always available regardless of
> NUMA_KEEP_MEMINFO.
> 
> The fix also removes numa_fill_memblks() from sparsemem.h using
> __weak.
> 
> From Dan:
> 
> """
> It just feels like numa_fill_memblks() has absolutely no business being
> defined in arch/x86/include/asm/sparsemem.h.
> 
> The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> applied to memory ranges hot-onlined by the CXL driver.
> 
> It belongs right next to numa_add_memblk(), and I suspect
> arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> what to do about the fact that linux/numa.h does not include asm/numa.h
> and that all implementations either provide numa_add_memblk() or select
> the generic implementation.
> 
> So I would prefer that this do the proper fix and get
> numa_fill_memblks() completely out of the sparsemem.h path.
> 
> Something like the following which boots for me.
> """
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too, a message is seen then in the logs:
> 
>  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Whilst I'm not particularly keen on an arch specific solution for this
and the stub is effectively pointless beyond making the build work, I guess
this works well enough for now.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I was aiming to post the ARM64 handling this cycle but it hasn't quite happened yet :(
Maybe we can look at whether there is a better level share at than
the whole function once that is done.

Jonathan

> ---
> Authorship can be changed to Dan's if he wants to but that needs his
> Signed-off-by.
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/include/asm/sparsemem.h | 2 --
>  arch/x86/mm/numa.c               | 4 ++--
>  drivers/acpi/numa/srat.c         | 5 +++++
>  include/linux/numa.h             | 7 +------
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..64df897c0ee3 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> -extern int numa_fill_memblks(u64 start, u64 end);
> -#define numa_fill_memblks numa_fill_memblks
>  #endif
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 65e9a6e391c0..ce84ba86e69e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
>  
> +#endif
> +
>  static int __init cmp_memblk(const void *a, const void *b)
>  {
>  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> @@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
>  	}
>  	return 0;
>  }
> -
> -#endif
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index e45e64993c50..3b09fd39eeb4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -208,6 +208,11 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> +__weak int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	return NUMA_NO_MEMBLK;
> +}
> +
>  #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 915033a75731..1d43371fafd2 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -36,12 +36,7 @@ int memory_add_physaddr_to_nid(u64 start);
>  int phys_to_target_node(u64 start);
>  #endif
>  
> -#ifndef numa_fill_memblks
> -static inline int __init numa_fill_memblks(u64 start, u64 end)
> -{
> -	return NUMA_NO_MEMBLK;
> -}
> -#endif
> +int numa_fill_memblks(u64 start, u64 end);
>  
>  #else /* !CONFIG_NUMA */
>  static inline int numa_nearest_node(int node, unsigned int state)


