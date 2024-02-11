Return-Path: <linux-kernel+bounces-60876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D33850A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ED91C2196A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587C5C8FB;
	Sun, 11 Feb 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnMdUuYp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D25C611
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671826; cv=none; b=tfkK6TZJtiIWU7ovr5IYWFeU81+YW746Lve2x7h8zisdcXqJITdFCHhY+xHVkW6bC3R5YjxCdAv7HuTrBTuHTY9jcwlFg9hNy6nLo7aMwZCONoRhVNhi/nLQD66xnF6j/N0ZHiJVlSXE/O6FCCrURksIduHqIDM1l1sc0YAcBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671826; c=relaxed/simple;
	bh=RLdQ20m3STopFisb1+bwMISsfKLUG83g3BUFt2Xbrvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMS0ALzxYlNkdeCC25EeAXRpqms2iMbouLtTIRzuDcCaaGEuCs2rrUHB0xLa6Z/sF6tnCL+3jSjJIMun+tgUnTCZbNLDhvv5LVPJ+L3+pmZmGg9+nYXEfnmPYX/4v2GOXNKoPQMH0tD1swd6biCHcK+Xbi+c78bXz3BQ/EPHw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnMdUuYp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707671825; x=1739207825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLdQ20m3STopFisb1+bwMISsfKLUG83g3BUFt2Xbrvs=;
  b=EnMdUuYplsSf2EZpfUAcmKiLSu5s1sDTXZJk88+9bLvGjljS/IvO9rVf
   RGEWJPGAn0P0y5f79Hrc4Eo+sknNiieW109qlDrtJ/jtbHBz+nf4ZVVC4
   TrJJLodps2tnoaf51BiKGUW1VoN2XUigbBcMcMUV8XKa7C7QCf10D7zBd
   x8mYfyBrOpsNHDxSahMqOBzT3+ziPkx8c0PHBkY9MBxNXFcl+XuFb9BfD
   fzn9W/8MLSwBBagqdzeM7CAhLUA9PPCnF1rYSSeIRaeT3Y82A4hdfqWdX
   jWjno6+kfDg1LfIGsFSg/jy+OJdjZmAw4pmWvrOPYc4cqPld02HHfBlF+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5482999"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="5482999"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 09:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="2735903"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2024 09:17:02 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZDRs-0006go-0f;
	Sun, 11 Feb 2024 17:17:00 +0000
Date: Mon, 12 Feb 2024 01:16:00 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v3 35/35] include: remove lots of unnecessary
 <linux/kernel.h> includes
Message-ID: <202402120114.eFm7I6hz-lkp@intel.com>
References: <20240211123000.3359365-36-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211123000.3359365-36-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240211-204508
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211123000.3359365-36-max.kellermann%40ionos.com
patch subject: [PATCH v3 35/35] include: remove lots of unnecessary <linux/kernel.h> includes
config: arm64-randconfig-001-20240211 (https://download.01.org/0day-ci/archive/20240212/202402120114.eFm7I6hz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402120114.eFm7I6hz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402120114.eFm7I6hz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/seccomp.c:1034:2: error: call to undeclared function 'do_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           do_exit(SIGKILL);
           ^
   kernel/seccomp.c:1359:3: error: call to undeclared function 'do_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   do_exit(SIGKILL);
                   ^
   2 errors generated.


vim +/do_exit +1034 kernel/seccomp.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1016  
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1017  static void __secure_computing_strict(int this_syscall)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1018  {
fe4bfff86ec547 Kees Cook       2020-06-19  1019  	const int *allowed_syscalls = mode1_syscalls;
5b1017404aea6d Roland McGrath  2009-02-27  1020  #ifdef CONFIG_COMPAT
5c38065e021bc7 Andy Lutomirski 2016-03-22  1021  	if (in_compat_syscall())
fe4bfff86ec547 Kees Cook       2020-06-19  1022  		allowed_syscalls = get_compat_mode1_syscalls();
^1da177e4c3f41 Linus Torvalds  2005-04-16  1023  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16  1024  	do {
fe4bfff86ec547 Kees Cook       2020-06-19  1025  		if (*allowed_syscalls == this_syscall)
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1026  			return;
fe4bfff86ec547 Kees Cook       2020-06-19  1027  	} while (*++allowed_syscalls != -1);
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1028  
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1029  #ifdef SECCOMP_DEBUG
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1030  	dump_stack();
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1031  #endif
495ac3069a6235 Kees Cook       2022-02-07  1032  	current->seccomp.mode = SECCOMP_MODE_DEAD;
fd76875ca289a3 Kees Cook       2017-08-11  1033  	seccomp_log(this_syscall, SIGKILL, SECCOMP_RET_KILL_THREAD, true);
a4412fc9486ec8 Andy Lutomirski 2014-07-21 @1034  	do_exit(SIGKILL);
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1035  }
a4412fc9486ec8 Andy Lutomirski 2014-07-21  1036  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

