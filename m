Return-Path: <linux-kernel+bounces-88102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331A86DD5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87E2286D9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63F6A343;
	Fri,  1 Mar 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFqgevnn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0B6A03C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282701; cv=none; b=TO/DZi8vhgz7FLQVgbwTT9HXoZ/6fyimsJBbNmeYjAGmYXRKFtajPo9MK6NDRANr9B59ZgxjtFXLaB2NGAmp+bC2F9lKxhuYS0wliZJwajH3vB3VS3j0gYSg+8YHfZAKYfhaCZzlsJ5u42l54QOgpIkNUu8BfuquyTf1ENNSK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282701; c=relaxed/simple;
	bh=7pjLmiG/8nf/MrZ8Ii/tmp+a66yW3du+qbUwi/OOCQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c7xpXkZNNHS+FYERD6Nj5ZAd1NF5DqHjYUOyZb+b6YqmS/vYT9LB9SxTx5WvtoTQdiOGiri40SRCiJTRBlmvOQnDTJO8Qg1uAZ7QmIQNhBd7fVo9CVndUHFX+HmbieI/zdDRrSS8zkjpj5nktAXJL+aQ6c3Kn1pOcgCPRP3SVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFqgevnn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709282698; x=1740818698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7pjLmiG/8nf/MrZ8Ii/tmp+a66yW3du+qbUwi/OOCQA=;
  b=PFqgevnnZTVTrLQJwRQE7uay9jNbZQqAcCuejB4qEK4aNAuwJJ2D8X2V
   I4FHG7VrRFT8bjjsNfJe9J22AoLYaA88XtAvFLtP2uc3sAnzQZSlkN10U
   BF7pNGBKCwhCzWFlNjvluwIoVF7R/0+I3ClIuiHBJkipTtUA6YLhSbpyv
   tb0+JG1ZQFPfHOOgD97wyDl3v85AxtbfvIKNYAG7k1rG1FGLRv+5VAyPC
   WVtwdEj141/cBL1w3jH3HKdVhnjSGs1TUvoMAWsE0MiDpcQALTxosdY5u
   iETXCZ/s+jtF3KG9DtEwE+5VSwCYdWkKbKdCSQy+40Qa7Ipx7Oq70Qp3o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6759787"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="6759787"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 00:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12731806"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2024 00:44:56 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfyVh-000Dg1-28;
	Fri, 01 Mar 2024 08:44:53 +0000
Date: Fri, 1 Mar 2024 16:44:26 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: include/linux/rcupdate.h:439:9: error: dereferencing pointer to
 incomplete type 'struct dpll_pin'
Message-ID: <202403011658.jcZIoLY9-lkp@intel.com>
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
commit: 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e dpll: rely on rcu for netdev_dpll_pin()
date:   3 days ago
config: i386-randconfig-141-20240228 (https://download.01.org/0day-ci/archive/20240301/202403011658.jcZIoLY9-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011658.jcZIoLY9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011658.jcZIoLY9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/radix-tree.h:18:0,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/energy_model.h:7,
                    from include/linux/device.h:16,
                    from drivers/dpll/dpll_core.c:11:
   include/linux/dpll.h: In function 'netdev_dpll_pin':
>> include/linux/rcupdate.h:439:9: error: dereferencing pointer to incomplete type 'struct dpll_pin'
     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
            ^
   include/linux/rcupdate.h:587:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rtnetlink.h:70:2: note: in expansion of macro 'rcu_dereference_check'
     rcu_dereference_check(p, lockdep_rtnl_is_held())
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dpll.h:175:9: note: in expansion of macro 'rcu_dereference_rtnl'
     return rcu_dereference_rtnl(dev->dpll_pin);
            ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/rbtree.h:24:0,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from net/core/rtnetlink.c:17:
   include/linux/dpll.h: In function 'netdev_dpll_pin':
>> include/linux/rcupdate.h:439:9: error: dereferencing pointer to incomplete type 'struct dpll_pin'
     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
            ^
   include/linux/rcupdate.h:587:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rtnetlink.h:70:2: note: in expansion of macro 'rcu_dereference_check'
     rcu_dereference_check(p, lockdep_rtnl_is_held())
     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/dpll.h:175:9: note: in expansion of macro 'rcu_dereference_rtnl'
     return rcu_dereference_rtnl(dev->dpll_pin);
            ^~~~~~~~~~~~~~~~~~~~
   In file included from net/core/rtnetlink.c:60:0:
   include/linux/dpll.h:179:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^


vim +439 include/linux/rcupdate.h

76c8eaafe4f061 Paul E. McKenney        2021-04-21  429  
24ba53017e188e Chun-Hung Tseng         2021-09-15  430  #define __rcu_access_pointer(p, local, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  431  ({ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  432  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  433) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  434  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  435  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  436  #define __rcu_dereference_check(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  437  ({ \
ac59853c06993a Pranith Kumar           2014-11-13  438  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15 @439  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  440  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  441) 	rcu_check_sparse(p, space); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  442  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  443  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  444  #define __rcu_dereference_protected(p, local, c, space) \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  445  ({ \
f78f5b90c4ffa5 Paul E. McKenney        2015-06-18  446  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad1 Joel Fernandes (Google  2018-12-12  447) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  448  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  449  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  450  #define __rcu_dereference_raw(p, local) \
995f1405610bd8 Paul E. McKenney        2016-07-01  451  ({ \
995f1405610bd8 Paul E. McKenney        2016-07-01  452  	/* Dependency order vs. p above. */ \
24ba53017e188e Chun-Hung Tseng         2021-09-15  453  	typeof(p) local = READ_ONCE(p); \
24ba53017e188e Chun-Hung Tseng         2021-09-15  454  	((typeof(*p) __force __kernel *)(local)); \
995f1405610bd8 Paul E. McKenney        2016-07-01  455  })
24ba53017e188e Chun-Hung Tseng         2021-09-15  456  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
ca5ecddfa8fcbd Paul E. McKenney        2010-04-28  457  

:::::: The code at line 439 was first introduced by commit
:::::: 24ba53017e188e031f9cb8b290286fad52d2af00 rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)

:::::: TO: Chun-Hung Tseng <henrybear327@gmail.com>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

