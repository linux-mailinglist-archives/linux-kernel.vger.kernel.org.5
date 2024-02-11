Return-Path: <linux-kernel+bounces-60917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE85850AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F051C211DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5F5D470;
	Sun, 11 Feb 2024 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPF5UWo6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE7FC19
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678130; cv=none; b=FcvgYft4jV8bwSOqmvYbyM8lngNHy3htw9j4gTJeeLk91tkjhvsa3lSXll0MYNRTUi5nDqLcy6pmaJUN9XXpnV/+idWy1oDhFcClqG8ls416hpyLXpRSMLJvAmQed4z6A8HHopbglxngHQG10re7YenckdORhCM97KmqMo3HySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678130; c=relaxed/simple;
	bh=ne+I1lVvIggr9Ct6CO9zOzMdMZ2Eb6zOcxpa0xPq5/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3B0HMNItcXZrD3EVyuThGfb45H9yvS8cUwVLV13ggpza4+mVAEn391UTUzJJSnaJ+3obp2/RljGTSFkNPdgPTaVjWN3bsR/zyYyHDTMt7JwI3Iweh9OvSJp4gEv86j6xupvCSpVADMZkeImMWUoaOAjZt91JKaLrYb2MLuD1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPF5UWo6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707678128; x=1739214128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ne+I1lVvIggr9Ct6CO9zOzMdMZ2Eb6zOcxpa0xPq5/Q=;
  b=HPF5UWo6BqDvzLra6alWKatkQCzidq77Ct31nxVEzyyHyuzltR8lfI45
   v3Af61LxKSfB6R/dTdqwaFoP4sYi3yfBFVlN+rOXt3iQSUlDPSf7vq5Bw
   XI/eoEvjNuMRQ+/Phpf0Il0uxgsDXg5SBNuUUty12tj97RZG0k0CDVu1b
   CvA4SNnlBaNFFDfBPPa6W+DxSBlHDEbqyebECWxDronfJuHGuhWBga8Lz
   i/dqoBbTIckKw88DbLlCT0DUTrGasQlZwbtlCF24BVazhoCEAIAi3F/uz
   dPmVZSJ/HaNZJBaM3tfD3Oj7l3InpWZgK0uFGkZB3DPU3Uh0x+XJ/SGJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="4618795"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="4618795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 11:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="2811533"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Feb 2024 11:02:06 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZF5X-0006ja-0D;
	Sun, 11 Feb 2024 19:02:03 +0000
Date: Mon, 12 Feb 2024 03:01:46 +0800
From: kernel test robot <lkp@intel.com>
To: Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all
 zswap_pools
Message-ID: <202402120226.TK7G37U9-lkp@intel.com>
References: <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-zswap-global-lru-v1-1-853473d7b0da@bytedance.com>

Hi Chengming,

kernel test robot noticed the following build errors:

