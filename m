Return-Path: <linux-kernel+bounces-61563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C38513B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197D6B25B34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE639FF2;
	Mon, 12 Feb 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhAr2a1z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E23611B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741733; cv=none; b=G6HoIp9GexXfQKnuecajkauWvw9mPAVfDGrJn/rvnNHAF30z5NpCNiZJcsFy693Uw4Oxaoudblyzxa5XRYmJh0Bo7T97M+9hx0YLn1ktGXhPTZotwoEJDuJ7p0Mftqi0b0TEb1TkXYnaQ/fJwWVNSqHqrX5jMgRqB/Y6tQ1+7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741733; c=relaxed/simple;
	bh=8ahY7c+eV6OLZtiYet7sguCFreXtMvOFOJFoSm+eyWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slYS5neo0ESyYfraZtp0z8WNJJ2uiMMuyQ8FYoqtZEbmmw7JT++yFrLXvIOneVK58JkJ3X492xmLnPNE9sjXbyygvgrOb/VNOmhq+rAchL982Xh0Q+hN9I280N4UvBQVY7YczdfOtqzoaPzITm02LalFBEFFP7Ybb/bcudzl9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhAr2a1z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707741732; x=1739277732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ahY7c+eV6OLZtiYet7sguCFreXtMvOFOJFoSm+eyWA=;
  b=OhAr2a1zudDe+srQcMEyPrqoTBqF8itN2WXhYZ2j8dlkBkcmppr2a8nu
   bx0uWEwVGRbSSFWxyZKbB9B02r5nf+SGxxceVJx3wqUB6vCOMgA7pzqMA
   ZCG/hgGfXSr6m76S0bdhQ95TA+dnjmtOhe+zZAM3GsTtIUpQJ9XtgAZ8m
   Ipf1/XuktPhwjVtsxi+7sOfgMDlfujw6FiO8O6qjKlswh9KBChhumLX73
   nsi3rujMHK/XjA4FHr7UP56OlOupciyUI3OmpiUIVu0o+HTZmpmGd+XLa
   hNJoYIOqH6YmsPkqc/is8sZBJprKvE7OnVQGT5nyis1MMXMjiuJIzzU/x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1868509"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1868509"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="7209497"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2024 04:42:09 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZVdO-000780-2d;
	Mon, 12 Feb 2024 12:42:06 +0000
Date: Mon, 12 Feb 2024 20:41:15 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v4 02/35] include: remove unnecessary #include directives
Message-ID: <202402122015.7dytzCz3-lkp@intel.com>
References: <20240211231518.349442-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211231518.349442-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240212-072756
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211231518.349442-3-max.kellermann%40ionos.com
patch subject: [PATCH v4 02/35] include: remove unnecessary #include directives
config: arm-randconfig-004-20240212 (https://download.01.org/0day-ci/archive/20240212/202402122015.7dytzCz3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402122015.7dytzCz3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402122015.7dytzCz3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/drm_modeset_lock.c:87:6: error: call to undeclared function 'stack_trace_save'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      87 |         n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
         |             ^
   drivers/gpu/drm/drm_modeset_lock.c:87:6: note: did you mean 'stack_depot_save'?
   include/linux/stackdepot.h:132:22: note: 'stack_depot_save' declared here
     132 | depot_stack_handle_t stack_depot_save(unsigned long *entries,
         |                      ^
>> drivers/gpu/drm/drm_modeset_lock.c:104:2: error: call to undeclared function 'stack_trace_snprint'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     104 |         stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 2);
         |         ^
   drivers/gpu/drm/drm_modeset_lock.c:104:2: note: did you mean 'stack_depot_snprint'?
   include/linux/stackdepot.h:163:5: note: 'stack_depot_snprint' declared here
     163 | int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
         |     ^
   2 errors generated.


vim +/stack_trace_save +87 drivers/gpu/drm/drm_modeset_lock.c

35cf03508d8466 Rob Clark        2016-11-14   80  
cd06ab2fd48f2c Jani Nikula      2021-10-01   81  #if IS_ENABLED(CONFIG_DRM_DEBUG_MODESET_LOCK)
bcae3af286f49b Stephen Rothwell 2021-10-18   82  static noinline depot_stack_handle_t __drm_stack_depot_save(void)
cd06ab2fd48f2c Jani Nikula      2021-10-01   83  {
cd06ab2fd48f2c Jani Nikula      2021-10-01   84  	unsigned long entries[8];
cd06ab2fd48f2c Jani Nikula      2021-10-01   85  	unsigned int n;
cd06ab2fd48f2c Jani Nikula      2021-10-01   86  
cd06ab2fd48f2c Jani Nikula      2021-10-01  @87  	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
cd06ab2fd48f2c Jani Nikula      2021-10-01   88  
cd06ab2fd48f2c Jani Nikula      2021-10-01   89  	return stack_depot_save(entries, n, GFP_NOWAIT | __GFP_NOWARN);
cd06ab2fd48f2c Jani Nikula      2021-10-01   90  }
cd06ab2fd48f2c Jani Nikula      2021-10-01   91  
bcae3af286f49b Stephen Rothwell 2021-10-18   92  static void __drm_stack_depot_print(depot_stack_handle_t stack_depot)
cd06ab2fd48f2c Jani Nikula      2021-10-01   93  {
cd06ab2fd48f2c Jani Nikula      2021-10-01   94  	struct drm_printer p = drm_debug_printer("drm_modeset_lock");
cd06ab2fd48f2c Jani Nikula      2021-10-01   95  	unsigned long *entries;
cd06ab2fd48f2c Jani Nikula      2021-10-01   96  	unsigned int nr_entries;
cd06ab2fd48f2c Jani Nikula      2021-10-01   97  	char *buf;
cd06ab2fd48f2c Jani Nikula      2021-10-01   98  
cd06ab2fd48f2c Jani Nikula      2021-10-01   99  	buf = kmalloc(PAGE_SIZE, GFP_NOWAIT | __GFP_NOWARN);
cd06ab2fd48f2c Jani Nikula      2021-10-01  100  	if (!buf)
cd06ab2fd48f2c Jani Nikula      2021-10-01  101  		return;
cd06ab2fd48f2c Jani Nikula      2021-10-01  102  
cd06ab2fd48f2c Jani Nikula      2021-10-01  103  	nr_entries = stack_depot_fetch(stack_depot, &entries);
cd06ab2fd48f2c Jani Nikula      2021-10-01 @104  	stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 2);
cd06ab2fd48f2c Jani Nikula      2021-10-01  105  
cd06ab2fd48f2c Jani Nikula      2021-10-01  106  	drm_printf(&p, "attempting to lock a contended lock without backoff:\n%s", buf);
cd06ab2fd48f2c Jani Nikula      2021-10-01  107  
cd06ab2fd48f2c Jani Nikula      2021-10-01  108  	kfree(buf);
cd06ab2fd48f2c Jani Nikula      2021-10-01  109  }
2dba5eb1c73b6b Vlastimil Babka  2022-01-21  110  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

