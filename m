Return-Path: <linux-kernel+bounces-95381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC84874D08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD831B2152D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3450912837F;
	Thu,  7 Mar 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHZ4oEmv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B22127B43;
	Thu,  7 Mar 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809744; cv=none; b=LxhCyt27hUcc6m5GNGh88nZTSzO9Wv4Lh5fWGDVigbAA14IOTb1iY6C/y6Q5+8KXojLM87Co8H/uXTyq2XjHuBQxY6lfWRawIg1/b5Cq2/NYIDs1zhrERMAuIriRkSOeW5C9q+29wZCtWSJxS4CY1TkR0qah6I8icQOtWuFh6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809744; c=relaxed/simple;
	bh=ouDZ0ujGuKmlj1Z5zELF5CFA2af4msmT0TU1fhL9Md8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4MycYDJWUF5dU9C4TFpNapcwY8TfsJ0RHvjNvpwW/4RyLg7/b5OWcqN9V1EusPylM7Sbjgi98LoXAkd9L2H8CqlDXDIhRfoiIqngfdokzgBBYa7D/LoTBcPTSPnt8Jajn+hsa92CpI/ydqsPOEEAzMolKfUYEaqc3C30a+UoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHZ4oEmv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709809742; x=1741345742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ouDZ0ujGuKmlj1Z5zELF5CFA2af4msmT0TU1fhL9Md8=;
  b=AHZ4oEmv7zm2M2jcvGE5X+qdtH21AWdeB/fSB99ilbiDIUsxh9Ch2U5M
   s2dpW08mr6VHoHOzoTSG1Yj7zpO7ahTstQEsvahzsQHJzVU8uu9RUGfD5
   XvhEDMHHMjE1TsWFhhlMu7Ex1ufcKlCVfRvJ7HQgNf9ruyIu/b/jbhTPK
   lCQNOPZ+ypZFN6EBcZxSMefxZo8dPCfeEZvS/mdevc3v5Mfk/ybQkzQBo
   bcB/8sEUHpmU+roCOKWUGVvoiSaF6aR7ew8W2umUKgmcJ0w5ZvVLb3qNu
   heU0zbACBHcxTpw252NnXxCfOaPHjtYHwLwo5hb+jeaBq2lpN3e2X57xv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4329822"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="4329822"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:09:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="10057605"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2024 03:08:56 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riBcK-00056n-2K;
	Thu, 07 Mar 2024 11:08:52 +0000
Date: Thu, 7 Mar 2024 19:08:23 +0800
From: kernel test robot <lkp@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, x86@kernel.org, kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for
 vmemmap region for the fsdax
