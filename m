Return-Path: <linux-kernel+bounces-32172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC18357A7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F581F21803
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE638383A4;
	Sun, 21 Jan 2024 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUEzk/h7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B66804
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867711; cv=none; b=BBCpOMmWxbGSvMXr74NLlF5MuiuXx7Zwhf2My/3++b3KqBvAlIY8/KCmhrMnulcTO3fZdgT/LqYEa85ZUUBiOT/Zb49xXDaPO8TVRdxNC3UJMSq2BvhUbwaxP2T7B/IX2EeFZmjpzjL0kUIklNLkX+8njQ9ZWQGaTpvtJxUbHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867711; c=relaxed/simple;
	bh=uv54BDJ2xx83Uk3+58/0LAFby63JWISeODEXR4MCmsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcIHmKO+3DF6r8epSb6QzXX69A54ra8VUxV/73pE+Hip33nqdWt+/OGYcm1N4hpyhhQibiG9UL8BTtx/kqGOBkKFq9YrjXiCkkRwjM4/WRhJZeqGyVh88BspKD9Po0bFt0gx9UmG1oXhauUhCWJmSMuR/J4GqBw0Ml7uGR/N3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUEzk/h7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705867709; x=1737403709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uv54BDJ2xx83Uk3+58/0LAFby63JWISeODEXR4MCmsc=;
  b=aUEzk/h7lS5orPUOwtFKZIPj5BG16HC9Vj+lewvCR9oUID9K9BlGxy7Y
   HmQb3zi9oHhyEjhyAodRDWr4Ut2MmWSwAh5HsAXf5Hu8FCxf9WLD4gqWp
   pjjle7s6daQFjXVfGNCj8wOqfKPW0PHEX0S3Egxbp7qXxfb8In9JiaYyw
   0VN4GimCZRfDekessgaE174NWIGk6Nn5iJ3fWbguUKKR15upEkI1qgUS5
   0EpdSj1rttL1fLdI2dDmI54w6S+3gFqaf03c1DdP/lqP+swc9cFZKNxBU
   w4h+13A/6VsHyl19E7U9nuIc8vdcfL13QlzZuJ9+sDg/+BTwHuFPhvY9x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14572431"
X-IronPort-AV: E=Sophos;i="6.05,210,1701158400"; 
   d="scan'208";a="14572431"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 12:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,210,1701158400"; 
   d="scan'208";a="33848646"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Jan 2024 12:08:25 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRe7C-0006AC-2M;
	Sun, 21 Jan 2024 20:08:22 +0000
Date: Mon, 22 Jan 2024 04:07:36 +0800
From: kernel test robot <lkp@intel.com>
To: Pranav Prasad <pranavpp@google.com>, tglx@linutronix.de,
	jstultz@google.com, sboyd@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Pranav Prasad <pranavpp@google.com>,
	Kelly Rossmoyer <krossmo@google.com>
Subject: Re: [PATCH] alarmtimer: Expose information about next alarm to
 userspace via sysfs
Message-ID: <202401220311.aQMd6KFE-lkp@intel.com>
References: <20240118181459.1663313-1-pranavpp@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118181459.1663313-1-pranavpp@google.com>

Hi Pranav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/timers/core]
[also build test WARNING on linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pranav-Prasad/alarmtimer-Expose-information-about-next-alarm-to-userspace-via-sysfs/20240119-021809
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20240118181459.1663313-1-pranavpp%40google.com
patch subject: [PATCH] alarmtimer: Expose information about next alarm to userspace via sysfs
config: um-randconfig-001-20240120 (https://download.01.org/0day-ci/archive/20240122/202401220311.aQMd6KFE-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d92ce344bf641e6bb025b41b3f1a77dd25e2b3e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240122/202401220311.aQMd6KFE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401220311.aQMd6KFE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
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
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
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
   In file included from kernel/time/alarmtimer.c:18:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
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
>> kernel/time/alarmtimer.c:37:19: warning: unused variable 'alarmtimer_group_name' [-Wunused-const-variable]
      37 | static const char alarmtimer_group_name[] = "alarmtimer";
         |                   ^~~~~~~~~~~~~~~~~~~~~
   13 warnings generated.


vim +/alarmtimer_group_name +37 kernel/time/alarmtimer.c

    36	
  > 37	static const char alarmtimer_group_name[] = "alarmtimer";
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

