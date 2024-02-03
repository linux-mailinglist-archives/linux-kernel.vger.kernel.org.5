Return-Path: <linux-kernel+bounces-50794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835FA847DF3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8C5B2982A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7851880A;
	Sat,  3 Feb 2024 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj/5n6Qp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0D626
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920942; cv=none; b=Uy+Gqpd0qWyKn6oJitHA9cXZ2B+ASYdkvClaT3yteFNFXovUB6scZxYlRh9mxcITElyZ83Qxw8BngnVPRUcK4UacZZibHXEcgzboNuLzHbhvAmejQZBDNTDW6wkj2MVYOEqyKpgN21w34vPdPJhpGOHJwgVJL49FhHtxLSZXyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920942; c=relaxed/simple;
	bh=ssCnG9xaRdN/ZI5sWJHTsltoE07TElOIcIe3kWg205Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5JHnCZD9TmKM8DjHRK49jKfuqA2FoayCO4pQyiWSavxLxApEQpwsMYyZgK70QyXCUZlKLXEqNF9xQGm+lmiKhJhLBjtyTc0T3vY5bp59X7R/OM3QK/2fRmRThna2U0jSC2wo1XNpUla3Kqr6cOSvgfbmYZz+/u1/+o8jGAwkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj/5n6Qp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706920941; x=1738456941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ssCnG9xaRdN/ZI5sWJHTsltoE07TElOIcIe3kWg205Y=;
  b=cj/5n6QpLdwdohC+ArsWsJd+B1GrVjS4HrNPNeuE5Ptjkpqy2vhTyJ6N
   rp+JD4NEgsK99i4UxdZag6u4R9p5JA8Qi8U/HaEEkxB5m+VwIcrlaeL6G
   aKl9l0UbRMaF6z3uOmUGlJ76xVYAdH6xRcgP4vnB3tIlDE094h9IFe+8w
   f2u4oL+6xEsFjZ56y+7fvLt/qUPq7UVHKoxnO3P+bwi/Y0Na02wy5VWiO
   0ECYxMF4zblyWEx5wS0TKVII7XboJSeLslKFu2kls635DB+vyFYIIIonE
   h3lcGNeH5Uys2fPWoN7SFWgVMrJzRM+rCaRkTsIPosHG2q1GsUEKUcAgS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="430428"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="430428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 16:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="23485788"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Feb 2024 16:42:19 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW46r-0004TM-0L;
	Sat, 03 Feb 2024 00:42:17 +0000
Date: Sat, 3 Feb 2024 08:41:11 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH 10/28] uprobes.h: move declarations to uprobes_types.h
Message-ID: <202402030843.CUng9PM7-lkp@intel.com>
References: <20240131145008.1345531-11-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131145008.1345531-11-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240131]
[cannot apply to mkp-scsi/for-next jejb-scsi/for-next axboe-block/for-next linus/master v6.8-rc2 v6.8-rc1 v6.7 v6.8-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240131-231042
base:   next-20240131
patch link:    https://lore.kernel.org/r/20240131145008.1345531-11-max.kellermann%40ionos.com
patch subject: [PATCH 10/28] uprobes.h: move declarations to uprobes_types.h
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240203/202402030843.CUng9PM7-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030843.CUng9PM7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030843.CUng9PM7-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/csky/kernel/signal.c: In function 'do_notify_resume':
>> arch/csky/kernel/signal.c:259:17: error: implicit declaration of function 'uprobe_notify_resume'; did you mean 'do_notify_resume'? [-Werror=implicit-function-declaration]
     259 |                 uprobe_notify_resume(regs);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 do_notify_resume
   cc1: some warnings being treated as errors


vim +259 arch/csky/kernel/signal.c

e9564df753fd54 Guo Ren 2018-09-05  250  
e9564df753fd54 Guo Ren 2018-09-05  251  /*
bf241682936293 Guo Ren 2019-04-01  252   * notification of userspace execution resumption
bf241682936293 Guo Ren 2019-04-01  253   * - triggered by the _TIF_WORK_MASK flags
e9564df753fd54 Guo Ren 2018-09-05  254   */
bf241682936293 Guo Ren 2019-04-01  255  asmlinkage void do_notify_resume(struct pt_regs *regs,
bf241682936293 Guo Ren 2019-04-01  256  	unsigned long thread_info_flags)
e9564df753fd54 Guo Ren 2018-09-05  257  {
8f6bb793b2be82 Guo Ren 2020-04-02  258  	if (thread_info_flags & _TIF_UPROBE)
8f6bb793b2be82 Guo Ren 2020-04-02 @259  		uprobe_notify_resume(regs);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

