Return-Path: <linux-kernel+bounces-18968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB908265D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD02B1F21427
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84E11181;
	Sun,  7 Jan 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNuLpt97"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFE10A3C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704656512; x=1736192512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k6T1t+jqUOcqGHUG5Fk3o3bHj/5BhPk54YIbKawj9AU=;
  b=kNuLpt97vD/3gy+m7vFpI4Y9ILAyS/F1XGa6WVAnruCM4MxzJ6JTVNYQ
   Bz1B1muyOswjFZgAggE8AlSAzntBOdD79FiFb+tVCon/HqWyRY029FolP
   VO9JpdEwk7un9SVpIn3lt+NB6RWbqmuln1rxtViadkjQpLybE/nvAFORC
   s6Oc8BM6M5o8CJkxSz+dgSk3cDElFU3S0VchtmwtI21Nb95x1TUwgf8ZJ
   zvdnFQGvMHxZy+gZhdtIUlqQbr7VJtiIYk6+GRl2/eUuPYDnCaws4gsdI
   KfUH2zbwXouyA+E5/4+Z6rBh0Vvo9G5wYeR/DNLpLzrm4gVPs34sPMhJk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="483934137"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="483934137"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 11:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="900170415"
X-IronPort-AV: E=Sophos;i="6.04,339,1695711600"; 
   d="scan'208";a="900170415"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2024 11:41:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMZ1m-00044Y-1g;
	Sun, 07 Jan 2024 19:41:46 +0000
Date: Mon, 8 Jan 2024 03:41:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dipam Turkar <dipamt1729@gmail.com>, alexander.deucher@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dipam Turkar <dipamt1729@gmail.com>
Subject: Re: [PATCH 1/1] Refactor radeon driver to use
 drm_gem_create_map_offset() instead of its custom implementation for
 associating GEM object with a fake offset. Since, we already have a generic
 implementation, we don't need the custom function and it is better to
 standardize the code.
Message-ID: <202401080333.6PSOtuIK-lkp@intel.com>
References: <20240106141422.10734-1-dipamt1729@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106141422.10734-1-dipamt1729@gmail.com>

Hi Dipam,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.7-rc8 next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipam-Turkar/Refactor-radeon-driver-to-use-drm_gem_create_map_offset-instead-of-its-custom-implementation-for-associating-GEM-object-/20240106-221755
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240106141422.10734-1-dipamt1729%40gmail.com
patch subject: [PATCH 1/1] Refactor radeon driver to use drm_gem_create_map_offset() instead of its custom implementation for associating GEM object with a fake offset. Since, we already have a generic implementation, we don't need the custom function and it is better to standardize the code.
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240108/202401080333.6PSOtuIK-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401080333.6PSOtuIK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401080333.6PSOtuIK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/radeon/radeon_gem.c:34:10: fatal error: 'drm/dem_gem.h' file not found
      34 | #include <drm/dem_gem.h>
         |          ^~~~~~~~~~~~~~~
   1 error generated.


vim +34 drivers/gpu/drm/radeon/radeon_gem.c

    31	
    32	#include <drm/drm_device.h>
    33	#include <drm/drm_file.h>
  > 34	#include <drm/dem_gem.h>
    35	#include <drm/drm_gem_ttm_helper.h>
    36	#include <drm/radeon_drm.h>
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