[auto build test ERROR on 191d97734e41a5c9f90a2f6636fdd335ae1d435d]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengming-Zhou/mm-zswap-global-lru-and-shrinker-shared-by-all-zswap_pools/20240211-220028
base:   191d97734e41a5c9f90a2f6636fdd335ae1d435d
patch link:    https://lore.kernel.org/r/20240210-zswap-global-lru-v1-1-853473d7b0da%40bytedance.com
patch subject: [PATCH 1/2] mm/zswap: global lru and shrinker shared by all zswap_pools
config: x86_64-randconfig-013-20240211 (https://download.01.org/0day-ci/archive/20240212/202402120226.TK7G37U9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120226.TK7G37U9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120226.TK7G37U9-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/zswap.c: In function 'zswap_shrinker_count':
>> mm/zswap.c:1300:42: error: 'pool' undeclared (first use in this function); did you mean 'zpool'?
    1300 |         nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
         |                                          ^~~~
         |                                          zpool
   mm/zswap.c:1300:42: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +1300 mm/zswap.c

b5ba474f3f5187 Nhat Pham      2023-11-30  1283  
b5ba474f3f5187 Nhat Pham      2023-11-30  1284  static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
b5ba474f3f5187 Nhat Pham      2023-11-30  1285  		struct shrink_control *sc)
b5ba474f3f5187 Nhat Pham      2023-11-30  1286  {
b5ba474f3f5187 Nhat Pham      2023-11-30  1287  	struct mem_cgroup *memcg = sc->memcg;
b5ba474f3f5187 Nhat Pham      2023-11-30  1288  	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
b5ba474f3f5187 Nhat Pham      2023-11-30  1289  	unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
b5ba474f3f5187 Nhat Pham      2023-11-30  1290  
501a06fe8e4c18 Nhat Pham      2023-12-07  1291  	if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
b5ba474f3f5187 Nhat Pham      2023-11-30  1292  		return 0;
b5ba474f3f5187 Nhat Pham      2023-11-30  1293  
b5ba474f3f5187 Nhat Pham      2023-11-30  1294  #ifdef CONFIG_MEMCG_KMEM
7d7ef0a4686abe Yosry Ahmed    2023-11-29  1295  	mem_cgroup_flush_stats(memcg);
b5ba474f3f5187 Nhat Pham      2023-11-30  1296  	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
b5ba474f3f5187 Nhat Pham      2023-11-30  1297  	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
b5ba474f3f5187 Nhat Pham      2023-11-30  1298  #else
b5ba474f3f5187 Nhat Pham      2023-11-30  1299  	/* use pool stats instead of memcg stats */
b5ba474f3f5187 Nhat Pham      2023-11-30 @1300  	nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
bf414d6ae81ba2 Chengming Zhou 2024-02-11  1301  	nr_stored = atomic_read(&zswap.nr_stored);
b5ba474f3f5187 Nhat Pham      2023-11-30  1302  #endif
b5ba474f3f5187 Nhat Pham      2023-11-30  1303  
b5ba474f3f5187 Nhat Pham      2023-11-30  1304  	if (!nr_stored)
b5ba474f3f5187 Nhat Pham      2023-11-30  1305  		return 0;
b5ba474f3f5187 Nhat Pham      2023-11-30  1306  
b5ba474f3f5187 Nhat Pham      2023-11-30  1307  	nr_protected =
b5ba474f3f5187 Nhat Pham      2023-11-30  1308  		atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
bf414d6ae81ba2 Chengming Zhou 2024-02-11  1309  	nr_freeable = list_lru_shrink_count(&zswap.list_lru, sc);
b5ba474f3f5187 Nhat Pham      2023-11-30  1310  	/*
b5ba474f3f5187 Nhat Pham      2023-11-30  1311  	 * Subtract the lru size by an estimate of the number of pages
b5ba474f3f5187 Nhat Pham      2023-11-30  1312  	 * that should be protected.
b5ba474f3f5187 Nhat Pham      2023-11-30  1313  	 */
b5ba474f3f5187 Nhat Pham      2023-11-30  1314  	nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
b5ba474f3f5187 Nhat Pham      2023-11-30  1315  
b5ba474f3f5187 Nhat Pham      2023-11-30  1316  	/*
b5ba474f3f5187 Nhat Pham      2023-11-30  1317  	 * Scale the number of freeable pages by the memory saving factor.
b5ba474f3f5187 Nhat Pham      2023-11-30  1318  	 * This ensures that the better zswap compresses memory, the fewer
b5ba474f3f5187 Nhat Pham      2023-11-30  1319  	 * pages we will evict to swap (as it will otherwise incur IO for
b5ba474f3f5187 Nhat Pham      2023-11-30  1320  	 * relatively small memory saving).
b5ba474f3f5187 Nhat Pham      2023-11-30  1321  	 */
b5ba474f3f5187 Nhat Pham      2023-11-30  1322  	return mult_frac(nr_freeable, nr_backing, nr_stored);
b5ba474f3f5187 Nhat Pham      2023-11-30  1323  }
b5ba474f3f5187 Nhat Pham      2023-11-30  1324  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

