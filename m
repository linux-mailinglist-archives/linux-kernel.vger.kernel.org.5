Return-Path: <linux-kernel+bounces-47808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135B845322
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72331F251C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9FC15AAB9;
	Thu,  1 Feb 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9JY8Z0P"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721615AAA7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777496; cv=none; b=JirHA2zJqABnp4jIiHvw4F43Kli5ND82zRKMbq2jBuIRZnwwmS/YvqHhmBzlCaqFpHALSHW7rtejsSRM0mtzB/N9SdDPN1m5efSRx/0aiGFdP6zSsWMjdXZbbGwBp9g79HIhoQoFjMYhdymU0Kv8F/8z5SyV0WCX+oZtqSipZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777496; c=relaxed/simple;
	bh=5iTdwm5f6YyDKv36WCOGaVcnA0ASfE/Qfgz/1SEYJFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G2xKEZQt7fajAm+Rz+q4Oh/BdjYsw5X71l5iaoSKcALJPWFXfPyWgC8dm0jy2Ncq6cV1rAa69RBWN0b4kEXv4GBKIzejVMSb9ywEb3ISR57Q2CGk99tRSMXY0K4WO1oNT6y7Zf4G+CdoAVZMEDIpx+6vkCe7Ipu3q/VGXtTc2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9JY8Z0P; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706777493; x=1738313493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5iTdwm5f6YyDKv36WCOGaVcnA0ASfE/Qfgz/1SEYJFo=;
  b=L9JY8Z0P63Yw31zKKZm9jgz8mc2QMFu1E3XVN0jwoqeLwJA1cOodVjkt
   8QNLzml5zjNAHgjHzhRI5K6UwVMjYvJcsJXgyUVPkRBlJacYrbtREM1ZE
   GHDVuMXwRLjgGI8+/KUp6XVQ69LQq52JePAqYfSesjwlNkxbmnrbko2GA
   gD587v8u2UkF2lVnmwtnu5r7alBGq/csZIiQwUWTkVt6YjSL47JK/QDL/
   oiUEfR93VjGCOTTriuCX7F0JZN1cR9Qp3Y5xuMyKne4f/lzEPJ7aI1ySp
   JUww6pSmXo0gUK4zCIpAjsjq4XhuJLsyhRkOyh7OMVNhy78qFI+PKu9jW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407563798"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="407563798"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 00:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119873437"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119873437"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2024 00:51:30 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVSnA-0002bS-0n;
	Thu, 01 Feb 2024 08:51:28 +0000
Date: Thu, 1 Feb 2024 16:51:20 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: lib/iomap.c:145:5: warning: no previous prototype for
 'ioread64_lo_hi'
