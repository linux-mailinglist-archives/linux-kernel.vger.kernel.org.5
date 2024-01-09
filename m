Return-Path: <linux-kernel+bounces-21478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43F828FFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E9E1C24FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFEA3E463;
	Tue,  9 Jan 2024 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPM9J3td"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E93C471;
	Tue,  9 Jan 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=g8AInbn27PK/qmmN0ungmXN+ZObkjDg3tOsWh8gDQaw=; b=gPM9J3tdDBH+7H4NT9yFSSQZ5y
	UsL7UJKUCL6/PAUtbH5oMMArEBvAQbkZfbm9hP4x7mHHwXwaxHk66Gf1ube6uMTFMC0IWUPiutyHU
	IzRZJX4YGrXhnoh+ytnTqj4/uoC6Ryppgh8yXCgPYAZnzUZ4N8CwwuRp1LVY2D8s5npJrHaVgTbuS
	fGgzqe8HchnLaqY3l4wacXcD8rlH84KT9l5zCD+C8KiBhxaUgxpqBgtCH4vNitb9Y6dYOHCk7bUex
	5negT2B7Yg10L/WUDRyR/qmuoyJwp1sWYyIZ03FPQZPVmlCwVXt1OGPYb0iqcCzuXApt5jC0u8aLC
	rqidvqpg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNKer-009jQb-2M;
	Tue, 09 Jan 2024 22:33:17 +0000
Message-ID: <e48c1e84-b27e-4109-b80d-084ba8a399ff@infradead.org>
Date: Tue, 9 Jan 2024 14:33:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/12] pstore/ram: Add dynamic ramoops region support
 through commandline
Content-Language: en-US
To: Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mathieu.poirier@linaro.org, vigneshr@ti.com, nm@ti.com,
 matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
 bmasney@redhat.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
 <20240109153200.12848-9-quic_mojha@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240109153200.12848-9-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/24 07:31, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This may not be
> required for something like Qualcomm's minidump which is interested
> in knowing addresses of ramoops region but it does not put hard
> requirement of address being fixed as most of it's SoC does not

                                                its

> support warm reset and does not use pstorefs at all instead it has
> firmware way of collecting ramoops region if it gets to know the
> address and register it with apss minidump table which is sitting
> in shared memory region in DDR and firmware will have access to
> these table during reset and collects it on crash of SoC.
> 
> So, add the support of reserving ramoops region to be dynamically
> allocated early during boot if it is request through command line
> via 'dyn_ramoops_size=<size>' and fill up reserved resource structure
> and export the structure, so that it can be read by ramoops driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  Documentation/admin-guide/ramoops.rst | 23 +++++++++-
>  fs/pstore/Kconfig                     | 15 ++++++
>  fs/pstore/ram.c                       | 66 +++++++++++++++++++++++++--
>  include/linux/pstore_ram.h            |  5 ++
>  init/main.c                           |  2 +
>  5 files changed, 107 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index e9f85142182d..517b00981e99 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
>  Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
>  which enables full cache on it. This can improve the performance.
>  
> +Ramoops supports its memory to be allocated dynamically during early boot
> +for plaforms that does not have support for warm boot i.e., no assurance

       platforms that do not have


> +of Ram content will be preserved across boot and for these platform

   that RAM content                             and for these platforms

> +giving static Ramoops memory is not necessary as it has separate backend
> +mechanism to retrieve ramoops content on system failure. More about
> +how to enable Dynamic ramoops in ``Setting the parameters`` A.b section.
> +
>  The memory area is divided into ``record_size`` chunks (also rounded down to
>  power of two) and each kmesg dump writes a ``record_size`` chunk of
>  information.
> @@ -59,7 +66,7 @@ Setting the parameters
>  
>  Setting the ramoops parameters can be done in several different manners:
>  
> - A. Use the module parameters (which have the names of the variables described
> + A.a  Use the module parameters (which have the names of the variables described
>   as before). For quick debugging, you can also reserve parts of memory during
>   boot and then use the reserved memory for ramoops. For example, assuming a
>   machine with > 128 MB of memory, the following kernel command line will tell
> @@ -68,6 +75,20 @@ Setting the ramoops parameters can be done in several different manners:
>  
>  	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
>  
> + A.b  Ramoops memory can be also be dynamically reserve by Kernel and in such

                                                   reserved

> + scenario ``mem_address`` i.e, Ramoops base address can be anywhere in the RAM

                             i.e.,

> + instead of being fixed and predefined. A separate command line option
> + ``dyn_ramoops_size=<size>`` and kernel config CONFIG_PSTORE_DYNAMIC_RAMOOPS
> + is provided to facilitate Dynamic Ramoops memory reservation during early boot.

    are provided

> + The command line option and the config should only be used in the presence of
> + separate backend which knows how to recover Dynamic Ramoops region otherwise
> + regular ramoops functionality will be impacted.
> + ``mem_size`` should not be used if Dynamic Ramoops support is requested and if
> + both are given ``mem_size`` value is overwritten with ``dyn_ramoops_size`` value
> + i.e, Dynamic Ramoops takes precedence::

    i.e.,

> +
> +	dyn_ramoops_size=2M ramoops.console_size=2097152
> +
>   B. Use Device Tree bindings, as described in
>   ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
>   For example::
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 3acc38600cd1..2f2bb483fd85 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -81,6 +81,21 @@ config PSTORE_RAM
>  
>  	  For more information, see Documentation/admin-guide/ramoops.rst.
>  
> +config PSTORE_DYNAMIC_RAMOOPS
> +	bool "Reserve ramoops region dynamically"
> +	select PSTORE_RAM
> +	help
> +	  This enables the dynamic reservation of ramoops region for a special case
> +	  where there is no requirement to access the logs from pstorefs on next boot

	                                                                         boot;

> +	  instead there is separate backend mechanism like minidump present which has
> +	  awareness about the dynamic ramoops region and can recover the logs. This is
> +	  enabled via command line parameter dyn_ramoops_size=<size> and should not be
> +	  used in absence of separate backend which knows how to recover this dynamic
> +	  region.
> +
> +	  Note whenever this config is selected ramoops driver will be build statically

	                                                               built

> +	  into kernel.
> +
>  config PSTORE_ZONE
>  	tristate
>  	depends on PSTORE
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 88b34fdbf759..795a8300631e 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>  #include <linux/compiler.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  
>  #include "internal.h"
> @@ -103,6 +104,59 @@ struct ramoops_context {
>  };
>  
>  static struct platform_device *dummy;
> +static struct resource dyn_ramoops_res = {
> +	.name  = "ramoops",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_NONE,
> +};
> +static int dyn_ramoops_size;
> +
> +#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
> +static int __init parse_dyn_ramoops_size(char *p)
> +{
> +	char *tmp;
> +
> +	dyn_ramoops_size = memparse(p, &tmp);
> +	if (p == tmp) {
> +		pr_err("ramoops: memory size expected\n");
> +		dyn_ramoops_size = 0;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
> +
> +/*
> + * setup_dynamic_ramoops() - reserves memory for dynamic ramoops
> + *
> + * This enable dynamic reserve memory support for ramoops through

           enables

> + * command line.
> + */


-- 
#Randy

