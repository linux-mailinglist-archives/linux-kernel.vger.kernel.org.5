Return-Path: <linux-kernel+bounces-70029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFBF8591FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CE21F22625
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF747E11B;
	Sat, 17 Feb 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2zi6nNk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E717D40F
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708197269; cv=none; b=lkMUUQ6OF0gxJcmad8+Bxk/H63K+qpx47SZYrQTb0TFtrYsKfTAWa1DvPVdywauwyQhCgANBVVn7eYVkdq/oQ23XOiC+p1ZMPKG7zrEjP0l/q6Ok9xs/S0+r3WIgdliUrvM4Fp1cSr3av0aOCgI2SHALrrx8PyCMmOgK2iUs8C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708197269; c=relaxed/simple;
	bh=tlJWS12Yes/MFess8mTzr6No3txuh/QDekUdE+ykk0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T25xwmqs5PC7grApIqaxM3g+0urGPDA6KpEZmjrrpi4fruNW5MT3w1/u3FE2ota11AYfJb0cB0AuJr58VcPPE/zK/NNETFL1W+fE6je187ugTxfl6QIewBJFvrTcDAso4QP0Zrus+z/t4wX7hVC6vLwCrBvWe4Q+D1iuPB5CpLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2zi6nNk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708197267; x=1739733267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tlJWS12Yes/MFess8mTzr6No3txuh/QDekUdE+ykk0I=;
  b=E2zi6nNkMr9lZPitom0VTrZKZ0hswwDwG5OxUQbcUqFoBb+HPV7WF3y2
   58d0kgNt/8wmh0KgMngRd3Lm0wEwQjjopfnL6Pp7g/xtCSB6GtuuHy3JR
   2L3ou4ohJG2e3dgmjB2pJHyMBdfDPETvwACSyms8tYgIch3lG/WWC49vC
   RwAUqD/Oimv5jKIBVx0FyjVZr3LWAJpJ7u3IUh5MOZF/vnVdllcm6LNOJ
   G+WXg7H/lK4zKVNKZZf9oO5NHo97Fmlc+6hZ9Kjmn0mb0rZk7ya6BcrRU
   CKk5qRxnAFresL39Y2DLRFL0puieY8UaLpyVkdge+/COnHIDT/T7z9E5O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2217418"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2217418"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 11:14:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="4478082"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2024 11:14:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbQ8R-0002Qs-2o;
	Sat, 17 Feb 2024 19:14:10 +0000
