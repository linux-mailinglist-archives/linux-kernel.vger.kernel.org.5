Return-Path: <linux-kernel+bounces-61237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD80850F84
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CBE281B70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7210796;
	Mon, 12 Feb 2024 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZNB1GYn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE45244
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729343; cv=none; b=BBAswYZ4XJ1zkAM1tK6paWYHRC8e1RLc6uHZFqh/R5yvfr4ddcT5hQzdJPV7gb1Y31r9mP3nIUPDfuRYVpJ5EUWlZsOSFDSechAgfQ23/Nk9rfYYNoIYoayQD7rJKIdgCUsKAZSI+q0FLcfm3CKXCJ0IsUb9tzyXxQrbY/svTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729343; c=relaxed/simple;
	bh=9I+IIux1dmdOum7JKLr/HdkGzJKPDj/8SR5f+urjR98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQRD3YgxQwFl7Z6vkVM0+/z+B9U4ChDCLktw25LJWTAmfzCHErZDQJP9lRdtbwduSgBorniYrHN6g5/6W7T6g+uEVLQJ+ZSkbKC5/9Ek1ZnU3kvIrUttU7ycf7z2R4qpVHEma7pKx503WppCjvgTLuzyLnjgLod/bKZwcx4UAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZNB1GYn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707729341; x=1739265341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9I+IIux1dmdOum7JKLr/HdkGzJKPDj/8SR5f+urjR98=;
  b=SZNB1GYn7qT27ybgC1fJ5qY3bZKgc2vnRbnJRHPgYFLfgAysSDaXscLZ
   rsPjwm3SBsOW7VApc7Fz4WxLXbdiB3Co3vkKQ799nRfG8aQHR/Qp2mk4h
   b7Jwy0wJ/0P0KApxDvaDUj+g6phXNfhjmjBXQlOKVCENIlMvCki0hAA5p
   oYzQCNov7ruQdu4Y3TC0JxUCkXPj4UPp8+dPKIb6O/dZOBf7yEO/antMa
   VoaV2p1tBkGXu+5TAEkXAdl0S+O62SKpQw76qkB5bBjpJ9vEn8w4KlgCK
   shaeFE0aM4y+ILt2xXU//4QIVxS/eOMa94TbOzKhfee0ZJgPp2J62D0Mm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5511045"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="5511045"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:15:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="7197027"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 01:15:38 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZSPX-000734-3A;
	Mon, 12 Feb 2024 09:15:35 +0000
Date: Mon, 12 Feb 2024 17:15:12 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v4 02/35] include: remove unnecessary #include directives
Message-ID: <202402121640.L0Pwfx8v-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240212-072756
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240211231518.349442-3-max.kellermann%40ionos.com
patch subject: [PATCH v4 02/35] include: remove unnecessary #include directives
config: powerpc-mpc834x_itxgp_defconfig (https://download.01.org/0day-ci/archive/20240212/202402121640.L0Pwfx8v-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240212/202402121640.L0Pwfx8v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402121640.L0Pwfx8v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/platforms/83xx/misc.c:79:7: error: implicit declaration of function 'of_find_compatible_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
                ^
>> arch/powerpc/platforms/83xx/misc.c:79:5: warning: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
           np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/83xx/misc.c:81:8: error: implicit declaration of function 'of_find_node_by_type' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   np = of_find_node_by_type(NULL, "ipic");
                        ^
   arch/powerpc/platforms/83xx/misc.c:81:6: warning: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
                   np = of_find_node_by_type(NULL, "ipic");
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/platforms/83xx/misc.c:87:2: error: implicit declaration of function 'of_node_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           of_node_put(np);
           ^
   arch/powerpc/platforms/83xx/misc.c:117:2: error: implicit declaration of function 'for_each_compatible_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
           ^
   arch/powerpc/platforms/83xx/misc.c:117:56: error: expected ';' after expression
           for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
                                                                 ^
                                                                 ;
   arch/powerpc/platforms/83xx/misc.c:119:57: error: expected ';' after expression
           for_each_compatible_node(np, "pci", "fsl,mpc8314-pcie")
                                                                  ^
                                                                  ;
   2 warnings and 6 errors generated.


vim +79 arch/powerpc/platforms/83xx/misc.c

d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  73  
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  74  void __init mpc83xx_ipic_init_IRQ(void)
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  75  {
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  76  	struct device_node *np;
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  77  
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  78  	/* looking for fsl,pq2pro-pic which is asl compatible with fsl,ipic */
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22 @79  	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  80  	if (!np)
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  81  		np = of_find_node_by_type(NULL, "ipic");
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  82  	if (!np)
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  83  		return;
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  84  
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  85  	ipic_init(np, 0);
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  86  
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  87  	of_node_put(np);
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  88  
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  89  	/* Initialize the default interrupt mapping priorities,
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  90  	 * in case the boot rom changed something on us.
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  91  	 */
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  92  	ipic_set_default_priority();
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  93  }
d4fb5ebd83c704 Dmitry Baryshkov 2011-07-22  94  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

