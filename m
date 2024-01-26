Return-Path: <linux-kernel+bounces-40686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CE83E41B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FA0285D52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C124B2D;
	Fri, 26 Jan 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PP3you0o"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70401DFF9;
	Fri, 26 Jan 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305235; cv=none; b=N8xTXvxWPRpIUY34fp0QfJu+XMOJcdvs9bw5j77+rO29MZkWIxMpGAEjDy7/b2cnV+VwHeUgVHAO45VtdxBszw6yuigD+ToePTveJfzDraDYuEuoERmUFrGC/Lq4ABz+6u8k/CeCznKlTUf17NpjUHOLuaq54fdKPz7cUODj0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305235; c=relaxed/simple;
	bh=y/MmXestLaco8MxcRu6FR5hsFEIdc9OmJHnVSWeZe2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEPVOk17giP3cYofe5/SCiL5LQpIHVkfaFat5HkypQCbMk4W+q5RKrQ5O3leE6NDyS/io7PW5k8j8XsvEiGYUmaud2IGC1d1qSawn4rLwKtktyJxtQMRZNkiNaiys1j59oUojPF+G7QvnkZQhZ3R6dGpjwylz9XoJk9NVhGkX+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PP3you0o; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706305229; x=1737841229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/MmXestLaco8MxcRu6FR5hsFEIdc9OmJHnVSWeZe2s=;
  b=PP3you0oz60xnc1W+WpMdRF2NR6nHbi82rXAgAzqwNcOSgBeeRNS8Aed
   o/RRMmJaByZ7mYlLnubB8GYRH0hpNrN5YgiJl9qqE3/ZGnvEKJatKUJyr
   xgvhwZinpP1b6baQDa2mm1bryonvPFFcbSaM+OEGAzKlyIrawnuQKLyEo
   BDVOX/rWlNo7JQdXXNPX6P1HpswLDXivbftmSLNwGYkeMqfPyC2QgfzOb
   CkaN1KWVkfJ9mys/35vcjHUcpJQHFnPqK0G7xWj1RhQhgMI4Py3Px4h0w
   8F3fADxA4XSfkR0+jRhQNKbvG1HjQWqfS3oVGqII+jXk9OULHWKEHqRlT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="466857919"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466857919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:40:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2787184"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.37.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:40:27 -0800
Date: Fri, 26 Jan 2024 13:40:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 5/5] dax: add a sysfs knob to control memmap_on_memory
 behavior
Message-ID: <ZbQmyanSjr+4Whp+@aschofie-mobl2>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
 <20240124-vv-dax_abi-v7-5-20d16cb8d23d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-vv-dax_abi-v7-5-20d16cb8d23d@intel.com>

On Wed, Jan 24, 2024 at 12:03:50PM -0800, Vishal Verma wrote:
> Add a sysfs knob for dax devices to control the memmap_on_memory setting
> if the dax device were to be hotplugged as system memory.
> 
> The default memmap_on_memory setting for dax devices originating via
> pmem or hmem is set to 'false' - i.e. no memmap_on_memory semantics, to
> preserve legacy behavior. For dax devices via CXL, the default is on.
> The sysfs control allows the administrator to override the above
> defaults if needed.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c                       | 43 +++++++++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-dax | 17 +++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 0fd948a4443e..27c86d0ca711 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1349,6 +1349,48 @@ static ssize_t numa_node_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t memmap_on_memory_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +
> +	return sysfs_emit(buf, "%d\n", dev_dax->memmap_on_memory);
> +}
> +
> +static ssize_t memmap_on_memory_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +	bool val;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (val == true && !mhp_supports_memmap_on_memory()) {
> +		dev_dbg(dev, "memmap_on_memory is not available\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	if (dev_dax->memmap_on_memory != val && dev->driver &&
> +	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE) {
> +		up_write(&dax_dev_rwsem);
> +		return -EBUSY;
> +	}
> +
> +	dev_dax->memmap_on_memory = val;
> +	up_write(&dax_dev_rwsem);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(memmap_on_memory);
> +
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -1375,6 +1417,7 @@ static struct attribute *dev_dax_attributes[] = {
>  	&dev_attr_align.attr,
>  	&dev_attr_resource.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_memmap_on_memory.attr,
>  	NULL,
>  };
>  
> diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
> index 6359f7bc9bf4..b34266bfae49 100644
> --- a/Documentation/ABI/testing/sysfs-bus-dax
> +++ b/Documentation/ABI/testing/sysfs-bus-dax
> @@ -134,3 +134,20 @@ KernelVersion:	v5.1
>  Contact:	nvdimm@lists.linux.dev
>  Description:
>  		(RO) The id attribute indicates the region id of a dax region.
> +
> +What:		/sys/bus/dax/devices/daxX.Y/memmap_on_memory
> +Date:		January, 2024
> +KernelVersion:	v6.8
> +Contact:	nvdimm@lists.linux.dev
> +Description:
> +		(RW) Control the memmap_on_memory setting if the dax device
> +		were to be hotplugged as system memory. This determines whether
> +		the 'altmap' for the hotplugged memory will be placed on the
> +		device being hotplugged (memmap_on_memory=1) or if it will be
> +		placed on regular memory (memmap_on_memory=0). This attribute
> +		must be set before the device is handed over to the 'kmem'
> +		driver (i.e.  hotplugged into system-ram). Additionally, this
> +		depends on CONFIG_MHP_MEMMAP_ON_MEMORY, and a globally enabled
> +		memmap_on_memory parameter for memory_hotplug. This is
> +		typically set on the kernel command line -
> +		memory_hotplug.memmap_on_memory set to 'true' or 'force'."
> 
> -- 
> 2.43.0
> 
> 

