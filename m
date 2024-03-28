Return-Path: <linux-kernel+bounces-123551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA2890AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE07D1F25A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB74139CF0;
	Thu, 28 Mar 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWzLsXjE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2431130A4F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656985; cv=none; b=bt9+xBXCNyYJRldQsD/vo5BJ0yRHjyn0Ms1/OjpRpqP1BW7vibvXT6tZJYG81nADiXtzziJLV/+mUZWz8sxBWX17bKqPK99p5XkIpgAxvvlYmVWtiUYzQPcKPZpSbmZ60yEbPUo+81XIUKLIVEIAIDj/Gao1BsIZGYAwxrMRVXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656985; c=relaxed/simple;
	bh=EC6VsBfda2qZy3M5bvlbFWNuCxM4KPpfW4DqeiEZc28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oNF1SJvk5hfH3vCVu++z+7P/oQpuX+gd7TqdkUaZnzMPM2QZ1OS7dFROln6U9UrN7+q5+6KuPepbY2GOs/5P/XdEzoMUBKwNqt7qJoYhdIc57cw4tzK7VO9prYYh8hAu+b4CX1qVqtyn5Bn1X1H5TKhoY/8scSDM3LKriGAp+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWzLsXjE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711656984; x=1743192984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EC6VsBfda2qZy3M5bvlbFWNuCxM4KPpfW4DqeiEZc28=;
  b=PWzLsXjEiS2PYUymiXQHX0600J7Hk9Q88nvibAqZqvYVjnvcQ7uxbIah
   G/UwS2AxpjNFPQAmcahTjl9VpVowJD6rrXzVy4nElRaQAp3NMDw+NADgr
   BJJrYaburqEwzBRJx2qLJGqpZu6t/3ijvpxxuhmi6IIvGyOTV0jBcuz4e
   GEF3fOCwXiS74hs+sVo39vTwY3ULNHc3IgLKE852mDa3cYVrUXWbkEzLw
   pC7vwb/fiaynMK5WTSK1mso4vUTICEOEaqeWf4xMJKbeFGyIdygd4cSox
   rKHMcE2DRqVjoFJXV/YhvL3xvXta1gCut7vmkbEetP1qFUk8KiN83fqTk
   Q==;
X-CSE-ConnectionGUID: 8HkJB6a4QSClD8h2Dp5hSw==
X-CSE-MsgGUID: 2M7KIAXGTKy9370ywYPB4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9794306"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="9794306"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 13:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="54213940"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Mar 2024 13:16:21 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpwAd-0002Um-0L;
	Thu, 28 Mar 2024 20:16:19 +0000
Date: Fri, 29 Mar 2024 04:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:sched/core 16/16] kernel/sched/fair.c:9944: warning: Function
 parameter or struct member 'sg_overloaded' not described in
 'update_sg_lb_stats'
Message-ID: <202403290435.TuY2hUx3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   f322c65c648eac74cf1f13691a562a0738aa9e35
commit: f322c65c648eac74cf1f13691a562a0738aa9e35 [16/16] sched/balancing: Simplify the sg_status bitmask and use separate sg_overloaded and sg_overutilized flags
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240329/202403290435.TuY2hUx3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290435.TuY2hUx3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290435.TuY2hUx3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:9944: warning: Function parameter or struct member 'sg_overloaded' not described in 'update_sg_lb_stats'
>> kernel/sched/fair.c:9944: warning: Function parameter or struct member 'sg_overutilized' not described in 'update_sg_lb_stats'
>> kernel/sched/fair.c:9944: warning: Excess function parameter 'sg_status' description in 'update_sg_lb_stats'


vim +9944 kernel/sched/fair.c

