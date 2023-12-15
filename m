Return-Path: <linux-kernel+bounces-565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F038142FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660FE1C22099
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C9510963;
	Fri, 15 Dec 2023 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCZ+6v78"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE125107A5;
	Fri, 15 Dec 2023 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702626913; x=1734162913;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=E3dxP/JeHc7c4fIWBmlsAqRVqJ6RpEEE2GiOPJLY2mw=;
  b=SCZ+6v7832f/wCK3EDKY6kafK7xkHLO3K+HcbMZEXA/W2sbjK0qQ+/ov
   Qk8u+rS5l9k1AoUNAXUlF6zOfRqtUgxYwoJfvuTIZcUN4+gwoKaHQi0St
   pAzwDuyilh6tiefJuiTdiWS1Pu5AUp3HeYDAaXjoT7Zbk53aXI/E4r71d
   NMHshb0TPFsAqFLTkGx0gRiLevJNWmIrt4mpafzXX83De3f27Lt0n+vEC
   ZUjFhxiSpWUPoHBUT2Le5eMhtJbCjpA62+Qpn8QsCZa7YYTMvGuoz32kV
   kH3IeDpFbKQ2q7E9TflpMNcfg5IuJnCuYBwgCeAFrdqitgqwhtoetbhKL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461705868"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="461705868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:55:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="16200871"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:55:08 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Andrew Morton <akpm@linux-foundation.org>,  Oscar
 Salvador <osalvador@suse.de>,  <linux-kernel@vger.kernel.org>,
  <nvdimm@lists.linux.dev>,  <linux-cxl@vger.kernel.org>,  David
 Hildenbrand <david@redhat.com>,  "Dave Hansen"
 <dave.hansen@linux.intel.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  <linux-mm@kvack.org>,  "Li Zhijian"
 <lizhijian@fujitsu.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 4/4] dax: add a sysfs knob to control
 memmap_on_memory behavior
In-Reply-To: <20231214-vv-dax_abi-v6-4-ad900d698438@intel.com> (Vishal Verma's
	message of "Thu, 14 Dec 2023 22:25:29 -0700")
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
	<20231214-vv-dax_abi-v6-4-ad900d698438@intel.com>
Date: Fri, 15 Dec 2023 15:53:08 +0800
Message-ID: <871qbnrjff.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Vishal Verma <vishal.l.verma@intel.com> writes:

> Add a sysfs knob for dax devices to control the memmap_on_memory setting
> if the dax device were to be hotplugged as system memory.
>
> The default memmap_on_memory setting for dax devices originating via
> pmem or hmem is set to 'false' - i.e. no memmap_on_memory semantics, to
> preserve legacy behavior. For dax devices via CXL, the default is on.
> The sysfs control allows the administrator to override the above
> defaults if needed.
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  drivers/dax/bus.c                       | 36 +++++++++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-dax | 17 ++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 6226de131d17..3622b3d1c0de 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1245,6 +1245,41 @@ static ssize_t numa_node_show(struct device *dev,
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
> +	ssize_t rc;
> +	bool val;
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
> +	guard(device)(dev);
> +	if (dev_dax->memmap_on_memory != val && dev->driver &&
> +	    to_dax_drv(dev->driver)->type == DAXDRV_KMEM_TYPE)
> +		return -EBUSY;
> +	dev_dax->memmap_on_memory = val;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(memmap_on_memory);
> +
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -1271,6 +1306,7 @@ static struct attribute *dev_dax_attributes[] = {
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