Message-ID: <202403071804.b9EgMxWo-lkp@intel.com>
References: <20240306102846.1020868-4-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306102846.1020868-4-lizhijian@fujitsu.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on nvdimm/libnvdimm-for-next]
[also build test ERROR on tip/x86/core linus/master v6.8-rc7]
[cannot apply to akpm-mm/mm-everything nvdimm/dax-misc next-20240306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhijian/mm-memremap-register-unregister-altmap-region-to-a-separate-resource/20240306-183118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-for-next
patch link:    https://lore.kernel.org/r/20240306102846.1020868-4-lizhijian%40fujitsu.com
patch subject: [PATCH v3 3/7] nvdimm: pmem: assign a parent resource for vmemmap region for the fsdax
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240307/202403071804.b9EgMxWo-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240307/202403071804.b9EgMxWo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403071804.b9EgMxWo-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvdimm/pmem.c: In function 'pmem_attach_disk':
>> drivers/nvdimm/pmem.c:501:9: error: implicit declaration of function 'pgmap_parent_resource' [-Werror=implicit-function-declaration]
     501 |         pgmap_parent_resource(&pmem->pgmap, parent);
         |         ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pgmap_parent_resource +501 drivers/nvdimm/pmem.c

   448	
   449	static int pmem_attach_disk(struct device *dev,
   450			struct nd_namespace_common *ndns)
   451	{
   452		struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
   453		struct nd_region *nd_region = to_nd_region(dev->parent);
   454		int nid = dev_to_node(dev), fua;
   455		struct resource *res = &nsio->res, *parent;
   456		struct range bb_range;
   457		struct nd_pfn *nd_pfn = NULL;
   458		struct dax_device *dax_dev;
   459		struct nd_pfn_sb *pfn_sb;
   460		struct pmem_device *pmem;
   461		struct request_queue *q;
   462		struct gendisk *disk;
   463		void *addr;
   464		int rc;
   465	
   466		pmem = devm_kzalloc(dev, sizeof(*pmem), GFP_KERNEL);
   467		if (!pmem)
   468			return -ENOMEM;
   469	
   470		rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
   471		if (rc)
   472			return rc;
   473	
   474		/* while nsio_rw_bytes is active, parse a pfn info block if present */
   475		if (is_nd_pfn(dev)) {
   476			nd_pfn = to_nd_pfn(dev);
   477			rc = nvdimm_setup_pfn(nd_pfn, &pmem->pgmap);
   478			if (rc)
   479				return rc;
   480		}
   481	
   482		/* we're attaching a block device, disable raw namespace access */
   483		devm_namespace_disable(dev, ndns);
   484	
   485		dev_set_drvdata(dev, pmem);
   486		pmem->phys_addr = res->start;
   487		pmem->size = resource_size(res);
   488		fua = nvdimm_has_flush(nd_region);
   489		if (!IS_ENABLED(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) || fua < 0) {
   490			dev_warn(dev, "unable to guarantee persistence of writes\n");
   491			fua = 0;
   492		}
   493	
   494		parent = devm_request_mem_region(dev, res->start, resource_size(res),
   495					dev_name(&ndns->dev));
   496		if (!res) {
   497			dev_warn(dev, "could not reserve region %pR\n", res);
   498			return -EBUSY;
   499		}
   500	
 > 501		pgmap_parent_resource(&pmem->pgmap, parent);
   502	
   503		disk = blk_alloc_disk(nid);
   504		if (!disk)
   505			return -ENOMEM;
   506		q = disk->queue;
   507	
   508		pmem->disk = disk;
   509		pmem->pgmap.owner = pmem;
   510		pmem->pfn_flags = PFN_DEV;
   511		if (is_nd_pfn(dev)) {
   512			pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
   513			pmem->pgmap.ops = &fsdax_pagemap_ops;
   514			addr = devm_memremap_pages(dev, &pmem->pgmap);
   515			pfn_sb = nd_pfn->pfn_sb;
   516			pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
   517			pmem->pfn_pad = resource_size(res) -
   518				range_len(&pmem->pgmap.range);
   519			pmem->pfn_flags |= PFN_MAP;
   520			bb_range = pmem->pgmap.range;
   521			bb_range.start += pmem->data_offset;
   522		} else if (pmem_should_map_pages(dev)) {
   523			pmem->pgmap.range.start = res->start;
   524			pmem->pgmap.range.end = res->end;
   525			pmem->pgmap.nr_range = 1;
   526			pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
   527			pmem->pgmap.ops = &fsdax_pagemap_ops;
   528			addr = devm_memremap_pages(dev, &pmem->pgmap);
   529			pmem->pfn_flags |= PFN_MAP;
   530			bb_range = pmem->pgmap.range;
   531		} else {
   532			addr = devm_memremap(dev, pmem->phys_addr,
   533					pmem->size, ARCH_MEMREMAP_PMEM);
   534			bb_range.start =  res->start;
   535			bb_range.end = res->end;
   536		}
   537	
   538		if (IS_ERR(addr)) {
   539			rc = PTR_ERR(addr);
   540			goto out;
   541		}
   542		pmem->virt_addr = addr;
   543	
   544		blk_queue_write_cache(q, true, fua);
   545		blk_queue_physical_block_size(q, PAGE_SIZE);
   546		blk_queue_logical_block_size(q, pmem_sector_size(ndns));
   547		blk_queue_max_hw_sectors(q, UINT_MAX);
   548		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
   549		blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
   550		if (pmem->pfn_flags & PFN_MAP)
   551			blk_queue_flag_set(QUEUE_FLAG_DAX, q);
   552	
   553		disk->fops		= &pmem_fops;
   554		disk->private_data	= pmem;
   555		nvdimm_namespace_disk_name(ndns, disk->disk_name);
   556		set_capacity(disk, (pmem->size - pmem->pfn_pad - pmem->data_offset)
   557				/ 512);
   558		if (devm_init_badblocks(dev, &pmem->bb))
   559			return -ENOMEM;
   560		nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
   561		disk->bb = &pmem->bb;
   562	
   563		dax_dev = alloc_dax(pmem, &pmem_dax_ops);
   564		if (IS_ERR(dax_dev)) {
   565			rc = PTR_ERR(dax_dev);
   566			goto out;
   567		}
   568		set_dax_nocache(dax_dev);
   569		set_dax_nomc(dax_dev);
   570		if (is_nvdimm_sync(nd_region))
   571			set_dax_synchronous(dax_dev);
   572		rc = dax_add_host(dax_dev, disk);
   573		if (rc)
   574			goto out_cleanup_dax;
   575		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
   576		pmem->dax_dev = dax_dev;
   577	
   578		rc = device_add_disk(dev, disk, pmem_attribute_groups);
   579		if (rc)
   580			goto out_remove_host;
   581		if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
   582			return -ENOMEM;
   583	
   584		nvdimm_check_and_set_ro(disk);
   585	
   586		pmem->bb_state = sysfs_get_dirent(disk_to_dev(disk)->kobj.sd,
   587						  "badblocks");
   588		if (!pmem->bb_state)
   589			dev_warn(dev, "'badblocks' notification disabled\n");
   590		return 0;
   591	
   592	out_remove_host:
   593		dax_remove_host(pmem->disk);
   594	out_cleanup_dax:
   595		kill_dax(pmem->dax_dev);
   596		put_dax(pmem->dax_dev);
   597	out:
   598		put_disk(pmem->disk);
   599		return rc;
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

