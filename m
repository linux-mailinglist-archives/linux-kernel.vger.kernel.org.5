Return-Path: <linux-kernel+bounces-87741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E286D863
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FC11C20E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14245C81;
	Fri,  1 Mar 2024 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR/nP0ye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE7538B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253450; cv=none; b=lIdq3Uffe4XGII5VNMNfx96b4yzMKOFKvfUJHpRWZO7uD0N704lQP43O6Gz555bZkHHB/sdt4Vsuu3KEJ1C1q7mUrSEtONfbf5tQgEoDZKNHhdM2C/AdntmScZxGI3M4xK7dOyjAEwOnv5AWLiJLG40cIDdqsPf4RtBp1V7WIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253450; c=relaxed/simple;
	bh=XRKjEm6PKQ9R1SbEeJLraW4dFbXuNtXD/2iSi0Qg4a4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t8VgBrTcx8XkuBbSicMvLvU7/EU08770FPXCdNjGi1h9ZyvvIQ+ihzXLM9ARn8lmvbPs+Nf7H5iJv8uwvzZAOvFtcaC/ujkpHuwQE1xlfLS1sm6e/CvK8EYc3MiEtrv3H/uhw17S0r038UdZRQTbstIsRM7iuT8EiWoiCqG/jL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR/nP0ye; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709253448; x=1740789448;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XRKjEm6PKQ9R1SbEeJLraW4dFbXuNtXD/2iSi0Qg4a4=;
  b=YR/nP0yeQLrhOoj+UqfmOkEPLSAI7GWZ0E94zdvqIDb2XqcWzboaYG77
   Nj0vHa4xd0urWzKXBWnoI7zk0Xps8fKZO9fbuIlJoyp0/wU5aLMjI58lx
   UM1X1mfNOD7Ge7wSSYKlbXZxWTIRAeubxb02apyTG1TYMv+w56WDVtKq5
   8DIlkHo/WU+QcuVRId1Tdu/r/xbSC5m3hNi49ZRo43LnLtXeLSGE8BbUb
   CDd7H5nJFfYJgcjoEBbY1NJ/lYw0tuMSF42IzGWNuLO0+fCSkW+WVM+rN
   5G9uHpo+kCHMJ480L0PLrHhRW/hEEZFWom9J6Fqj6dYrtENHKwLGjkU9s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3944688"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3944688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 16:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7933575"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 29 Feb 2024 16:37:26 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfqtn-000DOP-1t;
	Fri, 01 Mar 2024 00:37:18 +0000
Date: Fri, 1 Mar 2024 08:35:47 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: fs/bcachefs/quota.c:130:15: warning: arithmetic between different
 enumeration types ('enum quota_types' and 'enum quota_counters')
Message-ID: <202403010825.qnve2eAU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87adedeba51a822533649b143232418b9e26d08b
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   4 months ago
config: hexagon-randconfig-001-20240229 (https://download.01.org/0day-ci/archive/20240301/202403010825.qnve2eAU-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010825.qnve2eAU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403010825.qnve2eAU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/quota.c:2:
   In file included from fs/bcachefs/bcachefs.h:184:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2168:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/bcachefs/quota.c:2:
   In file included from fs/bcachefs/bcachefs.h:184:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/bcachefs/quota.c:2:
   In file included from fs/bcachefs/bcachefs.h:184:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/bcachefs/quota.c:2:
   In file included from fs/bcachefs/bcachefs.h:184:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   fs/bcachefs/quota.c:25:24: warning: variable 'dq' set but not used [-Wunused-but-set-variable]
      25 |         struct bkey_s_c_quota dq;
         |                               ^
>> fs/bcachefs/quota.c:130:15: warning: arithmetic between different enumeration types ('enum quota_types' and 'enum quota_counters') [-Wenum-enum-conversion]
     130 |         }               m[QTYP_NR * Q_COUNTERS];
         |                           ~~~~~~~ ^ ~~~~~~~~~~
   fs/bcachefs/quota.c:612:28: warning: variable 'q' set but not used [-Wunused-but-set-variable]
     612 |         struct bch_memquota_type *q;
         |                                   ^
   fs/bcachefs/quota.c:765:8: error: call to undeclared function 'COUNT_ARGS'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     765 |         ret = bch2_btree_insert_at(c, NULL, NULL, NULL, 0,
         |               ^
   fs/bcachefs/btree_update.h:72:10: note: expanded from macro 'bch2_btree_insert_at'
      72 |                 .nr             = COUNT_ARGS(__VA_ARGS__),              \
         |                                   ^
   10 warnings and 1 error generated.


vim +130 fs/bcachefs/quota.c

   124	
   125	struct quota_msgs {
   126		u8		nr;
   127		struct {
   128			u8	qtype;
   129			u8	msg;
 > 130		}		m[QTYP_NR * Q_COUNTERS];
   131	};
   132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

