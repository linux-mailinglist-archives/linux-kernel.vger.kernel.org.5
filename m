Return-Path: <linux-kernel+bounces-50735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0C847D69
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7001C225BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785D12D750;
	Fri,  2 Feb 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym6gwuRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C917F4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706918323; cv=none; b=AXnZgD9Jj9KnQXfwBMF9M4V3WWNCG+rDuJW1pcEbcfcfnuBWAaZ7xpWG5lw4H1GqKV06KcAUb7O3NZFh+bQvyml3oC2G90hgktzZPt4AlmWjIOexnmA39PnUdHpbNXNAAJA6F2a9PIt/Hg27kggDyESsrkyClWjyMsFBUiwhj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706918323; c=relaxed/simple;
	bh=zYoO7Wdoe+eIO/LyIAPkIFAZg398b2C1GJUJEJ0a+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpy7fePfXe7pMUJaV/W7KvT9tn7R5ojtJEQAk0KyJWFONMhqjEgZ4VqOqU63rqEt632k5BeHm65gek8JKZLQFnm3psY9Ng12mYeWmRRdkB7ZVOLv+YEmH/4g2+ihe2pr9LwaZ1JMp7Wx5vUpv761i+snjRi4638kampuJtoaRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym6gwuRz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706918321; x=1738454321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYoO7Wdoe+eIO/LyIAPkIFAZg398b2C1GJUJEJ0a+AE=;
  b=Ym6gwuRzFNc5mxP9lLUoXnidGK5mJO8MTMMzyYxMHI2NjL2BMxFqWjFQ
   L1SgWDo7rKqWWFRXOwxBjcPsm/9YOtwUWyOT4N/zwDppHY6h3cJmAIR6J
   QkE2SxM4UFEFyUuwRd7dWYnSZuYp5x76JD6EbtYiYGlyo19YAOsH4aAYW
   iIFALSE3P2f9zCjraxaVmHk3oTwbn7uWjVIk6W0StKg7RSY+bPROggEnV
   qhZnPSYhhJAqRWlDZNnRXPfyDL5TiE1vPCQNhnbpVzBEAaRBsQPiWrFlS
   Y2drKM/Se4bOXXRa4lVD8EvGMCUdqHmTMWZbhJ2XxXOw/+TzhFZ+8D4g9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="172888"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="172888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 15:58:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="494891"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 02 Feb 2024 15:58:39 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW3QZ-0004Py-2N;
	Fri, 02 Feb 2024 23:58:35 +0000
