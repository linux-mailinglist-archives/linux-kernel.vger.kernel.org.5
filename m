Return-Path: <linux-kernel+bounces-41574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513583F4BF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B226E1F2160E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6BDF5B;
	Sun, 28 Jan 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koIQtrwD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13CDDDC
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706433386; cv=none; b=JllxxbRlU3I5CjOjL2YgfJnH2/V7bDHNNWUYPTsZZbgsUauDS+xHw0d74EF4BmHE7PJgr17bLf2EIH7J4foyFw5RfZ7F11e21wRIGywGq1e4oKVWGP66/rKgahhNfVwppfoVAKUA2XE/nMcL5tL6NLCFffmJr9UKNRHB9W5zqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706433386; c=relaxed/simple;
	bh=U6bM/YXGQHvL7BYUSpYT7hNJk6NMH0NIZ6WTX2w4dlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ce5iGgIFU01hDxAeQ38ljwGjwXaYRyqKnxP8++YSsEQLrxuDwFz3nrxP0AZJ9Kyp6420BBc5MX6ftM+A3eFYB0J3XSlRpDRG/cdpgqAiHjmEQOHuAIpqp7w13EtH+FQ52rhtVR2wsQJl25ihMvO9lSFnU4NA+KCTlEuoA1zImEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koIQtrwD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706433385; x=1737969385;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U6bM/YXGQHvL7BYUSpYT7hNJk6NMH0NIZ6WTX2w4dlM=;
  b=koIQtrwD4iemrXg81+AvGFfinMmZewBFu58DQdewXQOpo2ZEEtBsh1WP
   2OU8xrB9ZYL8kyYNJ3V+zt/h/gM3gghDveRAi3dH8JoXPNIqBRR/4F8lq
   Yb6X92zMaCRr2v9QpaSmrB5xDvxGw45EGpyawVnIEcK6omu/DJSxapOIo
   SlnBtXCf6OiI/skxFh00yV/FBqgV949PQYV+vUMyiusCj0iVAjTX4z7NU
   9PL+gCOug70akuR3z7TbEqrIxMKgJrQldIT6nxOx4fqK7vGHVJBpiBYOS
   ZFWWQexDeb5jP4Lepk7XudtufQX8TG/SsIy1r9IBNBiVtPYr6twZA0kIe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10139577"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10139577"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 01:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29229135"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Jan 2024 01:16:22 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU1H1-0003H0-2o;
	Sun, 28 Jan 2024 09:16:19 +0000
Date: Sun, 28 Jan 2024 17:15:40 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:irq/core 9/9] include/linux/compiler_attributes.h:76:41: error:
 expected expression before '__attribute__'
Message-ID: <202401281754.1789C9HU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
head:   590610d72a790458431cbbebc71ee24521533b5e
commit: 590610d72a790458431cbbebc71ee24521533b5e [9/9] genirq/irq_sim: Shrink code by using cleanup helpers
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240128/202401281754.1789C9HU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281754.1789C9HU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281754.1789C9HU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:89,
                    from <command-line>:
   kernel/irq/irq_sim.c: In function 'irq_domain_create_sim':
>> include/linux/compiler_attributes.h:76:41: error: expected expression before '__attribute__'
      76 | #define __cleanup(func)                 __attribute__((__cleanup__(func)))
         |                                         ^~~~~~~~~~~~~
   include/linux/cleanup.h:64:25: note: in expansion of macro '__cleanup'
      64 | #define __free(_name)   __cleanup(__free_##_name)
         |                         ^~~~~~~~~
   kernel/irq/irq_sim.c:173:19: note: in expansion of macro '__free'
     173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
         |                   ^~~~~~


vim +/__attribute__ +76 include/linux/compiler_attributes.h

a3f8a30f3f0079 Miguel Ojeda   2018-08-30  71  
54da6a0924311c Peter Zijlstra 2023-05-26  72  /*
54da6a0924311c Peter Zijlstra 2023-05-26  73   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-cleanup-variable-attribute
54da6a0924311c Peter Zijlstra 2023-05-26  74   * clang: https://clang.llvm.org/docs/AttributeReference.html#cleanup
54da6a0924311c Peter Zijlstra 2023-05-26  75   */
54da6a0924311c Peter Zijlstra 2023-05-26 @76  #define __cleanup(func)			__attribute__((__cleanup__(func)))
54da6a0924311c Peter Zijlstra 2023-05-26  77  

:::::: The code at line 76 was first introduced by commit
:::::: 54da6a0924311c7cf5015533991e44fb8eb12773 locking: Introduce __cleanup() based infrastructure

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

