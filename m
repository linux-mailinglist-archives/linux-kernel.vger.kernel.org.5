Return-Path: <linux-kernel+bounces-106997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC76187F673
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E65DB22171
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E538F98;
	Tue, 19 Mar 2024 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTyWMRzl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B512744B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710823588; cv=none; b=OzXd/fg+mTCXX4lQLsx/jSqujFLuAZAhi7S5pNnvrjPiSHiLsZznGb9g9pdF2dRybowASJsdGSEqvh1O5DGASBFn37/QhvTpPb9VBXEfpdY2KB3ekMlO+ivfB8BR1GL3ZF9jppUAm1MlVR3ONf6KVVIEWC53DM35gc8xKTjyabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710823588; c=relaxed/simple;
	bh=fEy6P0I3jPTmevPJIPplBM0zTehyrCjLrW0b4HVZw6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn7YRiZtIEfMTVcdBCHrlENUd5Pj3wjANxEcvY/06CtYH37g2zVKvI1nngRZyN4ptfcjbozD3zvgADokUsZLXwx4rx2Ei1Exic9jN+wOP4jpFjDoao+2tKIptjpC6WO84uVcb9rCfZajon3Ix/Pw/jxFRlCROlnslXFWwZNMobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTyWMRzl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710823586; x=1742359586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEy6P0I3jPTmevPJIPplBM0zTehyrCjLrW0b4HVZw6Y=;
  b=MTyWMRzlNPnAiDxTVMtkLUilghNfscy+bmTEFeM2PrfPVtvosMBgaG3M
   zao2uUhWS8HX0hxPQ5hlZRMgqYUSspJMRmuT8c1MPyAgB7ow14gTY3QZm
   ydRTdwx9k8yeRNe5eCaJabqrM+vWPnPWNFKenFIAu9n8+uJtPOt+XmlRe
   trH9x7Canu2sXbkKuHOgSiyNEdliYrxay0ut0VjVmtSvdRFoNZ4Rrxw9j
   Zgj0wsJKljhlO2/BCqS6sFqX0W5da9l8cHdyDHpjXDZUDs+kgOX2fCRhL
   DOS1nMd35pOjArSrSj/zYds7lXT1OWbcExpy/+i35p1x1fiEWMjIR4JBV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="28148016"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="28148016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 21:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="36811876"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Mar 2024 21:46:22 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmRMi-000HTb-0J;
	Tue, 19 Mar 2024 04:46:20 +0000
Date: Tue, 19 Mar 2024 12:45:36 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Will Deacon <will@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Message-ID: <202403191203.AtV7fvue-lkp@intel.com>
References: <20240318130447.594-2-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318130447.594-2-petrtesarik@huaweicloud.com>

Hi Petr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.8]
[also build test WARNING on linus/master next-20240318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Tesarik/swiotlb-extend-buffer-pre-padding-to-alloc_align_mask-if-necessary/20240318-212500
base:   v6.8
patch link:    https://lore.kernel.org/r/20240318130447.594-2-petrtesarik%40huaweicloud.com
patch subject: [PATCH v2 1/2] swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240319/202403191203.AtV7fvue-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403191203.AtV7fvue-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403191203.AtV7fvue-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/dma/swiotlb.c:27:
   In file included from include/linux/dma-direct.h:9:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/dma/swiotlb.c:27:
   In file included from include/linux/dma-direct.h:9:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from kernel/dma/swiotlb.c:27:
   In file included from include/linux/dma-direct.h:9:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from kernel/dma/swiotlb.c:27:
   In file included from include/linux/dma-direct.h:9:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/dma/swiotlb.c:1348:33: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
    1348 |         pool->slots[index].pad_slots = i;
         |                                        ^
   kernel/dma/swiotlb.c:1301:16: note: initialize the variable 'i' to silence this warning
    1301 |         unsigned int i;
         |                       ^
         |                        = 0
   kernel/dma/swiotlb.c:1643:20: warning: unused function 'swiotlb_create_debugfs_files' [-Wunused-function]
    1643 | static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   15 warnings generated.


vim +/i +1348 kernel/dma/swiotlb.c

  1292	
  1293	phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
  1294			size_t mapping_size, size_t alloc_size,
  1295			unsigned int alloc_align_mask, enum dma_data_direction dir,
  1296			unsigned long attrs)
  1297	{
  1298		struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
  1299		unsigned int offset;
  1300		struct io_tlb_pool *pool;
  1301		unsigned int i;
  1302		int index;
  1303		phys_addr_t tlb_addr;
  1304		unsigned short pad_slots;
  1305	
  1306		if (!mem || !mem->nslabs) {
  1307			dev_warn_ratelimited(dev,
  1308				"Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
  1309			return (phys_addr_t)DMA_MAPPING_ERROR;
  1310		}
  1311	
  1312		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
  1313			pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
  1314	
  1315		if (mapping_size > alloc_size) {
  1316			dev_warn_once(dev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
  1317				      mapping_size, alloc_size);
  1318			return (phys_addr_t)DMA_MAPPING_ERROR;
  1319		}
  1320	
  1321		/*
  1322		 * Calculate buffer pre-padding within the allocated space. Use it to
  1323		 * preserve the low bits of the original address according to device's
  1324		 * min_align_mask. Limit the padding to alloc_align_mask or slot size
  1325		 * (whichever is bigger); higher bits of the original address are
  1326		 * preserved by selecting a suitable IO TLB slot.
  1327		 */
  1328		offset = orig_addr & dma_get_min_align_mask(dev) &
  1329			(alloc_align_mask | (IO_TLB_SIZE - 1));
  1330		index = swiotlb_find_slots(dev, orig_addr,
  1331					   alloc_size + offset, alloc_align_mask, &pool);
  1332		if (index == -1) {
  1333			if (!(attrs & DMA_ATTR_NO_WARN))
  1334				dev_warn_ratelimited(dev,
  1335		"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
  1336					 alloc_size, mem->nslabs, mem_used(mem));
  1337			return (phys_addr_t)DMA_MAPPING_ERROR;
  1338		}
  1339	
  1340		/*
  1341		 * Save away the mapping from the original address to the DMA address.
  1342		 * This is needed when we sync the memory.  Then we sync the buffer if
  1343		 * needed.
  1344		 */
  1345		pad_slots = offset / IO_TLB_SIZE;
  1346		offset %= IO_TLB_SIZE;
  1347		index += pad_slots;
> 1348		pool->slots[index].pad_slots = i;
  1349		for (i = 0; i < nr_slots(alloc_size + offset); i++)
  1350			pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
  1351		tlb_addr = slot_addr(pool->start, index) + offset;
  1352		/*
  1353		 * When the device is writing memory, i.e. dir == DMA_FROM_DEVICE, copy
  1354		 * the original buffer to the TLB buffer before initiating DMA in order
  1355		 * to preserve the original's data if the device does a partial write,
  1356		 * i.e. if the device doesn't overwrite the entire buffer.  Preserving
  1357		 * the original data, even if it's garbage, is necessary to match
  1358		 * hardware behavior.  Use of swiotlb is supposed to be transparent,
  1359		 * i.e. swiotlb must not corrupt memory by clobbering unwritten bytes.
  1360		 */
  1361		swiotlb_bounce(dev, tlb_addr, mapping_size, DMA_TO_DEVICE);
  1362		return tlb_addr;
  1363	}
  1364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

