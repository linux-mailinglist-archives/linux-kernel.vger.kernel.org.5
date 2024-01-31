Return-Path: <linux-kernel+bounces-46823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3978444CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7051F22129
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB112BEBF;
	Wed, 31 Jan 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utha4IqV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6912A145
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719707; cv=none; b=DYSIsRSMKfeCcOGWRYUiUccmTbr/7X3nmwwWMaKSiSSI/eV9rHR5f6waXErL1yRF5L5Op6Lsdvu011WtWDbZNNlf/pIWJH95rzh0qksjW7Exxs3iYhpL75GP7+Q9RKP69HlQd9iG5pJdnDu65VUrS2j1ZFQQf+gpQ/A22Ew2Xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719707; c=relaxed/simple;
	bh=/+XG45nhUBAUlL2pjdJqTW7tKrhpGtXBkG+mgQYR8ao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AuuKGCLiyapAsRl8rpTlBXVtmEIAlJ3hJ9lYAy9H/qim+lwrTanZDgtb251N3Ake8Xh7g3kLyym1Gspk2j2/PJ1/iZOkq0YHv9WwTApvEEBg+0TNtp9fMDAT4Anncc87GHrgXVfDLBA0MQJhDBIOTmHgS+pLzGZorqUTIEzu7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utha4IqV; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706719704; x=1738255704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/+XG45nhUBAUlL2pjdJqTW7tKrhpGtXBkG+mgQYR8ao=;
  b=Utha4IqVFZ6vKr8m27BLSKMmvMADptQh9HFt5vLLmi7X7JOu2aHTDzTE
   Evmm6zi9ttTcTgtFNUKa6r8xe83JElFvhu8BQmGtL8DZdGsjDn+7c1Hq8
   mIVYhZtrLBfm6y3J94c43v2Q5rMm5UxrU3gH3JcqXmbef9G1DYCgZP9Hk
   nRc7TLwflJGQUJ8EhBoCd3T6g3V6rjtvFD8oWdreg7cZmr0NUy8wnjBU9
   huHBLdqujb5yOx56BNSvqHVjze6gQ/nYlveLS3lJxDPSzPRdIsoB9SH8a
   WD9u73GQxk6qKUStgICml7mlwZQAo44wSdPKo5yDTXZMpgCD1NIyoWv3X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403275502"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403275502"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 08:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788635712"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788635712"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 08:48:21 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVDl5-0001mE-0i;
	Wed, 31 Jan 2024 16:48:19 +0000
Date: Thu, 1 Feb 2024 00:47:34 +0800
From: kernel test robot <lkp@intel.com>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/vector_kern.c:146:39: warning: ordered comparison of
 pointer with integer zero
Message-ID: <202402010040.RUSVaes4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1bbb19b6eb1b8685ab1c268a401ea64380b8bbcb
commit: 9807019a62dc670c73ce8e59e09b41ae458c34b3 um: Loadable BPF "Firmware" for vector drivers
date:   4 years, 2 months ago
config: um-randconfig-r063-20240107 (https://download.01.org/0day-ci/archive/20240201/202402010040.RUSVaes4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010040.RUSVaes4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010040.RUSVaes4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   In file included from include/linux/init.h:5,
                    from include/linux/memblock.h:12,
                    from arch/um/drivers/vector_kern.c:12:
   include/asm-generic/fixmap.h: In function 'fix_to_virt':
   include/asm-generic/fixmap.h:32:26: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
      32 |         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                          ^~
   include/linux/compiler.h:330:23: note: in definition of macro '__compiletime_assert'
     330 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:350:9: note: in expansion of macro '_compiletime_assert'
     350 |         _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:9: note: in expansion of macro 'BUILD_BUG_ON'
      32 |         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |         ^~~~~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/crypto.h:21,
                    from include/crypto/hash.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/skbuff.h:20,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from arch/um/drivers/vector_kern.c:13:
   arch/um/include/asm/uaccess.h: In function '__access_ok':
   arch/um/include/asm/uaccess.h:17:36: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
      17 |           (((unsigned long) (addr) >= FIXADDR_USER_START) && \
         |                                    ^~
   arch/um/include/asm/uaccess.h:45:17: note: in expansion of macro '__access_ok_vsyscall'
      45 |                 __access_ok_vsyscall(addr, size) ||
         |                 ^~~~~~~~~~~~~~~~~~~~
   arch/um/drivers/vector_kern.c: In function 'get_bpf_flash':
>> arch/um/drivers/vector_kern.c:146:39: warning: ordered comparison of pointer with integer zero [-Wextra]
     146 |                         return (allow > 0);
         |                                       ^
   arch/um/drivers/vector_kern.c: In function 'vector_parse':
   arch/um/drivers/vector_kern.c:717:16: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     717 |         int n, len, err;
         |                ^~~


vim +146 arch/um/drivers/vector_kern.c

   138	
   139	static bool get_bpf_flash(struct arglist *def)
   140	{
   141		char *allow = uml_vector_fetch_arg(def, "bpfflash");
   142		long result;
   143	
   144		if (allow != NULL) {
   145			if (kstrtoul(allow, 10, &result) == 0)
 > 146				return (allow > 0);
   147		}
   148		return false;
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

