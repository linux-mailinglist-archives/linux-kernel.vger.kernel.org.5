Return-Path: <linux-kernel+bounces-40656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208B083E3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DAED1C219AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5012249F5;
	Fri, 26 Jan 2024 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/sUUk/K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F31DFD8;
	Fri, 26 Jan 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303573; cv=none; b=O68hzifcG8gLWuuucVo5ZadHm03bKiJd3ABqRi55a2KzesCGKmDoLh5SFlchEnE8xDWacjG5JnM135btp7baPGEjZAbazMdFxdB/mp/bbwpT3idH4OJL1+blOdsTo6Qb7aljqHZgX6XtkTgF29o9vYcVvwPE3vDL/ZMcD1RNzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303573; c=relaxed/simple;
	bh=gYXycgNWRxeUp1sr7TriViT/K0cUe56I79wGz9gcseQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY2EfNc2vTLAZ8m8ss+YMQR2CbC+HmuDhb09ZrKobq/iABbZ/fFspH2DYG3/ZposvZ+RjnQOEWQZiEzcQ9zkrwBB53iBCmkFebGrxmpIHUH7ZhcU1X9HVg9/OxA55p2NBEKJnZsTWwrQHXFvqygkHN61qlrPbo74dZRkCIZ56Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/sUUk/K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706303562; x=1737839562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gYXycgNWRxeUp1sr7TriViT/K0cUe56I79wGz9gcseQ=;
  b=Y/sUUk/KJsjYaTSsa8mx0Ct5eQsmfL1j8xbNO3t3EiqW4NqFsnXrPNyn
   RSzHxiHwhIoRXw5aMt8QF+qvUjWfJ6lZU9cm5Hz/AgrSHYmdnTA1W1B94
   RDiFyCcVjE/U5gA62aoNrS8K+xp3LDbHgUoM77ufX11nskdS+0mr98D2G
   9A6/1rCywbz+FsWpmBuKZlfxuviJgKaPlaZFSa4F38VebWtDGiJcW98v7
   0zzyHWaB50T+bnShn3Jzsumr8XIzMLfZmebooD5YcfGSspghAVSSbCEhh
   dTMfyz+J25p1CUURYhRpY6XIp7J1DB4h71f3qOpk2VMCehzsnwVgeLh7W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9234212"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9234212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:12:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2698510"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.37.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:12:40 -0800
Date: Fri, 26 Jan 2024 13:12:38 -0800
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
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v7 1/5] dax/bus.c: replace driver-core lock usage by a
 local rwsem
Message-ID: <ZbQgRrQOmOPE8FHy@aschofie-mobl2>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
 <20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>

