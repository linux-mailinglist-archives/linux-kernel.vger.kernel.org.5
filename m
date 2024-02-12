Return-Path: <linux-kernel+bounces-61090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0963850D22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565CB1F22E83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623D538D;
	Mon, 12 Feb 2024 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv6hoCUm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A4694
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707711391; cv=none; b=Tn5h9txg+z9uTJHNwg6581R6u/XW5rvNOcm+N6/UYYh6IFeor5za4fbIWqt+b/iM7V/cvbT+/h0AuZmRvOCiB10gxFBKyhYHJ1z99thWOXxhJJCel0DQkAX67+imuy21omHslW5LRWpRqYyTSw4IlhP8rA484b2xFmjWNR4ZzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707711391; c=relaxed/simple;
	bh=cNv6wmO4uE87B+19zl8R1jip/GvDeTUusFtUmHEueRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkyU++KnMgKC4vJdJlkufy+VsrStax5Wec4XgpW1LsGn2zLXhRAhE+MNpOfV+ox69YRR1wQ7JEgdmbP0x9bKeyo/7dENKwoVWRBNl4PQSc5AWHYyaNzdVAHl8WPjqWJYPAyUAl1kxSOwjT7Kxz7FdkVq8e5Wq3QqdtKEkZ8l8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lv6hoCUm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707711390; x=1739247390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cNv6wmO4uE87B+19zl8R1jip/GvDeTUusFtUmHEueRw=;
  b=lv6hoCUmhqoVp6j6ToSu4C2lNusfgnuKZu6ICn5sHducVJhPAhsXwaz4
   excqV5B0Hyiu7jyGh7AnUbCMD2ONzp0FEqGONv01ws0N1sxrzsZOpZ4S5
   jj3Sq2VaskJWplYaUlzyIoe5GiG9leifGBoChU4v3YhMa1njH49AcZbTS
   vrpK0JCoy7kcvGcucY+rGKFvecH7xmCaE0qCZ4ofEla08af2TCcrVfRxT
   bVyKKzzINHg35HkGsmYcrlWlURoPYgRmhFKJfXTrBvrZ+yN7b0hwABh7M
   kqfU11Rti0E1IzBFUxBLme09JIuC3U5yh36xPoPhcE73E5rc+aGQzin+q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1529015"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1529015"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 20:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2790849"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2024 20:16:28 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZNk1-0006ug-2A;
	Mon, 12 Feb 2024 04:16:25 +0000
Date: Mon, 12 Feb 2024 12:15:58 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v4 03/35] include: reduce header dependencies by using
 "*_types.h"
Message-ID: <202402121235.LLT92dIZ-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240212-072756
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211231518.349442-4-max.kellermann%40ionos.com
patch subject: [PATCH v4 03/35] include: reduce header dependencies by using "*_types.h"
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240212/202402121235.LLT92dIZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402121235.LLT92dIZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402121235.LLT92dIZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/flex_proportions.h:11,
                    from lib/flex_proportions.c:36:
   include/linux/percpu_counter.h: In function 'percpu_counter_add':
   include/linux/percpu_counter.h:191:9: error: implicit declaration of function 'local_irq_save' [-Werror=implicit-function-declaration]
     191 |         local_irq_save(flags);
         |         ^~~~~~~~~~~~~~
   include/linux/percpu_counter.h:193:9: error: implicit declaration of function 'local_irq_restore' [-Werror=implicit-function-declaration]
     193 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/percpu_counter.h:191:9: warning: 'flags' is used uninitialized [-Wuninitialized]
     191 |         local_irq_save(flags);
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu_counter.h:189:23: note: 'flags' was declared here
     189 |         unsigned long flags;
         |                       ^~~~~
   cc1: some warnings being treated as errors


vim +/flags +191 include/linux/percpu_counter.h

80188b0d77d742 Dave Chinner   2015-05-29  185  
^1da177e4c3f41 Linus Torvalds 2005-04-16  186  static inline void
20e89767096392 Peter Zijlstra 2007-10-16  187  percpu_counter_add(struct percpu_counter *fbc, s64 amount)
^1da177e4c3f41 Linus Torvalds 2005-04-16  188  {
88ad32a799ddc9 Manfred Spraul 2022-12-16  189  	unsigned long flags;
88ad32a799ddc9 Manfred Spraul 2022-12-16  190  
88ad32a799ddc9 Manfred Spraul 2022-12-16 @191  	local_irq_save(flags);
^1da177e4c3f41 Linus Torvalds 2005-04-16  192  	fbc->count += amount;
88ad32a799ddc9 Manfred Spraul 2022-12-16  193  	local_irq_restore(flags);
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  195  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