Message-ID: <202402011648.cZGj77Kw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6764c317b6bb91bd806ef79adf6d9c0e428b191e
commit: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver
date:   2 years, 8 months ago
config: um-randconfig-r063-20240107 (https://download.01.org/0day-ci/archive/20240201/202402011648.cZGj77Kw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402011648.cZGj77Kw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402011648.cZGj77Kw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/iomap.c:145:5: warning: no previous prototype for 'ioread64_lo_hi' [-Wmissing-prototypes]
     145 | u64 ioread64_lo_hi(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~
>> lib/iomap.c:151:5: warning: no previous prototype for 'ioread64_hi_lo' [-Wmissing-prototypes]
     151 | u64 ioread64_hi_lo(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~
>> lib/iomap.c:157:5: warning: no previous prototype for 'ioread64be_lo_hi' [-Wmissing-prototypes]
     157 | u64 ioread64be_lo_hi(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~
>> lib/iomap.c:164:5: warning: no previous prototype for 'ioread64be_hi_lo' [-Wmissing-prototypes]
     164 | u64 ioread64be_hi_lo(const void __iomem *addr)
         |     ^~~~~~~~~~~~~~~~
>> lib/iomap.c:240:6: warning: no previous prototype for 'iowrite64_lo_hi' [-Wmissing-prototypes]
     240 | void iowrite64_lo_hi(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~
>> lib/iomap.c:246:6: warning: no previous prototype for 'iowrite64_hi_lo' [-Wmissing-prototypes]
     246 | void iowrite64_hi_lo(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~
>> lib/iomap.c:252:6: warning: no previous prototype for 'iowrite64be_lo_hi' [-Wmissing-prototypes]
     252 | void iowrite64be_lo_hi(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~
>> lib/iomap.c:258:6: warning: no previous prototype for 'iowrite64be_hi_lo' [-Wmissing-prototypes]
     258 | void iowrite64be_hi_lo(u64 val, void __iomem *addr)
         |      ^~~~~~~~~~~~~~~~~


vim +/ioread64_lo_hi +145 lib/iomap.c

79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  144  
8f28ca6bd82112 Krzysztof Kozlowski 2020-08-14 @145  u64 ioread64_lo_hi(const void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  146  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  147  	IO_COND(addr, return pio_read64_lo_hi(port), return readq(addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  148  	return 0xffffffffffffffffULL;
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  149  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  150  
8f28ca6bd82112 Krzysztof Kozlowski 2020-08-14 @151  u64 ioread64_hi_lo(const void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  152  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  153  	IO_COND(addr, return pio_read64_hi_lo(port), return readq(addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  154  	return 0xffffffffffffffffULL;
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  155  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  156  
8f28ca6bd82112 Krzysztof Kozlowski 2020-08-14 @157  u64 ioread64be_lo_hi(const void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  158  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  159  	IO_COND(addr, return pio_read64be_lo_hi(port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  160  		return mmio_read64be(addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  161  	return 0xffffffffffffffffULL;
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  162  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  163  
8f28ca6bd82112 Krzysztof Kozlowski 2020-08-14 @164  u64 ioread64be_hi_lo(const void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  165  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  166  	IO_COND(addr, return pio_read64be_hi_lo(port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  167  		return mmio_read64be(addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  168  	return 0xffffffffffffffffULL;
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  169  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  170  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  171  EXPORT_SYMBOL(ioread64_lo_hi);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  172  EXPORT_SYMBOL(ioread64_hi_lo);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  173  EXPORT_SYMBOL(ioread64be_lo_hi);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  174  EXPORT_SYMBOL(ioread64be_hi_lo);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  175  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  176  #endif /* readq */
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  177  
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  178  #ifndef pio_write16be
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  179  #define pio_write16be(val,port) outw(swab16(val),port)
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  180  #define pio_write32be(val,port) outl(swab32(val),port)
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  181  #endif
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  182  
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  183  #ifndef mmio_write16be
aecc787c06f430 Logan Gunthorpe     2019-01-16  184  #define mmio_write16be(val,port) writew(swab16(val),port)
aecc787c06f430 Logan Gunthorpe     2019-01-16  185  #define mmio_write32be(val,port) writel(swab32(val),port)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  186  #define mmio_write64be(val,port) writeq(swab64(val),port)
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  187  #endif
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  188  
9f741cb8fecef9 Harvey Harrison     2008-02-08  189  void iowrite8(u8 val, void __iomem *addr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  190  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  191  	IO_COND(addr, outb(val,port), writeb(val, addr));
^1da177e4c3f41 Linus Torvalds      2005-04-16  192  }
9f741cb8fecef9 Harvey Harrison     2008-02-08  193  void iowrite16(u16 val, void __iomem *addr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  194  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  195  	IO_COND(addr, outw(val,port), writew(val, addr));
^1da177e4c3f41 Linus Torvalds      2005-04-16  196  }
9f741cb8fecef9 Harvey Harrison     2008-02-08  197  void iowrite16be(u16 val, void __iomem *addr)
dae409a2778877 James Bottomley     2005-04-16  198  {
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  199  	IO_COND(addr, pio_write16be(val,port), mmio_write16be(val, addr));
dae409a2778877 James Bottomley     2005-04-16  200  }
9f741cb8fecef9 Harvey Harrison     2008-02-08  201  void iowrite32(u32 val, void __iomem *addr)
^1da177e4c3f41 Linus Torvalds      2005-04-16  202  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  203  	IO_COND(addr, outl(val,port), writel(val, addr));
^1da177e4c3f41 Linus Torvalds      2005-04-16  204  }
9f741cb8fecef9 Harvey Harrison     2008-02-08  205  void iowrite32be(u32 val, void __iomem *addr)
dae409a2778877 James Bottomley     2005-04-16  206  {
34ba8a5cd0b0d5 Linus Torvalds      2006-11-11  207  	IO_COND(addr, pio_write32be(val,port), mmio_write32be(val, addr));
dae409a2778877 James Bottomley     2005-04-16  208  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  209  EXPORT_SYMBOL(iowrite8);
^1da177e4c3f41 Linus Torvalds      2005-04-16  210  EXPORT_SYMBOL(iowrite16);
dae409a2778877 James Bottomley     2005-04-16  211  EXPORT_SYMBOL(iowrite16be);
^1da177e4c3f41 Linus Torvalds      2005-04-16  212  EXPORT_SYMBOL(iowrite32);
dae409a2778877 James Bottomley     2005-04-16  213  EXPORT_SYMBOL(iowrite32be);
^1da177e4c3f41 Linus Torvalds      2005-04-16  214  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  215  #ifdef writeq
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  216  static void pio_write64_lo_hi(u64 val, unsigned long port)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  217  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  218  	outl(val, port);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  219  	outl(val >> 32, port + sizeof(u32));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  220  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  221  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  222  static void pio_write64_hi_lo(u64 val, unsigned long port)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  223  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  224  	outl(val >> 32, port + sizeof(u32));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  225  	outl(val, port);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  226  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  227  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  228  static void pio_write64be_lo_hi(u64 val, unsigned long port)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  229  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  230  	pio_write32be(val, port + sizeof(u32));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  231  	pio_write32be(val >> 32, port);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  232  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  233  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  234  static void pio_write64be_hi_lo(u64 val, unsigned long port)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  235  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  236  	pio_write32be(val >> 32, port);
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  237  	pio_write32be(val, port + sizeof(u32));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  238  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  239  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16 @240  void iowrite64_lo_hi(u64 val, void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  241  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  242  	IO_COND(addr, pio_write64_lo_hi(val, port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  243  		writeq(val, addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  244  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  245  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16 @246  void iowrite64_hi_lo(u64 val, void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  247  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  248  	IO_COND(addr, pio_write64_hi_lo(val, port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  249  		writeq(val, addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  250  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  251  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16 @252  void iowrite64be_lo_hi(u64 val, void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  253  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  254  	IO_COND(addr, pio_write64be_lo_hi(val, port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  255  		mmio_write64be(val, addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  256  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  257  
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16 @258  void iowrite64be_hi_lo(u64 val, void __iomem *addr)
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  259  {
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  260  	IO_COND(addr, pio_write64be_hi_lo(val, port),
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  261  		mmio_write64be(val, addr));
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  262  }
79bf0cbd86ac48 Logan Gunthorpe     2019-01-16  263  

:::::: The code at line 145 was first introduced by commit
:::::: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)

:::::: TO: Krzysztof Kozlowski <krzk@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