Date: Sun, 18 Feb 2024 03:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
Message-ID: <202402180247.nziZ7rAH-lkp@intel.com>
References: <20240215145602.1371274-15-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145602.1371274-15-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240215]
[cannot apply to akpm-mm/mm-everything char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus powerpc/next powerpc/fixes linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/drivers-add-missing-includes-on-linux-mm-h-and-others/20240215-225853
base:   next-20240215
patch link:    https://lore.kernel.org/r/20240215145602.1371274-15-max.kellermann%40ionos.com
patch subject: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240218/202402180247.nziZ7rAH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402180247.nziZ7rAH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402180247.nziZ7rAH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kfifo.h:42,
                    from include/linux/tty_port.h:5,
                    from include/linux/tty.h:12,
                    from lib/bust_spinlocks.c:15:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kfifo.h:42,
                    from lib/kfifo.c:14:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   lib/kfifo.c: In function 'setup_sgl_buf':
>> lib/kfifo.c:310:14: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     310 |         page = virt_to_page(buf);
         |              ^
   lib/kfifo.c:319:23: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     319 |                 npage = virt_to_page(buf);
         |                       ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1654,
                    from lib/iomap.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   In file included from include/linux/pci.h:2688:
   include/linux/dma-mapping.h: In function 'dma_free_noncoherent':
>> include/linux/dma-mapping.h:331:35: warning: passing argument 3 of 'dma_free_pages' makes pointer from integer without a cast [-Wint-conversion]
     331 |         dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   int
   include/linux/dma-mapping.h:316:67: note: expected 'struct page *' but argument is of type 'int'
     316 | void dma_free_pages(struct device *dev, size_t size, struct page *page,
         |                                                      ~~~~~~~~~~~~~^~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:342:40: warning: passing argument 2 of 'dma_map_page_attrs' makes pointer from integer without a cast [-Wint-conversion]
     342 |         return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
         |                                        ^~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int
   include/linux/dma-mapping.h:105:64: note: expected 'struct page *' but argument is of type 'int'
     105 | dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
         |                                                   ~~~~~~~~~~~~~^~~~
   lib/iomap.c: At top level:
   lib/iomap.c:156:5: warning: no previous prototype for 'ioread64_lo_hi' [-Wmissing-prototypes]
     156 | u64 ioread64_lo_hi(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~
   lib/iomap.c:163:5: warning: no previous prototype for 'ioread64_hi_lo' [-Wmissing-prototypes]
     163 | u64 ioread64_hi_lo(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~
   lib/iomap.c:170:5: warning: no previous prototype for 'ioread64be_lo_hi' [-Wmissing-prototypes]
     170 | u64 ioread64be_lo_hi(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~
   lib/iomap.c:178:5: warning: no previous prototype for 'ioread64be_hi_lo' [-Wmissing-prototypes]
     178 | u64 ioread64be_hi_lo(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~
   lib/iomap.c:264:6: warning: no previous prototype for 'iowrite64_lo_hi' [-Wmissing-prototypes]
     264 | void iowrite64_lo_hi(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~
   lib/iomap.c:272:6: warning: no previous prototype for 'iowrite64_hi_lo' [-Wmissing-prototypes]
     272 | void iowrite64_hi_lo(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~
   lib/iomap.c:280:6: warning: no previous prototype for 'iowrite64be_lo_hi' [-Wmissing-prototypes]
     280 | void iowrite64be_lo_hi(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~
   lib/iomap.c:288:6: warning: no previous prototype for 'iowrite64be_hi_lo' [-Wmissing-prototypes]
     288 | void iowrite64be_hi_lo(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/virtio.h:7,
                    from arch/um/drivers/virtio_uml.c:27:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   In file included from include/linux/virtio.h:12:
   include/linux/dma-mapping.h: In function 'dma_free_noncoherent':
>> include/linux/dma-mapping.h:331:35: warning: passing argument 3 of 'dma_free_pages' makes pointer from integer without a cast [-Wint-conversion]
     331 |         dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   int
   include/linux/dma-mapping.h:316:67: note: expected 'struct page *' but argument is of type 'int'
     316 | void dma_free_pages(struct device *dev, size_t size, struct page *page,
         |                                                      ~~~~~~~~~~~~~^~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:342:40: warning: passing argument 2 of 'dma_map_page_attrs' makes pointer from integer without a cast [-Wint-conversion]
     342 |         return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
         |                                        ^~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int
   include/linux/dma-mapping.h:105:64: note: expected 'struct page *' but argument is of type 'int'
     105 | dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
         |                                                   ~~~~~~~~~~~~~^~~~
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from arch/um/drivers/virtio_uml.c:23:
   arch/um/drivers/virtio_uml.c: In function 'vhost_user_set_mem_table':
   arch/um/drivers/virtio_uml.c:678:54: error: 'end_iomem' undeclared (first use in this function)
     678 |                 rc = vhost_user_init_mem_region(__pa(end_iomem), highmem,
         |                                                      ^~~~~~~~~
   arch/um/include/asm/page.h:105:58: note: in definition of macro '__pa'
     105 | #define __pa(virt) uml_to_phys((void *) (unsigned long) (virt))
         |                                                          ^~~~
   arch/um/drivers/virtio_uml.c:678:54: note: each undeclared identifier is reported only once for each function it appears in
     678 |                 rc = vhost_user_init_mem_region(__pa(end_iomem), highmem,
         |                                                      ^~~~~~~~~
   arch/um/include/asm/page.h:105:58: note: in definition of macro '__pa'
     105 | #define __pa(virt) uml_to_phys((void *) (unsigned long) (virt))
         |                                                          ^~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/dmapool.h:14,
                    from include/linux/pci.h:1654,
                    from arch/um/drivers/virt-pci.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   In file included from include/linux/pci.h:2688:
   include/linux/dma-mapping.h: In function 'dma_free_noncoherent':
>> include/linux/dma-mapping.h:331:35: warning: passing argument 3 of 'dma_free_pages' makes pointer from integer without a cast [-Wint-conversion]
     331 |         dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   int
   include/linux/dma-mapping.h:316:67: note: expected 'struct page *' but argument is of type 'int'
     316 | void dma_free_pages(struct device *dev, size_t size, struct page *page,
         |                                                      ~~~~~~~~~~~~~^~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:342:40: warning: passing argument 2 of 'dma_map_page_attrs' makes pointer from integer without a cast [-Wint-conversion]
     342 |         return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
         |                                        ^~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int
   include/linux/dma-mapping.h:105:64: note: expected 'struct page *' but argument is of type 'int'
     105 | dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
         |                                                   ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/dma-mapping.h:11,
                    from include/linux/comedi/comedidev.h:13,
                    from drivers/comedi/comedi_buf.c:12:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/linux/scatterlist.h:189:25: error: implicit declaration of function 'virt_to_page'; did you mean 'virt_to_phys'? [-Werror=implicit-function-declaration]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~
         |                         virt_to_phys
>> include/linux/scatterlist.h:189:25: warning: passing argument 2 of 'sg_set_page' makes pointer from integer without a cast [-Wint-conversion]
     189 |         sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
         |                         ^~~~~~~~~~~~~~~~~
         |                         |
         |                         int
   include/linux/scatterlist.h:136:69: note: expected 'struct page *' but argument is of type 'int'
     136 | static inline void sg_set_page(struct scatterlist *sg, struct page *page,
         |                                                        ~~~~~~~~~~~~~^~~~
   include/linux/scatterlist.h: In function 'sg_phys':
   include/linux/scatterlist.h:389:16: error: implicit declaration of function 'page_to_phys'; did you mean 'page_to_pfn'? [-Werror=implicit-function-declaration]
     389 |         return page_to_phys(sg_page(sg)) + sg->offset;
         |                ^~~~~~~~~~~~
         |                page_to_pfn
   include/linux/dma-mapping.h: In function 'dma_free_noncoherent':
>> include/linux/dma-mapping.h:331:35: warning: passing argument 3 of 'dma_free_pages' makes pointer from integer without a cast [-Wint-conversion]
     331 |         dma_free_pages(dev, size, virt_to_page(vaddr), dma_handle, dir);
         |                                   ^~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   int
   include/linux/dma-mapping.h:316:67: note: expected 'struct page *' but argument is of type 'int'
     316 | void dma_free_pages(struct device *dev, size_t size, struct page *page,
         |                                                      ~~~~~~~~~~~~~^~~~
   include/linux/dma-mapping.h: In function 'dma_map_single_attrs':
>> include/linux/dma-mapping.h:342:40: warning: passing argument 2 of 'dma_map_page_attrs' makes pointer from integer without a cast [-Wint-conversion]
     342 |         return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
         |                                        ^~~~~~~~~~~~~~~~~
         |                                        |
         |                                        int
   include/linux/dma-mapping.h:105:64: note: expected 'struct page *' but argument is of type 'int'
     105 | dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
         |                                                   ~~~~~~~~~~~~~^~~~
   drivers/comedi/comedi_buf.c: In function 'comedi_buf_map_kref_release':
>> drivers/comedi/comedi_buf.c:41:51: warning: passing argument 1 of 'ClearPageReserved' makes pointer from integer without a cast [-Wint-conversion]
      41 |                                 ClearPageReserved(virt_to_page(buf->virt_addr));
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                   |
         |                                                   int
   In file included from include/linux/mmzone.h:23,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from drivers/comedi/comedi_buf.c:11:
   include/linux/page-flags.h:390:59: note: expected 'struct page *' but argument is of type 'int'
     390 | static __always_inline void ClearPage##uname(struct page *page)         \
         |                                              ~~~~~~~~~~~~~^~~~
   include/linux/page-flags.h:424:9: note: in expansion of macro 'CLEARPAGEFLAG'
     424 |         CLEARPAGEFLAG(uname, lname, policy)
         |         ^~~~~~~~~~~~~
   include/linux/page-flags.h:492:1: note: in expansion of macro 'PAGEFLAG'
     492 | PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
         | ^~~~~~~~
   drivers/comedi/comedi_buf.c: In function 'comedi_buf_map_alloc':
>> drivers/comedi/comedi_buf.c:124:41: warning: passing argument 1 of 'SetPageReserved' makes pointer from integer without a cast [-Wint-conversion]
     124 |                         SetPageReserved(virt_to_page(buf->virt_addr));
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         int
   include/linux/page-flags.h:383:57: note: expected 'struct page *' but argument is of type 'int'
     383 | static __always_inline void SetPage##uname(struct page *page)           \
         |                                            ~~~~~~~~~~~~~^~~~
   include/linux/page-flags.h:423:9: note: in expansion of macro 'SETPAGEFLAG'
     423 |         SETPAGEFLAG(uname, lname, policy)                               \
         |         ^~~~~~~~~~~
   include/linux/page-flags.h:492:1: note: in expansion of macro 'PAGEFLAG'
     492 | PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND)
         | ^~~~~~~~
   drivers/comedi/comedi_buf.c: In function '__comedi_buf_alloc':
>> drivers/comedi/comedi_buf.c:178:34: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     178 |                         pages[i] = virt_to_page(buf->virt_addr);
         |                                  ^
   drivers/comedi/comedi_buf.c:18:41: error: 'PAGE_KERNEL' undeclared (first use in this function)
      18 | #define COMEDI_PAGE_PROTECTION          PAGE_KERNEL
         |                                         ^~~~~~~~~~~
   drivers/comedi/comedi_buf.c:183:44: note: in expansion of macro 'COMEDI_PAGE_PROTECTION'
     183 |                                            COMEDI_PAGE_PROTECTION);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/comedi/comedi_buf.c:18:41: note: each undeclared identifier is reported only once for each function it appears in
      18 | #define COMEDI_PAGE_PROTECTION          PAGE_KERNEL
         |                                         ^~~~~~~~~~~
   drivers/comedi/comedi_buf.c:183:44: note: in expansion of macro 'COMEDI_PAGE_PROTECTION'
     183 |                                            COMEDI_PAGE_PROTECTION);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
.


vim +/sg_set_page +189 include/linux/scatterlist.h

82f66fbef58de4 Jens Axboe    2007-10-22  175  
18dabf473e1585 Jens Axboe    2007-10-22  176  /**
18dabf473e1585 Jens Axboe    2007-10-22  177   * sg_set_buf - Set sg entry to point at given data
18dabf473e1585 Jens Axboe    2007-10-22  178   * @sg:		 SG entry
18dabf473e1585 Jens Axboe    2007-10-22  179   * @buf:	 Data
18dabf473e1585 Jens Axboe    2007-10-22  180   * @buflen:	 Data length
18dabf473e1585 Jens Axboe    2007-10-22  181   *
18dabf473e1585 Jens Axboe    2007-10-22  182   **/
82f66fbef58de4 Jens Axboe    2007-10-22  183  static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
d32311fed70d12 Herbert Xu    2005-09-17  184  			      unsigned int buflen)
d32311fed70d12 Herbert Xu    2005-09-17  185  {
ac4e97abce9b80 Rusty Russell 2013-05-30  186  #ifdef CONFIG_DEBUG_SG
ac4e97abce9b80 Rusty Russell 2013-05-30  187  	BUG_ON(!virt_addr_valid(buf));
ac4e97abce9b80 Rusty Russell 2013-05-30  188  #endif
642f149031d704 Jens Axboe    2007-10-24 @189  	sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(buf));
d32311fed70d12 Herbert Xu    2005-09-17  190  }
d32311fed70d12 Herbert Xu    2005-09-17  191  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

