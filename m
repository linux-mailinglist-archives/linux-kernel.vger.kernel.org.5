Return-Path: <linux-kernel+bounces-40955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98983E8D1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F2EB21880
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0B5665;
	Sat, 27 Jan 2024 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gj31ykGz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32428468B;
	Sat, 27 Jan 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706317139; cv=none; b=qjZVtGK+1NNwDfsUFOR3+DzGeRnM02cwYUgt41nbPgsctMJDLtpFzbiHuGBE87o/YoQyqfFhqBqjyNx22MW314mT+Lwr8tjsL9G2mWmln39Np+vt7A0t0z/nd2YDFuaNyw+WcFKheyzdhGyPOOTnYJ1f+pkN8+Z1Sc2heXmIFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706317139; c=relaxed/simple;
	bh=7W44hQbjWJUDeDb618E3eurSBWCBLQAykx5uVsOx6TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njO8JGiqGJmlugre6DRKHEwU4wn/52jaL7BPzLshfcmPIBXJ3SU/r3hPsR0cmSca7E4l6p+NnOWG9MZIJX/XS3rYjyrs8bUBGlIdEz1q6ZitT+5Ytn9MuKZDAOg2HswwcUpmI0qH+bRscMbRkXNVUe5xvy68Uyuk9f1i2g6qxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gj31ykGz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706317137; x=1737853137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7W44hQbjWJUDeDb618E3eurSBWCBLQAykx5uVsOx6TY=;
  b=gj31ykGzCP/ItM1f7jsld/Uls24WP7BwUSCNIEN/xSDzGwvOiVv/Ye+S
   vmBmnTuER3q+HlGAFeiYEofO5j4r64ON1eKVdgprKIqkAt4VwjfDzSGsV
   zxhf0n/GPnXBIQ9kBV00cdmoIXTIJCyOQYRXntJoD0iee2jn2ginbI4zJ
   odAprmmTCme9NQrSC/kfMLjyJrzzzTcdBVX+lDmhxynJG1Yzgr4qZoSwt
   g0hzvWf9+dTQEKsb7MNaVeT0k2yGIx5UpyoxFA+AloVWRne0jezKgYS6Z
   fKOXLDX/CYz1Klh4pWq60stFr2a/SeUTGMIX3VgW2KZtTo3XUazw96cuY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="24080954"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24080954"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 16:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35585165"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jan 2024 16:58:51 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTX20-0001V8-2f;
	Sat, 27 Jan 2024 00:58:48 +0000
Date: Sat, 27 Jan 2024 08:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 5/8] i3c: target: add svc target controller support
Message-ID: <202401270838.wdxHPaAT-lkp@intel.com>
References: <20240123231043.3891847-6-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123231043.3891847-6-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus robh/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-target-mode-support/20240124-071453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240123231043.3891847-6-Frank.Li%40nxp.com
patch subject: [PATCH v4 5/8] i3c: target: add svc target controller support
config: i386-buildonly-randconfig-003-20240127 (https://download.01.org/0day-ci/archive/20240127/202401270838.wdxHPaAT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401270838.wdxHPaAT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270838.wdxHPaAT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/i3c/master/svc-i3c-target.c:12:0:
   include/linux/i3c/target.h: In function 'i3c_target_ctrl_alloc_request':
   include/linux/i3c/target.h:280:9: error: implicit declaration of function 'kzalloc'; did you mean 'xa_alloc'? [-Werror=implicit-function-declaration]
      req = kzalloc(sizeof(*req), gfp_flags);
            ^~~~~~~
            xa_alloc
>> include/linux/i3c/target.h:280:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      req = kzalloc(sizeof(*req), gfp_flags);
          ^
   include/linux/i3c/target.h: In function 'i3c_target_ctrl_free_request':
   include/linux/i3c/target.h:306:3: error: implicit declaration of function 'kfree'; did you mean '__free'? [-Werror=implicit-function-declaration]
      kfree(req);
      ^~~~~
      __free
   In file included from include/linux/resource_ext.h:11:0,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from include/linux/i3c/device.h:13,
                    from drivers/i3c/master/svc-i3c-target.c:24:
   include/linux/slab.h: At top level:
>> include/linux/slab.h:227:6: warning: conflicting types for 'kfree'
    void kfree(const void *objp);
         ^~~~~
   In file included from drivers/i3c/master/svc-i3c-target.c:12:0:
   include/linux/i3c/target.h:306:3: note: previous implicit declaration of 'kfree' was here
      kfree(req);
      ^~~~~
   In file included from include/linux/resource_ext.h:11:0,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from include/linux/i3c/device.h:13,
                    from drivers/i3c/master/svc-i3c-target.c:24:
>> include/linux/slab.h:709:37: error: conflicting types for 'kzalloc'
    static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
                                        ^~~~~~~
   In file included from drivers/i3c/master/svc-i3c-target.c:12:0:
   include/linux/i3c/target.h:280:9: note: previous implicit declaration of 'kzalloc' was here
      req = kzalloc(sizeof(*req), gfp_flags);
            ^~~~~~~
   cc1: some warnings being treated as errors


vim +280 include/linux/i3c/target.h

ebda81e6094f36 Frank Li 2024-01-23  264  
ebda81e6094f36 Frank Li 2024-01-23  265  /**
ebda81e6094f36 Frank Li 2024-01-23  266   * i3c_target_ctrl_alloc_request() - Alloc an I3C transfer
ebda81e6094f36 Frank Li 2024-01-23  267   * @ctrl: I3C target controller device
ebda81e6094f36 Frank Li 2024-01-23  268   * @gfp_flags: additional gfp flags used when allocating the buffers
ebda81e6094f36 Frank Li 2024-01-23  269   *
ebda81e6094f36 Frank Li 2024-01-23  270   * Returns: Zero for success, or an error code in case of failure
ebda81e6094f36 Frank Li 2024-01-23  271   */
ebda81e6094f36 Frank Li 2024-01-23  272  static inline struct i3c_request *
ebda81e6094f36 Frank Li 2024-01-23  273  i3c_target_ctrl_alloc_request(struct i3c_target_ctrl *ctrl, gfp_t gfp_flags)
ebda81e6094f36 Frank Li 2024-01-23  274  {
ebda81e6094f36 Frank Li 2024-01-23  275  	struct i3c_request *req = NULL;
ebda81e6094f36 Frank Li 2024-01-23  276  
ebda81e6094f36 Frank Li 2024-01-23  277  	if (ctrl && ctrl->ops && ctrl->ops->alloc_request)
ebda81e6094f36 Frank Li 2024-01-23  278  		req = ctrl->ops->alloc_request(ctrl, gfp_flags);
ebda81e6094f36 Frank Li 2024-01-23  279  	else
ebda81e6094f36 Frank Li 2024-01-23 @280  		req = kzalloc(sizeof(*req), gfp_flags);
ebda81e6094f36 Frank Li 2024-01-23  281  
ebda81e6094f36 Frank Li 2024-01-23  282  	if (req)
ebda81e6094f36 Frank Li 2024-01-23  283  		req->ctrl = ctrl;
ebda81e6094f36 Frank Li 2024-01-23  284  
ebda81e6094f36 Frank Li 2024-01-23  285  	return req;
ebda81e6094f36 Frank Li 2024-01-23  286  }
ebda81e6094f36 Frank Li 2024-01-23  287  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

