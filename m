Return-Path: <linux-kernel+bounces-104312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E368187CC11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5705281528
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEFD1BC2A;
	Fri, 15 Mar 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ebxw12Tx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1FC1B972;
	Fri, 15 Mar 2024 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501191; cv=none; b=GMkLM8x5dbnd0GueRnU55pzgHP7SaugH8Y4vjy6vLNkWwCSjNz5yUM62ZKogbxr38oT+jpd32yOxqAUXyhAVqBVsZuyHz8nA/zbRbgPLbFD5htG7txNST8qA+cVr2Fk+Hzb7ZkafcPyxhxbVy3nuA4hSf083n7K7ulBx10h7l9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501191; c=relaxed/simple;
	bh=g2fugJ9guH0dH0Kc//VxGG2YU3frt9CNJm8W5NG/wzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBP/rj0XQmMnFkLa4ML88xW3qq/EURUm+CLac9wiXMo2yWtRZFDSR35al0MhCFzvQlt11I82+Bke3RHP9vR+galx5xdxIVnHNP8fknvXdbKyjovhqbk3tjk5FnYvSjL7gl6hgMi/aPQuelhmL6lbrUmKHxKQyazIxFL1YWr7T2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ebxw12Tx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710501190; x=1742037190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g2fugJ9guH0dH0Kc//VxGG2YU3frt9CNJm8W5NG/wzA=;
  b=Ebxw12TxUUsRjgCjKh8lu8j3P8Fu0wS4HEFHr+i3DFZAs3rJpWha1VrH
   WWyav8q5eansrvYjhK9qtZhVahsAC+k1S6MF4GcffVm+hT7NXs53ghzpW
   gz7e/ztbXu6eMOVoExkOaJvmRK+QazfVfRoAmVL9iFlYQZRpLnm/vrAyl
   ivyCKFrUmQefCK1CErDSdZ6Coth1JmHoMMEH8xENDF0mhmm3xgwl/SkWn
   wW7sp2RyvsU0awWZfO1JMM0JcWB51MrGuAkQfEJcuPmztghtk9PQCCuUE
   X9TMJhx2yPsrfrgs2TMQBHgKo5wWmjYniduB3o+ZQh6fn0lKlLRORxvFV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22826050"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="22826050"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12677102"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Mar 2024 04:13:06 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl5Ul-000EN9-2e;
	Fri, 15 Mar 2024 11:13:03 +0000
Date: Fri, 15 Mar 2024 19:12:39 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 04/11] pinctrl: aw9523: Make use of struct pinfunction
 and PINCTRL_PINFUNCTION()
Message-ID: <202403151827.SQgOL8WH-lkp@intel.com>
References: <20240313235422.180075-5-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313235422.180075-5-andy.shevchenko@gmail.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master next-20240314]
[cannot apply to v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-aw9523-Destroy-mutex-on-remove/20240314-075853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240313235422.180075-5-andy.shevchenko%40gmail.com
patch subject: [PATCH v1 04/11] pinctrl: aw9523: Make use of struct pinfunction and PINCTRL_PINFUNCTION()
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240315/202403151827.SQgOL8WH-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403151827.SQgOL8WH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151827.SQgOL8WH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/pinctrl-aw9523.c:11:
   In file included from include/linux/gpio/driver.h:8:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/pinctrl/pinctrl-aw9523.c:11:
   In file included from include/linux/gpio/driver.h:8:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pinctrl/pinctrl-aw9523.c:11:
   In file included from include/linux/gpio/driver.h:8:
   In file included from include/linux/irqchip/chained_irq.h:10:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
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
   In file included from drivers/pinctrl/pinctrl-aw9523.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/pinctrl/pinctrl-aw9523.c:170:29: error: no member named 'ngrpoups' in 'struct pinfunction'; did you mean 'ngroups'?
     170 |         *ngroups = aw9523_pmx[sel].ngrpoups;
         |                                    ^~~~~~~~
         |                                    ngroups
   include/linux/pinctrl/pinctrl.h:218:9: note: 'ngroups' declared here
     218 |         size_t ngroups;
         |                ^
   7 warnings and 1 error generated.


vim +170 drivers/pinctrl/pinctrl-aw9523.c

   164	
   165	static int aw9523_pmx_get_groups(struct pinctrl_dev *pctl, unsigned int sel,
   166					 const char * const **groups,
   167					 unsigned int * const ngroups)
   168	{
   169		*groups = aw9523_pmx[sel].groups;
 > 170		*ngroups = aw9523_pmx[sel].ngrpoups;
   171		return 0;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

