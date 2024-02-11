Return-Path: <linux-kernel+bounces-60966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E442850BBC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7786E1C21281
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B845F49D;
	Sun, 11 Feb 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWOlRobX"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E35F48C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707689182; cv=none; b=be+aSVSX5jtwm88nLnVNDKstpmNL+Wn4rw1kvpqqCFvq8bbOM9Sn5Fkg/qN/f6Sd7KMWmALwJ4xebtUXYPgGP0WjWKBaAEDoDSumsmTh3ov4Q6rCyPtsjHjLRk5+v4/+YexODvY2rqxrGqIbC7ho/dmp1l7bHsg4RMUUSKEjp+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707689182; c=relaxed/simple;
	bh=0lt0/3dAV6b4iKc8faBrQmffiQNwh2AB2q1QDWvfliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewjlzOEso/czpC0JzgkJhS/xRsMlWAzFQLySiyNj0isM90uIBbNWlpPsMOlm799mf/9kNmTMPHXOPwct3qncXbVHhFPbzgUC3O+2BF6bRqfxnfiW0D6EHBrU2v6POETUD2gm6Zk5VJgpyMfnFcsN8zI8JJR/tv6YQxNEZzep0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWOlRobX; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707689180; x=1739225180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0lt0/3dAV6b4iKc8faBrQmffiQNwh2AB2q1QDWvfliM=;
  b=VWOlRobXbFFEcM+YtcRvSYcvSIPo2fmZYQcv5zEnjGMOgYAU3XkcHm2r
   sn9GPGxnM0Yw57FLQc3Fcvpnn9kuUBP+d4vxXWtKmNVNapg4VUIEz2hxj
   L/sSrX/mbgyDVbWzITy8fQf4by6pw9+G2QOBlWhhrelQlKRL8rL7z3poH
   ag6fs0mMXAAGz4h0eFZG7Yc3UwIBfmtHIZeI0koqgG/YiY8uE5InHmLSx
   qjJ2kMExXj5GPhKuPpaNjQyUrfsXtmzHvTbvNj9sgkwNBP/4GWrdvEK9i
   1h7fmu8V9gBiQhhVXGHbHlc/gAW8Bx0V0wFqBaiqJSD4MMkwuWu4H7oiw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="436797322"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="436797322"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 14:06:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="7065558"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Feb 2024 14:06:17 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZHxn-0006mS-0j;
	Sun, 11 Feb 2024 22:06:15 +0000
Date: Mon, 12 Feb 2024 06:05:24 +0800
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
Message-ID: <202402120503.HRNkoWyq-lkp@intel.com>
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
config: i386-randconfig-054-20240212 (https://download.01.org/0day-ci/archive/20240212/202402120503.HRNkoWyq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120503.HRNkoWyq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120503.HRNkoWyq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/zswap.c:1300:35: error: use of undeclared identifier 'pool'
    1300 |         nr_backing = get_zswap_pool_size(pool) >> PAGE_SHIFT;
         |                                          ^
   1 error generated.


vim +/pool +1300 mm/zswap.c

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

