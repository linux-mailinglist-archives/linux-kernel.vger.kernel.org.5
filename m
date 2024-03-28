Return-Path: <linux-kernel+bounces-107371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701A87FB97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3DD1C21CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18F7E566;
	Tue, 19 Mar 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev6ds6iJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673127E11C;
	Tue, 19 Mar 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843201; cv=none; b=hp2wPX2GBYCmFE66vkE8QMduf0dB8DmsGMuNxQW/AU2oQvDTxjDj1Mqpt6ImvLUWqecLt8q9+LYQO7/ZoZoZs2DCcOC3c3QBIYDw5nC7SVGtcrEE1Ed+7drpew2AfiQIyaxzgHM7tclZ/WCyNMyXNV6mwj0FxN73FEqk2X+47mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843201; c=relaxed/simple;
	bh=BSDyx7UrY3zAu0w9hzb8OyBEyWnjHi1Vwg9Xoa9pZ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqewbXi9dQSx8kOHeRlrspI6YR3TKnyFm1AOwukXoCcpgA2IJSZys1SX2zuHpz/hZLDfh01s757R2cWjAWrQA16RxHpH3kV7ZxBucIyjAUFDKFs7fMP3nc0jQ6i19M9ua6PrvsWwLTi2vkzgrzgQK7ND/yfrumAZYEqeOOI4hBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev6ds6iJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710843198; x=1742379198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BSDyx7UrY3zAu0w9hzb8OyBEyWnjHi1Vwg9Xoa9pZ/E=;
  b=Ev6ds6iJj8/4qgt/s6fufPO2wqgDmkM0du8W0C+gtUbuL1rh5RGgWF7h
   3aTn/qwYjz+WJ0CvF6lfAV2RnbmtMwioZLLN/hCFugsPgtri3KcNtWg5l
   OiBzUzp+j2+srb9DXDTDrxlKEOkwlKnLSERRCF/xQU5C+bqkVK1oTco34
   hyMVyf+oVtNBI8I49TFsMmQj7pIWGOfTOhXDekxKVByZmV9BvEf/sdj2V
   /j9oj1dlBIkdzHC0P075I9z+2BCs0SuQxh6qJvdss/XjYzKl3INqB9Q6l
   5/oYcUiSM/8B+9K9vgqfI/UzYl61PybkHkzIfGP5odVgUIdJquGjm4LLM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16343142"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="16343142"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 03:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13747801"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 19 Mar 2024 03:13:14 -0700
Date: Tue, 19 Mar 2024 18:08:43 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tim Whisonant <tim.whisonant@intel.com>,
	Ananda Ravuri <ananda.ravuri@intel.com>
Subject: Re: [PATCH] fpga: add DFL driver for CXL Cache IP block
Message-ID: <ZflkK/VZO0wqiAhz@yilunxu-OptiPlex-7050>
References: <20240308172327.1970160-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308172327.1970160-1-matthew.gerlach@linux.intel.com>

On Fri, Mar 08, 2024 at 09:23:27AM -0800, Matthew Gerlach wrote:
> From: Tim Whisonant <tim.whisonant@intel.com>
> 
> Add a Device Feature List (DFL) driver for the
> Intel CXL Cache IP block. The driver
> provides a means of accessing the device MMIO and the

Why the device MMIO should be accessed by userspace?

> capability to pin buffers and program their physical
> addresses into the HE-Cache registers. User interface

Are these registers also exposed to userspace?

And this patch to support a new device/IP, please firstly describe
what the device/IP is doing.  I think not everyone(including me) here
is familar with CXL standard and how this IP block is implementing CXL
functionality.  Some reference documentation is also helpful.

After a quick skim of this patch, I can see user is trying to write a
set of physical addrs to some register, but have no idea why this
should be done. i.e. Do not reiterate what the code literally does.

> is exposed via /dev/dfl-cxl-cache.X as described in
> include/uapi/linux/fpga-dfl.h.

And please split the patch, e.g. first add a skeleton of bus driver,
then add the skeleton of char interface, then add the functionalities
one by one.  This gives chances to clearly describe each function, and
why add it, etc.

But first of all, lets get to know the IP block.

Thanks,
Yilun

