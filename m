Return-Path: <linux-kernel+bounces-60450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86580850519
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E441F22112
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8DF5C5EB;
	Sat, 10 Feb 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdfvjyyn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C120B29;
	Sat, 10 Feb 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582092; cv=none; b=GFrCLC9YOkCjgIbG/YUjxcxoQJggrpB9Ngbd1kecg0G5BRmFVnTILsJgr/iyfaayQDnjtHGWcLuxd5dj4GgeXoYB5xWXJVzDcwPRGQNmbwDvWRvJSVNTdAQfpoK2ECdgwIdmNCoK5ou4H1QefhWMtD+bwdlsSNOewYVhCl5eTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582092; c=relaxed/simple;
	bh=V4SnHdVAWVg3aYiEAXPT2kWJeUZCj+ptmkgqgpD3gZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9Mn9fUmicyDKVfirVIGo+w+z/+4EJuZrOxIB5WFpyHvA8eaNm2jIlXtUvc1mFoLplFuE+U9MQI5p1plaNHyY2TUlQ1yUsqgDXP+s7HEBB4n3WMpjVnxV0nQ6GScuyYvYgelMvuIGlrly52jKGPsaMIo9HA76rkB2d/JRZI1ZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdfvjyyn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707582090; x=1739118090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V4SnHdVAWVg3aYiEAXPT2kWJeUZCj+ptmkgqgpD3gZo=;
  b=bdfvjyynOfm3YjnAtonimf52Pnshne6Tx/72d68GN/RifD/4LibTpL7p
   PKl4yCqNB3miiMRFq7XjgnjIeEeQZFAyBWdNUG5UfDBocmaZOFJLBbtyi
   U5YM7oMEwu1VYoHhAxeH8qmTbMXv+rpqOCAouuIsljt20AwoLBlWxTi70
   wRwlDdEvH91bjJtwPydZI0fMVxZ1ZsL26U9KlEAEDA8p4F/tqPBlTQSqC
   JqIIPvi1IHxDFCiOUCAgU2dRLIVuDZpq1wqJ7Btx3mPhsFV3ULbYgNHLb
   9a7i7QdHrfnVCeiQLEOAzMLAMw00iQ9dJkC3MHUvMQM7Ag5Tj4S7qYkbr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1466361"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1466361"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 08:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6828826"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Feb 2024 08:21:26 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYq6W-0005qM-1o;
	Sat, 10 Feb 2024 16:21:24 +0000
Date: Sun, 11 Feb 2024 00:21:01 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: oe-kbuild-all@lists.linux.dev, Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v6 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <202402110028.5c27frHr-lkp@intel.com>
References: <20240208232411.316936-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208232411.316936-3-fabrizio.castro.jz@renesas.com>

Hi Fabrizio,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on geert-renesas-devel/next krzk/for-next krzk-dt/for-next linus/master v6.8-rc3 next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrizio-Castro/dt-bindings-pwm-Add-RZ-V2M-PWM-binding/20240209-074309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240208232411.316936-3-fabrizio.castro.jz%40renesas.com
patch subject: [PATCH v6 2/4] pwm: Add support for RZ/V2M PWM driver
config: mips-randconfig-r054-20240210 (https://download.01.org/0day-ci/archive/20240211/202402110028.5c27frHr-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402110028.5c27frHr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402110028.5c27frHr-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/pwm/pwm-rzv2m.o: in function `rzv2m_pwm_get_state':
>> pwm-rzv2m.c:(.text.rzv2m_pwm_get_state+0xe0): undefined reference to `__umoddi3'
>> mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_get_state+0xf8): undefined reference to `__udivdi3'
>> mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_get_state+0x15c): undefined reference to `__umoddi3'
   mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_get_state+0x174): undefined reference to `__udivdi3'
   mips-linux-ld: drivers/pwm/pwm-rzv2m.o: in function `rzv2m_pwm_config':
>> pwm-rzv2m.c:(.text.rzv2m_pwm_config+0x13c): undefined reference to `__udivdi3'
>> mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_config+0x188): undefined reference to `__udivdi3'
   mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_config+0x1e8): undefined reference to `__udivdi3'
   mips-linux-ld: pwm-rzv2m.c:(.text.rzv2m_pwm_config+0x264): undefined reference to `__udivdi3'
   mips-linux-ld: drivers/pwm/pwm-rzv2m.o:pwm-rzv2m.c:(.text.rzv2m_pwm_probe+0x208): more undefined references to `__udivdi3' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

