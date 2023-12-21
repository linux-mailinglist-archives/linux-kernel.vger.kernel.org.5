Return-Path: <linux-kernel+bounces-8215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C771E81B3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5C31C25019
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB63697B1;
	Thu, 21 Dec 2023 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKi0VPQv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091F6979B;
	Thu, 21 Dec 2023 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703155085; x=1734691085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZVYgNpw/hI6h0hv9fqd/l40QyaXsV1WkF8iKTpDK1c=;
  b=SKi0VPQvMoRa6a0ejWujUg39+hF6mJyRdU334ONQWftkWgxAlg37cYI9
   62juK0VOXb+N21+RS2cyITAjB+QWBk2vaN3XWXgxNokY1H1NXtXZtHyR8
   1TS065CDphv7TJWTfPzw/ENjLHGIFp8gcwJ3bJUcBv5Wcy9lmnF5S+6Er
   RGBrhZ7FDno8pYFf9rkpGg8ANGgbN02FkGzV2XOxfaatbDbTVeLQdcnpH
   SxFwXLw4DjFSgouYI92nij1vENBioGe0YwcQBwily4500FMaj/j2/7WTi
   mTWa4i2xJDRse64SA7KQS36kdg9iyI3UTS8j+PqRKOs4TaYHTvHNORCeq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="17510024"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="17510024"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="780157751"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="780157751"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:37:43 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7F40111FAAC;
	Thu, 21 Dec 2023 12:37:40 +0200 (EET)
Date: Thu, 21 Dec 2023 10:37:40 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 20/22] device property: Modify fwnode irq_get() to use
 resource
Message-ID: <ZYQVdE4esAZbtMrn@kekkonen.localdomain>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.20.I38ac58ab04985a404ed6551eb5813fa7841ef410@changeid>

Hi Mark,

Thank you for the patch.

On Wed, Dec 20, 2023 at 04:54:34PM -0700, Mark Hasemeyer wrote:
> The underlying ACPI and OF subsystems provide their own APIs which
> provide IRQ information as a struct resource. This allows callers to get
> more information about the IRQ by looking at the resource flags.  For
> example, whether or not an IRQ is wake capable.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
> Changes in v2:
> -New patch
> 
>  drivers/acpi/property.c  | 11 +++++------
>  drivers/base/property.c  | 24 +++++++++++++++++++++---
>  drivers/of/property.c    |  8 ++++----
>  include/linux/fwnode.h   |  8 +++++---
>  include/linux/property.h |  2 ++
>  5 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a6ead5204046b..259869987ffff 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1627,17 +1627,16 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	return 0;
>  }
>  
> -static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
> -			       unsigned int index)
> +static int acpi_fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> +					unsigned int index, struct resource *r)
>  {
> -	struct resource res;
>  	int ret;
>  
> -	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, &res);
> +	ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), index, r);
>  	if (ret)
>  		return ret;
>  
> -	return res.start;
> +	return r->start;
>  }
>  
>  #define DECLARE_ACPI_FWNODE_OPS(ops) \
> @@ -1664,7 +1663,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
>  			acpi_graph_get_remote_endpoint,			\
>  		.graph_get_port_parent = acpi_fwnode_get_parent,	\
>  		.graph_parse_endpoint = acpi_fwnode_graph_parse_endpoint, \
> -		.irq_get = acpi_fwnode_irq_get,				\
> +		.irq_get_resource = acpi_fwnode_irq_get_resource,	\
>  	};								\
>  	EXPORT_SYMBOL_GPL(ops)
>  
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index a1b01ab420528..4f5d5ab5ab8cf 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1047,23 +1047,41 @@ void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
>  EXPORT_SYMBOL(fwnode_iomap);
>  
>  /**
> - * fwnode_irq_get - Get IRQ directly from a fwnode
> + * fwnode_irq_get_resource - Get IRQ directly from a fwnode and populate
> + *			     the resource struct
>   * @fwnode:	Pointer to the firmware node
>   * @index:	Zero-based index of the IRQ
> + * @r:		Pointer to resource to populate with IRQ information.
>   *
>   * Return: Linux IRQ number on success. Negative errno on failure.
>   */
> -int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> +			    unsigned int index, struct resource *r)
>  {
>  	int ret;
>  
> -	ret = fwnode_call_int_op(fwnode, irq_get, index);
> +	ret = fwnode_call_int_op(fwnode, irq_get_resource, index, r);
>  	/* We treat mapping errors as invalid case */
>  	if (ret == 0)
>  		return -EINVAL;
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(fwnode_irq_get_resource);

Both acpi_irq_get() and of_irq_to_resourece() use EXPORT_SYMBOL_GPL()
instead. I don't see why fwnode_irq_get_resource() shouldn't do the same.

With this changed,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

In fact this should have always been the case for fwnode_irq_get(). I
wouldn't mind changing that, too, in a separate patch.

> +
> +/**
> + * fwnode_irq_get - Get IRQ directly from a fwnode
> + * @fwnode:	Pointer to the firmware node
> + * @index:	Zero-based index of the IRQ
> + *
> + * Return: Linux IRQ number on success. Negative errno on failure.
> + */
> +int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
> +{
> +	struct resource r;
> +
> +	return fwnode_irq_get_resource(fwnode, index, &r);
> +}
>  EXPORT_SYMBOL(fwnode_irq_get);
>  
>  /**
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index afdaefbd03f61..864ea5fa5702b 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1425,10 +1425,10 @@ static void __iomem *of_fwnode_iomap(struct fwnode_handle *fwnode, int index)
>  #endif
>  }
>  
> -static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
> -			     unsigned int index)
> +static int of_fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> +				      unsigned int index, struct resource *r)
>  {
> -	return of_irq_get(to_of_node(fwnode), index);
> +	return of_irq_to_resource(to_of_node(fwnode), index, r);
>  }
>  
>  static int of_fwnode_add_links(struct fwnode_handle *fwnode)
> @@ -1469,7 +1469,7 @@ const struct fwnode_operations of_fwnode_ops = {
>  	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
>  	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
>  	.iomap = of_fwnode_iomap,
> -	.irq_get = of_fwnode_irq_get,
> +	.irq_get_resource = of_fwnode_irq_get_resource,
>  	.add_links = of_fwnode_add_links,
>  };
>  EXPORT_SYMBOL_GPL(of_fwnode_ops);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 2a72f55d26eb8..716ed863acde0 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -9,10 +9,11 @@
>  #ifndef _LINUX_FWNODE_H_
>  #define _LINUX_FWNODE_H_
>  
> -#include <linux/types.h>
> -#include <linux/list.h>
>  #include <linux/bits.h>
>  #include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <linux/list.h>
> +#include <linux/types.h>
>  
>  struct fwnode_operations;
>  struct device;
> @@ -164,7 +165,8 @@ struct fwnode_operations {
>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>  				    struct fwnode_endpoint *endpoint);
>  	void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
> -	int (*irq_get)(const struct fwnode_handle *fwnode, unsigned int index);
> +	int (*irq_get_resource)(const struct fwnode_handle *fwnode,
> +				unsigned int index, struct resource *r);
>  	int (*add_links)(struct fwnode_handle *fwnode);
>  };
>  
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e6516d0b7d52a..685ba72a8ce9e 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -190,6 +190,8 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>  
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> +int fwnode_irq_get_resource(const struct fwnode_handle *fwnode,
> +			    unsigned int index, struct resource *r);
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
>  
>  unsigned int device_get_child_node_count(const struct device *dev);

-- 
Kind regards,

Sakari Ailus