> 
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Co-developed-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/Kconfig          |  11 +
>  drivers/fpga/Makefile         |   1 +
>  drivers/fpga/dfl-cxl-cache.c  | 645 ++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fpga-dfl.h |  98 ++++++
>  4 files changed, 755 insertions(+)
>  create mode 100644 drivers/fpga/dfl-cxl-cache.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 2f689ac4ba3a..00931a3deebf 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -257,6 +257,17 @@ config FPGA_M10_BMC_SEC_UPDATE
>  	  (BMC) and provides support for secure updates for the BMC image,
>  	  the FPGA image, the Root Entry Hashes, etc.
>  
> +config FPGA_DFL_CXL_CACHE
> +	tristate "Intel CXL cache driver"
> +	depends on DRM && FPGA_DFL
> +	help
> +	  This is the driver for CXL cache Accelerated Function Unit
> +	  (AFU) which configures the IP and provides DMA buffer management
> +	  to user space.
> +
> +	  To compile this driver as a module, chose M here: the
> +	  module will be called dfl_cxl_cache.
> +
>  config FPGA_MGR_MICROCHIP_SPI
>  	tristate "Microchip Polarfire SPI FPGA manager"
>  	depends on SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 352a2612623e..970902810845 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +obj-$(CONFIG_FPGA_DFL_CXL_CACHE)	+= dfl-cxl-cache.o
>  
>  # KUnit tests
>  obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
> diff --git a/drivers/fpga/dfl-cxl-cache.c b/drivers/fpga/dfl-cxl-cache.c
> new file mode 100644
> index 000000000000..ee2ae04ac058
> --- /dev/null
> +++ b/drivers/fpga/dfl-cxl-cache.c
> @@ -0,0 +1,645 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DFL device driver for Host Exerciser Cache private feature.
> + *
> + * Provides a means of accessing the device MMIO and the
> + * capability to pin buffers and program their physical
> + * addresses into the HE-Cache registers. User interface
> + * is exposed via /dev/dfl-cxl-cache.X as described in
> + * include/uapi/linux/fpga-dfl.h.
> + *
> + * Copyright (C) 2023 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cdev.h>
> +#include <linux/cleanup.h>
> +#include <linux/container_of.h>
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/fpga-dfl.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/mmap_lock.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pgtable.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <drm/drm_cache.h>
> +
> +#define DFL_CXL_CACHE_DRIVER_NAME	"dfl-cxl-cache"
> +#define FME_FEATURE_ID_CXL_CACHE	0x25
> +
> +struct dfl_cxl_cache_buffer_region {
> +	struct rb_node node;
> +	u32 flags;
> +	u64 user_addr;
> +	u64 length;
> +	struct page **pages;
> +	phys_addr_t phys;
> +	u64 offset[DFL_ARRAY_MAX_SIZE];
> +};
> +
> +struct dfl_cxl_cache {
> +	struct cdev cdev;
> +	struct dfl_device *ddev;
> +	int id;
> +	struct device *dev;
> +	atomic_t opened;
> +	void __iomem *mmio_base;
> +	int mmio_size;
> +	struct dfl_cxl_cache_region_info rinfo;
> +	struct rb_root dma_regions;
> +};
> +
> +static DEFINE_MUTEX(dfl_cxl_cache_class_lock);
> +static struct class *dfl_cxl_cache_class;
> +static dev_t dfl_cxl_cache_devt;
> +static int dfl_cxl_cache_devices;
> +
> +static int dfl_cxl_cache_open(struct inode *inode, struct file *filp)
> +{
> +	struct dfl_cxl_cache *cxl_cache = container_of(inode->i_cdev, struct dfl_cxl_cache, cdev);
> +
> +	if (atomic_cmpxchg(&cxl_cache->opened, 0, 1))
> +		return -EBUSY;
> +
> +	filp->private_data = cxl_cache;
> +
> +	return 0;
> +}
> +
> +static long cxl_cache_ioctl_check_extension(struct dfl_cxl_cache *cxl_cache, unsigned long arg)
> +{
> +	/* No extension support for now */
> +	return 0;
> +}
> +
> +static long cxl_cache_ioctl_get_region_info(struct dfl_cxl_cache *cxl_cache, void __user *arg)
> +{
> +	struct dfl_cxl_cache_region_info rinfo;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct dfl_cxl_cache_region_info, offset);
> +	if (copy_from_user(&rinfo, arg, minsz))
> +		return -EFAULT;
> +
> +	if (rinfo.argsz < minsz)
> +		return -EINVAL;
> +
> +	rinfo.flags = cxl_cache->rinfo.flags;
> +	rinfo.size = cxl_cache->rinfo.size;
> +	rinfo.offset = cxl_cache->rinfo.offset;
> +
> +	if (copy_to_user(arg, &rinfo, sizeof(rinfo)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static void cxl_cache_unpin_pages(struct device *dev, struct page ***pages, unsigned long length)
> +{
> +	const long npages = PFN_DOWN(length);
> +
> +	if (!*pages)
> +		return;
> +
> +	unpin_user_pages(*pages, npages);
> +	kfree(*pages);
> +	*pages = NULL;
> +	account_locked_vm(current->mm, npages, false);
> +}
> +
> +static bool cxl_cache_check_continuous_pages(struct page **pages, unsigned long length)
> +{
> +	int i;
> +	const int npages = PFN_DOWN(length);
> +
> +	for (i = 0; i < npages - 1; i++)
> +		if (page_to_pfn(pages[i]) + 1 != page_to_pfn(pages[i + 1]))
> +			return false;
> +
> +	return true;
> +}
> +
> +static int cxl_cache_dma_pin_pages(struct dfl_cxl_cache *cxl_cache,
> +				   struct dfl_cxl_cache_buffer_region *region)
> +{
> +	int ret, pinned;
> +	unsigned int flags = FOLL_LONGTERM;
> +	const int npages = PFN_DOWN(region->length);
> +
> +	ret = account_locked_vm(current->mm, npages, true);
> +	if (ret) {
> +		dev_err(cxl_cache->dev, "account_locked_vm() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	region->pages = kcalloc(npages, sizeof(struct page *), GFP_KERNEL);
> +	if (!region->pages) {
> +		ret = -ENOMEM;
> +		goto unlock_vm;
> +	}
> +
> +	if (region->flags & DFL_CXL_BUFFER_MAP_WRITABLE)
> +		flags |= FOLL_WRITE;
> +
> +	pinned = pin_user_pages_fast(region->user_addr, npages, flags, region->pages);
> +	if (pinned == npages)
> +		return 0;
> +
> +	ret = -EFAULT;
> +	if (pinned > 0)
> +		unpin_user_pages(region->pages, pinned);
> +
> +	kfree(region->pages);
> +unlock_vm:
> +	account_locked_vm(current->mm, npages, false);
> +	return ret;
> +}
> +
> +static void cxl_cache_dma_region_remove(struct dfl_cxl_cache *cxl_cache,
> +					struct dfl_cxl_cache_buffer_region *region)
> +{
> +	rb_erase(&region->node, &cxl_cache->dma_regions);
> +}
> +
> +static bool dma_region_check_user_addr(struct dfl_cxl_cache_buffer_region *region, u64 user_addr,
> +				       u64 size)
> +{
> +	if (!size && region->user_addr != user_addr)
> +		return false;
> +
> +	return (region->user_addr <= user_addr) &&
> +		(region->length + region->user_addr >= user_addr + size);
> +}
> +
> +static struct dfl_cxl_cache_buffer_region*
> +cxl_cache_dma_region_find(struct dfl_cxl_cache *cxl_cache, u64 user_addr, u64 size)
> +{
> +	struct rb_node *node = cxl_cache->dma_regions.rb_node;
> +
> +	while (node) {
> +		struct dfl_cxl_cache_buffer_region *region;
> +
> +		region = container_of(node, struct dfl_cxl_cache_buffer_region, node);
> +
> +		if (dma_region_check_user_addr(region, user_addr, size))
> +			return region;
> +
> +		if (user_addr < region->user_addr)
> +			node = node->rb_left;
> +		else if (user_addr > region->user_addr)
> +			node = node->rb_right;
> +		else
> +			break;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int cxl_cache_dma_region_add(struct dfl_cxl_cache *cxl_cache,
> +				    struct dfl_cxl_cache_buffer_region *region)
> +{
> +	struct rb_node **new, *parent = NULL;
> +
> +	new = &cxl_cache->dma_regions.rb_node;
> +
> +	while (*new) {
> +		struct dfl_cxl_cache_buffer_region *this;
> +
> +		this = container_of(*new, struct dfl_cxl_cache_buffer_region, node);
> +		parent = *new;
> +
> +		if (dma_region_check_user_addr(this, region->user_addr, region->length))
> +			return -EEXIST;
> +
> +		if (region->user_addr < this->user_addr)
> +			new = &((*new)->rb_left);
> +		else if (region->user_addr > this->user_addr)
> +			new = &((*new)->rb_right);
> +		else
> +			return -EEXIST;
> +	}
> +
> +	rb_link_node(&region->node, parent, new);
> +	rb_insert_color(&region->node, &cxl_cache->dma_regions);
> +
> +	return 0;
> +}
> +
> +static void fixup_ptes(struct mm_struct *mm, unsigned long start, unsigned long end)
> +{
> +	unsigned long addr;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE) {
> +		pgd = pgd_offset(mm, addr);
> +		if (pgd_bad(*pgd) || pgd_none(*pgd))
> +			continue;
> +
> +		p4d = p4d_offset(pgd, addr);
> +		if (p4d_bad(*p4d) || p4d_none(*p4d))
> +			continue;
> +
> +		pud = pud_offset(p4d, addr);
> +		if (pud_bad(*pud) || pud_none(*pud))
> +			continue;
> +
> +		pmd = pmd_offset(pud, addr);
> +		if (pmd_bad(*pmd) || pmd_none(*pmd))
> +			continue;
> +
> +		pte = pte_offset_kernel(pmd, addr);
> +		if (!pte_none(*pte) && pte_present(*pte))
> +			*pte = pte_wrprotect(*pte);
> +	}
> +}
> +
> +static long cxl_cache_set_region_read_only(struct dfl_cxl_cache *cxl_cache,
> +					   struct dfl_cxl_cache_buffer_region *region)
> +{
> +	struct vm_area_struct *vma;
> +	long ret = 0;
> +
> +	vma = vma_lookup(current->mm, region->user_addr);
> +	if (IS_ERR(vma)) {
> +		ret = PTR_ERR(vma);
> +		dev_err(cxl_cache->dev, "vma_lookup() failed: %ld\n", ret);
> +		return ret;
> +	}
> +
> +	mmap_write_lock(current->mm);
> +
> +	/* Mark the pages as non-cached and write-protected. */
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vm_flags_clear(vma, VM_WRITE);
> +
> +	fixup_ptes(current->mm, vma->vm_start, vma->vm_end);
> +
> +	mmap_write_unlock(current->mm);
> +
> +	/* Flush all remaining cache entries. */
> +	drm_clflush_virt_range(page_address(region->pages[0]), region->length);
> +
> +	return ret;
> +}
> +
> +static long cxl_cache_ioctl_numa_buffer_map(struct dfl_cxl_cache *cxl_cache, void __user *arg)
> +{
> +	int i = 0;
> +	unsigned long minsz = 0;
> +	long ret = 0;
> +	struct dfl_cxl_cache_buffer_map dma_map;
> +	struct dfl_cxl_cache_buffer_region *region;
> +
> +	minsz = offsetofend(struct dfl_cxl_cache_buffer_map, csr_array);
> +	if (copy_from_user(&dma_map, arg, minsz)) {
> +		dev_err(cxl_cache->dev, "fails to copy from user space buffer\n");
> +		return -EFAULT;
> +	}
> +	if (dma_map.argsz < minsz) {
> +		dev_err(cxl_cache->dev, "invalid ioctl buffer size\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check Inputs, only accept page-aligned user memory region with valid length */
> +	if (!PAGE_ALIGNED(dma_map.user_addr) || !PAGE_ALIGNED(dma_map.length) ||
> +	    !(dma_map.length)) {
> +		dev_err(cxl_cache->dev, "length is not page-aligned or the length is zero\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Check overflow */
> +	if (dma_map.user_addr + dma_map.length < dma_map.user_addr) {
> +		dev_err(cxl_cache->dev, "dma buffer check overflow\n");
> +		return -EINVAL;
> +	}
> +
> +	region = kzalloc(sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	region->flags = dma_map.flags;
> +	region->user_addr = dma_map.user_addr;
> +	region->length = dma_map.length;
> +
> +	/* Pin the user memory region */
> +	ret = cxl_cache_dma_pin_pages(cxl_cache, region);
> +	if (ret) {
> +		dev_err(cxl_cache->dev, "failed to pin pages\n");
> +		goto free_region;
> +	}
> +
> +	/* Only accept continuous pages, return error else */
> +	if (!cxl_cache_check_continuous_pages(region->pages, region->length)) {
> +		dev_err(cxl_cache->dev, "pages are not continuous\n");
> +		ret = -EINVAL;
> +		goto out_unpin_pages;
> +	}
> +
> +	if (!(region->flags & DFL_CXL_BUFFER_MAP_WRITABLE)) {
> +		ret = cxl_cache_set_region_read_only(cxl_cache, region);
> +		if (ret)
> +			goto out_unpin_pages;
> +	}
> +
> +	ret = cxl_cache_dma_region_add(cxl_cache, region);
> +	if (ret) {
> +		dev_err(cxl_cache->dev, "failed to add dma region\n");
> +		goto out_unpin_pages;
> +	}
> +
> +	region->phys = page_to_phys(region->pages[0]);
> +
> +	for (i = 0; i < DFL_ARRAY_MAX_SIZE; i++) {
> +		if (dma_map.csr_array[i] && dma_map.csr_array[i] < cxl_cache->rinfo.size)
> +			writeq(region->phys, cxl_cache->mmio_base + dma_map.csr_array[i]);
> +	}
> +
> +	return 0;
> +
> +out_unpin_pages:
> +	cxl_cache_unpin_pages(cxl_cache->dev, &region->pages, region->length);
> +free_region:
> +	kfree(region);
> +	return ret;
> +}
> +
> +static long cxl_cache_ioctl_numa_buffer_unmap(struct dfl_cxl_cache *cxl_cache, void __user *arg)
> +{
> +	unsigned long minsz = 0;
> +	long ret = 0;
> +	int i = 0;
> +	struct dfl_cxl_cache_buffer_unmap dma_unmap;
> +	struct dfl_cxl_cache_buffer_region *region;
> +
> +	minsz = offsetofend(struct dfl_cxl_cache_buffer_unmap, csr_array);
> +	if (copy_from_user(&dma_unmap, arg, minsz)) {
> +		dev_err(cxl_cache->dev, "fails to copy from user space buffer\n");
> +		return -EFAULT;
> +	}
> +	if (dma_unmap.argsz < minsz) {
> +		dev_err(cxl_cache->dev, "invalid ioctl buffer size\n");
> +		return -EINVAL;
> +	}
> +
> +	region = cxl_cache_dma_region_find(cxl_cache, dma_unmap.user_addr, dma_unmap.length);
> +	if (!region) {
> +		dev_err(cxl_cache->dev, "fails to find buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	cxl_cache_dma_region_remove(cxl_cache, region);
> +	cxl_cache_unpin_pages(cxl_cache->dev, &region->pages, region->length);
> +
> +	for (i = 0; i < DFL_ARRAY_MAX_SIZE; i++) {
> +		if (dma_unmap.csr_array[i] && dma_unmap.csr_array[i] < cxl_cache->rinfo.size)
> +			writeq(0, cxl_cache->mmio_base + dma_unmap.csr_array[i]);
> +	}
> +
> +	kfree(region);
> +	return ret;
> +}
> +
> +static long dfl_cxl_cache_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct dfl_cxl_cache *cxl_cache = filp->private_data;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_GET_API_VERSION:
> +		return DFL_FPGA_GET_API_VERSION;
> +	case DFL_FPGA_CHECK_EXTENSION:
> +		return cxl_cache_ioctl_check_extension(cxl_cache, arg);
> +	case DFL_CXL_CACHE_GET_REGION_INFO:
> +		return cxl_cache_ioctl_get_region_info(cxl_cache, (void __user *)arg);
> +	case DFL_CXL_CACHE_NUMA_BUFFER_MAP:
> +		return cxl_cache_ioctl_numa_buffer_map(cxl_cache, (void __user *)arg);
> +	case DFL_CXL_CACHE_NUMA_BUFFER_UNMAP:
> +		return cxl_cache_ioctl_numa_buffer_unmap(cxl_cache, (void __user *)arg);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct vm_operations_struct cxl_cache_vma_ops = {
> +#ifdef CONFIG_HAVE_IOREMAP_PROT
> +	.access = generic_access_phys,
> +#endif
> +};
> +
> +static int dfl_cxl_cache_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct dfl_cxl_cache *cxl_cache = filp->private_data;
> +	u64 size = vma->vm_end - vma->vm_start;
> +	u64 offset;
> +
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +
> +	if (!(cxl_cache->rinfo.flags & DFL_CXL_CACHE_REGION_MMAP))
> +		return -EINVAL;
> +
> +	if ((vma->vm_flags & VM_READ) && !(cxl_cache->rinfo.flags & DFL_CXL_CACHE_REGION_READ))
> +		return -EPERM;
> +
> +	if ((vma->vm_flags & VM_WRITE) && !(cxl_cache->rinfo.flags & DFL_CXL_CACHE_REGION_WRITE))
> +		return -EPERM;
> +
> +	offset = PFN_PHYS(vma->vm_pgoff);
> +
> +	/* Support debug access to the mapping */
> +	vma->vm_ops = &cxl_cache_vma_ops;
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       PFN_DOWN(cxl_cache->ddev->mmio_res.start +
> +			       (offset - cxl_cache->rinfo.offset)),
> +			       size, vma->vm_page_prot);
> +}
> +
> +static void cxl_cache_dma_region_destroy(struct dfl_cxl_cache *cxl_cache)
> +{
> +	struct rb_node *node = rb_first(&cxl_cache->dma_regions);
> +	struct dfl_cxl_cache_buffer_region *region;
> +
> +	while (node) {
> +		region = container_of(node, struct dfl_cxl_cache_buffer_region, node);
> +
> +		rb_erase(node, &cxl_cache->dma_regions);
> +
> +		if (region->pages)
> +			cxl_cache_unpin_pages(cxl_cache->dev, &region->pages, region->length);
> +
> +		node = rb_next(node);
> +		kfree(region);
> +	}
> +}
> +
> +static int dfl_cxl_cache_release(struct inode *inode, struct file *filp)
> +{
> +	struct dfl_cxl_cache *cxl_cache = filp->private_data;
> +
> +	cxl_cache_dma_region_destroy(cxl_cache);
> +	atomic_set(&cxl_cache->opened, 0);
> +	return 0;
> +}
> +
> +static const struct file_operations dfl_cxl_cache_fops = {
> +	.owner = THIS_MODULE,
> +	.open = dfl_cxl_cache_open,
> +	.release = dfl_cxl_cache_release,
> +	.unlocked_ioctl = dfl_cxl_cache_ioctl,
> +	.mmap = dfl_cxl_cache_mmap,
> +};
> +
> +static void cxl_cache_dev_release(struct device *dev)
> +{
> +	struct dfl_cxl_cache *cxl_cache = dev_get_drvdata(dev);
> +
> +	cdev_del(&cxl_cache->cdev);
> +}
> +
> +static void cxl_cache_chardev_uinit(struct dfl_cxl_cache *cxl_cache)
> +{
> +	device_destroy(dfl_cxl_cache_class,
> +		       MKDEV(MAJOR(dfl_cxl_cache_devt), cxl_cache->id));
> +}
> +
> +static int cxl_cache_chardev_init(struct dfl_cxl_cache *cxl_cache,
> +				  struct dfl_device *ddev,
> +				  void __iomem *mmio_base)
> +{
> +	int ret;
> +
> +	dev_set_drvdata(&ddev->dev, cxl_cache);
> +	cxl_cache->ddev = ddev;
> +	cxl_cache->mmio_base = mmio_base;
> +	cxl_cache->id = dfl_cxl_cache_devices++;
> +	cxl_cache->dma_regions = RB_ROOT;
> +
> +	cxl_cache->rinfo.argsz = sizeof(struct dfl_cxl_cache_region_info);
> +	cxl_cache->rinfo.flags = DFL_CXL_CACHE_REGION_READ | DFL_CXL_CACHE_REGION_WRITE |
> +			   DFL_CXL_CACHE_REGION_MMAP;
> +	cxl_cache->rinfo.size = resource_size(&ddev->mmio_res);
> +	cxl_cache->rinfo.offset = 0;
> +
> +	cxl_cache->dev = device_create(dfl_cxl_cache_class, &ddev->dev,
> +				       MKDEV(MAJOR(dfl_cxl_cache_devt), cxl_cache->id),
> +				       cxl_cache, DFL_CXL_CACHE_DRIVER_NAME ".%d",
> +				       cxl_cache->id);
> +
> +	if (IS_ERR(cxl_cache->dev)) {
> +		ret = PTR_ERR(cxl_cache->dev);
> +		dev_err(&ddev->dev, "device_create failed: %d\n", ret);
> +		cxl_cache->dev = NULL;
> +		return ret;
> +	}
> +	cxl_cache->dev->release = cxl_cache_dev_release;
> +
> +	cdev_init(&cxl_cache->cdev, &dfl_cxl_cache_fops);
> +	cxl_cache->cdev.owner = THIS_MODULE;
> +	cxl_cache->cdev.ops = &dfl_cxl_cache_fops;
> +
> +	ret = cdev_add(&cxl_cache->cdev, cxl_cache->dev->devt, 1);
> +	if (ret)
> +		dev_err(cxl_cache->dev, "cdev_add failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int dfl_cxl_cache_probe(struct dfl_device *ddev)
> +{
> +	int ret = 0;
> +	void __iomem *mmio_base;
> +	struct dfl_cxl_cache *cxl_cache;
> +
> +	guard(mutex)(&dfl_cxl_cache_class_lock);
> +
> +	if (!dfl_cxl_cache_class) {
> +		dfl_cxl_cache_class = class_create(DFL_CXL_CACHE_DRIVER_NAME);
> +		if (IS_ERR(dfl_cxl_cache_class)) {
> +			ret = PTR_ERR(dfl_cxl_cache_class);
> +			dfl_cxl_cache_class = NULL;
> +			dev_err_probe(&ddev->dev, ret, "class_create failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (!MAJOR(dfl_cxl_cache_devt)) {
> +		ret = alloc_chrdev_region(&dfl_cxl_cache_devt, 0,
> +					  MINORMASK,
> +					  DFL_CXL_CACHE_DRIVER_NAME);
> +		if (ret) {
> +			dev_err_probe(&ddev->dev, ret, "alloc_chrdev_region failed\n");
> +			dfl_cxl_cache_devt = MKDEV(0, 0);
> +			return ret;
> +		}
> +	}
> +
> +	mmio_base = devm_ioremap_resource(&ddev->dev, &ddev->mmio_res);
> +	if (IS_ERR(mmio_base))
> +		return PTR_ERR(mmio_base);
> +
> +	cxl_cache = devm_kzalloc(&ddev->dev, sizeof(*cxl_cache), GFP_KERNEL);
> +	if (!cxl_cache)
> +		return -ENOMEM;
> +
> +	ret = cxl_cache_chardev_init(cxl_cache, ddev, mmio_base);
> +	if (ret)
> +		dev_err_probe(&ddev->dev, ret, "cxl_cache_chardev_init failed\n");
> +
> +	return ret;
> +}
> +
> +static void dfl_cxl_cache_remove(struct dfl_device *ddev)
> +{
> +	struct dfl_cxl_cache *cxl_cache = dev_get_drvdata(&ddev->dev);
> +
> +	guard(mutex)(&dfl_cxl_cache_class_lock);
> +	cxl_cache_chardev_uinit(cxl_cache);
> +
> +	if (dfl_cxl_cache_devices-- == 0) {
> +		if (dfl_cxl_cache_class) {
> +			class_destroy(dfl_cxl_cache_class);
> +			dfl_cxl_cache_class = NULL;
> +		}
> +
> +		if (MAJOR(dfl_cxl_cache_devt)) {
> +			unregister_chrdev_region(dfl_cxl_cache_devt, MINORMASK);
> +			dfl_cxl_cache_devt = MKDEV(0, 0);
> +		}
> +	}
> +}
> +
> +static const struct dfl_device_id dfl_cxl_cache_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_CXL_CACHE },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, dfl_cxl_cache_ids);
> +
> +static struct dfl_driver dfl_cxl_cache_driver = {
> +	.drv	= {
> +		.name	= DFL_CXL_CACHE_DRIVER_NAME,
> +	},
> +	.id_table = dfl_cxl_cache_ids,
> +	.probe   = dfl_cxl_cache_probe,
> +	.remove = dfl_cxl_cache_remove,
> +};
> +module_dfl_driver(dfl_cxl_cache_driver);
> +
> +MODULE_DESCRIPTION("DFL CXL Cache driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 1621b077bf21..866f50b99eb6 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -31,6 +31,7 @@
>  #define DFL_FPGA_BASE 0
>  #define DFL_PORT_BASE 0x40
>  #define DFL_FME_BASE 0x80
> +#define DFL_CXL_CACHE_BASE 0xA0
>  
>  /* Common IOCTLs for both FME and AFU file descriptor */
>  
> @@ -276,4 +277,101 @@ struct dfl_fpga_fme_port_pr {
>  					     DFL_FME_BASE + 4,	\
>  					     struct dfl_fpga_irq_set)
>  
> + /**
> +  * DFL_CXL_CACHE_GET_REGION_INFO - _IOWR(DFL_FPGA_MAGIC, DFL_CXL_CACHE_BASE + 0,
> +  *                                      struct dfl_cxl_cache_region_info)
> +  *
> +  * Retrieve information about a device memory region.
> +  * Caller provides struct dfl_cxl_cache_region_info with flags.
> +  * Driver returns the region info in other fields.
> +  * Return: 0 on success, -errno on failure.
> +  */
> +
> +#define DFL_CXL_CACHE_GET_REGION_INFO _IO(DFL_FPGA_MAGIC, DFL_CXL_CACHE_BASE + 0)
> +
> +  /**
> +   * struct dfl_cxl_cache_region_info - CXL cache region information
> +   * @argsz: structure length
> +   * @flags: access permission
> +   * @size: region size (bytes)
> +   * @offset: region offset from start of device fd
> +   *
> +   * to retrieve  information about a device memory region
> +   */
> +struct dfl_cxl_cache_region_info {
> +	__u32 argsz;
> +	__u32 flags;
> +#define DFL_CXL_CACHE_REGION_READ	_BITUL(0)
> +#define DFL_CXL_CACHE_REGION_WRITE	_BITUL(1)
> +#define DFL_CXL_CACHE_REGION_MMAP	_BITUL(2)
> +	__u64 size;
> +	__u64 offset;
> +};
> +
> +/**
> + * DFL_CXL_CACHE_NUMA_BUFFER_MAP - _IOWR(DFL_FPGA_MAGIC, DFL_CXL_CACHE_BASE + 1,
> + *                                      struct dfl_cxl_cache_buffer_map)
> + *
> + * Map the user memory per user_addr, length and numa node which are
> + * provided by caller. The driver allocates memory on the numa node,
> + * converts the user's virtual addressto a continuous physical address,
> + * and writes the physical address to the cxl cache read/write address table CSR.
> + *
> + * This interface only accepts page-size aligned user memory for mapping.
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +#define DFL_ARRAY_MAX_SIZE   0x10
> +
> +#define DFL_CXL_CACHE_NUMA_BUFFER_MAP    _IO(DFL_FPGA_MAGIC,  DFL_CXL_CACHE_BASE + 1)
> +
> +/**
> + * struct dfl_cxl_cache_buffer_map - maps user address to physical address.
> + * @argsz: structure length
> + * @flags: flags
> + * @user_addr: user mmap virtual address
> + * @length: length of mapping (bytes)
> + * @csr_array: array of region address offset
> + *
> + * maps user allocated virtual address to physical address.
> + */
> +struct dfl_cxl_cache_buffer_map {
> +	__u32 argsz;
> +#define DFL_CXL_BUFFER_MAP_WRITABLE	1
> +	__u32 flags;
> +	__u64 user_addr;
> +	__u64 length;
> +	__u64 csr_array[DFL_ARRAY_MAX_SIZE];
> +};
> +
> +/**
> + * DFL_CXL_CACHE_NUMA_BUFFER_UNMAP - _IOWR(DFL_FPGA_MAGIC, DFL_CXL_CACHE_BASE + 1,
> + *                                      struct dfl_cxl_cache_buffer_unmap)
> + *
> + * Unmaps the user memory per user_addr and length which are provided by caller
> + * The driver deletes the physical pages of the user address and writes a zero
> + * to the read/write address table CSR.
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +#define DFL_CXL_CACHE_NUMA_BUFFER_UNMAP  _IO(DFL_FPGA_MAGIC,  DFL_CXL_CACHE_BASE + 2)
> +
> +/**
> + * struct dfl_cxl_cache_buffer_unmap - unmaps user allocated memory.
> + * @argsz: structure length
> + * @flags: flags
> + * @user_addr: user mmap virtual address
> + * @length: length of mapping (bytes)
> + * @csr_array: array of region address offset
> + *
> + * unmaps user allocated memory.
> + */
> +struct dfl_cxl_cache_buffer_unmap {
> +	__u32 argsz;
> +	__u32 flags;
> +	__u64 user_addr;
> +	__u64 length;
> +	__u64 csr_array[DFL_ARRAY_MAX_SIZE];
> +};
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> -- 
> 2.34.1
> 
> 

