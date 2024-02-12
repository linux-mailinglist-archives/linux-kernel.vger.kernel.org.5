Return-Path: <linux-kernel+bounces-61105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FE850D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 06:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DBEB22697
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CB747F;
	Mon, 12 Feb 2024 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2AmmOcz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795525684
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715117; cv=none; b=G0j5Bv0yZIkkv+FQAtGt+Njf10udK5zIkiliuITq+c5MAfRNph/mQUuaccL5sSxFtoTrANtJBlJNyxh52HS8hg7WsDsUHtjjAdJIg4tlIvnsnnH6q1rrXA/TcF36o1/+XjoVx+7tKsm7wgBQHZWV2WS7MNM0L7HBjwNZI7gLSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715117; c=relaxed/simple;
	bh=KLZZMTyCIpkRQaeXCIxr/JJ16x+kKWm9YsrvXvu9+ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaVdmkAQxDAGXFCdc1o3Z5dgvDi+1Wx+IWAvDM214QfklADtusbs5rT0wuBE9WzhPjv3wutDM7ve8GV3rasqAVjhWFJfEzPK+vAQ+zva0rZieg9a6O7AS5JpDjS7NW/e0YKz8ahJALBqggmqMPxPXCA9XoCmpWjzEJYnkR8D3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2AmmOcz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707715115; x=1739251115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLZZMTyCIpkRQaeXCIxr/JJ16x+kKWm9YsrvXvu9+ls=;
  b=f2AmmOczthxNO48NLmc7fawEiCmqtKzmM6wsbMu3V+02Y2ZmQr22ZqFU
   848v2MXSo0/9WYi9r4yw282nUud4iKCxIm3mgi6f6S1euVky1pNLbHxKw
   HMDTamttpy1roro0b4YaRqd6A/EG5ym1TH+FjRpyAb3amI8/D9GSy080c
   vQ9yKpSBbnyslRKZcF4NxwPKwATQKg87a/Ns0sXlWGYDhyrn/FnXROkbC
   aAlytCe2eYSlkkGihZg5DqDSa7PYU8R+WlBvkxnw4f4lqDKql0uCW0taC
   PBMu/YnebnxJt9Aja8gkd0x74JEHYjDe9XIwIsAx0WYDXkCbfyLkVbL8N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1822080"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1822080"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 21:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="825713368"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="825713368"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2024 21:18:29 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZOi3-0006we-05;
	Mon, 12 Feb 2024 05:18:27 +0000
Date: Mon, 12 Feb 2024 13:18:15 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v4 03/35] include: reduce header dependencies by using
 "*_types.h"
Message-ID: <202402121320.iojukTeD-lkp@intel.com>
References: <20240211231518.349442-4-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211231518.349442-4-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240212-072756
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211231518.349442-4-max.kellermann%40ionos.com
patch subject: [PATCH v4 03/35] include: reduce header dependencies by using "*_types.h"
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240212/202402121320.iojukTeD-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402121320.iojukTeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402121320.iojukTeD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/chips/cfi_probe.c:19:
   In file included from include/linux/mtd/cfi.h:13:
>> include/linux/mtd/flashchip.h:16:10: fatal error: 'linux/wait_types.h' file not found
   #include <linux/wait_types.h>
            ^~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +16 include/linux/mtd/flashchip.h

     9	
    10	/* For spinlocks. sched.h includes spinlock.h from whichever directory it
    11	 * happens to be in - so we don't have to care whether we're on 2.2, which
    12	 * has asm/spinlock.h, or 2.4, which has linux/spinlock.h
    13	 */
    14	#include <linux/sched.h>
    15	#include <linux/mutex_types.h>
  > 16	#include <linux/wait_types.h>
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

