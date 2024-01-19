Return-Path: <linux-kernel+bounces-31381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EA6832D84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452351C24473
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15755785;
	Fri, 19 Jan 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmVtxEnv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9354F99
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683254; cv=none; b=hJxc773ryCjUcqGqEnbt60sPdjYXyDYm4oagqrTIlllTXb6bTz9OP8XzwQB5kIoC3zF5HmSDiuDcY6DZYxQjqf2Zp7UwDur3OVm8rCLqkzbh+rT3Q4bAQyEHNioDw6zhC9f4/nKTzoqNiHHVdLKQ6AIrtyGqmg2ckZc9c5kW82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683254; c=relaxed/simple;
	bh=2YSE7VIZi16NxMlC4f+gLFAmrm0z+PSPcQXuIvnMLa8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZBUIx+lB296CUXhi55Zi0NITZS+W+1Tvn0h0YiLuYeTFILtPvUILTb2IdEinbr1/MZWGS7V0hkHj4twxnWN+QlFsgbqdG9RR7Wtatk/d51fWd50e4FE2UxDdEtbY1EV8Als5VKnQZYm/mPG5k9N9JLRkEDfSC45j2uH/MNlpBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmVtxEnv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705683253; x=1737219253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2YSE7VIZi16NxMlC4f+gLFAmrm0z+PSPcQXuIvnMLa8=;
  b=lmVtxEnvMQkAW7Fz5lySVZKh6fUPQEgHHaQEYDR4qhsdDN01BMOLmq6/
   JVjsf6cTqIr90xy5AtQy6gi73jikgDggg4omIfp7vQw+3l4Zd4xobvXth
   r0YanTvf4Bk3bcrnIwYwQJMu7vM/AFI+bt+RDMg5iorxqO67Nbe84Xm/V
   wxNZUpXXbzihKdUOh2ViIwIEqJVx7eovjwFNjbd8C9PuXeso8uDdeRoOm
   i50nMR1vbMHi7kaNIDW8X2YS2eJjqC964JDD8PToAxwxdUeapyRKuOKRr
   QAB/sBhbzsRp6YTFVxyEiL41c5nDanorhrWa8DwLN+Xj7c2gXj9QSKgqM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="14310499"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="14310499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 08:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="33440419"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jan 2024 08:54:10 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQs87-0004HE-2S;
	Fri, 19 Jan 2024 16:54:07 +0000
Date: Sat, 20 Jan 2024 00:53:25 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Foley <pefoley2@pefoley.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for
 function 'pcap_init_kern'
Message-ID: <202401200023.6yVSKj6N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847
commit: 2c4d3841a82b88ae8a7b518dc6206f84f68e705a um: Avoid pcap multiple definition errors
date:   11 months ago
config: um-randconfig-001-20240116 (https://download.01.org/0day-ci/archive/20240120/202401200023.6yVSKj6N-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401200023.6yVSKj6N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200023.6yVSKj6N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from arch/um/drivers/pcap_kern.c:7:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
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
>> arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for function 'pcap_init_kern' [-Wmissing-prototypes]
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         |      ^
   arch/um/drivers/pcap_kern.c:18:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         | ^
         | static 
   arch/um/drivers/pcap_kern.c:53:5: warning: no previous prototype for function 'pcap_setup' [-Wmissing-prototypes]
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         |     ^
   arch/um/drivers/pcap_kern.c:53:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         | ^
         | static 
   14 warnings generated.


vim +/pcap_init_kern +18 arch/um/drivers/pcap_kern.c

    17	
  > 18	void pcap_init_kern(struct net_device *dev, void *data)
    19	{
    20		struct uml_net_private *pri;
    21		struct pcap_data *ppri;
    22		struct pcap_init *init = data;
    23	
    24		pri = netdev_priv(dev);
    25		ppri = (struct pcap_data *) pri->user;
    26		ppri->host_if = init->host_if;
    27		ppri->promisc = init->promisc;
    28		ppri->optimize = init->optimize;
    29		ppri->filter = init->filter;
    30	
    31		printk("pcap backend, host interface %s\n", ppri->host_if);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

