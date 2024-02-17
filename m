Return-Path: <linux-kernel+bounces-69985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43685914F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590992832D0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E27D41B;
	Sat, 17 Feb 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN5itX5B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110B1D681
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708190933; cv=none; b=jXVleNNmmcLu0Hy4EwHJaHpb482IOofh7cWWm0r1O+DeuQleldUHXdnkfQgLkr6otudRFUC/q1AYSc2C6qejQOph2Pbn3dxELBP71IwCiO4zQIqrL/6AiZN5VhOwkO5BF+4zP23dforsi1wXiTWwyG8UsWZy3kr47zuLTTrw6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708190933; c=relaxed/simple;
	bh=XoMAutHoxVHHbRXYGtOfCJCOlfzu7clxXNV9Rrq01Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QctJzqaAPmgYypL17voVGFet3/y8F1PIIDrSm9XnFX7K76lGKdLiB4phwai9HzEC2o3gX5zsxjpQZno3AJBbfJRkePbQGC9bN7M0tm6lD22Xbg2//VzGTzt7xPflzR3wDOSS3xGDuRaQ3xwdk3PiaQkVAEjMvAYRSDIDlEJA3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN5itX5B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708190931; x=1739726931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XoMAutHoxVHHbRXYGtOfCJCOlfzu7clxXNV9Rrq01Uo=;
  b=RN5itX5BYR+dRgWsDnI11SgEP2cr1Ie4NW3SW8GYYoi43c6vmvKurs9g
   fVAWLrJgKd7KC+NEr1kSaolUuAX0cPPzceTA1oVnPLxnKHwXUC7ER1Axg
   rx5Mk+ESkqlCdymG7c7j7QXc0PmPjNUfgHiOnoBpEjxbRz1KttyTRqVvJ
   coEA33GO0cPnhDh9p0aJ/+9R//pImXHDnyiTKuPSL91m68B33Pd+jzTRl
   T1xDGutyQxCYnDKtmm2ixcihldM6BgJdWeBKBBBaEq0yHTbivJP7S5DUV
   wcHsI1+b4k4DHA2HB4+Gzm/AVFUjc6H3KWttHqbXo5q7WiuU2M4e3nEH2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2182391"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="2182391"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 09:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="34902595"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Feb 2024 09:28:48 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbOUY-0002L2-0d;
	Sat, 17 Feb 2024 17:28:46 +0000
Date: Sun, 18 Feb 2024 01:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
Message-ID: <202402180115.xH2WHdhd-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240215]
[cannot apply to akpm-mm/mm-everything char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus powerpc/next powerpc/fixes linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/drivers-add-missing-includes-on-linux-mm-h-and-others/20240215-225853
base:   next-20240215
patch link:    https://lore.kernel.org/r/20240215145602.1371274-15-max.kellermann%40ionos.com
patch subject: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20240218/202402180115.xH2WHdhd-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 36adfec155de366d722f2bac8ff9162289dcf06c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240218/202402180115.xH2WHdhd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402180115.xH2WHdhd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from lib/scatterlist.c:9:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> lib/scatterlist.c:739:9: error: call to undeclared function 'PAGE_ALIGN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     739 |         return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
         |                ^
   lib/scatterlist.c:763:9: error: call to undeclared function 'PAGE_ALIGN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     763 |         return PAGE_ALIGN(sg->offset + sg_dma_len(sg)) >> PAGE_SHIFT;
         |                ^
>> lib/scatterlist.c:1153:3: error: call to undeclared function 'unpin_user_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1153 |                 unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
         |                 ^
>> lib/scatterlist.c:1239:8: error: call to undeclared function 'is_vmalloc_or_module_addr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1239 |                         if (is_vmalloc_or_module_addr((void *)kaddr))
         |                             ^
>> lib/scatterlist.c:1240:12: error: call to undeclared function 'vmalloc_to_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1240 |                                 page = vmalloc_to_page((void *)kaddr);
         |                                        ^
   lib/scatterlist.c:1240:12: note: did you mean 'vmalloc_nr_pages'?
   include/linux/vmalloc.h:135:22: note: 'vmalloc_nr_pages' declared here
     135 | extern unsigned long vmalloc_nr_pages(void);
         |                      ^
>> lib/scatterlist.c:1240:10: error: incompatible integer to pointer conversion assigning to 'struct page *' from 'int' [-Wint-conversion]
    1240 |                                 page = vmalloc_to_page((void *)kaddr);
         |                                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 warnings and 6 errors generated.


vim +/PAGE_ALIGN +739 lib/scatterlist.c

a321e91b6d73ed Imre Deak 2013-02-27  736  
a321e91b6d73ed Imre Deak 2013-02-27  737  static int sg_page_count(struct scatterlist *sg)
a321e91b6d73ed Imre Deak 2013-02-27  738  {
a321e91b6d73ed Imre Deak 2013-02-27 @739  	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
a321e91b6d73ed Imre Deak 2013-02-27  740  }
a321e91b6d73ed Imre Deak 2013-02-27  741  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