On Wed, Jan 24, 2024 at 12:03:46PM -0800, Vishal Verma wrote:
> The dax driver incorrectly used driver-core device locks to protect
> internal dax region and dax device configuration structures. Replace the
> device lock usage with a local rwsem, one each for dax region
> configuration and dax device configuration. As a result of this
> conversion, no device_lock() usage remains in dax/bus.c.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.c | 220 ++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 157 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 1ff1ab5fa105..cb148f74ceda 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -12,6 +12,18 @@
>  
>  static DEFINE_MUTEX(dax_bus_lock);
>  
> +/*
> + * All changes to the dax region configuration occur with this lock held
> + * for write.
> + */
> +DECLARE_RWSEM(dax_region_rwsem);
> +
> +/*
> + * All changes to the dax device configuration occur with this lock held
> + * for write.
> + */
> +DECLARE_RWSEM(dax_dev_rwsem);
> +
>  #define DAX_NAME_LEN 30
>  struct dax_id {
>  	struct list_head list;
> @@ -180,7 +192,7 @@ static u64 dev_dax_size(struct dev_dax *dev_dax)
>  	u64 size = 0;
>  	int i;
>  
> -	device_lock_assert(&dev_dax->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_dev_rwsem));
>  
>  	for (i = 0; i < dev_dax->nr_range; i++)
>  		size += range_len(&dev_dax->ranges[i].range);
> @@ -194,8 +206,15 @@ static int dax_bus_probe(struct device *dev)
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  	struct dax_region *dax_region = dev_dax->region;
>  	int rc;
> +	u64 size;
>  
> -	if (dev_dax_size(dev_dax) == 0 || dev_dax->id < 0)
> +	rc = down_read_interruptible(&dax_dev_rwsem);
> +	if (rc)
> +		return rc;
> +	size = dev_dax_size(dev_dax);
> +	up_read(&dax_dev_rwsem);
> +
> +	if (size == 0 || dev_dax->id < 0)
>  		return -ENXIO;
>  
>  	rc = dax_drv->probe(dev_dax);
> @@ -283,7 +302,7 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>  	resource_size_t size = resource_size(&dax_region->res);
>  	struct resource *res;
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
>  	for_each_dax_region_resource(dax_region, res)
>  		size -= resource_size(res);
> @@ -295,10 +314,13 @@ static ssize_t available_size_show(struct device *dev,
>  {
>  	struct dax_region *dax_region = dev_get_drvdata(dev);
>  	unsigned long long size;
> +	int rc;
>  
> -	device_lock(dev);
> +	rc = down_read_interruptible(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	size = dax_region_avail_size(dax_region);
> -	device_unlock(dev);
> +	up_read(&dax_region_rwsem);
>  
>  	return sprintf(buf, "%llu\n", size);
>  }
> @@ -314,10 +336,12 @@ static ssize_t seed_show(struct device *dev,
>  	if (is_static(dax_region))
>  		return -EINVAL;
>  
> -	device_lock(dev);
> +	rc = down_read_interruptible(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	seed = dax_region->seed;
>  	rc = sprintf(buf, "%s\n", seed ? dev_name(seed) : "");
> -	device_unlock(dev);
> +	up_read(&dax_region_rwsem);
>  
>  	return rc;
>  }
> @@ -333,14 +357,18 @@ static ssize_t create_show(struct device *dev,
>  	if (is_static(dax_region))
>  		return -EINVAL;
>  
> -	device_lock(dev);
> +	rc = down_read_interruptible(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	youngest = dax_region->youngest;
>  	rc = sprintf(buf, "%s\n", youngest ? dev_name(youngest) : "");
> -	device_unlock(dev);
> +	up_read(&dax_region_rwsem);
>  
>  	return rc;
>  }
>  
> +static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data);
> +
>  static ssize_t create_store(struct device *dev, struct device_attribute *attr,
>  		const char *buf, size_t len)
>  {
> @@ -358,7 +386,9 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
>  	if (val != 1)
>  		return -EINVAL;
>  
> -	device_lock(dev);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	avail = dax_region_avail_size(dax_region);
>  	if (avail == 0)
>  		rc = -ENOSPC;
> @@ -369,7 +399,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
>  			.id = -1,
>  			.memmap_on_memory = false,
>  		};
> -		struct dev_dax *dev_dax = devm_create_dev_dax(&data);
> +		struct dev_dax *dev_dax = __devm_create_dev_dax(&data);
>  
>  		if (IS_ERR(dev_dax))
>  			rc = PTR_ERR(dev_dax);
> @@ -387,7 +417,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
>  			rc = len;
>  		}
>  	}
> -	device_unlock(dev);
> +	up_write(&dax_region_rwsem);
>  
>  	return rc;
>  }
> @@ -417,7 +447,7 @@ static void trim_dev_dax_range(struct dev_dax *dev_dax)
>  	struct range *range = &dev_dax->ranges[i].range;
>  	struct dax_region *dax_region = dev_dax->region;
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
>  		(unsigned long long)range->start,
>  		(unsigned long long)range->end);
> @@ -435,7 +465,7 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
>  		trim_dev_dax_range(dev_dax);
>  }
>  
> -static void unregister_dev_dax(void *dev)
> +static void __unregister_dev_dax(void *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
> @@ -447,6 +477,17 @@ static void unregister_dev_dax(void *dev)
>  	put_device(dev);
>  }
>  
> +static void unregister_dev_dax(void *dev)
> +{
> +	if (rwsem_is_locked(&dax_region_rwsem))
> +		return __unregister_dev_dax(dev);
> +
> +	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
> +		return;
> +	__unregister_dev_dax(dev);
> +	up_write(&dax_region_rwsem);
> +}
> +
>  static void dax_region_free(struct kref *kref)
>  {
>  	struct dax_region *dax_region;
> @@ -463,11 +504,10 @@ static void dax_region_put(struct dax_region *dax_region)
>  /* a return value >= 0 indicates this invocation invalidated the id */
>  static int __free_dev_dax_id(struct dev_dax *dev_dax)
>  {
> -	struct device *dev = &dev_dax->dev;
>  	struct dax_region *dax_region;
>  	int rc = dev_dax->id;
>  
> -	device_lock_assert(dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_dev_rwsem));
>  
>  	if (!dev_dax->dyn_id || dev_dax->id < 0)
>  		return -1;
> @@ -480,12 +520,13 @@ static int __free_dev_dax_id(struct dev_dax *dev_dax)
>  
>  static int free_dev_dax_id(struct dev_dax *dev_dax)
>  {
> -	struct device *dev = &dev_dax->dev;
>  	int rc;
>  
> -	device_lock(dev);
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc)
> +		return rc;
>  	rc = __free_dev_dax_id(dev_dax);
> -	device_unlock(dev);
> +	up_write(&dax_dev_rwsem);
>  	return rc;
>  }
>  
> @@ -519,8 +560,14 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
>  	if (!victim)
>  		return -ENXIO;
>  
> -	device_lock(dev);
> -	device_lock(victim);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc) {
> +		up_write(&dax_region_rwsem);
> +		return rc;
> +	}
>  	dev_dax = to_dev_dax(victim);
>  	if (victim->driver || dev_dax_size(dev_dax))
>  		rc = -EBUSY;
> @@ -541,12 +588,12 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
>  		} else
>  			rc = -EBUSY;
>  	}
> -	device_unlock(victim);
> +	up_write(&dax_dev_rwsem);
>  
>  	/* won the race to invalidate the device, clean it up */
>  	if (do_del)
>  		devm_release_action(dev, unregister_dev_dax, victim);
> -	device_unlock(dev);
> +	up_write(&dax_region_rwsem);
>  	put_device(victim);
>  
>  	return rc;
> @@ -658,16 +705,15 @@ static void dax_mapping_release(struct device *dev)
>  	put_device(parent);
>  }
>  
> -static void unregister_dax_mapping(void *data)
> +static void __unregister_dax_mapping(void *data)
>  {
>  	struct device *dev = data;
>  	struct dax_mapping *mapping = to_dax_mapping(dev);
>  	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> -	struct dax_region *dax_region = dev_dax->region;
>  
>  	dev_dbg(dev, "%s\n", __func__);
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
>  	dev_dax->ranges[mapping->range_id].mapping = NULL;
>  	mapping->range_id = -1;
> @@ -675,28 +721,37 @@ static void unregister_dax_mapping(void *data)
>  	device_unregister(dev);
>  }
>  
> +static void unregister_dax_mapping(void *data)
> +{
> +	if (rwsem_is_locked(&dax_region_rwsem))
> +		return __unregister_dax_mapping(data);
> +
> +	if (WARN_ON_ONCE(down_write_killable(&dax_region_rwsem) != 0))
> +		return;
> +	__unregister_dax_mapping(data);
> +	up_write(&dax_region_rwsem);
> +}
> +
>  static struct dev_dax_range *get_dax_range(struct device *dev)
>  {
>  	struct dax_mapping *mapping = to_dax_mapping(dev);
>  	struct dev_dax *dev_dax = to_dev_dax(dev->parent);
> -	struct dax_region *dax_region = dev_dax->region;
> +	int rc;
>  
> -	device_lock(dax_region->dev);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return NULL;
>  	if (mapping->range_id < 0) {
> -		device_unlock(dax_region->dev);
> +		up_write(&dax_region_rwsem);
>  		return NULL;
>  	}
>  
>  	return &dev_dax->ranges[mapping->range_id];
>  }
>  
> -static void put_dax_range(struct dev_dax_range *dax_range)
> +static void put_dax_range(void)
>  {
> -	struct dax_mapping *mapping = dax_range->mapping;
> -	struct dev_dax *dev_dax = to_dev_dax(mapping->dev.parent);
> -	struct dax_region *dax_region = dev_dax->region;
> -
> -	device_unlock(dax_region->dev);
> +	up_write(&dax_region_rwsem);
>  }
>  
>  static ssize_t start_show(struct device *dev,
> @@ -709,7 +764,7 @@ static ssize_t start_show(struct device *dev,
>  	if (!dax_range)
>  		return -ENXIO;
>  	rc = sprintf(buf, "%#llx\n", dax_range->range.start);
> -	put_dax_range(dax_range);
> +	put_dax_range();
>  
>  	return rc;
>  }
> @@ -725,7 +780,7 @@ static ssize_t end_show(struct device *dev,
>  	if (!dax_range)
>  		return -ENXIO;
>  	rc = sprintf(buf, "%#llx\n", dax_range->range.end);
> -	put_dax_range(dax_range);
> +	put_dax_range();
>  
>  	return rc;
>  }
> @@ -741,7 +796,7 @@ static ssize_t pgoff_show(struct device *dev,
>  	if (!dax_range)
>  		return -ENXIO;
>  	rc = sprintf(buf, "%#lx\n", dax_range->pgoff);
> -	put_dax_range(dax_range);
> +	put_dax_range();
>  
>  	return rc;
>  }
> @@ -775,7 +830,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>  	struct device *dev;
>  	int rc;
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
>  	if (dev_WARN_ONCE(&dev_dax->dev, !dax_region->dev->driver,
>  				"region disabled\n"))
> @@ -821,7 +876,7 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  	struct resource *alloc;
>  	int i, rc;
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
>  	/* handle the seed alloc special case */
>  	if (!size) {
> @@ -875,13 +930,12 @@ static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, r
>  {
>  	int last_range = dev_dax->nr_range - 1;
>  	struct dev_dax_range *dax_range = &dev_dax->ranges[last_range];
> -	struct dax_region *dax_region = dev_dax->region;
>  	bool is_shrink = resource_size(res) > size;
>  	struct range *range = &dax_range->range;
>  	struct device *dev = &dev_dax->dev;
>  	int rc;
>  
> -	device_lock_assert(dax_region->dev);
> +	WARN_ON_ONCE(!rwsem_is_locked(&dax_region_rwsem));
>  
>  	if (dev_WARN_ONCE(dev, !size, "deletion is handled by dev_dax_shrink\n"))
>  		return -EINVAL;
> @@ -907,10 +961,13 @@ static ssize_t size_show(struct device *dev,
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  	unsigned long long size;
> +	int rc;
>  
> -	device_lock(dev);
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc)
> +		return rc;
>  	size = dev_dax_size(dev_dax);
> -	device_unlock(dev);
> +	up_write(&dax_dev_rwsem);
>  
>  	return sprintf(buf, "%llu\n", size);
>  }
> @@ -1080,17 +1137,27 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	device_lock(dax_region->dev);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	if (!dax_region->dev->driver) {
> -		device_unlock(dax_region->dev);
> -		return -ENXIO;
> +		rc = -ENXIO;
> +		goto err_region;
>  	}
> -	device_lock(dev);
> -	rc = dev_dax_resize(dax_region, dev_dax, val);
> -	device_unlock(dev);
> -	device_unlock(dax_region->dev);
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc)
> +		goto err_dev;
>  
> -	return rc == 0 ? len : rc;
> +	rc = dev_dax_resize(dax_region, dev_dax, val);
> +
> +err_dev:
> +	up_write(&dax_dev_rwsem);
> +err_region:
> +	up_write(&dax_region_rwsem);
> +
> +	if (rc == 0)
> +		return len;
> +	return rc;
>  }
>  static DEVICE_ATTR_RW(size);
>  
> @@ -1138,18 +1205,24 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  		return rc;
>  
>  	rc = -ENXIO;
> -	device_lock(dax_region->dev);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	if (!dax_region->dev->driver) {
> -		device_unlock(dax_region->dev);
> +		up_write(&dax_region_rwsem);
> +		return rc;
> +	}
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc) {
> +		up_write(&dax_region_rwsem);
>  		return rc;
>  	}
> -	device_lock(dev);
>  
>  	to_alloc = range_len(&r);
>  	if (alloc_is_aligned(dev_dax, to_alloc))
>  		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
> -	device_unlock(dev);
> -	device_unlock(dax_region->dev);
> +	up_write(&dax_dev_rwsem);
> +	up_write(&dax_region_rwsem);
>  
>  	return rc == 0 ? len : rc;
>  }
> @@ -1196,13 +1269,19 @@ static ssize_t align_store(struct device *dev, struct device_attribute *attr,
>  	if (!dax_align_valid(val))
>  		return -EINVAL;
>  
> -	device_lock(dax_region->dev);
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return rc;
>  	if (!dax_region->dev->driver) {
> -		device_unlock(dax_region->dev);
> +		up_write(&dax_region_rwsem);
>  		return -ENXIO;
>  	}
>  
> -	device_lock(dev);
> +	rc = down_write_killable(&dax_dev_rwsem);
> +	if (rc) {
> +		up_write(&dax_region_rwsem);
> +		return rc;
> +	}
>  	if (dev->driver) {
>  		rc = -EBUSY;
>  		goto out_unlock;
> @@ -1214,8 +1293,8 @@ static ssize_t align_store(struct device *dev, struct device_attribute *attr,
>  	if (rc)
>  		dev_dax->align = align_save;
>  out_unlock:
> -	device_unlock(dev);
> -	device_unlock(dax_region->dev);
> +	up_write(&dax_dev_rwsem);
> +	up_write(&dax_region_rwsem);
>  	return rc == 0 ? len : rc;
>  }
>  static DEVICE_ATTR_RW(align);
> @@ -1325,7 +1404,7 @@ static const struct device_type dev_dax_type = {
>  	.groups = dax_attribute_groups,
>  };
>  
> -struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> +static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  {
>  	struct dax_region *dax_region = data->dax_region;
>  	struct device *parent = dax_region->dev;
> @@ -1440,6 +1519,21 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  
>  	return ERR_PTR(rc);
>  }
> +
> +struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> +{
> +	struct dev_dax *dev_dax;
> +	int rc;
> +
> +	rc = down_write_killable(&dax_region_rwsem);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	dev_dax = __devm_create_dev_dax(data);
> +	up_write(&dax_region_rwsem);
> +
> +	return dev_dax;
> +}
>  EXPORT_SYMBOL_GPL(devm_create_dev_dax);
>  
>  int __dax_driver_register(struct dax_device_driver *dax_drv,
> 
> -- 
> 2.43.0
> 
> 