Date: Sat, 3 Feb 2024 07:58:33 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH 16/28] device.h: move declarations to device_types.h
Message-ID: <202402030708.WgadrfjA-lkp@intel.com>
References: <20240131145008.1345531-17-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131145008.1345531-17-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240131]
[cannot apply to mkp-scsi/for-next jejb-scsi/for-next axboe-block/for-next linus/master v6.8-rc2 v6.8-rc1 v6.7 v6.8-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240131-231042
base:   next-20240131
patch link:    https://lore.kernel.org/r/20240131145008.1345531-17-max.kellermann%40ionos.com
patch subject: [PATCH 16/28] device.h: move declarations to device_types.h
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240203/202402030708.WgadrfjA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030708.WgadrfjA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030708.WgadrfjA-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                                                    ^~~~~
   mm/slub.c:6327:14: error: 'slabs' undeclared here (not in a function); did you mean 'slab'?
    6327 | SLAB_ATTR_RO(slabs);
         |              ^~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6333:14: error: 'total_objects' undeclared here (not in a function); did you mean 'oo_objects'?
    6333 | SLAB_ATTR_RO(total_objects);
         |              ^~~~~~~~~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6339:14: error: 'objects' undeclared here (not in a function); did you mean 'kobject'?
    6339 | SLAB_ATTR_RO(objects);
         |              ^~~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6345:14: error: 'sanity_checks' undeclared here (not in a function); did you mean 'sanity_checks_attr'?
    6345 | SLAB_ATTR_RO(sanity_checks);
         |              ^~~~~~~~~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6132:53: error: invalid initializer
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                     ^~~~~~~~~~~~~~
   mm/slub.c:6351:1: note: in expansion of macro 'SLAB_ATTR_RO'
    6351 | SLAB_ATTR_RO(trace);
         | ^~~~~~~~~~~~
   mm/slub.c:6358:14: error: 'red_zone' undeclared here (not in a function)
    6358 | SLAB_ATTR_RO(red_zone);
         |              ^~~~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6365:14: error: 'poison' undeclared here (not in a function)
    6365 | SLAB_ATTR_RO(poison);
         |              ^~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6372:14: error: 'store_user' undeclared here (not in a function); did you mean 'pte_user'?
    6372 | SLAB_ATTR_RO(store_user);
         |              ^~~~~~~~~~
   mm/slub.c:6132:68: note: in definition of macro 'SLAB_ATTR_RO'
    6132 |         static struct slab_attribute _name##_attr = __ATTR_RO_MODE(_name, 0400)
         |                                                                    ^~~~~
   mm/slub.c:6391:11: error: 'validate' undeclared here (not in a function); did you mean 'key_validate'?
    6391 | SLAB_ATTR(validate);
         |           ^~~~~~~~
   mm/slub.c:6135:68: note: in definition of macro 'SLAB_ATTR'
    6135 |         static struct slab_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)
         |                                                                    ^~~~~
   mm/slub.c:6431:11: error: 'shrink' undeclared here (not in a function); did you mean 'shrinker'?
    6431 | SLAB_ATTR(shrink);
         |           ^~~~~~
   mm/slub.c:6135:68: note: in definition of macro 'SLAB_ATTR'
    6135 |         static struct slab_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)
         |                                                                    ^~~~~
   mm/slub.c:6455:11: error: 'remote_node_defrag_ratio' undeclared here (not in a function); did you mean 'remote_node_defrag_ratio_attr'?
    6455 | SLAB_ATTR(remote_node_defrag_ratio);
         |           ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/slub.c:6135:68: note: in definition of macro 'SLAB_ATTR'
    6135 |         static struct slab_attribute _name##_attr = __ATTR_RW_MODE(_name, 0600)
         |                                                                    ^~~~~
   mm/slub.c:6682:21: error: variable 'slab_sysfs_ops' has initializer but incomplete type
    6682 | static const struct sysfs_ops slab_sysfs_ops = {
         |                     ^~~~~~~~~
   mm/slub.c:6683:10: error: 'const struct sysfs_ops' has no member named 'show'
    6683 |         .show = slab_attr_show,
         |          ^~~~
   mm/slub.c:6683:17: warning: excess elements in struct initializer
    6683 |         .show = slab_attr_show,
         |                 ^~~~~~~~~~~~~~
   mm/slub.c:6683:17: note: (near initialization for 'slab_sysfs_ops')
   mm/slub.c:6684:10: error: 'const struct sysfs_ops' has no member named 'store'
    6684 |         .store = slab_attr_store,
         |          ^~~~~
   mm/slub.c:6684:18: warning: excess elements in struct initializer
    6684 |         .store = slab_attr_store,
         |                  ^~~~~~~~~~~~~~~
   mm/slub.c:6684:18: note: (near initialization for 'slab_sysfs_ops')
   mm/slub.c: In function 'sysfs_slab_add':
   mm/slub.c:6760:17: error: implicit declaration of function 'sysfs_remove_link' [-Werror=implicit-function-declaration]
    6760 |                 sysfs_remove_link(&slab_kset->kobj, s->name);
         |                 ^~~~~~~~~~~~~~~~~
   mm/slub.c:6777:15: error: implicit declaration of function 'sysfs_create_group' [-Werror=implicit-function-declaration]
    6777 |         err = sysfs_create_group(&s->kobj, &slab_attr_group);
         |               ^~~~~~~~~~~~~~~~~~
   mm/slub.c: In function 'sysfs_slab_alias':
   mm/slub.c:6827:24: error: implicit declaration of function 'sysfs_create_link'; did you mean 'kernfs_create_link'? [-Werror=implicit-function-declaration]
    6827 |                 return sysfs_create_link(&slab_kset->kobj, &s->kobj, name);
         |                        ^~~~~~~~~~~~~~~~~
         |                        kernfs_create_link
   mm/slub.c: At top level:
   mm/slub.c:6682:31: error: storage size of 'slab_sysfs_ops' isn't known
    6682 | static const struct sysfs_ops slab_sysfs_ops = {
         |                               ^~~~~~~~~~~~~~
>> mm/slub.c:6439:16: warning: 'remote_node_defrag_ratio_store' defined but not used [-Wunused-function]
    6439 | static ssize_t remote_node_defrag_ratio_store(struct kmem_cache *s,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/slub.c:6434:16: warning: 'remote_node_defrag_ratio_show' defined but not used [-Wunused-function]
    6434 | static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/slub.c:6422:16: warning: 'shrink_store' defined but not used [-Wunused-function]
    6422 | static ssize_t shrink_store(struct kmem_cache *s,
         |                ^~~~~~~~~~~~
   mm/slub.c:6417:16: warning: 'shrink_show' defined but not used [-Wunused-function]
    6417 | static ssize_t shrink_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~
   mm/slub.c:6379:16: warning: 'validate_store' defined but not used [-Wunused-function]
    6379 | static ssize_t validate_store(struct kmem_cache *s,
         |                ^~~~~~~~~~~~~~
   mm/slub.c:6374:16: warning: 'validate_show' defined but not used [-Wunused-function]
    6374 | static ssize_t validate_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~
   mm/slub.c:6367:16: warning: 'store_user_show' defined but not used [-Wunused-function]
    6367 | static ssize_t store_user_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~
   mm/slub.c:6360:16: warning: 'poison_show' defined but not used [-Wunused-function]
    6360 | static ssize_t poison_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~
   mm/slub.c:6353:16: warning: 'red_zone_show' defined but not used [-Wunused-function]
    6353 | static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~
   mm/slub.c:6347:16: warning: 'trace_show' defined but not used [-Wunused-function]
    6347 | static ssize_t trace_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~
   mm/slub.c:6341:16: warning: 'sanity_checks_show' defined but not used [-Wunused-function]
    6341 | static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~
   mm/slub.c:6335:16: warning: 'objects_show' defined but not used [-Wunused-function]
    6335 | static ssize_t objects_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~
   mm/slub.c:6329:16: warning: 'total_objects_show' defined but not used [-Wunused-function]
    6329 | static ssize_t total_objects_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~
   mm/slub.c:6323:16: warning: 'slabs_show' defined but not used [-Wunused-function]
    6323 | static ssize_t slabs_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~
   mm/slub.c:6316:16: warning: 'destroy_by_rcu_show' defined but not used [-Wunused-function]
    6316 | static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~~
   mm/slub.c:6301:16: warning: 'cache_dma_show' defined but not used [-Wunused-function]
    6301 | static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~
   mm/slub.c:6294:16: warning: 'hwcache_align_show' defined but not used [-Wunused-function]
    6294 | static ssize_t hwcache_align_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~
   mm/slub.c:6288:16: warning: 'reclaim_account_show' defined but not used [-Wunused-function]
    6288 | static ssize_t reclaim_account_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~~~
   mm/slub.c:6247:16: warning: 'slabs_cpu_partial_show' defined but not used [-Wunused-function]
    6247 | static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~~~~~
   mm/slub.c:6241:16: warning: 'objects_partial_show' defined but not used [-Wunused-function]
    6241 | static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~~~
   mm/slub.c:6235:16: warning: 'cpu_slabs_show' defined but not used [-Wunused-function]
    6235 | static ssize_t cpu_slabs_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~
   mm/slub.c:6229:16: warning: 'partial_show' defined but not used [-Wunused-function]
    6229 | static ssize_t partial_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~
   mm/slub.c:6223:16: warning: 'aliases_show' defined but not used [-Wunused-function]
    6223 | static ssize_t aliases_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~
   mm/slub.c:6215:16: warning: 'ctor_show' defined but not used [-Wunused-function]
    6215 | static ssize_t ctor_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~
   mm/slub.c:6197:16: warning: 'cpu_partial_store' defined but not used [-Wunused-function]
    6197 | static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
         |                ^~~~~~~~~~~~~~~~~
   mm/slub.c:6187:16: warning: 'cpu_partial_show' defined but not used [-Wunused-function]
    6187 | static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~
   mm/slub.c:6172:16: warning: 'min_partial_store' defined but not used [-Wunused-function]
    6172 | static ssize_t min_partial_store(struct kmem_cache *s, const char *buf,
         |                ^~~~~~~~~~~~~~~~~
   mm/slub.c:6167:16: warning: 'min_partial_show' defined but not used [-Wunused-function]
    6167 | static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~
   mm/slub.c:6161:16: warning: 'order_show' defined but not used [-Wunused-function]
    6161 | static ssize_t order_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~
   mm/slub.c:6155:16: warning: 'objs_per_slab_show' defined but not used [-Wunused-function]
    6155 | static ssize_t objs_per_slab_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~~~
   mm/slub.c:6149:16: warning: 'object_size_show' defined but not used [-Wunused-function]
    6149 | static ssize_t object_size_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~~~
   mm/slub.c:6143:16: warning: 'align_show' defined but not used [-Wunused-function]
    6143 | static ssize_t align_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~
   mm/slub.c:6137:16: warning: 'slab_size_show' defined but not used [-Wunused-function]
    6137 | static ssize_t slab_size_show(struct kmem_cache *s, char *buf)
         |                ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/remote_node_defrag_ratio_store +6439 mm/slub.c

2086d26a05a4b5 Christoph Lameter 2007-05-06  6432  
81819f0fc8285a Christoph Lameter 2007-05-06  6433  #ifdef CONFIG_NUMA
9824601ead957a Christoph Lameter 2008-01-07 @6434  static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
81819f0fc8285a Christoph Lameter 2007-05-06  6435  {
bf16d19aabd8f5 Joe Perches       2020-12-14  6436  	return sysfs_emit(buf, "%u\n", s->remote_node_defrag_ratio / 10);
81819f0fc8285a Christoph Lameter 2007-05-06  6437  }
81819f0fc8285a Christoph Lameter 2007-05-06  6438  
9824601ead957a Christoph Lameter 2008-01-07 @6439  static ssize_t remote_node_defrag_ratio_store(struct kmem_cache *s,
81819f0fc8285a Christoph Lameter 2007-05-06  6440  				const char *buf, size_t length)
81819f0fc8285a Christoph Lameter 2007-05-06  6441  {
eb7235eb842043 Alexey Dobriyan   2018-04-05  6442  	unsigned int ratio;
0121c619d03820 Christoph Lameter 2008-04-29  6443  	int err;
0121c619d03820 Christoph Lameter 2008-04-29  6444  
eb7235eb842043 Alexey Dobriyan   2018-04-05  6445  	err = kstrtouint(buf, 10, &ratio);
0121c619d03820 Christoph Lameter 2008-04-29  6446  	if (err)
0121c619d03820 Christoph Lameter 2008-04-29  6447  		return err;
eb7235eb842043 Alexey Dobriyan   2018-04-05  6448  	if (ratio > 100)
eb7235eb842043 Alexey Dobriyan   2018-04-05  6449  		return -ERANGE;
0121c619d03820 Christoph Lameter 2008-04-29  6450  
0121c619d03820 Christoph Lameter 2008-04-29  6451  	s->remote_node_defrag_ratio = ratio * 10;
81819f0fc8285a Christoph Lameter 2007-05-06  6452  
81819f0fc8285a Christoph Lameter 2007-05-06  6453  	return length;
81819f0fc8285a Christoph Lameter 2007-05-06  6454  }
9824601ead957a Christoph Lameter 2008-01-07  6455  SLAB_ATTR(remote_node_defrag_ratio);
81819f0fc8285a Christoph Lameter 2007-05-06  6456  #endif
81819f0fc8285a Christoph Lameter 2007-05-06  6457  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