c82a69629c53ed kernel/sched/fair.c Vincent Guittot  2022-07-08  9929  
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9930  /**
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9931   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
cd96891d48a945 kernel/sched/fair.c Randy Dunlap     2012-06-08  9932   * @env: The load balancing environment.
a315da5e686b02 kernel/sched/fair.c Randy Dunlap     2021-12-17  9933   * @sds: Load-balancing data with statistics of the local group.
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9934   * @group: sched_group whose statistics are to be updated.
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9935   * @sgs: variable to hold the statistics for this group.
630246a06ae2a7 kernel/sched/fair.c Quentin Perret   2018-12-03  9936   * @sg_status: Holds flag indicating the status of the sched_group
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9937   */
bd939f45da24e2 kernel/sched/fair.c Peter Zijlstra   2012-05-02  9938  static inline void update_sg_lb_stats(struct lb_env *env,
c0d14b57fe0c11 kernel/sched/fair.c Ricardo Neri     2021-09-10  9939  				      struct sd_lb_stats *sds,
630246a06ae2a7 kernel/sched/fair.c Quentin Perret   2018-12-03  9940  				      struct sched_group *group,
630246a06ae2a7 kernel/sched/fair.c Quentin Perret   2018-12-03  9941  				      struct sg_lb_stats *sgs,
f322c65c648eac kernel/sched/fair.c Ingo Molnar      2024-03-28  9942  				      bool *sg_overloaded,
f322c65c648eac kernel/sched/fair.c Ingo Molnar      2024-03-28  9943  				      bool *sg_overutilized)
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17 @9944  {
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot  2019-10-18  9945  	int i, nr_running, local_group;
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9946  
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra   2013-08-28  9947  	memset(sgs, 0, sizeof(*sgs));
b72ff13ce6021b kernel/sched/fair.c Peter Zijlstra   2013-08-28  9948  
c0d14b57fe0c11 kernel/sched/fair.c Ricardo Neri     2021-09-10  9949  	local_group = group == sds->local;
0b0695f2b34a4a kernel/sched/fair.c Vincent Guittot  2019-10-18  9950  
ae4df9d6c93510 kernel/sched/fair.c Peter Zijlstra   2017-05-01  9951  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9952  		struct rq *rq = cpu_rq(i);
c82a69629c53ed kernel/sched/fair.c Vincent Guittot  2022-07-08  9953  		unsigned long load = cpu_load(rq);
1e3c88bdeb1260 kernel/sched_fair.c Peter Zijlstra   2009-12-17  9954  
c82a69629c53ed kernel/sched/fair.c Vincent Guittot  2022-07-08  9955  		sgs->group_load += load;
82762d2af31a60 kernel/sched/fair.c Dietmar Eggemann 2021-11-18  9956  		sgs->group_util += cpu_util_cfs(i);
070f5e860ee2bf kernel/sched/fair.c Vincent Guittot  2020-02-24  9957  		sgs->group_runnable += cpu_runnable(rq);
a3498347030101 kernel/sched/fair.c Vincent Guittot  2019-10-18  9958  		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
4486edd12b5ac8 kernel/sched/fair.c Tim Chen         2014-06-23  9959  
a426f99c91d103 kernel/sched/fair.c Waiman Long      2015-11-25  9960  		nr_running = rq->nr_running;
5e23e474431529 kernel/sched/fair.c Vincent Guittot  2019-10-18  9961  		sgs->sum_nr_running += nr_running;
5e23e474431529 kernel/sched/fair.c Vincent Guittot  2019-10-18  9962  
a426f99c91d103 kernel/sched/fair.c Waiman Long      2015-11-25  9963  		if (nr_running > 1)
f322c65c648eac kernel/sched/fair.c Ingo Molnar      2024-03-28  9964  			*sg_overloaded = 1;
4486edd12b5ac8 kernel/sched/fair.c Tim Chen         2014-06-23  9965  
2802bf3cd936fe kernel/sched/fair.c Morten Rasmussen 2018-12-03  9966  		if (cpu_overutilized(i))
f322c65c648eac kernel/sched/fair.c Ingo Molnar      2024-03-28  9967  			*sg_overutilized = 1;
4486edd12b5ac8 kernel/sched/fair.c Tim Chen         2014-06-23  9968  

:::::: The code at line 9944 was first introduced by commit
:::::: 1e3c88bdeb1260edc341e45c9fb8efd182a5c511 sched: Move load balance code into sched_fair.c

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

