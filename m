Return-Path: <linux-kernel+bounces-125983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D254E892EE2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389B32822E8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE628F59;
	Sun, 31 Mar 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmHMJ6Hr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C68F45;
	Sun, 31 Mar 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711871184; cv=none; b=DPD2AzQXRn2ukNjGtUXDk+mnFPtiCyGqkZ6RU2huLdm5cgcUgTYaxQyWGpADQYEmqukgkDvStd6vxhMwG/Q+jWjg3WhGnvE5honnTRFOEf6C12C6qM9tVShGdP1ZDG6TLSOnGr9XOCpOYwguHO7IOM56G9LLXJ1R5JxrBdl4y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711871184; c=relaxed/simple;
	bh=CCC8iBQSUDYI2ajPaVCd9Q0dKPL7n+kFESzkcRRisfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdvwDpLEcC5su9E/RZ5qgJO9nxCFDn+oPJuUEDv22+3pJES7YK6mlafna+CBCRH1okEqfkHitlNB1+YyQHUqGpfrWSIf62a3q43Ithf4fOfCxzY15aiw4HcHhjvVF/WyRfGXwoQA11/hhTg44UuBpCFrQGecpCke49OW8TCWH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmHMJ6Hr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711871182; x=1743407182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCC8iBQSUDYI2ajPaVCd9Q0dKPL7n+kFESzkcRRisfA=;
  b=HmHMJ6Hry3ZK4qraydzaEfJfGMnv8Q2kRpJPd6fdowgMIYJX8oNWQIPC
   O+1S0Je8tkZ+/5f8id8IT910vpAMZg55BwR3bS1xTHXZ1IHYH6dBo/feq
   IgWbYnC8QrI5NFtmaUGjZW//o1OmHSsNJFZqYSuWbsh1QvakEKzewo7lx
   WM6kVsUx5sb+hzjWI11YX1POnWz5V6Y9uAD/7tW/MwizPRmkk2b5TzdtX
   MZNJiKyEflrFK2HqT3t4KvNcrVZXVIK+8SXzRbX58kFNE1i9vG+SkfXQj
   ov2mWnvPvWkZSyCWn+8jHJtT43QVZJiU+n3EcypQ/FG79s7Gpp4+VycOg
   A==;
X-CSE-ConnectionGUID: AwPOSMLtQbyZEDn4+am4IA==
X-CSE-MsgGUID: O2xjkgFoRBu8ZLFSWhVsyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="18449509"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18449509"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 00:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="48350563"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Mar 2024 00:46:20 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqptQ-0000uQ-2n;
	Sun, 31 Mar 2024 07:46:16 +0000
Date: Sun, 31 Mar 2024 15:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH 2/5] spi: cadence: Add Marvell IP modification changes
Message-ID: <202403311540.oe0vVEdr-lkp@intel.com>
References: <20240329194849.25554-3-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329194849.25554-3-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-cadence-Add-new-bindings-documentation-for-Cadence-XSPI/20240330-035124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240329194849.25554-3-wsadowski%40marvell.com
patch subject: [PATCH 2/5] spi: cadence: Add Marvell IP modification changes
config: i386-randconfig-141-20240330 (https://download.01.org/0day-ci/archive/20240331/202403311540.oe0vVEdr-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403311540.oe0vVEdr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311540.oe0vVEdr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-cadence-xspi.c:531:15: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     531 |                         *buf64++ = readq(addr);
         |                                    ^
   drivers/spi/spi-cadence-xspi.c:534:10: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     534 |                         tmp = readq(addr);
         |                               ^
   drivers/spi/spi-cadence-xspi.c:540:9: error: call to undeclared function 'readq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     540 |                 tmp = readq(addr);
         |                       ^
>> drivers/spi/spi-cadence-xspi.c:555:4: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     555 |                         writeq(*buf64++, addr);
         |                         ^
   drivers/spi/spi-cadence-xspi.c:559:4: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     559 |                         writeq(tmp, addr);
         |                         ^
   drivers/spi/spi-cadence-xspi.c:565:3: error: call to undeclared function 'writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     565 |                 writeq(tmp, addr);
         |                 ^
>> drivers/spi/spi-cadence-xspi.c:794:36: error: call to undeclared function 'spi_master_get_devdata'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     794 |         struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
         |                                           ^
   drivers/spi/spi-cadence-xspi.c:794:36: note: did you mean 'spi_mem_get_drvdata'?
   include/linux/spi/spi-mem.h:224:21: note: 'spi_mem_get_drvdata' declared here
     224 | static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
         |                     ^
>> drivers/spi/spi-cadence-xspi.c:794:68: error: no member named 'master' in 'struct spi_device'
     794 |         struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
         |                                                                  ~~~~~~~  ^
   8 errors generated.


vim +/readq +531 drivers/spi/spi-cadence-xspi.c

   520	
   521	static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len)
   522	{
   523		int i = 0;
   524		int rcount = len / 8;
   525		int rcount_nf = len % 8;
   526		uint64_t tmp;
   527		uint64_t *buf64 = (uint64_t *)buf;
   528	
   529		if (((uint64_t)buf % 8) == 0) {
   530			for (i = 0; i < rcount; i++)
 > 531				*buf64++ = readq(addr);
   532		} else {
   533			for (i = 0; i < rcount; i++) {
   534				tmp = readq(addr);
   535				memcpy(buf+(i*8), &tmp, 8);
   536			}
   537		}
   538	
   539		if (rcount_nf != 0) {
   540			tmp = readq(addr);
   541			memcpy(buf+(i*8), &tmp, rcount_nf);
   542		}
   543	}
   544	
   545	static void mrvl_iowriteq(void __iomem *addr, const void *buf, int len)
   546	{
   547		int i = 0;
   548		int rcount = len / 8;
   549		int rcount_nf = len % 8;
   550		uint64_t tmp;
   551		uint64_t *buf64 = (uint64_t *)buf;
   552	
   553		if (((uint64_t)buf % 8) == 0) {
   554			for (i = 0; i < rcount; i++)
 > 555				writeq(*buf64++, addr);
   556		} else {
   557			for (i = 0; i < rcount; i++) {
   558				memcpy(&tmp, buf+(i*8), 8);
   559				writeq(tmp, addr);
   560			}
   561		}
   562	
   563		if (rcount_nf != 0) {
   564			memcpy(&tmp, buf+(i*8), rcount_nf);
   565			writeq(tmp, addr);
   566		}
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

