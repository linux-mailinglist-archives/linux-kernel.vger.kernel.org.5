Return-Path: <linux-kernel+bounces-51575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4E848CB0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B341C21A35
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902E1B592;
	Sun,  4 Feb 2024 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsdGf1Ge"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA991B598
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707041726; cv=none; b=mTjbRXLpjC1GrdgnzrmZXrxThi5v2Gnb7RUYaFt0sx8nV5K3+YBjN64+SNXxk4euN0mpfx2WiUF/PFMeYroSwfE1K+NmKoDXsgzEYCx4t8OP92XW9WqdwYzy45JnPt+HK4Eqjvs5mzJAFpbp0Z2B8KF3DTJcD3kJYTbSD6vTDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707041726; c=relaxed/simple;
	bh=J1IJekIv2g4l/4cGH0z6H/to6TdkZ7VEOP1OcZEfTSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZEvU3d18muXC8T7i4fzgcpz325+8mXumfK8uS88dGoXrKuBfmJougwApb9GzJzXCysY67FdF5PwzHLnEz+1qilGPCGxoSVrFy3zYd9H/sWIilIMpgfO2gSHj5yERD5Q3MHtzUjYman5YR60GIlHau7WsyI563R1Y4H2t3GDgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsdGf1Ge; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707041724; x=1738577724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1IJekIv2g4l/4cGH0z6H/to6TdkZ7VEOP1OcZEfTSY=;
  b=nsdGf1GeGOaSyVhqHkold4HbFiJpGj3KD8Qh8hy3f5gpb6xWPtGaxRyO
   ATz4vriT+3F6tACDwqvdysuI3XroJuqFsWBw5ITgYlm5xTkg8YT6aD2sT
   6DtdtIN32bhnticQ+WpZMLOc8U6gb9EDaoeaosBhFl9OEZaTGSLcQ9PgK
   k88B4wQkYOixL2piMxx0JmFRuH0kKry3BJIONGBmvmxcjcfhwibmGMkdG
   1F27k0dITGHnpt+y9EmS7FKYNxoZO6JRxrHlSj/qIIaVSxPnioeQ47+P5
   ZuGW6mimYyJJ9ETRR4UAKxhYOYiuoaVYMkP+G/xibP511gndXGhm4fCzz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="534205"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="534205"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 02:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="759713"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2024 02:15:20 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWZWw-0006EQ-0K;
	Sun, 04 Feb 2024 10:15:18 +0000
Date: Sun, 4 Feb 2024 18:15:11 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH-wq v2 3/5] workqueue: Thaw frozen pwq in
 workqueue_apply_unbound_cpumask()
Message-ID: <202402041854.YeHAF3wV-lkp@intel.com>
References: <20240203154334.791910-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203154334.791910-4-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tj-wq/for-next]
[also build test WARNING on next-20240202]
[cannot apply to linus/master v6.8-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/workqueue-Skip-__WQ_DESTROYING-workqueues-when-updating-global-unbound-cpumask/20240203-234626
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20240203154334.791910-4-longman%40redhat.com
patch subject: [PATCH-wq v2 3/5] workqueue: Thaw frozen pwq in workqueue_apply_unbound_cpumask()
config: x86_64-randconfig-122-20240204 (https://download.01.org/0day-ci/archive/20240204/202402041854.YeHAF3wV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041854.YeHAF3wV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041854.YeHAF3wV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/workqueue.c:361:40: sparse: sparse: duplicate [noderef]
   kernel/workqueue.c:361:40: sparse: sparse: multiple address spaces given: __percpu & __rcu
>> kernel/workqueue.c:6373:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/workqueue.c:6373:25: sparse:    struct pool_workqueue *
   kernel/workqueue.c:6373:25: sparse:    struct pool_workqueue [noderef] __rcu *

vim +6373 kernel/workqueue.c

  6356	
  6357	/*
  6358	 * Check the given ordered workqueue to see if its non-default pwq's have
  6359	 * zero reference count and if so thaw the frozen default pwq.
  6360	 *
  6361	 * Return:
  6362	 * %true if dfl_pwq has been thawed or %false otherwise.
  6363	 */
  6364	static bool ordered_workqueue_ref_check(struct workqueue_struct *wq)
  6365	{
  6366		int refs = 0;
  6367		struct pool_workqueue *pwq;
  6368	
  6369		if (!READ_ONCE(wq->dfl_pwq->frozen))
  6370			return true;
  6371		mutex_lock(&wq->mutex);
  6372		for_each_pwq(pwq, wq) {
> 6373			if (pwq == wq->dfl_pwq)
  6374				continue;
  6375			refs += pwq->refcnt;
  6376		}
  6377		if (!refs)
  6378			thaw_pwq(wq->dfl_pwq);
  6379		mutex_unlock(&wq->mutex);
  6380		return !refs;
  6381	}
  6382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

