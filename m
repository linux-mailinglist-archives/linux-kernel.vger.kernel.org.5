Return-Path: <linux-kernel+bounces-38397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A161C83BEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DF9B29509
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E261CAB8;
	Thu, 25 Jan 2024 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW2YDOx+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710D1CAA5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178816; cv=none; b=DUDMvpdyLQW2wWQZa8ST0vnfwWr5On0chUW5ojjozAB3jMkcV3xqhX6kYJcSAF4sMXA3eNd8SlwNBlw5J+NgFfb6968+yzjUcB4Y0luF2OeiHjKqAkClPl6y/CKJ2BpAbsvYpr+APJUmRfY71io0wrLP4m+ot0N4S21sLWt0bgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178816; c=relaxed/simple;
	bh=g48t549HCnhx6cd9qj2p1n8VJWFKnnXsnpS6xM0HJDM=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IUz6+qb6/WPhaTyF81vTECmqmbOtaF3AS15M03mdPNDOuZH1ClzhS+Fa1lb6xceXVR4s1k7SCMPCUJxVx8N+f5wbkWsTMdR4+9D1mm/fIsaQYJkLNK68LDkU/WXSCgYmlerjvz5QvDAZ1n8B3qrYhC/9Y+ZZYdsg+KBmRIr6zfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW2YDOx+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706178814; x=1737714814;
  h=date:from:cc:subject:message-id:mime-version;
  bh=g48t549HCnhx6cd9qj2p1n8VJWFKnnXsnpS6xM0HJDM=;
  b=NW2YDOx+LUx9lGTKeD4oEKGQ2Kk0FxowJSwFUjRsfRrN23RkFo8IHqNB
   clDhNuP0hOyc3AS2XAaZ3N9ZnaHContQTe9us+6JB0p96RPAcuK5LpT4d
   SDTpsD9mI1u6zBLPO3hpxy2mGHJ+AGTGJObpvTS2xo6xGhUwlTuYKW/Ow
   PL91RYTLawCnrL3yNZYJ2KN6xqfbY+TQYMJp7QyaoTvxHMofPpLUfF0rG
   hWaKEhWy3hfQZiMy2pQMVRtvtGa9vIpxpwp/cc5hPpD7Zs6gkqyacYItk
   2/7JgkXNE7XWI1chpBtq0gsAsyVArocX4S10L2dSgI0uYSFuz78yggfdA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8779958"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8779958"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 02:33:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909954008"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909954008"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2024 02:33:32 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSx34-0008uf-1X;
	Thu, 25 Jan 2024 10:33:30 +0000
Date: Thu, 25 Jan 2024 18:32:48 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/dev_printk.h:110:2: warning: '%s' directive argument
 is null
Message-ID: <202401251824.Vie9Sa4X-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: af628aae8640c268938a0c9344b4ec0d102c0a0a device.h: move dev_printk()-like functions to dev_printk.h
date:   4 years, 1 month ago
config: x86_64-randconfig-012-20240106 (https://download.01.org/0day-ci/archive/20240125/202401251824.Vie9Sa4X-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401251824.Vie9Sa4X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401251824.Vie9Sa4X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/mouse/synaptics.c: In function 'synaptics_process_packet':
   drivers/input/mouse/synaptics.c:1103:6: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1103 |      ;   /* Nothing, treat a pen as a single finger */
         |      ^
   In file included from include/linux/device.h:15,
                    from include/linux/input.h:19,
                    from include/linux/input/mt.h:11,
                    from drivers/input/mouse/synaptics.c:26:
   drivers/input/mouse/synaptics.c: In function 'synaptics_init_ps2':
>> include/linux/dev_printk.h:110:2: warning: '%s' directive argument is null [-Wformat-overflow=]
     110 |  _dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/mouse/psmouse.h:202:2: note: in expansion of macro 'dev_info'
     202 |  dev_info(&(psmouse)->ps2dev.serio->dev,  \
         |  ^~~~~~~~
   drivers/input/mouse/synaptics.c:1628:3: note: in expansion of macro 'psmouse_info'
    1628 |   psmouse_info(psmouse,
         |   ^~~~~~~~~~~~


vim +110 include/linux/dev_printk.h

    91	
    92	/*
    93	 * #defines for all the dev_<level> macros to prefix with whatever
    94	 * possible use of #define dev_fmt(fmt) ...
    95	 */
    96	
    97	#define dev_emerg(dev, fmt, ...)					\
    98		_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
    99	#define dev_crit(dev, fmt, ...)						\
   100		_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
   101	#define dev_alert(dev, fmt, ...)					\
   102		_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
   103	#define dev_err(dev, fmt, ...)						\
   104		_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
   105	#define dev_warn(dev, fmt, ...)						\
   106		_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
   107	#define dev_notice(dev, fmt, ...)					\
   108		_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
   109	#define dev_info(dev, fmt, ...)						\
 > 110		_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
   111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

